package com.refinitiv.asts.test.ui.api.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.util.List;

@Data
public class SiPublicReferencesResponse {

    private List<Reference> data;
    private String message;

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Reference {

        private String code;
        private String createTime;
        private String description;
        private List<String> parentCodes;
        private String updateTime;
        private String parentType;
        private String groupId;
        private String groupName;
        private Boolean status;

    }

}