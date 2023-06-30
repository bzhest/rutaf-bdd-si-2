package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.SIPublicApi;
import com.refinitiv.asts.test.ui.constants.TestConstants;
import com.refinitiv.asts.test.ui.pageActions.setUp.fieldsManagement.ThirdPartyFieldsPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;

import java.util.Arrays;
import java.util.List;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.ARE_DEFAULT_THIRD_PARTY_FIELDS_CHANGED;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.pageActions.setUp.fieldsManagement.ThirdPartyFieldsPage.COUNTRY;
import static org.assertj.core.api.Assertions.assertThat;

public class ThirdPartyFieldsSteps extends BaseSteps {

    private final ThirdPartyFieldsPage thirdPartyFieldsPage;

    public ThirdPartyFieldsSteps(ScenarioCtxtWrapper context) {
        super(context);
        thirdPartyFieldsPage = new ThirdPartyFieldsPage(driver, context);
    }

    @When("User clicks Third-party Fields in Set Up menu")
    public void clickThirdPartyFieldsMenuOption() {
        thirdPartyFieldsPage.clickThirdPartyFieldsMenuOption();
        thirdPartyFieldsPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks on 'Dismiss' button for information message on top of Third-party Fields page")
    public void clickDismissInformationMessageButton() {
        thirdPartyFieldsPage.clickDismissInformationMessageButton();
    }

    @When("User clicks checkboxes in {string} column of {string} table for fields")
    public void clickThirdPartyFieldCheckboxes(String columnName, String tableName, List<String> fields) {
        if (columnName.equalsIgnoreCase(TestConstants.ACTIVE)) {
            fields.forEach(field-> thirdPartyFieldsPage.clickCheckboxActiveColumn(tableName, field));
        } else {
            fields.forEach(field-> thirdPartyFieldsPage.clickCheckboxRequiredColumn(tableName,field));
        }
    }

    @When("User clicks 'Save' button for Third-party Fields")
    public void clickSaveButton() {
        thirdPartyFieldsPage.clickSaveButton();
    }

    @When("User set default values for Third-party Fields via API")
    public void setThirdPartyFieldsDefaultValues() {
        SIPublicApi.setThirdPartyFieldsManagementToDefault();
    }

    @When("User sets custom values for Third-party Fields via API")
    public void setThirdPartyFieldsCustomValues() {
        SIPublicApi.setSubSectionsActiveFields();
        context.getScenarioContext().setContext(ARE_DEFAULT_THIRD_PARTY_FIELDS_CHANGED, true);
    }

    @When("User sets defaults values with required Bank Details and Contacts for Third-party Fields via API")
    public void setDefaultsWithRequiredBankDetailsAndContacts() {
        SIPublicApi.setDefaultsWithRequiredBankDetailsAndContacts();
        context.getScenarioContext().setContext(ARE_DEFAULT_THIRD_PARTY_FIELDS_CHANGED, true);
    }

    @When("User sets all Third-party Fields inactive except default required via API")
    public void setAllFieldsInactiveExceptDefaultRequired() {
        SIPublicApi.setAllFieldsInactiveExceptDefaultRequired();
        context.getScenarioContext().setContext(ARE_DEFAULT_THIRD_PARTY_FIELDS_CHANGED, true);
    }

    @When("User inactivates values for Third-party Segmentations Fields via API")
    public void unsetActiveThirdPartySegmentationFields() {
        SIPublicApi.unsetActiveThirdPartySegmentationFields();
        context.getScenarioContext().setContext(ARE_DEFAULT_THIRD_PARTY_FIELDS_CHANGED, true);
    }

    @When("User sets required values for General Information and Third-party Segmentations Fields via API")
    public void setRequiredGeneralInformationAndThirdPartySegmentationFields() {
        SIPublicApi.setRequiredGeneralInformationAndThirdPartySegmentationFields();
        context.getScenarioContext().setContext(ARE_DEFAULT_THIRD_PARTY_FIELDS_CHANGED, true);
    }

    @When("User sets required values for Third-party General Information fields via API")
    public void setThirdPartyFieldsRequiredValues() {
        SIPublicApi.setThirdPartyGeneralInformationFieldsToRequired();
        context.getScenarioContext().setContext(ARE_DEFAULT_THIRD_PARTY_FIELDS_CHANGED, true);
    }

    @When("User refreshes Third-party Fields page")
    public void refreshPage() {
        thirdPartyFieldsPage.refreshPage();
    }

    @Then("Third-party Fields page is displayed")
    public void isThirdPartyFieldsPageDisplayed() {
        assertThat(thirdPartyFieldsPage.isThirdPartyFieldsHeaderDisplayed())
                .as("Third-party Fields page is not displayed")
                .isTrue();
    }

    @Then ("^(Save|Reset|Dismiss) button is displayed on Third-party Fields page$")
    public void isButtonDisplayed(String buttonType) {
        boolean isElementDisplayed = false;
        switch (buttonType) {
            case SAVE:
                isElementDisplayed = thirdPartyFieldsPage.isSaveButtonDisplayed();
                break;
            case RESET:
                isElementDisplayed = thirdPartyFieldsPage.isResetButtonDisplayed();
                break;
            case DISMISS:
                isElementDisplayed = thirdPartyFieldsPage.isDismissButtonDisplayed();
        }
        assertThat(isElementDisplayed)
                .as("'%s' button is not displayed", buttonType)
                .isTrue();
    }

    @Then("^Information message is (displayed|not displayed) with text on top of Third-party Fields page$")
    public void isInformationMessageDisplayed(String state, List<String> infoMessages) {
        String actualMessage = thirdPartyFieldsPage.getInformationMessageText();
        if (state.contains(NOT)) {
            assertThat(thirdPartyFieldsPage.isInformationMessageDisplayed())
                    .as("Information message is displayed after dismissing")
                    .isFalse();
        } else {
            SoftAssertions soft = new SoftAssertions();
            infoMessages.forEach(text -> soft.assertThat(actualMessage)
                    .as("Information message is not displayed")
                    .contains(text));
            soft.assertAll();
        }
    }

    @Then("{string} table contains values")
    public void isTableContainsValues(String tableName, List<String> expectedRowNames) {
        List<String> actualRowNames = thirdPartyFieldsPage.getTableRowsNames(tableName);
        assertThat(actualRowNames)
                .as("Table row names are not as expected")
                .isEqualTo(expectedRowNames);
    }

    @Then("'Required' checkboxes for default required fields are disabled and checked in {string} table")
    public void isRequiredCheckboxesDisabledAndChecked(String tableName, List<String> rowNames) {
        SoftAssertions soft = new SoftAssertions();
        for (String row : rowNames) {
            soft.assertThat(thirdPartyFieldsPage.isRequiredCheckboxDisabledAndChecked(tableName, row))
                    .as("'" + row + "' field's 'Required' checkbox doesn't have default values or not displayed")
                    .isTrue();
        }
        soft.assertAll();
    }

    @Then("'Active' checkboxes for default required fields are disabled and checked in {string} table")
    public void isActiveCheckboxesDisabledAndChecked(String tableName, List<String> rowNames) {
        SoftAssertions soft = new SoftAssertions();
        for (String row : rowNames) {
            soft.assertThat(thirdPartyFieldsPage.isActiveCheckboxDisabledAndChecked(tableName, row))
                    .as("'" + row + "' field's 'Active' checkbox doesn't have default values or not displayed")
                    .isTrue();
        }
        soft.assertAll();
    }

    @Then("^Checkboxes are (checked|unchecked) in 'Active' column of \"(.*)\" table for fields$")
    public void isActiveCheckboxChecked(String state, String tableName, List<String> fieldNames) {
        SoftAssertions soft = new SoftAssertions();
        if (state.equals(CHECKED)) {
            fieldNames.forEach(field -> {
                soft.assertThat(thirdPartyFieldsPage.isActiveCheckboxChecked(tableName, field))
                        .as(field + " 'Active' checkbox is unchecked, but should be checked")
                        .isTrue();
            });
        } else {
            fieldNames.forEach(field -> {
                soft.assertThat(thirdPartyFieldsPage.isActiveCheckboxChecked(tableName, field))
                        .as(field + " 'Active' checkbox is checked, but should be unchecked")
                        .isFalse();
            });
        }
        soft.assertAll();
    }

    @Then("^Checkboxes are (checked|unchecked) in 'Required' column of \"(.*)\" table for fields$")
    public void isRequiredCheckboxChecked(String state, String tableName, List<String> fieldNames) {
        SoftAssertions soft = new SoftAssertions();
        if (state.equals(CHECKED)) {
            fieldNames.forEach(field -> {
                soft.assertThat(thirdPartyFieldsPage.isRequiredCheckboxChecked(tableName, field))
                        .as(field + " 'Required' checkbox is unchecked, but should be checked")
                        .isTrue();
            });
        } else {
            fieldNames.forEach(field -> {
                soft.assertThat(thirdPartyFieldsPage.isRequiredCheckboxChecked(tableName, field))
                        .as(field + " 'Required' checkbox is checked, but should be unchecked")
                        .isFalse();

            });
        }
        soft.assertAll();
    }

    @Then("{string} table contains default values for fields")
    public void isThirdPartyFieldsTableContainsDefaultValues(String tableName) {
        SoftAssertions soft = new SoftAssertions();
        List<String> tableRowsNames = thirdPartyFieldsPage.getTableRowsNames(tableName);
        List<String> requiredGeneralInformationFields =
                Arrays.asList("Name", "Responsible Party", "Division", "Workflow Group");
        tableRowsNames.forEach(field -> {
            soft.assertThat(thirdPartyFieldsPage.isActiveCheckboxChecked(tableName, field))
                    .as(field + " field Active checkbox is not checked")
                    .isTrue();
            if ((tableName.equalsIgnoreCase(GENERAL_INFORMATION) && (requiredGeneralInformationFields.contains(field)))
                    || (tableName.equalsIgnoreCase(ADDRESS) && field.equalsIgnoreCase(COUNTRY))) {
                soft.assertThat(thirdPartyFieldsPage.isRequiredCheckboxChecked(tableName, field))
                        .as(field + " field Required checkbox is not checked")
                        .isTrue();
            } else {
                soft.assertThat(thirdPartyFieldsPage.isRequiredCheckboxChecked(tableName, field))
                        .as(field + " field Required checkbox is checked")
                        .isFalse();
            }
        });
        soft.assertAll();
    }

}
