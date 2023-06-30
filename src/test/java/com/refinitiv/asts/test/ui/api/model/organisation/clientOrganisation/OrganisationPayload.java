package com.refinitiv.asts.test.ui.api.model.organisation.clientOrganisation;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class OrganisationPayload {

    private Country country;
    private String clientId;
    private String city;
    private MapRefObject mapRefObject;
    private String postalCode;
    private List<String> phones;
    private String description;
    private String addressLine;
    private Object dateUpdated;
    private String localName;
    private Object dateCreated;
    private Boolean isDeleted;
    private String name;
    private String id;
    private String state;
    private String fax;
    private Region region;

}