package com.refinitiv.asts.test.ui.utils;

import com.google.common.base.CharMatcher;
import com.google.gson.Gson;
import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.ui.enums.ContactScreeningTableColumns;
import com.refinitiv.asts.test.ui.enums.CountryType;
import com.refinitiv.asts.test.ui.enums.Providers;
import com.refinitiv.asts.test.ui.enums.ScreeningTableColumns;
import com.refinitiv.asts.test.ui.api.model.ScreeningResultResponse;
import com.refinitiv.asts.test.ui.utils.wc1.model.ResolutionResponse;
import com.refinitiv.asts.test.ui.utils.wc1.model.ResolutionToolkitResponseDTO;
import com.refinitiv.asts.test.ui.utils.wc1.model.ResultsResponseDTO;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.lang.invoke.MethodHandles;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.CountryType.LOCATION;
import static com.refinitiv.asts.test.ui.enums.CountryType.REGISTEREDIN;
import static com.refinitiv.asts.test.ui.enums.Providers.WATCHLIST;
import static com.refinitiv.asts.test.ui.enums.Resolution.UNRESOLVED;
import static com.refinitiv.asts.test.ui.utils.wc1.WCOApiResponseExtractor.getResolutionToolkitResponse;
import static java.lang.String.join;
import static java.util.Objects.isNull;

public class ScreeningCSVReportBuilder {

    protected static final Logger logger = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());
    private static final String jsonFilePath = "src/test/resources/testdata/api/resolution.json";
    private static ResolutionToolkitResponseDTO resolutionToolkitResponse;

    public static String getSupplierContactReport(String response) {
        return buildReportFromScreeningResponse(ContactScreeningTableColumns.getColumnNames(), LOCATION, response);
    }

    public static String getSupplierReport(String response) {
        return buildReportFromScreeningResponse(ScreeningTableColumns.getColumnNames(), REGISTEREDIN, response);
    }

    public static String buildReportFromScreeningResponse(List<String> header, CountryType countryType,
            String response) {
        ScreeningResultResponse screeningResult = new Gson().fromJson(response, ScreeningResultResponse.class);
        StringBuilder report = new StringBuilder().append(join(COMMA, header));
        for (ScreeningResultResponse.ProfileResponseDTO result : screeningResult.getProfiles()) {
            report.append(ROW_DELIMITER).append(buildReportRow(result, countryType));
        }
        return report.toString();
    }

    public static String buildReportRow(ScreeningResultResponse.ProfileResponseDTO result, CountryType countryType) {
        String[] fieldsList = {getStringValue(result.getPrimaryName()),
                getCountryValue(result.getCountryLinks(), countryType),
                getListValue(result.getCategories()).replace("PEP", "Politically Exposed Person"),
                result.getMatchStrength(),
                result.getProviderType().getProvider(),
                getReferenceIdWithoutPrefix(result.getProviderType(), result.getReferenceId()),
                getResolutionStatus(result.getResolution(), result.getProviderType())};
        return join(COMMA, fieldsList);
    }

    public static String getResolutionStatus(ResolutionResponse resolution, Providers provider) {
        if (Objects.nonNull(resolution)) {
            ResolutionToolkitResponseDTO.ResolutionFields.ResolutionField resolutionStatus = null;
            int count = 0;
            int maxTries = 3;
            while (isNull(resolutionStatus) && count++ <= maxTries) {
                if (isNull(resolutionToolkitResponse)) {
                    resolutionToolkitResponse =
                            getResolutionToolkitResponse(Config.get().value("wc1.group.id"), provider);
                }
                logger.info("Current Resolution: " + resolution);
                logger.info("All resolution Fields Status IDs " +
                                    resolutionToolkitResponse.getResolutionFields().getStatuses());
                resolutionStatus = resolutionToolkitResponse.getResolutionFields().getStatuses().stream()
                        .filter(status -> {
                            logger.info("Status ID " + status.getId());
                            return status.getId().equals(resolution.getStatusId());
                        }).findFirst().orElse(null);
            }
            if (isNull(resolutionStatus)) {
                throw new RuntimeException("Unexpected status ID");
            } else {
                return resolutionStatus.getLabel();
            }
        } else {
            return UNRESOLVED.toString();
        }
    }

    public static String getCountryValue(List<ResultsResponseDTO.CountryLink> countryList,
            CountryType countryType) {

        return getListValue(getCountriesListByType(countryList, countryType));
    }

    private static String getReferenceIdWithoutPrefix(Providers provider, String referenceId) {
        return provider.equals(WATCHLIST) ? referenceId.replaceAll(ID_REGEX, StringUtils.EMPTY) : referenceId;
    }

    private static String getListValue(List<String> categories) {
        if (categories.isEmpty()) {
            return StringUtils.EMPTY;
        }
        List<String> distinctList = categories.stream().distinct()
                .collect(Collectors.toList());
        if (distinctList.size() == 1) {
            return getStringValue(distinctList.get(0));
        } else {
            return DOUBLE_QUOTES + join(COMMA, distinctList) + DOUBLE_QUOTES;
        }
    }

    private static String getStringValue(String name) {
        CharMatcher chars = CharMatcher.anyOf(",'");
        return chars.matchesAnyOf(name) ? DOUBLE_QUOTES + name + DOUBLE_QUOTES : name;
    }

    public static List<String> getCountriesListByType(List<ResultsResponseDTO.CountryLink> countryList,
            CountryType countryType) {
        return countryList.stream()
                .filter(countryLink -> countryLink.getType().equals(countryType))
                .map(countryLink1 -> countryLink1.getCountry().getName())
                .collect(Collectors.toList());
    }

}
