package com.refinitiv.asts.test.ui.api.model.organisation.allOrganisationData;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class AllOrganizationDataByIdResponse {

    private OrganizationPayload payload;
    private String message;
    private String status;

}