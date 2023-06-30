package com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class ActivityInformationDisplayPO extends BasePO {

    public ActivityInformationDisplayPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

    private final By activityInformationPage =
            xpath("//h6[contains(., \"" + translator.getValue("thirdPartyInformation.activityInformationSection") +
                          "\")]/ancestor::div//*[contains(@class,'MuiGrid')]");
    private final String activityInformationFieldValue =
            "//h6[contains(., \"" + translator.getValue("ddoActivity.activityInformation") +
                    "\")]/ancestor::div//label[contains(., \"%s\")]/..//input | " +
                    "(//h6[contains(., \"" + translator.getValue("ddoActivity.activityInformation") +
                    "\")]/ancestor::div//label[contains(., \"%<s\")]/..//textarea[1])[1]";
    private final By editButton = id("edit-button");
    private final By activityBackButton =
            xpath("//*[contains(., \"" + translator.getValue("activity.backButton") + "\")]/ancestor::button");
    private final By saveActivityButton = xpath("//*[contains(., 'Save')]/parent::button");
    private final By cancelButton = xpath("(//*[contains(., 'Cancel')]/parent::button)[3]");
    private final By assigneeInput = xpath("//input[@name='assignee']");
    private final By assigneeList = id("assignee-popup");
    private final By assessmentInput = xpath("//*[text()='Assessment']/parent::div//input");
    private final By assessmentInputOpenButton =
            xpath("//*[text()='Assessment']/following-sibling::div//button[@title='Open' or @title='Close']");
    private final String activityButtonWithName = "(//button/span[contains(., '%s')])[1]";
    private final By statusInput = xpath("//input[@name='status']");
    private final By statusInputButton =
            xpath("//input[@name='status']/following-sibling::div//button[@title='Open' or @title='Close']");
    private final String tableRowValue = "td[%s]";
    private final String sectionHeader = "//p[text()='%s']/../..";
    private final String fieldMessage = "//label[text()='Assessment']/..//p";
    private final String field = "//label[text()='%s']/..//input | //label[text()='%<s']/..//textarea";
    private final String reviewTaskSection =
            "//*[text()='Review Task']/ancestor::div[contains(@class, 'MuiButtonBase') and contains(@class, 'MuiAccordionSummary')]";
    private final String pageWithName =
            "(//nav)[1]//*[text() and contains(translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'), '%s')]";
    private final String headerStrongText = "//*[@class='fr-view']//strong[text()='%s']";
    private final String headerTextWithStyle = "//*[@class='fr-view']//p[text()='%s' and @style='%s']";
    private final String invalidLabel = "//span[contains(., '%s')]/ancestor::td/div//span[text()='Invalid']";

    /**
     * Locators for Activity with Order details
     */
    private final By orderDetailsBtn =
            xpath("//*[text()[contains(., 'SI-')]]/.. | //*[text()[contains(., 'Order Details:')]]/..");
    private final By createOrderButton =
            xpath("//*[contains(., \"" + translator.getValue("ddoActivity.createOrderButton") +
                          "\")]/parent::button");
    private final By declineButton =
            xpath("//*[contains(., \"" + translator.getValue("ddoActivity.declineOrderButton") +
                          "\")]/parent::button");
    private final By declineConfirmationPopUp = xpath("//*[@role=\"dialog\"]//h6[contains(., \"" +
                                                              translator.getValue("ddoActivity.declineOrderButton") +
                                                              "\")]");
    private final By decliningWarningMsg =
            xpath("//*[@role=\"dialog\"]//p[contains(., 'Are you sure you want to decline order?')]");
    private final By declineConfirmationPopUpCancelBtn = id("AlertDialog-cancel");
    private final By declineConfirmationPopUpProceedBtn = id("AlertDialog-ok");

    /**
     * Questionnaire Details table - Assign Questionnaire
     */
    private final String questionnaireDetailsSection =
            "//p[contains(., \"" + translator.getValue("questionnaire.questionnaireDetails") +
                    "\")]/ancestor::div[@role=\"button\"]";
    private final By questionnaireDetailsTableRows =
            xpath(questionnaireDetailsSection + "/following-sibling::div//tbody/tr");
    private final By questionnaireDetailsName = xpath("td[1]");
    private final By questionnaireDetailsStatus = xpath("td[2]");
    private final By questionnaireDetailsAssignee = xpath("td[3]");
    private final By questionnaireDetailsReviewer = xpath("td[4]");
    private final By questionnaireDetailsReviewerAssessment = xpath("td[5]");
    private final By questionnaireDetailsScore = xpath("td[6]");
    private final By questionnaireDetailsCategory = xpath("td[7]");
    private final By questionnaireDetailsActions = xpath("td[8]");
    private final By assignNewButton = xpath("//*[@data-testid='assign-new-testid']");
    private final By questionnaireActionsButton = xpath("//*[contains(., 'Actions')]/parent::button");
    private final By questionnaireActionsRevertToInReviewButton =
            xpath("//*[@id=\"actions-menu\"]//li[contains(., 'Revert to In Review')]");
    private final String questionnaireActionsButtonWithName =
            "//*[@id='actions-menu' and not(contains(@style, 'hidden'))]//li[contains(., '%s')]";
    private final By questionnaireActionsButtons = xpath("//*[@id='actions-menu']//li");
    private final String questionnaireButtonOfActivityWithName =
            "//*[contains(., '%s')]/../following-sibling::td//span[text()='%s']/..";
    private final String questionnaireActionsButtonOfActivityWithName =
            "//span[contains(., '%s')]/../following-sibling::td/button";
    private final String questionnaireColumnValue = "td[%s]";
    private final By reviewButton = cssSelector("[name=reviewBtn]");
    private final By noAvailableDataTitle = xpath("//*[text()='Questionnaire Details']/ancestor::div[contains(@class, 'MuiAccordion-root')]//h6[text()='No Available Data']");


    /**
     * Questionnaire Details table - Questionnaire Assigned
     */
    private final By questionnaireState = xpath("td[3]");
    private final String questionnaireStateLink =
            "//td//*[contains(., \"%s\")]/../..//*[contains(., \"%s\")]/parent::button";
    private final By questionnaireAnswerButton = xpath("//*[contains(., 'Answer')]/parent::button");
    private final By questionnaireReviewButton = xpath("//*[contains(., 'Review')]/parent::button");

    /**
     * Approvers table
     */
    private final String approversSectionTitle =
            "//p[contains(., \"" + translator.getValue("thirdPartyInformation.approversSection") +
                    "\")]/ancestor::div[@role='button']";
    private final By approversTableRow = xpath(approversSectionTitle + "/following-sibling::div//tbody/tr");
    private final By approversTableColumns =
            xpath("//p[contains(., 'Approvers')]/ancestor::div[@role='button']/following-sibling::div//th");
    private final String assignedToColumnValue = "td[1]//span";
    private final String lastUpdateColumnValue = "td[2]";
    private final By approveButton = xpath(approversSectionTitle + "/following-sibling::div//td[3]//button[1]");
    private final String actionColumn = "td[3]";
    private final String actionButtons = "//td//span[text()='%s']/ancestor::tr//td[3]//button";
    private final String actionButton =
            "//td//span[text()='%1$s']/ancestor::tr//td[3]//span[text()='%2$s']/ancestor::button | " +
                    "//td//span[@title='%1$s']/ancestor::tr//td[3]//span[text()='%2$s']/ancestor::button";
    private final String statusColumn = "td[4]";
    private final By assignQuestionnaireButton =
            xpath("//*[text()=\"" + translator.getValue("activity.assignQuestionnaire") + "\"]/parent::button");
    private final String approverActionButton =
            "//p[text()='" + translator.getValue("thirdPartyInformation.approversSection") +
                    "']/ancestor::div[@role='button']/following-sibling::div//*[text()='%s']/ancestor::tr//*[text()='%s']/parent::button";
    private final By assignedToDropdownInput =
            xpath("//*[@object-list='vm.users']//input | //input[@id='approver-id']");
    private final String assignedToDropdownItem = "//li[contains(@id, '-option-')]//*[contains(.,'%s')]";
    private final By reassignForApprovalButton =
            xpath("//*[contains(., 'Re-assign for Approval')]/parent::button");

    /**
     * Reviewers table
     */
    private final By reviewersSectionTitle = xpath("//*[text()='Reviewers']/../../..");
    private final By reviewersTableRows = xpath("//*[text()='Reviewers']/../../../..//tbody/tr");
    private final String reviewersTableRowValue = "//*[text()='Reviewers']/../../../..//tbody/tr[%s]/td[%s]";
    private final String rowWithName =
            "//*[text()='Reviewers']/ancestor::div[contains(@class, 'MuiPaper')][1]//tbody//td//span[text()='%s']/ancestor::tr/";
    private final String reviewEditButton = rowWithName + "td[5]//*[name()='svg'][1]";
    private final String reviewDeleteButton = rowWithName + "td[5]//*[name()='svg'][2]";
    private final String reviewActionButton = rowWithName + "td[3]//span[text()='%s']";
    private final By allReviewButtons = xpath("//*[contains(., 'Review')]/parent::button");
    private final By reviewAssignUserInput =
            xpath("//*[@selected-object='vm.toUser']//input | //input[@id='reviewer' or @id='reviewer-id']");
    private final By reviewAssigneeDropDownItems =
            xpath("//ul[@id='reviewer-popup' or @id='reviewer-id-popup']/li[@aria-disabled='false'] ");
    private final By adHocReviewersSection = xpath("//*[contains(.,'Reviewers')]");
    private final String reviewActionAdHocButton =
            "//td/*[contains(.,'%s')]/../../td//*[contains(., '%s')]/ancestor::button";
    private final By adHocReviewersTableRows = xpath("//*[@process-type='REVIEW']//tbody/tr");
    private final String adHocReviewersTableRowValue =
            "//*[@process-type='REVIEW']//tbody/tr[%s]//td[%s]";

    /**
     * Review Task table
     */
    private final String reviewTaskActionButton =
            "//p[text()='Review Task']/../../../..//tbody/tr[%s]//button[@aria-controls=\"actions-menu\"]";
    private final String reviewTaskReviewButton = "//tr[%s]//*[@name='reviewBtn']";
    private final String reviewTaskActionTypeButton = "//li[text()='%s']";
    private final String reviewTaskStatus = "//tbody/tr[%s]/td[4]//span";
    private final By reviewTaskTableRows = xpath("//*[text()='Review Task']/../../../..//tbody/tr");
    private final By reviewTaskTableFirstRowName =
            xpath("//*[text()='Review Task']/../../../..//tbody/tr[1]/td[1]/span");
    private final By reviewTaskTableColumns = xpath("//*[text()='Review Task']/../../../..//thead//th");
    private final String reviewTaskTableRowValue = "//*[text()='Review Task']/../../../..//tbody/tr[%s]/td[%s]";

}