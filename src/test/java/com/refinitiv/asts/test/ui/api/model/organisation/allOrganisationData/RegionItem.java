package com.refinitiv.asts.test.ui.api.model.organisation.allOrganisationData;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class RegionItem {

    private Object dateCreated;
    private Boolean isDeleted;
    private Boolean notDeletable;
    private String name;
    private String description;
    private Boolean notEditable;
    private Object dateUpdated;
    private Boolean unEditableName;

    @JsonProperty("_id")
    private String id;

}