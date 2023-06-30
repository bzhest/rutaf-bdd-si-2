package com.refinitiv.asts.test.ui.pageActions.setUp.questionnaireManagement;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.questionnaireManagement.QuestionnairePO;
import com.refinitiv.asts.test.ui.pageObjects.setUp.questionnaireManagement.QuestionnaireReviewersPO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.apache.commons.text.CaseUtils;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static java.lang.Boolean.parseBoolean;
import static java.lang.String.format;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.StringUtils.*;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;
import static org.testng.util.Strings.isNullOrEmpty;

public class QuestionnaireReviewersPage extends BasePage<QuestionnaireReviewersPage> {

    public static final String ALLOW_TOTAL_SCORE = "Allow total score adjustment by entering a number";
    public static final String HIDE_TOTAL_SCORE = "Hide total score from reviewers";
    public static final String REQUIRE_MANDATORY_COMMENT = "Require mandatory comment for review and changes";
    public static final String HIDE_QUESTION_SCORE = "Hide question score from reviewers";
    private static final String MAIN_REVIEWER = "Main Reviewer";
    private static final String TRUE_STATUS = "true";
    private final QuestionnaireReviewersPO reviewersPO;
    private final QuestionnairePO questionnairePO;

    public QuestionnaireReviewersPage(WebDriver driver, ScenarioCtxtWrapper context, LanguageConfig translator) {
        super(driver, context);
        this.reviewersPO = new QuestionnaireReviewersPO(driver);
        this.questionnairePO = new QuestionnairePO(driver, translator);
    }

    @Override
    protected ExpectedCondition<QuestionnaireReviewersPage> getPageLoadCondition() {
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

    public void fillMainReviewer(String reviewer) {
        fillInDropDownWithReviewer(reviewer, xpath(reviewersPO.getMainReviewerInput()));
    }

    public void inputMainReviewer(String reviewer) {
        clearAndInputField(xpath(reviewersPO.getMainReviewerInput()), reviewer);
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    public void fillReviewer(String reviewer) {
        waitMoment.until(visibilityOfElementLocated(reviewersPO.getReviewerRuleReviewerInput()));
        fillInDropDownWithReviewer(reviewer, reviewersPO.getReviewerRuleReviewerInput());
    }

    public void clickOnReviewerRadioButton(String reviewer, String reviewerType) {
        if (reviewerType.equals(MAIN_REVIEWER)) {
            clickOn(xpath(format(reviewersPO.getMainReviewerRadioButton(),
                                 CaseUtils.toCamelCase(reviewer, false))));
        } else {
            selectRuleReviewer(reviewer);
        }
    }

    public void selectRuleReviewer(String reviewer) {
        clickOn(xpath(format(reviewersPO.getReviewerRadioButton(),
                             CaseUtils.toCamelCase(reviewer, false))));
    }

    public void clickRulesDropDownForReviewer(int ruleNumber) {
        clickOn(xpath(format(reviewersPO.getRulesDropDownForLevel(), ruleNumber)), waitShort);
    }

    public void selectRule(String ruleNumber, String rule) {
        waitMoment.ignoring(StaleElementReferenceException.class)
                .until(elementToBeClickable(xpath(format(reviewersPO.getRulesDropDownForLevel(), ruleNumber))));
        clearAndInputField(xpath(format(reviewersPO.getRulesDropDownForLevel(),
                                        ruleNumber)), rule);
        clickOn(xpath(format(reviewersPO.getDropDownOption(), rule)), waitShort);
    }

    public void selectRuleType(String selectRuleType, String ruleNumber) {
        waitMoment.ignoring(StaleElementReferenceException.class)
                .until(elementToBeClickable(xpath(format(reviewersPO.getRuleTypeDropDownButton(), ruleNumber))));
        fillInValueAndSelectFromDropDown(selectRuleType,
                                         xpath(format(reviewersPO.getRuleTypeDropDownButton(), ruleNumber)),
                                         xpath(format(reviewersPO.getDropDownOption(), selectRuleType)));
    }

    public void selectRuleTypeForReviewer(String selectRuleType, int reviewerLevel, int ruleNumber) {
        if (!isNullOrEmpty(selectRuleType)) {
            clickOn(waitMoment.ignoring(StaleElementReferenceException.class)
                            .until(elementToBeClickable(xpath(format(reviewersPO.getRuleTypeDropDownForLevel(),
                                                                     reviewerLevel, ruleNumber)))));
            fillInText(xpath(format(reviewersPO.getRuleTypeDropDownForLevel(),
                                    reviewerLevel, ruleNumber)), selectRuleType);
            clickOn(xpath(format(reviewersPO.getDropDownOption(), selectRuleType)), waitShort);
        }
    }

    public void selectReviewerRuleOption(String reviewerOption) {
        clickOn(xpath(format(reviewersPO.getReviewerRuleOption(), reviewerOption)));
    }

    public void selectReviewer(String reviewer) {
        int count = 1;
        int maxTries = 3;
        while (!waitMoment.ignoring(StaleElementReferenceException.class)
                .until(visibilityOfElementLocated(reviewersPO.getReviewerRuleReviewerInput()))
                .getAttribute(VALUE)
                .equals(reviewer) &&
                count++ <= maxTries) {
            clickDropDownReviewer();
            clearAndInputField(reviewersPO.getReviewerRuleReviewerInput(), reviewer);
            clickOn(xpath(format(questionnairePO.getDropDownItem(), reviewer)), waitShort);
        }
    }

    public void clickDropDownReviewer() {
        clickOn(reviewersPO.getReviewerRuleReviewerInput());
    }

    public void clickDropDownMainReviewerButton() {
        clickOn(reviewersPO.getMainReviewerInputButton());
    }

    public void clickRuleTypeDropDownArrowIcon(String ruleNumber) {
        scrollIntoView(xpath(format(reviewersPO.getRuleTypeDropDownArrowIcon(), ruleNumber)));
        clickOn(xpath(format(reviewersPO.getRuleTypeDropDownArrowIcon(), ruleNumber)));
    }

    public void clickRuleTypeDropDownForLevel(int reviewerLevel, int ruleNumber) {
        clickOn(xpath(format(reviewersPO.getRuleTypeDropDownForLevel(), reviewerLevel, ruleNumber)));
    }

    public void clickAddRulesButton() {
        clickOn(reviewersPO.getButtonAddRules(), waitShort);
    }

    public void clickAddRulesButtonForLevel(int reviewerLevel) {
        clickOn(xpath(format(reviewersPO.getAddRulesButtonForLevel(), reviewerLevel)), waitShort);
    }

    public void deleteRule(int ruleNumber) {
        moveToElement(driver.findElement(xpath(format(reviewersPO.getDeleteRuleIcon(), ruleNumber))));
        clickOn(xpath(format(reviewersPO.getDeleteRuleIcon(), ruleNumber)));
    }

    public void clicksReviewerTab(String tabName) {
        clickOn(xpath(format(reviewersPO.getReviewerTabButton(), tabName)), waitMoment);
    }

    public void toggleAllowTotalScore() {
        clickOn(reviewersPO.getToggleAllowTotalScore());
    }

    public void toggleHideTotalScore() {
        clickOn(reviewersPO.getToggleHideTotalScore());
    }

    public void toggleRequireMandatoryComment() {
        clickOn(reviewersPO.getToggleRequireMandatoryComment());
    }

    public void toggleHideQuestionScore() {
        clickOn(reviewersPO.getToggleHideQuestionScore());
    }

    public void selectNumberOfReviewerLevels(String level) {
        clickOn(reviewersPO.getNumberOfReviewerLevels());
        clickOn(xpath(format(questionnairePO.getDropDownListBoxItem(), level)));
    }

    public void selectSettingsDropDownValue(String dropDown, String value) {
        fillInValueAndSelectFromDropDown(value, xpath(format(reviewersPO.getSettingsDropDown(), dropDown)),
                                         xpath(format(reviewersPO.getDropDownOption(), value)));
    }

    public void clickSelectedValueCrossIcon(String dropDown, String value) {
        clickOn(xpath(format(reviewersPO.getSettingsSelectedValueClearIcon(), dropDown, value)));
    }

    public void fillDescription(String value, int level) {
        clearInputAndEnterField(xpath(format(reviewersPO.getDescription(), level)), value);
    }

    public void selectApproveNextLevel(String value, int level) {
        selectDropDownWithRetry(xpath(format(reviewersPO.getApproveNextLevel(), level)), value,
                                questionnairePO.getDropDownItem());
    }

    public void selectDeclineNextLevel(String value, int level) {
        selectDropDownWithRetry(xpath(format(reviewersPO.getDeclineNextLevel(), level)), value,
                                questionnairePO.getDropDownItem());
    }

    public void clickReviewerLevel(String reviewerLevel) {
        clickOn(xpath(format(reviewersPO.getReviewerLevelSection(), reviewerLevel)));
    }

    public void deleteQuestionnaireRulesMainReviewer() {
        clearText(xpath(reviewersPO.getMainReviewerInput()));
    }

    public void dragAndDropRule(int ruleNumber) {
        WebElement ruleSource = driver.findElement(xpath(format(reviewersPO.getRuleTarget(), ruleNumber)));
        WebElement ruleTarget = driver.findElement(xpath(format(reviewersPO.getRuleTarget(), 1)));
        clickOn(ruleTarget);
        action.clickAndHold(ruleSource)
                .moveByOffset(0, 10)
                .moveToElement(ruleTarget, 0, -10)
                .release()
                .pause(500)
                .build()
                .perform();
    }

    public void clickDeleteRulesReviewer() {
        clickOn(reviewersPO.getReviewerRuleReviewerInputDelete());
    }

    public void clickDeleteRulesRule(int reviewerLevel, int ruleNumber) {
        clickOn(xpath(format(reviewersPO.getRulesDropDownForLevelDeleteButton(), reviewerLevel, ruleNumber)),
                waitShort);
    }

    public void clickDeleteRulesRuleType(int reviewerLevel, int ruleNumber) {
        clickOn(xpath(format(reviewersPO.getRuleTypeDropDownForLevelDeleteButton(), reviewerLevel, ruleNumber)),
                waitShort);
    }

    public void clickLastRuleTypeInputButton() {
        clickOn(reviewersPO.getRuleTypeInputButton());
    }

    public void clickApproveNextLevel(int level) {
        clickOn(xpath(format(reviewersPO.getApproveNextLevel(), level)));
    }

    public void clickDeclineNextLevel(int level) {
        clickOn(xpath(format(reviewersPO.getDeclineNextLevel(), level)));
    }

    public void clickQuestionnaireProcessFlowCheckbox() {
        clickOn(reviewersPO.getProcessFlowCheckbox());
    }

    public boolean isQuestionnaireProcessFlowCheckboxChecked() {
        return isCheckboxChecked(reviewersPO.getProcessFlowCheckbox());
    }

    public boolean isReviewerSelected(String reviewer, String reviewerType) {
        if (reviewerType.equals(MAIN_REVIEWER)) {
            return isCheckboxChecked(
                    format(reviewersPO.getMainReviewerRadioButton(), CaseUtils.toCamelCase(reviewer, false)));
        } else {
            return isElementAttributeContains(
                    xpath(format(reviewersPO.getReviewerRadioButtonSpan(), CaseUtils.toCamelCase(reviewer, false))),
                    CLASS, CHECKED);
        }
    }

    public boolean isAddRuleFieldDisplayed() {
        return isElementDisplayed(waitMoment, reviewersPO.getAddRuleField());
    }

    public boolean isRuleTypeFieldDisplayed() {
        return isElementDisplayed(waitMoment, reviewersPO.getRuleTypeField());
    }

    public boolean isRuleOptionDisplayed(String option) {
        return isElementDisplayed(waitMoment, xpath(format(reviewersPO.getReviewerRuleOption(), option)));
    }

    public boolean isReviewerDropDownEnabled() {
        return isElementEnabled(reviewersPO.getReviewerRuleReviewerInput());
    }

    public boolean isRuleOptionSelected(String ruleOption) {
        return isElementAttributeContains(xpath(format(reviewersPO.getReviewerRuleOptionLabel(), ruleOption)), CLASS,
                                          MUI_CHECKED);
    }

    public boolean isAddRulesButtonDisabled() {
        return isElementAttributeContains(reviewersPO.getButtonAddRules(), CLASS, DISABLED);
    }

    public boolean isRuleDisplayed(int ruleNumber) {
        return isElementDisplayed(xpath(format(reviewersPO.getRuleIndex(), ruleNumber)));
    }

    public boolean isRuleInvisible(int ruleNumber) {
        return isElementInvisible(waitShort, xpath(format(reviewersPO.getRuleIndex(), ruleNumber)));
    }

    public boolean isDeleteMainReviewerButtonDisplayed() {
        return isElementDisplayed(reviewersPO.getDeleteMainReviewerButton());
    }

    public boolean isReviewerSubtabWithNameDisplayed(String tabName) {
        return isElementDisplayed(xpath(format(reviewersPO.getReviewerTabButton(), tabName)));
    }

    public boolean isMainReviewerInputHighlighted() {
        return parseBoolean(getAttributeValue(xpath(reviewersPO.getMainReviewerInput()), ARIA_INVALID));
    }

    public boolean isInputHighlighted(String fieldName) {
        return parseBoolean(getAttributeValue(xpath(format(reviewersPO.getLastInput(), fieldName)), ARIA_INVALID));
    }

    public boolean isSettingsDropDownRequired(String dropDown) {
        return getElementText(xpath(format(reviewersPO.getSettingsDropDownLabel(), dropDown))).contains(
                REQUIRED_INDICATOR);
    }

    public boolean isAllowedTotalScoreToggleEnabled() {
        return isSettingsDropDownToggleEnabled(reviewersPO.getToggleAllowTotalScore());
    }

    public boolean isHideTotalScoreToggleEnabled() {
        return isSettingsDropDownToggleEnabled(reviewersPO.getToggleHideTotalScore());
    }

    public boolean isRequireMandatoryToggleEnabled() {
        return isSettingsDropDownToggleEnabled(reviewersPO.getToggleRequireMandatoryComment());
    }

    public boolean isHideQuestionScoreToggleEnabled() {
        return isSettingsDropDownToggleEnabled(reviewersPO.getToggleHideQuestionScore());
    }

    public boolean isMainReviewerDisabled() {
        return isElementAttributeContains(xpath(reviewersPO.getMainReviewerInput()), CLASS, DISABLED);
    }

    public boolean isRuleSectionDisplayed(String section) {
        return isElementDisplayed(xpath(format(reviewersPO.getRuleSection(), section)));
    }

    public boolean isExpandedRuleTypeInputDisabled() {
        return isElementAttributeContains(xpath(reviewersPO.getRuleTypeInput()), CLASS, DISABLED);
    }

    public boolean isDeleteRuleButtonPresent(int ruleNo) {
        return isElementPresent(xpath(format(reviewersPO.getDeleteRuleIcon(), ruleNo)));
    }

    public boolean isRuleWithNumberPresent(int number) {
        scrollIntoView(xpath(format(reviewersPO.getRuleNumber(), number)));
        return isElementPresent(xpath(format(reviewersPO.getRuleNumber(), number)));
    }

    public boolean isLevelExpanded(String level) {
        return parseBoolean(
                getAttributeValue(xpath(format(reviewersPO.getReviewerLevelSectionButton(), level)), ARIA_EXPANDED));
    }

    public boolean isReviewerRadioButtonDisabled(String button) {
        return isElementAttributeContains(
                xpath(format(reviewersPO.getReviewerRadioButtonSpan(), CaseUtils.toCamelCase(button, false))),
                CLASS, DISABLED);
    }

    public boolean isProcessFlowCheckboxDisplayed() {
        return isElementPresent(reviewersPO.getProcessFlowCheckbox());
    }

    public String getBreadcrumb() {
        return getElementText(questionnairePO.getBreadcrumb()).replace(ROW_DELIMITER, SPACE);
    }

    public String getReviewerRuleValueForReviewer(int ruleNumber) {
        return getAttributeOrText(xpath(format(reviewersPO.getRulesDropDownForLevel(), ruleNumber)),
                                  VALUE);
    }

    public String getReviewerRuleTypeValueForReviewer(int reviewerLevel, int ruleNumber) {
        String elementText = getElementText(
                xpath(format(reviewersPO.getRuleTypeDropDownValueForLevel(), reviewerLevel, ruleNumber)));
        return nonNull(elementText) && !elementText.isEmpty() ? String.join(COMMA, elementText.split(LF)) : null;
    }

    public String getReviewersSettingsDropDownLocatorName(String dropDownName) {
        switch (dropDownName) {
            case ALLOW_TOTAL_SCORE:
                return "allowTotalScoreAdjustment";
            case HIDE_TOTAL_SCORE:
                return "hideTotalScoresFromReviewers";
            case REQUIRE_MANDATORY_COMMENT:
                return "requireMandatoryComment";
            case HIDE_QUESTION_SCORE:
                return "hideQuestionScoreFromReviewers";
            default:
                throw new IllegalArgumentException("Drop-down - " + dropDownName + " is unknown");
        }
    }

    public String getMainReviewerValue() {
        return getAttributeOrText(xpath(reviewersPO.getMainReviewerInputValue()), VALUE);
    }

    public String getMainReviewerFieldLabel() {
        return getElementText(reviewersPO.getMainReviewerLabel());
    }

    public String getReviewerFieldLabel() {
        return getElementText(reviewersPO.getReviewerRuleReviewerInputLabel());
    }

    public String getReviewerValue() {
        return getAttributeOrText(reviewersPO.getReviewerRuleReviewerInput(), VALUE);
    }

    public String getRuleTypeDropDownName() {
        return getElementText(reviewersPO.getDropDownRuleTypeName());
    }

    public String getNumberOfReviewerLevels() {
        return getElementText(reviewersPO.getNumberOfReviewerLevels());
    }

    public String getMainReviewerErrorMessageText() {
        return getElementText(reviewersPO.getMainReviewerInputHelpText());
    }

    public String getRuleErrorMessageText(String fieldName) {
        return getElementText(xpath(format(reviewersPO.getRuleInputHelpText(), fieldName)));
    }

    public String getLevelAccordionColor(String level) {
        return getCssValue(xpath(format(reviewersPO.getReviewerLevelSection(), level)), COLOR);
    }

    public String getRuleMessage() {
        return getElementText(reviewersPO.getRuleMessage());
    }

    public String getProcessFlowDescriptionLength(int level) {
        return getAttributeValue(xpath(format(reviewersPO.getDescription(), level)), MAX_LENGTH);
    }

    public String getProcessFlowInputErrorMessage(String fieldName, int level) {
        return getElementText(xpath(format(reviewersPO.getProcessFlowInputError(), fieldName, level)));
    }

    public String getProcessFlowInputColor(String fieldName, int level) {
        return getCssValue(xpath(format(reviewersPO.getProcessFlowInputLabel(), fieldName, level)), COLOR);
    }

    public List<String> getRuleTypeDropDownValues() {
        return getElementsText(reviewersPO.getRuleTypeSelectedItems());
    }

    public List<String> getSettingsDropDownValues(String dropDown) {
        clickOn(xpath(format(reviewersPO.getSettingsDropDown(), dropDown)));
        return getElementsText(questionnairePO.getDropDownValuesList());
    }

    public List<String> getSettingsSelectedValues(String dropDown) {
        return getElementsText(xpath(format(reviewersPO.getSettingsDropDownSelectedValues(), dropDown)));
    }

    public List<String> getReviewersLevels() {
        return getElementsText(reviewersPO.getReviewerLevelSections());
    }

    public List<String> getMainReviewerRadioButtons() {
        return getElementsText(reviewersPO.getMainReviewerRadioButtons());
    }

    public List<String> getReviewerRadioButtons() {
        return getElementsText(reviewersPO.getExpendedRuleReviewerRadioButtons());
    }

    public List<Integer> getRuleNumbers() {
        return getElementsText(reviewersPO.getRuleNumbers()).stream().map(Integer::parseInt)
                .collect(Collectors.toList());
    }

    public List<List<String>> getProcessFlowTableValues() {
        List<List<String>> valuesList = new ArrayList<>();
        valuesList.add(getProcessFlowTableHeaders());
        List<WebElement> rows = getElements(reviewersPO.getProcessFlowRows());
        for (int i = 0; i < rows.size(); i++) {
            List<String> values = new ArrayList<>();
            values.add(getElementText(rows.get(i).findElement(reviewersPO.getTableLevel())));
            values.add(getElementValue(rows.get(i).findElement(reviewersPO.getTableDescription())));
            values.add(getAttributeOrText(getElement(xpath(format(reviewersPO.getApproveNextLevel(), i + 1))), VALUE));
            values.add(getAttributeOrText(getElement(xpath(format(reviewersPO.getDeclineNextLevel(), i + 1))), VALUE));
            valuesList.add(values);
        }
        return valuesList;
    }

    private List<String> getProcessFlowTableHeaders() {
        return getElementsText(reviewersPO.getProcessFlowHeaders());
    }

    public List<String> getReviewersDropDownOptions() {
        try {
            waitShort.until(numberOfElementsToBeMoreThan(questionnairePO.getDropDownOptions(), 1));
        } catch (TimeoutException ignored) {
        }
        return getElementsText(questionnairePO.getDropDownOptions());
    }

    private boolean isSettingsDropDownToggleEnabled(By dropDownLocator) {
        return getAttributeValue(dropDownLocator, CHECKED).equals(TRUE_STATUS);
    }

    private void fillInDropDownWithReviewer(String reviewer, By dropDownLocator) {
        clearAndFillInValueAndSelectFromDropDown(reviewer, dropDownLocator, reviewersPO.getDropDownOption());
    }

}
