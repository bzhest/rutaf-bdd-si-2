package com.refinitiv.asts.test.ui.api.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class RenewalSettingsUserDetailsRequest {

    private String[] fields;
    private Object filter;

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Filter {

        private boolean isActive;
        private String userType_Name;

    }

}
