package com.refinitiv.asts.test.ui.stepDefinitions.api;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.api.stepDefinitions.ApiBaseSteps;
import com.refinitiv.asts.test.ui.api.AppApi;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserRoleData;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.testng.SkipException;

import java.util.List;
import java.util.stream.Collectors;

import static java.lang.String.format;
import static org.assertj.core.api.Assertions.assertThat;

public class RolesApiSteps extends ApiBaseSteps {

    public RolesApiSteps(ScenarioCtxtWrapper context) {
        super(context);
    }

    @When("User cleans up Roles with name prefix {string} via API")
    public void cleanUpRolesWithPrefix(String prefix) {
        List<String> roles = AppApi.getAllRoles().getPayload().stream()
                .map(UserRoleData::getName)
                .filter(role -> role.startsWith(prefix))
                .collect(Collectors.toList());
        if (roles.isEmpty()) {
            throw new SkipException(format("\"%s\" roles are already cleaned from environment!", prefix));
        }
        roles.forEach(AppApi::deleteRole);
    }

    @Then("Roles with name prefix {string} are not found")
    public void rolesWithPrefixAreNotFound(String prefix) {
        List<String> roles = AppApi.getAllRoles().getPayload().stream()
                .map(UserRoleData::getName)
                .filter(role -> role.startsWith(prefix))
                .collect(Collectors.toList());
        assertThat(roles).as("Roles with prefix %s are found", prefix).isNullOrEmpty();
    }

}
