package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.riskManagement;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.Attachment;
import com.refinitiv.asts.test.ui.api.model.workflow.workflowResponse.WorkFlowItem;
import com.refinitiv.asts.test.ui.constants.ContextConstants;
import com.refinitiv.asts.test.ui.constants.Pages;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.riskManagement.WorkflowHistoryPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.thirdPartyInformation.ActivityInformationSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.ActivityInformationData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang3.RandomStringUtils;
import org.assertj.core.api.SoftAssertions;

import java.io.File;
import java.util.*;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.WorkflowApi.getLastWorkflowHistoryResponse;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.Pages.SLASH;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.Colors.*;
import static com.refinitiv.asts.test.ui.pageActions.BasePage.URL;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static com.refinitiv.asts.test.utils.FileUtil.*;
import static java.lang.Integer.parseInt;
import static java.lang.String.format;
import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;

public class WorkflowHistorySteps extends BaseSteps {

    public static final int MAX_DESCRIPTION_LENGTH = 264;
    private final WorkflowHistoryPage workflowHistoryPage;
    private static final String GREY = "grey";
    private static final String GREEN = "green";
    private static final String RED = "red";
    private String commentDate;

    public WorkflowHistorySteps(ScenarioCtxtWrapper context) {
        super(context);
        this.workflowHistoryPage = new WorkflowHistoryPage(this.driver, this.context);
    }

    @When("User clicks {string} Activity details on Workflow History page")
    public void clickActivity(String activityName) {
        workflowHistoryPage.clickActivity(activityName);
    }

    @When("User uploads {string} Attachment on Workflow History page")
    public void uploadAttachment(String fileName) {
        workflowHistoryPage.uploadFile(fileName);
        context.getScenarioContext().setContext(UPLOADED_FILE_NAME, fileName);
    }

    @When("User clicks {string} button for Workflow History Activity Attachment")
    public void clickActivityAttachmentButton(String button) {
        workflowHistoryPage.clickAttachmentButton(button);
    }

    @When("User clicks {string} button for Workflow History Activity Comment")
    public void clickActivityCommentButton(String buttonName) {
        workflowHistoryPage.clickCommentButton(buttonName);
        if (buttonName.equalsIgnoreCase(COMMENT)) {
            commentDate = getCurrentCommentDateTime(ACTIVITY_COMMENT_DATE_FORMAT);
        }
    }

    @When("User clicks {string} edit button for Workflow History Activity Comment")
    public void clickActivityEditCommentButton(String buttonName) {
        workflowHistoryPage.clickEditCommentButton(buttonName);
    }

    @When("User fills in comment field {string} for Workflow History Activity")
    public void fillInCommentField(String comment) {
        workflowHistoryPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        workflowHistoryPage.fillInCommentField(comment);
    }

    @When("User fills in edit comment field {string} for Workflow History Activity")
    public void fillInEditCommentField(String comment) {
        workflowHistoryPage.fillInEditCommentField(comment);
    }

    @When("^User hovers over Workflow History Activity (Approver|Reviewer) \"((.*))\" (Pending|Approved|Rejected|Reassigned|Reviewed) 'Check' icon$")
    public void hoverOverCheckIcon(String userType, String user, String state) {
        workflowHistoryPage.hoverOverCheckIcon(userType, user, state);
    }

    @When("User clicks Workflow History arrow button")
    public void clickWorkflowHistoryArrowButton() {
        workflowHistoryPage.clickWorkflowHistoryArrowButton();
    }

    @When("User clicks Export to PDF link")
    public void clickExportToPdf() {
        workflowHistoryPage.clickExportToPdf();
    }

    @When("User adds Workflow History attachments")
    public void addWorkflowHistoryAttachments(DataTable table) {
        List<List<String>> rows = table.asLists(String.class);
        for (List<String> row : rows) {
            String description = row.get(1);
            uploadAttachment(row.get(0));
            addWorkflowHistoryDescription(description);
            clickActivityAttachmentButton(UPLOAD);
        }
    }

    @When("User adds Workflow History attachment description {string}")
    public void addWorkflowHistoryDescription(String description) {
        if (NOT_APPLICABLE.equals(description)) {
            description = RandomStringUtils.randomAlphabetic(MAX_DESCRIPTION_LENGTH);
        }
        if (APPLICABLE.equals(description)) {
            description = RandomStringUtils.randomAlphabetic(MAX_DESCRIPTION_LENGTH - 1);
            context.getScenarioContext().setContext(DESCRIPTION_REFERENCE, description);
        }
        workflowHistoryPage.addDescription(description);
    }

    @When("User clicks delete button for Workflow History attachment with name {string}")
    public void clickDeleteButtonForAttachment(String attachmentName) {
        workflowHistoryPage.clickDeleteAttachmentButton(attachmentName);
    }

    @When("User clicks on Workflow History Attachment {string} download button")
    public void clickOnAttachmentDownloadButton(String attachmentName) {
        if (!context.getScenarioContext().isContains(ATTACHMENT)) {
            File attachment = new File(getFilePath(attachmentName));
            context.getScenarioContext().setContext(ContextConstants.ATTACHMENT, attachment);
        }
        workflowHistoryPage.clickDownloadAttachmentButton(attachmentName);
    }

    @When("User clicks Workflow History attachment table column {string}")
    public void clickWorkflowHistoryAttachmentTableColumn(String columnName) {
        workflowHistoryPage.clickAttachmentTableColumnName(columnName);
    }

    @When("User clicks {string} Workflow History Activity Comment {string} button")
    public void clickWorkflowHistoryActivityCommentButton(String buttonName, String commentText) {
        workflowHistoryPage.clickCommentActionButton(buttonName, commentText);
    }

    @When("User clicks Workflow History Activity Comment {string} button for comment {string}")
    public void clickWorkflowHistoryActivityCommentTextButton(String buttonName, String commentText) {
        workflowHistoryPage.clickCommentTextButton(commentText, buttonName);
    }

    @When("User clicks Workflow History Activity comment section button {string}")
    public void clickWorkflowHistoryActivityCommentSectionButton(String buttonName) {
        workflowHistoryPage.clickCommentSectionButton(buttonName);
    }

    @When("User clicks Workflow History Questionnaire {string} action button {string}")
    public void clickWorkflowHistoryQuestionnaireActionButton(String questionnaireName, String buttonName) {
        workflowHistoryPage.clickQuestionnaireActionButton(questionnaireName, buttonName);
    }

    @When("User navigates to last created Workflow History")
    public void navigateToLastCreatedWorkflowHistory() {
        workflowHistoryPage.navigateToWorkflowHistoryPage();
    }

    @Then("Workflow History window is displayed")
    public void clickOnRiskManagementTab() {
        assertThat(workflowHistoryPage.isPageLoaded())
                .as("Workflow History window is not displayed")
                .isTrue();
    }

    @Then("Workflow History headers titles are displayed")
    public void checkWorkflowHeaderTitles(DataTable data) {
        List<String> headerTitles = data.asList();
        SoftAssertions soft = new SoftAssertions();
        headerTitles.forEach(title -> soft.assertThat(workflowHistoryPage.isHeaderTitleDisplayed(title))
                .as(title + " is not shown")
                .isTrue());
        soft.assertAll();
    }

    @Then("Workflow History headers values should be displayed")
    public void checkWorkflowHeaderValues(DataTable data) {
        workflowHistoryPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        Map<String, String> headers = new HashMap<>(data.asMap(String.class, String.class));
        SoftAssertions soft = new SoftAssertions();
        for (String key : headers.keySet()) {
            String value = headers.get(key);
            if (nonNull(value) && value.contains(TODAY)) {
                value = getDateAfterTodayDate(REACT_FORMAT, parseInt(value.replace(TODAY, EMPTY)));
                headers.put(key, value);
            }
            soft.assertThat(workflowHistoryPage.getHeaderValue(key))
                    .as("Value for header '%s' is unexpected", key)
                    .isEqualTo(headers.get(key));
        }
        soft.assertAll();
    }

    @Then("Workflow History activity groups titles should be displayed")
    public void checkWorkflowActivityGroupsTitles(DataTable data) {
        List<String> activityGroupsTitles = data.asList();
        SoftAssertions soft = new SoftAssertions();
        activityGroupsTitles.forEach(title -> soft.assertThat(workflowHistoryPage.isActivityGroupsTitleDisplayed(title))
                .as(title + " is not shown")
                .isTrue());
        soft.assertAll();
    }

    @Then("Workflow History activity groups values should be displayed")
    public void checkWorkflowActivityGroupsDisplayed(DataTable data) {
        List<List<String>> activityGroups = data.asLists();
        SoftAssertions soft = new SoftAssertions();
        activityGroups.forEach(activity -> soft.assertThat(
                        workflowHistoryPage.isActivityGroupsRowsDisplayed(activity.get(0), activity.get(1)))
                .as("Activity '" + activity.get(0) + "' with group '" + activity.get(1) + "' is not shown")
                .isTrue());
        soft.assertAll();
    }

    @Then("Workflow History Activity values should be displayed")
    public void checkActivityValues(DataTable data) {
        Map<String, String> headers = new HashMap<>(data.asMap(String.class, String.class));
        SoftAssertions soft = new SoftAssertions();
        for (String key : headers.keySet()) {
            String value = headers.get(key);
            if (nonNull(value) && value.contains(TODAY)) {
                value = getDateAfterTodayDate(REACT_FORMAT, parseInt(value.replace(TODAY, EMPTY)));
                headers.put(key, value);
            }
            soft.assertThat(workflowHistoryPage.getActivityHeaderValue(key.replace(SPACE, EMPTY)))
                    .as("Value for Header '%s' is unexpected", key)
                    .isEqualTo(headers.get(key));
        }
        soft.assertAll();
    }

    @Then("^Workflow History Activity Attachment Upload field and Browse button are (displayed|not displayed)$")
    public void checkAttachmentsUpload(String state) {
        SoftAssertions soft = new SoftAssertions();
        if (state.contains(NOT)) {
            soft.assertThat(workflowHistoryPage.isUploadFieldDisplayed())
                    .as("Attachments Upload field is not displayed")
                    .isFalse();
        } else {
            soft.assertThat(workflowHistoryPage.isUploadFieldDisplayed())
                    .as("Attachments Upload field is not displayed")
                    .isTrue();
            soft.assertThat(workflowHistoryPage.getUploadButtonName()).as("Incorrect button name is displayed")
                    .isEqualTo(BROWSE.toUpperCase());
        }
        soft.assertAll();
    }

    @Then("^Workflow History Activity Attachment Description field is (displayed|not displayed)$")
    public void checkAttachmentsDescription(String state) {
        if (state.contains(NOT)) {
            assertThat(workflowHistoryPage.isDescriptionDisplayed())
                    .as("Attachments Description field is displayed")
                    .isFalse();
        } else {
            assertThat(workflowHistoryPage.isDescriptionDisplayed())
                    .as("Attachments Description field is not displayed")
                    .isTrue();
        }
    }

    @Then("^Workflow History Activity Attachment buttons are (displayed|not displayed)$")
    public void checkActivityAttachmentsButtonsDisplayed(String state, List<String> buttons) {
        SoftAssertions softAssert = new SoftAssertions();
        if (state.contains(NOT)) {
            buttons.forEach(button -> softAssert.assertThat(workflowHistoryPage.isAttachmentButtonDisplayed(button))
                    .as("Attachments Description field is displayed").isFalse());
        } else {
            buttons.forEach(button -> softAssert.assertThat(workflowHistoryPage.isAttachmentButtonDisplayed(button))
                    .as("Attachments Description field is not displayed").isTrue());
        }

        softAssert.assertAll();
    }

    @Then("Workflow History Activity Attachment UPLOAD button is disabled")
    public void isUploadButtonDisabled() {
        assertThat(workflowHistoryPage.isAttachmentUploadButtonDisabled()).as(
                "Attachment UPLOAD button is not disabled").isTrue();
    }

    @Then("Workflow History Activity Attachment is displayed")
    public void checkUploadedAttachment() {
        String fileName = (String) context.getScenarioContext().getContext(UPLOADED_FILE_NAME);
        assertThat(workflowHistoryPage.getUploadFieldValue()).as("Attachment is not uploaded").contains(fileName);
    }

    @Then("Workflow History Activity Attachment table is displayed with headers")
    public void checkAttachmentTableHeaders(DataTable data) {
        workflowHistoryPage.waitWhilePreloadProgressbarIsDisappeared();
        List<String> expectedHeaders = data.asList();
        SoftAssertions soft = new SoftAssertions();
        soft.assertThat(workflowHistoryPage.isAttachmentTableDisplayed()).as("Attachment table is not displayed")
                .isTrue();
        List<String> actualHeaders = workflowHistoryPage.getAttachmentHeaders();
        soft.assertThat(actualHeaders).as("Not expected headers are displayed").containsAll(expectedHeaders);
        soft.assertAll();
    }

    @Then("^Workflow History Activity Attachment table is (displayed|not displayed) with details$")
    public void checkAttachmentTableValues(String state, List<Attachment> attachments) {
        workflowHistoryPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        List<Attachment> actualValues = workflowHistoryPage.getAttachmentTableValues();
        List<Attachment> expectedAttachments =
                attachments.stream().filter(attachment -> attachment.getDateUploaded().equals(TODAY))
                        .map(date -> date.setDateUploaded(getTodayDate(REACT_FORMAT))).collect(Collectors.toList());
        if (state.contains(NOT)) {
            assertThat(actualValues).as("Expected Attachment details are displayed")
                    .doesNotContainAnyElementsOf(expectedAttachments);
        } else {
            assertThat(actualValues).as("Expected Attachment details are not displayed")
                    .containsAll(expectedAttachments);
        }
    }

    @Then("^Workflow History Activity Attachment buttons are (available|not available) for file \"((.*))\"$")
    public void checkFileButtons(String state, String file, List<String> buttons) {
        SoftAssertions softAssert = new SoftAssertions();
        if (state.contains(NOT)) {
            buttons.forEach(button -> softAssert.assertThat(workflowHistoryPage.isFileButtonDisplayed(file, button)).as(
                    "Attachment %s button is displayed for file %s", button, file).isFalse());
        } else {
            buttons.forEach(button -> softAssert.assertThat(workflowHistoryPage.isFileButtonDisplayed(file, button)).as(
                    "Attachment %s button is not displayed for file %s", button, file).isTrue());
        }
        softAssert.assertAll();
    }

    @Then("^Workflow History Activity Attachment buttons are (available|not available) for all files$")
    public void attachmentButtonsAreAvailableForAllFiles(String state, List<String> buttons) {
        workflowHistoryPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        workflowHistoryPage.hoverWorkflowHistoryArrowButton();
        List<String> fileNames = workflowHistoryPage.getAllFileNames();
        for (String fileName : fileNames) {
            checkFileButtons(state, fileName, buttons);
        }
    }

    @Then("^Workflow History Activity Comment field is (displayed|not displayed)$")
    public void isActivityCommentFieldDisplayed(String state) {
        if (state.contains(NOT)) {
            assertThat(workflowHistoryPage.isActivityCommentFieldDisplayed()).as("Activity Comment field is displayed")
                    .isFalse();
        } else {
            assertThat(workflowHistoryPage.isActivityCommentFieldDisplayed()).as(
                            "Activity Comment field is not displayed")
                    .isTrue();
        }
    }

    @Then("^Workflow History Activity Comment buttons are (displayed|not displayed)$")
    public void isCommentButtonDisplayed(String state, List<String> buttons) {
        SoftAssertions softAssert = new SoftAssertions();
        if (state.contains(NOT)) {
            buttons.forEach(button -> softAssert.assertThat(workflowHistoryPage.isCommentButtonDisplayed(button)).as(
                    "%s button is displayed", button).isFalse());
        } else {
            buttons.forEach(button -> softAssert.assertThat(workflowHistoryPage.isCommentButtonDisplayed(button)).as(
                    "%s button is not displayed", button).isTrue());
        }
        softAssert.assertAll();
    }

    @Then("Workflow History Activity Comment COMMENT button is disabled")
    public void isCommentButtonDisabled() {
        assertThat(workflowHistoryPage.isCommentButtonDisabled()).as("Comment COMMENT button is not disabled").isTrue();
    }

    @Then("Workflow History Activity Comment {string} is added")
    public void checkActivityComment(String comment) {
        ActivityInformationSteps activityInformationSteps = new ActivityInformationSteps(context);
        UserData userTestData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        activityInformationSteps.validateCommentData(userTestData, comment, commentDate);
    }

    @Then("Workflow History table shows 'No Available Data' message")
    public void isAvailableDataMessageDisplayed() {
        assertThat(workflowHistoryPage.isAvailableDataMessageDisplayed())
                .as("Workflow History table does not show No Available Data message!").isTrue();
    }

    @Then("^Workflow History Activity (Approver|Reviewer) \"((.*))\" (Pending|Approved|Rejected|Reassigned|Reviewed) 'Check' icon is displayed$")
    public void isCheckIconDisplayed(String userType, String user, String state) {
        assertThat(workflowHistoryPage.isCheckIconDisplayed(userType, user, state)).as("%s check icon is not displayed",
                                                                                       userType)
                .isTrue();
    }

    @Then("^(?:Approver|Reviewer?) tooltip with text \"((.*))\" appears$")
    public void isTooltipTextDisplayed(String expectedTooltip) {
        assertThat(workflowHistoryPage.getTooltipText()).as("Tooltip %s is not displayed", expectedTooltip)
                .isEqualTo(expectedTooltip);
    }

    @Then("^Workflow History Activity (Approver|Reviewer) (Pending|Approved|Rejected|Reassigned|Reviewed) 'Check' icon is (grey|green|red)$")
    public void checkCheckIconColor(String user, String state, String color) {
        String expectedColor;
        switch (color) {
            case GREY:
                expectedColor = CHECK_ICON_DARK_GREY.getColorRgba();
                break;
            case GREEN:
                expectedColor = LIGHT_GREEN.getColorRgba();
                break;
            case RED:
                expectedColor = REACT_RED.getColorRgba();
                break;
            default:
                throw new IllegalArgumentException(color + " color for check icon is not expected!");
        }
        assertThat(workflowHistoryPage.getCheckIconCSSValue(user, state)).as("%s Check icon is not %s", state, color)
                .isEqualTo(expectedColor);
    }

    @Then("Workflow History details are present in file {string}")
    public void verifyPdfContent(String fileName) {
        SoftAssertions softAssertion = new SoftAssertions();
        String reportTitle = "Third-party Status Detailed Report";
        String delimiter = ":\n";
        String newDelimiter = ": ";
        String expectedFullFileName = fileName + getTodayDate(EXPORT_FILE_NAME_FORMAT) + PDF;
        String actualPdfDetails = readDownloadedPdfFile(expectedFullFileName);
        List<String> allWorkflowDetails = workflowHistoryPage.getAllWorkflowDetails();
        List<String> activitiesGroupList = workflowHistoryPage.getActivitiesGroupList();
        List<String> activitiesNameList = workflowHistoryPage.getActivitiesNameList();
        List<String> commentDetails = workflowHistoryPage.getCommentDetails();
        List<String> attachmentDetails = workflowHistoryPage.getAttachmentDetails();
        int numberOfActivities = activitiesGroupList.size();
        List<List<String>> activitiesDetails = new ArrayList<>();
        for (int i = 0; i < numberOfActivities; i++) {
            String activityName = activitiesNameList.get(i);
            List<String> activityDetails = workflowHistoryPage.getActivityDetails(activityName);
            activitiesDetails.add(activityDetails);
        }
        softAssertion.assertThat(actualPdfDetails).as("Report title is not displayed").contains(reportTitle);
        allWorkflowDetails.forEach(workflowDetail -> softAssertion.assertThat(actualPdfDetails)
                .as("PDF Report does not contain workflow detail %s", workflowDetail)
                .contains(workflowDetail.replaceAll(delimiter, newDelimiter)));
        activitiesGroupList.forEach(
                group -> softAssertion.assertThat(actualPdfDetails).as("%s group is not displayed", group)
                        .contains(format("Group No: %s", group)));
        activitiesNameList.forEach(
                activity -> softAssertion.assertThat(actualPdfDetails).as("%s activity is not displayed", activity)
                        .contains(activity));
        activitiesDetails.forEach(
                activityDetails -> activityDetails.forEach(activityDetail -> softAssertion.assertThat(actualPdfDetails)
                        .as("PDF Report does not contain activity detail %s", activityDetail)
                        .contains(activityDetail.replaceAll(delimiter, newDelimiter))));
        commentDetails.forEach(commentDetail -> softAssertion.assertThat(actualPdfDetails)
                .as("PDF Report does not contain comment detail %s", commentDetail)
                .contains(commentDetail));
        attachmentDetails.forEach(attachmentDetail -> softAssertion.assertThat(actualPdfDetails)
                .as("PDF Report does not contain attachment detail %s", attachmentDetail).contains(attachmentDetail));
        softAssertion.assertAll();
    }

    @Then("^Workflow History Attachment description characters limit text is (displayed|not displayed)$")
    public void workflowHistoryDescriptionLimitTextIsAppeared(String alertState, String alertMessage) {
        if (alertState.equalsIgnoreCase(DISPLAYED)) {
            assertThat(workflowHistoryPage.getDescriptionLimitText())
                    .as("Workflow History Description limit text is not displayed or incorrect")
                    .isNotNull()
                    .isEqualTo(alertMessage);
        } else {
            assertThat(workflowHistoryPage.getDescriptionLimitText())
                    .as("Workflow History Description limit text is displayed")
                    .isNull();
        }
    }

    @Then("Message {string} appears under uploads Workflow History file input")
    public void messageAppearsUnderUploadsWorkflowHistoryFileInput(String expectedMessage) {
        assertThat(workflowHistoryPage.getUploadInputError()).as("Uploads Workflow History error is unexpected")
                .isEqualTo(expectedMessage);
    }

    @Then("Workflow History attachment table displays records sorted by {string} in {string} order")
    public void attachmentTableDisplaysRecordsSortedByInOrder(String columnName, String expectedOrder) {
        List<String> valuesList = workflowHistoryPage.getListValuesForColumn(columnName);
        tableIsSortedByInOrder("Workflow History attachment", columnName, expectedOrder, REACT_FORMAT, valuesList,
                               false);
    }

    @Then("Workflow History edit comment length message {string} is displayed")
    public void workflowHistoryCommentLengthMessageIsDisplayed(String expectedMessage) {
        assertThat(workflowHistoryPage.getEditCommentLengthMessage())
                .as("Workflow History edit comment length message is unexpected")
                .isEqualTo(expectedMessage);
    }

    @Then("Workflow History page edit comment text area contains {string}")
    public void workflowHistoryPageCommentTextAreaContains(String expectedText) {
        assertThat(workflowHistoryPage.getEditCommentText())
                .as("Workflow History page edit comment text is unexpected")
                .isEqualTo(expectedText);
    }

    @Then("Workflow History page edit comment text area is not displayed")
    public void workflowHistoryPageEditCommentTextAreaIsNotDisplayed() {
        assertThat(workflowHistoryPage.isEditCommentTextAreaDisplayed())
                .as("Workflow History page edit comment text area is displayed")
                .isFalse();
    }

    @Then("Workflow History comment {string} message is displayed next to creation date")
    public void workflowHistoryCommentMessageIsDisplayedNextToCreationDate(String expectedEditText) {
        assertThat(workflowHistoryPage.getEditedCommentMessage(commentDate.replaceAll(PM, P_M_).replace(AM, A_M_)))
                .as("Workflow History comment message is not displayed next to creation date")
                .isEqualTo(expectedEditText);
    }

    @Then("Workflow History Activity Comment {string} is not displayed")
    public void workflowHistoryActivityCommentIsNotDisplayed(String commentText) {
        assertThat(workflowHistoryPage.isCommentInvisible(commentText))
                .as("Workflow History Activity Comment '%s' is displayed", commentText)
                .isTrue();
    }

    @Then("Workflow History comment section is expanded")
    public void workflowHistoryCommentSectionIsExpanded() {
        workflowHistoryPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(workflowHistoryPage.isCommentSectionExpanded())
                .as("Workflow History Activity Comment section is not expanded")
                .isTrue();
    }

    @Then("^Workflow History Activity Comment button \"((.*))\" is (disabled|enabled)$")
    public void workflowHistoryActivityCommentButtonIsDisabled(String buttonName, String state) {
        if (state.contains(DISABLED)) {
            assertThat(workflowHistoryPage.isCommentButtonDisabled(buttonName))
                    .as("Workflow History Activity Comment button '%s' is not disabled", buttonName)
                    .isTrue();
        } else {
            assertThat(workflowHistoryPage.isCommentButtonDisabled(buttonName))
                    .as("Workflow History Activity Comment button '%s' is not enabled", buttonName)
                    .isFalse();
        }
    }

    @Then("Workflow History page add comment text area contains {string}")
    public void workflowHistoryPageAddCommentTextAreaContains(String expectedText) {
        expectedText = expectedText.isEmpty() ? null : expectedText;
        assertThat(workflowHistoryPage.getAddCommentText())
                .as("Workflow History page add comment text is unexpected")
                .isEqualTo(expectedText);
    }

    @Then("Workflow History Activity Comments displayed")
    public void workflowHistoryActivityCommentsDisplayed(List<String> expectedComments) {
        workflowHistoryPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(workflowHistoryPage.getVisibleCommentsText())
                .as("Workflow History Activity Comments are unexpected")
                .isEqualTo(expectedComments);
    }

    @Then("^Workflow History Activity Comment \"((.*))\" button is (displayed|not displayed) for comment \"((.*))\"$")
    public void workflowHistoryActivityCommentButtonIsDisplayed(String buttonName, String state, String commentText) {
        if (state.contains(NOT)) {
            assertThat(workflowHistoryPage.isCommentTextButtonDisplayed(commentText, buttonName))
                    .as("Workflow History Activity Comment text button '%s' is displayed", buttonName)
                    .isFalse();
        } else {
            assertThat(workflowHistoryPage.isCommentTextButtonDisplayed(commentText, buttonName))
                    .as("Workflow History Activity Comment text button '%s' is not displayed", buttonName)
                    .isTrue();
        }
    }

    @Then("^Workflow History Activity comment section button \"((.*))\" is (displayed|not displayed)$")
    public void workflowHistoryActivityCommentSectionButtonIsNotDisplayed(String buttonName, String state) {
        workflowHistoryPage.waitWhilePreloadProgressbarIsDisappeared();
        if (state.contains(NOT)) {
            assertThat(workflowHistoryPage.isCommentSectionButtonDisplayed(buttonName))
                    .as("Workflow History Activity Comment section button '%s' is displayed", buttonName)
                    .isFalse();
        } else {
            assertThat(workflowHistoryPage.isCommentSectionButtonDisplayed(buttonName))
                    .as("Workflow History Activity Comment section button '%s' is displayed", buttonName)
                    .isTrue();
        }
    }

    @Then("Workflow History Questionnaire details is displayed")
    public void workflowHistoryQuestionnaireDetailsDisplayed(
            List<ActivityInformationData.ActivityQuestionnaireDetails> expectedResult) {
        workflowHistoryPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(workflowHistoryPage.getQuestionnaireTableData(isNull(expectedResult.get(0).getReviewer())))
                .as("Workflow History Questionnaire details are unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("Workflow History Questionnaire {string} action button {string} is displayed")
    public void workflowHistoryQuestionnaireActionButtonIsDisplayed(String questionnaireName, String buttonName) {
        assertThat(workflowHistoryPage.isQuestionnaireActionButtonDisplayed(questionnaireName, buttonName))
                .as("Workflow History Questionnaire %s action %s button is not displayed", questionnaireName,
                    buttonName)
                .isTrue();
    }

    @Then("Workflow History Activity {string} Comment action {string} is displayed")
    public void workflowHistoryActivityCommentActionIsDisplayed(String commentText, String buttonName) {
        assertThat(workflowHistoryPage.isCommentActionButtonDisplayed(commentText, buttonName))
                .as("Workflow History Comment %s action %s button is not displayed", commentText,
                    buttonName)
                .isTrue();
    }

    @Then("Risk Management Workflow History Activity has correct URL")
    public void checkRiskManagementWorkflowHistoryHasCorrectURL() {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        WorkFlowItem workflowHistoryResponse = getLastWorkflowHistoryResponse(thirdPartyId).get(0);
        String workflowHistoryId = workflowHistoryResponse.getId();
        String activityId = workflowHistoryResponse.getWorkflowComponents().get(0).getActivities().get(0).getId();
        String expectedUrl = URL + Pages.THIRD_PARTY + SLASH
                + thirdPartyId + format(Pages.WORKFLOW_HISTORY, workflowHistoryId, activityId);
        assertThat(driver.getCurrentUrl().replaceAll(HTTPS, HTTP))
                .as("Workflow History Activity URL is incorrect")
                .isEqualTo(expectedUrl);
    }

}