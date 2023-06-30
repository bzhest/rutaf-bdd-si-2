package com.refinitiv.asts.test.ui.api.model;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class SupplierInformationRequest {

    String clientId;
    String objectId;
    String objectType;

}

