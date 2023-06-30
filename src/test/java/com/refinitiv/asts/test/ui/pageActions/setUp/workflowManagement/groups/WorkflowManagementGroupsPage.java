package com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.groups;

import com.refinitiv.asts.test.ui.enums.WorkflowManagementGroupColumns;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageActions.PaginationPage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.workflowManagement.groups.WorkflowGroupsPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowGroupData;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.constants.Pages.WORKFLOW_MANAGEMENT_GROUPS_PATH;
import static java.lang.String.format;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfAllElementsLocatedBy;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated;

public class WorkflowManagementGroupsPage extends BasePage<WorkflowManagementGroupsPage> {

    private final WorkflowGroupsPO groupsPO;
    private final PaginationPage paginationPage = new PaginationPage(driver, context);

    public WorkflowManagementGroupsPage(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
        groupsPO = new WorkflowGroupsPO(driver, translator);
    }

    public WorkflowManagementGroupsPage(WebDriver driver) {
        super(driver);
        groupsPO = new WorkflowGroupsPO(driver);
    }

    @Override
    protected ExpectedCondition<WorkflowManagementGroupsPage> getPageLoadCondition() {
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

    public void navigateToGroupsPage() {
        this.driver.get(URL + WORKFLOW_MANAGEMENT_GROUPS_PATH);
    }

    public void clickWorkflowManagementSubmenuGroups() {
        clickOn(groupsPO.getWorkFlowGroupMenu());
    }

    public void clickFirstRow() {
        clickOn(groupsPO.getTableFirstRow());
    }

    public void clickWorkflowGroup(String groupName) {
        clickOn(xpath(format(groupsPO.getTableRowName(), groupName)));
    }

    public void clickEditWorkflowGroup(String groupName) {
        clickOn(xpath(format(groupsPO.getTableRowEdit(), groupName)));
    }

    public void clickDeleteWorkflowGroup(String groupName) {
        clickOn(xpath(format(groupsPO.getTableRowDelete(), groupName)), waitLong);
    }

    public void clickBack() {
        clickOn(groupsPO.getButtonBack());
    }

    public void clickButtonAddWorkflowGroup() {
        clickOn(groupsPO.getButtonAddWorkflowGroup(), waitShort);
    }

    public void enterGroupsName(String name) {
        clearAndInputField(groupsPO.getFieldWorkFlowGroupNameInput(), name);
    }

    public void clickSave() {
        clickOn(groupsPO.getButtonSave());
    }

    public void clickCancel() {
        clickOn(groupsPO.getButtonCancel());
    }

    public void clickEdit() {
        clickOn(groupsPO.getButtonEdit());
    }

    public WorkflowGroupData getAllFieldsValues(String groupName) {
        List<String> columnNames = getColumnNames();
        return new WorkflowGroupData(getGroupValueByName(groupName,
                                                         WorkflowManagementGroupColumns.WORKFLOW_GROUP_NAME.getName()
                                                                 .toUpperCase(), columnNames),
                                     getGroupValueByName(groupName,
                                                         WorkflowManagementGroupColumns.STATUS.getName().toUpperCase(),
                                                         columnNames),
                                     getGroupValueByName(groupName,
                                                         WorkflowManagementGroupColumns.DATE_CREATED.getName()
                                                                 .toUpperCase(), columnNames),
                                     getGroupValueByName(groupName,
                                                         WorkflowManagementGroupColumns.LAST_UPDATED.getName()
                                                                 .toUpperCase(), columnNames));
    }

    public WorkflowGroupData getAllFieldsValues(int groupNo) {
        return new WorkflowGroupData(getGroupValueByIndex(groupNo,
                                                          WorkflowManagementGroupColumns.WORKFLOW_GROUP_NAME.getName()
                                                                  .toUpperCase()),
                                     getGroupValueByIndex(groupNo, WorkflowManagementGroupColumns.STATUS.getName()
                                             .toUpperCase()),
                                     getGroupValueByIndex(groupNo, WorkflowManagementGroupColumns.DATE_CREATED.getName()
                                             .toUpperCase()),
                                     getGroupValueByIndex(groupNo, WorkflowManagementGroupColumns.LAST_UPDATED.getName()
                                             .toUpperCase()));
    }

    public List<WorkflowGroupData> getGroupsList() {
        return IntStream.rangeClosed(1, driver.findElements(groupsPO.getTableRows()).size())
                .mapToObj(this::getAllFieldsValues).collect(Collectors.toList());
    }

    public List<WorkflowGroupData> getAllGroupsList() {
        return paginationPage.getAllPagesTableValues(this::getGroupsList);
    }

    public String getGroupNameFieldLabelText() {
        return driver.findElement(groupsPO.getFieldWorkFlowGroupNameLabel()).getText();
    }

    public String getGroupNameFieldText() {
        return getAttributeValueWhenAppears(waitShort, groupsPO.getFieldWorkFlowGroupNameInput());
    }

    public String getFirstRowText() {
        return getElementText(groupsPO.getTableFirstRow());
    }

    private String getGroupValueByName(String groupName, String column, List<String> columnNames) {
        int columnIndex = columnNames.indexOf(column) + 1;
        return getElementText(xpath(format(groupsPO.getFieldValue(), groupName, columnIndex)));
    }

    private String getGroupValueByIndex(int groupNo, String columnName) {
        int columnIndex = getColumnNames().indexOf(columnName) + 1;
        String text = waitLong.until(
                        visibilityOfElementLocated(xpath(format(groupsPO.getTableRowValue(), groupNo, columnIndex))))
                .getText();
        return text.isEmpty() ? null : text;
    }

    public String getErrorMessageText() {
        return getElementText(groupsPO.getErrorMessage());
    }

    public String getErrorMessageElementCSS(String cssValue) {
        return getCssValue(groupsPO.getErrorMessage(), cssValue);
    }

    public List<String> getColumnNames() {
        return getElementsText(waitMoment.ignoring(StaleElementReferenceException.class)
                                       .until(visibilityOfAllElementsLocatedBy(groupsPO.getTableColumns())));
    }

    public boolean isPageWithNameDisplayed(String name) {
        return isElementDisplayed(waitShort, xpath(format(groupsPO.getPageName(), name)));
    }

    public boolean isPageWithNameDisappeared(String name) {
        return isElementDisappeared(waitShort, xpath(format(groupsPO.getPageName(), name)));
    }

    public boolean isActiveCheckboxChecked() {
        return isCheckboxChecked(groupsPO.getActive());
    }

    public boolean isSaveButtonDisplayed() {
        return isElementDisplayed(groupsPO.getButtonSave());
    }

    public boolean isCancelButtonDisplayed() {
        return isElementDisplayed(groupsPO.getButtonCancel());
    }

    public boolean isCloseButtonDisplayed() {
        return isElementDisplayed(groupsPO.getButtonBack());
    }

    public boolean isEditButtonDisplayed() {
        return isElementDisplayed(groupsPO.getButtonEdit());
    }

    public boolean isFieldInvalidAriaDisplayed() {
        return isElementDisplayed(groupsPO.getFieldWorkFlowGroupNameError());
    }

    public boolean isActiveCheckboxEnabled() {
        return isElementEnabled(groupsPO.getActive());
    }

    public boolean isWorkflowGroupNameInputDisplayed() {
        return isElementDisplayed(groupsPO.getFieldWorkFlowGroupNameInput());
    }

    public boolean areEditButtonsDisplayedForEachRow() {
        return driver.findElements(groupsPO.getTableRows()).stream()
                .allMatch(row -> isElementDisplayed(row.findElement(groupsPO.getEditButton())));
    }

    public boolean areDeleteButtonsDisplayedForEachRow() {
        return driver.findElements(groupsPO.getTableRows()).stream()
                .allMatch(row -> isElementDisplayed(row.findElement(groupsPO.getDeleteButton())));
    }

}
