package com.refinitiv.asts.test.ui.api.model.organisation.allOrganisationData;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class Country {

    @JsonProperty("_id")
    private String id;

    private CountryItem object;

}