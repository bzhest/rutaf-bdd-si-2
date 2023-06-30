package com.refinitiv.asts.test.ui.api.model.organisation.clientOrganisation;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class Object {

    private String uid;
    private Object dateCreated;
    private Object code;
    private Boolean isDeleted;
    private Boolean notDeletable;
    private String name;
    private String description;
    private String id;
    private Boolean notEditable;
    private List<String> refRegions;
    private Object dateUpdated;
    private Boolean unEditableName;

}