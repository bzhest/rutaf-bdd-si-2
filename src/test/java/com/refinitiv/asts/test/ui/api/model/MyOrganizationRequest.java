package com.refinitiv.asts.test.ui.api.model;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class MyOrganizationRequest {

    private String clientId;
    private String name;
    private String id;

}
