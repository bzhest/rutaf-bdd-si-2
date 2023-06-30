package com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.BaseApi;
import com.refinitiv.asts.test.ui.constants.Pages;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation.ActivityInformationDisplayPO;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.ActivityInformationData;
import com.refinitiv.asts.test.ui.utils.data.ui.ActivityQuestionnaireDetailsDTO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.ACTIVITY_ID;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.THIRD_PARTY_ID;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.EDIT;
import static com.refinitiv.asts.test.ui.constants.Pages.SLASH;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.thirdPartyInformation.ScreeningSteps.ELLIPSIS;
import static freemarker.template.utility.StringUtil.emptyToNull;
import static java.lang.String.format;
import static java.lang.String.join;
import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;
import static java.util.stream.Collectors.joining;
import static java.util.stream.Collectors.toList;
import static java.util.stream.IntStream.rangeClosed;
import static org.apache.commons.lang3.StringUtils.substringAfter;
import static org.apache.commons.lang3.StringUtils.substringBetween;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class ActivityInformationDisplayPage extends BasePage<ActivityInformationDisplayPage> {

    public static final String ACTIVITY_TYPE = "Activity Type";
    public static final String ACTIVITY_NAME = "Activity Name";
    public static final String DESCRIPTION = "Description";
    public static final String RISK_AREA = "Risk Area";
    public static final String ORDER_DETAILS = "Order Details";
    public static final String START_DATE = "Start Date";
    public static final String DUE_DATE = "Due Date";
    public static final String PRIORITY = "Priority";
    public static final String ASSESSMENT = "Assessment";
    public static final String ASSIGNEE = "Assignee";
    public static final String INITIATED_BY = "Initiated By";
    public static final String STATUS = "Status";
    public static final String SCORE = "Score";
    public static final String BUTTON = "Button";
    public static final String TYPE = "Type";
    public static final String REVIEW_STATUS = "Review Status";
    public static final String ASSIGNED_TO = "Assigned To";
    public static final String LAST_UPDATE = "Last Update";
    public static final String ACTION = "Action";
    public static final String QUESTIONNAIRE_NAME = "Questionnaire Name";
    public static final String REVIEWER = "Reviewer";
    public static final String OVERALL_ASSESSMENT = "Overall Assessment";
    public static final String REFERENCE_ID = "Reference Id";
    public static final String BUTTON_NAME = "Button Name";
    public static final String NAME = "Name";
    private static final String ACTIVITY_INFORMATION_PATH_REGEX = "(%s\\/ui\\/thirdparty\\/(\\w+)\\/activity\\/(\\w+))";
    public static final int QUESTIONNAIRE_NAME_TD_NUMBER = 1;
    public static final int QUESTIONNAIRE_STATUS_TD_NUMBER = 2;
    public static final int QUESTIONNAIRE_ASSIGNEE_TD_NUMBER = 3;
    public static final int QUESTIONNAIRE_REVIEWER_TD_NUMBER = 4;
    public static final int QUESTIONNAIRE_OVERALL_ASSESSMENT_TD_NUMBER = 5;
    public static final int QUESTIONNAIRE_SCORE_TD_NUMBER = 6;
    public static final int QUESTIONNAIRE_BUTTON = 8;

    private final ActivityInformationDisplayPO activityInformationPO;
    private final LanguageConfig translator;

    public ActivityInformationDisplayPage(WebDriver driver, ScenarioCtxtWrapper context, LanguageConfig translator) {
        super(driver, context, translator);
        this.translator = translator;
        activityInformationPO = new ActivityInformationDisplayPO(driver, translator);
        this.get();
    }

    @Override
    protected ExpectedCondition<ActivityInformationDisplayPage> getPageLoadCondition() {
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

    public void openCreatedActivity() {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        String adhocActivityId = (String) context.getScenarioContext().getContext(ACTIVITY_ID);
        driver.get(URL + Pages.THIRD_PARTY + SLASH + thirdPartyId + format(Pages.ACTIVITY, adhocActivityId));
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public ActivityInformationDisplayPage clickEditButton() {
        int count = 1;
        int maxTries = 3;
        while (count++ <= maxTries) {
            try {
                waitLong.until(visibilityOfElementLocated(activityInformationPO.getEditButton()));
                waitShort.until(elementToBeClickable(activityInformationPO.getEditButton()));
                clickWithJS(driver.findElement(activityInformationPO.getEditButton()));
                if (!isElementDisplayed(activityInformationPO.getEditButton())) {
                    break;
                }
            } catch (TimeoutException | StaleElementReferenceException e) {
                refreshPage();
                logger.error("Error while clicking on Edit button");
            }
        }
        waitWhilePreloadProgressbarIsDisappeared();
        return this;
    }

    public void clickCreateOrderButton() {
        clickWithJS(waitLong.until(visibilityOfElementLocated(activityInformationPO.getCreateOrderButton())));
    }

    public void clickCancelConfirmationPopUpButton() {
        WebElement element = driver.findElement(activityInformationPO.getDeclineConfirmationPopUpCancelBtn());
        clickWithJS(element);
    }

    public void clickDeclineOrderButton() {
        WebElement element = getElement(activityInformationPO.getDeclineButton());
        clickWithJS(element);
    }

    public void clickOrderDetailsBtn() {
        clickOn(activityInformationPO.getOrderDetailsBtn(), waitLong);
    }

    public void clickBackButtonForActivityPage() {
        clickOn(activityInformationPO.getActivityBackButton(), waitLong);
    }

    public void clickReassignForApprovalButton() {
        clickOn(activityInformationPO.getReassignForApprovalButton(), waitShort);
    }

    public void clickCancelActivityInformationButton() {
        clickWithJS(getElement(activityInformationPO.getCancelButton()));
    }

    public void clickAssignActivityInformationButton() {
        clickOn(activityInformationPO.getAssignQuestionnaireButton(), waitShort);
    }

    public void selectAssignedToApprover(String approverName) {
        clearAndInputField(activityInformationPO.getAssignedToDropdownInput(), approverName);
        clickOn(waitLong.until(
                visibilityOfElementLocated(xpath(format(activityInformationPO.getAssignedToDropdownItem(),
                                                        approverName)))));
    }

    public void clickActionButton(String approverName, String buttonName) {
        clickOn((xpath(format(activityInformationPO.getActionButton(), approverName, buttonName))), waitShort);
    }

    public void clickQuestionnaireActionsButton(String activityName) {
        if (isElementDisplayed(waitShort,
                               xpath(format(activityInformationPO.getQuestionnaireActionsButtonOfActivityWithName(),
                                            activityName)))) {
            clickOn(xpath(
                    format(activityInformationPO.getQuestionnaireActionsButtonOfActivityWithName(), activityName)));
        }
    }

    public void clickQuestionnaireActionsButtonWithName(String activityName, String buttonName) {
        clickQuestionnaireActionsButton(activityName);
        clickOn(xpath(format(activityInformationPO.getQuestionnaireActionsButtonWithName(), buttonName)), waitShort);
    }

    public List<String> getQuestionnaireActionsButtons(String questionnaireName) {
        clickOn(xpath(
                format(activityInformationPO.getQuestionnaireActionsButtonOfActivityWithName(), questionnaireName)));
        return getElementsText(waitMoment.until(
                visibilityOfAllElementsLocatedBy(activityInformationPO.getQuestionnaireActionsButtons())));
    }

    public void clickQuestionnaireButtonWithNameForActivity(String activityName, String buttonName) {
        scrollIntoView(waitShort.until(
                visibilityOfElementLocated(xpath(activityInformationPO.getQuestionnaireDetailsSection()))));
        clickOn(xpath(format(activityInformationPO.getQuestionnaireButtonOfActivityWithName(), activityName,
                             buttonName)), waitShort);
    }

    public void clickQuestionnaireStateButton(String questionnaireName, String linkName) {
        clickOn(xpath(format(activityInformationPO.getQuestionnaireStateLink(), questionnaireName, linkName)),
                waitLong);
    }

    public void fillStatusDropDown(String status) {
        clearAndFillInValueAndSelectFromDropDown(status, activityInformationPO.getStatusInput());
    }

    public void fillAssessmentDropDownWithAnyValueIfItExists() {
        clickOn(activityInformationPO.getAssessmentInput());
        if (isElementDisplayed(waitMoment, activityInformationPO.getDropDownFirstOption())) {
            clickOn(activityInformationPO.getDropDownFirstOption());
        }
    }

    public void fillAssessmentDropDown(String assessment) {
        clearAndFillInValueAndSelectFromDropDown(assessment, activityInformationPO.getAssessmentInput(),
                                                 activityInformationPO.getDropDownOption());
    }

    public void clickSaveActivityButton() {
        clickOn(activityInformationPO.getSaveActivityButton(), waitShort);
    }

    public void clickCancelActivityButton() {
        clickOn(activityInformationPO.getCancelButton());
    }

    public void clickOnButtonWithName(String buttonName) {
        clickOn(waitLong.until(elementToBeClickable(
                xpath(format(activityInformationPO.getActivityButtonWithName(), buttonName)))));
    }

    public void fillAssigneeDropDown(String assignee) {
        clearAndFillInValueAndSelectFromDropDown(assignee,
                                                 activityInformationPO.getAssigneeInput(),
                                                 activityInformationPO.getDropDownOption());
    }

    public void approveAllActivities() {
        List<WebElement> approveButtons = getElements(activityInformationPO.getApproveButton());
        if (!approveButtons.isEmpty()) {
            IntStream.rangeClosed(0, approveButtons.size() - 1)
                    .forEach(i -> waitShort
                            .ignoring(StaleElementReferenceException.class)
                            .ignoring(TimeoutException.class)
                            .until(driver -> {
                                clickOn(getElements(activityInformationPO.getApproveButton()).get(i), waitMoment);
                                return true;
                            }));
        } else {
            throw new IllegalArgumentException("There is a wrong locator or approve button is not found on page");
        }
    }

    public void reviewAllActivities() {
        waitShort.ignoring(StaleElementReferenceException.class)
                .until(visibilityOfAllElementsLocatedBy(activityInformationPO.getAllReviewButtons()))
                .forEach(button -> clickOn(button, waitShort));
    }

    public void clickReviewQuestionnaire() {
        clickOn(activityInformationPO.getReviewButton(), waitShort);
    }

    public void clickReviewActionButton(String userName, String buttonName) {
        waitWhilePreloadProgressbarIsDisappeared();
        userName = getDisplayedUserName(userName);
        scrollIntoView(activityInformationPO.getReviewersSectionTitle());
        clickOn(xpath(format(activityInformationPO.getReviewActionButton(), userName, buttonName)), waitShort);
    }

    public boolean isReviewIconDisplayed(String assignedTo, String icon) {
        waitWhilePreloadProgressbarIsDisappeared();
        scrollIntoView(activityInformationPO.getReviewersSectionTitle());
        if (EDIT.equals(icon)) {
            return isElementDisplayed(waitShort,
                                      xpath(format(activityInformationPO.getReviewEditButton(), assignedTo)));
        } else {
            return isElementDisplayed(waitShort,
                                      xpath(format(activityInformationPO.getReviewDeleteButton(), assignedTo)));
        }
    }

    public void clickReviewEditButton(String userName) {
        userName = getDisplayedUserName(userName);
        waitWhilePreloadProgressbarIsDisappeared();
        scrollIntoView(activityInformationPO.getReviewersSectionTitle());
        clickOn(xpath(format(activityInformationPO.getReviewEditButton(), userName)), waitShort);
    }

    public void clickReviewDeleteButton(String userName) {
        userName = getDisplayedUserName(userName);
        waitWhilePreloadProgressbarIsDisappeared();
        scrollIntoView(activityInformationPO.getReviewersSectionTitle());
        clickOn(xpath(format(activityInformationPO.getReviewDeleteButton(), userName)), waitShort);
    }

    public String getReviewerDeleteButtonColor(String userName) {
        return getCssValue(xpath(format(activityInformationPO.getReviewDeleteButton(), userName)), COLOR);
    }

    public void clickApproverActionButtonForUser(String userName, String buttonName) {
        buttonName = getFromDictionaryIfExists(buttonName);
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        scrollIntoView(getElementByXPath(activityInformationPO.getApproversSectionTitle()));
        By approverActionButton = xpath(format(activityInformationPO.getApproverActionButton(), userName, buttonName));
        waitShort.ignoring(StaleElementReferenceException.class)
                .until(visibilityOfElementLocated(approverActionButton));
        clickOn(approverActionButton, waitShort);
    }

    public void clickReviewAdHocActionButton(String userName, String buttonName) {
        scrollIntoView(driver.findElement(activityInformationPO.getAdHocReviewersSection()));
        clickOn(xpath(format(activityInformationPO.getReviewActionAdHocButton(), userName, buttonName)), waitShort);
    }

    public void selectAssignedReviewerUser(String userName) {
        clickOn(activityInformationPO.getReviewAssignUserInput(), waitMoment);
        fillInValueAndSelectFromDropDown(userName, activityInformationPO.getReviewAssignUserInput(),
                                         xpath(format(activityInformationPO.getDropDownOption(), userName)));
    }

    public void clickAssignNewQuestionnaireButton() {
        clickOn(driver.findElement(activityInformationPO.getAssignNewButton()));
    }

    public void clickReviewTaskActionButton(int rowNo) {
        clickOn(xpath(format(activityInformationPO.getReviewTaskActionButton(), rowNo)), waitLong);
    }

    public void clickReviewTaskActionTypeButton(String actionType) {
        clickOn(xpath(format(activityInformationPO.getReviewTaskActionTypeButton(), actionType)), waitMoment);
    }

    public void clickRevertToReviewButton() {
        clickOn(getElement(activityInformationPO.getQuestionnaireActionsRevertToInReviewButton()));
    }

    public void clickStatusInput() {
        clickOn(activityInformationPO.getStatusInputButton(), waitShort);
    }

    public boolean isCreateOrderBtnEnabled() {
        return isElementEnabled(
                waitLong.until(visibilityOfElementLocated(activityInformationPO.getCreateOrderButton())));
    }

    public boolean isCreateOrderBtnDisplayed() {
        waitWhilePreloadProgressbarIsDisappeared();
        return isElementDisplayed(activityInformationPO.getCreateOrderButton());
    }

    public boolean isDeclineOrderBtnDisplayed() {
        waitShort.until(visibilityOfElementLocated(activityInformationPO.getDeclineButton()));
        return isElementDisplayed(activityInformationPO.getDeclineButton());
    }

    public boolean isDecliningConfirmationPopUpDisplayed() {
        waitShort.until(visibilityOfElementLocated(activityInformationPO.getDeclineConfirmationPopUp()));
        return isElementDisplayed(activityInformationPO.getDeclineConfirmationPopUp());
    }

    public boolean isDecliningWarningMsgDisplayed() {
        return isElementDisplayed(activityInformationPO.getDecliningWarningMsg());
    }

    public boolean isConfirmationPopUpCancelBtnDisplayed() {
        return isElementDisplayed(activityInformationPO.getDeclineConfirmationPopUpCancelBtn());
    }

    public boolean isDecliningProceedBtnDisplayed() {
        return isElementDisplayed(activityInformationPO.getDeclineConfirmationPopUpProceedBtn());
    }

    public boolean isActivityInformationPageDisplayed() {
        return isElementDisplayed(waitLong, activityInformationPO.getActivityInformationPage());
    }

    public boolean isActivityInformationModalDisappeared() {
        return isElementDisappeared(waitMoment, activityInformationPO.getActivityInformationPage());
    }

    public boolean isAssigneeEditable() {
        clickOn(activityInformationPO.getAssigneeInput());
        return isElementDisplayed(activityInformationPO.getAssigneeList());
    }

    public boolean isSaveActivityButtonVisible() {
        return isElementDisplayed(waitShort, activityInformationPO.getSaveActivityButton());
    }

    public boolean isSaveActivityButtonInvisible() {
        return isElementInvisible(waitMoment, activityInformationPO.getSaveActivityButton());
    }

    public boolean isCancelActivityButtonInvisible() {
        return isElementInvisible(waitMoment, activityInformationPO.getCancelButton());
    }

    public boolean isCancelActivityButtonVisible() {
        return isElementDisplayed(waitShort, activityInformationPO.getCancelButton());
    }

    public boolean isEditActivityButtonVisible() {
        return isElementDisplayed(waitLong, activityInformationPO.getEditButton());
    }

    public boolean isEditActivityButtonHidden() {
        return isElementInvisible(waitMoment, activityInformationPO.getEditButton());
    }

    public boolean isReviewersSectionDisplayed() {
        return isElementDisplayed(activityInformationPO.getReviewersSectionTitle());
    }

    public boolean isStatusFieldEnabled() {
        return isElementEnabled(activityInformationPO.getStatusInput());
    }

    public boolean isAssessmentFieldEnabled() {
        return isElementEnabled(activityInformationPO.getAssessmentInput());
    }

    public boolean isReviewTaskReviewButtonDisplayed(int rowNo) {
        return isElementDisplayed(xpath(format(activityInformationPO.getReviewTaskReviewButton(), rowNo)));
    }

    public boolean isAssignNewQuestionnaireButtonDisplayed() {
        return isElementDisplayed(activityInformationPO.getAssignNewButton());
    }

    public boolean isSectionExpanded(String sectionName) {
        return getAttributeValueWithWait(waitShort,
                                         xpath(format(activityInformationPO.getSectionHeader(), sectionName)), CLASS)
                .contains(MUI_EXPANDED);
    }

    public boolean isApproverActionButtonDisabled(String approverName, String buttonName) {
        return getAttributeValue(waitShort,
                                 xpath(format(activityInformationPO.getActionButton(), approverName, buttonName)),
                                 CLASS)
                .contains(DISABLED);
    }

    public boolean isActivityInformationURLMatches() {
        return Pattern.matches(format(ACTIVITY_INFORMATION_PATH_REGEX, BaseApi.URL), driver.getCurrentUrl());
    }

    public boolean isActivityFieldDisabled(String fieldName) {
        return isElementAttributeContains(xpath(format(activityInformationPO.getField(), fieldName)), CLASS, DISABLED);
    }

    public boolean isReviewTaskSectionExpanded() {
        return getAttributeValueWithWait(waitShort, xpath(activityInformationPO.getReviewTaskSection()), CLASS)
                .contains(MUI_EXPANDED);
    }

    public boolean isQuestionnaireButtonWithNameDisplayed(String activityName, String buttonName) {
        return isElementDisplayed(xpath(format(activityInformationPO.getQuestionnaireButtonOfActivityWithName(),
                                               activityName, buttonName)));
    }

    public boolean isPageWithNameDisplayed(String pageName) {
        return isElementDisplayed(xpath(format(activityInformationPO.getPageWithName(), pageName.toLowerCase())));
    }

    public boolean isStrongHeaderTextDisplayed(String expectedText) {
        return isElementDisplayed(xpath(format(activityInformationPO.getHeaderStrongText(), expectedText)));
    }

    public boolean isHeaderTextWithStyleDisplayed(String expectedText, String expectedStyle) {
        return isElementDisplayed(
                xpath(format(activityInformationPO.getHeaderTextWithStyle(), expectedText, expectedStyle)));
    }

    public boolean isInvalidLabelDisplayedForUser(String userName) {
        return isElementPresent(xpath(format(activityInformationPO.getInvalidLabel(), userName)));
    }

    public String getActivityInformationFieldTextByName(String fieldName) {
        By fieldLocator = xpath(format(activityInformationPO.getActivityInformationFieldValue(), fieldName));
        return isElementDisplayed(waitMoment, fieldLocator) ? getAttributeValue(fieldLocator, VALUE) : null;
    }

    public ActivityInformationData getAllFieldsValues() {
        waitShort.until(attributeToBeNotEmpty(waitLong.until(visibilityOfElementLocated(
                xpath(format(activityInformationPO.getActivityInformationFieldValue(),
                             translator.getValue("ddoActivity.activityType"))))), VALUE));
        return ActivityInformationData.builder()
                .activityType(getActivityInformationFieldTextByName(translator.getValue("ddoActivity.activityType")))
                .activityName(getActivityInformationFieldTextByName(translator.getValue("ddoActivity.activityName")))
                .description(getActivityInformationFieldTextByName(translator.getValue("ddoActivity.description")))
                .riskArea(getActivityInformationFieldTextByName(translator.getValue("ddoActivity.riskArea")))
                .orderDetails(getOrderDetailsButtonText())
                .startDate(getActivityInformationFieldTextByName(translator.getValue("ddoActivity.startDate")))
                .dueDate(getActivityInformationFieldTextByName(translator.getValue("ddoActivity.dueDate")))
                .lastUpdate(getActivityInformationFieldTextByName(translator.getValue("ddoActivity.lastUpdate")))
                .priority(getActivityInformationFieldTextByName(ActivityInformationDisplayPage.PRIORITY))
                .assignee(getActivityInformationFieldTextByName(translator.getValue("ddoActivity.assignee")))
                .initiatedBy(getActivityInformationFieldTextByName(translator.getValue("ddoActivity.initiatedBy")))
                .status(getActivityInformationFieldTextByName(translator.getValue("ddoActivity.status")))
                .assessment(getActivityInformationFieldTextByName(translator.getValue("ddoActivity.assessment")))
                .build();
    }

    public String getReviewTaskStatus(int rowNo) {
        return getElementText(xpath(format(activityInformationPO.getReviewTaskStatus(), rowNo)));
    }

    public List<ActivityInformationData.Approver> getApproversTableData() {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        By byRows = activityInformationPO.getApproversTableRow();
        return IntStream.range(0,
                               waitShort.until(visibilityOfAllElementsLocatedBy(byRows)).size()).mapToObj(rowIndex -> {
            String approver = getElementText(waitShort, () -> getElements(byRows).get(rowIndex),
                                             xpath(activityInformationPO.getAssignedToColumnValue()));
            String actions = getElementText(waitMoment, () -> getElements(byRows).get(rowIndex),
                                            xpath(activityInformationPO.getActionColumn()));
            return new ActivityInformationData.Approver()
                    .setAssignedTo(
                            (isNull(approver) || approver.contains(REQUIRED_INDICATOR)) ? null :
                                    approver)
                    .setLastUpdate(
                            getElementText(waitMoment, () -> getElements(byRows).get(rowIndex),
                                           xpath(activityInformationPO.getLastUpdateColumnValue())))
                    .setAction(nonNull(actions) ? actions.lines().collect(joining(COMMA)) : null)
                    .setStatus(
                            getElementText(waitMoment, () -> getElements(byRows).get(rowIndex),
                                           xpath(activityInformationPO.getStatusColumn())));
        }).collect(Collectors.toList());
    }

    public List<ActivityInformationData.ActivityQuestionnaireDetails> getQuestionnaireDetailsTableData(
            boolean isWithFullDetails) {
        waitLong.until(visibilityOfElementLocated(activityInformationPO.getActivityInformationPage()));
        waitShort.until(numberOfElementsToBeMoreThan(activityInformationPO.getQuestionnaireDetailsTableRows(), 0));
        return getElements(activityInformationPO.getQuestionnaireDetailsTableRows())
                .stream().map(row -> new ActivityInformationData.ActivityQuestionnaireDetails()
                        .setQuestionnaireName(getQuestionnaireDetailsRowValue(row, QUESTIONNAIRE_NAME_TD_NUMBER))
                        .setStatus(getQuestionnaireDetailsRowValue(row, QUESTIONNAIRE_STATUS_TD_NUMBER))
                        .setAssignee(isWithFullDetails ?
                                             getQuestionnaireDetailsRowValue(row, QUESTIONNAIRE_ASSIGNEE_TD_NUMBER) :
                                             null)
                        .setScore(isWithFullDetails ?
                                          getQuestionnaireDetailsRowValue(row, QUESTIONNAIRE_SCORE_TD_NUMBER) :
                                          null)
                        .setOverallAssessment(isWithFullDetails ?
                                                      getQuestionnaireDetailsRowValue(row,
                                                                                      QUESTIONNAIRE_OVERALL_ASSESSMENT_TD_NUMBER) :
                                                      null)
                        .setReviewer(isWithFullDetails ?
                                             getQuestionnaireDetailsRowValue(row, QUESTIONNAIRE_REVIEWER_TD_NUMBER) :
                                             null)
                        .setButton(isWithFullDetails ?
                                           getQuestionnaireDetailsRowValue(row, QUESTIONNAIRE_BUTTON) :
                                           null))
                .collect(toList());
    }

    public List<ActivityInformationData.Approver> getReviewersTableData() {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        return rangeClosed(1, getElements(activityInformationPO.getReviewersTableRows()).size())
                .mapToObj(
                        i -> {
                            String reviewer = getElementText(waitShort,
                                                             xpath(format(
                                                                     activityInformationPO.getReviewersTableRowValue(),
                                                                     i, 1)));

                            return new ActivityInformationData.Approver()
                                    .setAssignedTo(reviewer.contains(REQUIRED_INDICATOR) ? null : reviewer)
                                    .setLastUpdate(getElementText(waitShort,
                                                                  xpath(format(
                                                                          activityInformationPO
                                                                                  .getReviewersTableRowValue(),
                                                                          i, 2))))
                                    .setAction(getAction(i))
                                    .setStatus(getElementText(waitShort,
                                                              xpath(format(
                                                                      activityInformationPO.getReviewersTableRowValue(),
                                                                      i, 4))));
                        }
                )
                .collect(toList());
    }

    private String getAction(int i) {
        String actions = getElementText(
                driver.findElement(xpath(format(activityInformationPO.getReviewersTableRowValue(), i, 3))));
        return isNull(actions) ? null : emptyToNull(join(COMMA, actions.split(ROW_DELIMITER)));
    }

    public String getOrderDetailsButtonText() {
        return isElementDisplayed(waitMoment, activityInformationPO.getOrderDetailsBtn()) ?
                getElementText(activityInformationPO.getOrderDetailsBtn()) :
                null;
    }

    private String getQuestionnaireDetailsRowValue(WebElement row, int column) {
        return getElementText(waitMoment.ignoring(StaleElementReferenceException.class)
                                      .until(presenceOfNestedElementLocatedBy(row, xpath(format(
                                              activityInformationPO.getQuestionnaireColumnValue(), column)))));
    }

    public String getFieldMessage(String fieldName) {
        return getElementText(xpath(format(activityInformationPO.getFieldMessage(), fieldName)));
    }

    private List<ActivityQuestionnaireDetailsDTO> getAllQuestionnaires() {
        List<ActivityQuestionnaireDetailsDTO> questionnaireList = new ArrayList<>();
        waitLong.until(numberOfElementsToBeMoreThan(activityInformationPO.getQuestionnaireDetailsTableRows(), 0));
        List<WebElement> rows = getElements(activityInformationPO.getQuestionnaireDetailsTableRows());
        for (WebElement row : rows) {
            questionnaireList
                    .add(new ActivityQuestionnaireDetailsDTO()
                                 .setRow(row)
                                 .setQuestionnaireName(
                                         getChildElement(row, activityInformationPO.getQuestionnaireDetailsName()))
                                 .setStatus(getChildElement(row, activityInformationPO.getQuestionnaireDetailsStatus()))
                                 .setState(getChildElement(row, activityInformationPO.getQuestionnaireState())));
        }
        return questionnaireList;
    }

    private List<ActivityInformationData.QuestionnaireDetails> getQuestionnaireDetailsList() {
        List<ActivityInformationData.QuestionnaireDetails> questionnaireList = new ArrayList<>();
        waitShort.until(numberOfElementsToBeMoreThan(activityInformationPO.getQuestionnaireDetailsTableRows(), 0));
        List<WebElement> rows = getElements(activityInformationPO.getQuestionnaireDetailsTableRows());
        for (WebElement row : rows) {
            questionnaireList
                    .add(new ActivityInformationData.QuestionnaireDetails()
                                 .setName(row.findElement(activityInformationPO.getQuestionnaireDetailsName()))
                                 .setStatus(row.findElement(activityInformationPO.getQuestionnaireDetailsStatus()))
                                 .setAssignee(row.findElement(activityInformationPO.getQuestionnaireDetailsAssignee()))
                                 .setReviewer(row.findElement(activityInformationPO.getQuestionnaireDetailsReviewer()))
                                 .setReviewerAssessment(row.findElement(
                                         activityInformationPO.getQuestionnaireDetailsReviewerAssessment()))
                                 .setScore(row.findElement(activityInformationPO.getQuestionnaireDetailsScore()))
                                 .setScoreCategory(
                                         row.findElement(activityInformationPO.getQuestionnaireDetailsCategory()))
                                 .setActions(row.findElement(activityInformationPO.getQuestionnaireDetailsActions())));
        }
        return questionnaireList;
    }

    public List<ActivityInformationData.ReviewTask> getReviewTaskTable() {
        waitShort.until(invisibilityOfElementWithText(activityInformationPO.getReviewTaskTableFirstRowName(),
                                                      StringUtils.EMPTY));
        List<String> columnNames = getElementsText(activityInformationPO.getReviewTaskTableColumns());
        List<WebElement> tableRows =
                waitShort.until(numberOfElementsToBeMoreThan(activityInformationPO.getReviewTaskTableRows(), 0));
        List<ActivityInformationData.ReviewTask> list = new ArrayList<>();
        for (WebElement result : tableRows) {
            ActivityInformationData.ReviewTask reviewTask = new ActivityInformationData.ReviewTask()
                    .setName(getRowText(result, NAME.toUpperCase(), columnNames))
                    .setReferenceId(getRowText(result, REFERENCE_ID.toUpperCase(), columnNames))
                    .setReviewer(getRowText(result, REVIEWER.toUpperCase(), columnNames))
                    .setReviewStatus(getRowText(result, REVIEW_STATUS.toUpperCase(), columnNames))
                    .setDueDate(getRowText(result, DUE_DATE.toUpperCase(), columnNames))
                    .setType(getRowText(result, TYPE.toUpperCase(), columnNames))
                    .setButtonName(getReviewButtonName(tableRows.indexOf(result) + 1));
            list.add(reviewTask);
        }
        return list;
    }

    private String getReviewButtonName(int rowNo) {
        return getElementText(xpath(format(activityInformationPO.getReviewTaskActionButton(), rowNo)));
    }

    private String getRowText(WebElement row, String columnName, List<String> columnNames) {
        int columnNameIndex = columnNames.indexOf(columnName) + 1;
        return columnNameIndex == 0 ? null :
                getElementText(
                        row.findElement(xpath(format(activityInformationPO.getTableRowValue(), columnNameIndex))));
    }

    public String getActivityAssigneeValue() {
        return getAttributeValue(activityInformationPO.getAssigneeInput(), VALUE);
    }

    public ActivityInformationData.QuestionnaireDetails getQuestionnaireDetailObject(String questionnaireName) {
        return getQuestionnaireDetailsList().stream()
                .filter(element -> element.getName().getText().contains(questionnaireName))
                .findFirst()
                .orElse(null);
    }

    public List<String> getApproversTableColumns() {
        return getElementsText(driver.findElements(activityInformationPO.getApproversTableColumns()));
    }

    public List<String> getAssignToDropDownValues() {
        clickOn(activityInformationPO.getReviewAssignUserInput());
        return getDropDownOptions(activityInformationPO.getReviewAssigneeDropDownItems()).stream()
                .map(option -> option.replace(ROW_DELIMITER, " (") + ")").collect(
                        toList());
    }

    public ActivityQuestionnaireDetailsDTO getQuestionnaire(String questionnaireName) {
        return getAllQuestionnaires().stream()
                .filter(element -> {
                    waitShort.ignoring(StaleElementReferenceException.class)
                            .until(visibilityOf(element.getQuestionnaireName()));
                    return element.getQuestionnaireName().getText().contains(questionnaireName);
                })
                .findFirst()
                .orElseThrow(
                        () -> new RuntimeException("Questionnaire with name '" + questionnaireName + "' wasn't found"));
    }

    public List<String> getStatusDropDownOptions() {
        return getDropDownOptions(activityInformationPO.getDropDownOptions());
    }

    public List<String> getAssigneeDropDownList() {
        clickOn(activityInformationPO.getAssigneeInput());
        return getDropDownOptions(activityInformationPO.getDropDownOptions());
    }

    public List<String> getApproversDropDownList() {
        clickOn(activityInformationPO.getAssignedToDropdownInput(), waitShort);
        waitShort.until(numberOfElementsToBeMoreThan(activityInformationPO.getDropDownOptions(), 1));
        List<String> listOfValues = getDropDownOptions(activityInformationPO.getDropDownOptions());
        clickOn(activityInformationPO.getAssignedToDropdownInput());
        return listOfValues;
    }

    public List<String> getAssessmentDropDownList() {
        clickOn(activityInformationPO.getAssessmentInputOpenButton(), waitShort);
        waitShort.until(numberOfElementsToBeMoreThan(activityInformationPO.getDropDownOptions(), 0));
        List<String> listOfValues = getDropDownOptions(activityInformationPO.getDropDownOptions());
        clickOn(activityInformationPO.getAssessmentInputOpenButton());
        return listOfValues;
    }

    public List<String> getUserActionButtons(String userName) {
        userName = getDisplayedUserName(userName);
        return getElementsText(xpath(format(activityInformationPO.getActionButtons(), userName)));
    }

    private String getDisplayedUserName(String userName) {
        return userName.length() >= MAX_VISIBLE_LENGTH ? userName.substring(0, MAX_VISIBLE_LENGTH) + ELLIPSIS :
                userName;
    }

    public String getActivityIdFromUrl() {
        String open = "activity/";
        String close = "/view";
        String currentUrl = driver.getCurrentUrl();
        return currentUrl.contains(close) ? substringBetween(currentUrl, open, close) :
                substringAfter(currentUrl, open);
    }

    public boolean isQuestionnaireDetailsTableEmpty() {
        return isElementDisplayed(activityInformationPO.getNoAvailableDataTitle());
    }

}