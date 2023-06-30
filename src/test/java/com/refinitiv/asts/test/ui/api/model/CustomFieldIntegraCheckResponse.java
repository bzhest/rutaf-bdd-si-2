package com.refinitiv.asts.test.ui.api.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class CustomFieldIntegraCheckResponse {

    Boolean purchaseOrderNumber;
    Boolean billToEntity;

}
