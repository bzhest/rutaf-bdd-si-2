package com.refinitiv.asts.test.ui.api.model.valueManagement;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.util.List;

@Data
public class RiskScoreEngineResponse {

    private List<DataItem> data;
    private String message;

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class DataItem {

        private String modelName;
        private List<RangesItem> ranges;
        private String description;
        private String id;
        private String code;
        private String createTime;
        private String updateTime;
        private String name;

        @Data
        @JsonIgnoreProperties(ignoreUnknown = true)
        public static class RangesItem {

            private Object min;
            private String dateCreated;
            private boolean deleted;
            private String color;
            private Object max;
            private String name;
            private String id;
            private String dateUpdated;

        }

    }

}