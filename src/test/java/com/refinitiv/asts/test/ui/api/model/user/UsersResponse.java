package com.refinitiv.asts.test.ui.api.model.user;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import lombok.Data;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class UsersResponse {

    private UserPayload payload;
    private String message;
    private String status;

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class UserPayload {

        List<UserData> data;
        int count;
        int limit;
        int skip;

    }

}
