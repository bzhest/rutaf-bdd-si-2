package com.refinitiv.asts.test.ui.api.model.organisation.allOrganisationData;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class Organization {

    private Object country;
    private Object clientId;
    private Object city;
    private MapRefObject mapRefObject;
    private Object postalCode;
    private Object phones;
    private Object description;
    private Object addressLine;
    private Object dateUpdated;
    private Object localName;
    private Object dateCreated;
    private Boolean isDeleted;
    private Object name;
    private String id;
    private Object state;
    private Object fax;
    private Object region;

}