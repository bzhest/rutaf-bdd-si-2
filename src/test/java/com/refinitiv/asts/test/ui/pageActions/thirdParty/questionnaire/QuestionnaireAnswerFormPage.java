package com.refinitiv.asts.test.ui.pageActions.thirdParty.questionnaire;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.questionnaire.QuestionnaireAnswerFormPO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.List;
import java.util.Objects;

import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static java.lang.String.format;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class QuestionnaireAnswerFormPage extends BasePage<QuestionnaireAnswerFormPage> {

    private final QuestionnaireAnswerFormPO questionnaireAnswerFormPO;

    public QuestionnaireAnswerFormPage(WebDriver driver, ScenarioCtxtWrapper context, LanguageConfig translator) {
        super(driver, context, translator);
        questionnaireAnswerFormPO = new QuestionnaireAnswerFormPO(driver, translator);
    }

    @Override
    protected ExpectedCondition<QuestionnaireAnswerFormPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return false;
    }

    @Override
    public void load() {

    }

    public void clickButton(String buttonName) {
        clickOn(waitLong.until(visibilityOfElementLocated(
                xpath(format(questionnaireAnswerFormPO.getQuestionnaireAnswerFormButton(), buttonName)))));
    }

    public void clickQuestionnaireAnswerButton(String button) {
        clickOn(xpath(format(questionnaireAnswerFormPO.getQuestionnaireButton(), button)), waitLong);
    }

    public boolean isQuestionnaireButtonDisabled(String button) {
        return isAttributePresent(xpath(format(questionnaireAnswerFormPO.getQuestionnaireButton(), button)),
                                  DISABLED);
    }

    public void clickCommentQuestionnaireButton() {
        clickOn(waitShort.until(visibilityOfElementLocated(questionnaireAnswerFormPO.getCommentButton())), waitShort);
    }

    public void clickRevisionButton() {
        clickOn(questionnaireAnswerFormPO.getRevisionButton(), waitLong);
    }

    public void fillInCommentQuestionnaire(String text) {
        clickOn(questionnaireAnswerFormPO.getCommentInput(), waitShort);
        clearAndInputField(questionnaireAnswerFormPO.getCommentInput(), text);
    }

    public void fillReplyCommentQuestionnaire(String text) {
        clickCommentReplyButton();
        fillInCommentQuestionnaire(text);
    }

    public void clickCommentReplyButton() {
        clickOn(questionnaireAnswerFormPO.getCommentReplyButton(), waitShort);
    }

    public void clickSendCommentQuestionnaireButton() {
        clickOn(questionnaireAnswerFormPO.getCommentSendButton());
    }

    public void clickDoneCommentQuestionnaireButton() {
        clickOn(questionnaireAnswerFormPO.getDoneButton(), waitShort);
    }

    public void clickAddButton() {
        clickOn(questionnaireAnswerFormPO.getAddButton(), waitShort);
    }

    public void fillReviewerDropdown(String level, String newReviewer) {
        if (Objects.nonNull(newReviewer)) {
            clearAndFillInValueAndSelectFromDropDown(newReviewer,
                                                     waitMoment.until(visibilityOfElementLocated(xpath(format(
                                                             questionnaireAnswerFormPO.getReviewerCellDropdown(),
                                                             level)))),
                                                     questionnaireAnswerFormPO.getUserDropdownOption());
        }
    }

    public void clickChangeReviewerLink() {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(questionnaireAnswerFormPO.getChangeReviewerLink());
    }

    public void clickReviewerTableButton(String button) {
        clickOn(xpath(format(questionnaireAnswerFormPO.getReviewerTableButtons(), button)));
    }

    public void clickQuestionnaireOptionButton(String button) {
        clickOn(xpath(format(questionnaireAnswerFormPO.getAnswerOptionButton(), button)));
    }

    public boolean isButtonVisible(String button) {
        return isElementDisplayed(waitLong, xpath(format(questionnaireAnswerFormPO.getQuestionnaireButton(), button)));
    }

    public boolean isOverallAssessmentModalDisplayed() {
        return isElementDisplayed(waitMoment, xpath(questionnaireAnswerFormPO.getModalOverallAssessment()));
    }

    public boolean isQuestionnaireDetailsPageDisplayed() {
        return isElementDisplayed(waitLong, questionnaireAnswerFormPO.getQuestionnaireDetailsPage());
    }

    public boolean isChangeReviewerLinkDisplayed() {
        return isElementDisplayed(questionnaireAnswerFormPO.getChangeReviewerLink());
    }

    public String getOverallAssessmentModalHeader() {
        return getElement(questionnaireAnswerFormPO.getModalOverallAssessmentHeader()).getText();
    }

    public String getOverallAssessmentModalMessage() {
        return getElement(questionnaireAnswerFormPO.getModalOverallAssessmentMessage()).getText();
    }

    public String getQuestionnaireDueDate() {
        waitShort.until(presenceOfElementLocated(questionnaireAnswerFormPO.getDueDate()));
        return getAttributeValue(questionnaireAnswerFormPO.getDueDate(), VALUE);
    }

    public String getCurrentReviewer(String level) {
        return getElementText(xpath(format(questionnaireAnswerFormPO.getReviewerCell(), level)));
    }

    public String getCommentCounter() {
        return getElementText(waitShort.until(presenceOfElementLocated(questionnaireAnswerFormPO.getCommentCounter())));
    }

    public String getCommentInputMaxLength() {
        return getAttributeValue(questionnaireAnswerFormPO.getCommentInput(), MAX_LENGTH);
    }

    public String getCommentContainerText(int position) {
        return getElementText(xpath(format(questionnaireAnswerFormPO.getCommentContainer(), position)));
    }

    public String getTextInputMaxLength(int tabIndex) {
        waitLong.until(visibilityOfElementLocated(xpath(format(questionnaireAnswerFormPO.getTextInput(), tabIndex))));
        return getAttributeValue(xpath(format(questionnaireAnswerFormPO.getTextInput(), tabIndex)), MAX_LENGTH);
    }

    public String getNumberInputMaxLength(int tabIndex) {
        waitLong.until(visibilityOfElementLocated(xpath(format(questionnaireAnswerFormPO.getNumberInput(), tabIndex))));
        return getAttributeValue(xpath(format(questionnaireAnswerFormPO.getNumberInput(), tabIndex)), MAX_LENGTH);
    }

    public String getSelectedDropDownValue(int tabIndex, String questionName) {
        return getAttributeValueWhenAppears(waitMoment,
                                            xpath(format(questionnaireAnswerFormPO.getDropDownInput(),
                                                         tabIndex, questionName)));
    }

    public String getCurrencyAmount(int tabIndex, String questionName) {
        return getAttributeValueWhenAppears(waitMoment, xpath(format(questionnaireAnswerFormPO.getCurrencyInput(),
                                                                     tabIndex, questionName)));
    }

    public String getDate(int tabIndex) {
        return getAttributeValueWhenAppears(waitMoment,
                                            xpath(format(questionnaireAnswerFormPO.getDateInput(), tabIndex)));
    }

    public List<String> getSelectedDropDownValues(int tabIndex, String questionName) {
        return getElementsText(waitMoment, xpath(format(questionnaireAnswerFormPO.getDropDownInputSelectedValues(),
                                                        tabIndex, questionName)));
    }

    public void clickDropDownInputAndSelectOption(int tabIndex, String questionName, String option) {
        clickOn(xpath(format(questionnaireAnswerFormPO.getDropDownInput(), tabIndex, questionName)));
        clickOn(xpath(format(questionnaireAnswerFormPO.getDropDownOption(), option)));
    }

    public void searchAndSelectOption(int tabIndex, String questionName, String option) {
        clickOn(xpath(format(questionnaireAnswerFormPO.getDropDownInput(), tabIndex, questionName)));
        fillInText(xpath(format(questionnaireAnswerFormPO.getDropDownInput(), tabIndex, questionName)), option,
                   waitMoment);
        clickOn(xpath(format(questionnaireAnswerFormPO.getDropDownOption(), option)));
    }

    public void selectDropDownAnswer(int tabIndex, String questionName, String value) {
        clearAndFillInValueAndSelectFromDropDown(value,
                                                 xpath(format(questionnaireAnswerFormPO.getDropDownInput(),
                                                              tabIndex, questionName)));
    }

    public void fillInCurrencyAmount(int tabIndex, String questionName, String amount) {
        clearInputAndEnterField(xpath(format(questionnaireAnswerFormPO.getCurrencyInput(), tabIndex, questionName)),
                                amount);
    }

    public void checkCheckboxAnswer(int tabIndex, String questionName, String checkboxName, String status) {
        int count = 0;
        int maxTries = 5;
        boolean isCheckboxSelected = isCheckboxSelected(tabIndex, questionName, checkboxName);
        while (count < maxTries) {
            if ((status.equals(CHECKED) && !isCheckboxSelected) || (!status.equals(CHECKED) && isCheckboxSelected)) {
                clickOn(xpath(format(questionnaireAnswerFormPO.getCheckboxInput(), tabIndex, questionName,
                                     checkboxName)));
                isCheckboxSelected = isCheckboxSelected(tabIndex, questionName, checkboxName);
            } else {
                break;
            }
            count++;
            logger.info("Checkbox click attempt " + count);
        }
    }

    public void fillInNumber(int tabIndex, String value) {
        clearAndInputField(xpath(format(questionnaireAnswerFormPO.getNumberInput(), tabIndex)), value);
    }

    public void fillInText(int tabIndex, String value) {
        clearAndInputField(xpath(format(questionnaireAnswerFormPO.getTextInput(), tabIndex)), value);
    }

    public void fillInDate(int tabIndex, String value) {
        waitLong.until(presenceOfElementLocated(xpath(format(questionnaireAnswerFormPO.getDateInput(), tabIndex))));
        clearAndInputField(xpath(format(questionnaireAnswerFormPO.getDateInput(), tabIndex)), value);
    }

    public void fillInTextField(int tabIndex, String questionName, String fieldName, String value) {
        clearAndInputField(
                xpath(format(questionnaireAnswerFormPO.getEnhancedTextEntryPlusInput(), tabIndex, questionName,
                             fieldName)), value);
    }

    public void clickPlusIconForOption(int tabIndex, String questionName, String option) {
        clickOn(xpath(format(questionnaireAnswerFormPO.getPlusIcon(), tabIndex, questionName, option)), waitShort);
    }

    public void clickEditIconForAssessment(int tabIndex, String questionName, String option) {
        clickOn(xpath(format(questionnaireAnswerFormPO.getEditIcon(), tabIndex, questionName, option)), waitShort);
    }

    public void fillQuestionComment(String value) {
        clearInputAndEnterField(questionnaireAnswerFormPO.getQuestionComment(), value);
    }

    public void clickSendComment() {
        clickOn(questionnaireAnswerFormPO.getSendComment());
    }

    public void clickAddForAssessment() {
        clickOn(questionnaireAnswerFormPO.getAddForAssessment());
    }

    public void addCommentForAssessment(String comment) {
        clearInputAndEnterField(questionnaireAnswerFormPO.getAssessmentComment(), comment);
    }

    public void toggleTagAsRedFlag() {
        clickOn(questionnaireAnswerFormPO.getTagAsRedFlag());
    }

    public void clickAssessmentAddButton() {
        clickOn(questionnaireAnswerFormPO.getAssessmentAddButton());
    }

    public void clickAttachmentButton(int tabIndex, String questionName) {
        clickOn(xpath(format(questionnaireAnswerFormPO.getAttachmentButton(), tabIndex, questionName)));
    }

    public void uploadAttachment(String path) {
        driver.findElement(questionnaireAnswerFormPO.getUploadFile()).sendKeys(path);
    }

    public void clickAddAttachmentButton() {
        clickOn(questionnaireAnswerFormPO.getUploadFileAddButton());
    }

    public void waitForUploadedAttachmentCrossButtonVisibility() {
        waitShort.until(visibilityOfAllElementsLocatedBy(questionnaireAnswerFormPO.getUploadFileCrossButton()));
    }

    public void clickTab(String tabName) {
        clickOn(xpath(format(questionnaireAnswerFormPO.getTabName(), tabName)));
    }

    public void selectRadioTypeQuestionAnswer(int tabIndex, String questionName, String answer) {
        clickOn(xpath(format(questionnaireAnswerFormPO.getRadioTypeInput(), tabIndex, questionName, answer)));
    }

    public void clickCancelQuestionnaireFormButton() {
        clickOn(questionnaireAnswerFormPO.getCancelQuestionnaireFormButton());
    }

    public void clickQuestionnaireDetailsCancelButton() {
        clickOn(questionnaireAnswerFormPO.getQuestionnaireDetailsCancelButton());
    }

    public void clickAnswerFormTab(String tabName) {
        clickOn(waitLong.until(ExpectedConditions.visibilityOfElementLocated
                (xpath(format(questionnaireAnswerFormPO.getAnswerFormTab(), tabName)))));
    }

    public boolean isQuestionnaireAnswerFormTabDisplayed(String tabName) {
        return isElementDisplayed(xpath(format(questionnaireAnswerFormPO.getAnswerFormTab(), tabName)));
    }

    public boolean isCommentTextDisplayed(String text) {
        return isElementPresent(xpath(format(questionnaireAnswerFormPO.getCommentText(), text)));
    }

    public boolean isCommentInputDisplayed() {
        return isElementPresent(questionnaireAnswerFormPO.getCommentInput());
    }

    public boolean isCommentSendButtonDisabled() {
        return isElementAttributeContains(questionnaireAnswerFormPO.getSendComment(), CLASS, DISABLED);
    }

    public boolean isCommentModalDisplayed() {
        return isElementDisplayed(xpath(questionnaireAnswerFormPO.getCommentModal()));
    }

    public boolean isCommentButtonDisabled(int position, String buttonName) {
        return isElementAttributeContains(
                xpath(format(questionnaireAnswerFormPO.getCommentContainerButton(), position, buttonName)), CLASS,
                DISABLED);
    }

    public boolean isCheckboxSelected(int tabIndex, String questionName, String checkboxName) {
        By checkbox =
                xpath(format(questionnaireAnswerFormPO.getCheckboxInputDiv(), tabIndex, questionName,
                             checkboxName));
        return isElementAttributeContains(checkbox, CLASS, MUI_CHECKED);
    }

    public boolean isRadioSelected(int tabIndex, String questionName, String answer) {
        return isCheckboxChecked(
                xpath(format(questionnaireAnswerFormPO.getRadioTypeInput(), tabIndex, questionName, answer)));
    }

}
