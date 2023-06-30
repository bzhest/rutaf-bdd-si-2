package com.refinitiv.asts.test.ui.api.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class RegionCountryRequest {

    private String _id;
    private RegionObject object;

    @Data
    @Accessors(chain = true)
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class RegionObject {

        private boolean isDeleted;
        private boolean notEditable;
        private boolean notDeletable;
        private boolean unEditableName;
        private String _id;
        private String name;
        private String description;

    }

}