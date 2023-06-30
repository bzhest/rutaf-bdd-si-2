package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.userManagement;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.AppApi;
import com.refinitiv.asts.test.ui.api.model.userRole.UserRoleResponse;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.enums.Colors;
import com.refinitiv.asts.test.ui.enums.UserRoleFields;
import com.refinitiv.asts.test.ui.pageActions.SearchSectionPage;
import com.refinitiv.asts.test.ui.pageActions.setUp.userManagement.UserManagementRolePage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserRoleData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.assertj.core.api.Assertions;
import org.assertj.core.api.SoftAssertions;
import org.testng.SkipException;
import org.testng.asserts.SoftAssert;
import org.testng.util.Strings;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.api.AppApi.getAllRoles;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.CHECKED;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.Pages.VIEW_ROLE_PATH;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.USER_ROLE;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.enums.Status.INACTIVE;
import static com.refinitiv.asts.test.ui.enums.UserRoleFields.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static java.lang.String.format;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.StringUtils.LF;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.*;

public class RoleManagementSteps extends BaseSteps {

    private final UserManagementRolePage userRoleFormPage;
    private final SearchSectionPage searchPage;
    private UserRoleData roleData;
    private String roleReference;
    private int roleNumber = 0;

    public RoleManagementSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.userRoleFormPage = new UserManagementRolePage(this.driver, this.context, translator);
        searchPage = new SearchSectionPage(this.driver);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public UserRoleData roleDataEntry(Map<String, String> entry) {
        return new UserRoleData(
                entry.get(UserRoleFields.NAME.getField()),
                entry.get(STATUS.getField())
        );
    }

    @When("User navigates to 'Add Role' page")
    public void navigateToAddTypePage() {
        userRoleFormPage.navigateToUserManagementAddRolePage();
        userRoleFormPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User navigates to 'View Role' page of existing Role")
    public void openViewUserPage() {
        String roleId = (String) context.getScenarioContext().getContext(USER_ROLE_ID);
        userRoleFormPage.navigateToUserManagementViewRolePage(roleId);
        userRoleFormPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User navigates to 'Edit Role' page of existing Role")
    public void openEditUserPage() {
        String roleId = (String) context.getScenarioContext().getContext(USER_ROLE_ID);
        userRoleFormPage.navigateToUserManagementEditRolePage(roleId);
        userRoleFormPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User navigates 'Set Up' block 'Role' section")
    public void openSetupBlockRoleSection() {
        userRoleFormPage.openUserRolePage();
    }

    @When("User clicks 'Add New Role' button")
    public void clickAddNewRoleButton() {
        userRoleFormPage.clickAddNewRoleButton();
    }

    @When("Skip test if existing roles number exceeds limit in {int} roles")
    public void skipTestIfExistingRolesNumberExceedsLimit(Integer rolesLimit) {
        int existingRolesNumber = getAllRoles().getPayload().size();
        if (existingRolesNumber >= rolesLimit) {
            throw new SkipException(
                    format("New role can't be created because roles number limit '%s' is exceed", rolesLimit));
        }
    }

    @When("User clicks 'Deactivate' button")
    public void clickDeactivateButton() {
        userRoleFormPage.clickDeactivateButton();
    }

    @When("User clicks 'Delete' button")
    public void clickDeleteButton() {
        String userRoleTitle = getLastUserRoleTitleFromContext();
        userRoleFormPage.clickDeleteButton(userRoleTitle);
    }

    @When("^Add (Active|Inactive) role with \"(.+)\" data$")
    public void addRole(String roleStatus, String roleReference) {
        clickAddNewRoleButton();
        fillRolePageHeader(roleReference);
        if (roleStatus.equals(INACTIVE.getStatus()) && userRoleFormPage.isActiveCheckboxChecked()) {
            userRoleFormPage.tickActiveCheckbox();
        }
        clickSubmitFormButton();
        verifyRoleFormIsClosed(ADD_ROLE);
        userRoleFormPage.waitWhileLoadingImageIsDisappeared();
        setLastUserRoleIdToContext();
    }

    @When("User fills name in header with empty data")
    public void fillEmptyNameInHeader() {
        userRoleFormPage.fillRoleName("");
    }

    @When("User fills new name in header")
    public void fillNameInHeader() {
        String userRoleTitle = AUTO_TEST_NAME_PREFIX + RandomStringUtils.randomAlphanumeric(10);
        userRoleFormPage.fillRoleName(userRoleTitle);
        setLastUserRoleTitleToContext(userRoleTitle);
    }

    @When("User fills User Role page header with {string} data")
    public void fillRolePageHeader(String roleReference) {
        String roleName = fillRolePageHeaderWithoutContext(roleReference);
        setLastUserRoleTitleToContext(roleName);
    }

    @When("User fills User Role page header with {string} data without saving to context")
    public String fillRolePageHeaderWithoutContext(String roleReference) {
        UserRoleData userRoleHeader = getUserRoleData(roleReference);
        if (Strings.isNullOrEmpty(userRoleHeader.getName())) {
            userRoleHeader.setName(AUTO_TEST_NAME_PREFIX + RandomStringUtils.randomAlphanumeric(10));
        }
        userRoleFormPage.fillAddRoleHeader(userRoleHeader);
        return userRoleHeader.getName();
    }

    @When("User fills User Role page header with {string} data without context")
    public void fillFormHeaderNoContext(String roleReference) {
        UserRoleData userRoleHeader = getUserRoleData(roleReference);
        userRoleFormPage.fillAddRoleHeader(userRoleHeader);
    }

    @When("User fills Third-party block with {string} data")
    public void fillFormThirdPartyBlock(String roleReference) {
        userRoleFormPage.fillThirdPartyBlock(getUserRoleData(roleReference));
    }

    @When("User edits Third-party privileges with {string} data")
    public void editFormThirdPartyBlock(String roleReference) {
        userRoleFormPage.editThirdPartyBlock(getUserRoleData(roleReference));
    }

    @When("User fills reports block with {string} data")
    public void fillFormReportsBlock(String roleReference) {
        userRoleFormPage.fillReportsBlock(getUserRoleData(roleReference));
    }

    @When("User fills setUp block with {string} data")
    public void fillFormSetUpBlock(String roleReference) {
        userRoleFormPage.fillSetUpBlock(getUserRoleData(roleReference));
    }

    @When("User fills Data Providers block with {string} data")
    public void fillFormDataProviderBlock(String roleReference) {
        userRoleFormPage.fillDataProviderBlock(getUserRoleData(roleReference));
    }

    @When("User fills Bulk Processing block with {string} data")
    public void fillBulkProcessingBlockWithData(String roleReference) {
        userRoleFormPage.fillBulkProcessingBlock(getUserRoleData(roleReference));
    }

    @When("User fills ddOrdering block with {string} data")
    public void fillFormDueDiligenceOrderBlock(String roleReference) {
        userRoleFormPage.fillDueDiligenceOrderBlock(getUserRoleData(roleReference));
    }

    @When("User clicks 'Submit' Role Management button")
    public void clickSubmitFormButton() {
        userRoleFormPage.clickSubmitFormButton();
    }

    @When("User clicks 'Cancel' button")
    public void clickCancelFormButton() {
        userRoleFormPage.clickCancelFormButton();
    }

    @When("User clicks Back button on Role form")
    public void clickCloseFormButton() {
        userRoleFormPage.clickBackButton();
    }

    @When("Skip User Role {string} creation if already exists")
    public void checkRoleExistAndSkip(String roleReference) {
        UserRoleData userRoleHeader = getUserRoleData(roleReference);
        String userRoleName = userRoleHeader.getName();
        String userRoleDescription =
                nonNull(userRoleHeader.getDescription()) ? userRoleHeader.getDescription() : StringUtils.EMPTY;
        if (isRoleCreated(userRoleName, userRoleDescription)) {
            throw new SkipException("User Role \"" + userRoleHeader.getName() + "\" already exists!");
        }
    }

    @Then("Duplicated role has not been created")
    public void verifyDuplicatedRoleIsNotCreated() {
        String userRoleTitle = getLastUserRoleTitleFromContext();
        List<String> roles = getAllRoles().getPayload()
                .stream()
                .map(UserRoleData::getName)
                .filter(name -> name.equals(userRoleTitle))
                .collect(Collectors.toList());
        assertTrue("There are more than one role with the same name", roles.size() <= 1);
    }

    @Then("User updates Name field with {string} name")
    public void fillInExistingName(String userRoleTitle) {
        userRoleFormPage.fillRoleName(userRoleTitle);
        setLastUserRoleTitleToContext(userRoleTitle);
    }

    @Then("{string} field is mandatory")
    public void verifyFieldIsMandatory(String fieldName) {
        assertTrue(format("Field %s is not mandatory", fieldName),
                   userRoleFormPage.isFormFieldMandatory(fieldName));
    }

    @Then("{string} Role Management page is opened")
    public void verifyRoleWindowIsOpened(String formName) {
        userRoleFormPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (formName.equals(USER_ROLE_TITLE)) {
            formName = getLastUserRoleTitleFromContext();
        }
        assertThat(userRoleFormPage.getRoleFormText()).as("%s window is not opened", formName)
                .isEqualTo(formName.toUpperCase());
    }

    @Then("{string} Role Management page is closed")
    public void verifyRoleFormIsClosed(String formName) {
        assertThat(userRoleFormPage.isRoleFormClosed(formName)).as("%s window is not closed", formName)
                .isTrue();
    }

    @Then("{string} field becomes highlighted in red")
    public void verifyFieldIsInError(String fieldName) {
        assertTrue(format("Form field %s isn't highlighted in error", fieldName),
                   userRoleFormPage.isFormFieldInError(fieldName));
    }

    @Then("Under {string} field there is an error message: {string}")
    public void verifyFieldErrorMessage(String fieldName, String errorMessage) {
        assertEquals("Form field error message isn't matched with expected one",
                     userRoleFormPage.getErrorMessageOnFormField(fieldName), errorMessage);
    }

    @When("User edits role name and description with {string}")
    public void editRoleNameAndDescription(String header) {
        UserRoleData userRoleHeader =
                new JsonUiDataTransfer<UserRoleData>(USER_ROLE).getTestData().get(header).getDataToEnter();
        userRoleHeader.setName(AUTO_TEST_NAME_PREFIX + RandomStringUtils.randomAlphanumeric(10));
        userRoleHeader.setDescription(userRoleHeader.getDescription() + RandomStringUtils.randomAlphanumeric(10));
        this.context.getScenarioContext().setContext(USER_ROLE_TITLE, userRoleHeader.getName());
        userRoleFormPage.editRoleHeader(userRoleHeader);
    }

    @When("User clicks 'Edit' button on created role on roles list")
    public void clickEditButtonOnCreatedRole() {
        String userRoleTitle = getLastUserRoleTitleFromContext();
        userRoleFormPage.openUserRolePage();
        searchPage.searchItem(userRoleTitle);
        userRoleFormPage.clickEditRole(userRoleTitle);
        userRoleFormPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks 'Edit' button on searched role {string}")
    public void clickEditButtonOnSearchedRole(String roleName) {
        userRoleFormPage.clickEditRole(roleName);
    }

    @When("User clicks 'Edit' button on role form page")
    public void clickEditButtonOnRoleForm() {
        userRoleFormPage.clickEditFormButton();
    }

    //TODO Change on API request and add to @After, after bug will be fixed (https://jira.refinitiv.com/browse/RMS-6874)
    @When("User deletes the role")
    public void deleteRole() {
        userRoleFormPage.openUserRolePage();
        String userRoleTitle = getLastUserRoleTitleFromContext();
        userRoleFormPage.clickDeleteRole(userRoleTitle);
        userRoleFormPage.waitWhileLoadingImageIsDisappeared();
    }

    @When("Users clicks {string} column in role header")
    public void clickColumnHeader(String columnName) {
        userRoleFormPage.clickOnTableColumn(columnName);
    }

    @When("User searches role by name")
    public void searchRoleByName() {
        String roleName = getLastUserRoleTitleFromContext();
        searchRoleBy(roleName);
    }

    @When("User searches role by {string} keyword")
    public void searchRoleBy(String keyWord) {
        searchPage.searchItem(keyWord);
    }

    @When("^User (unchecks|checks) 'Active' Edit User Role checkbox$")
    public void uncheckActiveEditUserRoleCheckbox(String state) {
        if ((state.equals(UNCHECKS) && userRoleFormPage.isActiveCheckboxChecked()) ||
                (state.equals(CHECKS)) && !userRoleFormPage.isActiveCheckboxChecked()) {
            userRoleFormPage.tickActiveCheckbox();
        }
    }

    @When("User hovers over Role checkbox")
    public void hoverOverRoleCheckbox() {
        String roleName = getLastUserRoleTitleFromContext();
        userRoleFormPage.hoverOverRoleCheckbox(roleName);
    }

    @When("User hovers over Role 'Delete' button")
    public void hoverOverRoleDeleteButton() {
        String roleName = getLastUserRoleTitleFromContext();
        userRoleFormPage.hoverOverRoleDeleteButton(roleName);
    }

    @When("User saves random Role id to context")
    public void saveRandomRoleIdToContext() {
        UserRoleData role = AppApi.getAllRoles().getPayload().stream().findAny()
                .orElseThrow(() -> new RuntimeException("No roles are found"));
        context.getScenarioContext().setContext(USER_ROLE_ID, role.get_id());
        context.getScenarioContext().setContext(USER_ROLE_TITLE, role.getName());
    }

    @When("User collapses Role Management sections")
    public void userCollapsesRoleManagementSections(List<String> sections) {
        sections.forEach(section -> {
            if (userRoleFormPage.isSectionExpanded(section)) {
                userRoleFormPage.clickCollapseExpandSection(section);
            }
        });
    }

    @Then("A new role has not been created")
    public void verifyRoleIsNotCreated() {
        String userRoleTitle = getLastUserRoleTitleFromContext();
        searchPage.searchItem(userRoleTitle);
        assertFalse("Role is created instead of cancel",
                    userRoleFormPage.isRoleDisplayedOnTable(userRoleTitle));
    }

    @Then("Role is displayed in roles list")
    public void verifyRoleIsDisplayedInList() {
        String userRoleTitle = getLastUserRoleTitleFromContext();
        assertTrue(userRoleTitle + " role is NOT displayed in roles list",
                   userRoleFormPage.isRoleDisplayedOnTable(userRoleTitle));

    }

    @Then("Role is displayed first in roles list")
    public void verifyRoleIsDisplayedFirstInList() {
        userRoleFormPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        String userRoleTitle = getLastUserRoleTitleFromContext();
        assertTrue(userRoleTitle + " role is NOT displayed in roles list",
                   userRoleFormPage.isRoleFirstInTable(userRoleTitle));
    }

    @Then("Role is NOT displayed in roles list")
    public void verifyRoleIsNotDisplayedInList() {
        String userRoleTitle = getLastUserRoleTitleFromContext();
        assertFalse(userRoleTitle + " role is displayed in roles list",
                    userRoleFormPage.isRoleDisplayedOnTable(userRoleTitle));
    }

    @Then("User verifies role is deleted")
    public void checkRoleIsDeleted() {
        String userRoleTitle = (String) context.getScenarioContext().getContext(USER_ROLE_TITLE);
        boolean isRoleExist = getAllRoles().getPayload().stream()
                .noneMatch(role -> role.getName().equals(userRoleTitle));
        assertTrue("Role '" + userRoleTitle + "' wasn't deleted", isRoleExist);
        context.getScenarioContext().setContext(USER_ROLE_TITLE, null);
    }

    @Then("Button 'Add New Role' should be displayed")
    public void buttonAddNewRoleShouldBeDisplayed() {
        assertTrue("Button 'Add New Role' is not displayed", userRoleFormPage.isAddNewRoleButtonVisible());
    }

    @Then("Role saved with provided details")
    public void isRoleSavedWithProvidedDetails() {
        userRoleFormPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        String userRoleDescription = (String) this.context.getScenarioContext().getContext(USER_ROLE_DESCRIPTION);
        assertTrue("Role is not updated with provided details", isRoleCreated(userRoleDescription));
    }

    @Then("Checkboxes in \"Third-party\" block in {string} column are ticked and NOT editable")
    public void areCheckboxesNotEditable(String columnName, DataTable dataTable) {
        SoftAssertions softAssert = new SoftAssertions();
        dataTable.asList().forEach(fieldName -> {
            softAssert.assertThat(userRoleFormPage.getCheckboxValueOnRolePage(fieldName, columnName))
                    .as("Checkbox isn't checked")
                    .isEqualTo(CHECKED);
            softAssert.assertThat(userRoleFormPage.isCheckBoxOnThirdPartyBlockEditable(fieldName, columnName))
                    .as("Checkbox for field {fieldName} is editable")
                    .isFalse();
        });
        softAssert.assertAll();
    }

    @Then("Checkbox for {string} in {string} column is editable")
    public void verifyCheckboxIsEditable(String fieldName, String columnName) {
        assertTrue("Checkbox for field {field} is NOT editable",
                   userRoleFormPage.isCheckBoxOnThirdPartyBlockEditable(fieldName, columnName));
    }

    @Then("All checkboxes are not editable on System Administrator form")
    public void verifyAllCheckboxesAreNotEditable() {
        SoftAssert softAssert = new SoftAssert();
        UserRoleFields.getFieldsFromBlocks(THIRD_PARTY)
                .forEach(field -> Arrays.asList(CREATE, EDIT, DELETE, READ)
                        .forEach(column -> softAssert
                                .assertFalse(userRoleFormPage.isCheckBoxOnThirdPartyBlockEditable(field, column),
                                             format("%s '%s' checkbox is editable", field, column))));
        UserRoleFields.getFieldsFromBlocks(SUPPLIERS_YES_NO, REPORTS_AND_DASHBOARD, SET_UP)
                .forEach(field -> softAssert
                        .assertFalse(userRoleFormPage.isCheckBoxOnThirdPartyBlockEditable(field, TOGGLE),
                                     format("%s '%s' checkbox is editable", field, TOGGLE)));
        Arrays.asList(ADD, DOWNLOAD, DELETE)
                .forEach(status -> softAssert
                        .assertFalse(
                                userRoleFormPage.isCheckBoxOnThirdPartyBlockEditable(RELATED_FILES.getField(), status),
                                format("%s '%s' checkbox is editable", RELATED_FILES.getField(), status)));
        Arrays.asList(CREATE, EDIT, READ, DECLINE, APPROVE)
                .forEach(status -> softAssert
                        .assertFalse(
                                userRoleFormPage.isCheckBoxOnOrderReportEditable(ORDER_REPORT.getField(), status),
                                format("%s '%s' checkbox is editable", ORDER_REPORT.getField(), status)));
        softAssert.assertAll();
    }

    @Then("Create, Edit and Delete checkboxes are editable")
    public void verifyCheckboxesAreEditable(DataTable dataTable) {
        SoftAssert softAssert = new SoftAssert();
        userRoleFormPage.selectCheckboxesOnSupplierBlock(dataTable.asList());
        dataTable.asList().forEach(field -> {
            softAssert.assertEquals(userRoleFormPage.getCheckboxValueOnRolePage(field, CREATE), CHECKED,
                                    format("'%s' checkbox for field: '%s' isn't checked", CREATE, field));
            softAssert.assertEquals(userRoleFormPage.getCheckboxValueOnRolePage(field, EDIT), CHECKED,
                                    format("'%s' checkbox for field: '%s' isn't checked", EDIT, field));
            softAssert.assertEquals(userRoleFormPage.getCheckboxValueOnRolePage(field, DELETE), CHECKED,
                                    format("'%s' checkbox for field: '%s' isn't checked", DELETE, field));
        });
        userRoleFormPage.selectCheckboxesOnSupplierBlock(dataTable.asList());
        dataTable.asList().forEach(field -> {
            softAssert.assertEquals(userRoleFormPage.getCheckboxValueOnRolePage(field, CREATE), UNCHECKED,
                                    format("'%s' checkbox for field '%s' is checked", CREATE, field));
            softAssert.assertEquals(userRoleFormPage.getCheckboxValueOnRolePage(field, EDIT), UNCHECKED,
                                    format("'%s' checkbox for field '%s' is checked", EDIT, field));
            softAssert.assertEquals(userRoleFormPage.getCheckboxValueOnRolePage(field, DELETE), UNCHECKED,
                                    format("'%s' checkbox for field '%s' is checked", DELETE, field));
        });
        softAssert.assertAll();
    }

    @Then("Toggle buttons can be switched on Role Management page")
    public void verifyRadioButtonsCanBeSelected(DataTable dataTable) {
        SoftAssertions softAssert = new SoftAssertions();
        dataTable.asList().forEach(userRoleFormPage::clickToggleButton);
        dataTable.asList().forEach(
                field -> softAssert.assertThat(userRoleFormPage.getCheckboxValueOnRolePage(field, TOGGLE))
                        .as("Toggle button isn't switched On for %s", field)
                        .isEqualTo(CHECKED));
        dataTable.asList().forEach(userRoleFormPage::clickToggleButton);
        dataTable.asList()
                .forEach(field -> assertThat(userRoleFormPage.getCheckboxValueOnRolePage(field, TOGGLE))
                        .as("Toggle button isn't switched Off for %s", field)
                        .isEqualTo(UNCHECKED));
        softAssert.assertAll();
    }

    @Then("Checkboxes are editable on Related Files section")
    public void verifyCheckboxesAreEditableOnRelatedFiles(DataTable dataTable) {
        SoftAssert softAssert = new SoftAssert();
        userRoleFormPage.selectAllCheckboxesOnRelatedFiles();
        dataTable.asList().forEach(columnName -> softAssert.assertEquals(
                userRoleFormPage.getCheckboxValueOnRolePage(RELATED_FILES.getField(), columnName), CHECKED,
                "Checkbox isn't selected"));
        userRoleFormPage.selectAllCheckboxesOnRelatedFiles();
        dataTable.asList().forEach(columnName -> softAssert.assertEquals(
                userRoleFormPage.getCheckboxValueOnRolePage(RELATED_FILES.getField(), columnName), UNCHECKED,
                "Checkbox isn't unselected"));
        softAssert.assertAll();
    }

    @Then("Checkboxes are editable on Due Diligence Order section")
    public void verifyCheckboxesAreEditableOnOrderReport(DataTable dataTable) {
        SoftAssert softAssert = new SoftAssert();
        userRoleFormPage.selectAllCheckboxesOnOrderReport();
        dataTable.asList().forEach(columnName -> softAssert.assertEquals(
                userRoleFormPage.getCheckboxValueOnRolePage(ORDER_REPORT.getField(), columnName), CHECKED,
                "Checkbox isn't selected"));
        userRoleFormPage.selectAllCheckboxesOnOrderReport();
        dataTable.asList().forEach(columnName -> softAssert.assertEquals(
                userRoleFormPage.getCheckboxValueOnRolePage(ORDER_REPORT.getField(), columnName), UNCHECKED,
                "Checkbox isn't unselected"));
        softAssert.assertAll();
    }

    @Then("Role status is {string}")
    public void verifyRoleStatus(String status) {
        verifyRoleTitleStatus(getLastUserRoleTitleFromContext(), status);
    }

    @Then("Role #{int} status is {string}")
    public void verifyRoleStatus(int roleNumber, String status) {
        verifyRoleTitleStatus((String) context.getScenarioContext().getContext(USER_ROLE_TITLE + roleNumber), status);
    }

    @Then("Role {string} status is {string}")
    public void verifyRoleTitleStatus(String role, String status) {
        assertEquals("Role status is not {status}", status, userRoleFormPage.getStatusForRole(role));
    }

    @Then("{string} is matched with {string}")
    public void verifyDate(String dateType, String date) {
        if (date.equals("Today")) {
            date = getTodayDate(REACT_FORMAT);
        }
        String userRoleTitle = getLastUserRoleTitleFromContext();
        assertEquals("Role status is not {status}",
                     date, dateType.equals(DATE_CREATED.getField()) ?
                             userRoleFormPage.getDateCreatedForRole(userRoleTitle) :
                             userRoleFormPage.getLastUpdateDateForRole(userRoleTitle));
    }

    @Then("{string} is matched with date pattern for {string} role")
    public void verifyDateIsMatchedWithFormat(String dateType, String roleName) {
        assertTrue(dateType + " isn't matched with date format",
                   dateType.equals(DATE_CREATED.getField()) ?
                           isDateMatchedWithFormat(userRoleFormPage.getDateCreatedForRole(roleName),
                                                   SI_UI_LOCAL_DATE_FORMAT) :
                           isDateMatchedWithFormat(userRoleFormPage.getLastUpdateDateForRole(roleName),
                                                   SI_UI_LOCAL_DATE_FORMAT));
    }

    @Then("User opens created role")
    public void openCreatedRole() {
        String userRoleTitle = getLastUserRoleTitleFromContext();
        userRoleFormPage.searchAndOpenRole(userRoleTitle);
    }

    @Then("User opens {string} created role")
    public void openCreatedRole(String userRoleTitle) {
        userRoleFormPage.searchAndOpenRole(userRoleTitle);
        userRoleFormPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @Then("^User (selects|unselects) (?:role|roles) in roles list$")
    public void selectRoleInRolesList(String checkboxState) {
        List<String> roles = new ArrayList<>();
        roles.add((String) context.getScenarioContext().getContext(USER_ROLE_TITLE));
        IntStream.rangeClosed(1, roleNumber - 1)
                .forEach(i -> {
                    String role = (String) context.getScenarioContext().getContext(USER_ROLE_TITLE + i);
                    if (Objects.nonNull(role)) {
                        roles.add(role);
                    }
                });
        if (checkboxState.startsWith(SELECT)) {
            roles.forEach(userRoleFormPage::selectRole);
        } else {
            roles.forEach(userRoleFormPage::unSelectRole);
        }
    }

    @Then("Verify the set up values contain expected {string} data for {string} role")
    public void verifyDataInCreatedRole(String roleReference, String roleStatus) {
        UserRoleData actualData = userRoleFormPage.getCreatedDataFromRole();
        UserRoleData expectedData = getUserRoleData(roleReference);
        expectedData.setActive(roleStatus.equals(ACTIVE.getStatus()) ? CHECKED : UNCHECKED);
        String roleFromContext = getLastUserRoleTitleFromContext();
        if (Objects.nonNull(roleFromContext)) {
            expectedData.setName(getLastUserRoleTitleFromContext());
        }
        assertThat(actualData).as("Role data is unexpected")
                .usingRecursiveComparison().ignoringExpectedNullFields().isEqualTo(expectedData);
    }

    @Then("Verify the set up values contain expected {string} roles")
    public void verifyRoleData(String roleReference) {
        UserRoleData actualData = userRoleFormPage.getCreatedDataFromRole();
        UserRoleData expectedData = getUserRoleData(roleReference);
        assertThat(actualData).as("Roles for '%s' differ from expected", roleReference).usingRecursiveComparison()
                .ignoringFields(UserRoleFields.NAME.getField().toLowerCase(),
                                UserRoleFields.DESCRIPTION.getField().toLowerCase(),
                                UserRoleFields.ACTIVE.getField().toLowerCase()).isEqualTo(expectedData);
    }

    @Then("All items containing {string} keyword in a Name field are shown")
    public void allGroupsContainingKeywordInARoleNameFieldAreShown(String keyWord) {
        userRoleFormPage.waitWhileLoadingImageIsDisappeared();
        assertTrue("Role table is not filtered by " + keyWord + " keyword",
                   userRoleFormPage.isRoleResultsFilteredByKeyword(keyWord));
    }

    @Then("Role table contains roles with values")
    public void roleTableContainsRolesWithValues(List<UserRoleData> userRole) {
        searchPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        List<UserRoleData> actualUserRoles = userRoleFormPage.getRolesList();
        assertThat(actualUserRoles).as("User table doesn't contain user with values").containsAll(userRole);
    }

    @Then("{string} role is first in roles list")
    public void verifyRoleIsFirstInList(String roleName) {
        userRoleFormPage.waitWhileLoadingImageIsDisappeared();
        assertEquals(roleName + " is not first in roles list",
                     roleName, userRoleFormPage.getRolesList().get(0).getName());
    }

    @Then("Roles table is displayed with columns")
    public void usersTableIsDisplayedWithColumns(DataTable dataTable) {
        List<String> expectedColumns = dataTable.asList();
        List<String> actualColumns = userRoleFormPage.getColumnNames();
        assertEquals("Roles table is not displayed with expected columns", expectedColumns, actualColumns);
    }

    @Then("Roles table displays roles sorted by {string} in {string} order")
    public void rolesTableIsSortedByField(String sortedBy, String sortOrder) {
        userRoleFormPage.waitWhilePreloadProgressbarIsDisappeared();
        List<String> actualRolesList = userRoleFormPage.getRolesListValuesForColumn(sortedBy);
        tableIsSortedByInOrder("Roles", sortedBy, sortOrder, SORTING_FORMAT, actualRolesList, false);
    }

    @Then("^\"((.*))\" element is (?:not present|disabled:) for \"((.*))\" in roles list$")
    public void verifyElementIsNotPresent(String elementName, String roleName) {
        String errorMessage = elementName + " is displayed for role " + roleName;
        switch (elementName) {
            case DELETE:
                assertFalse(errorMessage, userRoleFormPage.isDeleteButtonDisplayedOnTable(roleName));
            case EDIT:
                assertFalse(errorMessage, userRoleFormPage.isEditButtonDisplayedOnTable(roleName));
            case CHECKBOX:
                assertTrue(errorMessage, userRoleFormPage.isCheckboxDisabledOnTable(roleName));
        }
    }

    @Then("Verify checkboxes are present opposite to roles")
    public void verifyCheckboxesArePresentOnAllRoles() {
        SoftAssertions softAssert = new SoftAssertions();
        List<UserRoleData> rolesList = userRoleFormPage.getRolesList();
        rolesList.forEach(role -> {
            if (!role.getName().equals(SYSTEM_ADMINISTRATOR)) {
                softAssert.assertThat(userRoleFormPage.isCheckboxDisplayedOnTable(role.getName()))
                        .as("Checkbox isn't displayed for role " + role.getName())
                        .isTrue();
            }
        });
        softAssert.assertAll();
    }

    @Then("Verify Edit and Delete buttons are present opposite to roles")
    public void verifyButtonsArePresentOnAllRoles() {
        SoftAssertions softAssert = new SoftAssertions();
        List<UserRoleData> rolesList = userRoleFormPage.getRolesList();
        rolesList.forEach(role -> {
            if (!role.getName().equals(SYSTEM_ADMINISTRATOR)) {
                softAssert.assertThat(userRoleFormPage.isDeleteButtonDisplayedOnTable(role.getName()))
                        .as("Delete button isn't displayed for role " + role.getName())
                        .isTrue();
                softAssert.assertThat(userRoleFormPage.isEditButtonDisplayedOnTable(role.getName()))
                        .as("Edit button isn't displayed for role " + role.getName())
                        .isTrue();
            }
        });
        softAssert.assertAll();
    }

    @Then("^Edit button is (not displayed|displayed) on Role Management form page$")
    public void verifyEditButtonIsNotDisplayed(String state) {
        if (state.contains(NOT)) {
            assertThat(userRoleFormPage.isEditButtonDisplayedOnForm())
                    .as("Edit button is displayed on Role Management form page")
                    .isFalse();
        } else {
            assertThat(userRoleFormPage.isEditButtonDisplayedOnForm())
                    .as("Edit button is not displayed on Role Management form page")
                    .isTrue();
        }
    }

    @Then("^Role Management field \"(.*)\" toggle button is switched \"(On|Off)\"$")
    public void roleManagementFieldRadioButtonSelected(String fieldName, String toggleState) {
        userRoleFormPage.waitWhilePreloadProgressbarIsDisappeared();
        boolean result = userRoleFormPage.isToggleButtonSwitchedOn(fieldName);
        boolean shouldBeSwitchedOn = toggleState.equals(ON);
        assertThat(result)
                .as("%s field toggle button is not switched %s", fieldName, toggleState)
                .isEqualTo(shouldBeSwitchedOn);
    }

    @Then("^Role Active checkbox is (checked|unchecked)$")
    public void activeCheckboxIsChecked(String checkboxState) {
        boolean shouldBeChecked = checkboxState.equals(CHECKED);
        assertThat(userRoleFormPage.isActiveCheckboxChecked())
                .as("Active checkbox is not %s", checkboxState)
                .isEqualTo(shouldBeChecked);
    }

    private UserRoleData getUserRoleData(String roleReference) {
        if (Strings.isNullOrEmpty(this.roleReference) || !this.roleReference.equals(roleReference)) {
            this.roleReference = roleReference;
            this.roleData = new JsonUiDataTransfer<UserRoleData>(USER_ROLE).getTestData()
                    .get(this.roleReference).getDataToEnter();
        }
        return this.roleData;
    }

    private boolean isRoleCreated(String userRoleDescription) {
        String userRoleTitle = getLastUserRoleTitleFromContext();
        return isRoleCreated(userRoleTitle, userRoleDescription);
    }

    private boolean isRoleCreated(String userRoleTitle, String userRoleDescription) {
        UserRoleResponse allRoles = getAllRoles();
        return allRoles.getPayload().stream()
                .anyMatch(payload -> nonNull(payload.getName()) && payload.getName().trim().equals(userRoleTitle) &&
                        userRoleDescription.equals(payload.getDescription().trim()));
    }

    @Then("User management breadcrumb {string} is displayed")
    public void userManagementBreadcrumbIsDisplayed(String expectedText) {
        if (expectedText.contains(USER_ROLE_TITLE)) {
            expectedText = expectedText.replace(USER_ROLE_TITLE, getLastUserRoleTitleFromContext());
        }
        assertThat(userRoleFormPage.getBreadcrumbText().replace(LF, SPACE))
                .as("User management breadcrumb text is unexpected")
                .isEqualTo(expectedText.toUpperCase());
    }

    @Then("There are the following Role Management sections displayed")
    public void thereAreTheFollowingRoleManagementSectionsDisplayed(List<String> expectedSections) {
        assertThat(userRoleFormPage.getRoleSections())
                .as("Role Management sections are unexpected")
                .isEqualTo(expectedSections);
    }

    @Then("Role Management header is {string}")
    public void roleManagementHeaderIs(String headerName) {
        assertThat(userRoleFormPage.getRoleManagementHeader())
                .as("Role management header text is incorrect")
                .isEqualTo(headerName);
    }

    @Then("^Role #(\\d) checkbox is (checked|unchecked) in roles list$")
    public void roleCheckboxIsCheckedInRolesList(int roleNumber, String checkboxState) {
        String roleName = roleNumber > 0 ?
                (String) context.getScenarioContext().getContext(USER_ROLE_TITLE + roleNumber) :
                (String) context.getScenarioContext().getContext(USER_ROLE_TITLE);
        boolean isChecked = checkboxState.equals(CHECKED);
        assertThat(userRoleFormPage.isRoleCheckboxChecked(roleName))
                .as("%s checkbox is not %s", roleName, checkboxState)
                .isEqualTo(isChecked);
    }

    @Then("Role checkbox is disabled for role {string}")
    public void roleCheckboxIsDisabled(String roleName) {
        if (context.getScenarioContext().isContains(roleName)) {
            roleName = (String) context.getScenarioContext().getContext(roleName);
        }
        assertThat(userRoleFormPage.isRoleCheckboxEnabled(roleName))
                .as("%s checkbox is enabled")
                .isFalse();
    }

    @Then("Delete button color is changed to red")
    public void deleteButtonColorIsChangedToRed() {
        String roleName = getLastUserRoleTitleFromContext();
        Assertions.assertThat(userRoleFormPage.getDeleteButtonColor(roleName))
                .as("Delete button color is not red")
                .isEqualTo(Colors.REACT_RED.getColorRgba());
    }

    @Then("^(Submit|Cancel) button is displayed on (?:Add|Edit) Role page$")
    public void buttonIsDisplayedOnRolePage(String buttonName) {
        if (buttonName.equals(CANCEL)) {
            assertThat(userRoleFormPage.isCancelRoleButtonDisplayed())
                    .as("Cancel button is not displayed on Role page")
                    .isTrue();
        } else {
            assertThat(userRoleFormPage.isSubmitRoleButtonDisplayed())
                    .as("Submit button is not displayed on Role page")
                    .isTrue();
        }
    }

    public String getLastUserRoleTitleFromContext() {
        String role;
        Integer roleNumber = (Integer) context.getScenarioContext().getContext(USER_ROLE_NUMBER);
        if (Objects.nonNull(roleNumber) && roleNumber > 0) {
            role = (String) context.getScenarioContext().getContext(USER_ROLE_TITLE + roleNumber);
        } else {
            role = (String) context.getScenarioContext().getContext(USER_ROLE_TITLE);
        }
        return role;
    }

    private void setLastUserRoleTitleToContext(String userRoleTitle) {
        if (roleNumber > 0) {
            this.context.getScenarioContext().setContext(USER_ROLE_TITLE + roleNumber, userRoleTitle);
        } else {
            this.context.getScenarioContext().setContext(USER_ROLE_TITLE, userRoleTitle);
        }
        context.getScenarioContext().setContext(USER_ROLE_NUMBER, roleNumber++);
    }

    private void setLastUserRoleIdToContext() {
        String roleId = AppApi.getAllRoles().getPayload()
                .stream()
                .filter(role -> role.getName().equals(getLastUserRoleTitleFromContext()))
                .map(UserRoleData::get_id)
                .collect(Collectors.toList()).get(0);
        context.getScenarioContext().setContext(USER_ROLE_ID, roleId);
    }

    @Then("^Role Management sections are (expanded|collapsed)$")
    public void roleManagementSectionsAreExpanded(String status, List<String> sections) {
        boolean isExpanded = status.contains(EXPAND);
        SoftAssertions softAssert = new SoftAssertions();
        sections.forEach(section -> softAssert.assertThat(userRoleFormPage.isSectionExpanded(section))
                .as("Section %s is not expanded", section)
                .isEqualTo(isExpanded));
        softAssert.assertAll();
    }

    @Then("View Role URL contains expected Role id")
    public void viewRoleURLContainsExpectedRoleId() {
        String roleId = (String) context.getScenarioContext().getContext(USER_ROLE_ID);
        String expectedURL = format(VIEW_ROLE_PATH, roleId);
        assertThat(userRoleFormPage.getCurrentUrl())
                .as("Role URL is not as expected")
                .endsWith(expectedURL);
    }

    @Then("^Access rights are (not present|present) on Role page$")
    public void accessRightsAreNotPresentOnRolePage(String status, List<String> rightNames) {
        boolean isPresent = !status.contains(NOT);
        SoftAssertions softAssert = new SoftAssertions();
        rightNames.forEach(right -> softAssert.assertThat(userRoleFormPage.isAccessRightPresent(right))
                .as("Right is present on role page")
                .isEqualTo(isPresent));
        softAssert.assertAll();
    }

    @Then("Deactivate button is displayed on Roles list page")
    public void deactivateButtonIsDisplayedOnRolesList() {
        assertThat(userRoleFormPage.isDeactivateButtonDisplayed())
                .as("Deactivate button is not displayed")
                .isTrue();
    }

    @Then("^(Active|Inactive|All) roles are displayed in Roles table$")
    public void allRolesAreDisplayedInRolesTable(String status) {
        List<UserRoleData> expectedData;
        if (status.equalsIgnoreCase(ALL)) {
            expectedData = getAllRoles().getPayload();
        } else {
            expectedData = getAllRoles().getPayload().stream()
                    .filter(entry -> entry.getActive().equals(status))
                    .collect(Collectors.toList());
        }
        expectedData.forEach(entry -> entry.setName(entry.getName().trim()));
        List<UserRoleData> actualData = userRoleFormPage.getAllRolesList();
        assertThat(actualData).as("Roles list is not as expected")
                .usingRecursiveComparison().ignoringActualNullFields().ignoringCollectionOrder()
                .isEqualTo(expectedData);
    }

}