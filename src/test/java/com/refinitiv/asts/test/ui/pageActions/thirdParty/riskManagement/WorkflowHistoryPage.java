package com.refinitiv.asts.test.ui.pageActions.thirdParty.riskManagement;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.Attachment;
import com.refinitiv.asts.test.ui.api.model.workflow.workflowResponse.WorkFlowItem;
import com.refinitiv.asts.test.ui.constants.PageElementNames;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.riskManagement.WorkflowHistoryPO;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.ActivityInformationData;
import com.refinitiv.asts.test.ui.utils.DateUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.util.Strings;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.api.WorkflowApi.getLastWorkflowHistoryResponse;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.THIRD_PARTY_ID;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.Pages.THIRD_PARTY;
import static com.refinitiv.asts.test.ui.constants.Pages.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ActivityInformationDisplayPage.*;
import static com.refinitiv.asts.test.ui.stepDefinitions.ui.CommonSteps.COLON;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static com.refinitiv.asts.test.utils.FileUtil.getFilePath;
import static java.lang.String.format;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.apache.commons.lang3.StringUtils.LF;
import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.presenceOfElementLocated;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated;

public class WorkflowHistoryPage extends BasePage<WorkflowHistoryPage> {

    private final WorkflowHistoryPO workflowHistoryPO;

    public WorkflowHistoryPage(WebDriver driver, ScenarioCtxtWrapper context) {
        super(driver, context);
        workflowHistoryPO = new WorkflowHistoryPO(driver);
    }

    @Override
    protected ExpectedCondition<WorkflowHistoryPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return isElementDisplayed(waitShort, workflowHistoryPO.getWorkflowHistoryTab());
    }

    @Override
    public void load() {

    }

    public boolean isHeaderTitleDisplayed(String title) {
        return isElementDisplayed(xpath(format(workflowHistoryPO.getWorkflowHistoryHeadedTitles(), title)));
    }

    public boolean isActivityGroupsTitleDisplayed(String title) {
        return isElementDisplayed(xpath(format(workflowHistoryPO.getWorkflowHistoryActivityGroupsTitles(), title)));
    }

    public boolean isActivityGroupsRowsDisplayed(String groupNumber, String activityName) {
        return isElementDisplayed(
                xpath(format(workflowHistoryPO.getWorkflowHistoryActivityGroupsValues(), groupNumber, activityName)));
    }

    public boolean isUploadFieldDisplayed() {
        return isElementDisplayed(waitLong, workflowHistoryPO.getFieldUpload());
    }

    public boolean isDescriptionDisplayed() {
        return isElementDisplayed(workflowHistoryPO.getDescription());
    }

    public boolean isAttachmentButtonDisplayed(String button) {
        if (button.equals(CANCEL.toUpperCase())) {
            return isElementDisplayed(workflowHistoryPO.getButtonAttachmentCancel());
        } else {
            return isElementDisplayed(workflowHistoryPO.getButtonAttachmentUpload());
        }
    }

    public boolean isAttachmentTableDisplayed() {
        return isElementDisplayed(waitShort, workflowHistoryPO.getActivityAttachmentTable());
    }

    public boolean isFileButtonDisplayed(String file, String button) {
        if (button.equals(DELETE)) {
            return isElementDisplayed(xpath(format(workflowHistoryPO.getDeleteAttachmentButton(), file)));
        }
        return isElementDisplayed(xpath(format(workflowHistoryPO.getDownloadAttachmentButton(), file)));
    }

    public boolean isActivityCommentFieldDisplayed() {
        return isElementDisplayed(workflowHistoryPO.getFieldComment());
    }

    public boolean isAttachmentUploadButtonDisabled() {
        return isElementDisplayed(workflowHistoryPO.getButtonAttachmentUploadDisabled());
    }

    public boolean isCommentButtonDisplayed(String button) {
        return isElementDisplayed(xpath(format(workflowHistoryPO.getCommentButtonWithName(), button)));
    }

    public boolean isCommentButtonDisabled() {
        return isElementDisplayed(workflowHistoryPO.getButtonCommentDisabled());
    }

    public boolean isAvailableDataMessageDisplayed() {
        return isElementDisplayed(workflowHistoryPO.getNoAvailableData());
    }

    public boolean isCheckIconDisplayed(String userType, String user, String state) {
        return isElementDisplayed(waitShort, xpath(format(workflowHistoryPO.getCheckIcon(), userType, user, state)));
    }

    public boolean isEditCommentTextAreaDisplayed() {
        return isElementDisplayed(workflowHistoryPO.getEditCommentTextArea());
    }

    public boolean isCommentInvisible(String commentText) {
        return isElementDisappeared(waitMoment, xpath(format(workflowHistoryPO.getCommentText(), commentText)));
    }

    public boolean isCommentSectionExpanded() {
        waitShort.until(visibilityOfElementLocated(workflowHistoryPO.getCommentSectionHeader()));
        return isElementAttributeContains(workflowHistoryPO.getCommentSectionHeader(), CLASS, EXPAND);
    }

    public boolean isCommentButtonDisabled(String buttonName) {
        return isElementAttributeContains(xpath(format(workflowHistoryPO.getCommentButtonWithName(), buttonName)),
                                          CLASS, DISABLED);
    }

    public boolean isCommentTextButtonDisplayed(String commentText, String buttonName) {
        return isElementDisplayed(waitMoment,
                                  xpath(format(workflowHistoryPO.getCommentTextButton(), commentText, buttonName)));
    }

    public boolean isCommentSectionButtonDisplayed(String buttonName) {
        return isElementDisplayed(waitMoment, xpath(format(workflowHistoryPO.getCommentSectionButton(), buttonName)));
    }

    public boolean isQuestionnaireActionButtonDisplayed(String questionnaireName, String buttonName) {
        return isElementDisplayed(
                xpath(format(workflowHistoryPO.getQuestionnaireActionButton(), questionnaireName, buttonName)));
    }

    public boolean isCommentActionButtonDisplayed(String commentText, String buttonName) {
        scrollIntoView(xpath(format(workflowHistoryPO.getCommentText(), commentText)));
        hoverOverElement(xpath(format(workflowHistoryPO.getCommentText(), commentText)));
        clickWithJS(driver.findElement(xpath(format(workflowHistoryPO.getCommentText(), commentText))));
        return isElementDisplayed(waitMoment, cssSelector(format(workflowHistoryPO.getCommentActionButton(),
                                                                 buttonName.toLowerCase())));
    }

    public void clickActivity(String activityName) {
        clickOn(xpath(format(workflowHistoryPO.getActivity(), activityName)), waitShort);
    }

    public void clickAttachmentButton(String button) {
        if (button.equals(CANCEL.toUpperCase())) {
            clickOn(workflowHistoryPO.getButtonAttachmentCancel());
        } else {
            waitWhileSeveralPreloadProgressBarsAreDisappeared();
            clickOn(workflowHistoryPO.getButtonAttachmentUpload(), waitLong);
        }
    }

    public void clickCommentButton(String button) {
        clickOn(xpath(format(workflowHistoryPO.getCommentButtonWithName(), button)));
    }

    public void clickEditCommentButton(String button) {
        clickOn(xpath(format(workflowHistoryPO.getEditCommentButton(), button)));
    }

    public void fillInCommentField(String comment) {
        waitShort.until(visibilityOfElementLocated(workflowHistoryPO.getFieldComment()));
        clearAndInputField(workflowHistoryPO.getFieldComment(), comment);
    }

    public void fillInEditCommentField(String comment) {
        clearAndInputField(workflowHistoryPO.getEditCommentTextArea(), comment);
    }

    public void hoverOverCheckIcon(String userType, String user, String state) {
        hoverOverElement(xpath(format(workflowHistoryPO.getCheckIcon(), userType, user, state)));
    }

    public void clickWorkflowHistoryArrowButton() {
        clickOn(workflowHistoryPO.getWorkflowHistoryArrowButton());
    }

    public void clickExportToPdf() {
        clickOn(workflowHistoryPO.getExportToPdfLink(), waitShort);
    }

    public void addDescription(String description) {
        clearAndInputField(workflowHistoryPO.getDescription(), description);
    }

    public void clickDeleteAttachmentButton(String attachmentName) {
        hoverOverElement(xpath(format(workflowHistoryPO.getDeleteAttachmentButton(), attachmentName)));
        clickOn(xpath(format(workflowHistoryPO.getDeleteAttachmentButton(), attachmentName)));
    }

    public void clickDownloadAttachmentButton(String attachmentName) {
        clickOn(xpath(format(workflowHistoryPO.getDownloadAttachmentButton(), attachmentName)));
    }

    public void clickAttachmentTableColumnName(String columnName) {
        clickOn(xpath(format(workflowHistoryPO.getAttachmentColumnName(), columnName)));
    }

    public void clickCommentActionButton(String buttonName, String commentText) {
        scrollIntoView(xpath(format(workflowHistoryPO.getCommentText(), commentText)));
        hoverOverElement(xpath(format(workflowHistoryPO.getCommentText(), commentText)));
        clickWithJS(driver.findElement(xpath(format(workflowHistoryPO.getCommentText(), commentText))));
        clickOn(cssSelector(format(workflowHistoryPO.getCommentActionButton(), buttonName.toLowerCase())), waitMoment);
    }

    public void clickCommentTextButton(String commentText, String buttonName) {
        clickOn(xpath(format(workflowHistoryPO.getCommentTextButton(), commentText, buttonName)));
    }

    public void clickCommentSectionButton(String buttonName) {
        clickOn(xpath(format(workflowHistoryPO.getCommentSectionButton(), buttonName)), waitShort);
    }

    public void clickQuestionnaireActionButton(String questionnaireName, String buttonName) {
        clickOn(xpath(format(workflowHistoryPO.getQuestionnaireActionButton(), questionnaireName, buttonName)));
    }

    public void navigateToWorkflowHistoryPage() {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        WorkFlowItem workflowHistoryResponse = getLastWorkflowHistoryResponse(thirdPartyId).get(0);
        String workflowHistoryId = workflowHistoryResponse.getId();
        String activityId = workflowHistoryResponse.getWorkflowComponents().get(0).getActivities().get(0).getId();
        driver.get(URL + THIRD_PARTY + SLASH + thirdPartyId + format(WORKFLOW_HISTORY, workflowHistoryId, activityId));
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void hoverWorkflowHistoryArrowButton() {
        hoverOverElement(workflowHistoryPO.getWorkflowHistoryArrowButton());
    }

    public List<String> getAllWorkflowDetails() {
        return getElementsText(workflowHistoryPO.getPdfWorkflowDetails());
    }

    public List<String> getActivitiesGroupList() {
        return getElementsText(workflowHistoryPO.getPdfActivitiesGroupList());
    }

    public List<String> getActivitiesNameList() {
        return getElementsText(workflowHistoryPO.getPdfActivitiesNameList());
    }

    public List<String> getActivityDetails(String activity) {
        return getElementsText(xpath(format(workflowHistoryPO.getPdfActivityDetails(), activity)));
    }

    public List<String> getCommentDetails() {
        List<String> actualCommentDetails = getElementsText(workflowHistoryPO.getPdfComment());
        actualCommentDetails.remove(Strings.EMPTY);
        return actualCommentDetails.stream()
                .map(comment -> {
                    String commentWithMarkerReplaced = comment.replace(P_M_, PM).replace(A_M_, AM);
                    return DateUtil.isDateMatchedWithFormat(commentWithMarkerReplaced, ACTIVITY_COMMENT_DATE_FORMAT) ?
                            updateCommentDate(commentWithMarkerReplaced) : comment;
                }).collect(Collectors.toList());
    }

    public List<String> getAttachmentDetails() {
        return getElementsText(workflowHistoryPO.getPdfAttachment());
    }

    public List<String> getAttachmentHeaders() {
        waitShort.ignoring(StaleElementReferenceException.class)
                .until(visibilityOfElementLocated(workflowHistoryPO.getActivityAttachmentTableHeaders()));
        return getElementsText(workflowHistoryPO.getActivityAttachmentTableHeaders());
    }

    public List<String> getAllFileNames() {
        return getAttachmentTableValues().stream().map(Attachment::getFilename).collect(Collectors.toList());
    }

    public List<String> getListValuesForColumn(String columnName) {
        int columnIndex = getAttachmentHeaders().indexOf(columnName.toUpperCase()) + 1;
        return driver.findElements(workflowHistoryPO.getActivityAttachmentTableValues()).stream()
                .map(row -> getElementText(
                        row.findElement(xpath(format(workflowHistoryPO.getAttachmentTableRowValue(), columnIndex)))))
                .collect(Collectors.toList());
    }

    public List<String> getVisibleCommentsText() {
        return getElementsText(workflowHistoryPO.getCommentsText()).stream()
                .map(text -> text.replace(LF + SEE_MORE_LINK, EMPTY)).collect(
                        Collectors.toList());
    }

    public List<Attachment> getAttachmentTableValues() {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (isElementDisplayed(waitShort, workflowHistoryPO.getUploadedDataCells())) {
            List<WebElement> uploadedDataCells = getElements(workflowHistoryPO.getUploadedDataCells());
            IntStream.range(0, uploadedDataCells.size()).forEach(index -> waitLong.ignoring(
                    StaleElementReferenceException.class, TimeoutException.class).until(
                    driver -> isDateMatchedWithFormat(getElementText(uploadedDataCells.get(index)),
                                                      DATE_OF_INCORPORATION_FORMAT)));
        } else {
            refreshPage();
            waitWhileSeveralPreloadProgressBarsAreDisappeared();
            scrollIntoView(workflowHistoryPO.getActivityAttachmentTableValues());
        }

        List<WebElement> values = getElements(workflowHistoryPO.getActivityAttachmentTableValues());
        List<Attachment> list = new ArrayList<>();
        for (WebElement value : values) {
            Attachment attachment = new Attachment()
                    .setFilename(getRowChildElementText(value, workflowHistoryPO.getAttachmentTableFileName()))
                    .setDescription(getRowChildElementText(value, workflowHistoryPO.getAttachmentTableDescription()))
                    .setDateUploaded(getRowChildElementText(value, workflowHistoryPO.getAttachmentTableUploadDate()));
            list.add(attachment);
        }
        return list;
    }

    public List<ActivityInformationData.ActivityQuestionnaireDetails> getQuestionnaireTableData(
            boolean isQuestionnaireAssignedTable) {
        List<ActivityInformationData.ActivityQuestionnaireDetails> list = new ArrayList<>();
        for (WebElement row : getElements(workflowHistoryPO.getQuestionnaireDetailsTableRows())) {
            ActivityInformationData.ActivityQuestionnaireDetails activityQuestionnaireDetails =
                    new ActivityInformationData.ActivityQuestionnaireDetails()
                            .setQuestionnaireName(getQuestionnaireRowValue(row, QUESTIONNAIRE_NAME_TD_NUMBER))
                            .setStatus(getQuestionnaireRowValue(row, QUESTIONNAIRE_STATUS_TD_NUMBER))
                            .setScore(getQuestionnaireRowValue(row, QUESTIONNAIRE_SCORE_TD_NUMBER - 1))
                            .setOverallAssessment(
                                    getQuestionnaireRowValue(row, QUESTIONNAIRE_OVERALL_ASSESSMENT_TD_NUMBER - 1))
                            .setReviewer(isQuestionnaireAssignedTable ? null :
                                                 getQuestionnaireRowValue(row, QUESTIONNAIRE_REVIEWER_TD_NUMBER - 1));
            list.add(activityQuestionnaireDetails);
        }
        return list;
    }

    private String getQuestionnaireRowValue(WebElement row, int valueIndex) {
        return getRowChildElementText(row, xpath(format(workflowHistoryPO.getQuestionnaireColumnValue(), valueIndex)));
    }

    private String updateCommentDate(String commentDate) {
        return Objects.requireNonNull(
                        convertDateFormat(ACTIVITY_COMMENT_DATE_FORMAT, ACTIVITY_COMMENT_DATE_FORMAT_PDF, commentDate))
                .replace(PM, P_M_).replace(AM, A_M_);
    }

    public String getActivityHeaderValue(String title) {
        return getElementText(xpath(format(workflowHistoryPO.getActivityDetails(), title)));
    }

    public String getDescriptionLimitText() {
        return isElementDisplayedNow(workflowHistoryPO.getDescriptionLimitMessage()) ?
                getElementText(workflowHistoryPO.getDescriptionLimitMessage()) : null;
    }

    public String getUploadInputError() {
        return getElementText(
                waitMoment.until(visibilityOfElementLocated(workflowHistoryPO.getUploadFileInputError())));
    }

    public String getTooltipText() {
        return getElementText(workflowHistoryPO.getTooltip());
    }

    public String getCheckIconCSSValue(String user, String state) {
        return getElement(
                By.cssSelector(format(workflowHistoryPO.getCheckIconCSSValue(), user, state))).getCssValue(COLOR);
    }

    public String getHeaderValue(String title) {
        waitLong.until(
                visibilityOfElementLocated(xpath(format(workflowHistoryPO.getWorkflowHistoryHeadedValues(), STATUS))));
        if (title.equals(PageElementNames.DESCRIPTION)) {
            return getElementText(waitShort, workflowHistoryPO.getWorkflowHistoryDescriptionValue())
                    .replace(PageElementNames.DESCRIPTION + COLON + StringUtils.SPACE, EMPTY);
        } else {
            return getAttributeOrText(waitShort.until(
                                              presenceOfElementLocated(xpath(format(workflowHistoryPO.getWorkflowHistoryHeadedValues(), title)))),
                                      TITLE_ATR);
        }
    }

    public String getUploadFieldValue() {
        return getElementText(workflowHistoryPO.getUploaded());
    }

    public String getUploadButtonName() {
        return getElementText(waitLong, workflowHistoryPO.getButtonBrowse());
    }

    public String uploadFile(String fileName) {
        if (isElementDisplayed(workflowHistoryPO.getCancelUpload())) {
            clickOn(workflowHistoryPO.getCancelUpload());
        }
        getElement(workflowHistoryPO.getUpload()).sendKeys(getFilePath(fileName));
        return fileName;
    }

    public String getEditCommentLengthMessage() {
        return getElementText(workflowHistoryPO.getEditCommentLengthMessage());
    }

    public String getEditCommentText() {
        return getElementText(workflowHistoryPO.getEditCommentTextArea());
    }

    public String getAddCommentText() {
        return getElementText(workflowHistoryPO.getFieldComment());
    }

    public String getEditedCommentMessage(String createdDate) {
        return getElementText(xpath(format(workflowHistoryPO.getEditedCommentMessage(), createdDate)));
    }

}