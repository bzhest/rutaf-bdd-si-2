package com.refinitiv.asts.test.ui.pageActions.thirdParty.questionnaire;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.ThirdPartyOverviewPage;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.questionnaire.QuestionnaireActivityPO;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.QuestionnaireTabData;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ActivityInformationDisplayPage.*;
import static java.lang.String.format;
import static java.util.stream.Collectors.toList;
import static org.apache.commons.lang3.StringUtils.capitalize;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.Keys.HOME;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated;

public class QuestionnaireActivityPage extends BasePage<ThirdPartyOverviewPage> {

    public final static String REVIEWER_ASSESSMENT = "Reviewer Assessment";
    public static final String SCORE_CATEGORY = "Score Category";
    public static final String DATE_CREATED = "Date Created";
    private static final String QUESTIONNAIRE_STATUS = "Questionnaire Status";

    private final QuestionnaireActivityPO questionnairePO;

    public QuestionnaireActivityPage(WebDriver driver, ScenarioCtxtWrapper context, LanguageConfig translator) {
        super(driver, context, translator);
        questionnairePO = new QuestionnaireActivityPO(driver, translator);
    }

    @Override
    protected ExpectedCondition<ThirdPartyOverviewPage> getPageLoadCondition() {
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

    public void clickOnQuestionnaireTab() {
        clickWithJS(waitLong.until(visibilityOfElementLocated(questionnairePO.getQuestionnaireTab())));
    }

    public void clickOnAssignQuestionnaireButton() {
        waitUntilPageReady();
        clickOn(questionnairePO.getAssignQuestionnaireButton(), waitLong);
    }

    public void selectsInternalType() {
        clickOn(questionnairePO.getInternalTypeRadioButton(), waitShort);
    }

    public void selectsExternalType() {
        clickOn(questionnairePO.getExternalTypeRadioButton(), waitShort);
    }

    public void clickNextButton() {
        clickOn(questionnairePO.getNextButton(), waitShort);
    }

    public void clickBackButton() {
        clickOn(questionnairePO.getBackButton(), waitShort);
    }

    public void clickFinishButton() {
        clickOn(questionnairePO.getFinishButton());
    }

    public void selectQuestionnaire(String questionnaireName) {
        waitMoment.until(visibilityOfElementLocated(questionnairePO.getQuestionnaireInput()));
        clearAndInputField(questionnairePO.getQuestionnaireInput(), questionnaireName);
        clickOn(xpath(format(questionnairePO.getQuestionnaireItem(), questionnaireName)), waitLong);
    }

    public void selectQuestionnaires(List<String> questionnairesNames) {
        waitMoment.until(visibilityOfElementLocated(questionnairePO.getQuestionnaireInput()));
        questionnairesNames.forEach(questionnaire -> {
            getElement(questionnairePO.getQuestionnaireInput()).sendKeys(questionnaire);
            clickOn(xpath(format(questionnairePO.getQuestionnaireItem(), questionnaire)), waitLong);
        });
    }

    public List<String> getQuestionnaireDropdownOptionsList() {
        return getElementsText(questionnairePO.getQuestionnaireDropdownItems()).stream()
                .map(String::trim).collect(Collectors.toList());
    }

    public void selectOverallReviewer(String userName) {
        clickOn(questionnairePO.getAssigneeInput());
        clearAndFillInValueAndSelectFromDropDown(userName, questionnairePO.getReviewerInput(),
                                                 questionnairePO.getReviewerItem());
    }

    public void clickQuestionnaireInput() {
        clickOn(questionnairePO.getQuestionnaireInput());
    }

    public void selectAssignee(String assigneeName) {
        clickOn(questionnairePO.getAssigneeInput(), waitShort);
        clearAndFillInValueAndSelectFromDropDown(assigneeName, questionnairePO.getAssigneeInput(),
                                                 questionnairePO.getAssigneeItem());
    }

    public void selectSkipThisStepCheckbox() {
        int count = 0;
        final int maxTries = 5;
        while (!isReactCheckboxChecked(waitShort, questionnairePO.getSkipReviewerCheckbox()) && count++ < maxTries) {
            clickOn(questionnairePO.getSkipReviewerCheckbox(), waitShort);
        }
    }

    public void fillInDueDate(String date) {
        WebElement dateInput = getElement(questionnairePO.getDateInput());
        clickOn(dateInput);
        dateInput.sendKeys(HOME);
        dateInput.sendKeys(date);
        clickOnBlankArea();
    }

    public String getAssignQuestionnaireModalExistingFieldValue(String fieldName) {
        return getElementText(
                xpath(format(questionnairePO.getAssignQuestionnaireModalValueByFieldLabel(), fieldName)));
    }

    public boolean isDateInputFieldIsDisplayed() {
        return isElementDisplayed(waitShort, questionnairePO.getDateInput());
    }

    public boolean isReviewerInputFieldIsDisplayed() {
        return isElementDisplayed(waitShort, questionnairePO.getReviewerInput());
    }

    public boolean isAssignQuestionnaireWindowOpened() {
        return isElementDisplayed(waitShort, questionnairePO.getAssignQuestionnaireWindow());
    }

    public boolean isAssignQuestionnaireFieldEditable(String fieldName) {
        String iconProperty = getElementByXPath(format(questionnairePO.getSelectionIcon(), fieldName))
                .getAttribute(CLASS);
        return !iconProperty.contains(capitalize(DISABLED)) && iconProperty.contains(ACTIVE);
    }

    public boolean isQuestionnaireTabLoaded() {
        return isElementDisplayed(waitLong, questionnairePO.getQuestionnaireTabPage());
    }

    public List<QuestionnaireTabData> getQuestionnaireTabTableData() {
        final int[] rowsCount = new int[1];
        waitShort.ignoring(StaleElementReferenceException.class)
                .until(driver -> {
                    rowsCount[0] = getElements(questionnairePO.getQuestionnaireTabTableRows()).size();
                    return rowsCount[0] > 0;
                });
        return IntStream.rangeClosed(0, rowsCount[0] - 1).mapToObj(i ->
            new QuestionnaireTabData()
                    .setQuestionnaireName(getQuestionnaireTabTableValue(i, QUESTIONNAIRE_NAME))
                    .setStatus(getQuestionnaireTabTableValue(i, QUESTIONNAIRE_STATUS))
                    .setAssignee(getQuestionnaireTabTableValue(i, ASSIGNEE))
                    .setScore(getQuestionnaireTabTableValue(i, SCORE))
                    .setReviewerAssessment(getQuestionnaireTabTableValue(i, REVIEWER_ASSESSMENT))
                    .setReviewer(getQuestionnaireTabTableValue(i, REVIEWER))
                    .setScoreCategory(getQuestionnaireTabTableValue(i, SCORE_CATEGORY))
        ).collect(toList());
    }

    private String getQuestionnaireTabTableValue(int rowNumber, String header) {
        List<String> headers = getElementsText(questionnairePO.getQuestionnaireTabTableHeaders());
        int headerIndex = headers.indexOf(header.toUpperCase());
        final String[] text = new String[1];
        waitShort.ignoring(StaleElementReferenceException.class).until(driver -> {
            text[0] = getElementText(
                    getElements(questionnairePO.getQuestionnaireTabTableRows())
                            .get(rowNumber)
                            .findElements(questionnairePO.getTableRowColumns())
                            .get(headerIndex));
            return true;
        });
        return text[0];
    }

}


