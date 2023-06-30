package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.userManagement;

import com.google.api.client.util.Strings;
import com.google.common.collect.ImmutableMap;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.ui.api.AppApi;
import com.refinitiv.asts.test.ui.api.ConnectApi;
import com.refinitiv.asts.test.ui.api.Endpoints;
import com.refinitiv.asts.test.ui.api.model.organisation.allOrganisationData.OrganizationPayload;
import com.refinitiv.asts.test.ui.constants.TestConstants;
import com.refinitiv.asts.test.ui.dataproviders.DataProvider;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.enums.OOOFields;
import com.refinitiv.asts.test.ui.enums.UserFields;
import com.refinitiv.asts.test.ui.pageActions.SearchSectionPage;
import com.refinitiv.asts.test.ui.pageActions.setUp.userManagement.UserManagementUserPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.OOOData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.AssociatedPartyIndividualData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.text.CaseUtils;
import org.assertj.core.api.SoftAssertions;
import org.testng.SkipException;

import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.api.BaseApi.USERS_ITEMS_PER_PAGE;
import static com.refinitiv.asts.test.ui.api.BaseApi.ZERO;
import static com.refinitiv.asts.test.ui.api.Endpoints.ORGANISATION_GET;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.getFirstActiveUsers;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.getUsersByPublicApi;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.getActiveBillingEntities;
import static com.refinitiv.asts.test.ui.constants.APIConstants.*;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.THIRD_PARTY;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.USER;
import static com.refinitiv.asts.test.ui.enums.UserFields.*;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.DEFAULT_ITEMS_PER_PAGE;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.DEFAULT_PAGE;
import static com.refinitiv.asts.test.ui.stepDefinitions.BaseStepDef.RFG;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.TODAY;
import static java.lang.Integer.parseInt;
import static java.lang.String.format;
import static java.util.Arrays.asList;
import static java.util.Objects.nonNull;
import static java.util.UUID.randomUUID;
import static java.util.stream.Collectors.toList;
import static org.apache.commons.lang3.RandomStringUtils.randomAlphanumeric;
import static org.apache.commons.lang3.StringUtils.*;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.assertEquals;
import static org.testng.AssertJUnit.assertTrue;

public class UserManagementSteps extends BaseSteps {

    public static final String DEFAULT_SORT_BY = "dateCreated";
    private static final ImmutableMap<String, String> SORT_ORDER = new ImmutableMap.Builder<String, String>()
            .put("ASC", "+")
            .put("DESC", "-")
            .build();
    private static final String TEST_EMAIL = "%s@email.com";
    public static final String INTERNAL = "Internal";
    public static final String EXTERNAL = "External";
    private final UserManagementUserPage userPage;
    private final SearchSectionPage searchPage;
    private String firstName;
    private String lastName;
    private String email;
    private String role = EMPTY;

    public UserManagementSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.userPage = new UserManagementUserPage(this.driver, translator);
        this.searchPage = new SearchSectionPage(this.driver);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public UserData userDataEntry(Map<String, String> entry) {
        return UserData.builder()
                .firstName(entry.get(UserFields.FIRST_NAME.getDefaultName()))
                .lastName(entry.get(UserFields.LAST_NAME.getDefaultName()))
                .username(getUserName(entry.get(UserFields.USER_NAME.getDefaultName())))
                .userType(entry.get(UserFields.USER_TYPE.getDefaultName()))
                .role(entry.get(UserFields.ROLE.getDefaultName()))
                .status(entry.get(UserFields.STATUS.getDefaultName()))
                .singleSignOn(entry.get(SINGLE_SIGN_ON.getDefaultName()))
                .email(getUserName(entry.get(UserFields.EMAIL.getDefaultName())))
                .position(entry.get(POSITION.getDefaultName()))
                .group(entry.get(GROUP.getDefaultName()))
                .superior(entry.get(SUPERIOR.getDefaultName()))
                .externalOrganisation(entry.get(EXTERNAL_ORGANISATION.getDefaultName()))
                .department(entry.get(DEPARTMENT.getDefaultName()))
                .division(entry.get(DIVISION.getDefaultName()))
                .thirdParty(entry.get(UserFields.THIRD_PARTY.getDefaultName()))
                .defaultBillingEntity(entry.get(DEFAULT_BILLING_ENTITY.getDefaultName()))
                .otherBillingEntity(entry.get(OTHER_BILLING_ENTITY.getDefaultName()))
                .organisation(entry.get(ORGANISATION.getDefaultName()))
                .entity(nonNull(entry.get(ENTITY.getDefaultName())) ?
                                new UserData.Entity().setName(entry.get(ENTITY.getDefaultName())) : null)
                .build();
    }

    @DataTableType
    @SuppressWarnings("unused")
    public OOOData oooDataEntry(Map<String, String> entry) {
        return new OOOData().setName(getName(entry.get(OOOFields.NAME.getName())))
                .setDateTime(getTodayDate(entry.get(OOOFields.DATE_TIME.getName())).toUpperCase())
                .setOldValue(getHistoryValue(entry.get(OOOFields.OLD_VALUE.getName())))
                .setNewValue(getHistoryValue(entry.get(OOOFields.NEW_VALUE.getName())));
    }

    private String getUserName(String entry) {
        if (VALUE_TO_REPLACE.equals(entry)) {
            return Objects.nonNull(email) ? email : entry;
        } else if (EMAIL_CONTEXT.equals(entry)) {
            return (String) context.getScenarioContext().getContext(EMAIL_CONTEXT);
        } else if (nonNull(entry) && entry.contains(COM)) {
            return entry;
        } else if (nonNull(entry)) {
            return Config.get().value(entry);
        }
        return null;
    }

    private String getName(String entry) {
        UserData userData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        return entry.replace(VALUE_TO_REPLACE, userData.getUsername());
    }

    private String getHistoryValue(String entry) {
        return updateDate(updateUserEmail(entry)).replace(TODAY_LABEL, getTodayDate(DATE_TIME_FORMAT).toUpperCase());
    }

    private String updateUserEmail(String entry) {
        String userReference;
        Pattern patternText = Pattern.compile("\\((.+)\\)");
        Matcher m = patternText.matcher(entry);
        if (m.find()) {
            userReference = m.group(1);
            entry = entry.replace(userReference, Config.get().value(userReference));
        }
        return entry;
    }

    private String updateDate(String entry) {
        String dateReference;
        Pattern patternText = Pattern.compile("(TODAY[+-]\\d+)\\s");
        Matcher m = patternText.matcher(entry);
        if (m.find()) {
            dateReference = m.group(1);
            entry = entry.replace(dateReference, dateReference.contains(TODAY_MINUS) ?
                    getDateTimeBeforeToday(OOO_DATE_FORMAT, parseInt(dateReference.replace(TODAY_MINUS, EMPTY))) :
                    getDateAfterTodayDate(OOO_DATE_FORMAT, parseInt(dateReference.replace(TODAY, EMPTY))));
        }
        return entry;
    }

    private List<String> getExpectedDropDownOptions(String dropDownName) {
        switch (dropDownName) {
            case "Default Billing Entity":
            case "Other Billing Entity":
                return getActiveBillingEntities();
            case "Superior":
            case "Delegate to":
                return getFirstActiveUsers(20, INTERNAl_USER_TYPE).stream()
                        .filter(user -> user.getUsername() != null)
                        .map(user -> format(USER_FIRST_LAST_USERNAME_WITH_NEW_LINE, user.getFirstName(),
                                            user.getLastName(),
                                            user.getUsername()))
                        .collect(Collectors.toList());
            case "Role":
                return getAllFilteredRoles(true).getPayload().stream().map(role -> role.getName().trim())
                        .collect(toList());
            case "Group":
                return ConnectApi.getListOfActiveUserGroups().stream()
                        .map(group -> group.replace(DOUBLE_SPACE, SPACE).trim())
                        .collect(toList());
            case "Division":
                return getMyOrganizationFullDetails(Endpoints.DIVISION + ORGANISATION_GET)
                        .stream().filter(OrganizationPayload.ObjectsItem::getActive)
                        .map(OrganizationPayload.ObjectsItem::getName).collect(toList());
            case "Entity":
                return getMyOrganizationFullDetails(Endpoints.ENTITY + ORGANISATION_GET)
                        .stream().filter(OrganizationPayload.ObjectsItem::getActive)
                        .map(OrganizationPayload.ObjectsItem::getName).collect(toList());
            case "External Organisation":
                return getMyOrganizationFullDetails(Endpoints.EXTERNAL_ORGANISATION + ORGANISATION_GET)
                        .stream().filter(OrganizationPayload.ObjectsItem::getActive)
                        .map(OrganizationPayload.ObjectsItem::getName).collect(toList());
            case "Department":
                return getMyOrganizationFullDetails(Endpoints.DEPARTMENT + ORGANISATION_GET)
                        .stream().filter(OrganizationPayload.ObjectsItem::getActive)
                        .map(OrganizationPayload.ObjectsItem::getName).collect(toList());
            case "Status":
                return asList("New", "On-going");
            default:
                throw new IllegalArgumentException("Drop-down type: " + dropDownName + " is unexpected");
        }
    }

    @When("User navigates 'Set Up' block 'User' section")
    public void openSetupBlockUserSection() {
        userPage.navigateToUserManagementUserPage();
    }

    @When("User navigates to 'Add User' page")
    public void openAddUserPage() {
        userPage.navigateToUserManagementAddUserPage();
        userPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User navigates to 'View User' page of existing User")
    public void openViewUserPage() {
        String userId = (String) context.getScenarioContext().getContext(USER_ID);
        userPage.navigateToUserManagementViewUserPage(userId);
        userPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User navigates to 'Edit User' page of existing User")
    public void openEditUserPage() {
        String userId = (String) context.getScenarioContext().getContext(USER_ID);
        userPage.navigateToUserManagementEditUserPage(userId);
        userPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks 'Add New User' button")
    public void clickAddNewUserButton() {
        userPage.clickAddNewUserButton();
    }

    @When("User clicks 'Submit' button on User Page")
    public void clickSubmitButtonOnUserPage() {
        userPage.clicksUserPageSubmitButton();
    }

    @When("User clicks on back User Management button from User page")
    public void clickOnBackUserManagementButton() {
        userPage.clicksBackUserManagementButton();
        userPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("^User fills in \"((.*))\" (?:Add|Edit?) User value \"((.*))\"$")
    public void fillInAddUserValue(String fieldType, String value) {
        if (fieldType.equals(UserFields.EMAIL.getDefaultName()) && value.equals(VALUE_TO_REPLACE)) {
            email = context.getScenarioContext().isContains(EMAIL_CONTEXT) ?
                    (String) context.getScenarioContext().getContext(EMAIL_CONTEXT) :
                    format(TEST_EMAIL, randomUUID());
            userPage.clearAndTextField(UserFields.EMAIL.getName(), email);
        } else {
            value = value.equals(VALUE_TO_REPLACE) ? AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10) : value;
            if (fieldType.equals(FIRST_NAME.getDefaultName())) {
                firstName = value;
                userPage.clearAndTextField(FIRST_NAME.getName(), firstName);
                context.getScenarioContext().setContext(USER_FIRST_NAME, firstName);
            } else if (fieldType.equals(LAST_NAME.getDefaultName())) {
                lastName = value;
                userPage.clearAndTextField(LAST_NAME.getName(), lastName);
                context.getScenarioContext().setContext(USER_LAST_NAME, lastName);
            } else if (fieldType.equals(FROM.getDefaultName()) || fieldType.equals(TO.getDefaultName())) {
                value = value.contains(TODAY_MINUS) ?
                        getDateTimeBeforeToday(REACT_FORMAT, parseInt(value.replace(TODAY_MINUS, EMPTY))) :
                        getDateAfterTodayDate(REACT_FORMAT, parseInt(value.replace(TODAY, EMPTY)));
                userPage.clearAndTextField(fieldType, value);
            } else {
                fieldType = userPage.getFromDictionaryIfExists(fieldType);
                userPage.clearAndTextField(fieldType, value);
            }
        }
    }

    @When("^User selects in \"((.*))\" (?:Add|Edit?) User value \"((.*))\"$")
    public void selectInAddUserValue(String fieldType, String value) {
        userPage.waitWhilePreloadProgressbarIsDisappeared();
        if (OLD_ORGANISATION_NAME.equals(value)) {
            value = (String) context.getScenarioContext().getContext(OLD_ORGANISATION_NAME);
        }
        if (NEW_ORGANISATION_NAME.equals(value)) {
            value = (String) context.getScenarioContext().getContext(NEW_ORGANISATION_NAME);
        }
        if (fieldType.equals(ROLE.getDefaultName()) && value.equals(VALUE_TO_REPLACE)) {
            role = new RoleManagementSteps(context).getLastUserRoleTitleFromContext();
            userPage.selectFromDropDown(ROLE.getName(), role);
        } else if (fieldType.equals(ROLE.getDefaultName())) {
            userPage.selectFromDropDown(ROLE.getName(), value);
        } else if (fieldType.equals(ENTITY.getName()) && value.equals(VALUE_TO_REPLACE)) {
            String entity = (String) context.getScenarioContext().getContext(MY_ORGANISATION_ENTITY_NAME);
            userPage.selectFromDropDown(fieldType, entity);
        } else if (DIVISION.getDefaultName().equals(fieldType)) {
            userPage.cleanDivisionField();
            userPage.selectFromDropDown(userPage.getFromDictionaryIfExists(DIVISION.getName()), value);
        } else if (LANGUAGE.getDefaultName().equals(fieldType)) {
            userPage.selectFromDropDown(fieldType, value);
        } else {
            fieldType = userPage.getFromDictionaryIfExists(fieldType);
            userPage.selectFromDropDown(fieldType, value);
        }
    }

    @When("User searches user by first name")
    public void searchUserByFirstName() {
        firstName = nonNull(firstName) ? firstName :
                (String) context.getScenarioContext().getContext(USER_EDITED_FIRST_NAME);
        searchUserBy(firstName);
    }

    @When("User searches User by name {string}")
    public void searchUserByName(String firstName) {
        searchUserBy(firstName);
    }

    @When("User searches User by user reference {string}")
    public void searchUserByUserReference(String userReference) {
        UserData userData = getUserCredentialsByRole(userReference);
        searchUserBy(userData.getUsername());
    }

    @When("Open created user details")
    public void searchAndOpenCreatedUserDetails() {
        searchUserBy(firstName);
        clickUpdatedUserByName(firstName);
    }

    @When("User searches user by {string} keyword")
    public void searchUserBy(String keyWord) {
        switch (keyWord) {
            case USER_EDITED_FIRST_NAME:
                keyWord = (String) context.getScenarioContext().getContext(USER_EDITED_FIRST_NAME);
                firstName = keyWord;
                break;
            case USER_EDITED_LAST_NAME:
                keyWord = (String) context.getScenarioContext().getContext(USER_EDITED_LAST_NAME);
                break;
            case USER_LAST_NAME:
                keyWord = lastName;
                break;
            case USER_FIRST_NAME + SPACE + USER_LAST_NAME:
                keyWord = firstName + SPACE + lastName;
                break;
        }
        searchPage.searchItem(keyWord);
    }

    @When("User clicks edit user button by name")
    public void clickEditUserButtonByName() {
        userPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        clickEditUserButton(firstName);
    }

    @When("User clicks edit user button for user with First Name {string}")
    public void clickEditUserButton(String firstName) {
        userPage.clickEditUserByName(firstName);
        userPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks on updated user")
    public void clickUpdatedUser() {
        clickUpdatedUserByName(firstName);
    }

    @When("User clicks on user with First Name {string}")
    public void clickUpdatedUserByName(String name) {
        userPage.clickOnUserByName(name);
    }

    @When("User clicks on user with User Name {string}")
    public void clickUpdatedUserByUserName(String userName) {
        userPage.clickOnUserByUserName(userName);
    }

    @When("Users clicks {string} column header")
    public void clickColumnHeader(String columnName) {
        userPage.waitWhilePreloadProgressbarIsDisappeared();
        userPage.clickOnTableColumn(columnName);
    }

    @When("Users clicks on {int} users table row")
    public void clickOnUsersTableRow(int rowNo) {
        userPage.clickOnUsersTableRow(rowNo);
    }

    @When("^User (unchecks|checks) 'Active' Edit User checkbox$")
    public void uncheckActiveEditUserCheckbox(String state) {
        if ((state.equals(UNCHECKS) && userPage.isActiveCheckboxChecked()) ||
                (state.equals(CHECKS)) && !userPage.isActiveCheckboxChecked()) {
            userPage.checkActiveCheckbox();
        }
    }

    @When("User unchecks 'Enable Single Sign On' Edit User checkbox")
    public void uncheckEnableSingleSignOnCheckbox() {
        if (userPage.isEnableSingleSignOnCheckboxChecked()) {
            userPage.checkEnableSingleSignOnCheckbox();
        }
    }

    @When("User checks 'Enable Single Sign On' Edit User checkbox")
    public void checkEnableSingleSignOnEditUserCheckbox() {
        userPage.waitWhilePreloadProgressbarIsDisappeared();
        if (!userPage.isEnableSingleSignOnCheckboxChecked()) {
            userPage.checkEnableSingleSignOnCheckbox();
        }
    }

    @When("User creates internal user with data {string}")
    public void createInternalUserWithData(String userReference) {
        UserData userData = new JsonUiDataTransfer<UserData>(USER).getTestData().get(userReference).getDataToEnter();
        userPage.navigateToUserManagementUserPage();
        userPage.clickAddNewUserButton();
        userPage.waitWhilePreloadProgressbarIsDisappeared();
        userData.setFirstName(userData.getFirstName().isEmpty() ? AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10) :
                                      userData.getFirstName());
        userData.setLastName(userData.getLastName().isEmpty() ? AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10) :
                                     userData.getLastName());
        userData.setUsername(
                Strings.isNullOrEmpty(userData.getUsername()) ?
                        AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10) + "@lseg.com" :
                        Config.get().value(userData.getUsername()));
        userPage.fillInUserData(userData);
        context.getScenarioContext().setContext(userReference, userData);
    }

    @When("User selects {string} user Third-party")
    public void selectUserThirdParty(String thirdPartyReference) {
        String thirdPartyName = (String) context.getScenarioContext().getContext(thirdPartyReference);
        userPage.selectFromDropDown(THIRD_PARTY, thirdPartyName);
    }

    @When("User clicks User Overview Edit button")
    public void clickUserOverviewEditButton() {
        userPage.clickUserOverviewEditButton();
    }

    @When("User clicks 'Cancel' button on User Page")
    public void userClicksCancelButtonOnUserPage() {
        userPage.clickCancelButton();
    }

    @When("User clears User form fields")
    public void clearUserFormFields(List<String> fields) {
        fields.forEach(userPage::clearField);
    }

    @When("User hovers over User overview Edit icon")
    public void hoverOverUserOverviewEditIcon() {
        userPage.hoverOverEditIcon();
    }

    @When("User clicks User form button {string}")
    public void clickUserFormButton(String buttonName) {
        userPage.clickUserButton(buttonName);
    }

    @When("User hovers over User overview button {string}")
    public void hoverOverUserOverviewButton(String buttonName) {
        userPage.hoverUserButton(buttonName);
    }

    @When("User clicks User Management Deactivate button")
    public void clickUserManagementDeactivateButton() {
        userPage.clickDeactivateButton();
    }

    @When("User checks User table checkbox for row {int}")
    public void checkUserTableCheckboxForRow(int rowNo) {
        userPage.clickRowCheckbox(rowNo);
    }

    @When("User hovers over User table checkbox for row {int}")
    public void hoverOverUserTableCheckboxForRow(int rowNo) {
        userPage.hoverRowCheckbox(rowNo);
    }

    @When("User saves random User id to context")
    public void saveRandomUserIdToContext() {
        String userId = AppApi.getActiveUsersFromPublicApi().findAny()
                .orElseThrow(() -> new RuntimeException("No roles are found"))
                .getId();
        context.getScenarioContext().setContext(USER_ID, userId);
    }

    @When("User hovers User form status icon")
    public void hoverUserFormStatusIcon() {
        userPage.hoverStatusIcon();
    }

    @When("User updated OOO delegations {int} times")
    public void userUpdatedOOODelegationsTimes(int count) {
        for (int i = 1; i <= count; i++) {
            userPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
            fillInAddUserValue(OOOFields.FROM.getName(), TODAY_MINUS + i);
            clickUserFormButton(SAVE);
            userPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        }
    }

    @Then("Verify role name on user details was changed")
    public void verifyRoleNameWasChanged() {
        userPage.waitWhilePreloadProgressbarIsDisappeared();
        String expectedRole = new RoleManagementSteps(context).getLastUserRoleTitleFromContext();
        String actualRole = userPage.getUserOverviewDetails().getRole();
        assertEquals(format("Actual role name '%s' on user details page is different from expected one '%s'",
                            actualRole, expectedRole), expectedRole, actualRole);
    }

    @Then("Add User page is loaded")
    public void addUserModalIsDisplayed() {
        userPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertTrue("Add User page is not displayed", userPage.isAddUserModalDisplayed());
    }

    @Then("Add User page is closed")
    public void addUserModalIsDisappeared() {
        assertTrue("Add User page is not closed", userPage.isAddUserModalDisappeared());
    }

    @Then("Edit User page is displayed")
    public void editUserModalIsDisplayed() {
        assertTrue("Edit User page is not displayed", userPage.isEditUserPageDisplayed());
    }

    @Then("Overview User modal is displayed")
    public void userOverviewModalIsDisplayed() {
        userPage.waitWhilePreloadProgressbarIsDisappeared();
        assertTrue("User overview modal is not displayed", userPage.isUserOverviewModalDisplayed());
    }

    @Then("Overview User modal is disappeared")
    public void userOverviewModalIsDisappeared() {
        assertTrue("View User modal is not disappeared", userPage.isUserOverviewModalDisappeared());
    }

    @Then("User Type is {string}")
    public void userTypeIs(String expectedUserType) {
        assertEquals("User Type is not expected", expectedUserType, userPage.getUserType());
    }

    @Then("^User table (contains|doesn't contain) user with values$")
    public void userTableContainsUserWithValues(String state, UserData expectedUserData) {
        userPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (nonNull(expectedUserData.getSingleSignOn())) {
            expectedUserData.setSingleSignOn(userPage.getFromDictionaryIfExists(expectedUserData.getSingleSignOn()));
        }
        if (VALUE_TO_REPLACE.equals(expectedUserData.getFirstName())) {
            expectedUserData.setFirstName(firstName);
        } else if (USER_EDITED_FIRST_NAME.equals(expectedUserData.getFirstName())) {
            expectedUserData.setFirstName((String) context.getScenarioContext().getContext(USER_EDITED_FIRST_NAME));
        }
        if (VALUE_TO_REPLACE.equals(expectedUserData.getLastName())) {
            expectedUserData.setLastName(lastName);
        } else if (USER_EDITED_LAST_NAME.equals(expectedUserData.getLastName())) {
            expectedUserData.setLastName((String) context.getScenarioContext().getContext(USER_EDITED_LAST_NAME));
        }
        if (VALUE_TO_REPLACE.equals(expectedUserData.getUsername())) {
            expectedUserData.setUsername(email);
        }
        if (!role.isEmpty()) {
            expectedUserData.setRole(role);
        }
        if (state.equals(CONTAINS)) {
            assertThat(userPage.getUsersList()).as("User table doesn't contain user with values")
                    .contains(expectedUserData);
        } else {
            assertThat(userPage.getUsersList()).as("User table contains user with values")
                    .doesNotContain(expectedUserData);
        }

    }

    @Then("First fined user is displayed with values")
    public void userDisplayedWithValues(UserData expectedUserData) {
        userPage.waitWhilePreloadProgressbarIsDisappeared();
        if (nonNull(expectedUserData.getSingleSignOn())) {
            expectedUserData.setSingleSignOn(userPage.getFromDictionaryIfExists(expectedUserData.getSingleSignOn()));
        }
        if (VALUE_TO_REPLACE.equals(expectedUserData.getFirstName())) {
            expectedUserData.setFirstName(firstName);
        }
        if (VALUE_TO_REPLACE.equals(expectedUserData.getUsername())) {
            expectedUserData.setUsername(email);
        }
        if (!role.isEmpty()) {
            expectedUserData.setRole(role);
        }
        assertThat(userPage.getUsersList().get(0)).usingRecursiveComparison().ignoringExpectedNullFields()
                .isEqualTo(expectedUserData);
    }

    @Then("User overview is displayed with values")
    public void userOverviewDisplayedWithValues(UserData expectedUserData) {
        userPage.waitWhilePreloadProgressbarIsDisappeared();
        if (VALUE_TO_REPLACE.equals(expectedUserData.getFirstName())) {
            firstName = nonNull(firstName) ? firstName :
                    (String) context.getScenarioContext().getContext(USER_EDITED_FIRST_NAME);
            expectedUserData.setFirstName(firstName);
        }
        if (VALUE_TO_REPLACE.equals(expectedUserData.getLastName())) {
            expectedUserData.setLastName((String) context.getScenarioContext().getContext(USER_EDITED_LAST_NAME));
        }
        if (VALUE_TO_REPLACE.equals(expectedUserData.getPosition())) {
            expectedUserData.setPosition((String) context.getScenarioContext().getContext(USER_EDITED_POSITION));
        }
        if (VALUE_TO_REPLACE.equals(expectedUserData.getUsername())) {
            expectedUserData.setUsername(email);
        }
        if (VALUE_TO_REPLACE.equals(expectedUserData.getEmail())) {
            expectedUserData.setEmail(email);
        }
        if (OLD_ORGANISATION_NAME.equals(expectedUserData.getDepartment())) {
            expectedUserData.setDepartment((String) context.getScenarioContext().getContext(OLD_ORGANISATION_NAME));
        }
        if (NEW_ORGANISATION_NAME.equals(expectedUserData.getDepartment())) {
            expectedUserData.setDepartment((String) context.getScenarioContext().getContext(NEW_ORGANISATION_NAME));
        }
        if (OLD_ORGANISATION_NAME.equals(expectedUserData.getExternalOrganisation())) {
            expectedUserData.setExternalOrganisation(
                    (String) context.getScenarioContext().getContext(OLD_ORGANISATION_NAME));
        }
        if (NEW_ORGANISATION_NAME.equals(expectedUserData.getExternalOrganisation())) {
            expectedUserData.setExternalOrganisation(
                    (String) context.getScenarioContext().getContext(NEW_ORGANISATION_NAME));
        }
        if (nonNull(expectedUserData.getEntity()) &&
                OLD_ORGANISATION_NAME.equals(expectedUserData.getEntity().getName())) {
            expectedUserData.setEntity(new UserData.Entity().setName(
                    (String) context.getScenarioContext().getContext(OLD_ORGANISATION_NAME)));
        }
        if (nonNull(expectedUserData.getEntity()) &&
                NEW_ORGANISATION_NAME.equals(expectedUserData.getEntity().getName())) {
            expectedUserData.setEntity(new UserData.Entity().setName(
                    (String) context.getScenarioContext().getContext(NEW_ORGANISATION_NAME)));
        }
        if (OLD_ORGANISATION_NAME.equals(expectedUserData.getDivision())) {
            expectedUserData.setDivision((String) context.getScenarioContext().getContext(OLD_ORGANISATION_NAME));
        }
        if (NEW_ORGANISATION_NAME.equals(expectedUserData.getDivision())) {
            expectedUserData.setDivision((String) context.getScenarioContext().getContext(NEW_ORGANISATION_NAME));
        }

        assertThat(userPage.getUserOverviewDetails()).usingRecursiveComparison().ignoringExpectedNullFields()
                .isEqualTo(expectedUserData);
    }

    @Then("Users table is displayed with columns")
    public void usersTableIsDisplayedWithColumns(DataTable dataTable) {
        List<String> expectedColumns = dataTable.asList();
        List<String> actualColumns = userPage.getColumnNames();
        assertThat(actualColumns)
                .as("Users table is not displayed with expected columns")
                .isEqualTo(expectedColumns);
    }

    @Then("Users table is displayed")
    public void usersTableIsDisplayed() {
        assertTrue("Users table is not displayed", userPage.isUsersTableDisplayed());
    }

    @Then("All User details should be uneditable")
    public void allUserDetailsShouldBeUneditable() {
        assertTrue("User details is editable", userPage.areUserInputFieldInvisible());
    }

    @Then("Users table is sorted according to Date creation in Descending order")
    public void usersTableIsSortedByDefault() {
        List<UserData> expectedUsersList =
                getUsersByPublicApi(DEFAULT_ITEMS_PER_PAGE, DEFAULT_PAGE, SORT_ORDER.get(DESC), DEFAULT_SORT_BY);
        List<UserData> actualUsersList = userPage.getUsersList();
        assertThat(actualUsersList).as("Users table is not sorted according to Date creation in Descending order")
                .usingRecursiveComparison().ignoringFields("id", "name", "entity", "organisation", "thirdParty")
                .isEqualTo(expectedUsersList);
    }

    @Then("Users table displays users sorted by {string} in {string} order")
    public void usersTableIsSortedByField(String columnName, String sortOrder) {
        userPage.waitWhilePreloadProgressbarIsDisappeared();
        List<String> valuesList = userPage.getListValuesForColumn(columnName);
        tableIsSortedByInOrder("Users Table", columnName, sortOrder, REACT_FORMAT, valuesList, false);
    }

    @Then("The page should contain the message {string}")
    public void thePageShouldContainTheMessageNoMatchFound(String pageMessage) {
        assertThat(userPage.getNoRecordsTextMatched())
                .as("The page is not contains the message " + pageMessage)
                .isEqualTo(pageMessage);
    }

    @Then("User table should display user accounts that contain the provided {string} keyword")
    public void userTableShouldDisplayFilteredResults(String keyWord) {
        assertTrue("User table is not filtered by " + keyWord + " keyword",
                   userPage.isUserResultsFilteredByKeyword(keyWord));
    }

    @Then("'Edit' icon should be displayed for each user record")
    public void editIconShouldBeDisplayedForEachUserRecord() {
        assertTrue("'Edit' icon should be displayed for each user record",
                   userPage.isEditIconDisplayedForEachRecord());
    }

    @Then("User Overview {string} field is displayed with {string}")
    public void isFieldDisplayedWithValue(String fieldName, String value) {
        fieldName = userPage.getFromDictionaryIfExists(fieldName);
        userPage.waitWhilePreloadProgressbarIsDisappeared();
        if (value.equals(VALUE_TO_REPLACE)) {
            value = (String) context.getScenarioContext().getContext(USER_GROUP_NAME_CONTEXT + 0);
        }
        if (isEmpty(value)) {
            assertThat(userPage.getOverviewValue(fieldName)).as(
                            fieldName + " is displayed with unexpected value: " + value)
                    .isNull();
        } else {
            assertThat(userPage.getOverviewValue(fieldName)).as(
                            fieldName + " is displayed with unexpected value: " + value)
                    .contains(value);
        }
    }

    @Then("^External user with \"((.*))\" data (is not|is) created$")
    public void externalUserWithDataIsNotCreated(String userReference, String state) {
        AssociatedPartyIndividualData
                associatedPartyIndividualData = new JsonUiDataTransfer<AssociatedPartyIndividualData>(
                DataProvider.ASSOCIATED_PARTY_INDIVIDUAL).getTestData()
                .get(userReference).getDataToEnter();
        List<UserData> userList = getUsers(USERS_ITEMS_PER_PAGE, ZERO, DESC, DATE_CREATED).getPayload().getData();
        if (state.contains(NOT)) {
            for (UserData user : userList) {
                if (Config.get().value(associatedPartyIndividualData.getEmailAddress()).equals(user.getUsername())) {
                    throw new SkipException(associatedPartyIndividualData.getFirstName() + " already exists!");
                }
            }
        } else {
            assertThat(userList.stream().anyMatch(
                    user -> user.getEmail().equals(associatedPartyIndividualData.getEmailAddress())))
                    .as("External user with name: %s is not created", userReference)
                    .isTrue();
        }
    }

    @Then("^Internal user with \"((.*))\" data (is not|is) created$")
    public void internalUserWithDataIsNotCreated(String userReference, String state) {
        UserData userData = new JsonUiDataTransfer<UserData>(USER).getTestData().get(userReference).getDataToEnter();
        List<UserData> userList = getUsers(USERS_ITEMS_PER_PAGE, ZERO, DESC, DATE_CREATED).getPayload().getData();
        if (state.contains(NOT)) {
            for (UserData user : userList) {
                if (Config.get().value(userData.getUsername()).equals(user.getUsername())) {
                    throw new SkipException(userData.getFirstName() + " already exists!");
                }
            }
        } else {
            assertThat(userList.stream().anyMatch(user -> userData.getEmail().equals(user.getEmail())))
                    .as("Internal user with name: %s is not created", userReference)
                    .isTrue();
        }
    }

    @Then("{string} icon tooltip should be displayed for each user record")
    public void editIconTooltipShouldBeDisplayedForEachUserRecord(String expectedResult) {
        assertThat(userPage.getEditIconsTooltips())
                .as("Edit icon tooltip is unexpected")
                .containsOnly(expectedResult);
    }

    @Then("User table Third-party columns non empty for External users")
    public void userTableThirdPartyColumnsNonEmptyForExternalUsers() {
        SoftAssertions softAssertions = new SoftAssertions();
        List<String> columnValuesForInternalUsers = userPage.getListThirdPartyForColumnWithType(INTERNAL);
        List<String> columnValuesForExternalUsers = userPage.getListThirdPartyForColumnWithType(EXTERNAL);
        softAssertions.assertThat(columnValuesForInternalUsers.stream().allMatch(Objects::isNull))
                .as("Internal User Third-party values are unexpected")
                .isTrue();
        softAssertions.assertThat(columnValuesForExternalUsers.stream().allMatch(Objects::nonNull))
                .as("External User Third-party values are unexpected")
                .isTrue();
        softAssertions.assertAll();
    }

    @Then("User table {string} column contains only values")
    public void userTableColumnContainsOnlyValues(String columnName, List<String> expectedResult) {
        assertThat(userPage.getListValuesForColumn(columnName)).as("Column %s values are unexpected", columnName)
                .containsAnyElementsOf(expectedResult);
    }

    @Then("^User creation form (contains|doesn't contain) required indicator for fields$")
    public void userCreationFormContainsRequiredIndicatorForFields(String state, List<String> fieldNames) {
        boolean expectedResult = state.equals(CONTAINS);
        SoftAssertions softAssert = new SoftAssertions();
        fieldNames.forEach(fieldName -> softAssert.assertThat(userPage.isRequiredIndicatorDisplayedForField(fieldName))
                .as("Required indicator is unexpected for field %s", fieldName)
                .isEqualTo(expectedResult)
        );
        softAssert.assertAll();
    }

    @Then("^User form button \"((.*))\" is (displayed|not displayed)$")
    public void userFormButtonIsDisplayed(String buttonName, String state) {
        if (state.contains(NOT)) {
            assertThat(userPage.isButtonWithNameDisplayed(buttonName))
                    .as("User form button %s is displayed", buttonName)
                    .isFalse();
        } else {
            assertThat(userPage.isButtonWithNameDisplayed(buttonName))
                    .as("User form button %s is not displayed", buttonName)
                    .isTrue();
        }
    }

    @Then("Under User Form {string} field there is an error message: {string}")
    public void verifyFieldErrorMessage(String fieldName, String errorMessage) {
        assertThat(userPage.getErrorMessageOnFormField(fieldName))
                .as("Form field error message isn't matched with expected one")
                .isEqualTo(errorMessage);
    }

    @Then("User form system notice is displayed {string}")
    public void userFormSystemNoticeIsDisplayed(String expectedMessage) {
        assertThat(userPage.getNoticeMessage())
                .as("System notice is unexpected")
                .isEqualTo(expectedMessage);
    }

    @Then("^User form \"((.*))\" section (is not|is) displayed$")
    public void userFormSectionIsNotDisplayed(String sectionName, String state) {
        if (state.contains(NOT)) {
            assertThat(userPage.isSectionDisplayed(sectionName))
                    .as("%s section is displayed", sectionName)
                    .isFalse();
        } else {
            assertThat(userPage.isSectionDisplayed(sectionName))
                    .as("%s section is not displayed", sectionName)
                    .isTrue();
        }
    }

    @Then("User Type is not editable")
    public void userTypeIsNotEditable() {
        assertThat(userPage.isUserTypeDisabled())
                .as("User Type is editable")
                .isTrue();
    }

    @Then("Username is not editable")
    public void usernameIsNotEditable() {
        assertThat(userPage.isUsernameDisabled())
                .as("Username is editable")
                .isTrue();
    }

    @Then("Create User page is displayed with default values")
    public void createUserPageIsDisplayedWithDefaultValues() {
        UserData expected = new UserData().setOrganisation(RFG)
                .setSingleSignOn(NO)
                .setUserType(INTERNAL)
                .setStatus(CaseUtils.toCamelCase(ACTIVE, true))
                .setEntity(new UserData.Entity());
        assertThat(userPage.getEditUserDetails())
                .as("Create User page default values are unexpected")
                .isEqualTo(expected);
    }

    @Then("User {string} drop-down contains expected values")
    public void userDropDownContainsExpectedValues(String dropDownName) {
        List<String> expectedResult = getExpectedDropDownOptions(dropDownName);
        userPage.clickDropDownButton(dropDownName);
        List<String> actualResult = userPage.getDropDownOptions();
        actualResult.remove(DROPDOWN_PLACEHOLDER);
        assertThat(actualResult)
                .as("%s drop-down does not contain expected values", dropDownName)
                .containsExactlyInAnyOrderElementsOf(expectedResult);
        userPage.clickDropDownButton(dropDownName);
    }

    @Then("User form text fields max length is {string} symbols")
    public void userFormTextFieldsMaxLengthIsSymbols(String maxLength, List<String> fields) {
        SoftAssertions softAssert = new SoftAssertions();
        fields.forEach(field -> softAssert.assertThat(userPage.getFieldMaxLength(field))
                .as("Field %s max length is unexpected")
                .isEqualTo(maxLength));
        softAssert.assertAll();
    }

    @Then("User form organisation not editable")
    public void userFormOrganisationNotEditable() {
        assertThat(userPage.isOrganisationDisabled())
                .as("Organisation is editable")
                .isTrue();
    }

    @Then("^User form \"((.*))\" is (unchecked|checked)$")
    public void userFormEnableSingleSignOnIsUnchecked(String checkboxName, String state) {
        userPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (state.equals(TestConstants.CHECKED)) {
            assertThat(userPage.isUserInputFieldChecked(checkboxName))
                    .as("%s checkbox is not checked", checkboxName)
                    .isTrue();
        } else {
            assertThat(userPage.isUserInputFieldChecked(checkboxName))
                    .as("%s checkbox is not unchecked", checkboxName)
                    .isFalse();
        }
    }

    @Then("^User creation form fields (are|are not) editable$")
    public void userCreationFormFieldsAreEditable(String state, List<String> fields) {
        SoftAssertions softAssert = new SoftAssertions();
        fields.forEach(field -> {
            if (state.contains(NOT)) {
                softAssert.assertThat(userPage.isUserInputFieldEditable(field))
                        .as("%s field is editable", field)
                        .isFalse();
            } else {
                softAssert.assertThat(userPage.isUserInputFieldEditable(field))
                        .as("%s field is not editable", field)
                        .isTrue();
            }
        });
        softAssert.assertAll();
    }

    @Then("User overview form fields are not editable")
    public void userOverviewFormFieldsAreNotEditable(List<String> fields) {
        SoftAssertions softAssert = new SoftAssertions();
        fields.forEach(field -> softAssert.assertThat(userPage.isInputFieldUneditable(field))
                .as("User overview form input %s is displayed or enabled", field)
                .isTrue());
        softAssert.assertAll();
    }

    @Then("User form button {string} is disabled")
    public void userFormButtonIsDisabled(String buttonName) {
        assertThat(userPage.isUserButtonDisabled(buttonName))
                .as("%s button is not disabled", buttonName)
                .isTrue();
    }

    @Then("User table checkbox for row {int} is disabled")
    public void userTableCheckboxForRowIsDisabled(int rowNo) {
        assertThat(userPage.isUserRowCheckboxDisabled(rowNo))
                .as("User row No%s checkbox is not disabled", rowNo)
                .isTrue();
    }

    @Then("User form OOO notice is displayed")
    public void userFormOOONoticeIsDisplayed() {
        String expectedNotice =
                "This allows tasks to be automatically re-routed to another user during the out of office period. Please note that once saved, you can only modify the out of office settings before the scheduled job activates. Once activated, you need to click the \"Back To Office\" button first and complete the set-up process again for any modifications.Dismiss";
        assertThat(userPage.getOOONotice())
                .as("OOO notice is unexpected")
                .isEqualTo(expectedNotice);
    }

    @Then("User form calendar button is displayed for fields")
    public void userFormCalendarButtonIsDisplayedForFields(List<String> fields) {
        SoftAssertions softAssertions = new SoftAssertions();
        fields.forEach(field -> softAssertions.assertThat(userPage.isCalendarDisplayed(field))
                .as("Calendar is not displayed for field %s", field)
                .isTrue());
        softAssertions.assertAll();
    }

    @Then("User form timepicker button is displayed for Time fields")
    public void userFormTimepickerButtonIsDisplayedForTimeFields() {
        assertThat(userPage.getTimepickerCount())
                .as("Timepicker button is not displayed for both Time fields")
                .isEqualTo(2);
    }

    @Then("User form fields are empty")
    public void userFormFieldsAreEmpty(List<String> fields) {
        SoftAssertions softAssertions = new SoftAssertions();
        fields.forEach(field -> softAssertions.assertThat(userPage.getEditValue(field))
                .as("User form field %s value is not empty", field)
                .isNull());
        softAssertions.assertAll();
    }

    @Then("^User form Status field is (disabled|enabled)$")
    public void userFormStatusFieldIsInState(String state) {
        if (state.equals(DISABLED)) {
            assertThat(userPage.isStatusFieldDisabled()).as("Status input is not disabled").isTrue();
        } else {
            assertThat(userPage.isStatusFieldDisabled()).as("Status input is not enabled").isFalse();
        }
    }

    @Then("User form OOO history message {string} is displayed")
    public void userFormOOOHistoryMessageIsDisplayed(String expectedMessage) {
        assertThat(userPage.getHistoryMessage())
                .as("OOO history message is unexpected")
                .isEqualTo(expectedMessage);
    }

    @Then("User for OOO History table is displayed with last record")
    public void userForOOOHistoryTableIsDisplayedWithRecord(OOOData expectedData) {
        userPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        SoftAssertions softAssertions = new SoftAssertions();
        OOOData actualLastRecord = userPage.getOOOTableRecords().get(0);
        long difference = Math.abs(getSecondsDifferenceWithCurrentDate(
                getDateFromStringDate(actualLastRecord.getDateTime(), DATE_TIME_FORMAT).getTime()));
        logger.info("Difference between row and current date in seconds: " + difference);
        softAssertions.assertThat(actualLastRecord.getDateTime().equals(expectedData.getDateTime()) ||
                                          difference <= MINUTE)
                .as("OOO history Date/Time is unexpected")
                .isTrue();
        softAssertions.assertThat(actualLastRecord)
                .usingRecursiveComparison().ignoringFields("dateTime")
                .as("OOO History table doesn't contains record")
                .isEqualTo(expectedData);
        softAssertions.assertAll();
    }

}
