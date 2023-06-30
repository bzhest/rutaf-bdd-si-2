package com.refinitiv.asts.test.ui.api.model.organisation.allOrganisationData;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class CountryItem {

    private Long dateCreated;
    private Boolean isDeleted;
    private Boolean notDeletable;
    private String name;
    private String description;
    private Boolean notEditable;
    private Long dateUpdated;
    private Boolean unEditableName;
    private String uid;
    private Object code;
    private List<String> refRegions;

    @JsonProperty("_id")
    private String id;

}
