package com.refinitiv.asts.test.ui.pageActions.setUp.questionnaireManagement;

import com.refinitiv.asts.test.ui.enums.Colors;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageActions.SearchSectionPage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.questionnaireManagement.QuestionnaireManagementPO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.openqa.selenium.ElementNotInteractableException;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;

import static com.refinitiv.asts.test.ui.constants.Pages.ADD_QUESTIONNAIRES;
import static com.refinitiv.asts.test.ui.constants.Pages.QUESTIONNAIRES;
import static com.refinitiv.asts.test.ui.constants.TestConstants.COLOR;
import static com.refinitiv.asts.test.ui.constants.TestConstants.VALUE;
import static java.lang.String.format;
import static org.apache.commons.lang3.StringUtils.substringAfter;
import static org.apache.commons.lang3.StringUtils.substringBetween;
import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated;

public class QuestionnaireManagementPage extends BasePage<QuestionnaireManagementPage> {

    private final QuestionnaireManagementPO questionnaireManagementPO;
    private final SearchSectionPage searchSectionPage;

    public QuestionnaireManagementPage(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
        questionnaireManagementPO = new QuestionnaireManagementPO(driver, translator);
        searchSectionPage = new SearchSectionPage(driver);
    }

    public void navigateToQuestionnaireManagementPage() {
        this.driver.get(URL + QUESTIONNAIRES);
    }

    public void navigateToQuestionnaireManagementPage(String endpoint) {
        this.driver.get(URL + QUESTIONNAIRES + endpoint);
    }

    public void navigateToAddQuestionnaireManagementPage() {
        this.driver.get(URL + ADD_QUESTIONNAIRES);
    }

    public void clickEditQuestionnaireWithName(String questionnaireName) {
        clickOn(waitMoment.until(visibilityOfElementLocated(
                xpath(format(questionnaireManagementPO.getTableRowWithNameTextEditButton(), questionnaireName)))));
    }

    public void clickOnQuestionnaireWithName(String expectedQuestionnaireName) {
        clickOn(waitMoment.until(visibilityOfElementLocated(
                xpath(format(questionnaireManagementPO.getTableRowWithNameText(), expectedQuestionnaireName)))));
    }

    public void clickOnQuestionnaireWithIndex(int index) {
        clickOn(waitMoment.until(
                visibilityOfElementLocated(xpath(format(questionnaireManagementPO.getTableRowWithIndex(), index)))));
    }

    public void clickAddQuestionnaireBtn() {
        try {
            clickOn(questionnaireManagementPO.getAddQuestionnaire(), waitShort);
        } catch (ElementNotInteractableException e) {
            clickOn(questionnaireManagementPO.getAddQuestionnaireEmptyTableButton());
        }
    }

    public void clickQuestionnairesTab() {
        clickOn(questionnaireManagementPO.getMenuQuestionnaires());
    }

    public void clickCloneButton(String questionnaireName) {
        clickOn(xpath(format(questionnaireManagementPO.getTableRowWithNameTextCloneButton(), questionnaireName)));
    }

    public void clearNewQuestionnaireName() {
        clearText(questionnaireManagementPO.getNewQuestionnaireName());
    }

    public void clickButtonWithName(String name) {
        clickOn(xpath(format(questionnaireManagementPO.getModalButton(), name)));
    }

    public void fillInNewQuestionnaireName(String value) {
        clearInputAndEnterField(questionnaireManagementPO.getNewQuestionnaireName(), value);
    }

    public void clickColumnHeader(String headerName) {
        clickOn(xpath(format(questionnaireManagementPO.getColumnHeader(), headerName)));
    }

    public void searchQuestionnaireByName(String name) {
        searchSectionPage.searchItem(name);
    }

    public boolean overviewIsDisplayed() {
        return isElementDisplayed(waitShort, questionnaireManagementPO.getQuestionnaireOverview());
    }

    public boolean isQuestionnaireWithNameDisplayed(String expectedQuestionnaireName) {
        try {
            waitLong.until(visibilityOfElementLocated(questionnaireManagementPO.getQuestionnaireTable()));
            return isElementDisplayed(
                    xpath(format(questionnaireManagementPO.getTableRowWithNameText(), expectedQuestionnaireName)));
        } catch (NoSuchElementException | TimeoutException e) {
            return false;
        }
    }

    public boolean isCloneButtonDisplayed(String questionnaireName) {
        return isElementDisplayed(
                xpath(format(questionnaireManagementPO.getTableRowWithNameTextCloneButton(), questionnaireName)));
    }

    public boolean isCloneModalDisplayed() {
        return isElementDisplayed(waitMoment, questionnaireManagementPO.getCloneModal());
    }

    public boolean isNewQuestionnaireNameDisplayed() {
        return isElementDisplayed(questionnaireManagementPO.getNewQuestionnaireName());
    }

    public boolean isNewQuestionnaireNameRed() {
        return isElementContainsCssValue(waitMoment, questionnaireManagementPO.getNewQuestionnaireNameRed(), COLOR,
                                         Colors.REACT_RED.getColorRgba());
    }

    public boolean isButtonWithNameDisplayed(String buttonName) {
        return isElementDisplayed(xpath(format(questionnaireManagementPO.getButton(), buttonName)));
    }

    public boolean areEditButtonsDisplayed() {
        return driver.findElements(questionnaireManagementPO.getTableRows()).stream()
                .allMatch(row -> isElementDisplayed(row.findElement(questionnaireManagementPO.getEditButton())));
    }

    public boolean areCloneButtonsDisplayed() {
        return driver.findElements(questionnaireManagementPO.getTableRows()).stream()
                .allMatch(row -> isElementDisplayed(row.findElement(questionnaireManagementPO.getCloneButton())));
    }

    public List<String> getColumnHeadersList() {
        return getElementsText(getElements(questionnaireManagementPO.getColumnHeaders()));
    }

    public List<String> getListValuesForColumn(String columnName) {
        int columnIndex = getColumnHeadersList().indexOf(columnName.toUpperCase()) + 1;
        return getElementsTextsWithBlank(
                cssSelector(format(questionnaireManagementPO.getCellsWithIndex(), columnIndex)));
    }

    public String getQuestionnaireStatus(String questionnaireName) {
        waitLong.until(visibilityOfElementLocated(questionnaireManagementPO.getQuestionnaireTable()));
        waitLong.until(visibilityOfElementLocated(
                xpath(format(questionnaireManagementPO.getTableRowWithNameText(), questionnaireName))));
        return getElementText(xpath(format(questionnaireManagementPO.getTableRowStatus(), questionnaireName)));
    }

    public String getCloneModalTitle() {
        return getElementText(questionnaireManagementPO.getCloneModalTitle());
    }

    public String getCloneModalMessage() {
        return getElementText(questionnaireManagementPO.getCloneModalMessage());
    }

    public String getNewQuestionnaireNameValue() {
        return getAttributeValue(questionnaireManagementPO.getNewQuestionnaireName(), VALUE);
    }

    public String getTotalCountLabel() {
        return getElementText(questionnaireManagementPO.getPaginationCountLabel());
    }

    public String getValidationMessage() {
        return getElementText(questionnaireManagementPO.getValidationMessage());
    }

    public String getEmptyTableMessage() {
        return getElementText(questionnaireManagementPO.getEmptyTableMessage());
    }

    public String getQuestionnaireNewNameLabelValue() {
        return getElementText(questionnaireManagementPO.getNewNameLabel());
    }

    public String getIdFromUrl() {
        String open = "questionnaires/";
        String close = "/edit";
        String currentUrl = driver.getCurrentUrl();
        return currentUrl.contains(close) ? substringBetween(currentUrl, open, close) :
                substringAfter(currentUrl, open);
    }

    @Override
    protected ExpectedCondition<QuestionnaireManagementPage> getPageLoadCondition() {
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

}
