package com.refinitiv.asts.test.ui.api.model.user;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class UserRetrieveRequest {

    private String id;

}
