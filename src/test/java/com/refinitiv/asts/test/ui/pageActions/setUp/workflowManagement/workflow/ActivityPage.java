package com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.workflow;

import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.workflowManagement.workflow.ActivityTabPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowActivityData;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.testng.util.Strings;

import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.enums.Status.INACTIVE;
import static com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.workflowManagement.workflow.ActivitySteps.*;
import static com.refinitiv.asts.test.utils.FileUtil.getFilePath;
import static java.lang.String.format;
import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.StringUtils.isBlank;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.numberOfElementsToBeMoreThan;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated;

public class ActivityPage extends BasePage<ActivityPage> {

    public static final String ACTIVITY_TYPE = "Activity Type";
    public static final String SCOPE_TYPE = "Scope Type";
    public static final String ACTIVITY_NAME = "Activity Name";
    public static final String DESCRIPTION = "Description";
    public static final String USER_RADIO = "User radio";
    public static final String GROUP_RADIO = "Group radio";
    public static final String RESPONSIBLE_PARTY_RADIO = "Responsible Party radio";
    public static final String PENDING_FOR_ASSIGNMENT = "Pending for Assignment";
    public static final String ASSIGNEE = "Assignee(s)";
    public static final String STATUS = "Status";
    public static final String RISK_AREA = "Risk Area";
    public static final String ATTACHMENT = "Attachment";
    public static final String DUE_IN = "Due In";
    public static final String RELEVANT_QUESTIONNAIRES = "Relevant Questionnaires";
    private final ActivityTabPO activityPO;

    public ActivityPage(WebDriver driver) {
        super(driver);
        activityPO = new ActivityTabPO(driver);
    }

    @Override
    protected ExpectedCondition<ActivityPage> getPageLoadCondition() {
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

    public boolean isTabWithNameDisplayed(String name) {
        return isElementDisplayed(xpath(format(activityPO.getTabName(), name)));
    }

    public boolean isUserRadioButtonDisplayed() {
        return isElementPresent(activityPO.getRadioUserAssignee());
    }

    public boolean isGroupRadioButtonDisplayed() {
        return isElementPresent(activityPO.getRadioGroupAssignee());
    }

    public boolean isEditButtonEnabled() {
        return !isElementAttributeContains(activityPO.getEditButton(), CLASS, DISABLED);
    }

    public boolean isEditActivityStatusFieldDisabled() {
        return isElementAttributeContains(activityPO.getStatusInput(), CLASS, DISABLED);
    }

    public boolean areAssessmentFieldDisabled() {
        for (WebElement element : getElements(activityPO.getAssessmentValuesInput())) {
            if (!isElementAttributeContains(element, CLASS, DISABLED)) {
                return false;
            }
        }
        return true;
    }

    public boolean isAssessmentFieldDisplayed() {
        return isElementDisplayed(activityPO.getAssessmentValuesInput());
    }

    public boolean isAssigneeInputHidden() {
        return isElementDisappeared(waitShort, activityPO.getAssigneesInput());
    }

    public boolean isActivityTypeDropdownEnabled() {
        return !isAttributePresent(activityPO.getActivityTypeInput(), DISABLED);
    }

    public boolean isActivityNameFieldEnabled() {
        return !isAttributePresent(activityPO.getNameInput(), DISABLED);
    }

    public boolean isDescriptionFieldEnabled() {
        return !isAttributePresent(activityPO.getDescriptionInput(), DISABLED);
    }

    public boolean isUserRadioEnabled() {
        return !isAttributePresent(activityPO.getRadioUserAssignee(), DISABLED);
    }

    public boolean isGroupRadioEnabled() {
        return !isAttributePresent(activityPO.getRadioGroupAssignee(), DISABLED);
    }

    public boolean isResponsiblePartyRadioEnabled() {
        return !isAttributePresent(activityPO.getResponsiblePartyAssignee(), DISABLED);
    }

    public boolean isAssigneesDropdownEnabled() {
        return !isAttributePresent(activityPO.getAssigneesInput(), DISABLED);
    }

    public boolean isPendingForAssignmentCheckboxEnabled() {
        return !isAttributePresent(activityPO.getActivityPendingCheckbox(), DISABLED);
    }

    public boolean isStatusFieldEnabled() {
        return !isAttributePresent(activityPO.getStatusInput(), DISABLED);
    }

    public boolean isRiskAreaEnabled() {
        return !isAttributePresent(activityPO.getRiskAreaInput(), DISABLED);
    }

    public boolean isAttachmentFieldEnabled() {
        return !isAttributePresent(activityPO.getAttachmentInput(), DISABLED);
    }

    public boolean isDueInEnabled() {
        return !isAttributePresent(activityPO.getDueInInput(), DISABLED);
    }

    public boolean isActivityTabDisabled(String tabName) {
        return isElementAttributeContains(xpath(format(activityPO.getTabName(), tabName)), CLASS, DISABLED);
    }

    public boolean isUserGroupRadioButtonDisabled() {
        return isElementAttributeContains(activityPO.getRadioGroupAssignee(), CLASS, DISABLED);
    }

    public boolean isPendingForAssignmentCheckboxDisabled() {
        return isElementAttributeContains(activityPO.getActivityPendingCheckbox(), CLASS, DISABLED);
    }

    public boolean isFieldEnabled(String field) {
        switch (field) {
            case ACTIVITY_NAME:
                return isActivityNameFieldEnabled();
            case ACTIVITY_TYPE:
                return isActivityTypeDropdownEnabled();
            case DESCRIPTION:
                return isDescriptionFieldEnabled();
            case USER_RADIO:
                return isUserRadioEnabled();
            case GROUP_RADIO:
                return isGroupRadioEnabled();
            case RESPONSIBLE_PARTY_RADIO:
                return isResponsiblePartyRadioEnabled();
            case ASSIGNEE:
                return isAssigneesDropdownEnabled();
            case PENDING_FOR_ASSIGNMENT:
                return isPendingForAssignmentCheckboxEnabled();
            case STATUS:
                return isStatusFieldEnabled();
            case RISK_AREA:
                return isRiskAreaEnabled();
            case ATTACHMENT:
                return isAttachmentFieldEnabled();
            case DUE_IN:
                return isDueInEnabled();
            default:
                throw new IllegalArgumentException(format("Field %s is not recognized", field));
        }
    }

    public boolean isPickResponsiblePartyRadio() {
        return isElementAttributeContains(activityPO.getResponsiblePartyAssignee(), CLASS, CHECKED);
    }

    private boolean isPendingForAssignmentSelected() {
        return driver.findElement(activityPO.getActivityPendingCheckbox()).isSelected();
    }

    public boolean isExternalRelevantQuestionnairesDropdownEnabled() {
        return driver.findElement(activityPO.getExternalRelevantQuestionnaireDropdownButton()).isEnabled();
    }

    public boolean isInternalRelevantQuestionnairesDropdownEnabled() {
        return driver.findElement(activityPO.getInternalRelevantQuestionnaireDropdownButton()).isEnabled();
    }

    public boolean isQuestionnaireTypeRadioButtonSelected(String questionnaireType) {
        return driver.findElement(
                        new By.ByCssSelector(format(activityPO.getQuestionnaireTypeRadioButton(), questionnaireType)))
                .isSelected();
    }

    @Override
    public void load() {

    }

    public void clickEditButton() {
        clickOn(activityPO.getEditButton());
    }

    public void fillInActivityData(WorkflowActivityData activityData) {
        fillInActivityName(activityData.getActivityName());
        fillInDescription(activityData.getDescription());
        fillInActivityType(activityData.getActivityType());
        selectAssigneeType(activityData.getIsUserAssignee());
        fillInAssignee(activityData.getAssignee(), activityData.getIsUserAssignee());
        fillInDueDate(activityData.getDueIn());
        selectScopeType(activityData.getScopeType());
        selectPendingForAssignment(activityData.getPendingForAssignment());
        uploadAttachment(activityData.getAttachments());
        selectScope(activityData.getScope());
    }

    public void fillInActivityType(String type) {
        int count = 1;
        int maxTries = 5;
        waitMoment.until(visibilityOfElementLocated(activityPO.getActivityTypeInput()));
        fillInDropDownWithRetry(activityPO.getActivityTypeInput(), type, activityPO.getDropDownOption());
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        logger.info(count + " try: Activity Type is " + getInputValue(ACTIVITY_TYPE));
        while ((Strings.isNullOrEmpty(getInputValue(ACTIVITY_TYPE)) || !getInputValue(ACTIVITY_TYPE).equals(type)) &&
                count++ <= maxTries) {
            fillInDropDownWithRetry(activityPO.getActivityTypeInput(), type, activityPO.getDropDownOption());
            logger.info(count + " try: Activity Type is " + getInputValue(ACTIVITY_TYPE));
        }
    }

    public void fillInRelevantQuestionnaire(String questionnaire) {
        clearAndFillInValueAndSelectFromDropDown(questionnaire, activityPO.getRelevantQuestionnairesInput());
    }

    public void fillInActivityName(String name) {
        waitShort.until(visibilityOfElementLocated(activityPO.getNameInput()));
        clearText(getElement(activityPO.getNameInput()));
        getElement(activityPO.getNameInput()).sendKeys(name);
        enterViaKeyboard(Keys.ENTER);
    }

    public void fillInDescription(String description) {
        clearAndInputField(activityPO.getDescriptionInput(), description);
    }

    public void selectAssigneeType(Boolean isUserAssignee) {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (nonNull(isUserAssignee)) {
            if (isUserAssignee) {
                pickUserRadio();
            } else {
                pickGroupRadio();
            }
        }
    }

    public void pickUserRadio() {
        clickOn(activityPO.getRadioUserAssignee());
    }

    public void pickGroupRadio() {
        clickOn(activityPO.getRadioGroupAssignee());
    }

    public void pickResponsiblePartyRadio() {
        selectAssigneeRadio(activityPO.getResponsiblePartyAssignee());
    }

    public void fillInAssignee(String assignee, Boolean isUserAssignee) {
        if (nonNull(assignee) && nonNull(isUserAssignee)) {
            clearAndFillInValueAndSelectFromDropDown(assignee, activityPO.getAssigneesInput(),
                    activityPO.getDropDownOption());
        }
    }

    public void fillInDueDate(String dueDate) {
        clearAndInputField(activityPO.getDueInInput(), dueDate);
    }

    public void selectScopeType(String scopeType) {
        if (nonNull(scopeType)) {
            fillInDropDownWithRetry(activityPO.getScopeTypeInput(), scopeType,
                    activityPO.getDropDownOption());
        }
    }

    public void selectScope(String scope) {
        if (!isBlank(scope)) {
            clickOn(xpath(format(activityPO.getScopeValueButton(), scope)));
        } else if (nonNull(scope) && scope.isEmpty()) {
            clickOn(activityPO.getScopeInputs());
        }
    }

    public void selectPendingForAssignment(Boolean isChecked) {
        if (nonNull(isChecked)) {
            if (isChecked) {
                tickPendingForAssignmentCheckbox();
            }
        }
    }

    public void uploadAttachment(String attachment) {
        if (nonNull(attachment)) {
            String path = getFilePath(attachment);
            if (isElementDisplayed(activityPO.getAttachmentDeleteIcon())) {
                clickOn(activityPO.getAttachmentInput());
            }
            driver.findElement(activityPO.getAttachmentInput()).sendKeys(path);
            waitShort.until(visibilityOfElementLocated(activityPO.getAttachmentDeleteIcon()));
        }
    }

    public void clickDone() {
        clickOn(activityPO.getButtonDone());
    }

    public void clickActivityTab(String tabName) {
        clickOn(xpath(format(activityPO.getTabName(), tabName)));
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    public void clickDropDownActivityType() {
        clickOn(xpath(format(activityPO.getDropDownArrow(), ACTIVITY_TYPE)));
    }

    public void clickDropDownRiskArea() {
        clickOn(xpath(format(activityPO.getDropDownArrow(), RISK_AREA)));
    }

    public void clickDropDownAssignee() {
        clickOn(xpath(format(activityPO.getDropDownArrow(), ASSIGNEE)));
    }

    public void clickRelevantQuestionnairesDropdown() {
        clickOn(xpath(format(activityPO.getDropDownArrow(), RELEVANT_QUESTIONNAIRES)));
    }

    public void tickPendingForAssignmentCheckbox() {
        clickOn(activityPO.getActivityPendingCheckbox());
    }

    public void tickAutomaticallyOrderRecommendedScopeofDueDiligenceReportCheckbox() {
        clickOn(activityPO.getActivityAutoDDOCheckbox());
    }

    public void tickRetrieveReviewerQuestionnaireCheckbox() {
        clickOn(activityPO.getActivityRetrieveReviewerQuestionnaireCheckbox());
    }

    private void selectAssigneeRadio(By radio) {
        scrollIntoView(radio);
        clickOn(radio, waitMoment);
    }

    public void clearFormFields(String assigneeType) {
        clearText(getElement(activityPO.getDescriptionInput()));
        clearText(getElement(activityPO.getNameInput()));
        clearText(getElement(activityPO.getActivityTypeInput()));
        switch (assigneeType.toLowerCase()) {
            case USER:
            case GROUP:
                clearText(getElement(activityPO.getAssigneesInput()));
                break;
            case RESPONSIBLE_PARTY:
                break;
            default:
                throw new IllegalArgumentException(assigneeType + " is unknown assignee type");
        }
        clearText(getElement(activityPO.getDueInInput()));
    }

    public void selectQuestionnaireByType(String type) {
        clickOn(By.cssSelector(format(activityPO.getQuestionnaireTypeRadioButton(), type)));
    }

    public String getActivityInputRequiredIndicator(String fieldName) {
        return getElementText(getElement(xpath(format(activityPO.getInputRequiredIndicator(), fieldName))));
    }

    public String getEditAssigneesValue(boolean isUserAssignee) {
        String assignee;
        if (isUserAssignee) {
            String assigneeWithEmail = getAttributeValue(activityPO.getAssigneesInput(), VALUE);
            assignee = isNull(assigneeWithEmail) ? null : assigneeWithEmail;
        } else {
            assignee = getAttributeValue(activityPO.getAssigneesInput(), VALUE);
        }
        return assignee;
    }

    public String getValidationMessageForDropDownField(String fieldName) {
        return waitMoment.until(visibilityOfElementLocated(
                xpath(format(activityPO.getInputValidationMessage(), fieldName)))).getText();
    }

    public String getActivityTabColor(String tabName) {
        return getCssValue(xpath(format(activityPO.getTabName(), tabName)), COLOR);
    }

    public String getCurrentRelevantQuestionnaireDropdownValue() {
        return getElementText(activityPO.getRelevantQuestionnaireDropdownValue());
    }

    public String getStatus() {
        return isCheckboxChecked(activityPO.getActivityAutoDDOCheckbox()) ? ACTIVE.getStatus() : INACTIVE.getStatus();
    }

    private String getInputValue(String fieldName) {
        return getAttributeOrText(xpath(format(activityPO.getInputWithLabel(), fieldName)), VALUE);
    }

    private String getEditDescriptionValue() {
        return getAttributeValueWithWait(waitMoment, activityPO.getDescriptionInput(), VALUE);
    }

    private String getAttachmentValue() {
        return getElementText(activityPO.getAttachmentInput());
    }

    public List<String> getDropDownValues() {
        waitShort.until(numberOfElementsToBeMoreThan(activityPO.getDropDownOptions(), 1));
        return getDropDownOptions(activityPO.getDropDownOptions());
    }

    public List<String> getAssessmentFieldsTexts() {
        List<WebElement> elements = getElements(activityPO.getAssessmentValuesInput());
        return elements.isEmpty() ? null : elements.stream().map(input -> input.getAttribute(VALUE))
                .collect(Collectors.toList());
    }

    private List<String> getEditAssessmentList() {
        List<String> valuesList = getElements(activityPO.getAssessmentValuesInput()).stream()
                .map(webElement -> webElement.getAttribute(VALUE)).collect(Collectors.toList());
        return valuesList.isEmpty() ? null : valuesList;
    }

    public WorkflowActivityData getActivityDetails() {
        return new WorkflowActivityData()
                .setActivityName(getInputValue(ACTIVITY_NAME))
                .setActivityType(getInputValue(ACTIVITY_TYPE))
                .setDescription(getEditDescriptionValue())
                .setAssessment(getAssessmentFieldsTexts())
                .setAssignee(getInputValue(ASSIGNEE))
                .setPendingForAssignment(isPendingForAssignmentSelected())
                .setStatus(getInputValue(STATUS))
                .setRiskArea(getInputValue(RISK_AREA))
                .setAttachments(getAttachmentValue())
                .setDueIn(getInputValue(DUE_IN));
    }

    public WorkflowActivityData getEditActivityDetails(boolean isUserAssignee) {
        return new WorkflowActivityData()
                .setActivityName(getInputValue(ACTIVITY_NAME))
                .setActivityType(getInputValue(ACTIVITY_TYPE))
                .setDescription(getEditDescriptionValue())
                .setAssessment(getEditAssessmentList())
                .setAssignee(getEditAssigneesValue(isUserAssignee))
                .setPendingForAssignment(isPendingForAssignmentSelected())
                .setStatus(getInputValue(STATUS))
                .setRiskArea(getInputValue(RISK_AREA))
                .setAttachments(getAttachmentValue())
                .setDueIn(getInputValue(DUE_IN));
    }

    public void tickActivityCheckbox() {
        clickOn(activityPO.getActivityPendingCheckbox());
    }

    public void fillInScopeType(String type) {
        int count = 1;
        int maxTries = 5;
        waitMoment.until(visibilityOfElementLocated(activityPO.getScopeTypeInput()));
        fillInDropDownWithRetry(activityPO.getScopeTypeInput(), type, activityPO.getDropDownOption());
        logger.info(count + " try: Scope Type is " + getInputValue(SCOPE_TYPE));
        while ((Strings.isNullOrEmpty(getInputValue(SCOPE_TYPE)) || !getInputValue(SCOPE_TYPE).equals(type)) &&
                count++ <= maxTries) {
            fillInDropDownWithRetry(activityPO.getScopeTypeInput(), type, activityPO.getDropDownOption());
            logger.info(count + " try: Scope Type is " + getInputValue(SCOPE_TYPE));
        }
    }

    public boolean isActivityCheckboxDisabled() {
        return isElementAttributeContains(activityPO.getActivityPendingCheckbox(), CLASS, DISABLED);
    }

    public String getRecommendedScopeErrorMessage() {
        return getElementText(getElement(xpath(format(activityPO.getFieldErrorClassInRecommendedScope()))));

    }
}