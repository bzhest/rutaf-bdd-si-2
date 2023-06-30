package com.refinitiv.asts.test.ui.api.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class UserManagementGroup {

    private String name;
    private String description;
    private String status;
    private List<Users> users;

    @Data
    public static class Users {

        private String email;
        private String firstName;
        private String lastName;
        private String name;

    }

}
