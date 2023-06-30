package com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.workflow;

import com.refinitiv.asts.test.ui.enums.WorkflowManagementWorkflowColumns;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageActions.SearchSectionPage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.workflowManagement.workflow.WorkflowPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowData;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.apache.commons.text.CaseUtils;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.Pages.WORKFLOW_MANAGEMENT_WORKFLOW_PATH;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.enums.Status.INACTIVE;
import static java.lang.String.format;
import static java.util.Objects.isNull;
import static java.util.stream.Collectors.toList;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class WorkflowPage extends BasePage<WorkflowPage> {

    public static final String WORKFLOW_NAME = "Workflow Name";
    public static final String WORKFLOW_TYPE = "Workflow Type";
    public static final String DATE_CREATED = "DATE CREATED";
    public static final String LAST_UPDATED = "LAST UPDATED";
    public static final String STATUS = "STATUS";
    public static final String RISK_SCORING_RANGE = "Risk Scoring Range";
    public static final String WORKFLOW_GROUP = "Workflow Group";
    public static final String COMMIT_NEW_VERSION = "Commit new version";
    public static final String FROM = "From";
    public static final String TO = "To";
    public static final String ADD_WORKFLOW = "ADD WORKFLOW";
    public static final String RISK_RANGE_FORMAT = "%s (%s to %s)";
    private static final String RISK_SCORING_NUMBER_REGEX = "[+-]?([0-9]*[.*]?[0-9]+)";
    private final WorkflowPO workflowPO;
    private final SearchSectionPage searchPage;

    public WorkflowPage(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
        workflowPO = new WorkflowPO(driver, translator);
        searchPage = new SearchSectionPage(driver);
    }

    @Override
    protected ExpectedCondition<WorkflowPage> getPageLoadCondition() {
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

    public void navigateToWorkflowPage() {
        this.driver.get(URL + WORKFLOW_MANAGEMENT_WORKFLOW_PATH);
    }

    public void clickWorkflowManagementSubmenuWorkflow() {
        clickOn(workflowPO.getWorkflowMenu());
    }

    public void clickButtonAddWorkflow() {
        clickOn(workflowPO.getButtonAddWorkflow(), waitLong);
    }

    public void fillInWorkflowName(String name) {
        waitShort.until(visibilityOfElementLocated(workflowPO.getNameInput()));
        clearAndInputField(workflowPO.getNameInput(), name);
        if (isNull(getAttributeValue(workflowPO.getNameInput(), VALUE)) ||
                !isElementAttributeContains(workflowPO.getNameInput(), VALUE, name)) {
            fillInText(workflowPO.getNameInput(), name);
        }
    }

    public void fillInWorkflowType(String type) {
        if (isElementDisplayed(waitMoment, workflowPO.getWorkflowTypeInput())) {
            refreshPage();
        }
        clearAndFillInValueAndSelectFromDropDown(type,
                                                 waitMoment.until(
                                                         visibilityOfElementLocated(workflowPO.getWorkflowTypeInput())),
                                                 workflowPO.getDropDownOption());
    }

    public void tickActiveCheckbox(String checkboxStatus) {
        if ((checkboxStatus.equals(ACTIVE.getStatus()) && !isWorkflowActiveCheckboxChecked()) ||
                (checkboxStatus.equals(INACTIVE.getStatus()) && isWorkflowActiveCheckboxChecked())) {
            clickOn(workflowPO.getCheckboxActive());
        }
    }

    public void fillInRiskScoringRange(String rangeName) {
        clearAndFillInValueAndSelectFromDropDown(rangeName,
                                                 waitShort.until(visibilityOfElementLocated(
                                                         workflowPO.getRiskScoringRangeInput())),
                                                 workflowPO.getDropDownOption());
    }

    public void clearInput(String fieldName) {
        clearText(driver.findElement(xpath(format(workflowPO.getInputWithLabel(), fieldName))));
    }

    public void fillInDescription(String description) {
        fillInText(workflowPO.getDescriptionInput(), description, waitShort);
    }

    public void fillInWorkflowGroup(String groupName) {
        clearAndFillInValueAndSelectFromDropDown(groupName, workflowPO.getWorkflowGroupInput(),
                                                 workflowPO.getDropDownOption());
    }

    public void setComponentName(String name, int componentPosition) {
        clearAndInputField(xpath(format(workflowPO.getComponentNameInput(), componentPosition)), name);
    }

    public void clickNextButton() {
        clickOn(workflowPO.getButtonNext());
    }

    public void clickAddWizardComponentButton() {
        clickOn(workflowPO.getAddWizardComponentButton(), waitLong);
    }

    public void clickCheckComponentButton(int componentPosition) {
        clickOn(xpath(format(workflowPO.getComponentCheckButton(), componentPosition)));
    }

    public void clickAddActivity(int componentPosition) {
        doubleClickOn(xpath(format(workflowPO.getLinkAddActivity(), componentPosition)));
    }

    public void clickSaveButton() {
        clickOn(workflowPO.getButtonSave());
    }

    public void clickWorkflowButton(String button) {
        clickOn(getElement(xpath(format(workflowPO.getPageButton(), button))), waitMoment);
    }

    public void clickCreteWorkflowTypeButton() {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        clickOn(workflowPO.getWorkflowTypeInput());
    }

    public void clickRiskScoringButton() {
        int count = 0;
        int maxTries = 5;
        while (!isElementDisplayedNow(workflowPO.getDropDownItems()) && count++ < maxTries) {
            clickOn(workflowPO.getRiskScoringRangeInput());
        }
    }

    public void clickWorkflowGroupButton() {
        clickOn(workflowPO.getWorkflowGroupInput());
    }

    public void clickOnFirstWorkflowName() {
        clickOn(xpath(format(workflowPO.getTableFieldValue(), 1)));
    }

    public void clickEditButtonForFirstWorkflow() {
        clickOn(workflowPO.getTableColumnEditButton());
    }

    public void dragAndDropComponent(int dragElementPosition, int dropElementPosition) {
        WebElement dragElement =
                driver.findElement(xpath(format(workflowPO.getComponentHeader(), dragElementPosition)));
        WebElement dropElement =
                driver.findElement(xpath(format(workflowPO.getComponentHeader(), dropElementPosition)));
        clickOn(dragElement);
        action.clickAndHold(dragElement)
                .moveByOffset(0, 10)
                .moveToElement(dropElement, 0, -10)
                .moveToElement(dropElement, 20, 0)
                .release()
                .pause(500)
                .build()
                .perform();
    }

    public void clickEditComponentButton(int componentPosition) {
        clickOn(xpath(format(workflowPO.getComponentHeader(), componentPosition)));
        hoverOverElement(workflowPO.getAddWizardComponentButton());
        hoverOverElement(xpath(format(workflowPO.getComponentHeader(), componentPosition)));
        clickOn(xpath(format(workflowPO.getComponentEditButton(), componentPosition)));

    }

    public void clickDeleteComponentButton(int componentPosition) {
        hoverOverElement(xpath(format(workflowPO.getComponentHeader(), componentPosition)));
        clickOn(xpath(format(workflowPO.getComponentDeleteButton(), componentPosition)));
    }

    public void clickEditWorkflowButton() {
        clickOn(waitShort.until(visibilityOfElementLocated(workflowPO.getWorkflowOverviewEditButton())));
    }

    public void searchWorkflowByName(String name) {
        searchPage.searchItem(name);
        waitShort.until(numberOfElementsToBe(workflowPO.getWorkflowNameTableRow(), 1));
    }

    public void clickOnDescription() {
        clickOn(workflowPO.getDescriptionInput());
    }

    public void clickEditWizardComponent() {
        clickOn(xpath(workflowPO.getEditWizardButton()));
    }

    public void clickActivityComponent(String action, String activityName) {
        switch (CaseUtils.toCamelCase(action, true)) {
            case EDIT:
                if (isEditButtonEnabled(activityName)) {
                    clickOn(xpath(format(workflowPO.getEditActivityButton(), activityName)));
                } else {
                    doubleClickOn(xpath(format(workflowPO.getEditActivityButton(), activityName)));
                }
                break;
            case VIEW:
                if (isEditButtonEnabled(activityName)) {
                    clickOn(xpath(format(workflowPO.getComponentActivity(), activityName)));
                } else {
                    doubleClickOn(xpath(format(workflowPO.getComponentActivity(), activityName)));
                }
                break;
            case DELETE:
                clickOn(xpath(format(workflowPO.getDeleteActivityButton(), activityName)));
                break;
            default:
                throw new IllegalArgumentException("Incorrect action toward activity");
        }
    }

    public boolean isEditWorkflowButtonDisplayed() {
        return isElementDisplayed(waitShort, workflowPO.getWorkflowOverviewEditButton());
    }

    public boolean isWorkflowActiveCheckboxChecked() {
        return isCheckboxChecked(workflowPO.getCheckboxActive());
    }

    public boolean isNewComponentButtonEnabled(int componentPosition) {
        return isElementEnabled(xpath(format(workflowPO.getComponentCheckButton(), componentPosition)));
    }

    public boolean isNewComponentCreated(int componentPosition) {
        return isElementDisplayed(xpath(format(workflowPO.getComponentHeader(), componentPosition)));
    }

    public boolean isComponentNameInputDisplayed(int componentPosition) {
        return isElementDisplayed(xpath((format(workflowPO.getComponentNameInput(), componentPosition))));
    }

    public boolean isComponentEditButtonDisplayed(int componentPosition) {
        hoverOverElement(xpath(format(workflowPO.getComponentHeader(), componentPosition)));
        return isElementDisplayed(xpath((format(workflowPO.getComponentEditButton(), componentPosition))));
    }

    public boolean isComponentDeleteButtonDisplayed(int componentPosition) {
        hoverOverElement(xpath(format(workflowPO.getComponentHeader(), componentPosition)));
        return isElementDisplayed(xpath((format(workflowPO.getComponentDeleteButton(), componentPosition))));
    }

    public boolean isRiskScoringRangeDropDownDisplayed() {
        return isElementDisplayed(workflowPO.getRiskScoringRangeInput());
    }

    public boolean isInputInvalidAriaDisplayed(String fieldName) {
        return isElementAttributeContains(xpath(format(workflowPO.getInputWithLabel(), fieldName)),
                                          ARIA_INVALID, Boolean.toString(true));
    }

    public boolean isWorkflowFieldDisabled(String fieldName) {
        return isElementEnabled(xpath(format(workflowPO.getInputWithLabel(), fieldName)));
    }

    public boolean isWorkflowButtonDisplayed(String button) {
        return isElementDisplayed(waitMoment, xpath(format(workflowPO.getPageButton(), button)));
    }

    public boolean isWorkflowButtonEnabled(String button) {
        return isElementEnabled(xpath(format(workflowPO.getPageButton(), button)));
    }

    public boolean isAddWizardButtonDisplayed() {
        return isElementDisplayed(waitMoment, workflowPO.getAddWizardComponentButton());
    }

    public boolean isLinkAddActivityDisplayed(int componentPosition) {
        return isElementDisplayed(waitMoment,
                                  xpath(format(workflowPO.getLinkAddActivity(), Math.max(componentPosition, 1))));
    }

    public boolean isWorkflowTableDisplayed() {
        return isElementDisplayed(waitLong, workflowPO.getWorkflowTable());
    }

    public boolean isWorkFlowManagementModuleDisplayed() {
        return isElementDisplayed(workflowPO.getWorkflowManagementMenu());
    }

    public boolean isEditButtonEnabled(String activityName) {
        return isElementEnabled(xpath(format(workflowPO.getEditActivityButton(), activityName)));
    }

    public boolean isDeleteButtonEnabled(String activityName) {
        return isElementEnabled(xpath(format(workflowPO.getDeleteActivityButton(), activityName)));
    }

    public boolean isPageHeaderDisappeared() {
        return isElementDisappeared(waitShort, workflowPO.getPageHeader());
    }

    public WorkflowData getAllFieldsTableValues() {
        List<String> columns = getTableColumnNames();
        return new WorkflowData().setWorkflowName(
                        getFirstWorkflowData(WorkflowManagementWorkflowColumns.WORKFLOW_NAME.getName().toUpperCase(), columns))
                .setWorkflowType(
                        getFirstWorkflowData(WorkflowManagementWorkflowColumns.WORKFLOW_TYPE.getName().toUpperCase(),
                                             columns))
                .setDateCreated(
                        getFirstWorkflowData(WorkflowManagementWorkflowColumns.DATE_CREATED.getName().toUpperCase(),
                                             columns))
                .setLastUpdate(
                        getFirstWorkflowData(WorkflowManagementWorkflowColumns.LAST_UPDATED.getName().toUpperCase(),
                                             columns))
                .setStatus(getFirstWorkflowData(WorkflowManagementWorkflowColumns.STATUS.getName().toUpperCase(),
                                                columns));
    }

    public WorkflowData getWorkflowData() {
        return new WorkflowData().setWorkflowName(getInputValue(WORKFLOW_NAME))
                .setWorkflowType(getInputValue(WORKFLOW_TYPE))
                .setDescription(getDescriptionValue())
                .setRiskScoringRange(getInputValue(RISK_SCORING_RANGE))
                .setFrom(getInputValue(FROM))
                .setTo(getInputValue(TO))
                .setWorkflowGroup(getInputValue(WORKFLOW_GROUP))
                .setStatus(getWorkflowStatusAsText());
    }

    public List<WorkflowData> getAllWorkflowsData() {
        waitShort.until(numberOfElementsToBeMoreThan(workflowPO.getWorkflowNameTableRow(), 0));
        return getElements(workflowPO.getWorkflowNameTableRow())
                .stream()
                .map(row -> new WorkflowData()
                        .setWorkflowName(getElementText(row.findElement(workflowPO.getWorkflowNameTableField())))
                        .setWorkflowType(getElementText(row.findElement(workflowPO.getWorkflowTypeTableField())))
                        .setDateCreated(getElementText(row.findElement(workflowPO.getDateCreatedTableField())))
                        .setLastUpdate(getElementText(row.findElement(workflowPO.getLastUpdateTableField())))
                        .setStatus(getElementText(row.findElement(workflowPO.getStatusTableField()))))
                .collect(toList());
    }

    public List<String> getTableColumnNames() {
        return getElementsText(workflowPO.getTableColumns());
    }

    public List<String> getWorkflowOverviewFieldTitles() {
        return getElementsText(workflowPO.getWorkflowFieldsLabels());
    }

    public List<String> getDropDownOptionList() {
        return getDropDownOptions(workflowPO.getDropDownOptions());
    }

    public List<Float> getDropDownOptionNumbersList(List<String> options) {
        return options.stream()
                .map(this::getIntValueFromOption)
                .collect(Collectors.toUnmodifiableList());
    }

    private Float getIntValueFromOption(String option) {
        Matcher matcher = Pattern.compile(RISK_SCORING_NUMBER_REGEX).matcher(option);
        if (matcher.find()) {
            return Float.valueOf(matcher.group());
        }
        throw new IllegalArgumentException("Option '" + option + "' - doesn't contain range");
    }

    public String getRiskScoringName(WorkflowData riskScoring) {
        return format(RISK_RANGE_FORMAT, riskScoring.getRiskScoringRange(), riskScoring.getFrom(),
                      riskScoring.getTo());
    }

    public String getComponentName(int componentPosition) {
        return getElementText(xpath(format(workflowPO.getComponentHeader(), componentPosition)));
    }

    private String getWorkflowStatusAsText() {
        return isWorkflowActiveCheckboxChecked() ? ACTIVE.getStatus() : INACTIVE.getStatus();
    }

    private String getFirstWorkflowData(String columnName, List<String> columns) {
        int columnIndex = columns.indexOf(columnName) + 1;
        try {
            WebElement element = waitMoment.until(visibilityOfElementLocated(
                    xpath(format(workflowPO.getTableFieldValue(), columnIndex))));
            return getElementText(waitShort, element);
        } catch (TimeoutException ex) {
            return null;
        }
    }

    public String getFirstWorkflowName() {
        waitShort.until(numberOfElementsToBeMoreThan(workflowPO.getWorkflowNameTableRow(), 0));
        return getRowChildElementText(workflowPO.getWorkflowNameTableRow(), workflowPO.getWorkflowNameTableField());
    }

    public String getInputValue(String fieldName) {
        return getAttributeOrText(xpath(format(workflowPO.getInputWithLabel(), fieldName)), VALUE);
    }

    public String getDescriptionValue() {
        return getAttributeOrText(workflowPO.getDescriptionInput(), VALUE);
    }

    public String getWorkflowInputLabelText(String fieldName) {
        return getElementText(getElement(xpath(format(workflowPO.getInputRequiredIndicator(), fieldName))));
    }

    public String getValidationMessageForField(String fieldName) {
        return waitMoment.until(visibilityOfElementLocated(
                xpath(format(workflowPO.getInputValidationMessage(), fieldName)))).getText();
    }

    public String getErrorMessageElementCSS(String fieldName, String cssValue) {
        return getCssValue(xpath(format(workflowPO.getInputValidationMessage(), fieldName)), cssValue);
    }

    public String getAssignedGroupIndex(int componentPosition, String activityName) {
        return getElementText(
                xpath(format(workflowPO.getActivityAssignedGroup(), componentPosition, activityName)));
    }

    public String getPageHeaderText() {
        return getElementText(waitLong.until(visibilityOfElementLocated(workflowPO.getPageHeader())));
    }

}