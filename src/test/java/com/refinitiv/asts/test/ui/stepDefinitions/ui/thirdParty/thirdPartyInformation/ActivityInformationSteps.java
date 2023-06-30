package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.SIPublicApi;
import com.refinitiv.asts.test.ui.api.WorkflowApi;
import com.refinitiv.asts.test.ui.api.model.valueManagement.RefDataResponse;
import com.refinitiv.asts.test.ui.api.model.valueManagement.Value;
import com.refinitiv.asts.test.ui.constants.APIConstants;
import com.refinitiv.asts.test.ui.constants.ContextConstants;
import com.refinitiv.asts.test.ui.enums.ActivityAttachmentFields;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ActivityInformationAttachmentPage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ActivityInformationCommentPage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ActivityInformationDisplayPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.GenericTestData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.GroupData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionnaireData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.ActivityInformationAttachmentData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.ActivityInformationData;
import com.refinitiv.asts.test.ui.utils.data.ui.ActivityInformationAttachmentDTO;
import com.refinitiv.asts.test.ui.utils.data.ui.ActivityInformationCommentDTO;
import com.refinitiv.asts.test.ui.utils.data.ui.CommentDTO;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.assertj.core.api.SoftAssertions;
import org.junit.Assert;
import org.testng.asserts.SoftAssert;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.api.ConnectApi.*;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.COMMENT_DATE;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.Pages.THIRD_PARTY;
import static com.refinitiv.asts.test.ui.constants.Pages.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.ActivityAttachmentFields.FILE_NAME;
import static com.refinitiv.asts.test.ui.enums.ActivityAttachmentFields.UPLOAD_DATE;
import static com.refinitiv.asts.test.ui.enums.Colors.DELETE_EDIT_BUTTON_GREY;
import static com.refinitiv.asts.test.ui.enums.ValueTypeName.ACTIVITY_TYPE;
import static com.refinitiv.asts.test.ui.pageActions.BasePage.URL;
import static com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ActivityInformationDisplayPage.*;
import static com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.thirdPartyInformation.ScreeningSteps.ELLIPSIS;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static com.refinitiv.asts.test.utils.FileUtil.getFilePath;
import static java.lang.Integer.parseInt;
import static java.lang.String.format;
import static java.util.Arrays.stream;
import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang.RandomStringUtils.randomAscii;
import static org.apache.commons.lang3.StringUtils.*;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.*;

public class ActivityInformationSteps extends BaseSteps {

    private static final String SYSTEM_NOTICE = "System Notice";
    private static final String SEE_MORE_LINK = "\n[See more]";
    private final ActivityInformationDisplayPage activityInformationPage;
    private final ActivityInformationCommentPage activityInformationCommentPage;
    private final ActivityInformationAttachmentPage activityInformationAttachmentPage;
    private final List<CommentDTO> commentsData = new ArrayList<>();
    private String initialCommentDate;
    private UserData commentAuthor;

    public ActivityInformationSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.activityInformationPage = new ActivityInformationDisplayPage(driver, context, translator);
        this.activityInformationCommentPage = new ActivityInformationCommentPage(driver, context);
        this.activityInformationAttachmentPage = new ActivityInformationAttachmentPage(driver, context);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public ActivityInformationAttachmentData attachmentEntry(Map<String, String> entry) {
        return ActivityInformationAttachmentData.builder()
                .fileName(entry.get(FILE_NAME.getName()))
                .description(entry.get(ActivityAttachmentFields.DESCRIPTION.getName()))
                .uploadDate(entry.get(UPLOAD_DATE.getName()))
                .build();
    }

    @DataTableType
    @SuppressWarnings("unused")
    public ActivityInformationData activityEntry(Map<String, String> entry) {
        return ActivityInformationData.builder()
                .activityType(entry.get(ActivityInformationDisplayPage.ACTIVITY_TYPE))
                .activityName(entry.get(ACTIVITY_NAME))
                .description(entry.get(ActivityInformationDisplayPage.DESCRIPTION))
                .riskArea(entry.get(RISK_AREA))
                .orderDetails(entry.get(ORDER_DETAILS))
                .startDate(entry.get(START_DATE))
                .dueDate(entry.get(DUE_DATE))
                .lastUpdate(entry.get(LAST_UPDATE))
                .priority(entry.get(PRIORITY))
                .assessment(entry.get(ASSESSMENT))
                .assignee(entry.get(ASSIGNEE))
                .initiatedBy(entry.get(INITIATED_BY))
                .status(entry.get(STATUS))
                .build();
    }

    @DataTableType
    @SuppressWarnings("unused")
    public ActivityInformationData.ActivityQuestionnaireDetails questionnaireDetailsEntry(Map<String, String> entry) {
        return new ActivityInformationData.ActivityQuestionnaireDetails()
                .setQuestionnaireName(getQuestionnaireName(entry.get(QUESTIONNAIRE_NAME)))
                .setStatus(entry.get(STATUS))
                .setAssignee(entry.get(ASSIGNEE))
                .setReviewer(getReviewer(entry.get(REVIEWER)))
                .setOverallAssessment(entry.get(OVERALL_ASSESSMENT))
                .setScore(entry.get(SCORE))
                .setButton(entry.get(BUTTON));
    }

    @DataTableType
    @SuppressWarnings("unused")
    public ActivityInformationData.Approver approverEntry(Map<String, String> entry) {
        return new ActivityInformationData.Approver(
                entry.get(ASSIGNED_TO),
                entry.get(LAST_UPDATE),
                entry.get(ACTION),
                entry.get(STATUS)
        );
    }

    @DataTableType
    @SuppressWarnings("unused")
    public ActivityInformationData.ReviewTask reviewTaskEntry(Map<String, String> entry) {
        return new ActivityInformationData.ReviewTask()
                .setName(nonNull(entry.get(ActivityInformationDisplayPage.NAME)) ? (String) context.getScenarioContext()
                        .getContext(entry.get(ActivityInformationDisplayPage.NAME)) : null)
                .setReferenceId(nonNull(entry.get(ActivityInformationDisplayPage.REFERENCE_ID)) ?
                                        (String) context.getScenarioContext()
                                                .getContext(entry.get(ActivityInformationDisplayPage.REFERENCE_ID)) :
                                        null)
                .setReviewer(entry.get(REVIEWER))
                .setReviewStatus(entry.get(REVIEW_STATUS))
                .setDueDate(nonNull(entry.get(DUE_DATE)) ?
                                    getDateAfterTodayDate(REACT_FORMAT,
                                                          parseInt(entry.get(DUE_DATE)
                                                                           .replace(TODAY, StringUtils.EMPTY))) :
                                    null)
                .setType(entry.get(ActivityInformationDisplayPage.TYPE))
                .setButtonName(entry.get(BUTTON_NAME));
    }

    private List<ActivityInformationData.Approver> updateDate(List<ActivityInformationData.Approver> rows) {
        rows.forEach(row -> {
            if (nonNull(row.getLastUpdate()) && row.getLastUpdate().equals(VALUE_TO_REPLACE)) {
                row.setLastUpdate(getTodayDate(SI_UI_DATE_FORMAT));
            }
        });
        return rows;
    }

    public void validateCommentData(UserData userTestData, String expectedCommentText, String commentDate) {
        SoftAssertions softAssert = new SoftAssertions();
        ActivityInformationCommentDTO actualComment =
                activityInformationCommentPage.getActivityComment(expectedCommentText);
        softAssert.assertThat(actualComment.getAuthor().getText()).as("Author name is unexpected")
                .isEqualTo(userTestData.getFirstName() + SPACE + userTestData.getLastName());
        softAssert.assertThat(actualComment.getDate().getText()).as("Comment date is unexpected")
                .isEqualTo(commentDate.replaceAll(PM, P_M_).replace(AM, A_M_));
        softAssert.assertThat(actualComment.getComment().getText()).as("Comment text is unexpected")
                .isEqualTo(expectedCommentText);
        softAssert.assertAll();
    }

    private String getQuestionnaireName(String name) {
        if (QUESTIONNAIRE_NAME_CONTEXT.equals(name)) {
            return (String) context.getScenarioContext().getContext(QUESTIONNAIRE_NAME_CONTEXT);
        }
        return name;
    }

    private String getReviewer(String reviewer) {
        if (VALUE_TO_REPLACE.equals(reviewer)) {
            GroupData data = (GroupData) this.context.getScenarioContext().getContext(GROUP_TEST_DATA_CONTEXT);
            reviewer = data.getGroupName();
        } else if (nonNull(reviewer) && context.getScenarioContext().isContains(reviewer)) {
            UserData userData = (UserData) this.context.getScenarioContext().getContext(reviewer);
            reviewer = userData.getFirstName() + SPACE + userData.getLastName();
        }
        return reviewer;
    }

    @When("User opens previously created Activity")
    public void openCreatedActivity() {
        activityInformationPage.openCreatedActivity();
    }

    @When("User clicks on Activity Information Page for Questionnaire Details on 'Revert to in Review' button")
    public void clickRevertToReviewButton() {
        activityInformationPage.clickRevertToReviewButton();
    }

    @When("Users clicks {string} column header on Activity attachment table")
    public void clickColumnHeader(String columnName) {
        activityInformationAttachmentPage.clickHeaderColumn(columnName);
    }

    @When("User clicks delete icon for attachment {string}")
    public void deleteAttachmentOnActivityInformationPage(String attachment) {
        activityInformationAttachmentPage.clickDeleteAttachmentIcon(attachment);
    }

    @When("User on Activity information page adds comment {string}")
    public void activityInformationCommentBlockAddComment(String comment) {
        activityInformationCommentPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        initialCommentDate = getCurrentCommentDateTime(ACTIVITY_COMMENT_DATE_FORMAT);
        commentAuthor = (UserData) context.getScenarioContext().getContext(USER_DATA);
        activityInformationCommentPage.addCommentText(ACTIVITY_COMMENT_TEXT, comment);
        clickCommentSectionButton(COMMENT);
    }

    @When("User on Activity information page adds {int} comment {string}")
    public void addActivityInformationComments(int commentsCount, String comment) {
        for (int i = 1; i <= commentsCount; i++) {
            String expectedComment = comment + i;
            initialCommentDate =
                    getCurrentCommentDateTime(ACTIVITY_COMMENT_DATE_FORMAT).replace(AM, A_M_).replace(PM, P_M_);
            commentAuthor = (UserData) context.getScenarioContext().getContext(USER_DATA);
            activityInformationCommentPage.addCommentText(ACTIVITY_COMMENT_TEXT, comment + i);
            clickCommentSectionButton(COMMENT);
            commentsData.add(new CommentDTO()
                                     .setCommentText(expectedComment)
                                     .setDate(initialCommentDate)
                                     .setAuthor(commentAuthor.getFirstName() + SPACE + commentAuthor.getLastName()));
        }
    }

    @When("User selects activity status {string}")
    public void selectActivityStatus(String status) {
        activityInformationPage.fillStatusDropDown(status);
    }

    @When("User on Activity information page deletes comment {string}")
    public void deleteCommentOnActivityInformationPage(String comment) {
        activityInformationCommentPage.clickOnCommentDeleteButton(comment);
    }

    @When("User clicks Activity Information comment button {string}")
    public void clickCommentButton(String button) {
        activityInformationCommentPage.clickCommentButton(button);
    }

    @When("User clicks Activity Information comment section button {string}")
    public void clickCommentSectionButton(String button) {
        if (button.equals(CANCEL)) {
            int expectedCommentsSize = commentsData.size();
            if (expectedCommentsSize > 0) {
                commentsData.remove(expectedCommentsSize - 1);
            }
        }
        activityInformationCommentPage.clickActionButton(button);
    }

    @When("User clicks on Activity information page Edit comment button {string}")
    public void clickEditCommentOnActivityInformationPage(String comment) {
        activityInformationCommentPage.clickOnCommentEditButton(comment);
    }

    @When("User on Activity information page fills in comment text {string}")
    public void editCommentOnActivityInformationPage(String comment) {
        initialCommentDate =
                getCurrentCommentDateTime(ACTIVITY_COMMENT_DATE_FORMAT).replace(AM, A_M_).replace(PM, P_M_);
        commentAuthor = (UserData) context.getScenarioContext().getContext(USER_DATA);
        activityInformationCommentPage.addCommentText(ACTIVITY_COMMENT_TEXT, comment);
        commentsData.add(new CommentDTO()
                                 .setCommentText(comment)
                                 .setDate(initialCommentDate)
                                 .setAuthor(commentAuthor.getFirstName() + SPACE + commentAuthor.getLastName()));
    }

    @When("User on Activity information page Edit comment {string} with text {string}")
    public void editCommentOnActivityInformationPage(String comment, String newComment) {
        clickEditCommentOnActivityInformationPage(comment);
        activityInformationCommentPage.addCommentText(EDITED_ACTIVITY_COMMENT_TEXT, newComment);
    }

    @When("User clicks Activity Information comments section arrow")
    public void clicksActivityInformationCommentsSectionArrow() {
        activityInformationCommentPage.clickCommentsSectionArrow();
    }

    @When("User adds Activity attachment")
    public void addActivityAttachment(DataTable table) {
        List<List<String>> rows = table.asLists();
        for (List<String> row : rows) {
            activityInformationAttachmentPage.uploadFile(row.get(0));
            activityInformationAttachmentPage.addDescription(row.get(1));
            activityInformationAttachmentPage.clickUploadButton();
        }
    }

    @When("User uploads file on Activity page")
    public void addFileOnActivityPage(DataTable table) {
        List<String> attachmentData = table.asList();
        activityInformationAttachmentPage.uploadFile(attachmentData.get(0));
    }

    @When("User selects activity assignee {string}")
    public void selectActivityAssignee(String assignee) {
        activityInformationPage.fillAssigneeDropDown(assignee);
    }

    @When("User selects activity assessment")
    public void selectActivityAssessment() {
        activityInformationPage.fillAssessmentDropDownWithAnyValueIfItExists();
    }

    @When("User selects activity Assessment {string}")
    public void selectActivityAssessment(String assessment) {
        activityInformationPage.fillAssessmentDropDown(assessment);
    }

    @When("User clicks Create Order button")
    public void clickCreateOrderBtn() {
        activityInformationPage.waitWhilePreloadProgressbarIsDisappeared();
        activityInformationPage.clickCreateOrderButton();
    }

    @When("Approver {string} clicks {string} button")
    public void clickButton(String approver, String button) {
        activityInformationPage.waitWhilePreloadProgressbarIsDisappeared();
        activityInformationPage.clickActionButton(approver, button);
    }

    @When("User assigns approver {string}")
    public void assignApproverFromUsersList(String approver) {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        activityInformationPage.selectAssignedToApprover(approver);
    }

    @When("Approver clicks \"Re-assign for Approval\" button")
    public void clickReassignApprovalButton() {
        activityInformationPage.clickReassignForApprovalButton();
    }

    @When("User clicks Decline Order button")
    public void clickDeclineOrderBtn() {
        activityInformationPage.clickDeclineOrderButton();
    }

    @When("User clicks Back button to return from Activity modal")
    public void clickBackButtonForActivityPage() {
        activityInformationPage.waitWhilePreloadProgressbarIsDisappeared();
        activityInformationPage.clickBackButtonForActivityPage();
    }

    @When("User clicks Edit button for Activity")
    public void clickOnEditBtnForActivity() {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared(3);
        activityInformationPage.clickEditButton();
    }

    @When("User clicks Declining confirmation pop-up Cancel button")
    public void clickCancelConfirmationPopUpBtn() {
        activityInformationPage.clickCancelConfirmationPopUpButton();
    }

    @When("User clicks Order Details button")
    public void clickOrderDetailsButton() {
        activityInformationPage.waitWhileLoadingImageIsDisappeared();
        activityInformationPage.clickOrderDetailsBtn();
    }

    @When("User clicks Cancel Activity Information button")
    public void clickCancelActivityInformationButton() {
        activityInformationPage.clickCancelActivityInformationButton();
    }

    @When("User clicks 'Assign Questionnaire' Activity Information button")
    public void clickAssignActivityInformationButton() {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        activityInformationPage.clickAssignActivityInformationButton();
    }

    @When("User for questionnaire {string} clicks link {string}")
    public void clickLinkForQuestionnaireDetails(String questionnaireName, String link) {
        if (questionnaireName.equals(QUESTIONNAIRE_NAME_CONTEXT)) {
            questionnaireName = (String) context.getScenarioContext().getContext(QUESTIONNAIRE_NAME_CONTEXT);
        }
        link = activityInformationPage.getFromDictionaryIfExists(link);
        activityInformationPage.clickQuestionnaireStateButton(questionnaireName, link);
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User clicks 'Save' activity button")
    public void clickSaveActivityButton() {
        activityInformationPage.clickSaveActivityButton();
        String commentDate =
                getCurrentCommentDateTime(ACTIVITY_COMMENT_DATE_FORMAT).replace(PM, P_M_).replace(AM, A_M_);
        context.getScenarioContext().setContext(COMMENT_DATE, commentDate);
    }

    @When("User clicks 'Cancel' activity button")
    public void clickCancelActivityButton() {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        activityInformationPage.clickCancelActivityButton();
    }

    @When("User clicks Ad Hoc Activity {string} button")
    public void clickOnButtonWithName(String buttonName) {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        activityInformationPage.clickOnButtonWithName(buttonName);
    }

    @When("User approves all activities")
    public void approveAllActivities() {
        activityInformationPage.approveAllActivities();
    }

    @When("User reviews all activities")
    public void reviewAllActivities() {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        activityInformationPage.reviewAllActivities();
    }

    @When("User clicks review questionnaires")
    public void reviewAllQuestionnaires() {
        activityInformationPage.clickReviewQuestionnaire();
    }

    @When("User clicks {string} review action button for {string} user")
    public void rejectReviewForUser(String buttonName, String userName) {
        activityInformationPage.clickReviewActionButton(userName, buttonName);
    }

    @When("^User clicks (Delete|Edit) icon on Review for \"(.*)\" user$")
    public void clickIconOnReviewForUser(String iconName, String userName) {
        if (EDIT.equals(iconName)) {
            activityInformationPage.clickReviewEditButton(userName);
        } else {
            activityInformationPage.clickReviewDeleteButton(userName);
        }
    }

    @Then("^Review icon (Delete|Edit) icon for \"(.*)\" user (should|should not) be displayed$")
    public void checkIfReviewIconDisplayedForUser(String iconName, String userName, String state) {
        if (state.contains(NOT)) {
            assertThat(activityInformationPage.isReviewIconDisplayed(userName, iconName))
                    .as("Icon %s is displayed for Assignee - %s", iconName, userName)
                    .isFalse();
        } else {
            assertThat(activityInformationPage.isReviewIconDisplayed(userName, iconName))
                    .as("Icon %s is not displayed for Assignee - %s", iconName, userName)
                    .isTrue();
        }
    }

    @When("User clicks {string} approve action button for {string} user")
    public void clickApproverActionButtonForUser(String buttonName, String userName) {
        activityInformationPage.clickApproverActionButtonForUser(userName, buttonName);
    }

    @When("User clicks {string} review Ad Hoc action button for {string} user")
    public void rejectReviewAdHocForUser(String buttonName, String userName) {
        activityInformationPage.clickReviewAdHocActionButton(userName, buttonName);
    }

    @When("User selects {string} reviewer user")
    public void selectReviewerUser(String userName) {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        activityInformationPage.selectAssignedReviewerUser(userName);
    }

    @When("User click on 'Assign New' Questionnaire button")
    public void clickOnAssignNewQuestionnaireButton() {
        activityInformationPage.clickAssignNewQuestionnaireButton();
    }

    @When("User clicks Actions button for {int} Review Task")
    public void clickActionsButtonForReviewTask(int rowNo) {
        activityInformationPage.waitWhilePreloadProgressbarIsDisappeared();
        activityInformationPage.clickReviewTaskActionButton(rowNo);
    }

    @When("User clicks {string} action option")
    public void clickActionOption(String actionType) {
        activityInformationPage.clickReviewTaskActionTypeButton(actionType);
    }

    @When("User clicks Actions {string} button for Activity {string} in Questionnaire Details table")
    public void clickQuestionnaireActionsViewButton(String buttonName, String activityName) {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        activityInformationPage.clickQuestionnaireActionsButtonWithName(activityName, buttonName);
    }

    @SuppressWarnings("unchecked")
    @When("User clicks {string} button for Activity {string} in Questionnaire Details table")
    public void clickQuestionnaireButtonWithNameForActivity(String buttonName, String activityName) {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (activityName.equals(VALUE_TO_REPLACE)) {
            GenericTestData<QuestionnaireData> questionnaireTestData =
                    (GenericTestData<QuestionnaireData>) context.getScenarioContext()
                            .getContext(QUESTIONNAIRE_TEST_DATA);
            activityName = questionnaireTestData.getDataToEnter().getQuestionnaireName();
        }
        activityInformationPage.clickQuestionnaireButtonWithNameForActivity(activityName, buttonName);
    }

    @When("User adds Ad Hoc Activity attachment")
    public void addAdHocActivityAttachment(DataTable table) {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        List<List<String>> rows = table.asLists(String.class);
        for (List<String> row : rows) {
            String description = row.get(1);
            addActivityAttachmentFile(row.get(0));
            addActivityAttachmentDescription(description);
            clickActivityAttachmentUploadButton();
        }
    }

    @When("User uploads Activity attachment file {string}")
    public void addActivityAttachmentFile(String fileName) {
        activityInformationAttachmentPage.uploadFile(fileName);
    }

    @When("User adds Activity attachment description {string}")
    public void addActivityAttachmentDescription(String description) {
        if (NOT_APPLICABLE.equals(description)) {
            description = RandomStringUtils.randomAlphabetic(264);
        }
        if (APPLICABLE.equals(description)) {
            description = RandomStringUtils.randomAlphabetic(263);
            context.getScenarioContext().setContext(DESCRIPTION_REFERENCE, description);
        }
        activityInformationAttachmentPage.addDescription(description);
    }

    @When("User clicks Activity attachment upload button")
    public void clickActivityAttachmentUploadButton() {
        activityInformationAttachmentPage.clickUploadButton();
    }

    @When("User clicks Activity attachment upload button with fail")
    public void clickActivityAttachmentUploadWithFailButton() {
        String supplierId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        clickActivityAttachmentUploadButton();
        deleteThirdParty(supplierId);
    }

    @When("User clicks Activity attachment cancel button")
    public void clickActivityAttachmentCancelButton() {
        activityInformationAttachmentPage.clickCancelButton();
    }

    @When("^User clicks Activity information Attachment block (?:collapse|expand) icon")
    public void clickAttachmentCollapseButton() {
        activityInformationAttachmentPage.clickCollapseExpandIcon();
    }

    @When("User clicks on Activity information Attachment {string} download button")
    public void clickActivityAttachmentDownloadButton(String fileName) {
        if (!context.getScenarioContext().isContains(ATTACHMENT)) {
            File attachment = new File(getFilePath(fileName));
            context.getScenarioContext().setContext(ContextConstants.ATTACHMENT, attachment);
        }
        ActivityInformationAttachmentDTO actualAttachment = activityInformationAttachmentPage.getAttachment(fileName);
        activityInformationAttachmentPage.clickOn(actualAttachment.getDownloadIcon());
    }

    @When("User clicks on Activity information Attachment {string} delete button")
    public void clickActivityAttachmentDeleteButton(String fileName) {
        ActivityInformationAttachmentDTO actualAttachment = activityInformationAttachmentPage.getAttachment(fileName);
        activityInformationAttachmentPage.clickOn(actualAttachment.getDeleteIcon());
    }

    @When("User on Activity Information page adds comment with {int} alphanumeric and special characters")
    public void addActivityInformationComments(int commentLength) {
        this.activityInformationCommentPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        String generatedComment = randomAscii(commentLength);
        this.activityInformationCommentPage.addCommentText(ACTIVITY_COMMENT_TEXT, generatedComment);
        clickCommentSectionButton(COMMENT);
        initialCommentDate = getCurrentCommentDateTime(ACTIVITY_COMMENT_DATE_FORMAT);
        commentAuthor = (UserData) context.getScenarioContext().getContext(USER_DATA);
        commentsData.add(new CommentDTO()
                                 .setCommentText(generatedComment)
                                 .setDate(initialCommentDate)
                                 .setAuthor(commentAuthor.getFirstName() + SPACE + commentAuthor.getLastName()));
    }

    @When("User on Activity information page edits comment {string} with {int} alphanumeric and special characters")
    public void editCommentOnActivityInformationPageWith5000Characters(String comment, int commentLength) {
        this.activityInformationCommentPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        clickEditCommentOnActivityInformationPage(comment);
        addActivityInformationComments(commentLength);
    }

    @When("User saves Ad-Hoc Activity Id in context")
    public void saveAdHocActivityIdInContext() {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        String adHocId = getLastAdhocActivityId(thirdPartyId);
        context.getScenarioContext().setContext(ACTIVITY_ID, adHocId);
    }

    @When("User saves Ad-Hoc Activity Id from URL in context")
    public void saveAdHocActivityIdFromURLInContext() {
        String adHocId = activityInformationPage.getActivityIdFromUrl();
        context.getScenarioContext().setContext(ACTIVITY_ID, adHocId);
    }

    @Then("Activity Information page is displayed")
    public void activityInformationPageIsDisplayed() {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertTrue("Activity Information page is not displayed",
                   activityInformationPage.isActivityInformationPageDisplayed());
    }

    @Then("Activity Information modal is closed")
    public void activityInformationModalIsClosed() {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertTrue("Activity Information modal is not closed",
                   activityInformationPage.isActivityInformationModalDisappeared());
    }

    @Then("Ad Hoc Activity Information modal is displayed with details")
    public void adHocActivityInformationModalIsDisplayedWithDetails(ActivityInformationData expectedResult) {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        UserData userTestData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        if (nonNull(expectedResult.getOrderDetails()) && expectedResult.getOrderDetails().contains(VALUE_TO_REPLACE)) {
            String orderId =
                    WorkflowApi.getLastAddedAdHocActivityByName(thirdPartyId, expectedResult.getActivityName());
            expectedResult.setOrderDetails(expectedResult.getOrderDetails().replace(VALUE_TO_REPLACE, orderId));
        }
        if (nonNull(expectedResult.getDueDate())) {
            expectedResult.setDueDate(getDateAfterTodayDate(REACT_FORMAT, parseInt(
                    expectedResult.getDueDate().replace(TODAY, EMPTY))));
        }
        if (VALUE_TO_REPLACE.equals(expectedResult.getAssignee())) {
            expectedResult.setAssignee((String) getUserDataByEmail(userTestData.getUsername(), NAME_FILTER));
        }
        if (nonNull(expectedResult.getStartDate())) {
            expectedResult.setStartDate(getDateAfterTodayDate(REACT_FORMAT, parseInt(
                    expectedResult.getStartDate().replace(TODAY, EMPTY))));
        }
        if (nonNull(expectedResult.getLastUpdate())) {
            expectedResult.setLastUpdate(getDateAfterTodayDate(REACT_FORMAT, parseInt(
                    expectedResult.getLastUpdate().replace(TODAY, EMPTY))));
        }
        if (nonNull(expectedResult.getActivityName()) && expectedResult.getActivityName().equals(VALUE_TO_REPLACE)) {
            expectedResult.setActivityName(
                    (String) context.getScenarioContext().getContext(AD_HOC_ACTIVITY_CONTEXT_NAME));
        }

        ActivityInformationData actualResult = activityInformationPage.getAllFieldsValues();
        assertThat(actualResult).as("Activity Information modal doesn't display expected values")
                .usingRecursiveComparison().ignoringExpectedNullFields()
                .isEqualTo(expectedResult);
    }

    @Then("Activity Information modal is displayed with details")
    public void activityInfoModalIsDisplayedWithDetails(ActivityInformationData expectedResult) {
        activityInformationPage.waitWhilePreloadProgressbarIsDisappeared();
        UserData userTestData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        if (nonNull(expectedResult.getOrderDetails())) {
            String multilanguageOrderStatusRegex = "(?<=\\{).+?(?=\\})";
            Pattern pattern = Pattern.compile(multilanguageOrderStatusRegex);
            Matcher multilanguageMatcher = pattern.matcher(expectedResult.getOrderDetails());
            boolean isMultilanguageTemplateApplied = multilanguageMatcher.find();
            if (expectedResult.getOrderDetails().contains(VALUE_TO_REPLACE) && !isMultilanguageTemplateApplied) {
                String orderId = WorkflowApi.getLastSavedAsActivityByName(thirdPartyId);
                expectedResult.setOrderDetails(expectedResult.getOrderDetails().replace(VALUE_TO_REPLACE, orderId));
            }
            if (isMultilanguageTemplateApplied) {
                String orderId = WorkflowApi.getLastSavedAsActivityByName(thirdPartyId);
                String orderDetailsStatus = multilanguageMatcher.group();
                String orderDetailsTemplate =
                        activityInformationPage.getFromDictionaryIfExists("thirdPartyInformation.orderDetails");
                String psaOrderIdTemplate = "${ psaOrderId }";
                String orderStatusTemplate = "${ orderStatusLabel }";
                expectedResult.setOrderDetails(orderDetailsTemplate
                                                       .replace(psaOrderIdTemplate, orderId)
                                                       .replaceAll(NBSP_CODE, SPACE)
                                                       .replace(orderStatusTemplate, orderDetailsStatus)
                                                       .toUpperCase());
            }
        }
        if (nonNull(expectedResult.getAssignee()) && expectedResult.getAssignee().equals(VALUE_TO_REPLACE)) {
            expectedResult.setAssignee((String) getUserDataByEmail(userTestData.getUsername(), NAME_FILTER));
        }
        if (nonNull(expectedResult.getDueDate())) {
            expectedResult.setDueDate(getDateAfterTodayDate(REACT_FORMAT, parseInt(
                    expectedResult.getDueDate().replace(TODAY, EMPTY))));
        }
        if (nonNull(expectedResult.getStartDate())) {
            expectedResult.setStartDate(getDateAfterTodayDate(REACT_FORMAT, parseInt(
                    expectedResult.getStartDate().replace(TODAY, EMPTY))));
        }
        if (nonNull(expectedResult.getLastUpdate())) {
            expectedResult.setLastUpdate(getDateAfterTodayDate(REACT_FORMAT, parseInt(
                    expectedResult.getLastUpdate().replace(TODAY, EMPTY))));
        }
        if (nonNull(expectedResult.getActivityName()) && context.getScenarioContext().isContains(THIRD_PARTY_NAME)) {
            expectedResult.setActivityName(expectedResult.getActivityName()
                                                   .replace(THIRD_PARTY_NAME, (String)
                                                           context.getScenarioContext().getContext(THIRD_PARTY_NAME)));
        }
        if (VALUE_TO_REPLACE.equals(expectedResult.getActivityName())) {
            expectedResult.setActivityName(
                    (String) context.getScenarioContext().getContext(AD_HOC_ACTIVITY_CONTEXT_NAME));
        }
        ActivityInformationData actualResult = activityInformationPage.getAllFieldsValues();
        assertThat(actualResult).as("Activity Information modal doesn't contain expected details")
                .usingRecursiveComparison().ignoringExpectedNullFields()
                .isEqualTo(expectedResult);
    }

    @Then("Activity Information {string} is displayed with {string}")
    public void activityInformationFieldIsDisplayedWithValue(String fieldName, String value) {
        fieldName = activityInformationPage.getFromDictionaryIfExists(fieldName);
        activityInformationPage.waitWhilePreloadProgressbarIsDisappeared();
        String expectedValue =
                activityInformationPage.getActivityInformationFieldTextByName(fieldName).toUpperCase();
        assertEquals(fieldName + " is displayed with incorrect value: " + value, expectedValue, value.toUpperCase());
    }

    @Then("^Create Order button (is|is not) displayed$")
    public void createOrderBtnIsDisplayed(String buttonState) {
        if (buttonState.equals(IS_NOT)) {
            assertFalse("Create Order button is displayed", activityInformationPage.isCreateOrderBtnDisplayed());
        } else {
            assertTrue("Create Order button is not displayed", activityInformationPage.isCreateOrderBtnDisplayed());
        }
    }

    @Then("Decline Order button is displayed")
    public void declineOrderBtnIsDisplayed() {
        assertTrue("Decline Order button is not displayed", activityInformationPage.isDeclineOrderBtnDisplayed());
    }

    @Then("Declining confirmation pop-up appears")
    public void decliningConfirmationPopUpIsDisplayed() {
        assertTrue("Confirmation pop-up for declining did not appear",
                   activityInformationPage.isDecliningConfirmationPopUpDisplayed());
    }

    @Then("'Are you sure you want to decline order?' message is displayed")
    public void decliningWarningMsgIsDisplayed() {
        assertTrue("Warning message is not displayed or incorrect",
                   activityInformationPage.isDecliningWarningMsgDisplayed());
    }

    @Then("Declining confirmation pop-up Cancel button is displayed")
    public void cancelBtnIsDisplayed() {
        assertTrue("Cancel button is not displayed", activityInformationPage.isConfirmationPopUpCancelBtnDisplayed());
    }

    @Then("Proceed button for declining is displayed")
    public void decliningProceedBtnIsDisplayed() {
        assertTrue("Proceed button is not displayed", activityInformationPage.isDecliningProceedBtnDisplayed());
    }

    @Then("^Create Order button is (enabled|disabled)$")
    public void createOrderBtnIsEnabled(String buttonState) {
        if (buttonState.equals(DISABLED)) {
            assertFalse("Create Order Button is enabled!", activityInformationPage.isCreateOrderBtnEnabled());
        } else {
            assertTrue("Create Order Button is disabled!", activityInformationPage.isCreateOrderBtnEnabled());
        }
    }

    @Then("^Activity Information Assignee (can|can not) be edited$")
    public void assigneeCanBeEdited(String state) {
        if (state.contains(NOT)) {
            assertFalse("Assignee can be edited", activityInformationPage.isAssigneeEditable());
        } else {
            assertTrue("Assignee can't be edited", activityInformationPage.isAssigneeEditable());
        }

    }

    @SuppressWarnings("unchecked")
    @Then("Questionnaire {string} status should be {string}")
    public void checkQuestionnaireActivityStatusChanged(String questionnaireName, String status) {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared(10);
        if (questionnaireName.equals(VALUE_TO_REPLACE)) {
            GenericTestData<QuestionnaireData> questionnaireTestData =
                    (GenericTestData<QuestionnaireData>) context.getScenarioContext()
                            .getContext(QUESTIONNAIRE_TEST_DATA);
            questionnaireName = questionnaireTestData.getDataToEnter().getQuestionnaireName();
        }
        assertTrue("Status '" + status + "' can't be found",
                   activityInformationPage.getQuestionnaire(questionnaireName).getStatus().getText().contains(status));
    }

    @Then("^Activity Information button 'Save' is (displayed|not displayed)$")
    public void saveActivityButtonShouldBeVisible(String state) {
        if (state.contains(NOT)) {
            assertTrue("Save activity button is visible",
                       activityInformationPage.isSaveActivityButtonInvisible());
        } else {
            assertTrue("Save activity button is not visible",
                       activityInformationPage.isSaveActivityButtonVisible());
        }
    }

    @Then("^Activity Information button 'Cancel' is (displayed|not displayed)$")
    public void cancelActivityButtonShouldBeVisible(String state) {
        if (state.contains(NOT)) {
            assertTrue("Cancel activity button is visible",
                       activityInformationPage.isCancelActivityButtonInvisible());
        } else {
            assertTrue("Cancel activity button is not visible",
                       activityInformationPage.isCancelActivityButtonVisible());
        }
    }

    @Then("^Activity Information Edit button is (displayed|hidden)$")
    public void activityInformationEditButtonIsDisplayed(String buttonStatus) {
        if (buttonStatus.equals(DISPLAYED.toLowerCase())) {
            assertTrue("Activity Information Edit button is not displayed",
                       activityInformationPage.isEditActivityButtonVisible());
        } else {
            assertTrue("Activity Information Edit button is displayed",
                       activityInformationPage.isEditActivityButtonHidden());
        }
    }

    @Then("Activity Information Approvers table should contain the following columns")
    public void validateActivityInformationApproversTableColumns(DataTable dataTable) {
        List<String> expectedResult = dataTable.asList();
        List<String> actualResult = activityInformationPage.getApproversTableColumns();
        assertEquals("Approvers table columns is not expected",
                     expectedResult, actualResult);
    }

    @Then("^Activity Information Approvers table (should contain|does not contain) the following approvers$")
    public void validateActivityInformationApproversTableValues(String state,
            List<ActivityInformationData.Approver> expectedResult) {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        expectedResult.forEach(approver -> approver =
                nonNull(approver.getAssignedTo()) && approver.getAssignedTo().length() >= MAX_VISIBLE_LENGTH ?
                        approver.setAssignedTo(approver.getAssignedTo().substring(0, MAX_VISIBLE_LENGTH) + ELLIPSIS) :
                        approver.setAssignedTo(approver.getAssignedTo())
        );
        List<ActivityInformationData.Approver> actualResult = activityInformationPage.getApproversTableData();
        if (state.contains(NOT)) {
            assertThat(actualResult).as("Activity Information Approvers table contains unexpected approvers")
                    .doesNotContainAnyElementsOf(updateDate(expectedResult));
        } else {
            assertThat(actualResult).as("Activity Information Approvers table doesn't contain expected approvers")
                    .containsAll(updateDate(expectedResult));
        }

    }

    @Then("Activity Information Reviewers table should contain the following reviewers")
    public void validateActivityInformationReviewersTable(List<ActivityInformationData.Approver> expectedResult) {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        expectedResult.forEach(reviewer -> reviewer =
                nonNull(reviewer.getAssignedTo()) && reviewer.getAssignedTo().length() >= MAX_VISIBLE_LENGTH ?
                        reviewer.setAssignedTo(reviewer.getAssignedTo().substring(0, MAX_VISIBLE_LENGTH) + ELLIPSIS) :
                        reviewer.setAssignedTo(reviewer.getAssignedTo())
        );
        List<ActivityInformationData.Approver> actualResult = activityInformationPage.getReviewersTableData();

        if (expectedResult.size() == 1 && isNull(expectedResult.get(0).getAssignedTo())) {
            assertThat(actualResult.size()).as("Reviewers table is not empty").isEqualTo(0);
        } else {
            assertThat(actualResult)
                    .as("Activity Information Approvers table doesn't contain expected reviewers")
                    .isEqualTo(updateDate(expectedResult));
        }
    }

    @Then("^Activity Information Status field should be (enabled|disabled)$")
    public void activityInformationStatusFieldShouldBeNotEditable(String fieldState) {
        if (fieldState.equals(DISABLED)) {
            assertFalse("Status field is not disabled", activityInformationPage.isStatusFieldEnabled());
        } else {
            assertTrue("Status field is not enabled", activityInformationPage.isStatusFieldEnabled());
        }
    }

    @Then("^Activity Information Assessment field should be (enabled|disabled)$")
    public void activityInformationAssessmentFieldShouldBeNotEditable(String fieldState) {
        activityInformationPage.waitWhilePreloadProgressbarIsDisappeared();
        if (fieldState.equals(DISABLED)) {
            assertFalse("Assessment field is not disabled", activityInformationPage.isAssessmentFieldEnabled());
        } else {
            assertTrue("Assessment field is not enabled", activityInformationPage.isAssessmentFieldEnabled());
        }
    }

    @Then("Activity information Comment block elements are displayed")
    public void activityInformationCommentBlockElementsAreDisplayed() {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(activityInformationCommentPage.isCommentSectionExpanded(),
                              "Comment block isn't displayed");
        softAssert.assertTrue(activityInformationCommentPage.isCommentTextareaDisplayed(), "Text area isn't displayed");
        softAssert.assertTrue(activityInformationCommentPage.isCommentBlockButtonDisplayed(COMMENT),
                              "Check button isn't displayed");
        softAssert.assertAll();
    }

    @Then("^Activity information Comment \"((.*))\" edit button (is displayed|is not displayed)$")
    public void commentEditButtonIsDisplayed(String comment, String state) {
        if (state.contains(NOT)) {
            assertThat(activityInformationCommentPage.isCommentEditButtonDisplayed(comment))
                    .as("Activity information Comment %s edit button is displayed", comment).isFalse();
        } else {
            assertThat(activityInformationCommentPage.isCommentEditButtonDisplayed(comment))
                    .as("Activity information Comment %s edit button is not displayed", comment).isTrue();
        }
    }

    @Then("^Activity information Comment \"((.*))\" delete button (is displayed|is not displayed)$")
    public void commentDeleteButtonIsDisplayed(String comment, String state) {
        if (state.contains(NOT)) {
            assertThat(activityInformationCommentPage.isCommentDeleteButtonDisplayed(comment))
                    .as("Activity information Comment %s delete button is displayed", comment).isFalse();
        } else {
            assertThat(activityInformationCommentPage.isCommentDeleteButtonDisplayed(comment))
                    .as("Activity information Comment %s delete button is not displayed", comment).isTrue();
        }
    }

    @Then("^Created comment on Activity Information page (is displayed|is not displayed)$")
    public void verifyCommentWasCreatedOnActivityInformationPage(String state) {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        String expectedCommentText = (String) context.getScenarioContext().getContext(ACTIVITY_COMMENT_TEXT);
        if (state.contains(NOT)) {
            validateActivityInformationCommentVisibility(expectedCommentText, NOT);
        } else {
            validateCommentData(commentAuthor, expectedCommentText, initialCommentDate);
        }
    }

    @Then("Created comments on Activity Information page are displayed and sorted by upload date")
    public void verifyCommentsWereCreatedOnActivityInformationPage() {
        activityInformationCommentPage.waitWhilePreloadProgressbarIsDisappeared();
        List<CommentDTO> actualComments = activityInformationCommentPage.getActivitiesCommentsData();
        Collections.reverse(commentsData);
        assertThat(actualComments)
                .as("Expected comments list is not equal or sorted as actual ones")
                .isEqualTo(commentsData);
        Collections.reverse(commentsData);
    }

    @Then("^Edited comment on Activity Information page is displayed$")
    public void verifyCommentWasEditedOnActivityInformationPage() {
        String expectedCommentText = (String) context.getScenarioContext().getContext(ACTIVITY_COMMENT_TEXT);
        validateCommentData(commentAuthor, expectedCommentText, initialCommentDate);
    }

    @Then("User should see System Notice comment {string} on Activity Information page")
    public void verifySystemCommentWasCreated(String expectedCommentText, List<String> expectedResult) {
        activityInformationCommentPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        UserData userTestData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        ActivityInformationCommentDTO actualComment = activityInformationCommentPage
                .getActivityComment(expectedCommentText.replace(VALUE_TO_REPLACE, userTestData.getUsername()));
        String expectedCommentDate = ((String) context.getScenarioContext().getContext(COMMENT_DATE))
                .replace(AM, A_M_).replace(PM, P_M_);
        SoftAssertions softAssert = new SoftAssertions();
        assertThat(actualComment)
                .as("Comment is not displayed")
                .isNotNull();
        softAssert.assertThat(actualComment.getAuthor().getText())
                .as("Comment's author is unexpected")
                .isEqualTo(SYSTEM_NOTICE);
        softAssert.assertThat(actualComment.getDate().getText())
                .as("Comment's creation date is unexpected")
                .isEqualTo(expectedCommentDate);
        String actualText = actualComment.getComment().getText();
        expectedResult.forEach(text -> softAssert.assertThat(actualText)
                .as("Comment's text is unexpected").contains(text));
        softAssert.assertAll();
    }

    @Then("^Comment \"((.*))\" on Activity information page (should not|should) be shown$")
    public void validateActivityInformationCommentVisibility(String expectedCommentText, String state) {
        if (state.contains(NOT)) {
            assertThat(activityInformationCommentPage.isCommentWithTextDisplayed(expectedCommentText))
                    .as("Comment is displayed").isFalse();
        } else {
            assertThat(activityInformationCommentPage.isCommentWithTextDisplayed(expectedCommentText))
                    .as("Comment is not displayed").isTrue();
        }
    }

    @Then("Activity information page comment text area contains {string}")
    public void activityInformationPageCommentTextAreaContains(String expectedText) {
        expectedText = expectedText.isEmpty() ? null : expectedText;
        assertThat(activityInformationCommentPage.getCommentTextAreaText())
                .as("Activity information page comment text area doesn't contain expected text")
                .isEqualTo(expectedText);
    }

    @Then("^Activity information page comment block button \"((.*))\" (is displayed|is not displayed)$")
    public void activityInformationPageCommentButtonIsDisplayed(String buttonName, String state) {
        if (state.contains(NOT)) {
            assertThat(activityInformationCommentPage.isCommentBlockButtonDisplayed(buttonName))
                    .as("Activity information page comment block button %s is displayed")
                    .isFalse();
        } else {
            assertThat(activityInformationCommentPage.isCommentBlockButtonDisplayed(buttonName))
                    .as("Activity information page comment block button %s is not displayed")
                    .isTrue();
        }
    }

    @Then("^Activity information page comment section button \"((.*))\" (is displayed|is not displayed|is disabled|is enabled)$")
    public void activityInformationPageCommentSectionButtonIsDisplayed(String buttonName, String state) {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (state.contains(NOT)) {
            assertThat(activityInformationCommentPage.isCommentSectionButtonDisplayed(buttonName))
                    .as("Activity information page comment section button %s is displayed", buttonName)
                    .isFalse();
        } else if (state.contains(DISPLAYED.toLowerCase())) {
            assertThat(activityInformationCommentPage.isCommentSectionButtonDisplayed(buttonName))
                    .as("Activity information page comment section button %s is not displayed", buttonName)
                    .isTrue();
        } else if (state.contains(DISABLED.toLowerCase())) {
            assertThat(activityInformationCommentPage.isCommentSectionButtonDisabled(buttonName))
                    .as("Activity information page comment section button %s is not disabled", buttonName)
                    .isTrue();
        } else {
            assertThat(activityInformationCommentPage.isCommentSectionButtonDisabled(buttonName))
                    .as("Activity information page comment section button %s is not enabled", buttonName)
                    .isFalse();
        }
    }

    @Then("Created comments on Activity Information page is displayed in order")
    public void createdCommentsOnActivityInformationPageIsDisplayedInOrder(List<String> expectedList) {
        activityInformationCommentPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(activityInformationCommentPage.getCommentsList())
                .as("Created comments List is unexpected")
                .isEqualTo(expectedList);
    }

    @Then("^Activity information page comment section is (expanded|collapsed)$")
    public void activityInformationPageCommentSectionIsExpanded(String sectionState) {
        activityInformationCommentPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (sectionState.contains(EXPAND)) {
            assertThat(activityInformationCommentPage.isCommentSectionExpanded())
                    .as("Activity information page comment section is not expanded").isTrue();
        } else {
            assertThat(activityInformationCommentPage.isCommentSectionExpanded())
                    .as("Activity information page comment section is not collapsed").isFalse();
        }
    }

    @Then("^Activity information page comment section text area is (displayed|not displayed)$")
    public void activityInformationPageCommentSectionTextAreaIsDisplayed(String state) {
        boolean isDisplayed = state.equalsIgnoreCase(DISPLAYED);
        assertThat(activityInformationCommentPage.isCommentTextareaDisplayed())
                .as("Activity information page comment section text area is different from expected: %s", state)
                .isEqualTo(isDisplayed);
    }

    @Then("^Activity information page Review Task section is (expanded|collapsed)$")
    public void activityInformationPageReviewTaskSectionIsExpanded(String sectionState) {
        if (sectionState.contains(EXPAND)) {
            assertThat(activityInformationPage.isReviewTaskSectionExpanded())
                    .as("Activity information page Review Task section is not expanded")
                    .isTrue();
        } else {
            assertThat(activityInformationPage.isReviewTaskSectionExpanded())
                    .as("Activity information page Review Task section is not collapsed")
                    .isFalse();
        }
    }

    @Then("^Activity information Attachment block elements are (displayed|not displayed)$")
    public void activityInformationAttachmentBlockElementsAreDisplayed(String elementState) {
        activityInformationAttachmentPage.waitWhilePreloadProgressbarIsDisappeared();
        boolean isDisplayed = elementState.equalsIgnoreCase(DISPLAYED);
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(activityInformationAttachmentPage.isDescriptionFieldDisplayed(isDisplayed))
                .as("Description field doesn't match expected '%s' state", elementState)
                .isEqualTo(isDisplayed);
        softAssert.assertThat(activityInformationAttachmentPage.isCancelButtonDisplayed())
                .as("Cancel button doesn't match expected '%s' state", elementState)
                .isEqualTo(isDisplayed);
        softAssert.assertThat(activityInformationAttachmentPage.isUploadButtonDisplayed())
                .as("Add button doesn't match expected '%s' state", elementState)
                .isEqualTo(isDisplayed);
        softAssert.assertThat(activityInformationAttachmentPage.isBrowseButtonDisplayed())
                .as("Browse button doesn't match expected '%s' state", elementState)
                .isEqualTo(isDisplayed);
        softAssert.assertAll();
    }

    @Then("Activity Information Attachments table is empty with 'No Available Data' title")
    public void attachmentsTableIsEmpty() {
        assertThat(activityInformationAttachmentPage.isActivityInformationAttachmentsTableEmpty())
                .as("Attachments table is not empty")
                .isTrue();
    }

    @Then("Questionnaire Details table is empty with 'No Available Data' title")
    public void questionnaireTableContainsRecords() {
        assertThat(activityInformationPage.isQuestionnaireDetailsTableEmpty())
                .as("Questionnaire details table is not empty")
                .isTrue();
    }

    @Then("^Activity information page Attachment table row appears(| without download and delete icons)$")
    public void checkNewAttachmentAppearsOnActivityInformationPage(String buttonsState,
            List<ActivityInformationAttachmentData> expectedAttachments) {
        activityInformationAttachmentPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        SoftAssertions softAssert = new SoftAssertions();
        for (ActivityInformationAttachmentData expectedAttachment : expectedAttachments) {
            boolean isPendingExpected;
            if (TODAY.contains(expectedAttachment.getUploadDate().toUpperCase())) {
                expectedAttachment.setUploadDate(getTodayDate(REACT_FORMAT));
                isPendingExpected = false;
            } else {
                isPendingExpected = true;
            }
            ActivityInformationAttachmentData actualAttachment =
                    activityInformationAttachmentPage.getAttachmentData(expectedAttachment.getFileName(),
                                                                        isPendingExpected);
            String expectedDescription = expectedAttachment.getDescription();
            if (DESCRIPTION_REFERENCE.equals(expectedDescription)) {
                expectedDescription = (String) context.getScenarioContext().getContext(DESCRIPTION_REFERENCE);
                expectedAttachment.setDescription(expectedDescription);
            }
            if (buttonsState.isEmpty()) {
                expectedAttachment.setDeleteIconPresent(true).setDownloadIconPresent(true);
            } else {
                expectedAttachment.setDeleteIconPresent(false).setDownloadIconPresent(false);
            }
            softAssert.assertThat(actualAttachment)
                    .as("Attachment is different from expected %s", expectedAttachment.getFileName())
                    .isEqualTo(expectedAttachment);
        }
        softAssert.assertAll();
    }

    @Then("Attachment {string} should be deleted")
    public void checkAttachmentIsDeleted(String attachment) {
        activityInformationAttachmentPage.waitWhilePreloadProgressbarIsDisappeared();
        Assert.assertNull(format("Attachment '%s' wasn't deleted", attachment),
                          activityInformationAttachmentPage.getAttachment(attachment));
    }

    @Then("Message {string} appears under uploads file input")
    public void checkWarningMessage(String message) {
        Assert.assertEquals(format("Warning message '%s' is not shown", message), message,
                            activityInformationAttachmentPage.getWarningMessage());
    }

    @Then("Activity Information page Attachment table sorted by {string} in {string} order")
    public void activityInformationPageAttachmentTableDisplaysRowsSortedByInOrder(String sortedBy, String sortOrder) {
        List<ActivityInformationAttachmentDTO> actualAttachments =
                activityInformationAttachmentPage.getAllAttachmentsElements();
        List<ActivityInformationAttachmentDTO> expectedAttachments =
                activityInformationAttachmentPage.getSortedActivityAttachmentsTableRows(sortedBy, sortOrder);
        assertThat(actualAttachments).as("Activity attachments weren't properly sorted")
                .usingRecursiveFieldByFieldElementComparatorIgnoringFields("uploadIcon", "deleteIcon")
                .isEqualTo(expectedAttachments);
    }

    @Then("Activity information page Attachment table displays column names")
    public void activityInformationPageAttachmentTableDisplaysColumnNames(List<String> expectedColumns) {
        assertThat(activityInformationAttachmentPage.getTableColumns())
                .as("Attachment table columns are unexpected").isEqualTo(expectedColumns);
    }

    @Then("Activity Information Reviewers section is not shown")
    public void activityInformationReviewersSectionIsNotShown() {
        assertFalse("Activity Information Reviewers section is shown",
                    activityInformationPage.isReviewersSectionDisplayed());
    }

    @Then("Activity Information Reviewers section is shown")
    public void activityInformationReviewersSectionIsShown() {
        assertTrue("Activity Information Reviewers section is not shown",
                   activityInformationPage.isReviewersSectionDisplayed());
    }

    @Then("Activity Information Assigned To drop-down contains only active internal users")
    public void activityInformationAssignedToDropDownContainsOnlyActiveInternalUsers() {
        List<String> allActiveUsers = getActiveUsersFromPublicApi()
                .filter(data -> data.getUsername() != null)
                .map(user -> format(USER_FIRST_LAST_USERNAME, user.getFirstName(), user.getLastName(),
                                    user.getUsername()))
                .collect(Collectors.toList());
        List<String> actualResult = activityInformationPage.getAssignToDropDownValues();
        assertThat(allActiveUsers).as("Assigned To drop-down doesn't contain only active internal users")
                .containsAll(actualResult);

    }

    @Then("^Activity Information Assigned To drop-down contains only first (\\d+) active (Internal|External) users$")
    public void assignedToDropDownContainsOnly20ActiveInternalUsers(int usersCount, String userType) {
        List<String> allActiveUsers = SIPublicApi.getFirstActiveUsers(usersCount, userType)
                .stream()
                .filter(data -> data.getUsername() != null)
                .map(user -> format(USER_VALUE_FORMAT, user.getName(), user.getUsername()))
                .collect(Collectors.toList());
        List<String> actualResult = activityInformationPage.getAssignToDropDownValues();
        assertThat(allActiveUsers).as("Assigned To drop-down doesn't contain only active internal users")
                .containsAll(actualResult);
    }

    @Then("Review Task table contains row on position {int} with Review Status {string}")
    public void reviewTaskTableContainsRowOnPositionWithReviewStatus(int rowNo, String expectedResult) {
        assertEquals("Review Task status is unexpected", expectedResult,
                     activityInformationPage.getReviewTaskStatus(rowNo));
    }

    @Then("Review action for row on position {int} is displayed")
    public void reviewActionForRowOnPositionIsDisplayed(int rowNo) {
        assertTrue("Review action button is not displayed",
                   activityInformationPage.isReviewTaskReviewButtonDisplayed(rowNo));
    }

    @Then("Activity Information Details page should have Questionnaire details {string} with status {string}")
    public void checkQuestionnaireDetailsStatus(String questionnaireName, String status) {
        ActivityInformationData.QuestionnaireDetails questionnaireDetailObject =
                activityInformationPage.getQuestionnaireDetailObject(questionnaireName);
        assertEquals(questionnaireDetailObject.getStatus().getText(), status);
    }

    @Then("Activity Information Details page should have Questionnaire details {string} with Reviewer Assessment {string}")
    public void checkQuestionnaireDetailsReviewerAssessment(String questionnaireName, String reviewerAssessmentStatus) {
        ActivityInformationData.QuestionnaireDetails questionnaireDetailObject =
                activityInformationPage.getQuestionnaireDetailObject(questionnaireName);
        assertEquals(questionnaireDetailObject.getReviewerAssessment().getText(), reviewerAssessmentStatus);
    }

    @Then("Activity Status drop-down contains the next options")
    public void checkStatusDropDownListOfOptions(List<String> expectedOptions) {
        activityInformationPage.clickStatusInput();
        List<String> actualListOfOptions = activityInformationPage.getStatusDropDownOptions();
        assertThat(actualListOfOptions).as("Status dropdown contains not expected list of options!")
                .isEqualTo(expectedOptions);
        activityInformationPage.clickStatusInput();
    }

    @Then("'Assign New' Questionnaire button should be displayed")
    public void assignNewQuestionnaireButtonIsDisplayed() {
        assertThat(activityInformationPage.isAssignNewQuestionnaireButtonDisplayed())
                .as("'Assign New' Questionnaire button is not displayed")
                .isTrue();
    }

    @Then("Questionnaire Details table should contain following questionnaires")
    public void questionnaireTableContainsRecords(
            List<ActivityInformationData.ActivityQuestionnaireDetails> expectedResult) {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        boolean isWithFullDetails = expectedResult.get(0).getAssignee() != null;
        List<ActivityInformationData.ActivityQuestionnaireDetails> actualResult =
                activityInformationPage.getQuestionnaireDetailsTableData(isWithFullDetails);
        if (expectedResult.get(0).getButton() == null) {
            assertThat(actualResult)
                    .as("Questionnaire Details table doesn't contain expected values")
                    .usingRecursiveFieldByFieldElementComparatorIgnoringFields("button")
                    .containsAll(expectedResult);
        } else {
            assertThat(actualResult)
                    .as("Questionnaire Details table doesn't contain expected values")
                    .containsAll(expectedResult);
        }
    }

    @Then("Activity Information Status is displayed with {string}")
    public void isActivityStatusDisplayedWithValue(String value) {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(activityInformationPage.getActivityInformationFieldTextByName(STATUS))
                .as("Not expected Activity Status is displayed!")
                .isEqualTo(value);
    }

    @Then("Activity Information Order Details button should contain expected text {string}")
    public void activityInformationOrderDetailsButtonShouldContainExpectedText(String expectedResult) {
        String orderId = (String) context.getScenarioContext().getContext(ORDER_ID);
        expectedResult = nonNull(orderId) ? expectedResult.replace(VALUE_TO_REPLACE, orderId) : expectedResult;
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(activityInformationPage.getOrderDetailsButtonText())
                .as("Order Details button text is unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("User {string} was assigned to this activity")
    public void userWasAssignedToThisActivity(String userReference) {
        String expectedAssignee;
        if (userReference.isEmpty()) {
            expectedAssignee = null;
        } else {
            UserData userData = getUserCredentialsByRole(userReference);
            expectedAssignee = (String) getUserDataByEmail(userData.getUsername(), NAME_FILTER);
        }
        assertEquals("Activity assignee is unexpected", expectedAssignee,
                     activityInformationPage.getActivityAssigneeValue());
    }

    @Then("Assignee drop-down contains all the Active Internal Users in the System")
    public void assigneeDropdownContainsAllTheActiveInternalUsersInTheSystem() {
        List<String> expectedUsersList = getAllActiveInternalUsersStream(APIConstants.DESC).map(
                        user -> format(USER_VALUE_FORMAT, getUserDataByEmail(user.getUsername(), NAME_FILTER),
                                       user.getUsername()))
                .collect(Collectors.toList());
        List<String> actualUsersList = activityInformationPage.getAssigneeDropDownList();
        assertEquals("Assignee dropdown list is unexpected", expectedUsersList, actualUsersList);
    }

    @Then("Assignee drop-down contains all the Active Members of {string} group")
    public void assigneeDropdownContainsAllTheActiveMembersOfGroup(String groupName) {
        List<String> expectedUsersList = getUserGroup(getGroupIdByName(groupName)).getUsers().stream()
                .map(user -> format(USER_FORMAT, user.getFirstName() + SPACE + user.getLastName(), user.getEmail()))
                .collect(Collectors.toList());
        List<String> actualUsersList = activityInformationPage.getAssigneeDropDownList();
        List<String> actualCorrectedUsersList =
                actualUsersList.stream().map(user -> user.replaceAll(LF, SPACE)).collect(Collectors.toList());
        assertEquals("Assignee dropdown list is unexpected", expectedUsersList, actualCorrectedUsersList);
    }

    @Then("Ad-Hoc Activity Information is saved")
    public void adHocActivityInformationIsSaved() {
        assertThat(activityInformationPage.isEditActivityButtonVisible())
                .as("Ad Hoc activity information is not saved")
                .isTrue();
        String adHocId = activityInformationPage.getActivityIdFromUrl();
        context.getScenarioContext().setContext(ACTIVITY_ID, adHocId);
    }

    @Then("^Activity information Attachment block is (expanded|collapsed)$")
    public void activityInformationAttachmentBlockIsExpanded(String blockState) {
        boolean isExpanded = blockState.contains(EXPAND);
        assertThat(activityInformationAttachmentPage.isAttachmentsBlockExpanded())
                .as("Attachments block is not %s", blockState)
                .isEqualTo(isExpanded);
    }

    @Then("Activity information Attachment block upload button is disabled")
    public void attachmentUploadButtonIsDisabled() {
        assertThat(activityInformationAttachmentPage.isUploadButtonDisabled())
                .as("Attachment Upload button is not disabled")
                .isTrue();
    }

    @Then("Activity Information Review Task table contains the following task")
    public void reviewTaskTableContainsTheFollowingTask(List<ActivityInformationData.ReviewTask> expectedTask) {
        activityInformationPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(activityInformationPage.getReviewTaskTable())
                .usingRecursiveComparison().ignoringCollectionOrder().ignoringExpectedNullFields().asList()
                .as("Activity Information Review Task table doesn't contain expected task")
                .containsAll(expectedTask);
    }

    @Then("^Activity Attachment description characters limit text is (displayed|not displayed)$")
    public void activityAttachmentDescriptionLimitTextIsAppeared(String alertState, String alertMessage) {
        if (alertState.equalsIgnoreCase(DISPLAYED)) {
            assertThat(activityInformationAttachmentPage.getDescriptionLimitText())
                    .as("Activity Information Description limit text is not displayed or incorrect")
                    .isNotNull()
                    .isEqualTo(alertMessage);
        } else {
            assertThat(activityInformationAttachmentPage.getDescriptionLimitText())
                    .as("Activity Information Description limit text is displayed")
                    .isNull();
        }
    }

    @Then("Alert Icon is displayed with text on Activity Information page")
    public void alertIconIsDisplayedWithText(DataTable dataTable) {
        alertIconIsDisplayedWithText(activityInformationPage, dataTable);
    }

    @Then("^Activity information \"((.*))\" section is (expanded|collapsed)$")
    public void activityInformationAttachmentBlockIsExpanded(String sectionName, String state) {
        if (state.contains(EXPAND)) {
            assertThat(activityInformationPage.isSectionExpanded(sectionName))
                    .as("Attachments block is not %s", state)
                    .isTrue();
        } else {
            assertThat(activityInformationPage.isSectionExpanded(sectionName))
                    .as("Attachments block is not %s", state)
                    .isFalse();
        }
    }

    @Then("Activity Information Approvers drop-down contains {int} active users")
    public void activityInformationApproversDropDownContainsActiveUsers(int size) {
        List<String> expectedUsersList = getAllActiveInternalUsersStream(APIConstants.ASC)
                .map(user -> format("%s\n%s", user.getName(), user.getUsername()))
                .collect(Collectors.toList());
        List<String> actualResult = activityInformationPage.getApproversDropDownList();
        actualResult.remove(actualResult.size() - 1);
        SoftAssertions softAssertions = new SoftAssertions();
        softAssertions.assertThat(actualResult.size()).as("Approvers drop-down size is unexpected")
                .isEqualTo(size);
        softAssertions.assertThat(expectedUsersList).as("Approvers drop-down list is unexpected")
                .containsAll(actualResult);
        softAssertions.assertAll();
    }

    @Then("Activity Assessment drop-down contains all {string} activity assessments")
    public void activityAssessmentDropDownContainsAllActivityAssessments(String activityType) {
        RefDataResponse refDataPayload = getRefDataPayload(getValueTypeId(ACTIVITY_TYPE));
        Value activityValue = stream(refDataPayload.getListValues())
                .filter(activity -> activity.getName().equals(activityType)).findFirst()
                .orElseThrow(() -> new RuntimeException("Activity type '" + activityType + "' wasn't found"));
        List<String> expectedAssessmentList =
                activityValue.getAssessments().stream().map(Value.Assessment::getName).collect(Collectors.toList());
        assertThat(activityInformationPage.getAssessmentDropDownList())
                .as("Activity Assessment drop-down list is unexpected").isEqualTo(expectedAssessmentList);
    }

    @Then("^All action buttons for Activity (?:approver|reviewer) \"((.*))\" are (enabled|disabled)$")
    public void allActionButtonsForActivityApproverAreEnabled(String userName, String state) {
        boolean expectedResult = state.equals(DISABLED);
        SoftAssertions softAssertions = new SoftAssertions();
        List<String> actionButtons = activityInformationPage.getUserActionButtons(userName);
        softAssertions.assertThat(actionButtons).as("Actions buttons are not found").isNotNull().isNotEmpty();
        actionButtons.forEach(button -> softAssertions.assertThat(
                        activityInformationPage.isApproverActionButtonDisabled(userName, button))
                .as("Action button %s for Activity approver is not %s", button, state)
                .isEqualTo(expectedResult));
        softAssertions.assertAll();
    }

    @Then("Activity Information page URL is expected")
    public void activityInformationPageURLIsExpected() {
        assertThat(activityInformationPage.isActivityInformationURLMatches())
                .as("Activity Information page URL is unexpected").isTrue();

    }

    @Then("For Questionnaire {string} in Questionnaire Details table Actions buttons are")
    public void checkQuestionnaireActionsButtons(String questionnaireName, DataTable buttons) {
        activityInformationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(activityInformationPage.getQuestionnaireActionsButtons(questionnaireName))
                .as("For Questionnaire %s in Questionnaire table Actions buttons are incorrect", questionnaireName)
                .isEqualTo(buttons.asList());
    }

    @Then("For Questionnaire {string} in Questionnaire Details table Actions button {string} is displayed")
    public void checkQuestionnaireActionsButton(String questionnaireName, String buttonName) {
        assertThat(activityInformationPage.isQuestionnaireButtonWithNameDisplayed(questionnaireName, buttonName))
                .as("For Questionnaire %s in Questionnaire table Actions button is incorrect", questionnaireName)
                .isTrue();
    }

    @Then("Activity Information {string} field message {string} is displayed")
    public void activityInformationFieldMessageIsDisplayed(String fieldName, String expectedText) {
        assertThat(activityInformationPage.getFieldMessage(fieldName))
                .as("Activity Information %s field message is unexpected").isEqualTo(expectedText);
    }

    @Then("^Activity Information \"((.*))\" field should be (enabled|disabled)$")
    public void activityInformationFieldShouldBeEnabled(String fieldName, String fieldState) {
        activityInformationPage.waitWhilePreloadProgressbarIsDisappeared();
        if (fieldState.equals(DISABLED)) {
            assertThat(activityInformationPage.isActivityFieldDisabled(fieldName))
                    .as("Activity information %s field is not disabled", fieldName)
                    .isTrue();
        } else {
            assertThat(activityInformationPage.isActivityFieldDisabled(fieldName))
                    .as("Activity information %s field is not enabled", fieldName)
                    .isFalse();
        }
    }

    @Then("Only {int} last comments are displayed by default")
    public void onlyLastCommentsAreDisplayedByDefault(int commentsCount) {
        List<CommentDTO> actualComments = activityInformationCommentPage.getActivitiesCommentsData();
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(actualComments.size())
                .as("Actual displayed comments size is not %s", commentsCount)
                .isEqualTo(commentsCount);
        Collections.reverse(commentsData);
        IntStream.rangeClosed(0, commentsCount - 1)
                .forEach(i -> softAssert.assertThat(actualComments.get(i))
                        .as("Comment isn't matched with expected one")
                        .isEqualTo(commentsData.get(i)));
        softAssert.assertAll();
        Collections.reverse(commentsData);
    }

    @Then("^(Ad Hoc Activity|Activity Information) page opened from Reports contains expected URL$")
    public void activityPageOpenedFromReportsContainsExpectedURL(String activityType) {
        String thirdPartyId = (String) context.getScenarioContext().getContext(ContextConstants.THIRD_PARTY_ID);
        String activityId = (String) context.getScenarioContext().getContext(ContextConstants.ACTIVITY_ID);
        String expectedUrl = activityType.equals(ACTIVITY_INFORMATION) ?
                URL + THIRD_PARTY + SLASH + thirdPartyId + String.format(ACTIVITY, activityId) + ACTIVITY_IN_REPORT :
                URL + THIRD_PARTY + SLASH + thirdPartyId + String.format(AD_HOC_ACTIVITY, activityId) +
                        ACTIVITY_IN_REPORT;
        assertThat(driver.getCurrentUrl().replaceAll(HTTPS, HTTP))
                .as("Activity URL is incorrect")
                .contains(expectedUrl);
    }

    @Then("^(Ad Hoc Activity|Activity Information) page contains expected URL$")
    public void activityPageContainsExpectedURL(String activityType) {
        String thirdPartyId = (String) context.getScenarioContext().getContext(ContextConstants.THIRD_PARTY_ID);
        String activityId = (String) context.getScenarioContext().getContext(ContextConstants.ACTIVITY_ID);
        String expectedUrl = activityType.equals(ACTIVITY_INFORMATION) ?
                URL + THIRD_PARTY + SLASH + thirdPartyId + String.format(ACTIVITY, activityId) :
                URL + THIRD_PARTY + SLASH + thirdPartyId + String.format(AD_HOC_ACTIVITY, activityId);
        assertThat(driver.getCurrentUrl().replaceAll(HTTPS, HTTP))
                .as("Activity URL is incorrect")
                .contains(expectedUrl);
    }

    @Then("^'(Ad Hoc Activity|Activity Information)' Activity page is displayed$")
    public void addHocActivityPageIsDisplayed(String pageName) {
        assertThat(activityInformationPage.isPageWithNameDisplayed(pageName))
                .as("%s page is not displayed!", pageName)
                .isTrue();
    }

    @Then("The 5000-character comment on Activity Information page (is displayed|is not displayed)$")
    public void validate5000CharactersComment(String state) {
        String expectedCommentText =
                (((String) context.getScenarioContext().getContext(ACTIVITY_COMMENT_TEXT)).substring(0, 5000));
        ActivityInformationCommentDTO actualComment =
                this.activityInformationCommentPage.getActivityComment(expectedCommentText + SEE_MORE_LINK);
        if (state.contains(NOT)) {
            validateActivityInformationCommentVisibility(expectedCommentText, NOT);
        } else {
            assertThat(actualComment.getComment().getText().replace(SEE_MORE_LINK, EMPTY)).as(
                            "Comment text is unexpected")
                    .isEqualTo(expectedCommentText);
        }
    }

    @Then("Activity Information Page comment character limit message {string} is displayed")
    public void workflowHistoryCommentLengthMessageIsDisplayed(String expectedMessage) {
        assertThat(this.activityInformationCommentPage.getCommentCharacterLimitMessage())
                .as("Activity Information comment character limit message is unexpected")
                .isEqualTo(expectedMessage);
    }

    @Then("Third-party Questionnaire view page Froala text contains strong element with text {string}")
    public void thirdPartyQuestionnaireViewPageFroalaTextContainsStrongElementWithText(String expectedText) {
        assertThat(activityInformationPage.isStrongHeaderTextDisplayed(expectedText))
                .as("Header Strong element with text %s is not displayed", expectedText)
                .isTrue();
    }

    @Then("Third-party Questionnaire view page Froala text contains element with text {string} and style {string}")
    public void thirdPartyQuestionnaireViewPageFroalaTextContainsElementWithTextAndStyle(String expectedText,
            String expectedStyle) {
        assertThat(activityInformationPage.isHeaderTextWithStyleDisplayed(expectedText, expectedStyle))
                .as("Header element with text %s and style %sis not displayed", expectedText, expectedStyle)
                .isTrue();
    }

    @Then("^Activity Information Invalid label is (displayed|not displayed) for user \"((.*))\"$")
    public void verifyInvalidLabel(String expectedResult, String userReference) {
        Object userData = context.getScenarioContext().getContext(userReference);
        userReference = userData instanceof String ? (String) userData : ((UserData) userData).getFirstName();
        assertThat(activityInformationPage.isInvalidLabelDisplayedForUser(userReference))
                .as("Invalid label is not displayed for user %s", userReference)
                .isEqualTo(expectedResult.equalsIgnoreCase(DISPLAYED));
    }

    @Then("Activity Assessment drop-down does not contains all {string} activity assessments")
    public void activityAssessmentDropDownDoesNotContainsAllActivityAssessments(String activityType) {
        RefDataResponse refDataPayload = getRefDataPayload(getValueTypeId(ACTIVITY_TYPE));
        Value activityValue = stream(refDataPayload.getListValues())
                .filter(activity -> activity.getName().equals(activityType)).findFirst()
                .orElseThrow(() -> new RuntimeException("Activity type '" + activityType + "' wasn't found"));
        List<String> expectedAssessmentList =
                activityValue.getAssessments().stream().map(Value.Assessment::getName).collect(Collectors.toList());
        assertThat(activityInformationPage.getAssessmentDropDownList())
                .as("Activity Assessment drop-down list is match").isEqualTo(expectedAssessmentList);
    }

    @Then("'Delete' button is grayed out for the reviewer {string}")
    public void isReviewerDeleteButtonGrayedOut(String userName) {
        assertThat(activityInformationPage.getReviewerDeleteButtonColor(userName))
                .as("Delete reviewer button is not grayed out")
                .isEqualTo(DELETE_EDIT_BUTTON_GREY.getColorRgba());
    }

}