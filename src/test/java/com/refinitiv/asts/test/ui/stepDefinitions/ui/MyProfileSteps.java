package com.refinitiv.asts.test.ui.stepDefinitions.ui;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.MyProfilePage;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.ThirdPartyData;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.testng.asserts.SoftAssert;

import java.util.List;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.Colors.REACT_RED;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static org.assertj.core.api.Assertions.assertThat;

public class MyProfileSteps extends BaseSteps {

    private final MyProfilePage myProfilePage;

    public MyProfileSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.myProfilePage = new MyProfilePage(this.driver);
    }

    @When("User clicks My profile tab")
    public void clicksMyProfileTab() {
        myProfilePage.waitWhilePreloadProgressbarIsDisappeared();
        myProfilePage.clickMyProfileTab();
        myProfilePage.waitWhilePreloadProgressbarIsDisappeared();
        context.getScenarioContext().setContext(EXTERNAL_USER_FIRST_NAME, VALUE_TO_REPLACE);
    }

    @When("User clicks {string} My Profile tab")
    public void clickMyProfileTab(String tabName) {
        myProfilePage.clickMyProfileTab(tabName);
        myProfilePage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks My Profile Contacts {string} column")
    public void clickMyProfileContactsStringColumn(String columnName) {
        myProfilePage.clickColumnName(columnName);
        myProfilePage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @Then("My Profile page contains tabs")
    public void myProfilePageContainsTabs(List<String> expectedTabs) {
        myProfilePage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(myProfilePage.getTabNames()).as("My Profile page doesn't contain expected tabs")
                .isEqualTo(expectedTabs);
    }

    @Then("The Company Information tab contains a sub-section {string} with disabled fields")
    public void theCompanyInformationTabContainsSubSectionWithDisabledFields(String sectionName,
            List<String> fieldNames) {
        SoftAssert softAssert = new SoftAssert();
        fieldNames.forEach(field -> {
            softAssert.assertTrue(myProfilePage.isOverviewFieldDisplayed(sectionName, field),
                                  field + " overview field is not displayed");
            softAssert.assertFalse(myProfilePage.isInputSectionFieldEnabled(sectionName, field),
                                   field + " input field is enabled");
        });
        softAssert.assertAll();
    }

    @Then("The Company Information sub-section named {string} is collapsed")
    public void theCompanyInformationSubSectionNamedIsCollapsed(String sectionName) {
        assertThat(myProfilePage.isSectionCollapsed(sectionName)).as(sectionName + " section is not collapsed")
                .isTrue();
    }

    @Then("The Company Information sub-section named {string} cold be uncollapsed")
    public void theCompanyInformationSubSectionNamedGeneralInformationColdBeUncollapsed(String sectionName) {
        myProfilePage.clickSectionArrow(sectionName);
        assertThat(myProfilePage.isSectionCollapsed(sectionName)).as(sectionName + " section is not collapsed")
                .isFalse();
    }

    @Then("The Company Information tab fields contain expected data")
    public void theCompanyInformationTabFieldsContainExpectedData() {
        ThirdPartyData expectedResult =
                (ThirdPartyData) context.getScenarioContext().getContext(THIRD_PARTY_DATA_CONTEXT);
        expectedResult.setDateOfIncorporation(convertDateFormat(DATE_OF_INCORPORATION_FORMAT, REACT_FORMAT,
                                                                expectedResult.getDateOfIncorporation()));
        ThirdPartyData actualResult = myProfilePage.getCompanyInformationData();
        assertThat(actualResult).as("The Company Information tab fields are unexpected").usingRecursiveComparison()
                .ignoringFields("responsibleParty", "division", "workflowGroup", "liquidationDate", "spendCategory",
                                "commodityType", "designAgreement", "productImpact", "region", "relationshipVisibility",
                                "sourcingMethod", "sourcingType")
                .isEqualTo(expectedResult);
    }

    @Then("Error message {string} in red color is displayed near Profile fields")
    public void errorMessageInRedColorIsDisplayedNearProfileFields(String errorMessage, List<String> expectedFields) {
        SoftAssert softAssert = new SoftAssert();
        expectedFields.forEach(field -> {
            softAssert.assertTrue(myProfilePage.isProfileFieldInvalidAriaDisplayed(field),
                                  "Input field invalid aria is not displayed");
            softAssert.assertEquals(myProfilePage.getProfileErrorMessage(field), errorMessage,
                                    "Input field error message is not displayed");
            softAssert.assertEquals(myProfilePage.getProfileErrorMessageElementCSS(field, COLOR),
                                    REACT_RED.getColorRgba(), "Input field error message is not red");
        });
        softAssert.assertAll();
    }

    @Then("My Profile Contacts table is sorted by {string} field in {string} order")
    public void contactsTableRecordsAreSorted(String columnName, String orderType) {
        List<String> valuesList = myProfilePage.getListValuesForColumn(columnName);
        tableIsSortedByInOrder("Value Management", columnName, orderType, REACT_FORMAT, valuesList, false);
    }

}
