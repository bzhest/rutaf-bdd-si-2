package com.refinitiv.asts.test.ui.pageObjects.thirdParty.riskManagement;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static java.lang.String.format;
import static org.openqa.selenium.By.id;
import static org.openqa.selenium.By.xpath;

@Getter
public class RiskManagementPO extends BasePO {

    public RiskManagementPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

    private final By riskManagementHeader = id("RiskManagementDetails-Header");
    private final String table = "//*[text()='%s']/ancestor::*[contains(@class, 'MuiPaper') " +
            "and contains(@class, 'MuiAccordion-root')]//table";
    private final String workflowTable = format(table, "Workflow");
    private final String activityTable = format(table, "Ad Hoc Activity");
    private final By workflowDetails = xpath(workflowTable + "/tbody//td");
    private final By workflowDetailsRows = xpath(workflowTable + "/tbody//tr");
    private final By workflowTableHeaders = xpath(workflowTable + "/thead//th");
    private final By activityTableHeaderNames = xpath(activityTable + "/thead//th");
    private final By riskManagementCancelButton =
            xpath("(//button[@type='button' and not(@id)]/span[contains(text(), 'Cancel')])[2]");
    private final String activityButtonWithName =
            "//button[@type='button' and (contains(@id, '%s') or not (@id))]/span[contains(text(), '%<s')]";
    private final String activityPageWithName = "//*[@id='AdHocActivity-Header']/parent::*//h6[text()='%s']";
    private final String requiredField =
            "//*[contains(text(), '%s')]/ancestor::fieldset/preceding-sibling::input[@required] | //*[contains(text(), '%<s')]/ancestor::fieldset/preceding-sibling::textarea[@required]";
    private final String redAsterisk = "//*[contains(text(), '%s')]/ancestor::fieldset" +
            "/ancestor::div[contains(@class, 'MuiTextField')]//span[contains(@class, 'asterisk')]";
    private final String errorMessage =
            "//*[contains(text(), '%s')]/ancestor::fieldset/parent::*/following-sibling::*[text()='This field is required']";
    private final String fieldErrorClass =
            "//*[contains(text(), '%s')]/ancestor::fieldset/preceding-sibling::input[@aria-invalid='true'] " +
                    "| //*[contains(text(), '%<s')]/ancestor::fieldset/preceding-sibling::textarea[@aria-invalid='true']";
    private final String clearButton = "//*[text()='%s']/following-sibling::div//button[@aria-label='Clear']";
    private final String inputField =
            "//*[contains(text(), '%1$s')]/ancestor::fieldset/preceding-sibling::input | " +
                    "//*[contains(text(), '%1$s')]/../following-sibling::div//input | " +
                    "//*[contains(text(), '%1$s')]/..//input | " +
                    "//*[contains(text(), '%1$s')]/..//following-sibling::div//textarea[1]";
    private final By activityNameField = xpath("//input[@id='activity-name' or @id='add-activity-name']");
    private final By descriptionField = xpath("//*[@id='description' or @id='add-description']");
    private final String ableDueDate =
            "(//button[contains(@class, 'MuiPickersDay-day') and not(contains(@class, 'Disabled'))])[%s]";
    private final By dueDateDateTrigger = xpath("//*[contains(@id, 'due-date')]/parent::*//button");
    private final String emptyTableText = "//p[text()='%s']/ancestor::div[@role='button']/following-sibling::div//h6";
    private final String activityNameInTable =
            "//*[text()='ADD ACTIVITY']/../../..//tbody/tr/td/span[contains(., '%s')]";
    private final String activityWithNameRowInTable = activityTable + "/tbody//span[text()='%s']/ancestor::tr";
    private final String actionActivityIconWithNameRow = activityTable + "/tbody//span[text()='%s']/ancestor::tr" +
            "//*[name()='svg' and @title='%s']";
    private final By activityTableRows = xpath(activityTable + "/tbody//tr");
    private final By rowActionIcons = xpath("//tr/td/div/*");
    private final String activityTableRowValue = "td[%s]";
    private final By addReviewerButton = id("addReviewerSaveButton");
    private final By cancelReviewerButton = id("addReviewerCancelButton");
    private final By reviewersTable = xpath("//p[text()='Reviewers']/../../../..//table");
    private final By reviewerInReviewersTable = xpath("//p[text()='Reviewers']/../../../..//td[1]");
    private final String editReviewerButton =
            "//p[text()='Reviewers']/ancestor::*[contains(@class, 'MuiAccordion')]//*[contains(., '%s')]" +
                    "/parent::td/following-sibling::td//*[name()='svg'][1]";
    private final String reviewerEditModeButton =
            "//*[text()='Reviewer']/ancestor::*[contains(@class, 'MuiAccordionDetails')]//button/span[text()='%s']";
    private final String deleteReviewerButton =
            "//p[text()='Reviewers']/ancestor::*[contains(@class, 'MuiAccordion')]//*[contains(., '%s')]" +
                    "/parent::td/following-sibling::td//*[name()='svg'][last()]";
    private final By adHocActivitySaveButton = id("addActivitySaveButton");
    private final String rowActionButtons = "//*[@data-cid='Adhoc-TableAction-root']/*[%s]";
    private final String rowActionButton = "//td//span[text()='%s']/ancestor::tr" + rowActionButtons;
    private final String workflowRow = "//td[1]//*[text()='%s']/ancestor::tr//*[text()='%s']";

    //    Risk Remediation section
    private final String riskRemediationTab = "//*[@role='tab']//*[contains(text(), '%s')]/..";
    private final By backButton = id("third-party-information-back-button");
    private final By breadcrumb = xpath("//*[contains(text(), 'Risk Remediation')]");
    private final String breadcrumbBackIcon = "//*[contains(text(), '%s')]/..//button";

    //    Risk Remediation section - Media Check
    private final By riskRemediationMediaCheckTableColumns = xpath("//*[contains(@id,'MCScreeningTab')]//th");
    private final By riskRemediationMediaCheckTableRow = xpath("//*[contains(@id, 'MCScreeningTab')]//tbody//tr");
    private final By riskRemediationTabs = xpath("(//div[@role=\"tablist\"])[2]/button");
    private final By riskRemediationMessage =
            xpath("//p[text()='Risk Remediation']/ancestor::div[contains(@class,'Mui-expanded')]//*[contains(@class, 'MuiTableContainer')]//h6");
    private final By riskRemediationTableRows =
            xpath("//p[text()='Risk Remediation']/ancestor::div[contains(@class,'Mui-expanded')]//tbody/tr");
    private final String riskManagementSection = "//p[text()='%s']/ancestor::div[@aria-expanded]";
    private final By sourceValue = xpath("td[1]");
    private final By searchTermValue = xpath("td[2]");
    private final By tagAsRedFlagRecordValue = xpath("td[3]");
    private final By redFlagDateValue = xpath("td[4]");
    private final By sourceValues = xpath("//*[contains(@id,'MCScreeningTab')]//td[1]");
    private final By searchTermValues = xpath("//*[contains(@id,'MCScreeningTab')]//td[2]");
    private final By tagAsRedFlagRecordValues = xpath("//*[contains(@id,'MCScreeningTab')]//td[3]");
    private final By redFlagDateValues = xpath("//*[contains(@id,'MCScreeningTab')]//td[4]");
    private final String mediaCheckColumn = "//*[contains(@id,'MCScreeningTab')]//th[contains(., '%s')]";
    private final String mediaCheckRecord = "//*[contains(@id,'MCScreeningTab')]//tr[contains(., \"%s\")]";

    //    Risk Remediation section - World Check
    private final By riskRemediationWorldCheckTableColumns = xpath("//*[contains(@id,'WCScreeningTab')]//th");
    private final By riskRemediationWorldCheckTableRow = xpath("//*[contains(@id, 'WCScreeningTab')]//tbody//tr");
    private final By wcSourceValue = xpath("td[1]");
    private final By wcSearchTermValue = xpath("td[2]");
    private final By wcTagAsRedFlagRecordValue = xpath("td[3]");
    private final By wcReferenceIdValue = xpath("td[4]");
    private final By wcRedFlagDateValue = xpath("td[5]");
    private final By worldCheckSourceValues = xpath("//*[contains(@id,'WCScreeningTab')]//td[1]");
    private final By worldCheckSearchTermValues = xpath("//*[contains(@id,'WCScreeningTab')]//td[2]");
    private final By worldCheckTagAsRedFlagRecordValues = xpath("//*[contains(@id,'WCScreeningTab')]//td[3]");
    private final By worldCheckReferenceIdValues = xpath("//*[contains(@id,'WCScreeningTab')]//td[4]");
    private final By worldCheckRedFlagDateValues = xpath("//*[contains(@id,'WCScreeningTab')]//td[5]");
    private final String worldCheckColumn = "//*[contains(@id,'WCScreeningTab')]//th[contains(., '%s')]";
    private final String worldCheckRecord = "//*[contains(@id,'WCScreeningTab')]//tr[contains(., '%s')]";

    //    Risk Remediation section - Questionnaire
    private final By riskRemediationQuestionnaireColumns = xpath("//*[contains(@id,'questionnaireTab')]//th");
    private final By riskRemediationQuestionnaireRow = xpath("//*[contains(@id, 'questionnaireTab')]//tbody//tr");
    private final By questionnaireAssignmentId = xpath("td[1]");
    private final By questionnaireName = xpath("td[2]");
    private final By question = xpath("td[3]");
    private final By answer = xpath("td[4]");
    private final By attachment = xpath("td[5]");
    private final By assignee = xpath("td[6]");
    private final By dateSubmitted = xpath("td[7]");
    private final By questionnaireAssignmentIdValues = xpath("//*[contains(@id,'questionnaireTab')]//td[1]");
    private final By questionnaireNameValues = xpath("//*[contains(@id,'questionnaireTab')]//td[2]");
    private final By questionValues = xpath("//*[contains(@id,'questionnaireTab')]//td[3]");
    private final By answerValues = xpath("//*[contains(@id,'questionnaireTab')]//td[4]");
    private final By attachmentValues = xpath("//*[contains(@id,'questionnaireTab')]//td[5]");
    private final By assigneeValues = xpath("//*[contains(@id,'questionnaireTab')]//td[6]");
    private final By dateSubmittedValues = xpath("//*[contains(@id,'questionnaireTab')]//td[7]");
    private final String questionnaireColumn = "//*[contains(@id,'questionnaireTab')]//*[text()='%s']/..";
    private final String questionnaireRecord = "//*[contains(@id,'questionnaireTab')]//*[text()='%s']/../..";
    private final By questionnaireNoAvailableData =
            xpath("//*[contains(@id,'questionnaireTab')]//*[contains(text(), 'No Available Data')]");

    //    Risk Remediation section - Custom Fields
    private final By riskRemediationCustomFieldsTableColumns = xpath("//*[contains(@id,'customFieldsTab')]//th");
    private final By riskRemediationCustomFieldsTableRow = xpath("//*[contains(@id, 'customFieldsTab')]//tbody//tr");
    private final By customField = xpath("td[1]");
    private final By value = xpath("td[2]");
    private final By customFieldValues = xpath("//*[contains(@id,'customFieldsTab')]//td[1]");
    private final By values = xpath("//*[contains(@id,'customFieldsTab')]//td[2]");
    private final String customFieldsColumn = "//*[contains(@id,'customFieldsTab')]//table//th//*[text()='%s']";
    private final String customFieldsRecord = "//*[contains(@id,'customFieldsTab')]//table//td//*[text()='%s']";

}
