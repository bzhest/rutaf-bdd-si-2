package com.refinitiv.asts.test.ui.api.model.valueManagement;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class Value {

    Long dateCreated;
    Long dateUpdated;
    Boolean isDeleted;
    String _id;
    String clientId;
    String name;
    String description;
    String currencyCode;
    Boolean notEditable;
    Boolean notDeletable;
    Boolean unEditableName;
    Double min;
    Double max;
    List<Assessment> assessments;
    List<Value> listValues;

    @Data
    @Accessors(chain = true)
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Assessment {

        String name;

    }

}
