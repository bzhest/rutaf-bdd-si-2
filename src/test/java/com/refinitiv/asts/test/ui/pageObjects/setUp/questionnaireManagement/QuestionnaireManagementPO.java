package com.refinitiv.asts.test.ui.pageObjects.setUp.questionnaireManagement;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class QuestionnaireManagementPO extends BasePO {

    public QuestionnaireManagementPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

    private final String tableRowWithNameText =
            "//*[contains(@class,'MuiTableContainer')]//tbody/tr/td/*[contains(., '%s')]/..";
    private final String tableRowWithIndex =
            "(//*[contains(@class,'MuiTableContainer')]//tbody/tr)[%s]";
    private final String tableRowStatus =
            "//*[contains(@class,'MuiTableContainer')]//tbody/tr/td/*[contains(., '%s')]/../..//td[2]";
    private final String tableRowWithNameTextEditButton =
            "//*[contains(@class,'MuiTableContainer')]//tbody/tr/td/*[contains(., '%s')]/ancestor::tr//*[@title=\"" +
                    translator.getValue("user.editButton") + "\"]";
    private final String tableRowWithNameTextCloneButton =
            "//*[contains(@class,'MuiTableContainer')]//tbody/tr/td/*[contains(., '%s')]/ancestor::tr//*[@title='Clone']";
    private final By menuQuestionnaires =
            xpath("//*[contains(@class, 'MuiAccordionDetails')]//p[contains(., 'Questionnaires')]");
    private final By questionnaireOverview =
            xpath("//h6[contains(.,\"" + translator.getValue("questionnaire.questionnaireManagement") + "\")]");
    private final By columnHeaders = xpath("//*[contains(@aria-label,'simple-table-sort-')]/span");
    private final By addQuestionnaire = id("add-new-questionnaire");
    private final By addQuestionnaireEmptyTableButton =
            xpath("//*[@id='no-data-available']//*[@id='add-new-questionnaire']");
    private final By questionnaireTable = xpath("//*[contains(@class,'MuiTableContainer')]");
    private final String columnHeader = "//th//span[text()='%s']";
    private final By paginationCountLabel = xpath("//p[text()='ROWS']/../following-sibling::div/p");
    private final By tableRows = xpath("//tbody//tr");
    private final By editButton = xpath("//*[@aria-label='edit-questionnaire']");
    private final By cloneButton = xpath("//*[@aria-label='clone-questionnaire']");
    private final By emptyTableMessage = xpath("//h6[text()='Questionnaire Management']/following-sibling::div//h6");
    private final By newNameLabel = xpath("//*[@name='new-questionnaire-name']/../../label");

    /**
     * Clone Questionnaire modal
     */
    private final By cloneModal = xpath("//*[@role='dialog']");
    private final By cloneModalTitle = xpath("//*[@role='dialog']//h2");
    private final By cloneModalMessage = name("questionnaire-name");
    private final By newQuestionnaireName = name("new-questionnaire-name");
    private final By newQuestionnaireNameRed = xpath("//*[@name='new-questionnaire-name']/../../label/span");
    private final String modalButton = "//button//*[contains(., '%s')]";
    private final By validationMessage = xpath("//*[contains(@class, 'MuiFormHelperText')]");

}
