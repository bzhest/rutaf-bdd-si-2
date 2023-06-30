package com.refinitiv.asts.test.ui.api.model;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.refinitiv.asts.test.ui.enums.Providers;
import com.refinitiv.asts.test.ui.utils.wc1.model.ResolutionResponse;
import com.refinitiv.asts.test.ui.utils.wc1.model.ResultsResponseDTO;
import com.refinitiv.asts.test.ui.utils.wc1.model.ReviewResponseDTO;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
public class ScreeningResultResponse {

    PageInformationResponseDTO pageInformation;
    List<ProfileResponseDTO> profiles;
    Long lastScreeningDate;

    @Data
    public static class PageInformationResponseDTO {

        Integer pageNumber;
        Integer requestedPageSize;
        Integer currentPageSize;
        Integer totalPages;
        Integer totalItems;

    }

    @Data
    public static class ProfileResponseDTO {

        String resultId;
        String referenceId;
        String primaryName;
        List<ResultsResponseDTO.CountryLink> countryLinks;
        Providers providerType;
        String matchStrength;
        List<String> categories;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        ResolutionResponse resolution;
        ReviewResponseDTO resultReview;
        String creationDate;
        String modificationDate;
        boolean forReview;

        public ProfileResponseDTO(String resultId,
                String referenceId,
                String primaryName,
                List<ResultsResponseDTO.CountryLink> countryLinks,
                Providers providerType,
                String matchStrength,
                List<String> categories,
                ResolutionResponse resolution,
                ReviewResponseDTO resultReview,
                String creationDate,
                String modificationDate,
                boolean forReview) {
            this.resultId = resultId;
            this.referenceId = referenceId;
            this.primaryName = primaryName;
            this.countryLinks = countryLinks;
            this.providerType = providerType;
            this.matchStrength = matchStrength;
            this.categories = categories;
            this.resolution = resolution;
            this.resultReview = resultReview;
            this.creationDate = creationDate;
            this.modificationDate = modificationDate;
            this.forReview = forReview;
        }

    }

}
