package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.contacts;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.ui.api.ApiRequestBuilder;
import com.refinitiv.asts.test.ui.api.SIPublicApi;
import com.refinitiv.asts.test.ui.api.model.AssociatedPartyIndividualCreateRequest;
import com.refinitiv.asts.test.ui.api.model.AssociatedPartyIndividualCreateResponse;
import com.refinitiv.asts.test.ui.api.model.thirdParty.ObjectsItem;
import com.refinitiv.asts.test.ui.dataproviders.DataProvider;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.enums.AddressFields;
import com.refinitiv.asts.test.ui.enums.ContactFields;
import com.refinitiv.asts.test.ui.enums.GeneralInformationFields;
import com.refinitiv.asts.test.ui.enums.UserFields;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.contacts.ContactPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.AssociatedPartyIndividualData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;
import org.testng.asserts.SoftAssert;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.buildCreateAssociatedPartyIndividualRequest;
import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.getThirdPartyNameFilterRequest;
import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.getAvailableContactCountriesForRegion;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.*;
import static com.refinitiv.asts.test.ui.constants.APIConstants.SAME_DIVISION;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.CHECKED;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.Colors.*;
import static java.lang.Boolean.parseBoolean;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang.WordUtils.capitalizeFully;
import static org.apache.commons.lang3.RandomStringUtils.randomAlphanumeric;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.*;

public class ContactSteps extends BaseSteps {

    private static final String GENERAL_INFORMATION_CONTACT_DATA_REFERENCE = "editedContactGeneralInformation";
    private static final String ADDRESS_DATA_CONTACT_REFERENCE = "editedContactAddress";
    private static final String CONTACT_DATA_CONTACT_REFERENCE = "editedContactContact";
    private static final String CONTACT_DATA_REGION_REFERENCE = "editedContactRegion";
    private static final String CONTACT_DATA_COUNTRY_REFERENCE = "editedContactCountry";
    private final ContactPage contactPage;

    public ContactSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.contactPage = new ContactPage(this.driver, translator);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public AssociatedPartyIndividualData contactEntry(Map<String, String> entry) {
        return AssociatedPartyIndividualData.builder()
                .title(entry.get(GeneralInformationFields.TITLE.getDefaultName()))
                .firstName(entry.get(GeneralInformationFields.FIRST_NAME.getDefaultName()))
                .lastName(entry.get(GeneralInformationFields.LAST_NAME.getDefaultName()))
                .middleName(entry.get(GeneralInformationFields.MIDDLE_NAME.getDefaultName()))
                .addressLine(entry.get(AddressFields.ADDRESS_LINE.getName()))
                .city(entry.get(AddressFields.CITY.getName()))
                .zipCode(entry.get(AddressFields.ZIP_POSTAL_CODE.getName()))
                .stateProvince(entry.get(AddressFields.STATE_PROVINCE.getName()))
                .region(entry.get(AddressFields.REGION.getName()))
                .addressCountry(entry.get(AddressFields.COUNTRY.getName()))
                .nationality(entry.get(NATIONALITY))
                .placeOfBirth(entry.get(PLACE_OF_BIRTH))
                .phoneNumber(entry.get(ContactFields.PHONE_NUMBER.getDefaultName()))
                .fax(entry.get(ContactFields.FAX.getDefaultName()))
                .website(entry.get(ContactFields.WEBSITE.getDefaultName()))
                .emailAddress(entry.get(ContactFields.EMAIL_ADDRESS.getDefaultName()))
                .description(entry.get(DESCRIPTION))
                .keyPrinciple(nonNull(entry.get(KEY_PRINCIPAL)) ? parseBoolean(entry.get(KEY_PRINCIPAL)) : null)
                .status(entry.get(UserFields.STATUS.getName()))
                .build();
    }

    @When("User clicks Associated Party Overview contact button")
    public void clickContactOverviewButton() {
        contactPage.clickContactOverviewButton();
        contactPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User clicks on Save Associated Party button")
    public void clickOnSaveContactButton() {
        contactPage.clickSaveContactButton();
    }

    @When("User clicks on Save and New Associated Party button")
    public void clickOnSaveAndNewAssociatedPartyButton() {
        contactPage.clickSaveAndNewAssociatedPartyButton();
    }

    @When("User fills in contact data with random data")
    public void fillInContactData() {
        AssociatedPartyIndividualData
                contactTestData =
                new AssociatedPartyIndividualData().setEmailAddress(getRandomValue(VALUE_TO_REPLACE) + "@test.com")
                        .setFirstName(getRandomValue(VALUE_TO_REPLACE))
                        .setLastName(getRandomValue(VALUE_TO_REPLACE));
        contactPage.fillInAllMandatoryContactData(contactTestData);
        context.getScenarioContext().setContext(USER_EDITED_FIRST_NAME, contactTestData.getFirstName());
        context.getScenarioContext().setContext(USER_EDITED_LAST_NAME, contactTestData.getLastName());
    }

    @When("User clicks Close Add Associated Party button")
    public void clickCloseAddContactButton() {
        contactPage.waitWhilePreloadProgressbarIsDisappeared();
        contactPage.clickCloseAddContactButton();
    }

    @When("^User clicks Associated Party's (.*) section \"(Save|Edit|Cancel)\" button$")
    public void clicksAddressSectionButton(String sectionName, String buttonType) {
        sectionName = contactPage.getFromDictionaryIfExists(sectionName);
        if (contactPage.isSectionHidden(sectionName)) {
            contactPage.clickOnCollapseElapseButton(sectionName);
        }
        switch (buttonType) {
            case SAVE:
                contactPage.clickSaveSectionButton(sectionName);
                break;
            case EDIT:
                if (sectionName.equals(CONTACT)) {
                    contactPage.clickEditContactSectionButton(sectionName);
                } else {
                    contactPage.clickEditSectionButton(sectionName);
                }
                break;
            case CANCEL:
                contactPage.clickCancelSectionButton(sectionName);
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
    }

    @When("User fills in Associated Party's Description text {string}")
    public void fillInContactSDescriptionText(String text) {
        contactPage.fillInDescription(text);
    }

    @When("User enters Associated Party first name with value {string}")
    public void enterContactFirstName(String value) {
        if (value.equals(VALUE_TO_REPLACE)) {
            value = AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10);
            context.getScenarioContext().setContext(USER_EDITED_FIRST_NAME, value);
        }
        contactPage.enterFirstName(value);
    }

    @When("User enters Associated party Address section on position {int} with values")
    public void enterContactCountry(int addressPosition, AssociatedPartyIndividualData associatedPartyIndividualData) {
        if (nonNull(associatedPartyIndividualData.getRegion()) &&
                !associatedPartyIndividualData.getRegion().isEmpty()) {
            associatedPartyIndividualData.setRegion(getAvailableRegionNames().get(0));
        }
        if ((Objects.isNull(associatedPartyIndividualData.getAddressCountry()) ||
                associatedPartyIndividualData.getAddressCountry().isEmpty())
                && nonNull(associatedPartyIndividualData.getRegion())) {
            associatedPartyIndividualData.setAddressCountry(
                    getAvailableContactCountriesForRegion(associatedPartyIndividualData.getRegion()).get(0));
        }
        if (nonNull(associatedPartyIndividualData.getAddressCountry()) &&
                associatedPartyIndividualData.getAddressCountry().equals(VALUE_TO_REPLACE)) {
            associatedPartyIndividualData.setAddressCountry(getCountryWithoutChecklist());
        }
        contactPage.fillInAddressDetails(addressPosition, associatedPartyIndividualData);
    }

    @When("User enters Associated Party last name with value {string}")
    public void enterContactLastName(String value) {
        if (value.equals(VALUE_TO_REPLACE)) {
            value = AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10);
            context.getScenarioContext().setContext(USER_EDITED_LAST_NAME, value);
        }
        contactPage.enterLastName(value);
    }

    @When("User enters Associated Party email with value {string}")
    public void enterContactEmail(String value) {
        if (value.equals(EMAIL_CONTEXT)) {
            value = (String) context.getScenarioContext().getContext(EMAIL_CONTEXT);
        }
        contactPage.enterEmail(value);
    }

    @When("^User (checks|unchecks) 'Enabled as User' checkbox on contact screen$")
    public void clickEnableButton(String checkType) {
        if (contactPage.isSectionHidden(translator.getValue("contact.section"))) {
            contactPage.clickOnCollapseElapseButton(translator.getValue("contact.section"));
        }
        if ((checkType.equals(CHECKS) && !contactPage.isEnabledAsUserCheckboxChecked()) ||
                (!checkType.equals(CHECKS) && contactPage.isEnabledAsUserCheckboxChecked())) {
            contactPage.clickEditSectionButton(translator.getValue("contact.section"));
            contactPage.clickEnabledAsUserCheckbox();
            contactPage.clickSaveSectionButton(translator.getValue("contact.section"));
            contactPage.waitWhilePreloadProgressbarIsDisappeared();
        }
    }

    @When("^User (checks|unchecks) 'Enabled as User' checkbox on Add contact screen$")
    public void clickEnableAsUserCheckbox(String checkType) {
        if (contactPage.isSectionHidden(CONTACT)) {
            contactPage.clickOnCollapseElapseButton(CONTACT);
        }
        if ((checkType.equals(CHECKS) && !contactPage.isEnabledAsUserCheckboxChecked()) ||
                (!checkType.equals(CHECKS) && contactPage.isEnabledAsUserCheckboxChecked())) {
            contactPage.clickEnabledAsUserCheckbox();
        }
    }

    @When("User clicks close External User modal")
    public void clickCloseExternalUserModal() {
        contactPage.clickCancelExternalUserModal();
    }

    @When("User clicks Reset Password User modal button")
    public void clickResetPasswordUserModalButton() {
        contactPage.clickResetPassword();
    }

    @When("User updates Associated Party's General Information section with values")
    public void updateGeneralInformationSectionValues(AssociatedPartyIndividualData associatedPartyIndividualData) {
        contactPage.fillInProfileGeneralInformation(associatedPartyIndividualData);
        context.getScenarioContext().setContext(GENERAL_INFORMATION_CONTACT_DATA_REFERENCE,
                                                associatedPartyIndividualData);
    }

    @When("User updates Associated Party's Address section on position {int} with values")
    public void updateAddressSectionWithValues(int addressPosition,
            AssociatedPartyIndividualData associatedPartyIndividualData) {
        String regionToReplace = associatedPartyIndividualData.getRegion();
        if (nonNull(associatedPartyIndividualData.getRegion()) && VALUE_TO_REPLACE.equals(regionToReplace)) {
            String region = getAvailableRegionNames().get(0);
            associatedPartyIndividualData.setRegion(region);
            context.getScenarioContext().setContext(CONTACT_DATA_REGION_REFERENCE, region);
        }
        if ((Objects.isNull(associatedPartyIndividualData.getAddressCountry()) ||
                associatedPartyIndividualData.getAddressCountry().isEmpty())
                && nonNull(regionToReplace)) {
            String country = getAvailableContactCountriesForRegion(associatedPartyIndividualData.getRegion()).get(0);
            associatedPartyIndividualData.setAddressCountry(country);
            context.getScenarioContext().setContext(CONTACT_DATA_COUNTRY_REFERENCE, country);
        }
        contactPage.fillInAddressDetails(addressPosition, associatedPartyIndividualData);
        context.getScenarioContext().setContext(ADDRESS_DATA_CONTACT_REFERENCE, associatedPartyIndividualData);
    }

    @When("User updates Associated Party's Contact section with values")
    public void updateContactSectionWithValues(List<AssociatedPartyIndividualData> associatedPartyIndividualDataList) {
        if (EMAIL_CONTEXT.equals(associatedPartyIndividualDataList.get(0).getEmailAddress())) {
            associatedPartyIndividualDataList.get(0).setEmailAddress(
                    (String) context.getScenarioContext().getContext(EMAIL_CONTEXT));
        }
        contactPage.fillInProfileContact(associatedPartyIndividualDataList.get(0));
        context.getScenarioContext().setContext(CONTACT_DATA_CONTACT_REFERENCE, associatedPartyIndividualDataList);
    }

    @When("User clicks View External User")
    public void clickViewExternalUser() {
        contactPage.clickViewExternalUserButton();
    }

    @When("User clicks on Contact's Check Type {string}")
    public void clickOnCheckType(String checkType) {
        contactPage.clickCheckTypeCheckbox(checkType);
    }

    @When("User clicks on Contact's Ongoing Screening {string}")
    public void clickOngoingScreening(String ongoingName) {
        contactPage.clickOngoingScreening(ongoingName);
    }

    @When("User changes Contact's Search Term current value {string} with value {string}")
    public void changeSearchTermWithValue(String currentValue, String newValue) {
        contactPage.updateSearchTermValue(currentValue, newValue);
    }

    @When("User deletes First Name current value {string}")
    public void deleteFirstName(String currentValue) {
        contactPage.clearFirstNameValue(currentValue);
    }

    @When("User deletes Last Name current value {string}")
    public void deleteLastName(String currentValue) {
        contactPage.clearLastNameValue(currentValue);
    }

    @When("User enters Citizenship On Screening Criteria section with value {string}")
    public void enterScreeningCriteriaCitizenship(String value) {
        contactPage.fillInScreeningCriteriaCitizenship(value);
    }

    @When("User enters Country of Location On Screening Criteria Section with value {string}")
    public void enterScreeningCriteriaCountryOfLocation(String value) {
        contactPage.fillInScreeningCriteriaCountryOfLocation(value);
    }

    @When("User enters Place of Birth On Screening Criteria Section with value {string}")
    public void enterScreeningCriteriaPlaceOfBirth(String value) {
        contactPage.fillInScreeningCriteriaPlaceOfBirth(value);
    }

    @When("User enters Notification Recipients on Screening Criteria Section with value {string}")
    public void enterScreeningCriteriaNotificationRecipients(String value) {
        contactPage.fillInNotificationRecipients(value);
    }

    @When("^User clicks Auto-screen button to (ON|OFF)$")
    public void clickAutoScreenOFF(String switcherStatus) {
        if (switcherStatus.equals(ON.toUpperCase())) {
            contactPage.clickAutoScreenONButton();
        } else {
            contactPage.clickAutoScreenOFFButton();
        }
    }

    @When("User clicks Add Associated Party modal Add address button")
    public void clickAddContactModalAddAddressButton() {
        contactPage.clickAddAddressButton();
    }

    @When("User clicks Remove edit Address section on position {int}")
    public void clickRemoveEditAddressSectionOnPosition(int addressPosition) {
        contactPage.clickRemoveAddressButton(addressPosition);
    }

    @When("User updates Associated Party's Contact section {string} on position {int} with values {string}")
    public void updateContactSContactSectionOnPositionWithValues(String fieldName, int fieldPosition, String value) {
        contactPage.fillInContactSectionField(fieldName, fieldPosition, value);
    }

    @When("User clicks Add {string} button")
    public void clickAddContactFieldButton(String buttonName) {
        contactPage.clickAddContactField(buttonName);
    }

    @When("User clicks Add {string} edit contact button")
    public void clickAddContactFieldEditButton(String buttonName) {
        clickAddContactFieldButton(buttonName);
    }

    @When("User clicks remove {string} on position {int}")
    public void clickRemoveOnPosition(String fieldName, int fieldPosition) {
        contactPage.clickRemoveContactField(fieldName, fieldPosition);
    }

    @When("User click Remove Address section on position {int}")
    public void clickRemoveAddressSectionOnPosition(int addressPosition) {
        contactPage.clickRemoveAddressButton(addressPosition);
    }

    @When("External user creates {string} contact for {string} third-party via API")
    public void externalUserCreatesContactViaAPI(String contactReference, String thirdPartyName) {
        AssociatedPartyIndividualData contactTestData =
                new JsonUiDataTransfer<AssociatedPartyIndividualData>(
                        DataProvider.ASSOCIATED_PARTY_INDIVIDUAL).getTestData().get(contactReference)
                        .getDataToEnter();
        contactTestData.setFirstName(getRandomValue(contactTestData.getFirstName()));
        contactTestData.setLastName(getRandomValue(contactTestData.getLastName()));
        if (contactTestData.getEmailAddress().isEmpty()) {
            contactTestData.setEmailAddress((String) context.getScenarioContext().getContext(EMAIL_CONTEXT));
        }
        AssociatedPartyIndividualCreateResponse.ContactData contact =
                SIPublicApi.createMyProfileContact(contactTestData, thirdPartyName);
        context.getScenarioContext().setContext(CONTACT_ID, contact.getId());
        context.getScenarioContext().setContext(EXTERNAL_USER_FIRST_NAME, contact.getFirstName());
        context.getScenarioContext().setContext(USER_EDITED_FIRST_NAME, contact.getFirstName());
        context.getScenarioContext().setContext(USER_EDITED_LAST_NAME, contact.getLastName());
    }

    @When("Creates {string} contact for {string} third-party via API")
    public void createContactForThirdPartyViaAPI(String contactReference, String thirdPartyName) {
        AssociatedPartyIndividualData contactTestData =
                new JsonUiDataTransfer<AssociatedPartyIndividualData>(
                        DataProvider.ASSOCIATED_PARTY_INDIVIDUAL).getTestData().get(contactReference)
                        .getDataToEnter();
        contactTestData.setEmailAddress(Config.get().value(contactTestData.getEmailAddress()));
        ObjectsItem filteredThirdParties =
                getFilteredThirdParties(getThirdPartyNameFilterRequest(ApiRequestBuilder.NAME, ApiRequestBuilder.LIKE,
                                                                       thirdPartyName), SAME_DIVISION, TEN).stream()
                        .filter(thirdParty -> thirdParty.getName().equals(thirdPartyName)).findFirst()
                        .orElseThrow(() -> new RuntimeException(
                                String.format("Third-party with name %s wasn't found", thirdPartyName)));
        AssociatedPartyIndividualCreateRequest
                request = buildCreateAssociatedPartyIndividualRequest(contactTestData, filteredThirdParties.getId());
        postIndividualAssociatedParty(request, filteredThirdParties.getId());
    }

    @When("^User clicks on \"(Wold-Check|Custom WatchList|Media Check)\" checkbox to \"(select|unselect)\" in add contact page$")
    public void clickOnScreeningCheckType(String checkType, String option) {
        boolean isCheckTypeChecked = contactPage.isCheckTypeChecked(checkType);
        if ((option.equals(UNSELECT) && isCheckTypeChecked) || (option.equals(SELECT) && !isCheckTypeChecked)) {
            clickOnCheckType(checkType);
        }
    }

    @When("User selects a Screening Group {int}")
    public void selectContactGroup(int groupIndex) {
        contactPage.selectGroup(groupIndex);
    }

    @When("User hovers to Screening Groups field")
    public void hoverScreeningGroupsField() {
        contactPage.hoverScreeningGroups();
    }

    @Then("Add contact {string} drop-down field is displayed with list of countries from WC1")
    public void addDropDownFieldIsDisplayedWithListOfCountriesFromWC(String countryType) {
        List<String> expectedDropDownValues = getCountriesNamesList();
        List<String> actualDropDownValues = contactPage.openAndGetSearchCriteriaDropDownListValues(countryType);
        assertEquals(countryType + " drop-down list doesn't contains expected values", expectedDropDownValues,
                     actualDropDownValues);
    }

    @Then("{string} for contact is displayed between {string} and {string} sections")
    public void forContactIsDisplayedBetweenAndSections(String testedSection, String beforeSection,
            String afterSection) {
        contactPage.waitWhilePreloadProgressbarIsDisappeared();
        assertTrue(testedSection + " section is not right after " + beforeSection,
                   contactPage.isSectionBeforeOtherSection(beforeSection, testedSection));
        assertTrue(testedSection + " section is not right before " + afterSection,
                   contactPage.isSectionBeforeOtherSection(testedSection, afterSection));
    }

    @Then("Contact {string} Address section's field is empty")
    public void contactAddressDetailsIsEmpty(String fieldName) {
        assertTrue(fieldName + " contact address details doesn't contain expected data",
                   Objects.isNull(contactPage.getAddressDetailsValue(fieldName, 1)));
    }

    @Then("Associated Party page is loaded")
    public void contactPageIsLoaded() {
        contactPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertTrue("Contact page is not loaded", contactPage.isPageLoaded());
        context.getScenarioContext().setContext(CONTACT_ID, contactPage.getContactIdFromUrl());
    }

    @Then("^User can (expand|collapse) \"((.*))\" section$")
    public void validatePossibilityExpandSection(String sectionState, String sectionName) {
        sectionName = contactPage.getFromDictionaryIfExists(sectionName);
        contactPage.clickOnCollapseElapseButton(capitalizeFully(sectionName));
        validateSectionVisibility(sectionState, sectionName);
    }

    @Then("^Section \"((.*))\" is (expanded|collapsed)")
    public void validateSectionVisibility(String sectionName, String sectionState) {
        if (sectionState.contains(EXPAND)) {
            assertTrue(sectionName + " section is not expanded", contactPage.isSectionDisplayed(sectionName));
        } else {
            assertTrue(sectionName + " section is not collapsed", contactPage.isSectionDisappeared(sectionName));
        }
    }

    @Then("Associated Parties details are displayed with populated data")
    public void contactInformationDetailsAreDisplayedWithPopulatedData() {
        AssociatedPartyIndividualData
                expectedResult =
                (AssociatedPartyIndividualData) this.context.getScenarioContext().getContext(CONTACT_TEST_DATA);
        AssociatedPartyIndividualData actualResult = contactPage.getContactInformationDetails();
        assertThat(actualResult)
                .as("Contact Information details are not expected")
                .usingRecursiveComparison().ignoringFields("autoScreen")
                .isEqualTo(expectedResult);
    }

    @Then("Contact Information details are displayed with empty data")
    public void contactInformationDetailsAreDisplayedWithEmptyData() {
        AssociatedPartyIndividualData actualResult = contactPage.getContactInformationDetails();
        AssociatedPartyIndividualData expectedEmptyData = new AssociatedPartyIndividualData();
        assertThat(actualResult)
                .as("Contact Information details values are not empty")
                .isEqualTo(expectedEmptyData);
    }

    @Then("Associated Party's General Information section details are displayed with populated data")
    public void validateInformationSectionDetailsData() {
        contactPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        AssociatedPartyIndividualData expectedResult =
                (AssociatedPartyIndividualData) context.getScenarioContext()
                        .getContext(GENERAL_INFORMATION_CONTACT_DATA_REFERENCE);
        contactGeneralInformationSectionDetailsAreDisplayedWithData(expectedResult);
    }

    @Then("Associated Party's General Information section details are displayed with data")
    public void contactGeneralInformationSectionDetailsAreDisplayedWithData(
            AssociatedPartyIndividualData expectedResult) {
        if (expectedResult.getFirstName().equals(USER_EDITED_FIRST_NAME)) {
            String firstName = (String) context.getScenarioContext().getContext(USER_EDITED_FIRST_NAME);
            expectedResult.setFirstName(firstName);
        }
        if (expectedResult.getLastName().equals(USER_EDITED_LAST_NAME)) {
            String lastName = (String) context.getScenarioContext().getContext(USER_EDITED_LAST_NAME);
            expectedResult.setLastName(lastName);
        }
        AssociatedPartyIndividualData actualResult = contactPage.getGeneralInformationSectionDetails();
        assertThat(actualResult).as("Contact's General Information section section details are not expected")
                .isEqualTo(expectedResult);
    }

    @Then("Associated Party's Address section details are displayed with populated data")
    public void validateAddressSectionDetailsData() {
        contactPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        AssociatedPartyIndividualData expectedResult =
                (AssociatedPartyIndividualData) context.getScenarioContext().getContext(ADDRESS_DATA_CONTACT_REFERENCE);
        contactAddressSectionDetailsAreDisplayedWithData(List.of(expectedResult));
    }

    @Then("Associated Party's Address section details are displayed with data")
    public void contactAddressSectionDetailsAreDisplayedWithData(List<AssociatedPartyIndividualData> expectedResult) {
        contactPage.waitWhileLoadingImageIsDisappeared();
        expectedResult.forEach(address -> {
            if (nonNull(address.getRegion()) && address.getRegion().equals(VALUE_TO_REPLACE)) {
                address.setRegion((String) context.getScenarioContext().getContext(CONTACT_DATA_REGION_REFERENCE))
                        .setAddressCountry(
                                (String) context.getScenarioContext().getContext(CONTACT_DATA_COUNTRY_REFERENCE));
            }
        });
        List<AssociatedPartyIndividualData> actualResult = contactPage.getAddressSectionDetails();
        assertThat(actualResult).as("Contact's Address section section details are not expected")
                .usingRecursiveComparison().ignoringExpectedNullFields()
                .isEqualTo(expectedResult);
    }

    @SuppressWarnings("unchecked")
    @Then("Associated Party's Contact section details are displayed with populated data")
    public void validateContactSectionDetailsData() {
        contactPage.waitWhilePreloadProgressbarIsDisappeared();
        List<AssociatedPartyIndividualData> expectedResult =
                (List<AssociatedPartyIndividualData>) context.getScenarioContext()
                        .getContext(CONTACT_DATA_CONTACT_REFERENCE);
        contactContactSectionDetailsAreDisplayedWithData(expectedResult);
    }

    @Then("Associated Party's Contact section details are displayed with data")
    public void contactContactSectionDetailsAreDisplayedWithData(List<AssociatedPartyIndividualData> expectedResult) {
        contactPage.waitWhilePreloadProgressbarIsDisappeared();
        List<AssociatedPartyIndividualData> actualResult = contactPage.getContactSectionDetails();
        expectedResult.forEach(contactData -> {
            if (EMAIL_CONTEXT.equals(contactData.getEmailAddress())) {
                contactData.setEmailAddress((String) context.getScenarioContext().getContext(EMAIL_CONTEXT));
            }
        });
        assertThat(actualResult).as("Contact's Contact section section details are not expected")
                .isEqualTo(expectedResult);
    }

    @Then("^(.*) section \"(Save|Cancel)\" button (is|is not) displayed$")
    public void contactSectionButtonIsNotDisplayed(String sectionName, String buttonType, String buttonState) {
        contactPage.waitWhilePreloadProgressbarIsDisappeared();
        contactPage.waitWhileLoadingImageIsDisappeared();
        boolean isButtonDisplayed;
        switch (buttonType) {
            case SAVE:
                isButtonDisplayed = contactPage.isSectionSaveButtonDisplayed(sectionName);
                break;
            case CANCEL:
                isButtonDisplayed = contactPage.isSectionCancelButtonDisplayed(sectionName);
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
        if (buttonState.equals(IS_NOT)) {
            assertThat(isButtonDisplayed).as(buttonType + " button Contact's Contact section is displayed")
                    .isFalse();
        } else {
            assertThat(isButtonDisplayed).as(buttonType + " button Contact's Contact section is not displayed")
                    .isTrue();
        }
    }

    @Then("'Enabled as User' checkbox is unchecked")
    public void enableContactButtonIsInactive() {
        assertFalse("Enable contact button is not inactive", contactPage.isEnabledAsUserCheckboxChecked());
    }

    @Then("Contact status control is set to {string} position")
    public void contactStatusControlIsSetToPosition(String expectedStatus) {
        boolean isEnable = contactPage.isEnabledAsUserCheckboxChecked();
        if (expectedStatus.equals(ENABLE)) {
            assertThat(isEnable).as("Contact status control is not set to Enable").isTrue();
        } else {
            assertThat(isEnable).as("Contact status control is not set to Disable").isFalse();
        }
    }

    @Then("Error message {string} in red color is displayed near {string} contact field")
    public void errorMessageInRedColorIsDisplayedNearContactField(String errorMessage, String fieldName) {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(contactPage.isFieldInvalidAriaDisplayed(fieldName),
                              fieldName + " field doesn't display invalid aria");
        softAssert.assertEquals(contactPage.getErrorMessageText(fieldName), errorMessage,
                                errorMessage + " error message is not displayed");
        softAssert.assertTrue(contactPage.getErrorMessageElementCSS(fieldName, COLOR).equals(REACT_RED.getColorRgba()),
                              fieldName + " error message is not red");
        softAssert.assertAll();
    }

    @Then("^Associated Party's Email Address field is (read-only|editable)$")
    public void contactSEmailAddressFieldIsNotEditable(String fieldStatus) {
        if (fieldStatus.equals(READ_ONLY)) {
            assertTrue("Associated Party's Email Address field is editable", contactPage.isEmailReadOnly());
        } else {
            assertFalse("Associated Party's Email Address field is not editable", contactPage.isEmailReadOnly());
        }
    }

    @Then("Associated Party's Description section is not populated")
    public void contactSDescriptionSectionIsNotPopulated() {
        assertFalse("Associated Party's Description section is populated", contactPage.isDescriptionTextDisplayed());
    }

    @Then("Associated Party's Description section is populated with text {string}")
    public void contactSDescriptionSectionIsPopulatedWithText(String expectedResult) {
        assertEquals("Description is unexpected", expectedResult, contactPage.getDescriptionText());
    }

    @Then("^Contact's Check Type is (checked|unchecked)$")
    public void checkTypeIsCheckedOnTheFollowingList(String checkType, DataTable dataTable) {
        contactPage.waitWhilePreloadProgressbarIsDisappeared();
        SoftAssert soft = new SoftAssert();
        dataTable.asList().forEach(text -> {
            if (checkType.equals(CHECKED)) {
                soft.assertTrue(contactPage.isCheckTypeChecked(text),
                                "Check Type '" + text + "' isn't checked");
            } else {
                soft.assertFalse(contactPage.isCheckTypeChecked(text),
                                 "Check Type '" + text + "' is checked");
            }
        });
        soft.assertAll();
    }

    @Then("^Contact's Ongoing Screening \"(.*)\" is (checked|unchecked)$")
    public void uncheckOngoingScreening(String ongoingName, String checkedStatus) {
        boolean isChecked = contactPage.isOngoingScreeningUnChecked(ongoingName);
        if (checkedStatus.equals(CHECKED)) {
            assertTrue("Ongoing Screening '" + ongoingName + "' is not checked", isChecked);
        } else {
            assertFalse("Ongoing Screening '" + ongoingName + "' is not unchecked", isChecked);
        }
    }

    @Then("Contact's Notification Recipients {string} is checked")
    public void checkRecipients(String recipients) {
        assertTrue("Notification Recipients '" + recipients + "' is not checked",
                   contactPage.isRecipientsUserChecked(recipients));
    }

    @Then("Error message {string} in red color is displayed on General Information section on field")
    public void errorMessageInRedColorIsDisplayedNearField(String errorMessage, DataTable dataTable) {
        SoftAssert softAssert = new SoftAssert();
        dataTable.asList().forEach(text -> {
            softAssert.assertTrue(contactPage.isFieldInvalidAriaDisplayed(text),
                                  "Input field invalid aria is not displayed");
            softAssert.assertEquals(contactPage.getElementErrorMessage(text), errorMessage,
                                    "Input field error message is not displayed");
            softAssert.assertEquals(contactPage.getErrorMessageElementCSS(text, COLOR),
                                    REACT_RED.getColorRgba(),
                                    "Input field error message is not red");
        });
        softAssert.assertAll();
    }

    @Then("Error message {string} in red color is displayed on Contact section on field")
    public void errorMessageInRedColorIsDisplayedNearContactSectionField(String errorMessage, DataTable dataTable) {
        SoftAssert softAssert = new SoftAssert();
        dataTable.asList()
                .forEach(text -> {
                    softAssert.assertTrue(contactPage.isContactSectionFieldInvalidAriaDisplayed(text),
                                          "Contact section input field invalid aria is not displayed");
                    softAssert.assertEquals(contactPage.getContactSectionElementErrorMessage(text), errorMessage,
                                            "Contact section input field error message is not displayed");
                    softAssert.assertEquals(contactPage.getContactSectionErrorMessageElementCSS(text, COLOR),
                                            RED.getColorRgba(),
                                            "Contact section input field error message is not red");
                });
        softAssert.assertAll();
    }

    @Then("Error message {string} in red color is displayed on Screening Criteria section on field")
    public void errorMessageInRedColorIsDisplayedOnScreeningCriteriaSectionField(String errorMessage,
            String fieldName) {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertEquals(contactPage.getScreeningCriteriaSectionElementErrorMessage(fieldName), errorMessage,
                                "Screening Criteria section input field error message is not displayed");
        softAssert.assertEquals(contactPage.getScreeningCriteriaSectionErrorMessageColor(fieldName, COLOR),
                                REACT_RED.getColorRgba(),
                                "Screening Criteria section input field error message is not red");
        softAssert.assertAll();
    }

    @Then("Search Term Value on Screening Criteria section is pre-populated with Full Name {string}")
    public void checkSearchTermIsPrePopulated(String fullName) {
        assertTrue("Search Term value isn't pre-populated", contactPage.isSearchTermValueDisplayed(fullName));
    }

    @Then("{string} Value on Screening Criteria section is not pre-populated and Displayed as empty")
    public void checkValueNotPrePopulated(String name) {
        assertThat(contactPage.getDropDownValue(name))
                .as(name + " Value is pre-populated and not empty ")
                .isNull();
    }

    @Then("^Add Associated Party modal Add address button is (disabled|enabled|hidden)$")
    public void validateAddContactModalAddAddressButton(String buttonState) {
        if (buttonState.equals(HIDDEN)) {
            assertThat(contactPage.isAddAddressButtonHidden()).as("Add Address Button is displayed").isTrue();
        } else if (buttonState.equals(DISABLED)) {
            assertThat(contactPage.isAddAddressButtonDisabled()).as("Add Address Button is enabled").isTrue();
        } else {
            assertThat(contactPage.isAddAddressButtonEnabled()).as("Add Address Button is disabled").isTrue();
        }
    }

    @Then("^\"((.*))\" field on position ((.*)) (is|is not) displayed with value \"((.*))\"$")
    public void addUserFieldOnPositionIsDisplayedWithValue(String fieldName, int fieldPosition, String fieldState,
            String value) {
        if (fieldState.equals(IS_NOT)) {
            assertThat(contactPage.isFieldWithValueDisplayed(fieldName, fieldPosition, value)).as(
                    "%s field on position %s is displayed with value %s",
                    fieldName, fieldPosition, value).isFalse();
        } else {
            assertThat(contactPage.isFieldWithValueDisplayed(fieldName, fieldPosition, value)).as(
                    "%s field on position %s is displayed with value %s",
                    fieldName, fieldPosition, value).isTrue();
        }
    }

    @Then("^Add \"((.*))\" (?:contact|edit contact) button is (disabled|enabled)$")
    public void addContactModalAddContactButtonIsDisabled(String buttonName, String buttonState) {
        if (buttonState.equals(DISABLED)) {
            assertThat(contactPage.isAddContactFieldButtonDisabled(buttonName))
                    .as("Add %s is not disabled", buttonName).isTrue();
        } else {
            assertThat(contactPage.isAddContactFieldButtonEnabled(buttonName))
                    .as("Add %s is not enabled", buttonName).isTrue();
        }
    }

    @Then("Associated Party Add modal Auto-screen button is displayed")
    public void contactAddModalAutoScreenButtonIsDisplayed() {
        assertThat(contactPage.isAutoScreenButtonDisplayed())
                .as("Associated Party Add modal Auto-screen button is not displayed").isTrue();
    }

    @Then("Associated Party Add modal Key-principal star button is displayed")
    public void contactAddModalLeyPrincipalStarButtonIsDisplayed() {
        assertThat(contactPage.isKeyPrincipalCheckboxDisplayed())
                .as("Contact Add modal Key-principal star button is not displayed").isTrue();
    }

    @Then("Associated Party Contact modal {string} button is displayed")
    public void addContactModalButtonIsDisplayed(String buttonName) {
        assertThat(contactPage.isButtonWithTextDisplayed(buttonName))
                .as("Associated Party Contact modal %s button is displayed", buttonName).isTrue();
    }

    @Then("Contact 'Enabled as User' checkbox is displayed")
    public void contactEnableAsUserCheckboxIsDisplayed() {
        assertThat(contactPage.isEnabledAsUserCheckboxDisplayed())
                .as("'Enabled as User' checkbox is not displayed")
                .isTrue();
    }

    @Then("The Associated Party overview page contains {string} sub-section with fields")
    public void theContactOverviewPageContainsSubSectionWithFields(String sectionName, List<String> fields) {
        assertThat(contactPage.getSectionFields(sectionName))
                .as("The Contact sub-section doesn't contains expected fields").usingRecursiveComparison()
                .ignoringCollectionOrder().isEqualTo(fields);
    }

    @Then("The Associated Party overview page {string} edit button is displayed")
    public void theContactOverviewPageEditButtonIsDisplayed(String sectionName) {
        assertThat(contactPage.isEditSectionButtonDisplayed(sectionName))
                .as("Section %s edit button is not displayed", sectionName).isTrue();
    }

    @Then("^All Associated Party General Information section (input|view) fields are displayed$")
    public void allContactGeneralInformationSectionInputFieldsAreDisplayed(String fieldsState,
            List<String> fieldNames) {
        if (fieldsState.equalsIgnoreCase(VIEW)) {
            assertThat(contactPage.areAllViewGeneralInformationFieldsDisplayed(fieldNames))
                    .as("General Information contact section view fields are not displayed").isTrue();
        } else {
            assertThat(contactPage.areAllInputGeneralInformationFieldsDisplayed(fieldNames))
                    .as("General Information contact section input fields are not displayed").isTrue();
        }
    }

    @Then("^All Associated Party Address section (input|view) fields are displayed$")
    public void allContactAddressSectionInputFieldsAreDisplayed(String fieldsState, List<String> fieldNames) {
        SoftAssertions softAssert = new SoftAssertions();
        if (fieldsState.equalsIgnoreCase(VIEW)) {
            assertThat(contactPage.areAllViewAddressFieldsDisplayed(fieldNames))
                    .as("Address contact section view fields are not displayed").isTrue();
        } else {
            fieldNames.forEach(field -> softAssert.assertThat(contactPage.isSectionInputFieldDisplayed(ADDRESS, field))
                    .as(field + " is not displayed")
                    .isTrue());
        }
        softAssert.assertAll();
    }

    @Then("^All Associated Party Contact section (input|view) fields are displayed$")
    public void allContactContactSectionInputFieldsAreDisplayed(String fieldsState, List<String> fieldNames) {
        if (fieldsState.equalsIgnoreCase(VIEW)) {
            assertThat(contactPage.areAllViewContactFieldsDisplayed(fieldNames))
                    .as("Contact section view fields are not displayed").isTrue();
        } else {
            assertThat(contactPage.areAllInputContactFieldsDisplayed(fieldNames))
                    .as("Contact section input fields are not displayed").isTrue();
        }
    }

    @Then("Contact Address section does not contain address")
    public void contactAddressSectionDoesNotContainAddress(List<AssociatedPartyIndividualData> expectedResult) {
        List<AssociatedPartyIndividualData> actualResult = contactPage.getAddressSectionDetails();
        assertThat(actualResult).as("Create Contact's Address section section details are not expected").asList()
                .doesNotContain(expectedResult);
    }

    @Then("Associated Party Add modal contains a sub-section with fields")
    public void contactAddModalContainsASubSectionWithFields(List<String> fieldNames) {
        SoftAssert softAssert = new SoftAssert();
        fieldNames.forEach(name -> softAssert.assertTrue(contactPage.isInputFieldDisplayed(name),
                                                         name + " field is not displayed"));
        softAssert.assertAll();
    }

    @Then("Associated Party Add modal contains a sub-section with required indicator fields")
    public void contactAddModalContainsASubSectionWithRequiredIndicatorFields(List<String> fieldNames) {
        SoftAssert softAssert = new SoftAssert();
        fieldNames.forEach(name -> {
            softAssert.assertTrue(contactPage.isInputFieldDisplayed(name), name + " field is not displayed");
            softAssert.assertTrue(contactPage.isRequiredIndicatorDisplayed(name),
                                  name + " required indicator is not displayed");
        });
        softAssert.assertAll();
    }

    @Then("Associated Party Add modal contains a sub-section {string} with fields")
    public void contactAddModalContainsASubSectionWithFields(String sectionName, List<String> fieldNames) {
        SoftAssert softAssert = new SoftAssert();
        fieldNames.forEach(
                name -> softAssert.assertTrue(contactPage.isSectionInputFieldDisplayed(sectionName, name),
                                              name + " field is not displayed"));
        softAssert.assertAll();
    }

    @Then("^Associated Party Add modal contains a sub-section \"(.*)\" with (required|non required) indicator field$")
    public void contactAddModalContainsASubSectionWithRequiredIndicatorField(String sectionName, String requiredStatus,
            List<String> fieldNames) {
        SoftAssert softAssert = new SoftAssert();
        fieldNames.forEach(name -> {
            softAssert.assertTrue(contactPage.isSectionInputFieldDisplayed(sectionName, name),
                                  name + " field is not displayed");
            if (requiredStatus.equals(REQUIRED)) {
                softAssert.assertTrue(contactPage.isRequiredIndicatorDisplayed(name),
                                      name + " required indicator is not displayed");
            } else {
                softAssert.assertFalse(contactPage.isRequiredIndicatorDisplayed(name),
                                       name + " required indicator is displayed");
            }
        });
        softAssert.assertAll();
    }

    @Then("Associated Party contains a sub-section Description with input field")
    public void contactAddModalContainsDescriptionInputField() {
        assertThat(contactPage.isDescriptionInputDisplayed())
                .as("Add modal doesn't contain a sub-section Description with input field")
                .isTrue();
    }

    @Then("External User modal is displayed with data")
    public void externalUserModalIsDisplayedWithData(UserData expectedUserData) {
        if (VALUE_TO_REPLACE.equals(expectedUserData.getUsername())) {
            String email = (String) context.getScenarioContext().getContext(EMAIL_CONTEXT);
            expectedUserData.setEmail(email).setUsername(email);
        }
        if (VALUE_TO_REPLACE.equals(expectedUserData.getThirdParty())) {
            String thirdParty = (String) context.getScenarioContext().getContext(THIRD_PARTY_NAME);
            expectedUserData.setThirdParty(thirdParty);
        }
        UserData actualUserData = contactPage.getExternalUserModalData();
        assertThat(actualUserData).as("External User modal data is unexpected")
                .usingRecursiveComparison().isEqualTo(expectedUserData);
    }

    @Then("^Associated Party Contact modal is (displayed|invisible)$")
    public void addContactModalIsDisplayed(String modalState) {
        contactPage.waitWhilePreloadProgressbarIsDisappeared();
        boolean result = contactPage.isAddContactModalDisplayed();
        if (modalState.equals(INVISIBLE)) {
            assertThat(result).as("Associated Party Contact modal is displayed").isFalse();
        } else {
            assertThat(result).as("Associated Party Contact modal is not displayed").isTrue();
        }
    }

    @Then("Groups field value in Screening Criteria is default to {string}")
    public void groupsFieldValueInScreeningCriteriaIsDefaultTo(String groupValue) {
        assertTrue("Groups field default value is incorrect", contactPage.isGroupsFieldValueDisplayed(groupValue));
    }

    @Then("Screening Groups tooltip {string} is displayed")
    public void screeningGroupsTooltipIsDisplayed(String groupTooltip) {
        assertThat(contactPage.getGroupTooltipText())
                .as("Groups Tooltip is not matched on selected value")
                .isEqualTo(groupTooltip);
    }

    @Then("Edit Countries for Associated Party dropdown contains only countries for selected region")
    public void editCountriesForAssociatedPartyDropdownContainsOnlyCountriesForSelectedRegion() {
        String selectedRegionName = (String) context.getScenarioContext().getContext(SELECTED_REGION_NAME);
        List<String> selectedCountriesForRegion = getAvailableCountriesForRegion(getRegionIdByName(selectedRegionName));
        assertThat(contactPage.getCountryList())
                .as("Country list for region is unexpected")
                .isEqualTo(selectedCountriesForRegion);
    }

    @Then("All Phone Number of Contact section fields are displayed")
    public void checkPhoneNumberFieldsOfContactSection(List<String> phoneNumber) {
        assertThat(contactPage.areAllViewPhoneNumberFieldsDisplayed(phoneNumber))
                .as("All Phone Number of Contact section view fields are not displayed").isTrue();
    }

}