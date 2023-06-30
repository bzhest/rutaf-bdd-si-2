package com.refinitiv.asts.test.ui.api.model.externalUser;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class MyProfileContactsRequest {

    private String clientId;
    private String objectId;
    private String objectType;

}