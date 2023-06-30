package com.refinitiv.asts.test.ui.pageObjects.thirdParty.questionnaire;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class QuestionnaireAnswerFormPO extends BasePO {

    public QuestionnaireAnswerFormPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

    private final String questionnaireAnswerFormButton = "//div[@spacing]/button/span[text()='%s']/ancestor::button  " +
            "| //div[@spacing]/div/button/span[text()='%<s']/ancestor::button";
    private final String questionnaireOverallAssessmentSpan = "//button//*[contains(text(), '%s')]";
    private final String questionnaireButton = "//*[contains(., \"%s\")]/ancestor::button";
    private final String modalOverallAssessment = "//*[@aria-describedby='alert-dialog-description']";
    private final By modalOverallAssessmentHeader = xpath(modalOverallAssessment + "//h6");
    private final By modalOverallAssessmentMessage = xpath(modalOverallAssessment + "//p");
    private final By commentButton = xpath("//span[text()='comment']/../following-sibling::div//button");
    private final By commentInput = xpath("//*[@role='dialog']//textarea");
    private final By commentSendButton = xpath("//*[@role='dialog']//textarea/..//button[@aria-label='send']");
    private final By commentReplyButton = xpath("//button/span[text()='Reply']");
    private final By commentCounter = xpath("//span[text()='comment']/following-sibling::span/span/span");
    private final String commentModal = "//*[@role='dialog']//div[text()='Comments']";
    private final String commentText = commentModal + "/following-sibling::div//*[text()='%s']";
    private final String commentContainer =
            "(" + commentModal +
                    "/following-sibling::div/div/div/div//div[contains(@class, 'MuiGrid-spacing')]/div[not(contains(@class, 'MuiGrid-grid-lg'))]/..)[%s]";
    private final String commentContainerButton = commentContainer + "//button[@aria-label='%s']";
    private final By revisionButton = xpath("//span[text()='revision']/../following-sibling::div//button");
    private final By addButton = id("add-button-id");
    private final String answerOptionButton = "//span[text()='%s']/ancestor::label//input";
    private final String attachmentButton =
            "//*[@id='simple-tabpanel-%d']//*[contains(text(), '%s')]/../../../" +
                    "following-sibling::button//*[contains(text(), 'Attachment')]";
    private final By uploadFile = xpath("//input[@type='file']");
    private final By uploadFileAddButton = id("proceed");
    private final By uploadFileCrossButton = xpath("//*[@data-qid='FileUpload-button-cancel']");
    private final By cancelQuestionnaireFormButton = xpath("(//span[text()='Cancel']/..)[2]");
    private final By questionnaireDetailsCancelButton = xpath("//span[text()='Cancel']");
    private final String answerFormTab = "//button//*[contains(text(),'%s')]";

    /**
     * =================================================================================================================
     * Questionnaire Activity form
     * =================================================================================================================
     */

    private final By dueDate = xpath("//*[text()='Due Date']/ancestor::label/following-sibling::div/span");
    private final By questionnaireDetailsPage =
            xpath("//*[@data-cid='Questionnaire-Management-Header-root' or @id='react-container-answer-questionnaire']");

    /**
     * =================================================================================================================
     * Reviewer Flow
     * =================================================================================================================
     */

    private final String reviewerTableRaw =
            "//h6[contains(text(),'Reviewer Flow')]/../div[position()>1 and position() < last()][%s]";
    private final By levelCell = xpath(reviewerTableRaw + "/div[1]");
    private final String reviewerCell = reviewerTableRaw + "/div[3]";
    private final String reviewerCellDropdown = reviewerTableRaw + "/div[3]//input";
    private final By changeReviewerLink = xpath("//button/span[text()='Change Reviewer']");
    private final String userDropdownOption = "//div[contains(text(), '%s')] | //li[contains(text(), '%<s')]";
    private final String reviewerTableButtons =
            "//h6[contains(text(),'Reviewer Flow')]/../div[position() = last()]//button/span[text()='%s']";
    private final String plusIcon = "//*[@id='simple-tabpanel-%d']//*[text()='%s']/../../../../.." +
            "//*[contains(@class, 'MuiGrid-item')]//*[contains(text(),'%s')]/../following-sibling::div//button";
    private final String editIcon = "//*[@id='simple-tabpanel-%d']//*[text()='%s']/../../../../.." +
            "//*[contains(@class, 'MuiGrid-item')]//*[contains(text(),'%s')]/../following-sibling::div//button//*[@title='Edit Assessment']";
    private final By addForAssessment = xpath("//li[contains(text(), 'Add')]");
    private final By assessmentComment = xpath("//*[@id='assessment-modal']//textarea");
    private final By tagAsRedFlag = name("redflag");
    private final By assessmentAddButton = id("add-button-id");
    private final String tabName = "//*[@title='%s']";
    private final By questionComment = xpath("//textarea[@rows='2']");
    private final By sendComment = xpath("//*[@aria-label='send']");
    private final By doneButton = id("Button-Done");

    /**
     * =================================================================================================================
     * Questions
     * =================================================================================================================
     */

    private final String tabPanel = "//*[@id='simple-tabpanel-%d']";
    private final String contentAncestor = "/ancestor::div[contains(@class, 'MuiCardContent')]";
    private final String dropDownInput = tabPanel + "//label[text()='%s']/..//input";
    private final String dropDownInputSelectedValues = dropDownInput + "/../div[@role='button']";
    private final String checkboxInput =
            tabPanel + "//*[contains(text(),'%s')]" + contentAncestor + "//*[contains(text(), '%s')]/..//input";
    private final String checkboxInputDiv = checkboxInput + "/../..";
    private final String currencyInput = tabPanel + "//*[text()='%s']" + contentAncestor + "//input[@type='tel']";
    private final String enhancedTextEntryPlusInput =
            tabPanel + "//*[text()='%s']/../../../../..//span[text()='%s']/../../..//input";
    private final String numberInput = tabPanel + "//*[text()='Number']" + contentAncestor + "//input";
    private final String textInput = tabPanel + "//*[text()='Text']" + contentAncestor + "//textarea";
    private final String dateInput = tabPanel + "//*[text()='Date']" + contentAncestor + "//input";
    private final String radioTypeInput =
            tabPanel + "//*[contains(text(),'%s')]" + contentAncestor + "//*[contains(text(), '%s')]/..//input";

}