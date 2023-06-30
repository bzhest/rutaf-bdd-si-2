package com.refinitiv.asts.test.ui.pageObjects.thirdParty.questionnaire;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class QuestionnaireActivityPO extends BasePO {

    public QuestionnaireActivityPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

    private final By assignQuestionnaireWindow =
            xpath("//*[contains(@class, 'MuiDialog')]//*[contains(., 'Assign Questionnaire')]");
    private final By questionnaireTab =
            xpath("//*[text()= \"" + translator.getValue("questionnaire.questionnaire") + "\"]/..");
    private final By assignQuestionnaireButton = xpath("//span[.='Assign Questionnaire']");
    private final By internalTypeRadioButton = xpath("//*[@id='internal-radioInputPropsId']/../..");
    private final By externalTypeRadioButton = xpath("//*[@id='external-radioInputPropsId']/../..");
    private final By nextButton =
            xpath("//button/span[contains(., \"" + translator.getValue("questionnaire.nextButton") + "\")]");
    private final By backButton = xpath("//*[contains(@class, 'MuiDialog')]//button/span[contains(., \"" +
                                                translator.getValue("questionnaire.backButton") + "\")]");
    private final By questionnaireInput = xpath("//input[@id='autocomplete1-id']");
    private final String questionnaireItem =
            "(//*[@id='autocomplete1-id-popup']//li[@role='option']//div[contains(.,\"%s\")])[1]";
    private final By questionnaireDropdownItems =
            xpath("//*[@id='autocomplete1-id-popup']//li[@role='option']/div[@id='step-label-id']/div[1]");
    private final By assigneeInput =
            xpath("//*[contains(@class, 'MuiDialog')]//*[@data-cid='SearchTextField-root']//input");
    private final String assigneeItem = "//li[@role='option']//div[contains(., '%s')]";
    private final By skipReviewerCheckbox = xpath("//*[@id='skip-step-input-props4-id']/../..");
    private final By finishButton = id("finish-button4-id");
    private final By dateInput = id("custom-date3-id");
    private final By reviewerInput =
            xpath("//label[contains(., \"" + translator.getValue("questionnaire.reviewer") + "\")]/..//input");
    private final String reviewerItem = "//*[@role='listbox']//li[@role='option']//div[contains(., '%s')]";
    private final String selectionIcon =
            "//*[text()='%s']//ancestor::*[contains(@class, 'MuiStepLabel')]//*[contains(@class, 'MuiSvgIcon')]";
    private final By questionnaireTabPage = xpath("//*[@data-cid='Questionnaire-Management-Header-root']");
    private final By questionnaireTabTableRows = cssSelector("[data-cid^='Questionnaire-Management-Header']~[class^=MuiTable] tbody tr");
    private final By questionnaireTabTableHeaders = cssSelector("[data-cid^='Questionnaire-Management-Header']~[class^=MuiTable] thead tr th");
    private final By questionnaireTabTableRowValue = cssSelector("[data-cid^='Questionnaire-Management-Header']~[class^=MuiTable] thead tr th");
    private final String assignQuestionnaireModalValueByFieldLabel =
            "//*[text()='%s']//ancestor::*[contains(@class, 'MuiStepLabel')]//*[contains(@class, 'MuiBox')]//pre";

}
