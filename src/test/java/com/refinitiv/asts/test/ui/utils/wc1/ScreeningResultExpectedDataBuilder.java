package com.refinitiv.asts.test.ui.utils.wc1;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.AppApi;
import com.refinitiv.asts.test.ui.api.ConnectApi;
import com.refinitiv.asts.test.ui.enums.*;
import com.refinitiv.asts.test.ui.utils.wc1.model.CaseResponseDTO;
import com.refinitiv.asts.test.ui.utils.wc1.model.ResultsResponseDTO;
import org.apache.commons.lang3.StringUtils;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static com.refinitiv.asts.test.ui.api.AppApi.getContactOtherNameSearchId;
import static com.refinitiv.asts.test.ui.api.ConnectApi.getOtherNameSearchId;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.ID_REGEX;
import static com.refinitiv.asts.test.ui.constants.TestConstants.NOT_UPPER_CASE_REGEX;
import static com.refinitiv.asts.test.ui.enums.Resolution.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.API_DATE_FORMAT;
import static com.refinitiv.asts.test.ui.utils.DateUtil.isDateBeforeOtherDate;
import static com.refinitiv.asts.test.ui.utils.PaginationUtil.getSkipCount;
import static com.refinitiv.asts.test.ui.utils.ScreeningCSVReportBuilder.getResolutionStatus;
import static com.refinitiv.asts.test.ui.utils.wc1.WCOApiResponseExtractor.getCaseResponse;
import static com.refinitiv.asts.test.ui.utils.wc1.WCOApiResponseExtractor.getCaseResultResponse;
import static java.util.Objects.nonNull;

public class ScreeningResultExpectedDataBuilder {

    /**
     * Returns list response according pagination logic
     *
     * @param wcoScreeningResults response from WC1 API
     * @return list of results
     */
    public static List<ResultsResponseDTO> getResultsForCurrentPage(List<ResultsResponseDTO> wcoScreeningResults,
            int currentPage, int itemsPerPage) {
        return wcoScreeningResults.stream()
                .skip(getSkipCount(currentPage, itemsPerPage))
                .limit(itemsPerPage)
                .collect(Collectors.toList());
    }

    /**
     * Returns screening results from WC1 API without resolved records(Positive, Possible)
     *
     * @param context   test context
     * @param otherName test other name
     * @param pageType  supplier or contact
     * @param provider  Watchlist or Custom-Watchlist provider
     * @return full screening results
     */
    @SuppressWarnings("unchecked")
    public static List<ResultsResponseDTO> getScreeningResultsForOtherNameWithoutResolved(ScenarioCtxtWrapper context,
            String otherName, String pageType, Providers provider) {
        List<ResultsResponseDTO> caseProfilesResult =
                getScreeningResultsForOtherName(context, otherName, pageType, provider);
        List<String> resolvedRecordsIdList =
                (List<String>) context.getScenarioContext().getContext(RESOLVED_RECORDS_ID_LIST);
        if (nonNull(resolvedRecordsIdList) && !resolvedRecordsIdList.isEmpty()) {
            return caseProfilesResult.stream()
                    .filter(resultsResponseDTO -> !resolvedRecordsIdList
                            .contains(resultsResponseDTO.getReferenceId()
                                              .replaceAll(ID_REGEX, StringUtils.EMPTY)))
                    .collect(Collectors.toList());
        }
        return caseProfilesResult;
    }

    /**
     * Returns screening results from WC1 API
     *
     * @param context   test context
     * @param otherName test other name
     * @param pageType  supplier or contact
     * @param provider  Watchlist or Custom-Watchlist provider
     * @return full screening results
     */
    public static List<ResultsResponseDTO> getScreeningResultsForOtherName(ScenarioCtxtWrapper context,
            String otherName, String pageType, Providers provider) {
        String supplierId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        String contactId = (String) context.getScenarioContext().getContext(CONTACT_ID);
        String supplierOtherNameSearchId = pageType.contains("supplier") ? getOtherNameSearchId(supplierId, otherName) :
                getContactOtherNameSearchId(contactId, otherName);
        return getCaseProfilesResult(supplierOtherNameSearchId, provider);
    }

    /**
     * Returns screening results from WC1 filtered according business logic and for requested provider.
     * And sorted RMS-7442:
     * New Match
     * New
     * Update
     * Resolution:
     * - Positive
     * - Possible
     * - Unspecified
     * - Unresolved
     * - False
     * Match strength:
     * - Exact
     * - Strong
     * - Medium
     * - Fuzzy
     * Reference Id
     *
     * @param provider - WATCHLIST or CUSTOM_WATCHLIST provider
     * @return list of screening results
     */
    public static List<ResultsResponseDTO> getCaseProfilesResult(String systemCaseId, Providers provider) {
        List<ResultsResponseDTO> screeningResponse = getCaseResultResponse(systemCaseId);
        CaseResponseDTO caseResponse = getCaseResponse(systemCaseId);
        List<ResultsResponseDTO> filteredResults = filterResultsResponse(screeningResponse, caseResponse, provider);
        sortResultList(filteredResults, caseResponse);
        return filteredResults;
    }

    public static List<ResultsResponseDTO> getScreeningWithOtherNameResults(Providers provider,
            ScenarioCtxtWrapper context, String otherName, String resultsFor) {
        List<ResultsResponseDTO> fullScreeningResultsForOtherName =
                getScreeningResultsForOtherName(context, otherName, resultsFor, provider);
        List<ResultsResponseDTO> positiveResolvedResults = getPositiveResolvedResults(fullScreeningResultsForOtherName);
        String searchId = getSearchId(context, resultsFor);
        CaseResponseDTO caseResponse = getCaseResponse(searchId);
        List<ResultsResponseDTO> screeningResultsForMainTable = getCaseProfilesResult(searchId, provider);
        screeningResultsForMainTable.addAll(positiveResolvedResults);
        sortResultList(screeningResultsForMainTable, caseResponse);
        return screeningResultsForMainTable;
    }

    public static List<ResultsResponseDTO> getScreeningResults(ScenarioCtxtWrapper context,
            String resultsFor, Providers provider) {
        String searchId = getSearchId(context, resultsFor);
        return getCaseProfilesResult(searchId, provider);
    }

    public static String getSearchId(ScenarioCtxtWrapper context, String resultsFor) {
        String supplierId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        if (resultsFor.contains(EntityType.CONTACT.toString().toLowerCase())) {
            String contactId = AppApi.getContactIdsList(supplierId).get(0);
            return ConnectApi.getContactSearchId(contactId);
        }
        return ConnectApi.getSupplierSearchId(supplierId);
    }

    private static List<ResultsResponseDTO> getPositiveResolvedResults(
            List<ResultsResponseDTO> fullScreeningResultsForOtherName) {
        return fullScreeningResultsForOtherName.stream()
                .filter(result -> Arrays.asList(POSITIVE, POSSIBLE)
                        .contains(Resolution.valueOf(
                                getResolutionStatus(result.getResolution(), result.getProviderType()))))
                .collect(Collectors.toList());
    }

    public static List<String> getCountriesListByType(List<ResultsResponseDTO.CountryLink> countryList,
            CountryType countryType) {
        return countryList.stream()
                .filter(countryLink -> countryLink.getType().equals(countryType))
                .map(countryLink1 -> countryLink1.getCountry().getName())
                .collect(Collectors.toList());
    }

    public static List<String> getCategoriesAbbreviation(List<String> categories) {
        return categories.stream()
                .map(category -> category.replaceAll(NOT_UPPER_CASE_REGEX, StringUtils.EMPTY))
                .distinct()
                .collect(Collectors.toList());
    }

    private static List<ResultsResponseDTO> filterResultsResponse(List<ResultsResponseDTO> screeningResponse,
            CaseResponseDTO caseResponse, Providers provider) {
        return screeningResponse.stream()
                .filter(results ->
                                (isMatchedResult(caseResponse, results)
                                        || isAutoResolvedAsFalse(caseResponse, results)
                                        || isResultPositiveResolved(results)) && isProviderResult(results, provider))
                .collect(Collectors.toList());
    }

    private static boolean isMatchedResult(CaseResponseDTO caseResponse, ResultsResponseDTO results) {
        return isSubmittedTermEqualsSearchTerm(results, caseResponse.getName())
                && isResultsMatchedMatchStrength(results);
    }

    private static boolean isResultPositiveResolved(ResultsResponseDTO results) {
        String resolutionStatus = getResolutionStatus(results.getResolution(), results.getProviderType());
        return Arrays.asList(POSITIVE.toString(), POSSIBLE.toString()).contains(resolutionStatus);
    }

    public static boolean isResultMatchSecondaryField(ResultsResponseDTO result, CaseResponseDTO caseResponse) {
        boolean isMatchedResults = true;
        if (caseResponse.getSecondaryFields().isEmpty()) {
            return true;
        }
        for (ResultsResponseDTO.CountryLink country : result.getCountryLinks()) {
            String typeId = SecondaryFieldType.valueOf(country.getType().toString()).getTypeId();
            CaseResponseDTO.Field secondaryField = caseResponse.getSecondaryFields().stream()
                    .filter(field -> field.getTypeId().equals(typeId))
                    .findFirst().orElse(null);
            if (nonNull(secondaryField) && !secondaryField.getValue().equals(country.getCountry().getCode()) &&
                    !country.getCountryText().equals("UNKNOWN")) {
                isMatchedResults = false;
            } else {
                return true;
            }

        }
        return isMatchedResults;
    }

    private static boolean isSubmittedTermEqualsSearchTerm(ResultsResponseDTO result, String searchTerm) {
        return result.getSubmittedTerm().equals(searchTerm);
    }

    private static boolean isResultsMatchedMatchStrength(ResultsResponseDTO result) {
        List<String> matchStrengthList = Stream.of(MatchStrength.values())
                .map(MatchStrength::name)
                .collect(Collectors.toList());
        return matchStrengthList.contains(result.getMatchStrength());
    }

    private static boolean isAutoResolvedAsFalse(CaseResponseDTO caseResponse, ResultsResponseDTO results) {
        return isSubmittedTermEqualsSearchTerm(results, caseResponse.getName())
                && isResultsMatchedMatchStrength(results)
                && !isResultMatchSecondaryField(results, caseResponse)
                && nonNull(results.getResolution())
                && getResolutionStatus(results.getResolution(), results.getProviderType()).equals(FALSE.toString());
    }

    private static boolean isProviderResult(ResultsResponseDTO result, Providers provider) {
        return result.getProviderType().equals(provider);
    }

    public static void sortResultList(List<ResultsResponseDTO> responseResultsList, CaseResponseDTO caseResponse) {
        responseResultsList.sort(new ScreeningResultsComparator(caseResponse));
    }

    public static boolean isResultNewMatch(ResultsResponseDTO result, CaseResponseDTO caseResponse) {
        return nonNull(result.getResultReview())
                && result.getResultReview().getReviewRequired()
                &&
                isDateBeforeOtherDate(result.getResultReview().getReviewRequiredDate(), caseResponse.getCreationDate(),
                                      API_DATE_FORMAT)
                && isDateBeforeOtherDate(result.getResultReview().getReviewRequiredDate(), result.getCreationDate(),
                                         API_DATE_FORMAT);
    }

    public static boolean isResultNew(ResultsResponseDTO result, CaseResponseDTO caseResponse) {
        return nonNull(result.getSecondaryFieldResults())
                &&
                isDateBeforeOtherDate(caseResponse.getCreationDate(), result.getResultReview().getReviewRequiredDate(),
                                      API_DATE_FORMAT)
                && (Objects.isNull(result.getResolution()));
    }

    public static boolean isResultUpdated(ResultsResponseDTO result, CaseResponseDTO caseResponse) {
        return nonNull(result.getResultReview())
                && isDateBeforeOtherDate(result.getCreationDate(), result.getModificationDate(), API_DATE_FORMAT)
                &&
                isDateBeforeOtherDate(caseResponse.getCreationDate(), result.getResultReview().getReviewRequiredDate(),
                                      API_DATE_FORMAT)
                && isDateBeforeOtherDate(result.getCreationDate(), result.getResultReview().getReviewRequiredDate(),
                                         API_DATE_FORMAT);
    }

}
