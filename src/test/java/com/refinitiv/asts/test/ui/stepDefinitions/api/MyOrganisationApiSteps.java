package com.refinitiv.asts.test.ui.stepDefinitions.api;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.api.stepDefinitions.ApiBaseSteps;
import com.refinitiv.asts.test.ui.api.AppApi;
import com.refinitiv.asts.test.ui.api.model.organisation.allOrganisationData.OrganizationPayload;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.AppApi.getMyOrganizationDetails;
import static com.refinitiv.asts.test.ui.api.AppApi.getMyOrganizationFullDetails;
import static com.refinitiv.asts.test.ui.api.Endpoints.*;
import static org.assertj.core.api.Assertions.assertThat;

public class MyOrganisationApiSteps extends ApiBaseSteps {

    public MyOrganisationApiSteps(ScenarioCtxtWrapper context) {
        super(context);
    }

    @When("User cleans up My Organisation records with name prefix {string} via API")
    public void cleanUpMyOrganisationRecords(String name) {
        Arrays.asList(DEPARTMENT, ENTITY, EXTERNAL_ORGANISATION, DIVISION).forEach(endpoint -> {
            List<String> filteredMyOrganisationsIds = getFilteredMyOrganisationsIds(endpoint, name);
            filteredMyOrganisationsIds.forEach(
                    id -> AppApi.deleteMyOrganization(endpoint + ORGANISATION_DELETE, id));
        });
    }

    @Then("My Organisation records with name prefix {string} are not found")
    public void myOrganisationRecordsWithNamePrefixAreNotFound(String namePrefix) {
        Arrays.asList(DEPARTMENT, ENTITY, EXTERNAL_ORGANISATION, DIVISION).forEach(
                endpoint -> assertThat(getMyOrganizationDetails(endpoint + ORGANISATION_GET)
                                               .stream().filter(record -> record.startsWith(namePrefix))
                                               .collect(Collectors.toList()))
                        .as("\"%s\" were not deleted on %s endpoint", namePrefix, endpoint)
                        .isNullOrEmpty());
    }

    private List<String> getFilteredMyOrganisationsIds(String endpoint, String namePrefix) {
        return getMyOrganizationFullDetails(endpoint + ORGANISATION_GET)
                .stream()
                .filter(record -> record.getName().startsWith(namePrefix))
                .map(OrganizationPayload.ObjectsItem::getId)
                .collect(Collectors.toList());
    }

}
