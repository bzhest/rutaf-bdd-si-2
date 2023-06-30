package com.refinitiv.asts.test.ui.testdatatypes.setUp.userRoleResponse;

import java.util.List;

import com.refinitiv.asts.test.ui.api.model.user.UserAppApiPayload;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
public class UserRoleJsonResponse {

    private List<UserAppApiPayload.UserPayload.Role> payload;
    private String message;
    private String status;

}