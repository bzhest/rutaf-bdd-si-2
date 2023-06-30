package com.refinitiv.asts.test.ui.pageActions.setUp;

import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.MyOrganisationPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.MyOrganisation;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.Pages.MY_ORGANISATION;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.enums.Status.INACTIVE;
import static java.lang.String.format;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.RandomStringUtils.randomAlphanumeric;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.numberOfElementsToBe;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated;

public class MyOrganisationPage extends BasePage<MyOrganisationPage> {

    public static final String DIVISION_NAME = "Division Name";
    public static final String DEPARTMENT_NAME = "Department Name";
    public static final String EXTERNAL_ORGANISATION_NAME = "External Organisation Name";
    public static final String ENTITY_NAME = "Entity Name";
    public static final String REGION = "Region";
    public static final String COUNTRY = "Country";
    public static final String ORGANISATION_NAME = "Organisation Name";
    public static final String LOCAL_NAME = "Local Name";
    public static final String PHONE_NUMBER = "Phone Number";
    public static final String FAX = "Fax";
    public static final String DESCRIPTION = "Description";
    public static final String ADDRESS_LINE = "Address Line";
    public static final String CITY = "City";
    public static final String ZIP_POSTAL_CODE = "Zip/Postal";
    public static final String STATE_PROVINCE = "State/Province";
    private final MyOrganisationPO myOrganisationPO;

    public MyOrganisationPage(WebDriver driver) {
        super(driver);
        this.myOrganisationPO = new MyOrganisationPO(driver);
    }

    @Override
    protected ExpectedCondition<MyOrganisationPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    public String getTextFieldValue(String fieldName) {
        waitShort.until(visibilityOfElementLocated(xpath(format(myOrganisationPO.getEditableFieldInput(), fieldName))));
        return getAttributeValue(waitMoment, xpath(format(myOrganisationPO.getEditableFieldInput(), fieldName)), VALUE);
    }

    public String getRequiredIndicatorColor(String fieldName) {
        return driver.findElement(xpath(format(myOrganisationPO.getRequiredIndicator(), fieldName))).getCssValue(COLOR);
    }

    public String getErrorMessageText(String fieldName) {
        return getElementText(xpath(format(myOrganisationPO.getFieldInputValidationMessage(), fieldName)));
    }

    public String getErrorMessageColor(String fieldName) {
        return driver.findElement(xpath(format(myOrganisationPO.getFieldInputValidationMessage(), fieldName)))
                .getCssValue(COLOR);
    }

    public List<String> getTableColumnNames() {
        return getElementsText(myOrganisationPO.getColumnNames());
    }

    public List<String> getCountryDropDownOptions(int expectedSize) {
        clickInputFieldImage(COUNTRY);
        waitLong.until(numberOfElementsToBe(myOrganisationPO.getDropDownOptions(), expectedSize));
        return getDropDownOptions(myOrganisationPO.getDropDownOptions());
    }

    public List<String> getRegionDropDownOptions(int expectedSize) {
        clickInputFieldImage(REGION);
        waitLong.until(numberOfElementsToBe(myOrganisationPO.getDropDownOptions(), expectedSize));
        return getDropDownOptions(myOrganisationPO.getDropDownOptions());
    }

    public List<MyOrganisation> getAllDisplayedOrganisations() {
        return getElements(myOrganisationPO.getRows()).stream()
                .map(row -> new MyOrganisation()
                        .setName(getElementText(row.findElement(xpath(format(myOrganisationPO.getRowColumn(), 1)))))
                        .setRegion(getElementText(row.findElement(xpath(format(myOrganisationPO.getRowColumn(), 2)))))
                        .setCountry(getElementText(row.findElement(xpath(format(myOrganisationPO.getRowColumn(), 3)))))
                        .setDateCreated(
                                getElementText(row.findElement(xpath(format(myOrganisationPO.getRowColumn(), 4)))))
                        .setLastUpdate(
                                getElementText(row.findElement(xpath(format(myOrganisationPO.getRowColumn(), 5)))))
                        .setStatus(getElementText(row.findElement(xpath(format(myOrganisationPO.getRowColumn(), 6))))))
                .collect(Collectors.toList());
    }

    public List<String> getListValuesForColumn(String columnName) {
        int columnIndex = getTableColumnNames().indexOf(columnName) + 1;
        return driver.findElements(myOrganisationPO.getRows()).stream()
                .map(row -> getElementText(
                        row.findElement(xpath(format(myOrganisationPO.getRowColumn(), columnIndex)))))
                .collect(Collectors.toList());
    }

    public List<String> getMyOrganisationFields() {
        return getElementsText(myOrganisationPO.getMyOrganisationFields());
    }

    public List<String> getMyOrganisationTabs() {
        return getElementsText(myOrganisationPO.getMyOrganisationTabs());
    }

    public String getStatus() {
        return isCheckboxChecked(myOrganisationPO.getActiveCheckbox()) ? ACTIVE.getStatus() : INACTIVE.getStatus();
    }

    public String getMyOrganisationName() {
        return getElementText(myOrganisationPO.getMyOrganisationName());
    }

    public String getMyOrganisationFieldValue(String fieldName) {
        return getElementText(xpath(format(myOrganisationPO.getFieldValue(), fieldName)));
    }

    public String getMyOrganisationInputValue(String fieldName) {
        return getElementValue(xpath(format(myOrganisationPO.getEditableFieldInput(), fieldName)));
    }

    public MyOrganisation getMyOrganisationDetails() {
        return new MyOrganisation().setName(getMyOrganisationName())
                .setLocalName(getMyOrganisationFieldValue(LOCAL_NAME))
                .setPhoneNumber(getMyOrganisationFieldValue(PHONE_NUMBER))
                .setFax(getMyOrganisationFieldValue(FAX))
                .setDescription(getMyOrganisationFieldValue(DESCRIPTION))
                .setAddressLine(getMyOrganisationFieldValue(ADDRESS_LINE))
                .setCity(getMyOrganisationFieldValue(CITY))
                .setZip(getMyOrganisationFieldValue(ZIP_POSTAL_CODE))
                .setState(getMyOrganisationFieldValue(STATE_PROVINCE))
                .setRegion(getMyOrganisationFieldValue(REGION))
                .setCountry(getMyOrganisationFieldValue(COUNTRY));
    }

    public int getPhoneCount() {
        return getPhoneInputs().size();
    }

    public List<WebElement> getPhoneInputs() {
        return driver.findElements(myOrganisationPO.getPhoneNumberInput());
    }

    @Override
    public boolean isPageLoaded() {
        return false;
    }

    public boolean isModalWithNameDisplayed(String modalName) {
        return isElementDisplayed(xpath(format(myOrganisationPO.getModalName(), modalName)));
    }

    public boolean isModalWithNameDisappeared(String modalName) {
        return isElementDisappeared(waitMoment, xpath(format(myOrganisationPO.getModalName(), modalName)));
    }

    public boolean isCancelButtonEnabled() {
        return isElementEnabled(myOrganisationPO.getCancelButton());
    }

    public boolean isSaveButtonEnabled() {
        return isElementEnabled(myOrganisationPO.getSaveButton());
    }

    public boolean isSaveAndNewButtonEnabled() {
        return isElementEnabled(myOrganisationPO.getSaveAndNewButton());
    }

    public boolean isSaveAndNewButtonDisplayed() {
        return isElementDisplayed(myOrganisationPO.getSaveAndNewButton());
    }

    public boolean isEditModalButtonDisplayed() {
        return isElementDisplayed(myOrganisationPO.getEditModalButton());
    }

    public boolean isEditIconDisplayed() {
        return isElementDisplayed(myOrganisationPO.getEditIcon());
    }

    public boolean isRequiredIndicatorDisplayedForField(String fieldName) {
        return isElementDisplayed(xpath(format(myOrganisationPO.getRequiredIndicator(), fieldName)));
    }

    public boolean isFieldInvalidAriaDisplayed(String fieldName) {
        return isElementDisplayed(xpath(format(myOrganisationPO.getFieldInputError(), fieldName)));
    }

    public boolean isFieldInputUneditable(String fieldName) {
        return !isElementDisplayed(xpath(format(myOrganisationPO.getEditableFieldInput(), fieldName)));
    }

    public boolean isInputFieldDisplayed(String fieldName) {
        return isElementDisplayed(xpath(format(myOrganisationPO.getEditableFieldInput(), fieldName)));
    }

    public boolean isRowWithNameDisplayed(String organisationName) {
        return isElementPresent(xpath(format(myOrganisationPO.getRowWithName(), organisationName)));
    }

    public boolean isAddNewButtonDisplayed() {
        return isElementDisplayed(waitShort, myOrganisationPO.getAddNewButton());
    }

    public boolean isEditButtonDisplayed(String record) {
        return isElementDisplayed(xpath(format(myOrganisationPO.getEditButton(), record)));
    }

    public boolean isDeleteButtonDisplayed(String record) {
        return isElementDisplayed(xpath(format(myOrganisationPO.getDeleteButton(), record)));
    }

    public boolean isAddPhoneButtonDisabled() {
        return isElementAttributeContains(myOrganisationPO.getAddPhoneButton(), CLASS, DISABLED);
    }

    public boolean isAddPhoneButtonDisplayed() {
        return isElementDisplayed(myOrganisationPO.getAddPhoneButton());
    }

    public boolean isRemoveIconDisplayed(int phoneCount) {
        return phoneCount == driver.findElements(myOrganisationPO.getDeletePhoneButtons()).size() + 1;
    }

    public boolean isNoMatchFoundMessageDisplayed() {
        return isElementDisplayed(myOrganisationPO.getNoMatchFoundMessage());
    }

    @Override
    public void load() {

    }

    public void navigateToMyOrganisationPage() {
        driver.get(URL + MY_ORGANISATION);
    }

    public void clickTab(String tabName) {
        clickOn(xpath(format(myOrganisationPO.getButton(), tabName)), waitLong);
    }

    public void clickAddNewButton() {
        clickOn(myOrganisationPO.getAddNewButton(), waitShort);
    }

    public void fillInDivisionFields(MyOrganisation divisionData) {
        clearAndInputField(myOrganisationPO.getNameInput(), divisionData.getName());
        fillInRegion(divisionData.getRegion());
        fillInCountry(divisionData.getCountry());
    }

    public void fillInDepartmentFields(MyOrganisation departmentData) {
        clearAndInputField(myOrganisationPO.getNameInput(), departmentData.getName());
        fillInRegion(departmentData.getRegion());
        fillInCountry(departmentData.getCountry());
        selectStatus(departmentData.getStatus());
    }

    public void fillInExternalOrganisationFields(MyOrganisation externalOrganisation) {
        clearAndInputField(myOrganisationPO.getNameInput(), externalOrganisation.getName());
        fillInRegion(externalOrganisation.getRegion());
        fillInCountry(externalOrganisation.getCountry());
        selectStatus(externalOrganisation.getStatus());
    }

    public void fillInEntityFields(MyOrganisation entityData) {
        clearAndInputField(myOrganisationPO.getNameInput(), entityData.getName());
        fillInRegion(entityData.getRegion());
        fillInCountry(entityData.getCountry());
        selectStatus(entityData.getStatus());
    }

    public void fillInOrganisationFields(MyOrganisation organisationData) {
        fillInInputField(ORGANISATION_NAME, organisationData.getName());
        fillInInputField(LOCAL_NAME, organisationData.getLocalName());
        fillInInputField(PHONE_NUMBER, organisationData.getPhoneNumber());
        fillInInputField(FAX, organisationData.getFax());
        fillInInputField(DESCRIPTION, organisationData.getDescription());
        fillInInputField(ADDRESS_LINE, organisationData.getAddressLine());
        fillInInputField(CITY, organisationData.getCity());
        fillInInputField(ZIP_POSTAL_CODE, organisationData.getZip());
        fillInInputField(STATE_PROVINCE, organisationData.getState());
        fillInRegion(organisationData.getRegion());
        fillInCountry(organisationData.getCountry());
    }

    private void selectStatus(String status) {
        if (nonNull(status) &&
                (status.equals(ACTIVE.getStatus()) && !isCheckboxChecked(myOrganisationPO.getActiveCheckbox())) ||
                (status.equals(INACTIVE.getStatus()) && isCheckboxChecked(myOrganisationPO.getActiveCheckbox()))) {
            clickWithJS(driver.findElement(myOrganisationPO.getActiveCheckbox()));
        }
    }

    public void clearAllDivisionFields() {
        clearText(myOrganisationPO.getNameInput());
        clearText(myOrganisationPO.getRegionInput());
        clearText(myOrganisationPO.getCountryInput());
    }

    public void clearAllDepartmentFields() {
        clearText(myOrganisationPO.getNameInput());
        clearText(myOrganisationPO.getRegionInput());
        clearText(myOrganisationPO.getCountryInput());
    }

    public void clearAllExternalOrganisationFields() {
        clearText(myOrganisationPO.getNameInput());
        clearText(myOrganisationPO.getRegionInput());
        clearText(myOrganisationPO.getCountryInput());
    }

    public void clearAllEntityFields() {
        clearText(myOrganisationPO.getNameInput());
        clearText(myOrganisationPO.getRegionInput());
        clearText(myOrganisationPO.getCountryInput());
    }

    private void fillInRegion(String region) {
        if (nonNull(region)) {
            clearAndFillInValueAndSelectFromDropDown(region, myOrganisationPO.getRegionInput(),
                                                     myOrganisationPO.getDropDownOption());
        }
        waitWhilePreloadProgressbarIsDisappeared();
    }

    private void fillInCountry(String country) {
        if (nonNull(country)) {
            clearAndFillInValueAndSelectFromDropDown(country, myOrganisationPO.getCountryInput(),
                                                     myOrganisationPO.getDropDownOption());
        }
    }

    private void fillInInputField(String fieldName, String value) {
        if (nonNull(value)) {
            value = value.equals(VALUE_TO_REPLACE) ? AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10) : value;
            clearAndInputField(xpath(format(myOrganisationPO.getEditableFieldInput(), fieldName)), value);
        }
    }

    public void clickSaveButton() {
        clickOn(myOrganisationPO.getSaveButton());
    }

    public void clickSaveAndNewButton() {
        clickOn(myOrganisationPO.getSaveAndNewButton());
    }

    public void clickCancelButton() {
        clickOn(myOrganisationPO.getCancelButton());
    }

    public void clickEditPageButton() {
        clickOn(myOrganisationPO.getEditModalButton(), waitShort);
    }

    public void clickBackButton() {
        clickOn(myOrganisationPO.getBackButton(), waitShort);
    }

    public void clickEditButton(String name) {
        clickOn(xpath(format(myOrganisationPO.getEditButton(), name)), waitLong);
    }

    public void clickDeleteButton(String name) {
        clickOn(xpath(format(myOrganisationPO.getDeleteButton(), name)), waitShort);
    }

    public void clickOnOrganisation(String name) {
        clickOn(xpath(format(myOrganisationPO.getRowWithText(), name)), waitShort);
    }

    public void clickInputFieldImage(String fieldName) {
        clickOn(xpath(format(myOrganisationPO.getFieldInputImage(), fieldName)));
    }

    public void clickOnColumnWithName(String columnName) {
        clickOn(xpath(format(myOrganisationPO.getColumnWithText(), columnName)));
    }

    public void clickEditIcon() {
        clickOn(myOrganisationPO.getEditIcon());
    }

    public void clearInputField(String fieldName) {
        clearText(xpath(format(myOrganisationPO.getEditableFieldInput(), fieldName)));
    }

    public void clearLastPhoneNumber() {
        List<WebElement> phoneNumbers = getPhoneInputs();
        clearText(phoneNumbers.get(phoneNumbers.size() - 1));
    }

    public void fillsInPhoneNumber(String phoneNumber) {
        List<WebElement> phoneNumbers = getPhoneInputs();
        clearAndInputField(phoneNumbers.get(phoneNumbers.size() - 1), phoneNumber);
    }

    public void clickAddPhoneButton() {
        clickOn(myOrganisationPO.getAddPhoneButton());
    }

    public void deleteAllPhones() {
        List<WebElement> deleteIcons = driver.findElements(myOrganisationPO.getDeletePhoneButtons());
        for (int i = deleteIcons.size() - 1; i >= 0; i--) {
            clickOn(deleteIcons.get(i));
        }
        clearLastPhoneNumber();
    }

}
