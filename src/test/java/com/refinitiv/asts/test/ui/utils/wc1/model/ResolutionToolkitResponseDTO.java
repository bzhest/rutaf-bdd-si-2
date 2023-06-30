package com.refinitiv.asts.test.ui.utils.wc1.model;

import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
public class ResolutionToolkitResponseDTO {

    String groupId;
    ResolutionFields resolutionFields;
    Map<String, StatusRule> resolutionRules;
    String providerType;

    @Data
    public static class ResolutionFields {

        List<ResolutionField> statuses;
        List<ResolutionField> risks;
        List<ResolutionField> reasons;

        @Data
        public static class ResolutionField {

            String id;
            String label;
            String type;

        }

    }

    @Data
    public static class StatusRule {

        List<String> reasons;
        Boolean remarkRequired;
        Boolean reasonRequired;
        List<String> risks;

    }

}
