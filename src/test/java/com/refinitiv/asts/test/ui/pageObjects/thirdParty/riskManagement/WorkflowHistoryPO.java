package com.refinitiv.asts.test.ui.pageObjects.thirdParty.riskManagement;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class WorkflowHistoryPO extends BasePO {

    private final By workflowHistoryTab = xpath("//*[@id='WorkflowHistory-Header']//*[text()='Workflow-HISTORY']");
    private final String workflowHistoryHeadedTitles =
            "//*[contains(@data-cid, 'PrimaryDetails')]//p[contains(., '%s')] " +
                    "| //*[contains(@data-cid, 'PrimaryDetails')]//p/span[contains(., '%<s')]";
    private final String workflowHistoryHeadedValues =
            "//*[contains(@data-cid, 'PrimaryDetails')]//p[contains(., '%s')]/ancestor::div[contains(@id, 'PrimaryDetails')]//span | " +
                    "(//*[contains(@data-cid, 'PrimaryDetails')]//p[contains(., '%<s')]/ancestor::div[contains(@id, 'PrimaryDetails')]//p)[2]";
    private final By workflowHistoryDescriptionValue =
            xpath("//*[contains(@data-cid, 'PrimaryDetails')]//p/span[contains(., 'Description')]/ancestor::p");
    private final String workflowHistoryActivityGroupsTitles =
            "//*[contains(@id, 'ActivityTable')]//th//span[text()='%s']";
    private final String workflowHistoryActivityGroupsValues =
            "//*[contains(@id, 'SecondaryDetails-ActivityTable')]//td[text()='%s']" +
                    "/ancestor::tr//span[text()='%s']";
    private final String activity = "//td//*[contains(., '%s')]";
    private final String activityDetails =
            "(//*[@role='region']//*[contains(@id,'%s')]//p)[2] | //p[contains(., 'Last Update')]/../following-sibling::div//p";
    private final By noAvailableData =
            xpath("//*[contains(., 'Workflow')]/ancestor::div[@role='button']/following-sibling::div//*[contains(., 'No Available Data')]");
    private final String checkIcon =
            "//*[contains(@id,'%s')]//*[contains(., '%s')]/../..//*[contains(@class,'MuiSvgIcon') and @title='%s']";
    private final String checkIconCSSValue = "[id*='%s'] [title='%s'] path";
    private final By tooltip = xpath("//*[@role='tooltip']/div");
    private final By workflowHistoryArrowButton = id("risk-management-back-button");
    private final By exportToPdfLink = xpath("//*[text()='EXPORT TO PDF']");
    private final By pdfWorkflowDetails =
            xpath("//*[@data-cid='PrimaryDetails-root']//*[contains(@id, 'PrimaryDetails')]");
    private final By pdfActivitiesGroupList = xpath("//*[@id='SecondaryDetails-ActivityTable']//tbody/tr/td[1]");
    private final By pdfActivitiesNameList = xpath("//*[@id='SecondaryDetails-ActivityTable']//tbody/tr/td[2]");
    private final String pdfActivityDetails =
            "//*[contains(., '%s')]/ancestor::div[@data-cid='TableRowDetails-root']/div/div/following-sibling::div//*[contains(@id,'ActivityDetails')]";
    private final String questionnaireActionButton =
            "//span[contains(., '%s')]/ancestor::tr//span[text()='%s']/ancestor::button";
    private final By questionnaireDetailsTableRows = xpath("//p[text()='Questionnaire Details']/../../../..//tbody/tr");
    private final String questionnaireColumnValue = "td[%s]";

    //Activity Attachments
    private final By fieldUpload = xpath("(//*[@data-cid=\"activity-attachements\"]//input)[2]");
    private final By upload = xpath("//*[@data-cid='activity-attachements']//input");
    private final By buttonBrowse =
            xpath("//*[@data-cid=\"activity-attachements\"]//*[contains(@data-cid,\"FileUpload\")]//button");
    private final By description = xpath("//*[@data-cid='activity-attachements']//textarea");
    private final By buttonAttachmentCancel = id("activity-attachements-cancel");
    private final By buttonAttachmentUpload = id("activity-attachements-add");
    private final By buttonAttachmentUploadDisabled =
            xpath("//*[@id=\"activity-attachements-add\" and contains(@class, 'disabled')]");
    private final By uploaded = xpath("//*[@data-cid='activity-attachements']//*[contains(@class, 'MuiCard')]");
    private final By activityAttachmentTable = xpath("//*[contains(@class, 'siAttachmentTable')]");
    private final By activityAttachmentTableHeaders = xpath("//*[contains(@class, 'siAttachmentTable')]//th");
    private final By activityAttachmentTableValues = xpath("//*[contains(@class, 'siAttachmentTable')]//tbody/tr");
    private final By attachmentTableFileName = xpath("td[1]");
    private final By attachmentTableDescription = xpath("td[2]");
    private final By attachmentTableUploadDate = xpath("td[3]");
    private final String downloadAttachmentButton =
            "(//*[contains(., '%s')]/../following-sibling::td//*[contains(@class, 'MuiSvgIcon')][@title='Download'])";
    private final String deleteAttachmentButton =
            "//*[contains(., '%s')]/../following-sibling::td//*[contains(@class, 'MuiSvgIcon') and  @title='Delete'] | (//*[contains(., '%<s')]/../following-sibling::td//*[contains(@class, 'MuiSvgIcon')])[2]";
    private final By descriptionLimitMessage = xpath("//label[text()='Description']/following-sibling::p");
    private final By uploadFileInputError = cssSelector("[data-cid='FileUpload-root'] p");
    private final String attachmentColumnName = "//th//span[text()='%s']";
    private final String attachmentTableRowValue = "td[%s]";
    private final By pdfAttachment = xpath("//*[@data-cid='activity-attachements']//td");
    private final By pendingRow = xpath("//td/span[text()='Pending']");
    private final By uploadedDataCells = xpath("//div[@data-testid='table-testid']//tr/td[3]");

    //Activity Comments
    private final By fieldComment = id("comment");
    private final String commentButtonWithName =
            "//*[@id='undefined-CommentsComponent']//span[contains(., '%s')]/ancestor::button";
    private final String editCommentButton = "//*[@data-testid='comment-body']//span[text()='%s']/..";
    private final By buttonCommentDisabled =
            xpath("//*[@id='undefined-CommentsComponent']//button[contains(@class, 'disabled ')]/span[contains(., 'Comment')]");
    private final By pdfComment =
            xpath("//*[@id='undefined-CommentsComponent']/div[contains(@class, 'MuiGrid-item')]//p");
    private final String commentActionButton = "[data-testid='%s-button']";
    private final String commentText = "//*[@data-testid='comment-body']//p[text()='%s']";
    private final By editCommentLengthMessage = xpath("(//*[@for='comment'])[2]/../following-sibling::p");
    private final By editCommentTextArea = xpath("(//textarea[@id='comment'])[2]");
    private final String editedCommentMessage = "//p[text()='%s']/following-sibling::p";
    private final String commentTextButton = commentText + "//span[text()='%s']/..";
    private final String commentSectionButton = "//*[contains(@class, 'MuiGrid-item')]//span[text()='%s']/..";
    private final By commentSectionHeader = xpath("//p[text()='Comments']/../..");
    private final By commentsText = xpath("//*[@data-testid='comment-body']/div[2]/p");
    private final By cancelUpload = cssSelector("[data-qid='FileUpload-button-cancel']");

    public WorkflowHistoryPO(WebDriver driver) {
        super(driver);
    }

}