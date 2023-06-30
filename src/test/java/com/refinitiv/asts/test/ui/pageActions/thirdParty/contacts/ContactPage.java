package com.refinitiv.asts.test.ui.pageActions.thirdParty.contacts;

import com.refinitiv.asts.test.ui.constants.PageElementNames;
import com.refinitiv.asts.test.ui.enums.AddressFields;
import com.refinitiv.asts.test.ui.enums.Colors;
import com.refinitiv.asts.test.ui.enums.UserFields;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.contacts.ContactPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.AssociatedPartyIndividualData;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.AddressFields.*;
import static com.refinitiv.asts.test.ui.enums.ContactFields.*;
import static com.refinitiv.asts.test.ui.enums.GeneralInformationFields.*;
import static java.lang.Boolean.parseBoolean;
import static java.lang.String.format;
import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class ContactPage extends BasePage<ContactPage> {

    private final ContactPO contactPO;
    private final LanguageConfig translator;

    public ContactPage(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
        this.translator = translator;
        contactPO = new ContactPO(driver, translator);
    }

    @Override
    protected ExpectedCondition<ContactPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        waitLong.until(visibilityOfElementLocated(contactPO.getAssociatedPartyHeaderName()));
        return isElementDisplayed(waitMoment, contactPO.getAssociatedPartyBreadcrumbBackButton());
    }

    public boolean isAssociatedPartyCurrentPage() {
        return isElementDisplayedNow(contactPO.getContactProfileBackButton());
    }

    @Override
    public void load() {

    }

    public void clickContactOverviewButton() {
        waitWhilePreloadProgressbarIsDisappeared();
        waitShort.until(not(attributeContains(contactPO.getContactProfileBackButton(), CLASS, DISABLED)));
        clickOn(contactPO.getContactProfileBackButton());
    }

    public void clickSaveContactButton() {
        clickOn(contactPO.getSaveContactButton(), waitMoment);
    }

    public void clickSaveAndNewAssociatedPartyButton() {
        clickOn(contactPO.getSaveAndNewAssociatedPartyButton(), waitMoment);
    }

    public void clickSaveSectionButton(String sectionName) {
        clickSectionButton(contactPO.getSectionSaveButton(), sectionName);
    }

    public void clickEditSectionButton(String sectionName) {
        clickSectionButton(contactPO.getSectionEditButton(), sectionName);
    }

    public void clickEditContactSectionButton(String sectionName) {
        clickSectionButton(contactPO.getContactSectionEditButton(), sectionName);
    }

    public void clickCancelSectionButton(String sectionName) {
        clickSectionButton(contactPO.getSectionCancelButton(), sectionName);
    }

    private void clickSectionButton(String locator, String sectionName) {
        scrollToSection(sectionName);
        clickOn(xpath(format(locator, sectionName)), waitShort);
    }

    public boolean isSectionSaveButtonDisplayed(String sectionName) {
        return isElementDisplayed(xpath(format(contactPO.getSectionSaveButton(), sectionName)));
    }

    public boolean isSectionCancelButtonDisplayed(String sectionName) {
        return isElementDisplayed(xpath(format(contactPO.getSectionCancelButton(), sectionName)));
    }

    public void clickCloseAddContactButton() {
        clickOn(contactPO.getCancelAddContactButton(), waitMoment);
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void checkKeyPrincipalCheckbox() {
        clickOn(contactPO.getKeyPrincipalCheckbox());
    }

    public boolean isSectionBeforeOtherSection(String beforeSection, String afterSection) {
        List<WebElement> sectionList = driver.findElements(contactPO.getContactSectionsList());
        int beforeSectionIndex = getSectionIndex(sectionList, beforeSection);
        int afterSectionIndex = getSectionIndex(sectionList, afterSection);
        return afterSectionIndex - beforeSectionIndex == 1;
    }

    public boolean isSectionDisplayed(String sectionName) {
        return isElementDisplayed(xpath(format(contactPO.getSectionEntered(), sectionName)));
    }

    public boolean isSectionHidden(String sectionName) {
        return isElementDisplayed(xpath(format(contactPO.getSectionHidden(), sectionName)));
    }

    public boolean isSectionDisappeared(String sectionName) {
        return isElementDisappeared(waitShort, xpath(format(contactPO.getSectionEntered(), sectionName)));
    }

    public boolean isEnabledAsUserCheckboxChecked() {
        return isElementAttributeContains(contactPO.getEnabledAsUserCheckbox(), CLASS, MUI_CHECKED);
    }

    public boolean isFieldInvalidAriaDisplayed(String fieldName) {
        return isElementDisplayed(xpath(format(contactPO.getValidationMessage(), fieldName)));
    }

    public boolean isEmailReadOnly() {
        return parseBoolean(driver.findElement(contactPO.getEmailAddressField()).getAttribute(DISABLED));
    }

    public boolean isDescriptionTextDisplayed() {
        WebElement description = getElement(contactPO.getDescriptionInput());
        return !(description.getText().isEmpty() || description.getText().equals(DESCRIPTION));
    }

    public boolean isAddAddressButtonEnabled() {
        return isElementContainsCssValue(waitShort, contactPO.getAddAddressButton(), COLOR,
                                         Colors.BLACK.getColorRgba());
    }

    public boolean isAddAddressButtonDisabled() {
        return isElementContainsCssValue(waitShort, contactPO.getAddAddressButton(), COLOR,
                                         Colors.DARK_GREY.getColorRgba());
    }

    public boolean isFieldWithValueDisplayed(String fieldName, int fieldPosition, String value) {
        By fieldLocator =
                xpath(format(contactPO.getTextInputOnPosition(), fieldName, fieldPosition));
        return isElementDisplayed(fieldLocator) && getElement(fieldLocator).getAttribute(VALUE).equals(value);
    }

    public boolean isAddContactFieldButtonEnabled(String buttonName) {
        return isElementContainsCssValue(waitShort,
                                         xpath(format(contactPO.getContactInputFieldAddButton(), buttonName)),
                                         COLOR, Colors.BLACK_REACT.getColorRgba());
    }

    public boolean isAddContactFieldButtonDisabled(String buttonName) {
        return isElementContainsCssValue(waitShort,
                                         xpath(format(contactPO.getContactInputFieldAddButton(), buttonName)),
                                         COLOR, Colors.DARK_GREY.getColorRgba());
    }

    public boolean isAutoScreenButtonDisplayed() {
        return isElementDisplayed(contactPO.getAutoScreenSwitcher());
    }

    public boolean isKeyPrincipalCheckboxDisplayed() {
        return isElementDisplayed(contactPO.getKeyPrincipalCheckbox());
    }

    public boolean isButtonWithTextDisplayed(String buttonName) {
        return isElementDisplayed(xpath(format(contactPO.getButtonWithText(), buttonName)));
    }

    public boolean isEnabledAsUserCheckboxDisplayed() {
        return isElementDisplayed(contactPO.getEnabledAsUserCheckbox());
    }

    public boolean isEditSectionButtonDisplayed(String sectionName) {
        return isElementDisplayed(xpath(format(contactPO.getSectionEditButton(), sectionName)));
    }

    public boolean isGroupsFieldValueDisplayed(String groupsValue) {
        return getElement(contactPO.getGroupsInput()).getAttribute(VALUE).equals(groupsValue);
    }

    public void selectGroup(int value) {
        clickOn(contactPO.getGroupsInput(), waitShort);
        clickOn(waitMoment.until(visibilityOfAllElementsLocatedBy((contactPO.getDropDownOptions()))).get(value));
    }

    public void hoverScreeningGroups() {
        hoverOverElement(contactPO.getSelectedGroups());
    }

    public String getGroupTooltipText() {
        return getElementText(contactPO.getTooltip());
    }

    /**
     * =================================================================================================================
     * Retrieve contact's profile details steps
     * =================================================================================================================
     */

    public List<String> getSectionFields(String sectionName) {
        return getElementsText(xpath(format(contactPO.getSectionFieldName(), sectionName)))
                .stream()
                .map(c -> StringUtils.removeEnd(c, REQUIRED_INDICATOR))
                .map(StringUtils::strip)
                .collect(Collectors.toList());
    }

    public AssociatedPartyIndividualData getGeneralInformationSectionDetails() {
        return new AssociatedPartyIndividualData().setTitle(getGeneralInformationValue(TITLE.getName()))
                .setFirstName(getGeneralInformationValue(FIRST_NAME.getName()))
                .setLastName(getGeneralInformationValue(LAST_NAME.getName()))
                .setMiddleName(getGeneralInformationValue(MIDDLE_NAME.getName()));
    }

    public List<AssociatedPartyIndividualData> getAddressSectionDetails() {
        return IntStream.rangeClosed(1, getElements(contactPO.getAddressDividers()).size() + 1)
                .mapToObj(i -> new AssociatedPartyIndividualData()
                        .setAddressLine(getAddressDetailsValue(ADDRESS_LINE.getName(), i))
                        .setCity(getAddressDetailsValue(CITY.getName(), i))
                        .setZipCode(getAddressDetailsValue(ZIP_POSTAL_CODE.getName(), i))
                        .setStateProvince(getAddressDetailsValue(STATE_PROVINCE.getName(), i))
                        .setRegion(getAddressDetailsValue(REGION.getName(), i))
                        .setAddressCountry(getAddressDetailsValue(AddressFields.COUNTRY.getName(), i))
                ).collect(Collectors.toList());
    }

    public List<AssociatedPartyIndividualData> getContactSectionDetails() {
        int phoneNumberSize = getElements(format(contactPO.getContactInputField(), PHONE_NUMBER.getName())).size();
        int faxSize = getElements(format(contactPO.getContactInputField(), FAX.getName())).size();
        int websiteSize = getElements(format(contactPO.getContactInputField(), WEBSITE.getName())).size();
        return IntStream.rangeClosed(1, NumberUtils.max(phoneNumberSize, faxSize, websiteSize))
                .mapToObj(i -> new AssociatedPartyIndividualData()
                        .setPhoneNumber(i <= phoneNumberSize ? getContactValue(PHONE_NUMBER.getName(), i) : null)
                        .setFax(i <= faxSize ? getContactValue(FAX.getName(), i) : null)
                        .setWebsite(i <= websiteSize ? getContactValue(WEBSITE.getName(), i) : null)
                        .setEmailAddress(i == 1 ? getContactValue(EMAIL_ADDRESS.getName()) : null))
                .collect(Collectors.toList());
    }

    public AssociatedPartyIndividualData getContactInformationDetails() {
        return new AssociatedPartyIndividualData().setFirstName(getGeneralInformationValue(FIRST_NAME.getName()))
                .setLastName(getGeneralInformationValue(LAST_NAME.getName()))
                .setEmailAddress(getContactValue(EMAIL_ADDRESS.getName()))
                .setAddressCountry(getAddressDetailsValue(AddressFields.COUNTRY.getName(), 1));
    }

    private String getGeneralInformationValue(String fieldName) {
        By textElement = xpath(format(contactPO.getGeneralInformationFieldValue(), fieldName));
        return getAttributeValue(textElement, VALUE);
    }

    private String getContactValue(String fieldName) {
        return getContactValue(fieldName, 1);
    }

    private String getContactValue(String fieldName, int contactFieldPosition) {
        List<WebElement> textElement = getElements(xpath(format(contactPO.getContactFieldValue(), fieldName)));
        return getAttributeValue(textElement.get(contactFieldPosition - 1), VALUE);
    }

    public String getAddressDetailsValue(String fieldName, int addressPosition) {
        WebElement addressElement = getElements(xpath(format(contactPO.getAddressDetailsValue(), fieldName)))
                .get(addressPosition - 1);
        scrollIntoView(addressElement);
        String text = getAttributeOrText(addressElement, VALUE);
        return isNull(text) || text.equals(fieldName) ? null : text;
    }

    public List<String> openAndGetSearchCriteriaDropDownListValues(String countryType) {
        List<WebElement> dropDownList;
        switch (countryType) {
            case NATIONALITY:
                dropDownList = getDropDownCountriesList(contactPO.getScreeningCitizenship(),
                                                        contactPO.getDropDownOptions());
                break;
            case PLACE_OF_BIRTH:
                dropDownList = getDropDownCountriesList(contactPO.getScreeningPlaceOfBirth(),
                                                        contactPO.getDropDownOptions());
                break;
            default:
                throw new IllegalArgumentException("Country type - " + countryType + " is not supported!");

        }
        return getElementsText(dropDownList);
    }

    private List<WebElement> getDropDownCountriesList(By dropDownButton, By countriesList) {
        clickOn(dropDownButton);
        waitShort.until(visibilityOfElementLocated(countriesList));
        return driver.findElements(countriesList);
    }

    /**
     * =================================================================================================================
     * Create/Edit contact steps
     * =================================================================================================================
     */
    public void fillInAllMandatoryContactData(AssociatedPartyIndividualData contactTestData) {
        enterFirstName(contactTestData.getFirstName());
        enterLastName(contactTestData.getLastName());
        enterEmail(contactTestData.getEmailAddress());
    }

    public void fillInProfileGeneralInformation(AssociatedPartyIndividualData associatedPartyIndividualData) {
        scrollIntoView(
                xpath(format(contactPO.getSection(), translator.getValue("thirdPartyInformation.generalInformation"))));
        clearAndInputTextField(TITLE.getName(), associatedPartyIndividualData.getTitle(), contactPO.getTextInput());
        clearAndInputTextField(FIRST_NAME.getName(), associatedPartyIndividualData.getFirstName(),
                               contactPO.getTextInput());
        clearAndInputTextField(LAST_NAME.getName(), associatedPartyIndividualData.getLastName(),
                               contactPO.getTextInput());
        clearAndInputTextField(MIDDLE_NAME.getName(), associatedPartyIndividualData.getMiddleName(),
                               contactPO.getTextInput());
    }

    public void scrollToSection(String section) {
        scrollIntoView(xpath(format(contactPO.getSection(), section)));
    }

    public void fillInAddressDetails(int addressPosition, AssociatedPartyIndividualData associatedPartyIndividualData) {
        String address = translator.getValue("associatedParties.address");
        scrollIntoView(xpath(format(contactPO.getSection(), address)));
        if (isSectionHidden(address)) {
            clickOnCollapseElapseButton(address);
        }
        fillInAddressLine(addressPosition, associatedPartyIndividualData.getAddressLine());
        fillInCity(addressPosition, associatedPartyIndividualData.getCity());
        fillInZipCode(addressPosition, associatedPartyIndividualData.getZipCode());
        fillInStateProvince(addressPosition, associatedPartyIndividualData.getStateProvince());
        selectRegion(addressPosition, associatedPartyIndividualData.getRegion());
        selectContactAddressCountry(addressPosition, associatedPartyIndividualData.getAddressCountry());
    }

    public void fillInProfileContact(AssociatedPartyIndividualData associatedPartyIndividualData) {
        scrollIntoView(xpath(format(contactPO.getSection(), translator.getValue("addThirdParty.contactSection"))));
        clearAndInputTextField(PHONE_NUMBER.getName(), associatedPartyIndividualData.getPhoneNumber(),
                               contactPO.getTextInput());
        clearAndInputTextField(FAX.getName(), associatedPartyIndividualData.getFax(), contactPO.getTextInput());
        clearAndInputTextField(WEBSITE.getName(), associatedPartyIndividualData.getWebsite(), contactPO.getTextInput());
        clearAndInputTextField(EMAIL_ADDRESS.getName(), associatedPartyIndividualData.getEmailAddress(),
                               contactPO.getTextInput());
    }

    private void fillInAddressLine(int addressPosition, String addressLine) {
        if (nonNull(addressLine)) {
            WebElement addressInput = getElements(contactPO.getAddressLine()).get(addressPosition - 1);
            clearAndInputField(addressInput, addressLine);
        }
    }

    public void fillInDescription(String text) {
        clearAndInputField(contactPO.getDescriptionInput(), text);
    }

    private void fillInCity(int addressPosition, String city) {
        if (nonNull(city)) {
            WebElement cityInput = getElements(contactPO.getCity()).get(addressPosition - 1);
            clearAndInputField(cityInput, city);
        }
    }

    private void fillInZipCode(int addressPosition, String zipCode) {
        if (nonNull(zipCode)) {
            WebElement zipCodeInput = getElements(contactPO.getZipPostalCode()).get(addressPosition - 1);
            clearAndInputField(zipCodeInput, zipCode);
        }
    }

    private void fillInStateProvince(int addressPosition, String stateProvince) {
        if (nonNull(stateProvince)) {
            WebElement stateProvinceInput = getElements(contactPO.getStateProvince()).get(addressPosition - 1);
            clearAndInputField(stateProvinceInput, stateProvince);
        }
    }

    public void fillScreeningCitizenship(String countryValue) {
        if (Objects.nonNull(countryValue)) {
            clearAndFillInValueAndSelectFromDropDown(countryValue, contactPO.getScreeningCitizenship());
        }
    }

    public void fillScreeningPlaceOfBirth(String countryValue) {
        if (Objects.nonNull(countryValue)) {
            clearAndFillInValueAndSelectFromDropDown(countryValue, contactPO.getScreeningPlaceOfBirth());
        }
    }

    public void enterEmail(String emailAddress) {
        if (nonNull(emailAddress)) {
            if (isSectionHidden(getFromDictionaryIfExists("addThirdParty.contactSection"))) {
                clickOnCollapseElapseButton(getFromDictionaryIfExists("addThirdParty.contactSection"));
            }
            clearInputAndEnterField(contactPO.getEmailAddressField(), emailAddress);
        }
    }

    public void enterLastName(String lastName) {
        clearAndInputField(contactPO.getLastNameField(), lastName);
    }

    public void enterFirstName(String firstName) {
        waitShort.until(visibilityOfElementLocated(contactPO.getFirstNameField()));
        clearAndInputField(contactPO.getFirstNameField(), firstName);
    }

    public String getErrorMessageText(String fieldName) {
        return getElementText(xpath(format(contactPO.getValidationMessage(), fieldName)));
    }

    public String getErrorMessageElementCSS(String fieldName, String attribute) {
        return driver.findElement(xpath(format(contactPO.getValidationMessage(), fieldName))).getCssValue(attribute);
    }

    public String getDescriptionText() {
        return getElementText(contactPO.getDescriptionInput());
    }

    public boolean isAddAddressButtonHidden() {
        return isElementInvisible(waitShort, contactPO.getAddAddressButton());
    }

    public boolean isCheckTypeChecked(String checkTypeName) {
        return getAttributeValue(xpath(format(contactPO.getCheckType(), checkTypeName)), CLASS).contains(MUI_CHECKED);
    }

    public void clickCheckTypeCheckbox(String checkTypeName) {
        clickOn(xpath(format(contactPO.getCheckType(), checkTypeName)));
    }

    public boolean isOngoingScreeningUnChecked(String ongoingName) {
        By ongoingScreeningLocator =
                By.xpath(format(contactPO.getOngoingScreening(), ongoingName));
        return getAttributeValue(ongoingScreeningLocator, CLASS).contains(MUI_CHECKED);
    }

    public void clickOngoingScreening(String ongoingName) {
        clickOn(xpath(format(contactPO.getOngoingScreening(), ongoingName)));
    }

    public boolean isRecipientsUserChecked(String recipient) {
        By recipientsUserLocator =
                By.xpath(format(contactPO.getRecipientsUser(), recipient));
        return getAttributeValue(recipientsUserLocator, CLASS).contains(MUI_CHECKED);
    }

    public String getElementErrorMessage(String fieldName) {
        return getElementText(xpath(format(contactPO.getInputFieldErrorMessage(), fieldName)));
    }

    public boolean isContactSectionFieldInvalidAriaDisplayed(String fieldName) {
        return driver.findElement(xpath(format(contactPO.getContactFieldValue(), fieldName)))
                .getAttribute(ARIA_INVALID)
                .equals(Boolean.toString(true));
    }

    public String getContactSectionElementErrorMessage(String fieldName) {
        return getElementText(xpath(format(contactPO.getInputContactSectionFieldErrorMessage(), fieldName)));
    }

    public String getContactSectionErrorMessageElementCSS(String fieldName, String cssValue) {
        return driver.findElement(xpath(format(contactPO.getInputContactSectionFieldErrorMessage(), fieldName)))
                .getCssValue(cssValue);
    }

    public String getScreeningCriteriaSectionElementErrorMessage(String fieldName) {
        return getElementText(
                xpath(format(contactPO.getInputScreeningCriteriaSectionFieldErrorMessage(), fieldName)));
    }

    public String getScreeningCriteriaSectionErrorMessageColor(String fieldName, String color) {
        return driver.findElement(
                        xpath(format(contactPO.getInputScreeningCriteriaSectionFieldErrorMessage(), fieldName)))
                .getCssValue(color);
    }

    public String getDropDownValue(String name) {
        return getAttributeValue(xpath(format(contactPO.getInputScreeningCriteriaSectionField(), name)), VALUE);
    }

    public boolean isSearchTermValueDisplayed(String searchTerm) {
        By searchTermLocator =
                By.xpath(format(contactPO.getSearchTermInput(), searchTerm));
        return isElementDisplayed(waitLong, searchTermLocator);
    }

    public void updateSearchTermValue(String currentValue, String newValue) {
        WebElement columnElement = getElementByXPath(format(contactPO.getSearchTermInput(), currentValue));
        clickOn(columnElement);
        clearText(columnElement);
        columnElement.sendKeys(newValue);
    }

    public void clearFirstNameValue(String currentValue) {
        WebElement columnElement = getElementByXPath(format(contactPO.getFirstNameInput(), currentValue));
        clearText(columnElement);
    }

    public void clearLastNameValue(String currentValue) {
        WebElement columnElement = getElementByXPath(format(contactPO.getLastNameInput(), currentValue));
        clearText(columnElement);
    }

    public void fillInScreeningCriteriaCitizenship(String country) {
        clearAndFillInValueAndSelectFromDropDown(country, contactPO.getScreeningCitizenship());
    }

    public void fillInScreeningCriteriaCountryOfLocation(String country) {
        clearAndFillInValueAndSelectFromDropDown(country, contactPO.getScreeningCountryOfLocation());
    }

    public void fillInScreeningCriteriaPlaceOfBirth(String country) {
        clearAndFillInValueAndSelectFromDropDown(country, contactPO.getScreeningPlaceOfBirth());
    }

    public void fillInNotificationRecipients(String recipient) {
        clearAndFillInValueAndSelectFromDropDown(recipient, contactPO.getScreeningNotificationRecipients());
    }

    public void selectAutoScreen(Boolean isEnableAutoScreen) {
        if (isEnableAutoScreen) {
            clickAutoScreenONButton();
        } else {
            clickAutoScreenOFFButton();
        }
    }

    public void clickAutoScreenOFFButton() {
        if (getElement(contactPO.getAutoScreenSwitcher()).getAttribute(CLASS).contains(MUI_CHECKED)) {
            clickOn(contactPO.getAutoScreenSwitcher(), waitMoment);
        }
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void clickAutoScreenONButton() {
        if (!getElement(contactPO.getAutoScreenSwitcher()).getAttribute(CLASS).contains(MUI_CHECKED)) {
            clickOn(contactPO.getAutoScreenSwitcher(), waitMoment);
        }
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void clickRemoveContactField(String fieldName, int contactPosition) {
        WebElement contactFieldDeleteButton =
                getElements(waitShort, xpath(format(contactPO.getContactFieldDeleteButton(), fieldName)))
                        .get(contactPosition - 1);
        clickOn(contactFieldDeleteButton);
    }

    public void selectContactAddressCountry(int countryPosition, String countryName) {
        if (nonNull(countryName) && !countryName.isEmpty()) {
            if (isSectionHidden(ADDRESS)) {
                clickOnCollapseElapseButton(ADDRESS);
            }
            clearAndFillInValueAndSelectFromDropDown(countryName,
                                                     getElements(contactPO.getAddressCountryInput())
                                                             .get(countryPosition - 1));
        }
    }

    private void clearAndInputTextField(String elementName, String value, String inputPath) {
        if (nonNull(value) && !value.isEmpty()) {
            WebElement inputElement = driver.findElement(xpath(format(inputPath, elementName)));
            clearInputAndEnterField(inputElement, value);
        }
    }

    private void selectRegion(int regionPosition, String region) {
        if (nonNull(region) && !region.isEmpty()) {
            clearAndFillInValueAndSelectFromDropDown(region,
                                                     getElements(contactPO.getAddressRegionInput())
                                                             .get(regionPosition - 1));
        }
    }

    public void clickOnCollapseElapseButton(String sectionName) {
        clickOn(xpath(format(contactPO.getCollapseElapseButton(), sectionName)));
    }

    public void clickEnabledAsUserCheckbox() {
        clickOn(contactPO.getEnabledAsUserCheckbox());
    }

    public void clickViewExternalUserButton() {
        clickOn(contactPO.getViewExternalUserButton(), waitShort);
    }

    public void clickAddAddressButton() {
        clickOn(contactPO.getAddAddressButton(), waitShort);
    }

    public void clickRemoveAddressButton(int addressPosition) {
        clickOn(xpath(format(contactPO.getRemoveAddressButton(), addressPosition)), waitShort);
    }

    public void fillInContactSectionField(String fieldName, int fieldPosition, String value) {
        clearAndInputField(
                xpath(format(contactPO.getTextInputOnPosition(), fieldName, fieldPosition)),
                value);
    }

    public void clickAddContactField(String buttonName) {
        clickOn(xpath(format(contactPO.getContactInputFieldAddButton(), buttonName)));
    }

    public void clickCancelExternalUserModal() {
        clickOn(contactPO.getCancelExternalUserModal(), waitMoment);
    }

    public void clickResetPassword() {
        clickOn(contactPO.getResetPassword(), waitShort);
    }

    private String getExternalUserValue(String fieldName) {
        By externalUserField = xpath(format(contactPO.getExternalUserFieldValue(), fieldName));
        return getAttributeValue(externalUserField, VALUE);
    }

    public UserData getExternalUserModalData() {
        return UserData.builder()
                .firstName(getExternalUserValue(UserFields.FIRST_NAME.getName()))
                .email(getExternalUserValue(UserFields.EMAIL.getName()))
                .position(getExternalUserValue(UserFields.POSITION.getName()))
                .lastName(getExternalUserValue(UserFields.LAST_NAME.getName()))
                .username(getExternalUserValue(UserFields.USER_NAME.getName()))
                .userType(getExternalUserValue(UserFields.USER_TYPE.getName()))
                .thirdParty(getExternalUserValue(PageElementNames.THIRD_PARTY)).build();
    }

    public boolean areAllInputGeneralInformationFieldsDisplayed(List<String> fieldNames) {
        return areAllFieldsDisplayed(fieldNames, contactPO.getGeneralInformationInputField());
    }

    public boolean areAllViewGeneralInformationFieldsDisplayed(List<String> fieldNames) {
        return areAllFieldsDisplayed(fieldNames, contactPO.getGeneralInformationViewField());
    }

    public boolean areAllViewAddressFieldsDisplayed(List<String> fieldNames) {
        return areAllFieldsDisplayed(fieldNames, contactPO.getAddressViewField());
    }

    public boolean areAllInputContactFieldsDisplayed(List<String> fieldNames) {
        return areAllFieldsDisplayed(fieldNames, contactPO.getContactInputField());
    }

    public boolean areAllViewContactFieldsDisplayed(List<String> fieldNames) {
        return areAllFieldsDisplayed(fieldNames, contactPO.getContactViewField());
    }

    public boolean isInputFieldDisplayed(String field) {
        return isElementDisplayed(xpath(format(contactPO.getInputField(), field)));
    }

    public boolean isSectionInputFieldDisplayed(String sectionName, String field) {
        if (field.equals(REGION.getName()) || field.equals(AddressFields.COUNTRY.getName())) {
            return isElementDisplayed(
                    xpath(format(contactPO.getSectionDropdownFieldInput(), sectionName, field)));
        } else {
            return isElementDisplayed(
                    xpath(format(contactPO.getSectionFieldInput(), sectionName, field)));
        }
    }

    public boolean isRequiredIndicatorDisplayed(String field) {
        return isElementDisplayed(xpath(format(contactPO.getRequiredIndicator(), field)));
    }

    public boolean isDescriptionInputDisplayed() {
        return isElementDisplayed(contactPO.getDescriptionInput());
    }

    private int getSectionIndex(List<WebElement> sectionList, String sectionText) {
        int index = 0;
        for (int i = 0; i < sectionList.size(); i++) {
            if (sectionList.get(i).getText().contains(sectionText)) {
                logger.info(sectionText + " section index: " + i);
                return i;
            }
        }
        return index;
    }

    public boolean isAddContactModalDisplayed() {
        return isElementDisplayed(waitShort, contactPO.getAddContactModal());
    }

    public String getContactIdFromUrl() {
        return StringUtils.substringBetween(driver.getCurrentUrl(), "associated-parties/", "/view");
    }

    public List<String> getCountryList() {
        clickOn(contactPO.getAddressCountryInput());
        return getDropDownOptions(contactPO.getDropDownOptions());
    }

    public boolean areAllViewPhoneNumberFieldsDisplayed(List<String> phoneNumber) {
        return areAllFieldsDisplayed(phoneNumber, contactPO.getContactPhoneNumberViewField());
    }

}
