package com.refinitiv.asts.test.ui.stepDefinitions.api;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.api.stepDefinitions.ApiBaseSteps;
import com.refinitiv.asts.test.ui.api.Endpoints;
import com.refinitiv.asts.test.ui.api.model.organisation.allOrganisationData.OrganizationPayload;
import com.refinitiv.asts.test.ui.api.model.user.UserAppApiPayload.UserPayload;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.api.Endpoints.ORGANISATION_GET;
import static com.refinitiv.asts.test.ui.constants.APIConstants.DATE_CREATED;
import static com.refinitiv.asts.test.ui.constants.APIConstants.DESC;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static org.assertj.core.api.Assertions.assertThat;

public class UsersApiSteps extends ApiBaseSteps {

    public UsersApiSteps(ScenarioCtxtWrapper context) {
        super(context);
    }

    @When("User deactivates users records with name prefix {string} via API")
    public void deactivateUsersViaApi(String namePrefix) {
        List<String> autoTestUsersIds = getActiveUsersFromPublicApi()
                .filter(user -> user.getFirstName().startsWith(namePrefix))
                .map(UserData::getId)
                .collect(Collectors.toList());
        if (!autoTestUsersIds.isEmpty()) {
            autoTestUsersIds.forEach(userId -> {
                UserPayload userPayload = getUserDataById(userId).getPayload();
                userPayload.setActive(false);
                updateUser(userPayload);
                logger.info("User with id " + userId + " is inactivated!");
            });
        }
    }

    @When("User deactivates users records with name reference {string} via API")
    public void deactivateUserViaApi(String nameReference) {
        Object contextValue = context.getScenarioContext().getContext(nameReference);
        String name = contextValue instanceof String ? (String) contextValue : ((UserData) contextValue).getFirstName();
        List<UserData> userList = getUsers(USERS_ITEMS_PER_PAGE, ZERO, DESC, DATE_CREATED).getPayload()
                .getData().stream()
                .filter(user -> user.getStatus().equals(ACTIVE.getStatus()) &&
                        name.equals(user.getFirstName()))
                .collect(Collectors.toList());
        UserPayload userPayload = getUserDataById(userList.get(0).getId()).getPayload();
        userPayload.setActive(false);
        updateUser(userPayload);
        logger.info("User with first name " + name + " is inactivated!");
    }

    @When("User updates user {string} Division with value {string} via API")
    public void updateUserDivisionViaApi(String nameReference, String departmentName) {
        Object contextValue = context.getScenarioContext().getContext(nameReference);
        String name = contextValue instanceof String ? (String) contextValue : ((UserData) contextValue).getFirstName();
        List<UserData> userList = getUsers(USERS_ITEMS_PER_PAGE, ZERO, DESC, DATE_CREATED).getPayload()
                .getData().stream()
                .filter(user -> user.getStatus().equals(ACTIVE.getStatus()) &&
                        name.equals(user.getFirstName()))
                .collect(Collectors.toList());
        UserPayload userPayload = getUserDataById(userList.get(0).getId()).getPayload();
        List<OrganizationPayload.ObjectsItem> myOrganizationFullDetails =
                getMyOrganizationFullDetails(Endpoints.DIVISION + ORGANISATION_GET);
        OrganizationPayload.ObjectsItem objectsItem = myOrganizationFullDetails.stream()
                .filter(department -> department.getActive() && department.getName().equals(departmentName))
                .findFirst().orElse(new OrganizationPayload.ObjectsItem());
        userPayload.setDivisions(List.of(objectsItem));
        updateUser(userPayload);
        logger.info("User with first name " + name + " is updated!");
    }

    @Then("Users records with name prefix {string} are deactivated")
    public void usersRecordsWithNamePrefixAreNotFound(String namePrefix) {
        List<String> usersList = getActiveUsersFromPublicApi()
                .filter(user -> user.getFirstName().startsWith(namePrefix))
                .map(UserData::getName)
                .collect(Collectors.toList());
        assertThat(usersList)
                .as("Following users are not deactivated:")
                .isNullOrEmpty();
    }

}
