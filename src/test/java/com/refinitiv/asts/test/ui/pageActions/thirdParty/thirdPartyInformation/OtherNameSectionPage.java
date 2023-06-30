package com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.constants.TestConstants;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation.OtherNameSectionPO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.REACT_FORMAT;
import static com.refinitiv.asts.test.ui.utils.DateUtil.getDateFromStringDate;
import static java.lang.Boolean.parseBoolean;
import static java.lang.String.format;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class OtherNameSectionPage extends BasePage<OtherNameSectionPage> {

    private final OtherNameSectionPO otherNamePO;

    public OtherNameSectionPage(WebDriver driver, ScenarioCtxtWrapper context, LanguageConfig translator) {
        super(driver, context, translator);
        otherNamePO = new OtherNameSectionPO(driver, translator);
    }

    @Override
    protected ExpectedCondition<OtherNameSectionPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return false;
    }

    @Override
    public void load() {

    }

    public boolean isOtherNameElementDisplayed(String elementName) {
        return isElementDisplayed(waitLong, getElementLocatorByName(elementName));
    }

    public boolean isOtherNameElementDisappeared(String elementName) {
        return isElementDisappeared(waitMoment, getElementLocatorByName(elementName));
    }

    public boolean isFieldInvalidAriaDisplayed(String elementName) {
        WebElement element = driver.findElement(xpath(format(otherNamePO.getInputField(), elementName)));
        return element.getAttribute(ARIA_INVALID).equals(Boolean.toString(true));
    }

    public boolean isEditButtonDisplayed(String editButton) {
        waitWhilePreloadProgressbarIsDisappeared();
        hoverToOtherNameGroup();
        return isElementDisplayed(xpath(format(otherNamePO.getOtherNameEdit(), editButton)));
    }

    public boolean isScreeningButtonDisplayed(String editButton) {
        return isElementDisplayed(xpath(format(otherNamePO.getOtherNameScreen(), editButton)));
    }

    public boolean isDeleteButtonDisplayed(String elementText) {
        hoverToOtherNameGroup();
        return isElementDisplayed(xpath(format(otherNamePO.getOtherNameDelete(), elementText)));
    }

    public boolean isRequireIndicatorDisplayed(String elementName) {
        By otherNameFieldLocator;
        switch (elementName) {
            case NAME:
                otherNameFieldLocator = otherNamePO.getInputFieldName();
                break;
            case NAME_TYPE:
                otherNameFieldLocator = otherNamePO.getInputNameTypeField();
                break;
            default:
                throw new IllegalArgumentException(
                        "Element: " + elementName + " is unexpected for required field verification");
        }
        return isAttributePresent(otherNameFieldLocator, REQUIRED);
    }

    public boolean isInputFieldWithNameDisplayed(String elementText) {
        return isElementDisplayed(waitShort, xpath(format(otherNamePO.getInputField(), elementText)));
    }

    public boolean isDropDownForFieldWithNameDisplayed(String countryType) {
        return isElementDisplayed(xpath(format(otherNamePO.getOpenDropDownButton(), countryType)));
    }

    public boolean isDropDownOptionWithTextDisabled(String selectedOptionText) {
        WebElement inputField =
                driver.findElement(xpath(format(otherNamePO.getDropDownValueWithText(), selectedOptionText)));
        return inputField.getAttribute(ARIA_SELECTED).equals(Boolean.toString(true));
    }

    public String getInputFieldErrorText(String fieldName) {
        return getElementText(xpath(format(otherNamePO.getFieldError(), fieldName)));
    }

    public boolean isOtherNameRowPresent(String elementText) {
        scrollIntoBottomView(xpath(otherNamePO.getOtherNamesSection()));
        return isElementPresent(waitLong, xpath(format(otherNamePO.getOtherNameRow(), elementText)));
    }

    public boolean isOtherNameRowDisappeared(String rowName) {
        return isElementDisappeared(waitShort, xpath(format(otherNamePO.getOtherNameRow(), rowName)));
    }

    public String getInputFieldValue(String fieldName) {
        return driver.findElement(xpath(format(otherNamePO.getInputField(), fieldName))).getAttribute(VALUE);
    }

    public String getErrorMessageElementCSS(String fieldName, String cssValue) {
        return driver.findElement(xpath(format(otherNamePO.getFieldError(), fieldName))).getCssValue(cssValue);
    }

    public void clickOn(String elementName) {
        clickOn(getElementLocatorByName(elementName), waitLong);
    }

    public void clickEditOtherNameButton(String elementText) {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        hoverToOtherNameGroup();
        clickOn(xpath(format(otherNamePO.getOtherNameEdit(), elementText)));
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void clickDeleteOtherNameButton(String elementText) {
        hoverToOtherNameGroup();
        clickOn(xpath(format(otherNamePO.getOtherNameDelete(), elementText)), waitShort);
    }

    public void clickDeleteOtherNameModalCancelButton() {
        clickOn(otherNamePO.getDeleteOtherNameModalCancelButton(), waitShort);
    }

    public void clickDeleteOtherNameModalProceedButton() {
        clickOn(otherNamePO.getDeleteOtherNameModalProceedButton(), waitShort);
    }

    public boolean isDeleteOtherNameModalOpened() {
        return isElementDisplayed(waitShort, otherNamePO.getDeleteOtherNameModalBody()) &&
                isElementDisplayed(otherNamePO.getDeleteOtherNameModalCancelButton()) &&
                isElementDisplayed(otherNamePO.getDeleteOtherNameModalProceedButton());
    }

    public boolean isDeleteOtherNameModalClosed() {
        return isElementDisappeared(waitShort, otherNamePO.getDeleteOtherNameModalBody());
    }

    public String getDeleteOtherNameModalBodyText() {
        return getElementText(waitShort, otherNamePO.getDeleteOtherNameModalBody());
    }

    public void clickScreenOtherNameScreenIcon(String elementText) {
        clickOn(xpath(format(otherNamePO.getOtherNameScreen(), elementText)), waitLong);
    }

    public boolean isScreenOtherNameScreenIconIsDisplay() {
        return isElementDisplayed(otherNamePO.getOtherNameScreenIcon());
    }

    public List<String> getOtherNameColumnValuesList(String columnName) {
        String columnHeaderText =
                getElementText(waitShort, xpath(format(otherNamePO.getOtherNameColumn(), columnName)));
        List<WebElement> otherNameTableHeaderList = driver.findElements(otherNamePO.getOtherNamesTableColumnNameList());
        List<String> columnsHeadersText = getElementsText(otherNameTableHeaderList);
        int index = columnsHeadersText.indexOf(columnHeaderText);
        String valuesPath = format(otherNamePO.getOtherNameColumnValues(), index + 1);
        List<WebElement> tableRows = driver.findElements(xpath(valuesPath));
        return getElementsText(tableRows);
    }

    public void fillInInputField(String fieldName, String inputString) {
        clearAndInputField(xpath(format(otherNamePO.getInputField(), fieldName)), inputString);
    }

    public void fillNameField(String inputString) {
        clickOn(waitLong.until(visibilityOfElementLocated(otherNamePO.getInputFieldName())));
        clearAndInputField(otherNamePO.getInputFieldName(), inputString);
    }

    public void fillNameTypeField(String type) {
        clearAndFillInValueAndSelectFromDropDown(type, otherNamePO.getOpenNameTypeList(),
                                                 otherNamePO.getDropDownOption());
    }

    public void selectCountry(String countryType, String inputString) {
        clearAndInputField(xpath(format(otherNamePO.getInputField(), countryType)), inputString);
        clickOn(otherNamePO.getFirstDropDownOption());
    }

    public void clickOnOpenDropDown(String elementText) {
        clickOn(xpath(format(otherNamePO.getOpenDropDownButton(), elementText)));
    }

    public void clickCloseDropDown(String elementText) {
        By closeDropDownLocator = xpath(format(otherNamePO.getCloseDropDownButton(), elementText));
        if (isElementDisplayed(closeDropDownLocator)) {
            clickOn(closeDropDownLocator);
        }
    }

    public void clickOnClearDropDown(String elementText) {
        clickOn(xpath(format(otherNamePO.getClearDropDownButton(), elementText)));
    }

    public void clearInputField(String elementName) {
        clearText(xpath(format(otherNamePO.getInputField(), elementName)));
    }

    public void clickOnInputField(String elementName) {
        clickOn(xpath(format(otherNamePO.getInputField(), elementName)));
    }

    public List<String> getOtherNamesTableColumnNames() {
        return getElementsText(
                waitShort.until(numberOfElementsToBeMoreThan(otherNamePO.getOtherNamesTableColumnNameList(), 1)));
    }

    public List<String> getOtherNamesTableColumnValues() {
        scrollToTop(getElementByXPath(otherNamePO.getOtherNameTable()));
        return getElementsText(waitShort, getElements(otherNamePO.getOtherNamesTableColumnValuesList()));
    }

    public List<String> getDropDownListValues(String dropDownName) {
        try {
            return getElementsText(driver.findElements(otherNamePO.getDropDownOptions()));
        } catch (StaleElementReferenceException e) {
            clickOnOpenDropDown(dropDownName);
            return getElementsText(driver.findElements(otherNamePO.getDropDownOptions()));
        }
    }

    public List<String> getCheckTypeOptions() {
        return getElementsText(driver.findElements(xpath(otherNamePO.getCheckTypeOptions())));
    }

    public List<Date> getDateCreatedListValues() {
        return getElementsText(getElements(otherNamePO.getOtherNamesTableCreateDateValuesList())).stream()
                .map(dateText -> getDateFromStringDate(dateText, REACT_FORMAT)).collect(
                        Collectors.toList());
    }

    public boolean isCheckTypeChecked(String checkTypeName) {
        return getAttributeValue(xpath(format(otherNamePO.getCheckTypeSpan(), checkTypeName)), CLASS)
                .contains(TestConstants.CHECKED);
    }

    public boolean isCheckTypeDisabled(String checkTypeName) {
        return parseBoolean(
                getAttributeValue(xpath(format(otherNamePO.getCheckTypeSpan(), checkTypeName)), ARIA_DISABLED));
    }

    public void clickCheckTypeCheckbox(String checkTypeName) {
        clickOn(xpath(format(otherNamePO.getCheckType(), checkTypeName)), waitMoment);
    }

    private By getElementLocatorByName(String elementName) {
        switch (elementName) {
            case OTHER_NAME_ADD_SAVE_BUTTON:
            case ADD_BUTTON:
                return otherNamePO.getOtherNamesSubmitButton();
            case ADD_CANCEL_BUTTON:
                return otherNamePO.getCancelOtherNameButton();
            case OTHER_NAMES_SECTION:
                return xpath(otherNamePO.getOtherNamesSection());
            case OTHER_NAME_TABLE:
                return xpath(otherNamePO.getOtherNameTable());
            default:
                throw new RuntimeException("Unsupported web element " + elementName);
        }
    }

    public Boolean isCheckTypeLabelDisplayed(String checkTypeLabel) {
        return isElementDisplayed(waitLong, xpath(format(otherNamePO.getCheckTypeLabel(), checkTypeLabel)));
    }

    public Boolean isCheckTypeIsSelected(String checkTypeName) {
        return isCheckboxChecked(xpath(format(otherNamePO.getScreenCheckType(), checkTypeName)));
    }

    public void clickOnMediaCheckRecord(int record) {
        clickOn(xpath(format(otherNamePO.getMediaCheckScreeningRecord(), record)));
    }

    public boolean isFieldEnabled(String elementText) {
        return isElementEnabled(xpath(format(otherNamePO.getInputField(), elementText)));
    }

    public boolean isCheckboxCheckTypeEnabled(String elementText) {
        return isElementEnabled(xpath(format(otherNamePO.getCheckBoxCheckType(), elementText)));
    }

    public boolean isOtherNameGroupNameDisplayed(String groupsValue) {
        return getElement(otherNamePO.getOtherNameGroupsName()).getAttribute(VALUE).equals(groupsValue);
    }

    public void selectOtherNameGroup(int value) {
        clickOn(otherNamePO.getOtherNameGroupsInput(), waitShort);
        clickOn(waitMoment.until(visibilityOfAllElementsLocatedBy((otherNamePO.getDropDownOptions()))).get(value));
    }

    public void hoverToOtherNameGroup() {
        hoverOverElement(otherNamePO.getOtherNameGroupsName());
    }

    public String getOtherNameGroupTooltip() {
        return getElementText(otherNamePO.getTooltip());
    }

    public boolean isOtherNameGroupsFieldDisabled() {
        return isElementAttributeContains(otherNamePO.getOtherNameGroupsInput(), CLASS, MUI_DISABLED);
    }

    public String getOtherNameGroupsValue() {
        return getAttributeValue(otherNamePO.getOtherNameGroupsInput(), VALUE);
    }

    public void hoverToOtherNameGroupsDropDown(int value) {
        clickOn(otherNamePO.getOtherNameGroupsInput(), waitShort);
        hoverOverElement(
                waitMoment.until(visibilityOfAllElementsLocatedBy((otherNamePO.getDropDownOptions()))).get(value));
    }

    public String getOtherNameGroupsDropDownTooltip() {
        return getElementText(otherNamePO.getTooltip());
    }

    public String getGroupsValue() {
        return getAttributeValue(otherNamePO.getAssociatedOrgOtherNameGroupsInput(), VALUE);
    }

    public String getOtherNameLastScreeningDateText() {
        return getElementText(otherNamePO.getOtherNameLastScreeningDate());
    }

    public boolean isOtherNameNoMatchFoundMessageDisplayed() {
        waitWhilePreloadProgressbarIsDisappeared();
        return isElementDisplayed(otherNamePO.getOtherNameNoMatchFoundMessage());
    }

    public boolean isOtherNameOGSToggleDisable() {
        return isElementDisplayed(waitShort, otherNamePO.getOtherNameOgsButtonDisable());
    }

    public String getOtherNameLasScreeningDateText() {
        return getElementText(otherNamePO.getOtherNameLastScreeningDate());
    }

    public boolean isIconScreeningOtherNameElementDisappeared(String otherName) {
        return isElementDisappeared(waitShort, xpath(format(otherNamePO.getOtherNameScreen(), otherName)));
    }

    public void scrollIntoViewWCOtherNameRecord(String name, String type) {
        scrollIntoView(xpath(format(otherNamePO.getWcScreeningOtherNameTypeTooltip(), name, type)));
    }

    public void hoversOverWCScreeningOtherNameType(String name, String type) {
        hoverOverElement(xpath(format(otherNamePO.getWcScreeningOtherNameTypeTooltip(), name, type)));
    }

}
