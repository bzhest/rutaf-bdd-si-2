package com.refinitiv.asts.test.ui.utils.wc1.model;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;
import java.util.Map;

@Data
@Accessors(chain = true)
public class CaseResponseDTO {

    String caseId;
    String name;
    List<String> providerTypes;
    List<Field> customFields;
    List<Field> secondaryFields;
    String groupId;
    String entityType;
    String caseSystemId;
    Map<String, String> caseScreeningState;
    String lifecycleState;
    UserSummary assignee;
    UserSummary creator;
    UserSummary modifier;
    String creationDate;
    String modificationDate;
    Boolean outstandingActions;
    Boolean nameTransposition;
    AggregatedResultSummaries aggregatedResultSummaries;

    @Data
    public static class UserSummary {

        String id;
        String fullName;
        String firstName;
        String lastName;
        String email;
        String status;
        String registrationKey;
        String userId;

    }

    @Data
    public static class Field {

        String value;
        String dateTimeValue;
        String typeId;

    }

    @Data
    public static class AggregatedResultSummaries {

        Integer totalSubCases;
        Integer totalMandatoryActions;
        ClientWatchlistCaseMatchSummariesDTO clientWatchlist;
        MediaCheckCaseMatchSummariesDTO mediaCheck;
        WatchlistCaseMatchSummariesDTO watchlist;

        @Data
        public static class ClientWatchlistCaseMatchSummariesDTO {

            int clientWatchlistTotalMatches;
            int clientWatchlistUnresolved;
            int clientWatchlistReviewRequired;

        }

        @Data
        public static class MediaCheckCaseMatchSummariesDTO {

            long mediaCheckAttachedCount;
            boolean mediaCheckReviewRequired;

        }

        @Data
        public static class WatchlistCaseMatchSummariesDTO {

            int watchlistTotalMatches;
            int watchlistUnresolved;
            int watchlistReviewRequired;
            CategorisedMatches categorisedMatches;

            @Data
            public static class CategorisedMatches {

                Map<String, Integer> watchlistUnresolvedBySubCategory;
                Map<String, Integer> watchlistReviewRequiredBySubCategory;

            }

        }

    }

}

