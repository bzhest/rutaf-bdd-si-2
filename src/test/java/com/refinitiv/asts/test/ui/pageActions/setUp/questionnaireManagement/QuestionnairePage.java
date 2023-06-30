package com.refinitiv.asts.test.ui.pageActions.setUp.questionnaireManagement;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.enums.AssigneeType;
import com.refinitiv.asts.test.ui.enums.QuestionnaireTabs;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.ThirdPartyOverviewPage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.questionnaireManagement.QuestionnairePO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionnaireData;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.SneakyThrows;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.ThreadLocalRandom;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.CHECKED;
import static com.refinitiv.asts.test.ui.constants.QuestionnaireConstants.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.Colors.REACT_RED;
import static java.lang.Boolean.parseBoolean;
import static java.lang.String.format;
import static java.util.Arrays.asList;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.StringUtils.LF;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.apache.commons.text.CaseUtils.toCamelCase;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class QuestionnairePage extends BasePage<ThirdPartyOverviewPage> {

    public final QuestionnairePO questionnairePO;

    public QuestionnairePage(WebDriver driver, ScenarioCtxtWrapper context, LanguageConfig translator) {
        super(driver, context, translator);
        questionnairePO = new QuestionnairePO(driver, translator);
        this.get();
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

    public boolean isPageDisplayed() {
        return isElementDisplayed(waitShort, questionnairePO.getQuestionnaireWizard());
    }

    public void fillQuestionnaireInformation(QuestionnaireData questionnaireData) {
        fillQuestionnaireName(questionnaireData.getQuestionnaireName());
        fillQuestionnaireCategory(questionnaireData.getCategory());
        fillQuestionnaireDescription(questionnaireData.getDescription());
        clearAndFillQuestionnaireHeader(questionnaireData.getHeader());
        fillQuestionnaireLanguage(questionnaireData.getLanguage());
        fillAssigneeType(questionnaireData.getAssigneeType());
    }

    public void clearQuestionnaireName() {
        clearText(driver.findElement(questionnairePO.getQuestionnaireNameInput()));
    }

    public void fillInQuestionDetails(QuestionnaireData questionTestData) {
        fillInQuestionFroalaText(questionTestData.getQuestionName());
        fillInHelpText(questionTestData.getHelpText());
    }

    public void fillInQuestionConfigs(QuestionData questionTestData) {
        fillInQuestionFroalaText(questionTestData.getFroalaText());
        fillInHelpText(questionTestData.getHelpText());
        fillInChoices(questionTestData.getChoices());
        fillInSubQuestions(questionTestData.getSubQuestions());
        checkAttachmentAllowedCheckbox(questionTestData.getIsAttachmentAllowed());
        checkMandatoryCheckbox(questionTestData.getIsResponseMandatory());
        checkCalculateHighestScoreOnly(questionTestData.getIsCalculateHighestScoreOnly());
        fillInBranches(questionTestData.getBranchQuestion());
        fillInQuestionReviewerLevel(questionTestData.getReviewerLevel());
    }

    public void fillInQuestionReviewerLevel(String reviewerLevel) {
        if (nonNull(reviewerLevel)) {
            clickOpenDropDownWithLabel(SELECT_REVIEWER);
            selectDropDownValueWithText(reviewerLevel);
        }
    }

    public void checkMandatoryCheckbox(Boolean isResponseMandatory) {
        if (nonNull(isResponseMandatory) && ((isResponseMandatory && !isResponseMandatoryChecked()) ||
                (!isResponseMandatory && isResponseMandatoryChecked()))) {
            clickOn(questionnairePO.getMandatoryCheckbox());
        }
    }

    public void checkAttachmentAllowedCheckbox(Boolean isAttachmentAllowed) {
        if (nonNull(isAttachmentAllowed) && ((isAttachmentAllowed && !isAttachmentAllowedChecked()) ||
                (!isAttachmentAllowed && isAttachmentAllowedChecked()))) {
            clickOn(questionnairePO.getAttachmentCheckbox());
        }
    }

    public void checkCalculateHighestScoreOnly(Boolean isCalculateHighestScoreOnly) {
        Boolean isCalculateHighestScoreOnlyChecked = isCalculateHighestScoreOnlyChecked();
        if (nonNull(isCalculateHighestScoreOnly) && nonNull(isCalculateHighestScoreOnlyChecked)
                && ((isCalculateHighestScoreOnly && !isCalculateHighestScoreOnlyChecked)
                || (!isCalculateHighestScoreOnly && isCalculateHighestScoreOnlyChecked))) {
            clickOn(questionnairePO.getCalculateHighestScoreOnlyCheckbox());
        }
    }

    public void fillTabName(String name) {
        clearInputAndEnterField(questionnairePO.getTabNameInput(), name);
    }

    public void clickTabButton(int tabIndex) {
        clickOn(xpath(format(questionnairePO.getTabButton(), tabIndex)));
    }

    public void fillScoringName(String scoringName) {
        clearAndInputField(questionnairePO.getScoringNameInput(), scoringName);
    }

    public void fillScoringMinRange(String scoringRangeFrom) {
        clearAndInputField(questionnairePO.getScoringMinRange(), scoringRangeFrom);
    }

    public void fillScoringToRange(String scoringRangeTo) {
        clearAndInputField(questionnairePO.getScoringMaxRange(), scoringRangeTo);
    }

    public void fillLevelOfReviewer(String levelOfReviewer) {
        if (nonNull(levelOfReviewer)) {
            clickOn(questionnairePO.getScoringLevelOfReviewer());
            clickOn(waitMoment.until(
                    visibilityOfElementLocated(xpath(format(questionnairePO.getDropDownOption(), levelOfReviewer)))));
        }
    }

    public void fillReviewerRuleValue(String value, String inputField) {
        WebElement element = getElementByXPath(format(questionnairePO.getDropDownWithLabelInput(), inputField));
        clickOn(element);
        element.sendKeys(value);
        enterViaKeyboard(Keys.ARROW_DOWN);
        enterViaKeyboard(Keys.ENTER);
    }

    public void clearTabName() {
        WebElement tabNameInput = getElement(questionnairePO.getTabNameInput());
        clickOn(tabNameInput);
        clearText(tabNameInput);
    }

    public void clickAddNewTabButton() {
        clickOn(xpath(questionnairePO.getPlusTabIcon()));
    }

    public void clickCreateTabButton(String buttonName) {
        clickOn(xpath(format(questionnairePO.getCreateTabButton(), buttonName)));
    }

    public void clickCreateTabRadioButton(String radioButton) {
        clickOn(xpath(format(questionnairePO.getCreateTabRadioButton(), radioButton)));
    }

    public void clickOnTabButton(int tabIndex) {
        clickOn(getElements(questionnairePO.getQuestionTabList()).get(tabIndex));
    }

    public void clickOnEditTabButton(int tabIndex) {
        clickOn(xpath(format(questionnairePO.getEditTabButton(), tabIndex - 1)));
    }

    public void clickOnDeleteTabButton(int tabIndex) {
        clickOn(xpath(format(questionnairePO.getDeleteTabButton(), tabIndex - 1)));
    }

    public void clickApproveEditButton() {
        clickOn(questionnairePO.getApproveEditButton());
    }

    public void clickAddScoringButton() {
        clickOn(questionnairePO.getAddScoringButton());
    }

    public void clickButton(String buttonName) {
        clickOn(getElement(xpath(format(questionnairePO.getButtonWithName(), buttonName))));
    }

    public void clickBackButton() {
        clickOn(questionnairePO.getBackButton(), waitShort);
    }

    public void clickEditButton() {
        clickOn(questionnairePO.getEditButton());
    }

    public void clickStatusCheckbox() {
        clickOn(questionnairePO.getStatusCheckbox());
    }

    public void clickTabWithName(String tabName) {
        waitWhilePreloadProgressbarIsDisappeared();
        clickWithJS(
                waitShort.until(visibilityOfElementLocated(xpath(format(questionnairePO.getTabWithName(), tabName)))));
    }

    public void clickQuestionnaireTabWithName(String tabName) {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(driver.findElement(xpath(format(questionnairePO.getQuestionnaireTabWithName(), tabName))));
    }

    public void clickOpenDropDownWithLabel(String dropDownLabel) {
        clickOn(xpath(format(questionnairePO.getDropDownWithLabel(), dropDownLabel)));
    }

    public void toggleForChoice(String choiceTitle) {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(xpath(format(questionnairePO.getRedFlagToggle(), choiceTitle)));
    }

    public void clickDeleteIcon(int questionPosition) {
        waitMoment.until(
                visibilityOfElementLocated(
                        xpath(format(questionnairePO.getDeleteButtonForQuestion(), questionPosition))));
        clickOn(xpath(format(questionnairePO.getDeleteButtonForQuestion(), questionPosition)));
    }

    public void clickDeleteScoreIcon(int questionPosition) {
        clickOn(xpath(format(questionnairePO.getDeleteScoreButton(), questionPosition)), waitLong);
    }

    public void clickEditScoreIcon(int questionPosition) {
        clickOn(xpath(format(questionnairePO.getEditScoreButton(), questionPosition)), waitLong);
    }

    public void fillInScoreValue(String scorePosition, String scoreValue) {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(xpath(format(questionnairePO.getScoreInput(), scorePosition)));
        selectText();
        fillInText(xpath(format(questionnairePO.getScoreInput(), scorePosition)), scoreValue);
    }

    public void toggleCheckbox(String toggleName) {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(xpath(format(questionnairePO.getToggle(), toggleName)));
    }

    public void clickCancelWarningButton() {
        clickOn(questionnairePO.getCancelWarningButton());
    }

    public void clickProceedWarningButton() {
        clickOn(questionnairePO.getProceedWarningButton());
    }

    public void selectDropDownValueWithText(String value) {
        clickOn(xpath(format(questionnairePO.getDropDownItem(), value)));
    }

    @SneakyThrows
    public void addRandomQuestionTypeToTab() {
        int index =
                ThreadLocalRandom.current().nextInt(0, getElements(questionnairePO.getQuestionTypeList()).size() - 1);
        WebElement questionTypeElement = getElements(questionnairePO.getQuestionTypeList()).get(index);
        WebElement questionsTabPanel = getElement(xpath(questionnairePO.getQuestionTabPanel()));
        scrollIntoView(questionTypeElement);
        dragAndDrop(questionTypeElement, questionsTabPanel);
        waitWhilePreloadProgressbarIsDisappeared();
    }

    @SneakyThrows
    public void addQuestionTypeToTab(String type) {
        int initialQuestionsCount = getActiveQuestionTabQuestionsCounter();
        int count = 1;
        int maxTries = 3;
        boolean isNextAttempt = true;
        while (isNextAttempt && count++ <= maxTries) {
            WebElement questionTypeElement = getElementByXPath(format(questionnairePO.getQuestionType(), type));
            WebElement questionsTabPanel = getElement(xpath(questionnairePO.getQuestionTabPanel()));
            scrollIntoView(questionsTabPanel);
            dragAndDrop(questionTypeElement, questionsTabPanel);
            try {
                waitMoment.until(driver -> initialQuestionsCount < getActiveQuestionTabQuestionsCounter());
                isNextAttempt = false;
            } catch (TimeoutException exception) {
            }
        }
    }

    public void fillInBranchQuestion(String choice, String question) {
        clickOn(xpath(format(questionnairePO.getBranchQuestion(), choice)));
        clickOn(waitMoment.until(
                visibilityOfElementLocated(xpath(format(questionnairePO.getDropDownOption(), question)))));
    }

    public void fillInBranchTabName(String choice, String tabName) {
        clickOn(xpath(format(questionnairePO.getBranchTabName(), choice)));
        clickOn(waitMoment.until(
                visibilityOfElementLocated(xpath(format(questionnairePO.getDropDownOption(), tabName)))));
    }

    public void clickConfigButtonForQuestion(int questionIndex) {
        clickOn(xpath(format(questionnairePO.getConfigButtonForQuestion(), questionIndex)));
    }

    public void clickMappingButtonForQuestion(int questionIndex) {
        clickOn(xpath(format(questionnairePO.getMappingButtonForQuestion(), questionIndex)));
    }

    public void clickConfigIconForQuestion(String questionName) {
        clickOn(xpath(format(questionnairePO.getConfigButtonForQuestionWithName(), questionName)));
    }

    public void fillInChoiceName(String choice, String value) {
        By choiceLocator = xpath(format(questionnairePO.getChoiceNameInput(), choice));
        if (isElementDisplayed(choiceLocator)) {
            moveToElementAndClick(waitMoment.until(presenceOfElementLocated(choiceLocator)), 100);
            clearAndInputField(choiceLocator, value);
        }
    }

    public void selectTabNameForChoice(String tabName, String choice) {
        clearAndFillInValueAndSelectFromDropDown(tabName,
                                                 xpath(format(questionnairePO.getBranchQuestionTabName(), choice)));
    }

    public void selectQuestionForChoice(String question, String choice) {
        clearAndFillInValueAndSelectFromDropDown(question,
                                                 xpath(format(questionnairePO.getBranchQuestionName(), choice)));
    }

    public void dragAndDrop(WebElement questionTypeElement, WebElement questionsTabPanel) {
        action.clickAndHold(questionTypeElement)
                .pause(Duration.ofSeconds(1))
                .moveByOffset(0, 10)
                .pause(Duration.ofSeconds(1))
                .moveToElement(questionsTabPanel, 0, -10)
                .release()
                .pause(300)
                .build()
                .perform();
    }

    public void fillInQuestionFroalaText(String questionFroalaText) {
        if (nonNull(questionFroalaText)) {
            WebElement element = driver.findElement(questionnairePO.getQuestionFroalaInput());
            clickWithJS(element);
            clearText(element);
            element.sendKeys(questionFroalaText);
        }
    }

    public void fillInHelpText(String helpText) {
        if (nonNull(helpText)) {
            clearInputAndEnterField(questionnairePO.getHelpTextFieldInput(), helpText);
        }
    }

    public void fillInChoices(List<QuestionData.Choice> choices) {
        if (nonNull(choices)) {
            for (int i = 1; i <= choices.size(); i++) {
                QuestionData.Choice choice = choices.get(i - 1);
                String choiceLabel = CHOICE_NAME + i;
                if (!isElementDisplayed(xpath(format(questionnairePO.getScoreInput(), choiceLabel)))) {
                    clickAddChoiceButton(CHOICE_NAME + (i - 1));
                }
                fillInChoiceName(choiceLabel, choice.getChoice());
                fillInScoreValue(choiceLabel, choice.getScore());
                Boolean isRedFlagChecked = isChoiceToggleChecked(choiceLabel);
                if (nonNull(choice.getIsRedFlag()) && nonNull(isRedFlagChecked) &&
                        ((choice.getIsRedFlag() && !isRedFlagChecked) ||
                                (!choice.getIsRedFlag() && isRedFlagChecked))) {
                    toggleForChoice(choiceLabel);
                }
            }
        }
    }

    public void fillInSubQuestions(List<QuestionData.SubQuestion> questions) {
        if (nonNull(questions)) {
            for (int i = 1; i <= questions.size(); i++) {
                QuestionData.SubQuestion subQuestion = questions.get(i - 1);
                String choiceLabel = SUB_QUESTION_NAME + i;
                if (!isElementDisplayedNow(xpath(format(questionnairePO.getTypeInput(), choiceLabel)))
                        && !isElementDisplayedNow(xpath(format(questionnairePO.getChoiceNameInput(), choiceLabel)))) {
                    clickAddChoiceButton(SUB_QUESTION_NAME + (i - 1));
                    if (nonNull(subQuestion.getOption())) {
                        clickEnhancedTextEntryPlusOption(subQuestion.getOption());
                    }
                }
                if (nonNull(subQuestion.getOption()) && subQuestion.getOption().equals(ADD_FIELD)) {
                    clickModalCheckbox(subQuestion.getSubQuestionName());
                    clickModalButton(SAVE);
                    waitWhilePreloadProgressbarIsDisappeared();
                } else {
                    fillInChoiceName(choiceLabel, subQuestion.getSubQuestionName());
                    selectType(choiceLabel, subQuestion.getType());
                }
                Boolean isMandatoryChecked = isChoiceToggleChecked(choiceLabel);
                if ((subQuestion.getIsMandatory() && !isMandatoryChecked) ||
                        (!subQuestion.getIsMandatory() && isMandatoryChecked)) {
                    toggleForChoice(choiceLabel);
                }
            }
        }
    }

    public void fillInBranches(List<QuestionData.BranchQuestion> branches) {
        if (nonNull(branches)) {
            for (QuestionData.BranchQuestion branchQuestion : branches) {
                String isChoiceIs = branchQuestion.getIsChoiceIs();
                if (nonNull(branchQuestion.getTabName())) {
                    fillInBranchTabName(isChoiceIs, branchQuestion.getTabName());
                }
                if (nonNull(branchQuestion.getQuestion())) {
                    fillInBranchQuestion(isChoiceIs, branchQuestion.getQuestion());
                }
            }
        }
    }

    public void fillQuestionnaireDescription(String description) {
        if (nonNull(description)) {
            clearInputAndEnterField(questionnairePO.getQuestionnaireDescriptionInput(), description);
        }
    }

    public void clearAndFillQuestionnaireHeader(String header) {
        if (nonNull(header)) {
            clearInputAndEnterField(questionnairePO.getQuestionnaireHeaderInput(), header);
        }
    }

    public void fillQuestionnaireHeader(String header) {
        if (nonNull(header)) {
            enterViaKeyboard(Keys.ENTER);
            fillInText(questionnairePO.getQuestionnaireHeaderInput(), header);
        }
    }

    public void clearQuestionnaireHeader() {
        clearText(questionnairePO.getQuestionnaireHeaderInput());
    }

    public void fillQuestionnaireLanguage(List<String> languages) {
        if (nonNull(languages)) {
            languages.forEach(language -> {
                fillInText(questionnairePO.getQuestionnaireLanguageInput(), language);
                enterViaKeyboard(Keys.ARROW_DOWN);
                clickEnter();
            });
        }
    }

    public void fillAssigneeType(String assigneeType) {
        if (nonNull(assigneeType)) {
            switch (AssigneeType.valueOf(assigneeType.toUpperCase())) {
                case INTERNAL:
                    clickOn(questionnairePO.getInternalRadioButton());
                    break;
                case EXTERNAL:
                    clickOn(questionnairePO.getExternalRadioButton());
                    break;
                default:
                    throw new IllegalArgumentException("Assignee type: " + assigneeType + " is unexpected");
            }
        }
    }

    public void fillQuestionnaireCategory(String category) {
        if (nonNull(category)) {
            clickCategoryInput();
            clickOn(driver.findElement(xpath(format(questionnairePO.getDropDownItem(), category))));
        }
    }

    public void clickCategoryInput() {
        if (!isElementDisplayed(questionnairePO.getCategoryInputCloseArrow())) {
            clickOn(questionnairePO.getCategoryInputOpenArrow());
        }
    }

    public void clickLanguageInput() {
        clickOn(questionnairePO.getLanguageInputOpenCloseArrow());
    }

    public void fillQuestionnaireName(String name) {
        if (nonNull(name)) {
            WebElement input = waitShort.until(visibilityOfElementLocated(questionnairePO.getQuestionnaireNameInput()));
            clickWithJS(input);
            clearInputAndEnterField(input, name);
        }
    }

    public void clickMappingIcon() {
        clickOn(questionnairePO.getMappingButton());
    }

    public void hoverToQstGroupField() {
        hoverOverElement(questionnairePO.getGroupsField());
    }

    public void hoverToQstGroupsDropDown(int value) {
        clickOn(questionnairePO.getGroupsField(), waitShort);
        hoverOverElement(
                waitMoment.until(visibilityOfAllElementsLocatedBy((questionnairePO.getDropDownOptions()))).get(value));
    }

    public void selectType(String choiceLabel, String type) {
        if (isTypeValueInputDisplayed(choiceLabel)) {
            clickTypeInput(choiceLabel);
            clickOn(xpath(format(questionnairePO.getDropDownOption(), type)));
            clickOn(xpath(format(questionnairePO.getTypeInput(), choiceLabel)));
        }
    }

    public void clickTypeInput(String choiceLabel) {
        clickOn(xpath(format(questionnairePO.getTypeInput(), choiceLabel)));
    }

    public void selectQstGroup(int value) {
        clickOn(questionnairePO.getGroupsField(), waitShort);
        clickOn(waitMoment.until(visibilityOfAllElementsLocatedBy((questionnairePO.getDropDownOptions()))).get(value));
    }

    public void clickRemoveLanguage(String language) {
        clickOn(xpath(format(questionnairePO.getLanguageRemoveIcon(), language)));
    }

    public void clickBreadcrumb() {
        clickOn(questionnairePO.getBreadcrumbButton());
    }

    public void clickOnFroalaButton(String buttonName) {
        clickOn(xpath(format(questionnairePO.getFroalaButton(), toCamelCase(buttonName, false))));
    }

    public void clickOnTableInsertButton(String buttonName) {
        clickOn(xpath(format(questionnairePO.getTableInsertButton(), buttonName)));
    }

    public void clickQuickInsertButton() {
        clickOn(questionnairePO.getQuickInsertButton());
    }

    public void clickQuickInsertLink(String linkTitle) {
        clickOn(xpath(format(questionnairePO.getQuickInsertLink(), linkTitle)));
    }

    public void clickHeaderContentElement(String elementName) {
        clickOn(xpath(format(questionnairePO.getHeaderContentElement(), elementName)));
    }

    public void clickDeleteChoiceButton(String choice) {
        clickOn(xpath(format(questionnairePO.getChoiceDeleteButton(), choice)));
    }

    public void clickAddChoiceButton(String choice) {
        moveToElementAndClick(
                waitMoment.until(presenceOfElementLocated(xpath(format(questionnairePO.getChoiceAddButton(), choice)))),
                100);
    }

    public void clickChoiceButton(String buttonName) {
        clickOn(xpath(format(questionnairePO.getQuestionConfigAreaChoicesButton(), buttonName)));
    }

    public void clickQuestionButton(String buttonName) {
        clickOn(xpath(format(questionnairePO.getQuestionButton(), buttonName)));
    }

    public void clickAddBulkChoicesButton(String buttonName) {
        clickOn(xpath(format(questionnairePO.getAddBulkChoicesButton(), buttonName)));
    }

    public void fillInBulkChoiceValue(String value) {
        fillInText(questionnairePO.getAddBulkChoicesInput(), value);
    }

    public void clickClearDropDownButton(String dropDownLabel) {
        clickOn(xpath(format(questionnairePO.getClearDropDownButton(), dropDownLabel)));
    }

    public void clearField(String label) {
        if (isElementDisplayedNow(xpath(format(questionnairePO.getInputField(), label)))) {
            clearText(xpath(format(questionnairePO.getInputField(), label)));
        } else {
            clickOn(xpath(format(questionnairePO.getClearDropDownButton(), label)));

        }
    }

    public void clickClearMappingButton() {
        clickOn(questionnairePO.getClearMappingButton());
    }

    public void clickEnhancedTextEntryPlusOption(String option) {
        clickOn(xpath(format(questionnairePO.getDropDownListBoxItem(), option)));
    }

    public void clickModalCheckbox(String field) {
        clickOn(xpath(format(questionnairePO.getAddFieldModalCheckbox(), field)));
    }

    public void clickModalButton(String button) {
        clickOn(xpath(format(questionnairePO.getAddFieldModalButton(), button)));
    }

    public int getTabCount() {
        return getElements(questionnairePO.getQuestionTabList()).size();
    }

    public int getInformationContentTabCount() {
        return getElements(questionnairePO.getInformationContentQuestionTabList()).size();
    }

    public int getQuestionCountForTab() {
        return getElements(questionnairePO.getDroppedQuestionsList()).size();
    }

    public int getAddedQuestionSize() {
        return isElementDisplayed(waitMoment, questionnairePO.getAddedQuestion()) ?
                driver.findElements(questionnairePO.getAddedQuestion()).size() : 0;
    }

    public int getActiveQuestionTabQuestionsCounter() {
        return Integer.parseInt(getElementText(questionnairePO.getSelectedTabQuestionCounter()));
    }

    public String getTabName(int i) {
        return waitLong.until(visibilityOfElementLocated(xpath((format(questionnairePO.getTabNameTitle(), i)))))
                .getText();
    }

    public String getQuestionnaireNameLabelValue() {
        return getElementText(questionnairePO.getQuestionnaireNameLabel());
    }

    public String getQuestionnaireInputLabelValue(String fieldName) {
        return getElementText(xpath(format(questionnairePO.getQuestionnaireInputLabel(), fieldName)));
    }

    public String getWarningMessageText() {
        return getElementText(questionnairePO.getWarningMessage());
    }

    public String getHelpTextValue() {
        return getElementText(questionnairePO.getHelpTextFieldInput());
    }

    public String getHelpTextMaxLength() {
        return getAttributeValue(questionnairePO.getHelpTextFieldInput(), MAX_LENGTH);
    }

    public String getQuestionFroalaTextValue() {
        return getElementText(questionnairePO.getQuestionFroalaInput());
    }

    public String getScoringMessage() {
        return getElementText(questionnairePO.getScoringMessage());
    }

    public String getScoringFormMessage() {
        return getElementText(questionnairePO.getScoringRangeMessage()).replace(LF, SPACE);
    }

    public String getSetupInformationQuestionnaireName() {
        return getAttributeValueWhenAppears(waitMoment, questionnairePO.getQuestionnaireNameInput());
    }

    public String getSetupInformationQuestionnaireNameMaxLength() {
        return getAttributeValue(questionnairePO.getQuestionnaireNameInput(), MAX_LENGTH);
    }

    public String getSetupInformationDescriptionMaxLength() {
        return getAttributeValue(questionnairePO.getQuestionnaireDescriptionInput(), MAX_LENGTH);
    }

    public String getSetupInformationQuestionnaireCategory() {
        return getAttributeOrText(questionnairePO.getViewQuestionnaireCategory(), VALUE);
    }

    public String getSetupInformationQuestionnaireDescription() {
        return getElementText(questionnairePO.getViewQuestionnaireDescription());
    }

    public String getSetupInformationQuestionnaireAssignee() {
        return getElementText(questionnairePO.getViewQuestionAssigneeType());
    }

    public String getErrorMessageText(String fieldName) {
        return getElementText(xpath(format(questionnairePO.getInputError(), fieldName)));
    }

    public String getCounterLabel() {
        return getElementText(questionnairePO.getFroalaCounter());
    }

    public String getQstGroupsValue() {
        return getAttributeValue(questionnairePO.getGroupsField(), VALUE);
    }

    public String getQstGroupTooltip() {
        return getElementText(questionnairePO.getTooltip());
    }

    public String getScoringNameMaxLength() {
        return getAttributeValue(questionnairePO.getScoringNameInput(), MAX_LENGTH);
    }

    public String getScoringLevelOfReviewer() {
        return getAttributeOrText(questionnairePO.getLevelOfReviewer(), VALUE);
    }

    public String getScoringNameValue() {
        return getAttributeOrText(questionnairePO.getScoringNameInput(), VALUE);
    }

    public String getScoringMinValue() {
        return getAttributeOrText(questionnairePO.getScoringMinRange(), VALUE);
    }

    public String getScoringMaxValue() {
        return getAttributeOrText(questionnairePO.getScoringMaxRange(), VALUE);
    }

    public String getQuestionnaireScoreName(int index) {
        return getAttributeOrText(
                getElements(questionnairePO.getRow()).get(index - 1).findElement(questionnairePO.getScoreName()),
                VALUE);
    }

    public String getChoiceNameValue(String choice) {
        return isElementDisplayed(xpath(format(questionnairePO.getChoiceNameInput(), choice))) ?
                getElementValue(xpath(format(questionnairePO.getChoiceNameInput(), choice))) :
                getElementValue(xpath(format(questionnairePO.getChoiceNameInputView(), choice)));
    }

    public String getScoreValue(String choice) {
        return getElementValue(xpath(format(questionnairePO.getScoreInput(), choice)));
    }

    public String getTypeValue(String choice) {
        return isElementDisplayed(xpath(format(questionnairePO.getTypeInput(), choice))) ?
                getElementValue(xpath(format(questionnairePO.getTypeInput(), choice))) :
                getElementText(xpath(format(questionnairePO.getTypeInputView(), choice)));
    }

    public String getQuestionReviewer() {
        return getInputValue(SELECT_REVIEWER);
    }

    public String getInputValue(String inputLabel) {
        String elementValue =
                getElementValue(getElement(xpath(format(questionnairePO.getDropDownWithLabelInput(), inputLabel))));
        return nonNull(elementValue) ? elementValue :
                getElementText(xpath(format(questionnairePO.getDropDownWithLabel(), inputLabel)));
    }

    public String getQuestionName(int position) {
        return getElementText(xpath(format(questionnairePO.getQuestionName(), position)));
    }

    public String getQuestionMainAreBackground() {
        return getCssValue(xpath(questionnairePO.getQuestionMainArea()), BACKGROUND_COLOR);
    }

    public String getQuestionConfigTitle() {
        return getElementText(questionnairePO.getQuestionConfigTitle());
    }

    public String getQuestionTabPanelMessage() {
        return getElementText(questionnairePO.getQuestionTabPanelMessage());
    }

    public String getQuestionTabPanelAdditionalMessage() {
        return getElementText(questionnairePO.getQuestionTabPanelAdditionalMessage());
    }

    public String getAddedChoicesCount(String label) {
        Pattern patternText = Pattern.compile(format("(%s: )(\\d+)(/)(\\d+)", label));
        String initialCount = "2";
        Matcher m = patternText.matcher(getElementText(questionnairePO.getQuestionConfigAreaChoicesText()));
        if (m.find()) {
            initialCount = m.group(2);
        }
        return initialCount;
    }

    public String getBulkChoicesModalHeader() {
        return getElementText(waitShort, questionnairePO.getAddBulkChoicesModalHeader());
    }

    public String getBulkChoicesModalInstruction() {
        return getElementText(questionnairePO.getAddBulkChoicesModalInstruction());
    }

    public String getUseType() {
        return getElementText(questionnairePO.getUseType());
    }

    public String getTabCountValue(int position) {
        return getElementText(xpath(format(questionnairePO.getTabCounter(), (position - 1))));
    }

    public String getPlusTabsCountValue() {
        return getElementText(questionnairePO.getPlusTabIconCounter());
    }

    public String getQuestionTabNameOnPosition(int position) {
        return getElementText(xpath(format(questionnairePO.getQuestionTabName(), (position - 1))));
    }

    public String getMappingQuestionnaireValue() {
        return getElementValue(questionnairePO.getMappingQuestionTitle());
    }

    public String getEnhancedTextEntryPlusCounter() {
        return getElementText(questionnairePO.getQuestionCounter());
    }

    public String getModalHeader() {
        waitLong.until(driver -> Objects.nonNull(getElementText(questionnairePO.getModalHeader())));
        return getElementText(questionnairePO.getModalHeader());
    }

    public String getFirstAvailableDropDownValue() {
        return getElementText(questionnairePO.getAvailableDropDownItem());
    }

    public List<String> getDropDownValues() {
        return getElementsText(
                waitShort.until(numberOfElementsToBeMoreThan(questionnairePO.getDropDownOptions(), 1)));
    }

    public List<String> getSetupInformationQuestionnaireLanguage() {
        String elementText = getElementText(questionnairePO.getViewQuestionnaireLanguage());
        return nonNull(elementText) ? asList(elementText.split(ROW_DELIMITER)) : null;
    }

    public List<String> getQuestionOptions() {
        return getElementsText(questionnairePO.getQuestionOptions());
    }

    public List<String> getQuestionFields() {
        return getElementsText(questionnairePO.getQuestionFields());
    }

    public List<String> getConfigQuestionFields() {
        return getElementsValue(questionnairePO.getMappingQuestionTitle());
    }

    public List<String> getMappingQuestionFieldsForPartType(String type) {
        By mappingTitles = xpath(format(questionnairePO.getMappingQuestionTitlesForPartType(), type));
        waitShort.until(driver -> getElements(mappingTitles).size() > 0);
        return getElementsValue(mappingTitles);
    }

    public List<String> getConfigQuestionFieldsForPartType(String type, int expectedSize) {
        By mappingTitles = xpath(format(questionnairePO.getMappingConfigSubQuestionsPartType(), type));
        waitShort.until(driver -> getElements(mappingTitles).size() == expectedSize);
        waitLong.until(driver -> !getElementsValue(mappingTitles).contains(null));
        return getElementsValue(mappingTitles);
    }

    public List<String> getQuestionChoicesInputMaxLength(String choiceName) {
        List<WebElement> elements =
                driver.findElements(xpath(format(questionnairePO.getChoiceNameInput(), choiceName)));
        return IntStream.rangeClosed(1, elements.size())
                .mapToObj(i -> getAttributeValue(xpath(format(questionnairePO.getChoiceNameInput(), choiceName + i)),
                                                 MAX_LENGTH))
                .collect(Collectors.toList());
    }

    public List<String> getQuestionScoresInputMaxLength() {
        List<WebElement> elements =
                driver.findElements(xpath(format(questionnairePO.getChoiceNameInput(), CHOICE_NAME)));
        return IntStream.rangeClosed(1, elements.size())
                .mapToObj(i -> getAttributeValue(xpath(format(questionnairePO.getScoreInput(), CHOICE_NAME + i)),
                                                 MAX_LENGTH))
                .collect(Collectors.toList());
    }

    public List<String> getChoices() {
        return getElementsText(questionnairePO.getChoicesLabel());
    }

    public List<String> getCreateTabModalRadioButtons() {
        return getElementsText(questionnairePO.getCreateTabRadioButtons());
    }

    public List<String> getDraggableQuestionOptions() {
        return getElementsText(questionnairePO.getQuestionTypeList());
    }

    public List<String> getMappingDataSections() {
        return getElementsText(questionnairePO.getMappingDataSections());
    }

    public List<String> getMapToValues() {
        return getElementsText(questionnairePO.getMapToSection());
    }

    public List<String> getQuestionConfigText() {
        return getElementsText(questionnairePO.getQuestionConfigAreaChoicesText());
    }

    public List<QuestionnaireData> getQuestionnaireScores() {
        return getElements(questionnairePO.getRow()).stream()
                .map(row -> new QuestionnaireData().setScoringName(
                                getElementText(row.findElement(questionnairePO.getScoreName())))
                        .setScoringRange(getElementText(row.findElement(questionnairePO.getScoreRange())))
                        .setLevelOfReviewer(getElementText(row.findElement(questionnairePO.getScoreLevel())))
                ).collect(Collectors.toList());
    }

    public QuestionnaireData getSetupInformation() {
        return new QuestionnaireData()
                .setQuestionnaireName(getSetupInformationQuestionnaireName())
                .setCategory(getSetupInformationQuestionnaireCategory())
                .setDescription(getSetupInformationQuestionnaireDescription())
                .setHeader(getQuestionFroalaTextValue())
                .setLanguage(getSetupInformationQuestionnaireLanguage())
                .setAssigneeType(getSetupInformationQuestionnaireAssignee());
    }

    public QuestionData getQuestionConfigData() {
        List<QuestionData.Choice> choicesValues = getChoicesValues();
        return new QuestionData()
                .setFroalaText(getQuestionFroalaTextValue())
                .setHelpText(getHelpTextValue())
                .setChoices(choicesValues)
                .setIsResponseMandatory(isResponseMandatoryChecked())
                .setIsAttachmentAllowed(isAttachmentAllowedChecked())
                .setIsCalculateHighestScoreOnly(isCalculateHighestScoreOnlyChecked())
                .setBranchQuestion(getBranchesValues(choicesValues))
                .setReviewerLevel(getQuestionReviewer())
                .setSubQuestions(getSubQuestionsValues());
    }

    public List<QuestionData.Choice> getChoicesValues() {
        if (isElementPresent(xpath(format(questionnairePO.getScoreInput(), CHOICE_NAME)))) {
            List<QuestionData.Choice> list = new ArrayList<>();
            for (int i = 1; i <= 250; i++) {
                String choiceLabel = CHOICE_NAME + i;
                if (isElementPresent(xpath(format(questionnairePO.getScoreInput(), choiceLabel)))) {
                    QuestionData.Choice choice =
                            new QuestionData.Choice().setChoice(getChoiceNameValue(choiceLabel))
                                    .setScore(getScoreValue(choiceLabel))
                                    .setIsRedFlag(isChoiceToggleChecked(choiceLabel));
                    list.add(choice);
                    scrollIntoView(xpath(format(questionnairePO.getScoreInput(), choiceLabel)));
                } else {
                    break;
                }
            }
            return list;
        }
        return null;
    }

    public List<QuestionData.SubQuestion> getSubQuestionsValues() {
        if (isElementPresent(xpath(format(questionnairePO.getChoiceNameInput(), SUB_QUESTION_NAME)))) {
            List<QuestionData.SubQuestion> list = new ArrayList<>();
            for (int i = 1; i <= 10; i++) {
                String subQuestionLabel = SUB_QUESTION_NAME + i;
                if (isElementPresent(xpath(format(questionnairePO.getChoiceNameInput(), subQuestionLabel)))) {
                    QuestionData.SubQuestion subQuestion =
                            new QuestionData.SubQuestion().setSubQuestionName(getChoiceNameValue(subQuestionLabel))
                                    .setType(getTypeValue(subQuestionLabel))
                                    .setIsMandatory(isChoiceToggleChecked(subQuestionLabel));
                    list.add(subQuestion);
                    scrollIntoView(xpath(format(questionnairePO.getChoiceNameInput(), subQuestionLabel)));
                } else {
                    break;
                }
            }
            return list;
        }
        return null;
    }

    public List<QuestionData.BranchQuestion> getBranchesValues(List<QuestionData.Choice> choicesValues) {
        if (nonNull(choicesValues) && !choicesValues.isEmpty()) {
            List<QuestionData.BranchQuestion> list = new ArrayList<>();
            for (QuestionData.Choice choicesValue : choicesValues) {
                String choice = choicesValue.getChoice();
                scrollIntoView(xpath(format(questionnairePO.getBranchTabName(), choice)));
                QuestionData.BranchQuestion branch =
                        new QuestionData.BranchQuestion()
                                .setIsChoiceIs(choice)
                                .setTabName(getElementValue(xpath(format(questionnairePO.getBranchTabName(), choice))))
                                .setQuestion(
                                        getElementValue(xpath(format(questionnairePO.getBranchQuestion(), choice))));
                list.add(branch);
            }
            return list;
        }
        return null;
    }

    public boolean isDeleteButtonForQuestion(int questionIndex) {
        return isElementDisplayed(xpath(format(questionnairePO.getDeleteButtonForQuestion(), questionIndex)));
    }

    public boolean isScoreWithNameDisplayedInTable(String expectedScoringName) {
        return isElementDisplayed(xpath(format(questionnairePO.getScoreRowWithName(), expectedScoringName)));
    }

    public boolean attachmentLabelIsDisplayed() {
        return isElementDisplayed(questionnairePO.getAttachmentLabel());
    }

    public boolean isTabDisplayed(String tabName) {
        WebElement tab;
        switch (QuestionnaireTabs.valueOf(tabName.toUpperCase())) {
            case INFORMATION:
                tab = getElement(questionnairePO.getInfoTab());
                break;
            case QUESTION:
                tab = getElement(xpath(format(questionnairePO.getQuestionnaireTabWithName(), tabName)));
                break;
            case SCORING:
                tab = getElement(questionnairePO.getScoringTab());
                break;
            case REVIEWERS:
                tab = getElement(questionnairePO.getReviewerTab());
                break;
            default:
                throw new RuntimeException("Tab is unknown:" + tabName);
        }
        scrollIntoView(tab);
        return nonNull(tab) && tab.isDisplayed();
    }

    public boolean isAddScoringButtonDisplayed() {
        return isElementDisplayed(questionnairePO.getAddScoringButton());
    }

    public boolean isWarningMessageDisplayed() {
        return isElementDisplayed(waitMoment, questionnairePO.getWarningMessage());
    }

    public boolean isPlusButtonDisabled() {
        return isElementContainsCssValue(xpath(questionnairePO.getPlusTabIcon()), POINTER_EVENTS, NONE);
    }

    public boolean areChoicesDisplayed() {
        return getElements(questionnairePO.getChoicesSection()).size() > 0;
    }

    public boolean isButtonWithNameDisplayed(String buttonName) {
        return isElementDisplayed(xpath(format(questionnairePO.getButtonWithName(), buttonName)));
    }

    public boolean isButtonWithNameDisabled(String buttonName) {
        return isElementAttributeContains(xpath(format(questionnairePO.getButtonWithName(), buttonName)), CLASS,
                                          DISABLED);
    }

    public boolean isEditModeDisplayed() {
        return getElementText(questionnairePO.getBreadcrumb()).contains(EDIT.toUpperCase());
    }

    public boolean isStatusActive() {
        return isAttributePresent(questionnairePO.getStatusCheckbox(), CHECKED);
    }

    public boolean isAlertIconDisplayed() {
        return isElementDisplayed(waitLong, questionnairePO.getAlertIcon());
    }

    public boolean isQuickInsertLinkDisplayed(String linkTitle) {
        return isElementDisplayed(waitMoment, xpath(format(questionnairePO.getQuickInsertLink(), linkTitle)));
    }

    public boolean isTableInsertLinkDisplayed(String linkTitle) {
        return isElementDisplayed(waitMoment, xpath(format(questionnairePO.getTableInsertButton(), linkTitle)));
    }

    public boolean isTabSelected(String linkTitle) {
        By tabLocator = xpath(format(questionnairePO.getButton(), linkTitle));
        return parseBoolean(getAttributeValue(tabLocator, ARIA_SELECTED)) ||
                isElementAttributeContains(tabLocator, CLASS, MUI_BUTTON_CONTAINEDPRIMARY);
    }

    public boolean isTabDisabled(String linkTitle) {
        return isElementAttributeContains(xpath(format(questionnairePO.getButton(), linkTitle)), CLASS, DISABLED);
    }

    public boolean idRemoveLanguageDisplayed(String language) {
        return isElementDisplayed(xpath(format(questionnairePO.getLanguageRemoveIcon(), language)));
    }

    public boolean isFroalaButtonDisplayed(String buttonName) {
        return isElementDisplayed(xpath(format(questionnairePO.getFroalaButton(), toCamelCase(buttonName, false))));
    }

    public boolean isFroalaOptionDisplayed(String section, String buttonName) {
        return isElementDisplayed(waitMoment,
                                  xpath(format(questionnairePO.getFroalaOption(), toCamelCase(section, false),
                                               buttonName)));
    }

    public boolean isCounterLabelDisplayed() {
        return isElementDisplayed(questionnairePO.getFroalaCounter());
    }

    public boolean isStrongHeaderTextDisplayed(String expectedText) {
        return isElementDisplayed(xpath(format(questionnairePO.getHeaderStrongText(), expectedText)));
    }

    public boolean isHeaderTextWithStyleDisplayed(String expectedText, String expectedStyle) {
        return isElementDisplayed(xpath(format(questionnairePO.getHeaderTextWithStyle(), expectedText, expectedStyle)));
    }

    public boolean isSetupInformationSectionDisplayed() {
        return isElementDisplayed(questionnairePO.getSetupInformationSection());
    }

    public boolean areAssigneeTypeRadioButtonsDisplayed() {
        return isElementPresent(questionnairePO.getInternalRadioButton()) &&
                isElementPresent(questionnairePO.getExternalRadioButton());
    }

    public boolean isLanguageClickable(String language) {
        return isElementAttributeContains(xpath(format(questionnairePO.getLanguageButton(), language)), CLASS,
                                          CLICKABLE);
    }

    public boolean isEditButtonDisplayed() {
        return isElementDisplayed(questionnairePO.getEditButton());
    }

    public boolean isToggleChecked(String toggleName) {
        waitWhilePreloadProgressbarIsDisappeared();
        return isCheckboxChecked(xpath(format(questionnairePO.getToggle(), toggleName)));
    }

    public boolean isToggleDropDownInputDisplayed(String toggleName, String dropDownName) {
        waitWhilePreloadProgressbarIsDisappeared();
        return isElementDisplayed(xpath(format(questionnairePO.getToggleDropDown(), toggleName, dropDownName)));
    }

    public boolean isTabHighlightedInRed(String tabName) {
        waitWhilePreloadProgressbarIsDisappeared();
        return getCssValue(xpath(format(questionnairePO.getButton(), tabName)), BACKGROUND_COLOR).equals(
                REACT_RED.getColorRgba()) || getCssValue(xpath(format(questionnairePO.getButtonText(), tabName)), COLOR)
                .equals(REACT_RED.getColorRgba());
    }

    public boolean isQstGroupsFieldDisplayed() {
        return isElementDisplayed(waitMoment, questionnairePO.getGroupsField());
    }

    public boolean areScoringTableEditButtonsDisplayed() {
        for (int i = 1; i <= getElements(questionnairePO.getRow()).size(); i++) {
            if (!isElementDisplayed(xpath(format(questionnairePO.getEditScoreButton(), i)))) {
                return false;
            }
        }
        return true;
    }

    public boolean areScoringTableDeleteButtonsDisplayed() {
        for (int i = 1; i <= getElements(questionnairePO.getRow()).size(); i++) {
            if (!isElementDisplayed(xpath(format(questionnairePO.getDeleteScoreButton(), i)))) {
                return false;
            }
        }
        return true;
    }

    public Boolean isChoiceToggleChecked(String choice) {
        setImplicitWaitToZero();
        if (isElementPresent(xpath(format(questionnairePO.getRedFlagToggle(), choice)))) {
            return isCheckboxChecked(xpath(format(questionnairePO.getRedFlagToggle(), choice)));
        }
        return null;
    }

    public boolean isChoiceToggleDisabled(String choice) {
        return isAttributePresent(xpath(format(questionnairePO.getRedFlagToggle(), choice)), DISABLED);
    }

    public Boolean isResponseMandatoryChecked() {
        if (isElementPresent(questionnairePO.getMandatoryCheckbox())) {
            return isCheckboxChecked(questionnairePO.getMandatoryCheckbox());
        } else {
            return null;
        }
    }

    public boolean isResponseMandatoryDisabled() {
        return isAttributePresent(questionnairePO.getMandatoryCheckbox(), DISABLED);
    }

    public boolean isAttachmentAllowedChecked() {
        return isCheckboxChecked(questionnairePO.getAttachmentCheckbox());
    }

    public Boolean isCalculateHighestScoreOnlyChecked() {
        if (isElementPresent(questionnairePO.getCalculateHighestScoreOnlyCheckbox())) {
            return isCheckboxChecked(questionnairePO.getCalculateHighestScoreOnlyCheckbox());
        }
        return null;
    }

    public boolean isQIDDisplayed(int position) {
        return isElementDisplayed(waitMoment, xpath(format(questionnairePO.getQID(), position)));
    }

    public boolean isConfigIconDisplayed(int position) {
        return isElementDisplayed(waitMoment, xpath(format(questionnairePO.getConfigButtonForQuestion(), position)));
    }

    public boolean isDropDownWithLabelDisplayed(String dropDownLabel) {
        return isElementDisplayed(xpath(format(questionnairePO.getDropDownWithLabel(), dropDownLabel)));
    }

    public boolean isInputWithLabelDisabled(String label) {
        return isAttributePresent(xpath(format(questionnairePO.getDropDownWithLabelInput(), label)), DISABLED);
    }

    public boolean areChoicesAddButtonDisplayed(String choiceName) {
        List<WebElement> elements =
                driver.findElements(xpath(format(questionnairePO.getChoiceNameInput(), choiceName)));
        return IntStream.rangeClosed(1, elements.size())
                .allMatch(i -> isElementDisplayed(xpath(format(questionnairePO.getChoiceAddButton(),
                                                               choiceName + i))));
    }

    public boolean areChoicesDeleteButtonDisplayed(String choiceName) {
        List<WebElement> elements =
                driver.findElements(xpath(format(questionnairePO.getChoiceNameInput(), choiceName)));
        return IntStream.rangeClosed(1, elements.size())
                .allMatch(i -> isElementDisplayed(xpath(format(questionnairePO.getChoiceDeleteButton(),
                                                               choiceName + i))));
    }

    public boolean isChoiceButtonDisplayed(String buttonName) {
        return isElementDisplayed(xpath(format(questionnairePO.getQuestionConfigAreaChoicesButton(), buttonName)));
    }

    public boolean isBulkChoicesModalButtonDisabled(String buttonName) {
        return isElementAttributeContains(xpath(format(questionnairePO.getAddBulkChoicesButton(), buttonName)), CLASS,
                                          DISABLED);
    }

    public boolean isBulkChoicesModalInvisible() {
        return isElementInvisible(waitShort, xpath(questionnairePO.getAddBulkChoicesModal()));
    }

    public boolean isEditTabButtonDisplayed(int position) {
        return isElementDisplayed(xpath(format(questionnairePO.getEditTabButton(), (position - 1))));
    }

    public boolean isDeleteTabButtonDisplayed(int position) {
        return isElementDisplayed(xpath(format(questionnairePO.getDeleteTabButton(), (position - 1))));
    }

    public boolean isCreateTabModalDisplayed() {
        return isElementDisplayed(waitMoment, xpath(questionnairePO.getCreateTabModalHeader()));
    }

    public boolean isCreateTabModalInvisible() {
        return isElementInvisible(waitMoment, xpath(questionnairePO.getCreateTabModalHeader()));
    }

    public boolean isCreateTabModalButtonDisplayed(String buttonName) {
        return isElementDisplayed(xpath(format(questionnairePO.getCreateTabButton(), buttonName)));
    }

    public boolean isCreateTabModalRadioButtonSelected(String buttonName) {
        return isCheckboxChecked(xpath(format(questionnairePO.getCreateTabRadioButton(), buttonName)));
    }

    public boolean isMappingIconDisplayed(int questionIndex) {
        return isElementDisplayed(xpath(format(questionnairePO.getMappingButtonForQuestion(), questionIndex)));
    }

    public boolean isQIDLabelDisplayed(String labelText) {
        return isElementDisplayed(xpath(format(questionnairePO.getQidLabel(), labelText)));
    }

    public boolean isDropDownWithLabelRequired(String dropDownLabel) {
        return isAttributePresent(xpath(format(questionnairePO.getDropDownWithLabelInput(), dropDownLabel)), REQUIRED);
    }

    public boolean isMappingClearButtonDisplayed() {
        return isElementDisplayed(questionnairePO.getClearMappingButton());
    }

    public boolean isMappingReviewRequiredToggleDisplayed() {
        return isElementPresent(questionnairePO.getReviewMappingRequired());
    }

    public boolean isMappingReviewRequiredToggleChecked() {
        return isCheckboxChecked(questionnairePO.getReviewMappingRequired());
    }

    public boolean isMappingAutoScreenToggleChecked() {
        return isCheckboxChecked(questionnairePO.getAutoScreenToggle());
    }

    public boolean isCurrencyTextFieldReadOnly() {
        return isAttributePresent(questionnairePO.getCurrencyTextField(), READONLY);
    }

    public boolean isInputReadOnly(String label) {
        return isAttributePresent(xpath(format(questionnairePO.getLabel(), label)), READONLY);
    }

    public boolean isTypeValueInputDisplayed(String choice) {
        return isElementDisplayed(xpath(format(questionnairePO.getTypeInput(), choice)));
    }

    public boolean isModalCheckboxChecked(String field) {
        return isAttributePresent(xpath(format(questionnairePO.getAddFieldModalCheckbox(), field)), CHECKED);
    }

    public boolean isModalButtonDisplayed(String buttonName) {
        return isElementDisplayed(xpath(format(questionnairePO.getAddFieldModalButton(), buttonName)));
    }

    public boolean isModalButtonDisabled(String buttonName) {
        return isAttributePresent(xpath(format(questionnairePO.getAddFieldModalButton(), buttonName)), DISABLED);
    }

    public boolean isEnhancedTextEntryPlusOptionDisplayed(String option) {
        return isElementDisplayedNow(xpath(format(questionnairePO.getDropDownListBoxItem(), option)));
    }

    public boolean isChoiceDraggable(String option) {
        return isAttributePresent(xpath(format(questionnairePO.getChoice(), option)),
                                  DATA_RBD_DRAG_HANDLE_DRAGGABLE_ID);
    }

    public boolean isMappingSubQuestionsDisplayed(String field) {
        return isElementDisplayed(xpath(format(questionnairePO.getMappingField(), field)));
    }

    public boolean isDropDownValueDisabled(String value) {
        return isAttributePresent(xpath(format(questionnairePO.getDropDownItem(), value)), ARIA_DISABLED);
    }

    public void selectPartType(String type) {
        selectReactCheckbox(questionnairePO.getPartTypeCheckbox(), type, CHECKED);
    }

    public void unSelectPartType(String type) {
        selectReactCheckbox(questionnairePO.getPartTypeCheckbox(), type, UNCHECKED);
    }

    public boolean isPartTypeCheckboxChecked(String type) {
        return isReactCheckboxChecked(questionnairePO.getPartTypeCheckbox(), type);
    }

    public void clickAddFieldButtonForPartType(String type) {
        clickOn(xpath(format(questionnairePO.getAddFieldForPartType(), type)));
    }

    public void clickAddSubQuestionButton(String type, String subQuestion) {
        clickOn(xpath(format(questionnairePO.getAddSubQuestionForPartTypeIcon(), type, subQuestion)));
    }

}
