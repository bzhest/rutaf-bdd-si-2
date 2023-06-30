package com.refinitiv.asts.test.ui.api.model.userRole;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserRoleData;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
public class UserRoleResponse {

    @JsonProperty("payload")
    private List<UserRoleData> payload;

    @JsonProperty("message")
    private String message;

    @JsonProperty("status")
    private String status;

}