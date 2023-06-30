package com.refinitiv.asts.test.ui.pageActions.setUp.userManagement;

import com.refinitiv.asts.test.ui.enums.OOOFields;
import com.refinitiv.asts.test.ui.enums.UserFields;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.userManagement.UserPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.OOOData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.api.AppApi.EXTERNAL_USER_TYPE;
import static com.refinitiv.asts.test.ui.api.AppApi.INTERNAl_USER_TYPE;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.NO;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.YES;
import static com.refinitiv.asts.test.ui.constants.Pages.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.enums.Status.INACTIVE;
import static com.refinitiv.asts.test.ui.enums.UserFields.THIRD_PARTY;
import static com.refinitiv.asts.test.ui.enums.UserFields.*;
import static java.lang.String.format;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.StringUtils.LF;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.presenceOfElementLocated;

public class UserManagementUserPage extends BasePage<UserManagementUserPage> {

    private final UserPO userPO;

    public UserManagementUserPage(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
        this.userPO = new UserPO(driver, translator);
    }

    @Override
    protected ExpectedCondition<UserManagementUserPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return isElementDisplayed(userPO.getUserManagementLabel());
    }

    @Override
    public void load() {

    }

    public void navigateToUserManagementUserPage() {
        driver.get(URL + USER_PATH);
    }

    public void navigateToUserManagementAddUserPage() {
        driver.get(URL + ADD_USER_PATH);
    }

    public void navigateToUserManagementViewUserPage(String userId) {
        driver.get(URL + format(VIEW_USER_PATH, userId));
    }

    public void navigateToUserManagementEditUserPage(String userId) {
        driver.get(URL + format(EDIT_USER_PATH, userId));
    }

    public void clickAddNewUserButton() {
        clickOn(userPO.getAddNewUserButton(), waitShort);
    }

    public void clicksUserPageSubmitButton() {
        clickOn(userPO.getUserPageSubmitButton(), waitShort);
    }

    public void clearField(String fieldType) {
        clearText(xpath(format(userPO.getUserInputField(), fieldType)));
    }

    public void clearAndTextField(String fieldType, String value) {
        clearInputAndEnterField(driver.findElement(xpath(format(userPO.getUserInputField(), fieldType))),
                                value);
    }

    public void selectFromDropDown(String fieldType, String value) {
        clearAndFillInValueAndSelectFromDropDown(value,
                                                 xpath(format(userPO.getUserInputField(), fieldType)),
                                                 userPO.getDropDownOption());
    }

    public void cleanDivisionField() {
        List<WebElement> divisions = driver.findElements(xpath(userPO.getDivisionDeleteButtonList()));
        for (int i = 0; i < divisions.size(); i++) {
            clickOn(userPO.getFirstDivisionDeleteButton());
        }
    }

    public void clickEditUserByName(String firstName) {
        clickOn(driver.findElement(xpath(format(userPO.getEditRowButton(), firstName))));
    }

    public void clickOnUserByName(String firstName) {
        clickOn(xpath(format(userPO.getUserRowFirstName(), firstName)));
    }

    public void clickOnUserByUserName(String userName) {
        clickOn(xpath(format(userPO.getUserRowUserName(), userName)));
    }

    public void clickOnTableColumn(String columnName) {
        clickOn(xpath(format(userPO.getUsersTableColumn(), columnName)));
    }

    public void clicksBackUserManagementButton() {
        clickOn(userPO.getBackUserManagementButton(), waitShort);
    }

    public void clickOnUsersTableRow(int rowNo) {
        clickOn(xpath(format(userPO.getUsersTableRow(), rowNo)), waitLong);
    }

    public void checkActiveCheckbox() {
        clickOn(xpath(userPO.getActiveCheckbox()));
    }

    public void checkEnableSingleSignOnCheckbox() {
        clickOn(userPO.getEnableSingleSignOnCheckboxButton());
    }

    public void fillInUserData(UserData userData) {
        clearAndTextField(LAST_NAME.getName(), userData.getLastName());
        clearAndTextField(EMAIL.getName(), userData.getUsername());
        selectFromDropDown(ROLE.getName(), userData.getRole());
        selectFromDropDown(DIVISION.getName(), userData.getDivision());
        selectFromDropDown(DEPARTMENT.getName(), userData.getDepartment());
        clearAndTextField(FIRST_NAME.getName(), userData.getFirstName());
        if (nonNull(userData.getDefaultBillingEntity())) {
            selectFromDropDown(DEFAULT_BILLING_ENTITY.getName(), userData.getDefaultBillingEntity());
        }
    }

    public void clickUserOverviewEditButton() {
        clickOn(userPO.getUserOverviewPageEditButton());
    }

    public void clickCancelButton() {
        clickOn(userPO.getCancelButton());
    }

    public void clickDropDownButton(String dropDownName) {
        clickOn(xpath(format(userPO.getUserInputFieldButton(), dropDownName)));
    }

    public void hoverOverEditIcon() {
        hoverOverElement(userPO.getUserOverviewPageEditButton());
    }

    public void clickUserButton(String buttonName) {
        clickOn(xpath(format(userPO.getButton(), buttonName)));
    }

    public void hoverUserButton(String buttonName) {
        scrollIntoView(xpath(format(userPO.getButton(), buttonName)));
        hoverOverElement(xpath(format(userPO.getButton(), buttonName)));
    }

    public void clickDeactivateButton() {
        clickOn(userPO.getDeactivateButton());
    }

    public void clickRowCheckbox(int rowNo) {
        clickOn(xpath(format(userPO.getRowCheckbox(), rowNo)));
    }

    public void hoverRowCheckbox(int rowNo) {
        hoverOverElement(xpath(format(userPO.getRowCheckbox(), rowNo)));
    }

    public void hoverStatusIcon() {
        hoverOverElement(userPO.getStatusIcon());
    }

    public List<UserData> getUsersList() {
        waitWhilePreloadProgressbarIsDisappeared();
        return IntStream.rangeClosed(1, driver.findElements(userPO.getUsersTableRows()).size())
                .mapToObj(this::getUserRowDetails).collect(Collectors.toList());
    }

    public UserData getUserRowDetails(int userNo) {
        return new UserData().setFirstName(getTableRowValue(userNo, UserFields.FIRST_NAME.getName(), 2))
                .setLastName(getTableRowValue(userNo, UserFields.LAST_NAME.getName(), 2))
                .setUsername(getTableRowValue(userNo, USER_NAME.getName(), 2))
                .setOrganisation(getTableRowValue(userNo, ORGANISATION.getName(), 2))
                .setThirdParty(getTableRowValue(userNo, THIRD_PARTY.getName(), 2))
                .setUserType(getTableRowValue(userNo, USER_TYPE.getName(), 2))
                .setRole(getTableRowValue(userNo, UserFields.ROLE.getName(), 2))
                .setStatus(getTableRowValue(userNo, STATUS.getName(), 2))
                .setSingleSignOn(getTableRowValue(userNo, SINGLE_SIGN_ON.getName(), 2));
    }

    public UserData getUserOverviewDetails() {
        UserData userData = new UserData().setFirstName(getOverviewValue(UserFields.FIRST_NAME.getName()))
                .setLastName(getOverviewValue(UserFields.LAST_NAME.getName()))
                .setEmail(getOverviewValue(UserFields.EMAIL.getName()))
                .setUsername(getOverviewValue(USERNAME.getName()))
                .setPosition(getOverviewValue(POSITION.getName()))
                .setUserType(getOverviewValue(USER_TYPE.getName()))
                .setRole(getOverviewValue(UserFields.ROLE.getName()))
                .setStatus(getUserOverviewStatus())
                .setGroup(getOverviewValue(GROUP.getName()))
                .setSuperior(getOverviewValue(SUPERIOR.getName()));
        if (EXTERNAL_USER_TYPE.equals(userData.getUserType())) {
            userData.setThirdParty(getOverviewValue(THIRD_PARTY.getName()));
        }
        if (INTERNAl_USER_TYPE.equals(userData.getUserType())) {
            userData.setOrganisation(getOverviewValue(ORGANISATION.getName()))
                    .setEntity(new UserData.Entity().setName(getOverviewValue(ENTITY.getName())))
                    .setExternalOrganisation(getExternalOrganisationValue())
                    .setDepartment(getOverviewValue(DEPARTMENT.getName()))
                    .setSingleSignOn(getSingleSignOn())
                    .setDivision(getOverviewValue(UserFields.DIVISION.getName()).replaceAll(LF, COMMA + SPACE));
        }
        return userData;
    }

    public UserData getEditUserDetails() {
        UserData userData = new UserData().setFirstName(getEditValue(UserFields.FIRST_NAME.getName()))
                .setLastName(getEditValue(UserFields.LAST_NAME.getName()))
                .setEmail(getEditValue(UserFields.EMAIL.getName()))
                .setUsername(getEditValue(USERNAME.getName()))
                .setPosition(getEditValue(POSITION.getName()))
                .setUserType(getEditValue(USER_TYPE.getName()))
                .setRole(getEditValue(UserFields.ROLE.getName()))
                .setStatus(getUserOverviewStatus())
                .setGroup(getEditValue(GROUP.getName()))
                .setSuperior(getEditValue(SUPERIOR.getName()))
                .setOrganisation(getEditValue(ORGANISATION.getName()))
                .setEntity(new UserData.Entity().setName(getEditValue(ENTITY.getName())))
                .setExternalOrganisation(getExternalOrganisationValue())
                .setDepartment(getEditValue(DEPARTMENT.getName()))
                .setThirdParty(getEditValue(THIRD_PARTY.getName()))
                .setSingleSignOn(getSingleSignOn());
        if (INTERNAl_USER_TYPE.equals(userData.getUserType())) {
            String division = getEditValue(DIVISION.getName());
            userData.setDivision(nonNull(division) ? division.replaceAll(LF, COMMA + SPACE) : null);
        }
        return userData;
    }

    public List<OOOData> getOOOTableRecords() {
        waitWhilePreloadProgressbarIsDisappeared();
        return IntStream.rangeClosed(1, driver.findElements(userPO.getUsersTableRows()).size())
                .mapToObj(this::getOOOHistoryRowDetails).collect(Collectors.toList());
    }

    public OOOData getOOOHistoryRowDetails(int rowNo) {
        return new OOOData().setName(getTableRowValue(rowNo, OOOFields.NAME.getName(), 1))
                .setDateTime(getTableRowValue(rowNo, OOOFields.DATE_TIME.getName(), 1))
                .setOldValue(getTableRowValue(rowNo, OOOFields.OLD_VALUE.getName(), 1))
                .setNewValue(getTableRowValue(rowNo, OOOFields.NEW_VALUE.getName(), 1));
    }

    public String getUserType() {
        return getAttributeValueWhenAppears(waitShort, userPO.getUserPageUserTypeInput());
    }

    public String getOverviewValue(String fieldName) {
        By valuePath = xpath(format(userPO.getUserOverviewField(), fieldName));
        if (isElementDisplayed(valuePath)) {
            return getElementText(valuePath);
        }
        return null;
    }

    public String getEditValue(String fieldName) {
        By valuePath = xpath(format(userPO.getUserInputField(), fieldName));
        if (isElementDisplayed(valuePath)) {
            return getAttributeOrText(valuePath, VALUE);
        }
        return null;
    }

    private String getExternalOrganisationValue() {
        return isElementPresent(userPO.getExternalOrganisationLabel()) ?
                getAttributeOrText(userPO.getExternalOrganisationValue(), VALUE) : null;
    }

    private String getUserOverviewStatus() {
        return isCheckboxChecked(xpath(userPO.getActiveCheckbox())) ? ACTIVE.getStatus() : INACTIVE.getStatus();
    }

    private String getSingleSignOn() {
        WebElement singleSignOnCheckbox = getElement(userPO.getEnableSingleSignOnCheckbox());
        return Objects.nonNull(singleSignOnCheckbox) ?
                isCheckboxChecked(userPO.getEnableSingleSignOnCheckbox()) ? YES : NO :
                null;
    }

    public String getNoRecordsTextMatched() {
        return getElementText(userPO.getNoRecordResults());
    }

    public String getNoticeMessage() {
        return getElementText(userPO.getNotice());
    }

    public String getFieldMaxLength(String field) {
        return getAttributeValue(xpath(format(userPO.getUserInputField(), field)), MAX_LENGTH);
    }

    public String getOOONotice() {
        return getElementText(userPO.getOooNotice());
    }

    public String getHistoryMessage() {
        return getElementText(userPO.getHistoryMessage());
    }

    public List<String> getColumnNames() {
        return getElementsNonBlankTexts(driver.findElements(userPO.getTableColumnHeader()));
    }

    public List<String> getListValuesForColumn(String columnName) {
        int columnIndex = getColumnNames().indexOf(columnName) + 2;
        return getElementsText(cssSelector(format(userPO.getCellsWithIndex(), columnIndex)));
    }

    public List<String> getEditIconsTooltips() {
        List<WebElement> tableRow = driver.findElements(userPO.getUsersTableRows());
        List<String> tooltips = new ArrayList<>();
        IntStream.rangeClosed(1, tableRow.size())
                .forEach(i -> {
                             hoverOverElement(xpath(format(userPO.getEditButtonForRow(), i)));
                             tooltips.add(getElementText(userPO.getTooltip()));
                         }
                );
        return tooltips;
    }

    public List<String> getListThirdPartyForColumnWithType(String type) {
        return getElementsText(xpath(format(userPO.getRowThirdParty(), type)));
    }

    public boolean isAddUserModalDisplayed() {
        return isElementDisplayed(waitShort, userPO.getAddUserPage());
    }

    public boolean isAddUserModalDisappeared() {
        return isElementDisappeared(waitLong, userPO.getAddUserPage());
    }

    public boolean isEditUserPageDisplayed() {
        return isElementDisplayed(waitShort, userPO.getBackUserManagementButton()) &&
                !isElementDisplayed(userPO.getUserOverviewPageEditButton());
    }

    public boolean isUserOverviewModalDisplayed() {
        return isElementDisplayed(waitLong, userPO.getUserOverviewPageEditButton());
    }

    public boolean isUserOverviewModalDisappeared() {
        return isElementDisappeared(waitLong, userPO.getUserOverviewPageEditButton());
    }

    public boolean isUsersTableDisplayed() {
        return isElementDisplayed(waitLong, userPO.getUsersNameColumn());
    }

    public boolean areUserInputFieldInvisible() {
        return Arrays.stream(UserFields.values())
                .noneMatch(field -> isElementDisplayed(xpath(format(userPO.getUserInputField(), field.getName()))));
    }

    public boolean isUserResultsFilteredByKeyword(String keyWord) {
        for (UserData userData : getUsersList()) {
            if (!userData.getFirstName().toLowerCase().contains(keyWord.toLowerCase()) &&
                    !userData.getLastName().toLowerCase().contains(keyWord.toLowerCase()) &&
                    !userData.getUsername().toLowerCase().contains(keyWord.toLowerCase())) {
                logger.error(userData + " doesn't contain keyword " + keyWord);
                return false;
            }
        }
        return true;
    }

    public boolean isEditIconDisplayedForEachRecord() {
        List<WebElement> tableRow = driver.findElements(userPO.getUsersTableRows());
        return IntStream.rangeClosed(1, tableRow.size())
                .allMatch(i -> isElementDisplayed(xpath(format(userPO.getEditButtonForRow(), i))));
    }

    public boolean isActiveCheckboxChecked() {
        waitWhileLoadingImageIsDisappeared();
        return isElementAttributeContains(userPO.getActiveCheckboxSpan(), CLASS, CHECKED);
    }

    public boolean isEnableSingleSignOnCheckboxChecked() {
        return waitShort.until(presenceOfElementLocated(userPO.getEnableSingleSignOnCheckbox())).isSelected();
    }

    public boolean isButtonWithNameDisplayed(String name) {
        return isElementDisplayed(xpath(format(userPO.getButton(), name)));
    }

    public boolean isRequiredIndicatorDisplayedForField(String fieldName) {
        return isElementDisplayed(waitMoment, xpath(format(userPO.getRequiredIndicator(), fieldName)));
    }

    public boolean isSectionDisplayed(String sectionName) {
        return isElementDisplayed(xpath(format(userPO.getSection(), sectionName)));
    }

    public boolean isUserTypeDisabled() {
        return isElementAttributeContains(userPO.getUserTypeInput(), CLASS, DISABLED);
    }

    public boolean isUsernameDisabled() {
        return isElementAttributeContains(userPO.getUsername(), CLASS, DISABLED);
    }

    public boolean isOrganisationDisabled() {
        return isElementAttributeContains(userPO.getOrganisation(), CLASS, DISABLED);
    }

    public boolean isUserInputFieldChecked(String fieldName) {
        return isAttributePresent(xpath(format(userPO.getUserInputField(), fieldName)), CHECKED);
    }

    public boolean isUserInputFieldEditable(String field) {
        return driver.findElement(xpath(format(userPO.getUserInputField(), field))).isEnabled();
    }

    public boolean isInputFieldUneditable(String field) {
        return !isElementDisplayed(xpath(format(userPO.getUserInputField(), field))) ||
                isElementAttributeContains(xpath(format(userPO.getUserInputField(), field)), CLASS, DISABLED);
    }

    public boolean isUserButtonDisabled(String buttonName) {
        return isElementAttributeContains(xpath(format(userPO.getButton(), buttonName)), CLASS, DISABLED);
    }

    public boolean isUserRowCheckboxDisabled(int rowNo) {
        return isAttributePresent(xpath(format(userPO.getRowCheckbox(), rowNo)), DISABLED);
    }

    public boolean isCalendarDisplayed(String field) {
        return isElementDisplayed(xpath(format(userPO.getCalendarButton(), field)));
    }

    public int getTimepickerCount() {
        return driver.findElements(userPO.getTimeButton()).size();
    }

    public boolean isStatusFieldDisabled() {
        return isElementAttributeContains(userPO.getStatusInput(), CLASS, DISABLED);
    }

    private String getTableRowValue(int rowNo, String columnName, int index) {
        int columnNo = getColumnNames().indexOf(columnName.toUpperCase()) + index;
        return getElementText(xpath(format(userPO.getUserTableRowValue(), rowNo, columnNo)));
    }

}