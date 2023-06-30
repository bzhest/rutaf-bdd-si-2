package com.refinitiv.asts.test.ui.api.model.organisation.clientOrganisation;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class Country {

    private String id;
    private Object object;

}