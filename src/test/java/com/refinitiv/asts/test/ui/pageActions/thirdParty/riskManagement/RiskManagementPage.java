package com.refinitiv.asts.test.ui.pageActions.thirdParty.riskManagement;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.constants.Pages;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.riskManagement.RiskManagementPO;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.*;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.ACTIVITY_ID;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.THIRD_PARTY_ID;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.DELETE;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.EDIT;
import static com.refinitiv.asts.test.ui.constants.Pages.SLASH;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static java.lang.String.format;
import static java.util.Arrays.asList;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.apache.commons.text.WordUtils.capitalizeFully;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.presenceOfElementLocated;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated;

public class RiskManagementPage extends BasePage<RiskManagementPage> {

    private final RiskManagementPO riskManagementPO;
    public static final String RISK_MANAGEMENT_TAB = "RISK MANAGEMENT";
    public static final String ACTIVITY_NAME = "Activity Name";
    public static final String DESCRIPTION = "Description";
    public static final String NAME = "NAME";
    public static final String STATUS = "STATUS";
    public static final String FINAL_ASSESSMENT = "FINAL ASSESSMENT";
    public static final String OVERALL_RISK_SCORE = "OVERALL RISK SCORE";
    public static final String INITIATED_BY = "INITIATED BY";
    public static final String START_DATE = "START DATE";
    public static final String LAST_UPDATE = "LAST UPDATE";
    public static final List<String> ACTION_BUTTONS = asList("Edit", "Delete");
    public static final String SOURCE = "SOURCE";
    public static final String SEARCH_TERM = "SEARCH TERM";
    public static final String TAG_AS_RED_FLAG_RECORD = "TAG AS RED FLAG RECORD";
    public static final String REFERENCE_ID = "REFERENCE ID";
    public static final String RED_FLAG_DATE = "RED FLAG DATE";
    public static final String QUESTIONNAIRE_ASSIGNMENT_ID = "QUESTIONNAIRE ASSIGNMENT ID";
    public static final String QUESTIONNAIRE_NAME = "QUESTIONNAIRE NAME";
    public static final String QUESTION = "QUESTION";
    public static final String ANSWER = "ANSWER";
    public static final String ATTACHMENT = "ATTACHMENT";
    public static final String ASSIGNEE = "ASSIGNEE";
    public static final String DATE_SUBMITTED = "DATE SUBMITTED";
    public static final String CUSTOM_FIELD = "CUSTOM FIELD";
    public static final String VALUE = "VALUE";

    public RiskManagementPage(WebDriver driver, ScenarioCtxtWrapper context, LanguageConfig translator) {
        super(driver, context, translator);
        riskManagementPO = new RiskManagementPO(driver, translator);
    }

    @Override
    protected ExpectedCondition<RiskManagementPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return isElementDisplayed(waitShort, riskManagementPO.getRiskManagementHeader());
    }

    @Override
    public void load() {

    }

    public void openCreatedAdHocActivity() {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        String adhocActivityId = (String) context.getScenarioContext().getContext(ACTIVITY_ID);
        driver.get(URL + Pages.THIRD_PARTY + SLASH + thirdPartyId + format(Pages.AD_HOC_ACTIVITY, adhocActivityId));
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void clickOnRiskManagementTab() {
        clickWithJS(waitLong.until(
                visibilityOfElementLocated(xpath(format(riskManagementPO.getButton(), RISK_MANAGEMENT_TAB)))));
    }

    public void clickOnButtonWithName(String buttonName) {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(xpath(format(riskManagementPO.getActivityButtonWithName(), buttonName)), waitShort);
    }

    public boolean isAdhocActivityFieldEnabled(String fieldName) {
        return isElementEnabled(xpath(format(riskManagementPO.getInputField(), fieldName)));
    }

    public void clickRiskManagementCancelButton() {
        clickOn(riskManagementPO.getRiskManagementCancelButton(), waitShort);
    }

    public void fillInDropDown(String dropDownName, String value) {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        clickOn(xpath(format(riskManagementPO.getInputField(), capitalizeFully(dropDownName.toLowerCase()))), waitMoment);
        clearAndFillInValueAndSelectFromDropDown(value, xpath(format(riskManagementPO.getInputField(),
                                                                     capitalizeFully(
                                                                             dropDownName.toLowerCase()))));
    }

    public void clearDropDown(String dropDownName) {
        waitWhilePreloadProgressbarIsDisappeared();
        clearAndInputField(xpath(format(riskManagementPO.getInputField(), capitalizeFully(dropDownName.toLowerCase()))),
                           EMPTY);
        moveToElementAndClick(driver.findElement(xpath(format(riskManagementPO.getClearButton(), dropDownName))));
    }

    public void clickDropdown(String dropDownName) {
        clickOn(xpath(format(riskManagementPO.getInputField(), capitalizeFully(dropDownName))));
    }

    public boolean isDropdownDisplayed(String dropDownName) {
        return isElementDisplayed(xpath(format(riskManagementPO.getInputField(), capitalizeFully(dropDownName))));
    }

    public void fillInActivityNameField(String value) {
        clearAndInputField(riskManagementPO.getActivityNameField(), value);
    }

    public void fillInDescriptionField(String value) {
        clearAndInputField(riskManagementPO.getDescriptionField(), value);
    }

    public void openDueDateDateSelection() {
        clickOn(riskManagementPO.getDueDateDateTrigger());
    }

    public void selectDueDate(int daysAfterToday) {
        clickOn(xpath(format(riskManagementPO.getAbleDueDate(), daysAfterToday + 1)));
    }

    public void clickOnActivityRowWithName(String activityName) {
        scrollIntoView(xpath(format(riskManagementPO.getActivityWithNameRowInTable(), activityName)));
        clickOn(xpath(format(riskManagementPO.getActivityWithNameRowInTable(), activityName)), waitShort);
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void clickOnActionButtonActivityRowWithName(String activityName, String actionIcon) {
        clickOn(xpath(format(riskManagementPO.getActionActivityIconWithNameRow(), activityName, actionIcon)));
    }

    public void clickOnDoneReviewerButton() {
        clickOn(riskManagementPO.getAddReviewerButton());
    }

    public void clickOnCancelReviewerButton() {
        clickOn(riskManagementPO.getCancelReviewerButton());
    }

    public void clearField(String fieldName) {
        clearText(xpath(format(riskManagementPO.getInputField(), fieldName)));
    }

    public void clickOnAdHocActivityName(String activityName) {
        clickOn(xpath(format(riskManagementPO.getActivityNameInTable(), activityName)), waitShort);
    }

    public void clickOnAdHocActivitySaveButton() {
        clickOn(riskManagementPO.getAdHocActivitySaveButton());
    }

    public void clickEditReviewer(String reviewerName) {
        clickOn(xpath(format(riskManagementPO.getEditReviewerButton(), reviewerName)));
    }

    public void clickDeleteReviewer(String reviewerName) {
        clickOn(xpath(format(riskManagementPO.getDeleteReviewerButton(), reviewerName)), waitShort);
    }

    public void clickReviewerEditModeButton(String buttonName) {
        clickOn(xpath(format(riskManagementPO.getReviewerEditModeButton(), buttonName)));
    }

    public void clickOnAdHocRowButton(String buttonName, String rowName) {
        clickOn(xpath(format(riskManagementPO.getRowActionButton(), rowName, ACTION_BUTTONS.indexOf(buttonName) + 1)));
    }

    public List<String> getWorkflowTableHeaders() {
        return getElementsText(riskManagementPO.getWorkflowTableHeaders());
    }

    public List<String> getActivityTableColumns() {
        return getElementsText(driver.findElements(riskManagementPO.getActivityTableHeaderNames()));
    }

    public List<String> getListValuesForColumn(String columnName) {
        int columnIndex = getActivityTableColumns().indexOf(columnName.toUpperCase()) + 1;
        return driver.findElements(riskManagementPO.getActivityTableRows()).stream()
                .map(row -> getElementText(
                        row.findElement(xpath(format(riskManagementPO.getActivityTableRowValue(), columnIndex)))))
                .collect(Collectors.toList());
    }

    public List<RiskManagementItemData> getAdHocActivityTableRows() {
        List<String> columnNames = getActivityTableColumns();
        return driver.findElements(riskManagementPO.getActivityTableRows()).stream()
                .map(row -> new RiskManagementItemData()
                        .setName(getColumnValue(row, columnNames, NAME))
                        .setStatus(getColumnValue(row, columnNames, STATUS))
                        .setOverallRiskScore(getColumnValue(row, columnNames, OVERALL_RISK_SCORE))
                        .setInitiatedBy(getColumnValue(row, columnNames, INITIATED_BY))
                        .setStartDate(getColumnValue(row, columnNames, START_DATE))
                        .setLastUpdate(getColumnValue(row, columnNames, LAST_UPDATE)))
                .collect(Collectors.toList());
    }

    public List<WorkflowActivityTableData> getWorkflowActivityTableRows() {
        List<String> columnNames = getWorkflowTableHeaders();
        return driver.findElements(riskManagementPO.getWorkflowDetailsRows()).stream()
                .map(row -> new WorkflowActivityTableData()
                        .setName(getColumnValue(row, columnNames, NAME))
                        .setStatus(getColumnValue(row, columnNames, STATUS))
                        .setFinalAssessment(getColumnValue(row, columnNames, FINAL_ASSESSMENT))
                        .setOverallRiskScore(getColumnValue(row, columnNames, OVERALL_RISK_SCORE))
                        .setInitiatedBy(getColumnValue(row, columnNames, INITIATED_BY))
                        .setStartDate(getColumnValue(row, columnNames, START_DATE))
                        .setLastUpdate(getColumnValue(row, columnNames, LAST_UPDATE)))
                .collect(Collectors.toList());
    }

    public Boolean checkTableActivityHasEditDeleteIcons(String activityName, String icon) {
        WebElement activityRow = driver.findElements(riskManagementPO.getActivityTableRows())
                .stream()
                .filter(row -> row.getText().contains(activityName))
                .findFirst()
                .orElseThrow(() -> new RuntimeException(format("Activity '%s' was not found", activityName)));
        switch (icon) {
            case EDIT:
                return isElementDisplayed(activityRow.findElements(riskManagementPO.getRowActionIcons()).get(0));
            case DELETE:
                return isElementDisplayed(activityRow.findElements(riskManagementPO.getRowActionIcons()).get(1));
            default:
                throw new IllegalArgumentException(format("Improper icon name - %s", icon));
        }
    }

    private String getColumnValue(WebElement row, List<String> columnNames, String columnName) {
        int columnNameIndex = columnNames.indexOf(columnName) + 1;
        return columnNameIndex == 0 ? null :
                getElementText(row.findElement(xpath(format(riskManagementPO.getActivityTableRowValue(),
                                                            columnNameIndex))));
    }

    public String getEmptyTableText(String sectionName) {
        return getElementText(xpath(format(riskManagementPO.getEmptyTableText(), sectionName)));
    }

    public boolean isActivityPageWithNameDisplayed(String modalName) {
        return isElementDisplayed(xpath(format(riskManagementPO.getActivityPageWithName(), modalName)));
    }

    public boolean isButtonWithNameDisplayed(String buttonName) {
        return isElementDisplayed(waitShort, xpath(format(riskManagementPO.getActivityButtonWithName(), buttonName)));
    }

    public boolean isFieldRequired(String fieldName) {
        return isElementDisplayed(xpath(format(riskManagementPO.getRequiredField(), fieldName)));
    }

    public boolean isRedAsteriskDisplayed(String fieldName) {
        return isElementDisplayed(xpath(format(riskManagementPO.getRedAsterisk(), fieldName)));
    }

    public boolean isErrorMessageDisplayed(String fieldName) {
        return isElementDisplayed(xpath(format(riskManagementPO.getErrorMessage(), fieldName)));
    }

    public boolean doesFieldHaveErrorAttribute(String fieldName) {
        return isElementDisplayed(xpath(format(riskManagementPO.getFieldErrorClass(), fieldName)));
    }

    public boolean isAdHocActivityDisplayed(String activityName) {
        return isElementDisplayed(waitShort, xpath(format(riskManagementPO.getActivityNameInTable(), activityName)));
    }

    public boolean isReviewersTableDisplayed() {
        waitWhilePreloadProgressbarIsDisappeared();
        return isElementDisplayed(riskManagementPO.getReviewersTable());
    }

    public String getReviewerName() {
        return getElementText(riskManagementPO.getReviewerInReviewersTable());
    }

    public boolean isFieldEnabled(String field) {
        return !isAttributePresent(xpath(format(riskManagementPO.getInputField(), field)), DISABLED);
    }

    public boolean areAdHocActivityButtonsDisplayed(String buttonName) {
        int buttonIndex = ACTION_BUTTONS.indexOf(buttonName) + 1;
        return driver.findElements(riskManagementPO.getActivityTableRows())
                .stream()
                .allMatch(row -> isElementDisplayed(
                        row.findElement(xpath(format(riskManagementPO.getRowActionButtons(), buttonIndex)))));
    }

    public boolean areAdHocActivityButtonsEnabled(String buttonName) {
        int buttonIndex = ACTION_BUTTONS.indexOf(buttonName) + 1;
        return driver.findElements(riskManagementPO.getActivityTableRows())
                .stream()
                .allMatch(row -> row.findElement(xpath(format(riskManagementPO.getRowActionButtons(), buttonIndex)))
                        .isEnabled());
    }

    public boolean isRiskManagementTabSelected() {
        return getAttributeValue(waitShort.until(
                visibilityOfElementLocated(xpath(format(riskManagementPO.getButton(), RISK_MANAGEMENT_TAB)))), CLASS)
                .contains(MUI_SELECTED);
    }

    public void clickRiskRemediationTab(String tabName) {
        clickOn(xpath(format(riskManagementPO.getRiskRemediationTab(), tabName)));
    }

    public boolean isRiskRemediationTabDisplayed(String tabName) {
        return isElementDisplayed(xpath(format(riskManagementPO.getRiskRemediationTab(), tabName)));
    }

    public List<String> getRiskRemediationMediaCheckTableColumns() {
        return getElementsText(riskManagementPO.getRiskRemediationMediaCheckTableColumns());
    }

    public List<String> getRiskRemediationTabs() {
        return getElementsText(riskManagementPO.getRiskRemediationTabs());
    }

    public int getRowsCount() {
        if (isElementDisplayed(riskManagementPO.getRiskRemediationTableRows())) {
            return getElements(riskManagementPO.getRiskRemediationTableRows()).size();
        } else {
            return 0;
        }
    }

    public String getEmptyTableMessage() {
        return getElementText(waitShort, riskManagementPO.getRiskRemediationMessage());
    }

    public boolean isEmptyTableMessageDisplayed() {
        return isElementDisplayed(riskManagementPO.getRiskRemediationMessage());
    }

    public boolean isRiskManagementSectionDisplayed(String section) {
        return isElementDisplayed(xpath(format(riskManagementPO.getRiskManagementSection(), section)));
    }

    public boolean isRiskManagementSectionExpanded(String section) {
        return getAttributeValueWithWait(waitShort, xpath(format(riskManagementPO.getRiskManagementSection(), section)),
                                         CLASS).contains(MUI_EXPANDED);
    }

    public List<String> getRiskRemediationWorldCheckTableColumns() {
        return getElementsText(riskManagementPO.getRiskRemediationWorldCheckTableColumns());
    }

    public List<String> getRiskRemediationQuestionnaireTableColumns() {
        return getElementsText(riskManagementPO.getRiskRemediationQuestionnaireColumns());
    }

    public List<String> getRiskRemediationCustomFieldsTableColumns() {
        return getElementsText(riskManagementPO.getRiskRemediationCustomFieldsTableColumns());
    }

    public List<RiskRemediationMediaCheckData> getRiskRemediationMediaCheckTableData() {
        return getElements(riskManagementPO.getRiskRemediationMediaCheckTableRow()).stream()
                .map(row -> new RiskRemediationMediaCheckData()
                        .setSource(getElementText(row.findElement(riskManagementPO.getSourceValue())))
                        .setSearchTerm(getElementText(row.findElement(riskManagementPO.getSearchTermValue())))
                        .setTagAsRedFlagRecord(
                                getElementText(row.findElement(riskManagementPO.getTagAsRedFlagRecordValue())))
                        .setRedFlagDate(getElementText(row.findElement(riskManagementPO.getRedFlagDateValue()))))
                .collect(Collectors.toList());
    }

    public List<RiskRemediationWorldCheckData> getRiskRemediationWorldCheckTableData() {
        return getElements(riskManagementPO.getRiskRemediationWorldCheckTableRow()).stream()
                .map(row -> new RiskRemediationWorldCheckData()
                        .setSource(getElementText(row.findElement(riskManagementPO.getWcSourceValue())))
                        .setSearchTerm(getElementText(row.findElement(riskManagementPO.getWcSearchTermValue())))
                        .setTagAsRedFlagRecord(
                                getElementText(row.findElement(riskManagementPO.getWcTagAsRedFlagRecordValue())))
                        .setReferenceId(getElementText(row.findElement(riskManagementPO.getWcReferenceIdValue())))
                        .setRedFlagDate(getElementText(row.findElement(riskManagementPO.getWcRedFlagDateValue()))))
                .collect(Collectors.toList());
    }

    public List<RiskRemediationQuestionnaireData> getRiskRemediationQuestionnaireTableData() {
        waitWhilePreloadProgressbarIsDisappeared();
        return getElements(riskManagementPO.getRiskRemediationQuestionnaireRow()).stream()
                .map(row -> new RiskRemediationQuestionnaireData()
                        .setQuestionnaireName(getElementText(row.findElement(riskManagementPO.getQuestionnaireName())))
                        .setQuestion(getElementText(row.findElement(riskManagementPO.getQuestion())))
                        .setAnswer(getElementText(row.findElement(riskManagementPO.getAnswer())))
                        .setAttachment(getElementText(row.findElement(riskManagementPO.getAttachment())))
                        .setAssignee(getElementText(row.findElement(riskManagementPO.getAssignee())))
                        .setDateSubmitted(getElementText(row.findElement(riskManagementPO.getDateSubmitted()))))
                .collect(Collectors.toList());
    }

    public List<RiskRemediationCustomFieldsData> getRiskRemediationCustomFieldsTableData() {
        waitWhilePreloadProgressbarIsDisappeared();
        return getElements(riskManagementPO.getRiskRemediationCustomFieldsTableRow()).stream()
                .map(row -> new RiskRemediationCustomFieldsData()
                        .setCustomField(getElementText(row.findElement(riskManagementPO.getCustomField())))
                        .setValue(getElementText(row.findElement(riskManagementPO.getValue()))))
                .collect(Collectors.toList());
    }

    public List<String> getRiskRemediationMediaCheckColumnValues(String columnName) {
        waitWhilePreloadProgressbarIsDisappeared();
        switch (columnName.toUpperCase()) {
            case SOURCE:
                return getElementsText(riskManagementPO.getSourceValues());
            case SEARCH_TERM:
                return getElementsText(riskManagementPO.getSearchTermValues());
            case TAG_AS_RED_FLAG_RECORD:
                return getElementsText(riskManagementPO.getTagAsRedFlagRecordValues());
            case RED_FLAG_DATE:
                return getElementsText(riskManagementPO.getRedFlagDateValues());
            default:
                throw new IllegalArgumentException("Unexpected column Name: " + columnName);
        }
    }

    public List<String> getRiskRemediationWorldCheckColumnValues(String columnName) {
        waitWhilePreloadProgressbarIsDisappeared();
        switch (columnName.toUpperCase()) {
            case SOURCE:
                return getElementsText(riskManagementPO.getWorldCheckSourceValues());
            case SEARCH_TERM:
                return getElementsText(riskManagementPO.getWorldCheckSearchTermValues());
            case TAG_AS_RED_FLAG_RECORD:
                return getElementsText(riskManagementPO.getWorldCheckTagAsRedFlagRecordValues());
            case REFERENCE_ID:
                return getElementsText(riskManagementPO.getWorldCheckReferenceIdValues());
            case RED_FLAG_DATE:
                return getElementsText(riskManagementPO.getWorldCheckRedFlagDateValues());
            default:
                throw new IllegalArgumentException("Unexpected column Name: " + columnName);
        }
    }

    public List<String> getQuestionnaireRiskRemediationColumnValues(String columnName) {
        waitWhilePreloadProgressbarIsDisappeared();
        switch (columnName.toUpperCase()) {
            case QUESTIONNAIRE_ASSIGNMENT_ID:
                return getElementsText(riskManagementPO.getQuestionnaireAssignmentIdValues());
            case QUESTIONNAIRE_NAME:
                return getElementsText(riskManagementPO.getQuestionnaireNameValues());
            case QUESTION:
                return getElementsText(riskManagementPO.getQuestionValues());
            case ANSWER:
                return getElementsText(riskManagementPO.getAnswerValues());
            case ATTACHMENT:
                return getElementsText(riskManagementPO.getAttachmentValues());
            case ASSIGNEE:
                return getElementsText(riskManagementPO.getAssigneeValues());
            case DATE_SUBMITTED:
                return getElementsText(riskManagementPO.getDateSubmittedValues());
            default:
                throw new IllegalArgumentException("Unexpected column Name: " + columnName);
        }
    }

    public List<String> getRiskRemediationCustomFieldsColumnValues(String columnName) {
        waitWhilePreloadProgressbarIsDisappeared();
        switch (columnName.toUpperCase()) {
            case CUSTOM_FIELD:
                return getElementsText(riskManagementPO.getCustomFieldValues());
            case VALUE:
                return getElementsText(riskManagementPO.getValues());
            default:
                throw new IllegalArgumentException("Unexpected column Name: " + columnName);
        }
    }

    public void clickRiskRemediationMediaCheckColumn(String columnName) {
        clickOn(xpath(format(riskManagementPO.getMediaCheckColumn(), columnName)), waitMoment);
    }

    public void clickRiskRemediationWorldCheckColumn(String columnName) {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(xpath(format(riskManagementPO.getWorldCheckColumn(), columnName)));
    }

    public void clickRiskRemediationCustomFieldsColumn(String columnName) {
        clickOn(xpath(format(riskManagementPO.getCustomFieldsColumn(), columnName)));
    }

    public void clickMediaCheckRiskRemediationRecord(String record) {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(xpath(format(riskManagementPO.getMediaCheckRecord(), record)));
    }

    public void clickWorldCheckRiskRemediationRecord(String record) {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(xpath(format(riskManagementPO.getWorldCheckRecord(), record)));
    }

    public void clickCustomFieldsRiskRemediationRecord(String record) {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(xpath(format(riskManagementPO.getCustomFieldsRecord(), record)));
    }

    public void clickMediaCheckDetailsBackButton() {
        clickOn(riskManagementPO.getBackButton());
    }

    public void clickRiskRemediationBreadcrumb() {
        clickOn(riskManagementPO.getBreadcrumb());
    }

    public void clickRiskRemediationBreadcrumbBackIcon(String section) {
        clickOn(xpath(format(riskManagementPO.getBreadcrumbBackIcon(), section)));
    }

    public boolean isRiskRemediationBreadcrumbDisplayed() {
        return isElementDisplayed(riskManagementPO.getBreadcrumb());
    }

    public boolean isRiskRemediationQuestionnaireNoAvailableDataDisplayed() {
        return isElementDisplayed(riskManagementPO.getQuestionnaireNoAvailableData());
    }

    public void clickQuestionnaireRiskRemediationColumn(String columnName) {
        clickOn(xpath(format(riskManagementPO.getQuestionnaireColumn(), columnName)));
    }

    public void clickQuestionnaireRiskRemediationRecord(String record) {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(xpath(format(riskManagementPO.getQuestionnaireRecord(), record)));
    }

    public void clickOnWorkflow(String name, String status) {
        clickOn(waitShort.until(
                presenceOfElementLocated(xpath(format(riskManagementPO.getWorkflowRow(), name, status)))));
    }

    public boolean isAdHocActivityWithStatusDisplayed(String name, String status) {
        return isElementDisplayed(xpath(format(riskManagementPO.getWorkflowRow(), name, status)));
    }

    public boolean isActivityIconDisplayed(String activityName, String iconName) {
        return isElementDisplayed(
                waitMoment, xpath(format(riskManagementPO.getActionActivityIconWithNameRow(), activityName, iconName)));
    }

}

