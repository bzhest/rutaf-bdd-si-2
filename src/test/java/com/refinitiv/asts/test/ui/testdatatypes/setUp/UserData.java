package com.refinitiv.asts.test.ui.testdatatypes.setUp;

import com.fasterxml.jackson.annotation.JsonAlias;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.util.Map;

import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.enums.Status.INACTIVE;
import static java.util.Objects.nonNull;

@Data
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
@Builder
public class UserData {

    public String password;
    public String name;
    @JsonAlias({"firstname", "firstName"})
    public String firstName;
    @JsonAlias({"lastname", "lastName"})
    public String lastName;
    public String username;
    public String organisation;
    @JsonAlias({"userType.name", "userType"})
    public String userType;
    public String role;
    public String status;
    public String singleSignOn;
    public Entity entity;
    @JsonIgnore
    public String email;
    @JsonIgnore
    public String position;
    @JsonIgnore
    public String group;
    @JsonIgnore
    public String superior;
    @JsonIgnore
    public String externalOrganisation;
    @JsonIgnore
    public String department;
    public String division;
    public String id;
    @JsonIgnore
    public String thirdParty;
    @JsonIgnore
    public String defaultBillingEntity;
    @JsonIgnore
    public String otherBillingEntity;

    @JsonProperty("organization")
    private void setOrganisationName(Object organizationObject) {
        if (organizationObject instanceof Map) {
            organisation = (String) ((Map<?, ?>) organizationObject).get("name");
        } else if (nonNull(organizationObject)) {
            organisation = (String) organizationObject;
        }
    }

    @JsonProperty("userType")
    private void setUserTypeName(Object userTypeObject) {
        if (userTypeObject instanceof Map) {
            userType = (String) ((Map<?, ?>) userTypeObject).get("name");
        } else if (nonNull(userTypeObject)) {
            userType = (String) userTypeObject;
        }
    }

    @JsonProperty("role")
    private void setRoleName(Object roleObject) {
        if (roleObject instanceof Map) {
            role = (String) ((Map<?, ?>) roleObject).get("name");
        } else if (nonNull(roleObject)) {
            role = (String) roleObject;
        }
    }

    @JsonProperty("username")
    private void setUsernameFromResponse(String usernameResponse) {
        if (nonNull(usernameResponse) && !usernameResponse.isEmpty()) {
            username = usernameResponse;
        }
    }

    @JsonProperty("active")
    private void setStatusFromResponse(boolean isActive) {
        status = isActive ? ACTIVE.getStatus() : INACTIVE.getStatus();
    }

    @JsonProperty("isSingleSignOnEnabled")
    private void setSingleSignOnFromResponse(boolean isSingleSignOnEnabled) {
        singleSignOn = isSingleSignOnEnabled ? "Yes" : "No";
    }

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Entity {

        String id;
        String clientId;
        String name;

    }

}
