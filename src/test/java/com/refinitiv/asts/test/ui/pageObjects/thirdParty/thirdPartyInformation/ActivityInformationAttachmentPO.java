package com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;

@Getter
public class ActivityInformationAttachmentPO extends BasePO {

    public ActivityInformationAttachmentPO(WebDriver driver) {
        super(driver);
    }

    private final By
            attachmentsBlock =
            xpath("//*[text()='Attachments']/ancestor::*[contains(@class, 'MuiAccordionSummary-root')]");
    private final By uploadFile = cssSelector("[data-cid=FileUpload-root] [class*=underline] input");
    private final By uploadFileCrossButton =
            cssSelector("[data-cid=activity-attachements] [data-qid=FileUpload-button-cancel]");
    private final By description = cssSelector("[data-cid=activity-attachements] textarea");
    private final By cancelAttachmentButton = cssSelector("#activity-attachements-cancel");
    private final By uploadAttachmentButton = cssSelector("#activity-attachements-add");
    private final By browseButton = cssSelector("[data-cid=activity-attachements] [data-cid=FileUpload-button-browse]");
    private final By fileWarningMessage = cssSelector(".siAttachmentsContainer [data-cid^=FileUpload] p");
    private final By descriptionLimitMessage = cssSelector(".siAttachmentsContainer [class^=MuiFormHelperText]");
    private final By fileSizeLimitMessage = cssSelector(".siAttachmentsContainer [class^=MuiPaper]~p");

    /**
     * Attachment table
     */
    private final String headerColumn =
            "//*[contains(@class, 'siAttachmentTable')]//thead//th//span[contains(., '%s')]";
    private final By sectionHeader = xpath("//p[text()='Attachments']");
    private final By headerColumnName =
            xpath("//p[text()='Attachments']/../../../..//thead/tr/th/span");
    private final By tableRow = cssSelector(".siAttachmentTable tbody>tr");
    private final String tableRowWithNumber = ".siAttachmentTable tbody>tr:nth-child(%s)";
    private final By rowFileName = cssSelector("td:nth-child(1)");
    private final By rowDescription = cssSelector("td:nth-child(2)");
    private final By rowUploadDate = cssSelector("td:nth-child(3)");
    private final By rowDownloadIcon = cssSelector("td:nth-child(4) svg:nth-child(1)");
    private final By rowDeleteIcon = cssSelector("td:nth-child(4) svg:nth-child(2)");
    private final By
            noAvailableDataTitle = xpath("//*[contains(@class, 'siAttachmentTable')]//h6[text()='No Available Data']");
    private final By collapseExpandIcon = xpath("//*[text()='Attachments']/preceding-sibling::*[name()='svg']");

}
