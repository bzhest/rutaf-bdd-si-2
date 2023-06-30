package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.contacts;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.contacts.ContactsPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.AssociatedPartyIndividualData;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import java.util.List;

import static com.refinitiv.asts.test.ui.api.ConnectApi.isContactNotFound;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.DISPLAYED;
import static com.refinitiv.asts.test.ui.constants.TestConstants.ENABLED;
import static java.util.Objects.nonNull;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.assertFalse;
import static org.testng.AssertJUnit.assertTrue;

public class ContactsSteps extends BaseSteps {

    private final ContactsPage contactsPage;

    public ContactsSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.contactsPage = new ContactsPage(this.driver, this.context, this.translator);
    }

    @When("User opens Contacts for previously created Third-party")
    public void openContactsForPreviouslyCreatedThirdParty() {
        contactsPage.openContactsForCreatedThirdParty();
    }

    @When("User clicks 'Add Associated Party' button on Contacts overview page")
    public void clickAddAssociatedPartyButton() {
        contactsPage.clickAddAssociatedPartyButton();
    }

    @When("User clicks 'Add Associated Party' button on Associated Parties Overview")
    public void clickAddAssociatedPartiesButton() {
        contactsPage.clickAddAssociatedPartyButton();
    }

    @When("User deletes contact {string}")
    public void deleteContact(String contactReference) {
        contactsPage.waitWhileLoadingImageIsDisappeared();
        clicksDeleteButtonForContact(contactReference);
        contactsPage.clickOnConfirmDeleteContactButton();
        assertFalse("Confirmation Dialog is still displayed", contactsPage.isConfirmationDialogDisplayed());
    }

    @When("User clicks delete button for Associated Party {string}")
    public void clicksDeleteButtonForContact(String contactReference) {
        String contactName = (String) context.getScenarioContext().getContext(contactReference);
        if (nonNull(contactName)) {
            contactsPage.clickDeleteContactWithName(contactName);
        } else {
            contactsPage.clickDeleteContactWithName(contactReference);
        }
    }

    @When("User clicks edit contact with name {string}")
    public void clickEditContactWithName(String contactName) {
        if (contactName.equals(USER_EDITED_FIRST_NAME)) {
            contactName = (String) context.getScenarioContext().getContext(USER_EDITED_FIRST_NAME);
        }
        contactsPage.clickEditContactWithName(contactName);
    }

    @When("User clicks on Associated Party with name {string}")
    public void clickContact(String contactName) {
        contactsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (contactName.equals(USER_EDITED_FIRST_NAME)) {
            contactName = (String) context.getScenarioContext().getContext(USER_EDITED_FIRST_NAME);
        }
        contactsPage.clickOnContactWithFirstName(contactName);
    }

    @When("User clicks key principal button for contact {string}")
    public void clickKeyPrincipalButtonForContact(String contactReference) {
        contactsPage.waitWhilePreloadProgressbarIsDisappeared();
        String contactName = (String) context.getScenarioContext().getContext(contactReference);
        contactsPage.clickKeyPrincipleCheckbox(contactName);
    }

    @When("User clicks on first Contacts overview row")
    public void clickOnFirstContactsRow() {
        contactsPage.waitWhilePreloadProgressbarIsDisappeared();
        contactsPage.clickOnContactsFirstRow();
    }

    @When("User clicks on Associated Organisation")
    public void clickOnAssociatedOrganisation() {
        contactsPage.clickOnAssociatedOrganisation();
    }

    @When("User populates Name field with value {string}")
    public void populateName(String organizationName) {
        contactsPage.enterName(organizationName);
    }

    @When("User selects a Associated Organisation Screening Group {int}")
    public void selectAssociatedOrganizationScreeningGroup(int groupIndex) {
        contactsPage.selectAssociatedOrganisationScreeningGroup(groupIndex);
    }

    @When("User clicks on {string} collapse button")
    public void clickCollapseButton(String section) {
        contactsPage.clickOnCollapseElapseButton(section);
    }

    @When("User hovers to Associated Organisation groups dropdown {int}")
    public void hoverToAssociatedOrganizationGroupsDropdown(int index) {
        contactsPage.hoverToGroupsDropDown(index);
    }

    @When("User hovers to Associated Organisation Groups field")
    public void hoverToAssociatedOrganizationGroupsField() {
        contactsPage.hoverToGroupsField();
    }

    @When("User clicks Save Associated Organisation button")
    public void clickSaveAssociatedOrganisationButton() {
        contactsPage.clickAssociatedOrganisationSaveButton();
        contactsPage.waitWhilePreloadProgressbarIsDisappeared();
        if (contactsPage.isDuplicateCheckModalDisplayed()) {
            contactsPage.clickDuplicateCheckConfirmButton();
        }
    }

    @When("User clicks Duplicate Check Cancel button")
    public void clickDuplicateCheckCancelButton() {
        contactsPage.clickDuplicateCheckCancelButton();
    }

    @When("User clicks Duplicate Check Confirm button")
    public void clickDuplicateCheckConfirmButton() {
        if (contactsPage.isDuplicateCheckModalDisplayed()) {
            contactsPage.clickDuplicateCheckConfirmButton();
        }
    }

    @When("User clicks the Duplicate Check modal hyperlink {string}")
    public void clickDuplicateCheckHyperlink(String text) {
        contactsPage.clickDuplicateCheckHyperlink(text);
    }

    @Then("Associated Party {string} does not appear in the Associated Parties table")
    public void contactDoesNotAppearInTheContactsTable(String contactReference) {
        String contactName = (String) context.getScenarioContext().getContext(contactReference);
        assertFalse("Contact with name: " + contactName + " still appears in the contacts table",
                    contactsPage.isContactWithNameDisplayed(contactName));
    }

    @Then("Empty Associated Parties table with text {string} is displayed")
    public void emptyContactsTableWithTextIsDisplayed(String expectedText) {
        assertThat(contactsPage.getEmptyContactTableText())
                .as("Contacts table doesn't contains expected text")
                .isEqualTo(contactsPage.getFromDictionaryIfExists(expectedText).toUpperCase());
    }

    @Then("Associated Party table contains associated party with values")
    public void contactsTableContainsContactWithValues(List<AssociatedPartyIndividualData> expectedContacts) {
        contactsPage.waitWhilePreloadProgressbarIsDisappeared();
        expectedContacts.forEach(
                contact -> {
                    if (context.getScenarioContext().isContains(contact.getFirstName())) {
                        contact.setFirstName((String) context.getScenarioContext().getContext(contact.getFirstName()));
                    }
                    if (context.getScenarioContext().isContains(contact.getLastName())) {
                        contact.setLastName((String) context.getScenarioContext().getContext(contact.getLastName()));
                    }
                });
        assertThat(contactsPage.getContactsList())
                .as("Contacts table is not expected")
                .containsAll(expectedContacts);
    }

    @Then("Created contact does not exist")
    public void createdContactDoesNotExist() {
        String contactId = (String) context.getScenarioContext().getContext(CONTACT_ID);
        assertTrue("Created contact exists", isContactNotFound(contactId));
    }

    @Then("ADD ASSOCIATED PARTY button is displayed")
    public void addAssociatedPartyButtonDisplayed() {
        assertThat(contactsPage.isAddAssociatedPartyButtonDisplayed())
                .as("'ADD ASSOCIATED PARTY' button is not displayed")
                .isTrue();
    }

    @Then("Key Principal for contact {string} is selected")
    public void keyPrincipalForContactIsSelected(String contactReference) {
        String contactName = (String) context.getScenarioContext().getContext(contactReference);
        assertThat(contactsPage.isKeyPrincipalChecked(contactName))
                .as("Key Principal for contact %s is not selected", contactName)
                .isTrue();
    }

    @Then("Contact table contains columns")
    public void contactTableContainsColumns(List<String> expectedColumns) {
        contactsPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(contactsPage.getContactTableColumns())
                .as("Contact table doesn't contain expected columns")
                .isEqualTo(expectedColumns);
    }

    @Then("For each Contact record in the list controls buttons should be displayed")
    public void forEachContactRecordInTheListControlsButtonsShouldBeDisplayed() {
        assertThat(contactsPage.areDeleteButtonsDisplayedForEachRow())
                .as("Not all delete buttons are displayed").isTrue();
        assertThat(contactsPage.areEditButtonsDisplayedForEachRow())
                .as("Not all edit buttons are displayed").isTrue();
    }

    @Then("{string} tooltip is displayed when hover over edit button for contact {string}")
    public void tooltipIsDisplayedWhenHoverOverEditButtonForContact(String tooltipMessage, String contactReference) {
        String contactName = (String) context.getScenarioContext().getContext(contactReference);
        contactsPage.waitWhilePreloadProgressbarIsDisappeared();
        contactsPage.hoverOverEditButton(contactName);
        assertThat(contactsPage.getTooltipText())
                .as("Tooltip text is not expected")
                .isEqualTo(tooltipMessage);
    }

    @Then("^Edit button is (enabled|disabled) for contact \"((.*))\"$")
    public void editButtonIsEnabledForContact(String buttonState, String contactReference) {
        String contactName = (String) context.getScenarioContext().getContext(contactReference);
        if (buttonState.equals(ENABLED)) {
            assertThat(contactsPage.isEditButtonEnabledForContact(contactName))
                    .as("Edit button is not enabled for contact %s", contactName).isTrue();
        } else {
            assertThat(contactsPage.isEditButtonEnabledForContact(contactName))
                    .as("Edit button is not disabled for contact %s", contactName).isFalse();

        }
    }

    @Then("^Edit button is (displayed|not displayed) for contact \"((.*))\"$")
    public void editButtonIsDisplayedForContact(String buttonState, String contactReference) {
        String contactName = (String) context.getScenarioContext().getContext(contactReference);
        if (buttonState.equals(DISPLAYED.toLowerCase())) {
            assertThat(contactsPage.isEditButtonsDisplayedForContact(contactName))
                    .as("Edit button is not displayed for contact %s", contactName).isTrue();
        } else {
            assertThat(contactsPage.isEditButtonsDisplayedForContact(contactName))
                    .as("Edit button is  displayed for contact %s", contactName).isFalse();
        }
    }

    @Then("Associated Organisation Groups field value in Screening Criteria is default to {string}")
    public void associatedOrganisationGroupsFieldValueInScreeningCriteriaIsDefaultTo(String groupValue) {
        assertThat(contactsPage.getGroupsValue()).as("Default value is incorrect").isEqualTo(groupValue);
    }

    @Then("Screening Groups dropdown tooltip {string} is displayed")
    public void isScreeningGroupsDropDownToolTipDisplayed(String tooltip) {
        assertThat(contactsPage.getGroupsToolTip()).as("Expected Group Dropdown Tooltip is not displayed")
                .isEqualTo(tooltip);
    }

    @Then("Associated Organisation Screening Groups tooltip {string} is displayed")
    public void isScreeningGroupsToolTipDisplayed(String tooltip) {
        assertThat(contactsPage.getGroupsToolTip()).as("Expected Group Tooltip is not displayed").isEqualTo(tooltip);
    }

    @Then("Duplicate Check modal is displayed with text")
    public void validateDuplicateCheckModalText(List<String> expectedText) {
        String actualText = contactsPage.getDuplicateCheckModalText();
        expectedText.forEach(text ->
                                     assertTrue("Add Comment modal text '" + actualText +
                                                        "' doesn't contain expected text: ",
                                                actualText.contains(text)));
    }

    @Then("Duplicate Check modal is closed")
    public void isDuplicateCheckModalClosed() {
        assertTrue("Duplicate Check modal is not closed", contactsPage.isDuplicateCheckModalDisappeared());
    }

    @Then("Duplicate Check modal is displayed")
    public void isDuplicateCheckModalDisplayed() {
        assertTrue("Duplicate Check modal is not displayed", contactsPage.isDuplicateCheckModalDisplayed());
    }

    @Then("Duplicate Associated Organisation {string} is displayed in new tab")
    public void displayDuplicateAssociatedOrganizationNewTab(String name) {
        contactsPage.switchToTab(1);
        assertThat(contactsPage.getAssociatedOrganisationName()).as(
                "Duplicate Associated Organisation is not displayed").contains(name);
    }

}
