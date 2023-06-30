package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.userManagement;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.ui.api.ConnectApi;
import com.refinitiv.asts.test.ui.api.model.UserManagementGroup;
import com.refinitiv.asts.test.ui.constants.TestConstants;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.enums.Colors;
import com.refinitiv.asts.test.ui.enums.GroupFields;
import com.refinitiv.asts.test.ui.enums.Status;
import com.refinitiv.asts.test.ui.pageActions.PaginationPage;
import com.refinitiv.asts.test.ui.pageActions.setUp.userManagement.UserManagementGroupPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.GroupData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;
import org.testng.SkipException;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.buildUserGroupRequest;
import static com.refinitiv.asts.test.ui.api.AppApi.INTERNAl_USER_TYPE;
import static com.refinitiv.asts.test.ui.api.BaseApi.USERS_ITEMS_PER_PAGE;
import static com.refinitiv.asts.test.ui.api.BaseApi.ZERO;
import static com.refinitiv.asts.test.ui.api.ConnectApi.getGroupIdByName;
import static com.refinitiv.asts.test.ui.api.ConnectApi.getListOfActiveUserGroups;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.getUsersByPublicApi;
import static com.refinitiv.asts.test.ui.constants.APIConstants.*;
import static com.refinitiv.asts.test.ui.constants.APIConstants.DATE_CREATED;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.Pages.SLASH;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.USER_GROUP;
import static com.refinitiv.asts.test.ui.enums.Colors.REACT_RGB_RED;
import static com.refinitiv.asts.test.ui.enums.GroupFields.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.REACT_FORMAT;
import static com.refinitiv.asts.test.ui.utils.DateUtil.getTodayDate;
import static java.util.Objects.nonNull;
import static java.util.UUID.randomUUID;
import static java.util.stream.Collectors.toList;
import static org.apache.commons.lang3.RandomStringUtils.randomAlphanumeric;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;

public class GroupManagementSteps extends BaseSteps {

    private static final String SUFFIX_FOR_GROUP = "_TEST";
    private final UserManagementGroupPage groupPage;
    private final PaginationPage paginationPage;
    private volatile String groupName;
    private int groupIndex = 0;

    public GroupManagementSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.groupPage = new UserManagementGroupPage(this.driver, translator);
        this.paginationPage = new PaginationPage(this.driver, translator, context);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public GroupData groupDataEntry(Map<String, String> entry) {
        return new GroupData(
                entry.get(GROUP_NAME.getField()),
                entry.get(GroupFields.DESCRIPTION.getField()),
                entry.get(GroupFields.STATUS.getField()),
                entry.get(GroupFields.DATE_CREATED.getField()),
                entry.get(LAST_UPDATE.getField()));
    }

    @When("User navigates to Group Management page")
    public void navigateToUserManagementGroupPage() {
        groupPage.navigateToUserManagementGroupPage();
    }

    @When("User navigates to Group Management Add page")
    public void navigateToUserManagementGroupAddPage() {
        groupPage.navigateToUserManagementGroupAddPage();
    }

    @When("User navigates to open {string} existing User Group page")
    public void navigateToOpenExistingUserGroupPage(String endpoint) {
        String groupId = (String) context.getScenarioContext().getContext(USER_GROUP_ID_CONTEXT);
        groupPage.navigateToUserManagementGroupPage(SLASH + groupId + endpoint);
    }

    @When("User clicks 'Add New Group' button")
    public void clickAddNewGroupButton() {
        groupPage.clickAddNewGroupButton();
    }

    @When("User clicks {string} Group form page button")
    public void clickGroupPageButton(String buttonType) {
        switch (buttonType) {
            case SAVE:
                groupPage.clickSaveButton();
                break;
            case CANCEL:
                groupPage.clickCancelButton();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
    }

    @When("^User fills in \"((.*))\" User Group value \"((.*))\"$")
    public void fillTextGroupInput(String fieldType, String value) {
        fieldType = groupPage.getFromDictionaryIfExists(fieldType);
        if (fieldType.equalsIgnoreCase(translator.getValue("groups.groupNameField"))) {
            if (value.equals(VALUE_TO_REPLACE)) {
                groupName = AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10);
                context.getScenarioContext().setContext(USER_GROUP_NAME_CONTEXT + groupIndex++, groupName);
            } else if (value.equals(VALUE_TO_UPDATE)) {
                groupName = AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10);
                groupIndex = 0;
                context.getScenarioContext().setContext(USER_GROUP_NAME_CONTEXT + groupIndex, groupName);
            } else {
                groupName = value;
                context.getScenarioContext().setContext(USER_GROUP_NAME_CONTEXT + groupIndex++, groupName);
            }
            groupPage.clearAndTextField(fieldType, groupName);
        } else {
            groupPage.clearAndTextField(fieldType, value);
        }
    }

    @When("^User selects in \"((.*))\" User Group value \"((.*))\"$")
    public void selectGroupValue(String fieldType, String value) {
        fieldType = groupPage.getFromDictionaryIfExists(fieldType);
        if (context.getScenarioContext().isContains(value)) {
            value = ((UserData) context.getScenarioContext().getContext(value)).getFirstName();
        }
        groupPage.selectFromDropDown(fieldType, value);
    }

    @When("^User (checks|unchecks) User Group Active checkbox$")
    public void clickActiveCheckbox(String state) {
        if ((!groupPage.isActiveCheckboxSelected() && state.equals(CHECKS)) ||
                (groupPage.isActiveCheckboxSelected() && !state.equals(CHECKS))) {
            groupPage.clickActiveCheckbox();
        }
    }

    @When("User searches group by group name")
    public void searchGroupByGroupName() {
        String name = groupName;
        if (this.context.getScenarioContext().isContains(USER_GROUP_EXISTING_NAME_CONTEXT)) {
            name = (String) this.context.getScenarioContext().getContext(USER_GROUP_EXISTING_NAME_CONTEXT);
        }
        groupPage.searchGroup(name);
    }

    @When("User searches group by group name - {string}")
    public void searchGroupByGroupName(String groupName) {
        if (groupName.equals(USER_GROUP_NAME_CONTEXT + groupIndex)) {
            groupName = (String) context.getScenarioContext().getContext(USER_GROUP_NAME_CONTEXT + groupIndex);
        }
        groupPage.searchGroup(groupName);
    }

    @When("User creates new User Group {string} via API")
    public void createUserGroupViaAPI(String groupReference) {
        GroupData groupData =
                new JsonUiDataTransfer<GroupData>(USER_GROUP).getTestData().get(groupReference).getDataToEnter();
        groupData.setGroupName(AUTO_TEST_NAME_PREFIX + randomUUID())
                .setEmail(
                        groupData.getEmail().stream().map(emailReference -> Config.get().value(emailReference)).collect(
                                Collectors.toList()))
                .setUsername(groupData.getUsername());
        UserManagementGroup request = buildUserGroupRequest(groupData);
        ConnectApi.createUserGroup(request);
        groupName = request.getName();
        String groupId = getGroupIdByName(request.getName());
        this.context.getScenarioContext().setContext(USER_GROUP_NAME_CONTEXT + groupIndex++, groupName);
        this.context.getScenarioContext().setContext(USER_GROUP_ID_CONTEXT, groupId);
        this.context.getScenarioContext().setContext(GROUP_TEST_DATA_CONTEXT, groupData);
    }

    @When("User creates new User Group {string} via API without context")
    public void createUserGroupViaAPINoContext(String groupReference) {
        GroupData groupData =
                new JsonUiDataTransfer<GroupData>(USER_GROUP).getTestData().get(groupReference).getDataToEnter();
        groupData.setEmail(
                groupData.getEmail().stream().map(emailReference -> Config.get().value(emailReference)).collect(
                        Collectors.toList()));
        UserManagementGroup request = buildUserGroupRequest(groupData);
        ConnectApi.createUserGroup(request);
    }

    @When("^User clicks \"(Edit|Delete)\" icon for the created User Group$")
    public void clickIconWithName(String iconName) {
        groupPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        groupPage.clickIconWithName(groupName, iconName);
    }

    @When("User ticks created User Group(s) to be deactivated")
    public void tickCreatedUserGroup() {
        IntStream.rangeClosed(0, groupIndex).forEach(i -> {
            if (context.getScenarioContext().isContains(USER_GROUP_NAME_CONTEXT + i)) {
                String name = (String) context.getScenarioContext().getContext(USER_GROUP_NAME_CONTEXT + i);
                groupPage.tickUserGroupWithName(name);
            }
        });
    }

    @When("User clicks User Group Deactivate button")
    public void clickDeactivateButton() {
        groupPage.clickDeactivateButton();
    }

    @When("User clears Group form page {string} field")
    public void clearField(String fieldType) {
        String members = "Members";
        if (fieldType.equals(members)) {
            groupPage.clearDropdownInput(fieldType);
        } else {
            groupPage.clearField(fieldType);
        }
    }

    @When("User clicks on User Group to view details")
    public void clickOnUserGroupToViewDetails() {
        groupPage.clickUserGroupRow();
    }

    @When("User clicks on created User Group to view details")
    public void clickOnCreatedUserGroupToViewDetails() {
        groupPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        groupPage.clickCreatedUserGroupRow(groupName);
    }

    @When("User clicks Edit button on Group page")
    public void clickGroupPageEditButton() {
        groupPage.clickGroupPageEditButton();
    }

    @When("User fills in {string} Group field with already existing Group name")
    public void fillInGroupNameWithPreExistingNameAdd(String fieldType) {
        String value;
        if (Objects.nonNull(groupName)) {
            value = ConnectApi.getUserGroupNames().stream()
                    .filter(s -> !s.contains(groupName) && s.contains(SUFFIX_FOR_GROUP)).findFirst()
                    .orElse(null);
        } else {
            value = ConnectApi.getUserGroupNames().stream().findFirst().orElse(null);
        }
        groupPage.clearAndTextField(fieldType, value);
        this.context.getScenarioContext().setContext(USER_GROUP_EXISTING_NAME_CONTEXT, value);
    }

    @When("Skip User Group {string} creation if already exists")
    public void checkUserGroupExists(String groupName) {
        if (getListOfActiveUserGroups().stream().anyMatch(group -> group.equals(groupName))) {
            throw new SkipException(groupName + " already exists");
        }
    }

    @When("User clicks User Groups in Set Up menu")
    public void clickGroupsInSetUpMenu() {
        groupPage.clickUserGroupMenu();
        groupPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User hovers over cheated User Group checkbox")
    public void hoverOverCheatedUserGroupCheckbox() {
        String name = (String) context.getScenarioContext().getContext(USER_GROUP_NAME_CONTEXT + 0);
        groupPage.hoverUserGroupCheckboxWithName(name);
    }

    @When("User clicks cross control button for User Group member {string}")
    public void clickCrossControlButtonForUserGroupMember(String member) {
        groupPage.clickOnCrossControlButton(member);
    }

    @Then("Group Management {string} page is displayed")
    public void isPageDisplayed(String pageType) {
        assertThat(groupPage.isPageWithTypeDisplayed(pageType))
                .as("%s page is not displayed", pageType)
                .isTrue();
    }

    @Then("{string} User Group page is disappeared")
    public void addNewGroupIsDisappeared(String pageType) {
        assertThat(groupPage.isUserGroupPageDisappeared(pageType))
                .as("%s page is not displayed", pageType)
                .isTrue();
    }

    @Then("Group is displayed with values")
    public void isGroupDisplayedWithValues(List<GroupData> expectedGroupData) {
        groupPage.waitWhilePreloadProgressbarIsDisappeared();
        List<GroupData> actualGroupData = new ArrayList<>();
        IntStream.rangeClosed(0, groupIndex).forEach(i -> {
            if (context.getScenarioContext().isContains(USER_GROUP_NAME_CONTEXT + i)) {
                String name = (String) context.getScenarioContext().getContext(USER_GROUP_NAME_CONTEXT + i);
                expectedGroupData.get(i).setGroupName(name)
                        .setDateCreated(getTodayDate(expectedGroupData.get(i).getDateCreated()))
                        .setLastUpdate(nonNull(expectedGroupData.get(i).getLastUpdate()) ?
                                               getTodayDate(expectedGroupData.get(i).getLastUpdate()) : null);
                actualGroupData.add(groupPage.getGroupRowDetails(name));
            }
        });
        assertThat(actualGroupData)
                .as("Created User group data is unexpected")
                .usingRecursiveComparison().ignoringCollectionOrder()
                .isEqualTo(expectedGroupData);
    }

    @Then("Edit and Delete icons are available on User Groups page")
    public void areEditAndDeleteIconsDisplayed() {
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(groupPage.areIconsEditDisplayed())
                .as("No Edit icons are displayed")
                .isTrue();
        softAssert.assertThat(groupPage.areIconsDeleteDisplayed())
                .as("No Delete icons are displayed")
                .isTrue();
        softAssert.assertAll();
    }

    @Then("Alert Icon for User Group Management is displayed with text")
    public void isAlertIconForUserGroupDisplayedWithText(List<String> expectedAlertMessage) {
        String actualAlertMessage = groupPage.getAlertIconText();
        if (this.context.getScenarioContext().isContains(USER_GROUP_EXISTING_NAME_CONTEXT)) {
            groupName = (String) this.context.getScenarioContext().getContext(USER_GROUP_EXISTING_NAME_CONTEXT);
        }
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(groupPage.isAlertIconDisplayed())
                .as("Alert Icon is not displayed")
                .isTrue();
        expectedAlertMessage.forEach(text -> softAssert.assertThat(actualAlertMessage)
                .as("Alert message doesn't contain expected text")
                .contains(String.format(text, groupName)));
        softAssert.assertAll();

    }

    @Then("User Group Deactivate button appears")
    public void isDeactivateButtonDisplayed() {
        assertThat(groupPage.isDeactivateButtonDisplayed())
                .as("Deactivate button is not displayed")
                .isTrue();
    }

    @Then("Created User group status is {string}")
    public void isCreatedGroupDisplayedWithStatus(String expectedStatus) {
        groupPage.refreshPage();
        groupPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(groupPage.getGroupStatus(groupName))
                .as("Created User group status is unexpected")
                .isEqualTo(expectedStatus);
    }

    @Then("Group form page {string} input is displayed")
    public void isTextFieldDisplayed(String fieldName) {
        assertThat(groupPage.isInputDisplayed(fieldName))
                .as("%s field is not displayed", fieldName)
                .isTrue();
    }

    @Then("^Group form page \"((.*))\" field (is|is not) required$")
    public void isTextFieldRequired(String fieldName, String state) {
        if (state.contains(NOT)) {
            assertThat(groupPage.getTextFieldIndicator(fieldName))
                    .as("User group field is not optional")
                    .isNull();
        } else {
            assertThat(groupPage.getTextFieldIndicator(fieldName))
                    .as("User group field required indicator is unexpected")
                    .isEqualTo(REQUIRED_INDICATOR);
        }
    }

    @Then("^Group form page Active checkbox is displayed$")
    public void isActiveCheckboxDisplayed() {
        assertThat(groupPage.isActiveCheckboxDisplayed())
                .as("Active checkbox is not displayed")
                .isTrue();
    }

    @Then("^Group form page \"((.*))\" field validation message \"((.*))\" is displayed$")
    public void isFieldValidationMessageDisplayed(String fieldType, String message) {
        if (this.context.getScenarioContext().isContains(USER_GROUP_EXISTING_NAME_CONTEXT)) {
            groupName = (String) this.context.getScenarioContext().getContext(USER_GROUP_EXISTING_NAME_CONTEXT);
        }
        assertThat(groupPage.getValidationMessage(fieldType))
                .as("Group form validation message is unexpected")
                .isEqualTo(String.format(message, groupName));
    }

    @Then("^Group form page \"((.*))\" field is populated with \"((.*))\"$")
    public void isTextFieldPopulated(String fieldType, String value) {
        groupPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (value.equals(VALUE_TO_REPLACE)) {
            value = groupName;
        }
        assertThat(groupPage.isTextFieldPopulated(fieldType))
                .as("Group form %s field value is unexpected", fieldType)
                .isEqualTo(value);
    }

    @Then("^Group form page Active checkbox is checked$")
    public void isActiveCheckboxChecked() {
        assertThat(groupPage.isActiveCheckboxSelected())
                .as("Active checkbox is not checked")
                .isTrue();
    }

    @Then("'No match found' is displayed on user groups table")
    public void noMatchFoundIsDisplayed() {
        assertThat(groupPage.isNoMatchFoundDisplayed())
                .as("No match found is not displayed")
                .isTrue();
    }

    @Then("^Group form page \"((.*))\" dropdown is populated with \"((.*))\"$")
    public void isDropdownPopulated(String fieldType, String value) {
        if (value.equals(VALUE_TO_REPLACE)) {
            GroupData data = (GroupData) this.context.getScenarioContext().getContext(GROUP_TEST_DATA_CONTEXT);
            value = data.getUsername().get(0);
        }
        if (value.isEmpty()) {
            assertThat(groupPage.getDropdownSelectedValues(fieldType))
                    .as("Group form %s drop-down value is not empty", fieldType)
                    .isEmpty();
        } else {
            assertThat(groupPage.getDropdownSelectedValues(fieldType))
                    .as("Group form %s drop-down value is unexpected", fieldType)
                    .contains(value);
        }
    }

    @Then("^Group form page \"((.*))\" field is highlighted$")
    public void isTextFieldHighlighted(String fieldType) {
        assertThat(groupPage.getTextFieldBorderColor(fieldType))
                .as("Field is not highlighted in red")
                .isEqualTo(REACT_RGB_RED.getColorRgba());
    }

    @Then("Group form page {string} button is displayed")
    public void isGroupPageButtonDisplayed(String buttonType) {
        boolean actualResult;
        switch (buttonType) {
            case SAVE:
                actualResult = groupPage.isSaveGroupPageButtonDisplayed();
                break;
            case CANCEL:
                actualResult = groupPage.isCancelGroupPageButtonDisplayed();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
        assertThat(actualResult)
                .as("Button %s is not displayed", buttonType)
                .isTrue();
    }

    @Then("User Group Overview columns are displayed")
    public void userGroupOverviewColumnsAreDisplayed(List<String> expectedResult) {
        assertThat(groupPage.getGroupTableColumnNames())
                .as("Column names are unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("Group form page {string} field is disabled")
    public void isGroupFormFieldEditable(String fieldType) {
        assertThat(groupPage.isFieldDisabled(fieldType))
                .as("Group field %s is editable", fieldType)
                .isTrue();
    }

    @Then("User Group Edit button on Group page is displayed")
    public void isEditButtonOnGroupPageDisplayed() {
        assertThat(groupPage.isEditButtonOnGroupPageDisplayed())
                .as("User Group Edit button on Group page is not displayed")
                .isTrue();
    }

    @Then("User Group table shows only one search result")
    public void isOnlyOneRowDisplayed() {
        String name;
        if (this.context.getScenarioContext().isContains(USER_GROUP_EXISTING_NAME_CONTEXT)) {
            name = (String) this.context.getScenarioContext().getContext(USER_GROUP_EXISTING_NAME_CONTEXT);
        } else {
            name = groupName;
        }
        assertThat(groupPage.isOnlyOneRowDisplayed(name))
                .as("Search returned more than one result")
                .isTrue();
    }

    @Then("User Group Management page is displayed")
    public void isUserManagementHeaderDisplayed() {
        assertThat(groupPage.isUserManagementHeaderDisplayed())
                .as("User Group header is not displayed")
                .isTrue();
    }

    @Then("User Groups table is displayed")
    public void userGroupsTableIsDisplayed() {
        assertThat(groupPage.isUserGroupsTableDisplayed())
                .as("User Group table is not displayed")
                .isTrue();
    }

    @Then("^User group \"((.*))\" (is|is not) created$")
    public void isUserGroupCreated(String groupName, String state) {
        if (state.contains(NOT)) {
            assertThat(getListOfActiveUserGroups().stream().noneMatch(group -> group.equals(groupName)))
                    .as("User group %s was created", groupName)
                    .isTrue();
        } else {
            assertThat(getListOfActiveUserGroups().stream().anyMatch(group -> group.equals(groupName)))
                    .as("User group %s was not created", groupName)
                    .isTrue();
        }
    }

    @Then("^(All|Active|Inactive) User Groups are displayed on groups table$")
    public void userGroupsAreDisplayedInTable(String groupStatus) {
        List<String> expectedUsersGroupList;
        switch (groupStatus.toLowerCase()) {
            case ACTIVE:
                expectedUsersGroupList = ConnectApi.getListOfActiveUserGroups().stream()
                        .map(group -> group.replace(DOUBLE_SPACE, SPACE).trim())
                        .collect(Collectors.toList());
                break;
            case INACTIVE:
                expectedUsersGroupList = ConnectApi.getListOfInactiveUserGroups().stream()
                        .map(group -> group.replace(DOUBLE_SPACE, SPACE).trim())
                        .collect(Collectors.toList());
                break;
            case TestConstants.ALL:
                expectedUsersGroupList = ConnectApi.getUserGroupNames().stream()
                        .map(group -> group.replace(DOUBLE_SPACE, SPACE).trim())
                        .collect(Collectors.toList());
                break;
            default:
                throw new IllegalArgumentException(groupStatus + " is not allowed");
        }
        List<String> actualUsersGroupList = paginationPage.getAllTableStringResults().stream()
                .map(group -> group.split(ROW_DELIMITER)[0]).collect(Collectors.toList());
        assertThat(actualUsersGroupList)
                .as("Not all %s user groups are returned in a search result", groupStatus)
                .usingRecursiveComparison().ignoringCollectionOrder()
                .isEqualTo(expectedUsersGroupList);
    }

    @Then("User Groups table is displayed only with groups names contain {string}")
    public void userGroupsTableIsDisplayedOnlyWithGroupsNamesContain(String partOfName) {
        SoftAssertions softAssert = new SoftAssertions();
        List<String> actualUsersGroupList = paginationPage.getAllTableStringResults().stream()
                .map(group -> group.split(ROW_DELIMITER)[0]).collect(Collectors.toList());
        actualUsersGroupList.forEach(name -> softAssert.assertThat(name)
                .as("Group Name doesn't contain expected part")
                .contains(partOfName));
        softAssert.assertAll();
    }

    @Then("User Groups table displays groups sorted by {string} in {string} order")
    public void userGroupsTableDisplaysUsersSortedByInOrder(String columnName, String sortOrder) {
        groupPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        List<String> valuesList = groupPage.getListValuesForColumn(columnName);
        tableIsSortedByInOrder("User Groups Table", columnName, sortOrder, REACT_FORMAT, valuesList, false);
    }

    @Then("User Groups Add New Group button is displayed")
    public void userGroupsAddNewGroupButtonIsDisplayed() {
        assertThat(groupPage.isAddNewGroupButtonDisplayed())
                .as("User Groups Add New Group button is not displayed")
                .isTrue();
    }

    @Then("^All checkboxes for created User Groups are (activated|inactivated|disabled)$")
    public void allCheckboxesForCreatedUserGroupsAreActivated(String state) {
        SoftAssertions softAssertions = new SoftAssertions();
        for (int i = 0; i <= groupIndex; i++) {
            if (context.getScenarioContext().isContains(USER_GROUP_NAME_CONTEXT + i)) {
                String name = (String) context.getScenarioContext().getContext(USER_GROUP_NAME_CONTEXT + i);
                String expectedColor;
                boolean currentState;
                switch (state) {
                    case ACTIVATED:
                        expectedColor = Colors.DARK_BLUE.getColorRgba();
                        currentState = groupPage.isCheckboxChecked(name);
                        break;
                    case INACTIVATED:
                        expectedColor = Colors.CHECKBOX_DARK_GREY.getColorRgba();
                        currentState = !groupPage.isCheckboxChecked(name);
                        break;
                    case DISABLED:
                        expectedColor = Colors.CHECKBOX_LIGHT_GREY.getColorRgba();
                        currentState = groupPage.isCheckboxDisabled(name);
                        break;
                    default:
                        throw new IllegalArgumentException(state + " state is unexpected");
                }
                softAssertions.assertThat(groupPage.getCheckboxColor(name))
                        .as("Checkbox color for group %s is unexpected", name)
                        .isEqualTo(expectedColor);
                softAssertions.assertThat(currentState)
                        .as("Checkbox for group %s is not in state: %s", name, state)
                        .isTrue();
            }
        }
        softAssertions.assertAll();

    }

    @Then("User Group {string} drop-down contains only active internal users")
    public void userGroupDropDownContainsOnlyActiveInternalUsers(String fieldName) {
        List<String> expectedResult =
                getUsersByPublicApi(USERS_ITEMS_PER_PAGE, ZERO, SORT_ORDER_SIGN.get(DESC), DATE_CREATED)
                        .stream()
                        .filter(user -> user.getStatus().equals(Status.ACTIVE.getStatus().toUpperCase()) &&
                                user.getUserType().equals(INTERNAl_USER_TYPE) && nonNull(user.getUsername()) &&
                                nonNull(user.getRole()))
                        .map(user -> user.getFirstName() + SPACE + user.getLastName())
                        .limit(20)
                        .collect(toList());
        groupPage.clickDropDown(fieldName);
        List<String> actualResult = groupPage.getDropDownOptions();
        actualResult.remove(DROPDOWN_PLACEHOLDER);
        assertThat(actualResult)
                .as("%s drop-down does not contain expected values", fieldName)
                .containsExactlyInAnyOrderElementsOf(expectedResult);
        groupPage.clickDropDown(fieldName);
    }

    @Then("Group form selected {string} values is displayed with cross control near the value")
    public void groupFormSelectedValuesIsDisplayedWithCrossControlNearTheValue(String dropDownName) {
        List<String> selectedMembers = groupPage.getDropdownSelectedValues(dropDownName);
        SoftAssertions softAssertions = new SoftAssertions();
        selectedMembers.forEach(member ->
                                        softAssertions.assertThat(groupPage.isCrossControlDisplayed(member))
                                                .as("Cross Control button is not displayed for member %s", member)
                                                .isTrue());
        softAssertions.assertAll();
    }

    @Then("Group form page breadcrumb test is {string}")
    public void groupFormPageBreadcrumbTestIs(String expectedText) {
        assertThat(groupPage.getBreadcrumbText())
                .as("Group form page breadcrumb test is unexpected")
                .isEqualTo(expectedText);
    }

    @Then("Group form page {string} field max length is {string}")
    public void groupFormPageFieldMaxLengthIs(String fieldName, String expectedLength) {
        assertThat(groupPage.getInputMaxLength(fieldName))
                .as("Field %s max length is unexpected", fieldName)
                .isEqualTo(expectedLength);
    }

    @Then("User Groups option in Set Up menu is not displayed")
    public void isGroupsInSetUpMenuDisplayed() {
        assertThat(groupPage.isUserGroupMenuDisplayed())
                .as("User Groups option in Set Up menu is displayed")
                .isFalse();
    }

}
