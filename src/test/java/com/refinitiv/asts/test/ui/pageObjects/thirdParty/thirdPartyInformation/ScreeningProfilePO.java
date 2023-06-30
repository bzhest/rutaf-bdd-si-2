package com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class ScreeningProfilePO extends BasePO {

    public ScreeningProfilePO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

    private final By backToScreeningResultsButton =
            xpath("//button/following-sibling::p[contains(.,\"" +
                          translator.getValue("thirdPartyInformation.screening.screeningResults") + "\")]");
    private final By exportToPdfButton = id("export-profile-to-pdf");
    private final String nameElement = "//span[text()='%s']/ancestor::fieldset/preceding-sibling::span";
    private final String textElement = "//p[text()='%s']/ancestor::span/following-sibling::p";
    private final String tabButton = "//*[@role='tablist']/button//*[contains(.,'%s')]/ancestor::button";
    private final String screeningTableHeaders = "//*[text()='%s']/ancestor::li//thead/tr/th/span";
    private final String screeningTableRow = "//*[text()='%s']/ancestor::li//tbody/tr[%s]/td/*";
    private final String screeningTableRows = "//*[text()='%s']/ancestor::li//tbody/tr/td/*";
    private final String keywordsRow = "[role=tabpanel] tbody>tr:nth-child(%s)>td>span";
    private final String connectionsRow = "[role=tabpanel] tbody>tr:nth-child(%s)>td:nth-child(%s)>span";
    private final String aliasRows = "//*[text()='%s']/ancestor::li//p//div";
    private final By furtherInformationSectionNames = xpath("//*[@role='tabpanel']//li//span//p[1]");
    private final String furtherInformationSectionText =
            "//*[@role='tabpanel']//li//p[text()='%s']/ancestor::span/following-sibling::p";
    private final By resolutionType =
            xpath("//*[contains(.,\"" + translator.getValue("thirdPartyInformation.screening.resolutionType") +
                          "\")]/parent::div");
    private final String resolutionButton =
            "//*[contains(.,\"" + translator.getValue("thirdPartyInformation.screening.resolutionType") +
                    "\")]/parent::div/following-sibling::button[%s]";
    private final String resolutionList =
            "//*[text()=\"" + translator.getValue("thirdPartyInformation.screening.resolutionType") +
                    "\"]/parent::div/following-sibling::button//*[name()='svg']";
    private final By tagsButton = xpath("//*[@name='add-resolution-switch-redflag']/ancestor::label");
    private final By tagAsRedFlagSwitch =
            xpath("//*[@name='add-resolution-switch-redflag']/ancestor::span[contains(@class, 'MuiButtonBase')]");
    private final String tableRowList = "//*[text()='%s']/ancestor::li//tbody/tr";
    private final String emptyTable =
            "//*[text()='%s']/ancestor::span/following-sibling::*//*[contains(., 'No Available Data')]";
    private final By externalSourcesList =
            xpath("//*[text()='EXTERNAL SOURCES']/ancestor::span/following-sibling::p//a");
    private final By thirdPartyInformationBackButton = id("third-party-information-back-button");
    private final By thirdPartyOtherNamesInformationBackButton =
            xpath("//div[@id='MediaCheckOtherNameTable-MediaCheckOtherNameModal']//button[@id='third-party-information-back-button']");
    private final By saveCommentButton = cssSelector("[class*=MuiDialogActions] [id^=add]");
    private final By cancelCommentButton = cssSelector("[class*=MuiDialogActions] [id^=cancel]");
    private final By recordUpdateDateList = xpath("//*[text()='RECORD UPDATE']/parent::div//tbody//td/*");
    private final By addCommentButton = xpath("//*[contains(@id, 'Comments')]//span[text()='Comment']/parent::button");
    private final By keywordsTableColumnsList =
            xpath("//*[text()='Keywords']/ancestor::button[contains(@class, 'Mui-selected')]" +
                          "/ancestor::div[contains(@class, 'MuiTabs-root')]/parent::div//thead//th");
    private final By keywordsTableRowList =
            xpath("//*[text()='Keywords']/ancestor::button[contains(@class, 'Mui-selected')]" +
                          "/ancestor::div[contains(@class, 'MuiTabs-root')]/parent::div//tbody//tr");
    private final By columnsList = xpath("//thead//th");
    private final By rowList = xpath("//tbody//tr");
    private final By addReviewerCommentButton =
            xpath("//button[@id='add-reviewer-button-id']//span[contains(., \"" +
                          translator.getValue("thirdPartyInformation.screening.addReviewer") + "\")]/..");
    private final By addReviewerButton = xpath("//*[text()='ADD REVIEWER']/parent::button");
    private final By reviewButton = xpath("//*[text()='REVIEW']/parent::button");
    private final By reviewersInput = cssSelector(
            "[id*=Reviewer] input#reviewer, [id*=Reviewer] input#AssignReviewer-NewSelectInput, #ReviewerDetails-NewSelectInput");
    private final By dueDateInput = cssSelector("[id*=AssignReviewer] input[id*=DateInput]");
    private final By saveReviewerButton = xpath("//button/span[text()='Save']");
    private final By createAdHocActivityButton = id("AssignReviewer-Save-CreateAdhoc-Button");
    private final By saveReviewerEditButton = id("ReviewerDetails-ActionButtons-save-button");
    private final String reviewerType = "//*[contains(@id, AssignReviwer)]//*[text()='%s']/preceding-sibling::span";
    private final By reviewStatus = xpath("//p[text()='Review Status:']/following-sibling::p");
    private final By reviewer = cssSelector("[id*=ReviewerDetails] input");
    private final By reviewerText = xpath("//p[text()='Reviewer:']/following-sibling::p | //input[@id='reviewer']");
    private final By reviewerAssignedBy = xpath("//*[text()='Assigned by:']/following-sibling::p");
    private final String reviewerRadioButton =
            "//*[@id='ProfileDetails-AssignReviewer-ActivityTable']//tbody//td/span[@title='%s']/../../td//span";
    private final By legalNotice = xpath("//p[text()='Legal Notice']");
    private final By legalNoticeText = id("ProfileDetailsFooter-legal-notice");
    private final By reviewerDetails = id("ProfileDetailsReviewer-ReviewerDetails");
    private final String tabOnScreeningResults = "//div[@aria-label='scrollable']//span[text()='%s']";
    private final By reviewerClearButton = cssSelector("button[aria-label='Clear']");
    private final By worldCheckLogo = xpath("//img[contains(@alt, 'refinitiv-world-check')]");
    private final By headersDetailsList = cssSelector("[id^=header-detail]");
    private final By tabDataList =
            xpath("//*[@role='tabpanel']//li[not(.//table)]/div | //*[@role='tabpanel']//table/ancestor::div[contains(@class, 'MuiListItemText')]/p");
    private final By connectionsTabDataList =
            xpath("//*[@role='tabpanel']//thead//tr | //*[@role='tabpanel']//table//td/span");
    private final By keywordsTabDataList =
            xpath("//*[@role='tabpanel']//table/ancestor::div[contains(@class, 'MuiTableContainer') and not(./ancestor::div[contains(@class, 'MuiListItemText')])]");
    private final By sourcesTabDataList = xpath("//*[@role='tabpanel']//li/div/p");
    private final By riskLevelValue = xpath("//*[contains(., 'Risk Level')]/parent::*/following-sibling::*");
    private final By reasonValue = xpath("//*[contains(., 'Reason')]/parent::*/following-sibling::*");
    private final By legalNoticeLink = id("legal-notice-link");
    private final By tagAsRedFlag = xpath("//span[contains(@class, 'MuiButtonBase')]");

    /**
     * Comments section
     **/
    private final String commentsSection =
            "//*[text()=\"" + translator.getValue("thirdPartyInformation.screening.comments") +
                    "\"]/ancestor::div[contains(@class, 'MuiPaper') and contains(@class, 'MuiAccordion')]";
    private final By commentNextSection = xpath(commentsSection + "/../following-sibling::div");
    private final By comments =
            xpath("//h6[text()=\"" + translator.getValue("thirdPartyInformation.screening.comments").toUpperCase() +
                          "\"]/parent::*/following-sibling::*[@data-testid='comment-body']");
    private final By commentText = xpath("div[2]/p");
    private final By commentAuthor = xpath("div[1]/p[1]");
    private final String commentForAuthor = "(//p[text()='%s']/../../div/p)[1]";
    private final String commentForAuthorPosition = "//div[@data-testid='comment-body'][%s]//p[text()='%s']";
    private final By commentDate = xpath("div[1]/p[2]");
    private final By commentDeleteButton = cssSelector("button[title=Delete]");
    private final By commentEditButton = cssSelector("button[title=Edit]");
    private final By commentsFurtherInformation = xpath("//p[text()='ADDITIONAL COMMENTS']/following-sibling::p");
    private final By commentButton = cssSelector("button[data-testid='add-comment-button']");
    private final By commentTextArea = id("comment");
    private final String commentWithText = commentsSection + "//p[contains(., '%s')]";
    private final String commentWithTextPosition = "//div[@data-testid='comment-body'][%s]/div[2]/p[text()='%s']";
    private final String commentsButtonWithName = commentsSection + "//span[text()='%s']/parent::button";
    private final String commentEditedLabel =
            "//p[text()='%s']/ancestor::div[@data-testid='comment-body']/div[1]/p[3][text()='Edited']";
    private final String commentEditedLabelPosition =
            "//p[text()='%s']/ancestor::div//div[@data-testid='comment-body'][%s]//p[3][text()='Edited']";
    private final By commentsSectionDetailPage =
            xpath("//*[text()='Comments']/ancestor::div[contains(@class, 'MuiAccordion-root')]");
    private final By commentAccordionButton = xpath("//div[contains(@class, 'MuiAccordion-root')]//*[name()='svg']");
    private final String commentSeeMoreButton =
            "//div[@data-testid='comment-body'][%s]//span[contains(text(),'See more')]";
    private final String commentSeeLessButton =
            "//div[@data-testid='comment-body'][%s]//span[contains(text(),'See less')]";
    private final By commentShowMoreButton = xpath("//span[text()='Show More']");
    private final By commentShowAllCommentButton = xpath("//span[text()='Show all comments']");
    private final By commentHideCommentsButton = xpath("//span[text()='Hide comments']");
    private final By commentCancelButton = xpath("//button[@data-testid='cancel-comment-button']");
    private final By commentLengthMessage = xpath("//*[@id='CommentsV2-container']/div/div[1]/div/p/span");

}
