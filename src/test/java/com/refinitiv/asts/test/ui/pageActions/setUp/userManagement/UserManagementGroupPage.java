package com.refinitiv.asts.test.ui.pageActions.setUp.userManagement;

import com.refinitiv.asts.test.ui.constants.TestConstants;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.userManagement.GroupFormPO;
import com.refinitiv.asts.test.ui.pageObjects.setUp.userManagement.GroupTablePO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.GroupData;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;

import static com.refinitiv.asts.test.ui.constants.Pages.ADD_GROUP_PATH;
import static com.refinitiv.asts.test.ui.constants.Pages.GROUP_PATH;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.GroupFields.*;
import static java.lang.String.format;
import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class UserManagementGroupPage extends BasePage<UserManagementGroupPage> {

    private final GroupTablePO groupTablePO;
    private final GroupFormPO groupFormPO;

    public UserManagementGroupPage(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
        this.groupTablePO = new GroupTablePO(driver, translator);
        this.groupFormPO = new GroupFormPO(driver);
    }

    @Override
    protected ExpectedCondition<UserManagementGroupPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return true;
    }

    @Override
    public void load() {

    }

    public void navigateToUserManagementGroupPage() {
        driver.get(URL + GROUP_PATH);
    }

    public void navigateToUserManagementGroupPage(String endpoint) {
        driver.get(URL + GROUP_PATH + endpoint);
    }

    public void navigateToUserManagementGroupAddPage() {
        driver.get(URL + ADD_GROUP_PATH);
    }

    public void clickAddNewGroupButton() {
        clickOn(groupTablePO.getAddNewGroupButton(), waitLong);
    }

    public void clickSaveButton() {
        clickOn(groupFormPO.getSaveGroupButton(), waitShort);
    }

    public void clickCancelButton() {
        clickOn(groupFormPO.getCancelGroupButton());
    }

    public void clickIconWithName(String groupName, String iconName) {
        clickOn(xpath(format(groupTablePO.getGroupIcon(), groupName, iconName)), waitShort);
    }

    public void tickUserGroupWithName(String groupName) {
        clickOn(xpath(format(groupTablePO.getGroupCheckbox(), groupName)));
    }

    public void hoverUserGroupCheckboxWithName(String groupName) {
        hoverOverElement(xpath(format(groupTablePO.getGroupCheckbox(), groupName)));
    }

    public void clickDeactivateButton() {
        clickOn(waitShort.until(visibilityOfElementLocated(groupTablePO.getDeactivateButton())));
    }

    public void clickUserGroupRow() {
        clickOn(groupTablePO.getRowInTable(), waitShort);
    }

    public void clickCreatedUserGroupRow(String groupName) {
        clickOn(xpath(format(groupTablePO.getGroupNameInTable(), groupName)));
    }

    public void clickGroupPageEditButton() {
        clickOn(groupFormPO.getEditButton());
    }

    public void clearAndTextField(String fieldType, String value) {
        clearInputAndEnterField(xpath(format(groupFormPO.getGroupFormInput(), fieldType)), value);
    }

    public void selectFromDropDown(String fieldType, String value) {
        fillInValueAndSelectFromDropDown(value, xpath(format(groupFormPO.getGroupFormInput(), fieldType)),
                                         groupFormPO.getMembersDropDownItem());
    }

    public void clickActiveCheckbox() {
        clickOn(xpath(groupFormPO.getActiveCheckboxSpan()));
    }

    public void searchGroup(String groupName) {
        clearInputAndEnterField(waitShort.until(elementToBeClickable(groupTablePO.getUserSearchInput())), groupName);
        try {
            waitMoment.until(
                    presenceOfAllElementsLocatedBy(xpath(format(groupTablePO.getGroupNameInTable(), groupName))));
        } catch (TimeoutException ex) {
            refreshPage();
            clearInputAndEnterField(waitShort.until(elementToBeClickable(groupTablePO.getUserSearchInput())),
                                    groupName);
        }
    }

    public void clearField(String fieldType) {
        clearText(xpath(format(groupFormPO.getGroupFormInput(), fieldType)));
    }

    public void clickDropDown(String fieldType) {
        clickOn(xpath(format(groupFormPO.getGroupFormInput(), fieldType)));
    }

    public void clearDropdownInput(String fieldType) {
        if (getElements(xpath(format(groupFormPO.getDropDownSelectedItems(), fieldType))).size() > 0) {
            hoverOverElement(groupFormPO.getDropDownClearButton());
            clickOn(groupFormPO.getDropDownClearButton());
        }
    }

    public void clickUserGroupMenu() {
        clickOn(groupFormPO.getGroupMenuButton());
    }

    public void clickOnCrossControlButton(String member) {
        clickOn(xpath(format(groupFormPO.getCrossControlButton(), member)));
    }

    public boolean isPageWithTypeDisplayed(String pageType) {
        return isElementDisplayed(waitShort, xpath(format(groupFormPO.getUserGroupFormPage(),
                                                          getFromDictionaryIfExists(pageType))));
    }

    public boolean isUserGroupPageDisappeared(String pageType) {
        return isElementDisappeared(waitLong, xpath(format(groupFormPO.getUserGroupFormPage(),
                                                           getFromDictionaryIfExists(pageType))));
    }

    public boolean isActiveCheckboxSelected() {
        return isCheckboxChecked(groupFormPO.getActiveCheckboxInput());
    }

    public boolean areIconsEditDisplayed() {
        return areIconsDisplayed(groupTablePO.getIconsEdit());
    }

    public boolean areIconsDeleteDisplayed() {
        return areIconsDisplayed(groupTablePO.getIconsDelete());
    }

    public boolean isDeactivateButtonDisplayed() {
        return isElementDisplayed(groupTablePO.getDeactivateButton());
    }

    public boolean isInputDisplayed(String fieldType) {
        return isElementDisplayed(waitShort, xpath(format(groupFormPO.getGroupFormInput(), fieldType)));
    }

    public boolean isActiveCheckboxDisplayed() {
        return isElementDisplayed(xpath(groupFormPO.getActiveCheckboxSpan()));
    }

    public boolean isSaveGroupPageButtonDisplayed() {
        return isElementDisplayed(groupFormPO.getSaveGroupButton());
    }

    public boolean isCancelGroupPageButtonDisplayed() {
        return isElementDisplayed(groupFormPO.getCancelGroupButton());
    }

    public boolean isFieldDisabled(String fieldType) {
        return isElementAttributeContains(xpath(format(groupFormPO.getGroupFormInput(), fieldType)), CLASS, DISABLED);
    }

    public boolean isOnlyOneRowDisplayed(String groupName) {
        return waitShort.ignoring(StaleElementReferenceException.class).
                until(visibilityOfAllElements(
                        getElements(xpath(format(groupTablePO.getGroupNameInTable(), groupName))))).size() == 1;
    }

    public boolean isEditButtonOnGroupPageDisplayed() {
        return isElementDisplayed(groupFormPO.getEditButton());
    }

    public boolean isUserManagementHeaderDisplayed() {
        return isElementDisplayed(waitShort, xpath(groupTablePO.getPageHeader()));
    }

    public boolean isUserGroupsTableDisplayed() {
        return isElementDisplayed(waitLong, groupTablePO.getUserGroupsTableList());
    }

    public boolean isNoMatchFoundDisplayed() {
        return isElementDisplayed(waitShort, groupTablePO.getNoMatchFound());
    }

    public boolean isAddNewGroupButtonDisplayed() {
        return isElementDisplayed(waitShort, groupTablePO.getAddNewGroupButton());
    }

    public boolean isCheckboxDisabled(String groupName) {
        return isElementAttributeContains(xpath(format(groupTablePO.getGroupCheckboxSpan(), groupName)), CLASS,
                                          DISABLED);
    }

    public boolean isCheckboxChecked(String groupName) {
        return isCheckboxChecked(groupTablePO.getGroupCheckbox(), groupName);
    }

    public boolean isCrossControlDisplayed(String member) {
        return isElementDisplayed(xpath(format(groupFormPO.getCrossControlButton(), member)));
    }

    public boolean isUserGroupMenuDisplayed() {
        return isElementDisplayed(groupFormPO.getGroupMenuButton());
    }

    private boolean areIconsDisplayed(By path) {
        List<WebElement> list = waitShort.until(visibilityOfAllElements(getElements(path)));
        return list.size() > 0;
    }

    public String isTextFieldPopulated(String fieldType) {
        return getAttributeValue(waitMoment, xpath(format(groupFormPO.getGroupFormInput(), fieldType)), VALUE);
    }

    public List<String> getDropdownSelectedValues(String fieldType) {
        return getElementsText(xpath(format(groupFormPO.getDropDownSelectedItems(), fieldType)));
    }

    public String getTextFieldBorderColor(String fieldType) {
        waitMoment.until(visibilityOfElementLocated(groupFormPO.getInputFieldError()));
        return getCssValue(xpath(format(groupFormPO.getGroupFormFieldset(), fieldType)),
                           TestConstants.BORDER_COLOR);
    }

    public String getGroupStatus(String groupName) {
        return getElementText(xpath(format(groupTablePO.getGroupStatus(), groupName)));
    }

    private String getTableRowValue(List<String> columnNames, String groupName, String columnName) {
        int index = columnNames.indexOf(columnName) + 2;
        return getElementText(xpath(format(groupTablePO.getGroupTableRowValue(), groupName, index)));
    }

    public String getTextFieldIndicator(String fieldName) {
        return getElementText(xpath(format(groupFormPO.getGroupFormInputAsterisk(), fieldName)));
    }

    public String getValidationMessage(String fieldType) {
        return getElementText(xpath(format(groupFormPO.getValidationMessage(), fieldType)));
    }

    public String getCheckboxColor(String groupName) {
        return getCssValue(xpath(format(groupTablePO.getGroupCheckboxSpan(), groupName)), COLOR);
    }

    public String getBreadcrumbText() {
        return getElementText(groupFormPO.getBreadcrumb()).replace(StringUtils.LF, StringUtils.EMPTY);
    }

    public String getInputMaxLength(String fieldName) {
        return getAttributeValue(xpath(format(groupFormPO.getGroupFormInput(), fieldName)), MAX_LENGTH);
    }

    public GroupData getGroupRowDetails(String groupName) {
        List<String> columnNames = getGroupTableColumnNames();
        return new GroupData().setGroupName(
                        getTableRowValue(columnNames, groupName, GROUP_NAME.getField().toUpperCase()))
                .setDescription(getTableRowValue(columnNames, groupName, DESCRIPTION.getField().toUpperCase()))
                .setStatus(getTableRowValue(columnNames, groupName, STATUS.getField().toUpperCase()))
                .setDateCreated(getTableRowValue(columnNames, groupName, DATE_CREATED.getField().toUpperCase()))
                .setLastUpdate(getTableRowValue(columnNames, groupName, LAST_UPDATE.getField().toUpperCase()));
    }

    public List<String> getGroupTableColumnNames() {
        return getElementsText(getElements(groupTablePO.getGroupTableColumnNames()));
    }

    public List<String> getListValuesForColumn(String columnName) {
        int columnIndex = getGroupTableColumnNames().indexOf(columnName) + 2;
        return getElementsText(cssSelector(format(groupTablePO.getCellsWithIndex(), columnIndex)));
    }

}
