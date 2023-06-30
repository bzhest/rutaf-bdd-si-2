package com.refinitiv.asts.test.ui.utils.wc1;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import com.refinitiv.asts.test.ui.api.model.ScreeningResultResponse;
import com.refinitiv.asts.test.ui.enums.Providers;
import com.refinitiv.asts.test.ui.utils.wc1.model.ResolutionResponse;
import com.refinitiv.asts.test.ui.utils.wc1.model.ResultsResponseDTO;
import com.refinitiv.asts.test.ui.utils.wc1.model.ReviewResponseDTO;
import lombok.SneakyThrows;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static com.refinitiv.asts.test.ui.utils.PaginationUtil.getCurrentPageSize;
import static com.refinitiv.asts.test.ui.utils.PaginationUtil.getTotalPages;
import static com.refinitiv.asts.test.ui.utils.wc1.ScreeningResultExpectedDataBuilder.getResultsForCurrentPage;

public class ScreeningResponseDataTransfer {

    @SneakyThrows
    public static DocumentContext getExpectedScreeningOutput(int pageNo, int pageSize, String systemCaseId,
            Providers provider) {
        List<ResultsResponseDTO> screeningResultsList =
                ScreeningResultExpectedDataBuilder.getCaseProfilesResult(systemCaseId, provider);
        List<ResultsResponseDTO> currentPageResults = getResultsForCurrentPage(screeningResultsList, pageNo, pageSize);
        ScreeningResultResponse expectedScreeningResponse = new ScreeningResultResponse()
                .setPageInformation(getPageInformationResponse(screeningResultsList.size(), pageSize, pageNo))
                .setProfiles(getScreeningProfiles(currentPageResults));
        ObjectMapper mapper = new ObjectMapper();
        return JsonPath.parse(mapper.writeValueAsString(expectedScreeningResponse));
    }

    private static ScreeningResultResponse.PageInformationResponseDTO getPageInformationResponse(int totalItems,
            int pageSize, int pageNo) {
        return new ScreeningResultResponse.PageInformationResponseDTO()
                .setPageNumber(pageNo)
                .setRequestedPageSize(pageSize)
                .setCurrentPageSize(getCurrentPageSize(totalItems, pageSize, pageNo))
                .setTotalItems(totalItems)
                .setTotalPages(getTotalPages(totalItems, pageSize));
    }

    private static List<ScreeningResultResponse.ProfileResponseDTO> getScreeningProfiles(
            List<ResultsResponseDTO> currentPageResults) {
        return currentPageResults.stream()
                .map(wc1Result ->
                             new ScreeningResultResponse.ProfileResponseDTO(
                                     wc1Result.getResultId(),
                                     wc1Result.getReferenceId(),
                                     wc1Result.getPrimaryName(),
                                     wc1Result.getCountryLinks(),
                                     wc1Result.getProviderType(),
                                     wc1Result.getMatchStrength(),
                                     wc1Result.getCategories(),
                                     getResolution(wc1Result),
                                     new ReviewResponseDTO().setReviewRequired(wc1Result
                                                                                       .getResultReview()
                                                                                       .getReviewRequired()),
                                     updateDateFormat(API_DATE_FORMAT, SI_CONNECT_DATE_FORMAT,
                                                      wc1Result.getCreationDate()),
                                     updateDateFormat(API_DATE_FORMAT, SI_CONNECT_DATE_FORMAT,
                                                      wc1Result.getModificationDate()),
                                     false
                             )

                ).collect(Collectors.toList());
    }

    private static ResolutionResponse getResolution(ResultsResponseDTO wc1Result) {
        return Objects.nonNull(wc1Result.getResolution()) ? wc1Result.getResolution()
                .setResolutionDate(updateDateFormat(API_DATE_FORMAT, SI_CONNECT_DATE_FORMAT,
                                                    wc1Result.getResolution().getResolutionDate()))
                : null;
    }

}
