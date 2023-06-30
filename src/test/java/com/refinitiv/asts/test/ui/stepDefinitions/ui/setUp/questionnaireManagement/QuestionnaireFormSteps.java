package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.questionnaireManagement;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.ConnectApi;
import com.refinitiv.asts.test.ui.api.model.LanguageResponse;
import com.refinitiv.asts.test.ui.api.model.Reference;
import com.refinitiv.asts.test.ui.api.model.RegionCountryRequest;
import com.refinitiv.asts.test.ui.api.model.thirdParty.RiskProperty;
import com.refinitiv.asts.test.ui.api.model.valueManagement.RiskScoreEngineResponse;
import com.refinitiv.asts.test.ui.constants.QuestionnaireConstants;
import com.refinitiv.asts.test.ui.constants.TestConstants;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.enums.QuestionType;
import com.refinitiv.asts.test.ui.pageActions.setUp.questionnaireManagement.QuestionnairePage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.GenericTestData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionnaireCustomFieldsItemResponse;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionnaireData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang.RandomStringUtils;
import org.assertj.core.api.SoftAssertions;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.api.AppApi.getAllAvailableRegions;
import static com.refinitiv.asts.test.ui.api.AppApi.getQuestionnaireCategoryList;
import static com.refinitiv.asts.test.ui.api.ConnectApi.*;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.getCommodityTypes;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.getRiskScoreEngineRanges;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.getQuestionnairesCustomFields;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.QuestionnaireConstants.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.QUESTION;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.QUESTIONNAIRE;
import static com.refinitiv.asts.test.ui.enums.Colors.BACKGROUND_GREY;
import static com.refinitiv.asts.test.ui.enums.QuestionType.ENHANCED_TEXT_ENTRY_PLUS;
import static com.refinitiv.asts.test.ui.enums.QuestionType.getQuestionType;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.utils.DateUtil.REACT_FORMAT;
import static com.refinitiv.asts.test.ui.utils.DateUtil.getTodayDate;
import static io.netty.karate.util.internal.StringUtil.SPACE;
import static java.lang.Integer.parseInt;
import static java.util.Arrays.asList;
import static java.util.Objects.isNull;
import static java.util.UUID.randomUUID;
import static org.apache.commons.lang3.RandomStringUtils.randomAlphanumeric;
import static org.apache.commons.lang3.StringUtils.LF;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.*;

public class QuestionnaireFormSteps extends BaseSteps {

    private final QuestionnairePage questionnairePage;
    private final List<QuestionnaireData> scoringList = new ArrayList<>();
    private int tabCountBeforeAdding = 0;

    public QuestionnaireFormSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.questionnairePage = new QuestionnairePage(this.driver, this.context, translator);
    }

    private List<String> getCustomFieldTypeValues(String customFieldType) {
        switch (customFieldType) {
            case REGION:
                return getAllAvailableRegions().stream()
                        .map(RegionCountryRequest.RegionObject::getName).collect(Collectors.toList());
            case COUNTRY:
                return ConnectApi.getCountries().getReferences().stream()
                        .map(Reference::getDescription).collect(Collectors.toList());
            case RISK_TIER:
                if (getTenantFeatureManagement().isDisableDynamicRiskScoringEngine()) {
                    return getRiskProperties().stream().map(RiskProperty::getLevel).collect(Collectors.toList());
                } else {
                    return getRiskScoreEngineRanges().getData().get(0).getRanges().stream()
                            .map(RiskScoreEngineResponse.DataItem.RangesItem::getName).collect(Collectors.toList());
                }
            case COMMODITY_TYPE:
                return getCommodityTypes().getData().stream()
                        .map(type -> type.getDescription().trim()).collect(Collectors.toList());
            case INDUSTRY_TYPE:
                //                TODO uncomment code when RMS-30721 will be fixed
//                if (getTenantFeatureManagement().isDisableDynamicRiskScoringEngine()) {
                return ConnectApi.getIndustryTypes().getReferences().stream().map(Reference::getDescription)
                        .collect(
                                Collectors.toList());
//                } else {
//                    return SIPublicApi.getIndustryTypes().getData().stream()
//                            .map(type -> type.getDescription().trim()).collect(Collectors.toList());
//                }
            default:
                throw new IllegalArgumentException("Drop-down type: " + customFieldType + " is unexpected");
        }
    }

    @When("User creates questionnaire {string} with {int} {string} tabs")
    public void createQuestionnaireWithTabs(String questionnaireReference, int tabCount, String tabName) {
        addQuestionnaireSetupPageDisplayed();
        fillInRequiredQuestionnaireSetupInformation(questionnaireReference);
        questionnairePage.clickButton(questionnairePage.getFromDictionaryIfExists("questionnaire.nextButton"));
        questionnairePage.clickButton(questionnairePage.getFromDictionaryIfExists("questionnaire.nextButton"));
        questionnairePage.waitWhilePreloadProgressbarIsDisappeared();
        addNewTabsWithDefaultName(tabCount, tabName);
        questionnairePage.clickButton(questionnairePage.getFromDictionaryIfExists("questionnaire.nextButton"));
        questionnairePage.waitWhilePreloadProgressbarIsDisappeared();
        clickButton(SAVE);
    }

    @When("User creates Questionnaire with {string} data with {string} question")
    public void createsQuestionnaireWithData(String questionnaireReference, String questionType) {
        addQuestionnaireSetupPageDisplayed();
        GenericTestData<QuestionnaireData> questionnaireTestData =
                new JsonUiDataTransfer<QuestionnaireData>(QUESTIONNAIRE).getTestData()
                        .get(questionnaireReference);
        if (questionnaireTestData.getDataToEnter().getQuestionnaireName().isEmpty()) {
            questionnaireTestData.getDataToEnter().setQuestionnaireName(AUTO_TEST_NAME_PREFIX + randomUUID());
        }
        this.context.getScenarioContext().setContext(QUESTIONNAIRE_TEST_DATA, questionnaireTestData);
        questionnairePage.waitWhilePreloadProgressbarIsDisappeared();
        questionnairePage.fillQuestionnaireInformation(questionnaireTestData.getDataToEnter());
        questionnairePage.clickButton(NEXT);
        questionnairePage.clickButton(NEXT);
        questionnairePage.waitWhilePreloadProgressbarIsDisappeared();
        questionnairePage.addQuestionTypeToTab(questionType);
        questionnairePage.clickButton(NEXT);
        questionnairePage.waitWhilePreloadProgressbarIsDisappeared();
        clickButton(SAVE);
        questionnairePage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks 'Add Field' for {string} part type in EnhancedTextEntryPlus mapping")
    public void clickAddFieldForPartType(String type) {
        questionnairePage.clickAddFieldButtonForPartType(type);
    }

    @When("User clicks Questionnaire Setup button {string}")
    public void clickButton(String buttonName) {
        questionnairePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        switch (buttonName) {
            case SAVE:
                questionnairePage.clickButton(
                        questionnairePage.getFromDictionaryIfExists("associatedParties.saveButton"));
                break;
            case DONE:
                questionnairePage.clickButton(questionnairePage.getFromDictionaryIfExists("questionnaire.doneButton"));
                break;
            case NEXT:
                questionnairePage.clickButton(questionnairePage.getFromDictionaryIfExists("questionnaire.nextButton"));
                break;
            default:
                questionnairePage.clickButton(buttonName);
        }
    }

    @When("User clicks Back questionnaire button")
    public void clickBackQuestionnaireButton() {
        questionnairePage.waitWhilePreloadProgressbarIsDisappeared();
        questionnairePage.clickBackButton();
    }

    @When("User clicks Cancel warning button")
    public void clickCancelButton() {
        questionnairePage.clickCancelWarningButton();
    }

    @When("User clicks Proceed warning button")
    public void clickProceedButton() {
        questionnairePage.clickProceedWarningButton();
    }

    @When("User clicks Add question tab button")
    public void clickAddTabButton() {
        questionnairePage.clickAddNewTabButton();
    }

    @When("User clicks Create Tab modal {string} button")
    public void clickCreateTabButton(String buttonName) {
        questionnairePage.clickCreateTabButton(buttonName);
    }

    @When("User clicks on Question tab with index {int}")
    public void clickOnQuestionTab(int tabIndex) {
        questionnairePage.clickOnTabButton(tabIndex);
    }

    @When("User clicks delete button for tab on position {int}")
    public void clickDeleteButtonForTabOnPosition(int tabIndex) {
        questionnairePage.clickOnDeleteTabButton(tabIndex);
    }

    @When("User fills {string} required questionnaire setup information")
    public void fillInRequiredQuestionnaireSetupInformation(String questionnaireReference) {
        GenericTestData<QuestionnaireData> questionnaireTestData =
                new JsonUiDataTransfer<QuestionnaireData>(QUESTIONNAIRE)
                        .getTestData()
                        .get(questionnaireReference);
        if (questionnaireTestData.getDataToEnter().getQuestionnaireName().isEmpty()) {
            if (questionnaireReference.contains(MAX_QUESTIONS_COUNT)) {
                questionnaireTestData.getDataToEnter().setQuestionnaireName("AUTO_TEST_180_" + randomUUID());
            } else {
                questionnaireTestData.getDataToEnter().setQuestionnaireName("AUTO_TEST_QUESTIONNAIRE_" + randomUUID());
            }
        }
        this.context.getScenarioContext().setContext(QUESTIONNAIRE_TEST_DATA, questionnaireTestData);
        questionnairePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        questionnairePage.fillQuestionnaireInformation(questionnaireTestData.getDataToEnter());
    }

    @When("User fills {string} required questionnaire setup information without context")
    public void fillInRequiredQuestionnaireSetupInformationNoContext(String questionnaireReference) {
        GenericTestData<QuestionnaireData> questionnaireTestData =
                new JsonUiDataTransfer<QuestionnaireData>(QUESTIONNAIRE).getTestData()
                        .get(questionnaireReference);
        if (questionnaireTestData.getDataToEnter().getQuestionnaireName().isEmpty()) {
            questionnaireTestData.getDataToEnter().setQuestionnaireName("AUTO_TEST_QUESTIONNAIRE_" + randomUUID());
        }
        questionnairePage.waitWhilePreloadProgressbarIsDisappeared();
        questionnairePage.fillQuestionnaireInformation(questionnaireTestData.getDataToEnter());
    }

    @When("User fills {string} required questionnaire setup information without save in context")
    public void fillInRequiredQuestionnaireSetupInformationWithoutSaveInContext(String questionnaireReference) {
        GenericTestData<QuestionnaireData> questionnaireTestData =
                new JsonUiDataTransfer<QuestionnaireData>(QUESTIONNAIRE).getTestData()
                        .get(questionnaireReference);
        if (questionnaireTestData.getDataToEnter().getQuestionnaireName().isEmpty()) {
            questionnaireTestData.getDataToEnter().setQuestionnaireName("AUTO_TEST_QUESTIONNAIRE_" + randomUUID());
        }
        questionnairePage.waitWhilePreloadProgressbarIsDisappeared();
        questionnairePage.fillQuestionnaireInformation(questionnaireTestData.getDataToEnter());
    }

    @When("User fills {string} required questionnaire scoring information")
    public void fillInRequiredQuestionnaireScoringInformation(String questionnaireReference) {
        if (questionnairePage.isAddScoringButtonDisplayed()) {
            clickAddScoringSchemeQuestionnaireButton();
        }
        fillInScoringInformation(questionnaireReference);
    }

    @When("User clicks Add Scoring Scheme questionnaire button")
    public void clickAddScoringSchemeQuestionnaireButton() {
        questionnairePage.clickAddScoringButton();
    }

    @When("User fills {string} scoring information")
    public void fillInScoringInformation(String questionnaireReference) {
        QuestionnaireData questionnaireTestData =
                new JsonUiDataTransfer<QuestionnaireData>(QUESTIONNAIRE).getTestData()
                        .get(questionnaireReference).getDataToEnter();
        scoringList.add(questionnaireTestData);
        this.context.getScenarioContext().setContext(QUESTIONNAIRE_SCORING_TEST_DATA, questionnaireTestData);
        this.context.getScenarioContext().setContext(QUESTIONNAIRE_SCORING_LIST, scoringList);
        questionnairePage.fillScoringName(questionnaireTestData.getScoringName());
        questionnairePage.fillScoringMinRange(questionnaireTestData.getScoringRangeFrom());
        questionnairePage.fillScoringToRange(questionnaireTestData.getScoringRangeTo());
        questionnairePage.fillLevelOfReviewer(questionnaireTestData.getLevelOfReviewer());
    }

    @When("User fills in Questionnaire scoring name {string}")
    public void fillInScoringName(String scoringName) {
        questionnairePage.fillScoringName(scoringName);
    }

    @When("User fills in Questionnaire scoring Min value {string}")
    public void fillInScoringMinValue(String minValue) {
        questionnairePage.fillScoringMinRange(minValue);
    }

    @When("User fills in Questionnaire scoring Max value {string}")
    public void fillInScoringMaxValue(String maxValue) {
        questionnairePage.fillScoringToRange(maxValue);
    }

    @When("User fills in Questionnaire scoring Level of Reviewer value {string}")
    public void fillInScoringLevelOfReviewerValue(String levelOfReviewer) {
        questionnairePage.fillLevelOfReviewer(levelOfReviewer);
    }

    @When("User clicks to edit Question tab name on position {int}")
    public void editTabName(int tabIndex) {
        questionnairePage.clickOnEditTabButton(tabIndex);
    }

    @When("User fills tab name {string} for tab and click save")
    public void fillInTabNameForTabOnPosition(String tabName) {
        questionnairePage.clearTabName();
        questionnairePage.fillTabName(tabName);
        questionnairePage.clickApproveEditButton();
    }

    @When("User selects {string} Reviewer {string} from drop-down")
    public void selectReviewerFromDropDown(String value, String dropDownLabel) {
        questionnairePage.clickOpenDropDownWithLabel(dropDownLabel);
        questionnairePage.selectDropDownValueWithText(value);
    }

    @When("User fills {string} Reviewer {string}")
    public void fillInReviewer(String value, String fillInField) {
        questionnairePage.clickOpenDropDownWithLabel(fillInField);
        questionnairePage.fillReviewerRuleValue(value, fillInField);
    }

    @When("User adds question with type {string} to active tab")
    public void addQuestionWithType(String type) {
        questionnairePage.waitWhilePreloadProgressbarIsDisappeared();
        questionnairePage.addQuestionTypeToTab(type);
    }

    @When("User clicks Configuration icon")
    public void clickConfigIcon() {
        questionnairePage.clickConfigButtonForQuestion(1);
    }

    @When("User clicks Configuration icon for Question {string}")
    public void clickConfigIcon(String questionName) {
        questionnairePage.clickConfigIconForQuestion(questionName);
    }

    @When("User clicks Configuration icon for Question on position {int}")
    public void clickConfigIconOnPosition(int position) {
        questionnairePage.clickConfigButtonForQuestion(position);
    }

    @When("^User toggles (?:Red Flag|Mandatory?) for choice \"((.*))\"$")
    public void toggleRedFlagForChoice(String choiceTitle) {
        questionnairePage.toggleForChoice(choiceTitle);
    }

    @When("User fills {string} question details")
    public void fillInQuestionName(String questionReference) {
        questionnairePage.waitWhilePreloadProgressbarIsDisappeared();
        QuestionnaireData questionTestData =
                (new JsonUiDataTransfer<QuestionnaireData>(QUESTIONNAIRE).getTestData()
                        .get(questionReference)).getDataToEnter();
        if (questionTestData.getQuestionName().isEmpty()) {
            questionTestData.setQuestionName("AUTO_TEST_QUESTION_" + randomUUID());
        }
        this.context.getScenarioContext().setContext(QUESTION_TEST_DATA, questionTestData);
        questionnairePage.fillInQuestionDetails(questionTestData);
    }

    @When("User toggles {string}")
    public void toggleCheckBox(String toggleName) {
        questionnairePage.toggleCheckbox(toggleName);
    }

    @When("User clicks {string} tab")
    public void clicksTab(String tabName) {
        questionnairePage.clickTabWithName(tabName);
    }

    @When("User clicks {string} questionnaire tab")
    public void clicksQuestionnaireTab(String tabName) {
        questionnairePage.clickQuestionnaireTabWithName(questionnairePage.getFromDictionaryIfExists(tabName));
    }

    @When("User clicks Edit questionnaire button")
    public void clickEditQuestionnaireButton() {
        questionnairePage.clickEditButton();
    }

    @When("User selects {string} questionnaire status")
    public void selectQuestionnaireStatus(String status) {
        if ((status.equals(ACTIVE.getStatus()) && !questionnairePage.isStatusActive()) ||
                (!status.equals(ACTIVE.getStatus()) && questionnairePage.isStatusActive())) {
            questionnairePage.clickStatusCheckbox();
        }
    }

    @When("User clears Questionnaire Name")
    public void clearQuestionnaireName() {
        questionnairePage.clearQuestionnaireName();
    }

    @When("User clicks delete question button for question on position {int}")
    public void clickDeleteQuestionButtonForQuestionOnPosition(int questionPosition) {
        questionnairePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        questionnairePage.clickDeleteIcon(questionPosition);
    }

    @When("User clicks delete button for score range on position {int}")
    public void clickDeleteButtonForScoreRangeOnPosition(int scoreRangePosition) {
        scoringList.removeIf(scoring -> scoring.getScoringName()
                .equals(questionnairePage.getQuestionnaireScoreName(scoreRangePosition)));
        questionnairePage.clickDeleteScoreIcon(scoreRangePosition);
    }

    @When("User clicks edit button for score range on position {int}")
    public void clickEditButtonForScoreRangeOnPosition(int scoreRangePosition) {
        String questionnaireScoreName = questionnairePage.getQuestionnaireScoreName(scoreRangePosition);
        scoringList.removeIf(scoring -> scoring.getScoringName().equals(questionnaireScoreName));
        questionnairePage.clickEditScoreIcon(scoreRangePosition);
    }

    @When("User fills in choice score on position {int} value {string}")
    public void fillInChoiceScoreOnPositionValue(int scorePosition, String scoreValue) {
        questionnairePage.fillInScoreValue(CHOICE_NAME + scorePosition, scoreValue);
    }

    @When("User adds up to {int} questions with multiply types for active tab")
    public void addsUpToQuestionsWithMultiplyTypesForTabOnPosition(int questionsCount) {
        for (int i = 1; i <= questionsCount; i++) {
            int count = 0;
            int maxTries = 5;
            while (questionnairePage.getActiveQuestionTabQuestionsCounter() != i && count++ < maxTries) {
                questionnairePage.addRandomQuestionTypeToTab();
            }
            logger.info("Question " + questionnairePage.getActiveQuestionTabQuestionsCounter() + "/" + questionsCount +
                                " was added");
        }
    }

    @When("User fills choice name {string} with value {string}")
    public void fillChoiceName(String choice, String value) {
        questionnairePage.waitWhilePreloadProgressbarIsDisappeared();
        questionnairePage.fillInChoiceName(choice, value);
    }

    @When("User selects Branch Question tab name {string} for choice {string}")
    public void selectTabNameForChoice(String tabName, String choice) {
        questionnairePage.selectTabNameForChoice(tabName, choice);
    }

    @When("User selects Branch Question question {string} for choice {string}")
    public void selectQuestionForChoice(String question, String choice) {
        questionnairePage.selectQuestionForChoice(question, choice);
    }

    @When("User clicks Mapping icon")
    public void clickMappingIcon() {
        questionnairePage.clickMappingIcon();
    }

    @When("User clicks Mapping icon for Question on position {int}")
    public void clickMappingIconOnPosition(int position) {
        questionnairePage.clickMappingButtonForQuestion(position);
    }

    @When("User hovers to Questionnaire Groups dropdown {int}")
    public void hoverToQstGroupsDropDown(int groupIndex) {
        questionnairePage.hoverToQstGroupsDropDown(groupIndex);
    }

    @When("User selects Questionnaire Group {int}")
    public void selectQstGroup(int groupIndex) {
        questionnairePage.selectQstGroup(groupIndex);
    }

    @When("User hovers to Questionnaire Group field")
    public void hoverToQstGroupField() {
        questionnairePage.hoverToQstGroupField();
    }

    @When("User fills tab name {string} for active tab")
    public void fillTabName(String tabName) {
        questionnairePage.fillTabName(tabName);
    }

    @When("User fills in Questionnaire Language {string}")
    public void fillInQuestionnaireLanguage(String language) {
        questionnairePage.fillQuestionnaireLanguage(List.of(language));
    }

    @When("User clicks remove icon for {string} Questionnaire language")
    public void clickRemoveIconForQuestionnaireLanguage(String language) {
        questionnairePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        questionnairePage.clickRemoveLanguage(language);
    }

    @When("User clicks Questionnaire Management breadcrumb")
    public void clickQuestionnaireManagementBreadcrumb() {
        questionnairePage.clickBreadcrumb();
    }

    @When("User fills in Questionnaire Name with value {string}")
    public void fillInQuestionnaireNameWithValue(String name) {
        questionnairePage.fillQuestionnaireName(name);
    }

    @When("User fills in Questionnaire Category with value {string}")
    public void fillInQuestionnaireCategoryWithValue(String category) {
        questionnairePage.fillQuestionnaireCategory(category);
    }

    @When("User fills in Questionnaire Description with value {string}")
    public void fillInQuestionnaireDescriptionWithValue(String description) {
        questionnairePage.fillQuestionnaireDescription(description);
    }

    @When("User selects in Question Assignee Type {string}")
    public void fillInQuestionnaireAssigneeTypeWithValue(String assigneeType) {
        questionnairePage.fillAssigneeType(assigneeType);
    }

    @When("User clicks Questionnaire Header Froala {string} button")
    public void clickQuestionnaireHeaderFroalaButton(String buttonName) {
        questionnairePage.clickOnFroalaButton(buttonName);
    }

    @When("User clicks Questionnaire Table Insert Froala {string} button")
    public void clickQuestionnaireTableInsertFroalaButton(String buttonName) {
        questionnairePage.clickOnTableInsertButton(buttonName);
    }

    @When("User clicks Quick Insert {string} button")
    public void clickQuickInsertButton(String buttonName) {
        questionnairePage.clickQuickInsertLink(buttonName);
    }

    @When("User fills in Questionnaire Header text {string} and click {string} Froala button")
    public void fillInQuestionnaireHeaderTextAndClickFroalaButton(String text, String buttonName) {
        questionnairePage.fillQuestionnaireHeader(text);
        questionnairePage.selectLastAddedText(text);
        questionnairePage.clickOnFroalaButton(buttonName);
        questionnairePage.moveToTheEndOfLine();
        questionnairePage.clickOnFroalaButton(buttonName);
    }

    @When("User clicks Questionnaire Header {string} content element")
    public void clickQuestionnaireHeaderContentElement(String elementName) {
        questionnairePage.clickHeaderContentElement(elementName);
    }

    @When("User clears Questionnaire Header")
    public void clearQuestionnaireHeader() {
        questionnairePage.clearQuestionnaireHeader();
    }

    @When("User clicks Froala Quick insert button")
    public void clickFroalaQuickInsertButton() {
        questionnairePage.clickQuickInsertButton();
    }

    @When("User configures question with data {string}")
    public void configureQuestionWithData(String dataReference) {
        QuestionData questionTestData = new JsonUiDataTransfer<QuestionData>(QUESTION).getTestData()
                .get(dataReference).getDataToEnter();
        questionnairePage.fillInQuestionConfigs(questionTestData);
    }

    @When("User clicks Create tab {string} radio button")
    public void clickCreateTabRadioButton(String radioButton) {
        questionnairePage.clickCreateTabRadioButton(radioButton);
    }

    @When("User selects Question Reviewer level {string}")
    public void selectQuestionReviewerLevel(String reviewerLevel) {
        questionnairePage.fillInQuestionReviewerLevel(reviewerLevel);
    }

    @When("User clicks Delete button for question {string} choice")
    public void clickDeleteButtonForQuestionChoice(String choice) {
        questionnairePage.clickDeleteChoiceButton(choice);
    }

    @When("User clicks Add button for question {string} choice")
    public void clickAddButtonForQuestionChoice(String choice) {
        questionnairePage.clickAddChoiceButton(choice);
    }

    @When("User clicks Questionnaire question configuration {string} button")
    public void clickQuestionnaireChoicesButton(String buttonName) {
        questionnairePage.clickChoiceButton(buttonName);
    }

    @When("User clicks Questionnaire question {string} button")
    public void clickQuestionnaireButton(String buttonName) {
        questionnairePage.clickQuestionButton(buttonName);
    }

    @When("User clicks Questionnaire Add Bulk Choices button {string}")
    public void clickQuestionnaireAddBulkChoicesButton(String buttonName) {
        questionnairePage.clickAddBulkChoicesButton(buttonName);
    }

    @When("User fills in Bulk Choices values")
    public void fillInBulkChoicesValues(List<String> values) {
        String choices = values.stream().map(value -> value + LF).collect(Collectors.joining());
        questionnairePage.fillInBulkChoiceValue(choices);
    }

    @When("User adds {int} new tabs with default {string} name")
    public void addNewTabsWithDefaultName(int tabCount, String expectedTabName) {
        addNewTabsWithDefaultNameAndUseType(tabCount, expectedTabName, RESPONDER_USE);
    }

    @When("User adds {int} new tabs with default {string} name with {string} use type")
    public void addNewTabsWithDefaultNameAndUseType(int tabCount, String expectedTabName, String useType) {
        questionnairePage.waitWhilePreloadProgressbarIsDisappeared();
        tabCountBeforeAdding = questionnairePage.getTabCount();
        int lastTabIndex = tabCountBeforeAdding - 1;
        questionnairePage.clickOnTabButton(lastTabIndex);
        for (int i = lastTabIndex + 1; i <= lastTabIndex + tabCount; i++) {
            if (questionnairePage.getQuestionCountForTab() == 0) {
                questionnairePage.addRandomQuestionTypeToTab();
            }
            questionnairePage.clickAddNewTabButton();
            questionnairePage.clickCreateTabRadioButton(useType);
            clickCreateTabButton(CREATE);
            questionnairePage.clickOnTabButton(i);
            tabNameIsDisplayedForTabOnPosition(expectedTabName, i + 1);
        }
    }

    @When("^User turns (On|Off) Calculate Highest Score Only question button$")
    public void turnOnCalculateHighestScoreOnlyQuestionButton(String state) {
        questionnairePage.checkCalculateHighestScoreOnly(state.equals(ON));
    }

    @When("User selects Question {string} {string} drop-down value")
    public void selectQuestionMapToDropDownValue(String dropDownLabel, String value) {
        if (context.getScenarioContext().isContains(value)) {
            value = (String) context.getScenarioContext().getContext(value);
        }
        questionnairePage.clickOpenDropDownWithLabel(dropDownLabel);
        if (value.equals(FIRST_AVAILABLE_VALUE)) {
            String firstAvailableDropDownValue = questionnairePage.getFirstAvailableDropDownValue();
            context.getScenarioContext().setContext(value, firstAvailableDropDownValue);
            value = firstAvailableDropDownValue;
        }
        questionnairePage.selectDropDownValueWithText(value);
    }

    @When("User clicks clear icon for {string} drop-down value")
    public void clickClearIconForDropDownValue(String dropDownLabel) {
        questionnairePage.clickClearDropDownButton(dropDownLabel);
    }

    @When("User clears next fields values")
    public void clickClearIconForDropDownValues(DataTable dataTable) {
        dataTable.asList().forEach(questionnairePage::clearField);
    }

    @When("User clicks clear mapping button")
    public void clickClearMappingButton() {
        questionnairePage.clickClearMappingButton();
    }

    @When("User fills in {int} Bulk Choices {string} values")
    @SuppressWarnings("unchecked")
    public void fillInBulkChoicesValues(int count, String dataReference) {
        int limit = 250 - parseInt(questionnairePage.getAddedChoicesCount(CHOICES));
        List<QuestionData.Choice> bulkChoices = new ArrayList<>();
        if (context.getScenarioContext().isContains(dataReference)) {
            bulkChoices = (List<QuestionData.Choice>) context.getScenarioContext().getContext(dataReference);
        }
        StringBuilder choices = new StringBuilder();
        ThreadLocalRandom current = ThreadLocalRandom.current();
        for (int i = 0; i < count; i++) {
            String name = randomAlphanumeric(current.nextInt(1, parseInt(CHOICE_MAX_LENGTH)));
            int score = current.nextInt(1, SCORE_MAX_VALUE);
            String value = name + VERTICAL_BAR + score;
            bulkChoices.add(new QuestionData.Choice().setChoice(name).setScore(String.valueOf(score)));
            choices.append(value).append(LF);
        }
        questionnairePage.fillInBulkChoiceValue(choices.toString());
        context.getScenarioContext()
                .setContext(dataReference, bulkChoices.stream().limit(limit).collect(Collectors.toList()));
    }

    @When("User clicks Delete button for question Choice #{int} bulk added {string} Bulk Choices")
    @SuppressWarnings("unchecked")
    public void clicksDeleteButtonForQuestionChoiceBulkAddedBulkChoices(int position, String dataReference) {
        List<QuestionData.Choice> addedChoices =
                (List<QuestionData.Choice>) context.getScenarioContext().getContext(dataReference);
        addedChoices.remove(addedChoices.size() - 1);
        questionnairePage.clickDeleteChoiceButton(CHOICE_NAME + position);
        context.getScenarioContext().setContext(dataReference, addedChoices);
    }

    @When("User clicks {string} EnhancedTextEntryPlus option")
    public void clickEnhancedTextEntryPlusOption(String option) {
        questionnairePage.clickEnhancedTextEntryPlusOption(option);
    }

    @When("^User (checks|unchecks) EnhancedTextEntryPlus modal fields$")
    public void clickEnhancedTextEntryPlusModalFields(String state, List<String> fields) {
        fields.forEach(field -> {
            if ((questionnairePage.isModalCheckboxChecked(field) && state.equals(UNCHECKS)) ||
                    (!questionnairePage.isModalCheckboxChecked(field) && state.equals(CHECKS))) {
                questionnairePage.clickModalCheckbox(field);
            }
        });
    }

    @When("User clicks EnhancedTextEntryPlus modal {string} button")
    public void clickEnhancedTextEntryPlusModalButton(String buttonName) {
        questionnairePage.clickModalButton(buttonName);
    }

    @When("User clicks Type input field with label {string}")
    public void clickTypeInputFieldWithLabel(String label) {
        questionnairePage.clickTypeInput(label);
    }

    @When("^User (unselects|selects) questionnaire Part Type configuration \"(.*)\"$")
    public void selectQuestionnairePartTypeConfiguration(String action, String type) {
        if (action.contains(UNSELECT)) {
            questionnairePage.unSelectPartType(type);
        } else {
            questionnairePage.selectPartType(type);
        }
    }

    @When("User clicks Add button for question {string} choice for part type {string}")
    public void clickAddButtonForQuestionChoiceForPartType(String subQuestion, String partType) {
        questionnairePage.clickAddSubQuestionButton(partType, subQuestion);
    }

    @Then("Add Questionnaire setup page displayed")
    public void addQuestionnaireSetupPageDisplayed() {
        questionnairePage.waitWhilePreloadProgressbarIsDisappeared();
        assertTrue("Add Questionnaire Wizard is not displayed", questionnairePage.isPageDisplayed());
    }

    @Then("{string} Tab is displayed")
    public void tabIsDisplayed(String tabName) {
        assertTrue(tabName + " Tab is not displayed", questionnairePage.isTabDisplayed(tabName));
    }

    @Then("Question tab count contains {int} new tabs")
    public void validateTabsCount(int tabCount) {
        assertThat(questionnairePage.getTabCount())
                .as("Question tabs count is not expected")
                .isEqualTo(tabCountBeforeAdding + tabCount);
    }

    @Then("User should be able to add up to {int} questions with multiply types for active tab")
    public void validateAbilityToAddTabs(int questionsCount) {
        addsUpToQuestionsWithMultiplyTypesForTabOnPosition(questionsCount);
        assertThat(questionnairePage.getActiveQuestionTabQuestionsCounter())
                .as("Question tabs count is not expected")
                .isEqualTo(questionsCount);
    }

    @Then("Added Question Name is displayed")
    public void addedQuestionNameIsDisplayed() {
        QuestionnaireData questionTestData =
                (QuestionnaireData) context.getScenarioContext().getContext(QUESTION_TEST_DATA);
        assertThat(questionnairePage.getQuestionName(1))
                .as("Question name is unexpected")
                .isEqualTo(questionTestData.getQuestionName());
    }

    @Then("Attachment label is displayed")
    public void attachmentLabelIsDisplayed() {
        assertThat(questionnairePage.attachmentLabelIsDisplayed())
                .as("Attachment label is not displayed")
                .isTrue();
    }

    @Then("User should be able to edit Question tab name with {int} characters name")
    public void validateAbilityToEditTab(int nameLength) {
        int tabIndex = questionnairePage.getTabCount();
        String name = RandomStringUtils.randomAlphanumeric(nameLength);
        questionnairePage.clickOnEditTabButton(tabIndex);
        questionnairePage.fillTabName(name);
        questionnairePage.waitWhilePreloadProgressbarIsDisappeared();
        questionnairePage.clickApproveEditButton();
        tabNameIsDisplayedForTabOnPosition(name, tabIndex);
    }

    @Then("Manage buttons are displayed for each added question type")
    public void manageButtonsAreDisplayedForEachAddedQuestionType() {
        for (int i = 1; i <= questionnairePage.getQuestionCountForTab(); i++) {
            assertTrue("Configure button is not displayed for question No" + i,
                       questionnairePage.isConfigIconDisplayed(i));
            assertTrue("Delete button is not displayed for question No" + i,
                       questionnairePage.isDeleteButtonForQuestion(i));
        }
    }

    @Then("Questionnaire Scores are displayed on scoring table with provided details")
    @SuppressWarnings("unchecked")
    public void scoreIsDisplayedOnScoringTable() {
        List<QuestionnaireData> questionnaireTestData = (List<QuestionnaireData>) context.getScenarioContext()
                .getContext(QUESTIONNAIRE_SCORING_LIST);
        List<QuestionnaireData> expectedData =
                questionnaireTestData.stream()
                        .map(data -> new QuestionnaireData()
                                .setScoringName(data.getScoringName())
                                .setScoringRange(data.getScoringRangeFrom() + DASH + data.getScoringRangeTo())
                                .setLevelOfReviewer(isNull(data.getLevelOfReviewer()) ? DEFAULT_LEVEL_OF_REVIEWER :
                                                            data.getLevelOfReviewer()))
                        .distinct()
                        .collect(Collectors.toList());
        List<QuestionnaireData> questionnaireScores = questionnairePage.getQuestionnaireScores();
        assertThat(questionnaireScores)
                .as("Scoring table rows are unexpected")
                .containsExactlyInAnyOrderElementsOf(expectedData);
    }

    @Then("Score is not displayed on scoring table")
    public void scoreIsNotDisplayedOnScoringTable() {
        QuestionnaireData questionnaireTestData = (QuestionnaireData) context.getScenarioContext()
                .getContext(QUESTIONNAIRE_SCORING_TEST_DATA);
        scoreNameIsNotDisplayedOnScoringTable(questionnaireTestData.getScoringName());
    }

    @Then("Score {string} is not displayed on scoring table")
    public void scoreNameIsNotDisplayedOnScoringTable(String expectedScoringName) {
        assertThat(questionnairePage.isScoreWithNameDisplayedInTable(expectedScoringName))
                .as("Score with name %s is displayed", expectedScoringName).isFalse();
    }

    @Then("Questionnaire Name field is displayed as required")
    public void questionnaireNameFieldIsDisplayedAsRequired() {
        assertTrue("Questionnaire Name  field is not displayed as required",
                   questionnairePage.getQuestionnaireNameLabelValue().contains(REQUIRED_INDICATOR));
    }

    @Then("Alert Icon for Questionnaire page is displayed with text")
    public void alertIconIsDisplayedWithText(DataTable dataTable) {
        assertTrue("Alert Icon is not displayed", questionnairePage.isAlertIconDisplayed());
        dataTable = adjustMessageWithTranslations(dataTable);
        String actualAlertMessage = questionnairePage.getAlertIconTextWithWait(dataTable.asList().get(1));
        dataTable.asList().forEach(text -> assertThat(actualAlertMessage)
                .as("Actual alert message '%s' doesn't contain expected text '%s'", actualAlertMessage, text)
                .contains(text));
    }

    @Then("Question contains {int} tabs")
    public void questionContainsTabs(int expectedTabCount) {
        assertEquals("Question tabs count is not expected", expectedTabCount,
                     questionnairePage.getInformationContentTabCount());
    }

    @Then("Tab on position {int} contains {int} questions")
    public void tabOnPositionContainsQuestions(int tabIndex, int expectedQuestionCount) {
        questionnairePage.clickTabButton(tabIndex);
        assertThat(questionnairePage.getActiveQuestionTabQuestionsCounter())
                .as("Question tabs count is not expected")
                .isEqualTo(expectedQuestionCount);
    }

    @Then("Warning Message is displayed with text")
    public void warningMessageIsDisplayedWithText(DataTable dataTable) {
        assertTrue("Warning Message is not displayed", questionnairePage.isWarningMessageDisplayed());
        List<String> expectedWarningMessage = dataTable.asList();
        String actualWarningMessage = questionnairePage.getWarningMessageText();
        expectedWarningMessage.forEach(text ->
                                               assertTrue("Actual alert message '" + actualWarningMessage +
                                                                  "' doesn't contain expected text '" + text + "'",
                                                          actualWarningMessage.contains(text)));
    }

    @Then("Question setting page contains {int} tabs")
    public void questionSettingPageContainsTabs(int expectedCount) {
        assertEquals("Question tabs count is not expected", expectedCount, questionnairePage.getTabCount());
    }

    @Then("^Question tab Plus icon is (disabled|enabled)$")
    public void plusIconIsDisabled(String state) {
        assertThat(questionnairePage.isPlusButtonDisabled())
                .as("Plus icon is not %s", state)
                .isEqualTo(state.equals(DISABLED));
    }

    @Then("Tab name {string} is displayed for tab on position {int}")
    public void tabNameIsDisplayedForTabOnPosition(String expectedName, int tabIndex) {
        assertEquals("Tab name is not expected", expectedName.toUpperCase(),
                     questionnairePage.getTabName(tabIndex).toUpperCase());
    }

    @Then("Choices are not displayed")
    public void choicesAreNotDisplayed() {
        assertFalse("Choices are displayed", questionnairePage.areChoicesDisplayed());
    }

    @Then("Question fields contains provided data")
    public void questionFieldsContainsProvidedData() {
        QuestionnaireData questionTestData =
                (QuestionnaireData) context.getScenarioContext().getContext(QUESTION_TEST_DATA);
        assertEquals("Question 'Question' field doesn't contain provided data", questionTestData.getQuestionName(),
                     questionnairePage.getQuestionFroalaTextValue());
        assertEquals("Question 'Help Text' field doesn't contain provided data", questionTestData.getHelpText(),
                     questionnairePage.getHelpTextValue());
    }

    @Then("Scoring tab contains message {string}")
    public void scoringTabContainsMessage(String expectedMessage) {
        assertEquals("Scoring tab doesn't contain expected message", expectedMessage,
                     questionnairePage.getScoringMessage());
    }

    @Then("Scoring tab form contains message {string}")
    public void scoringTabFormContainsMessage(String expectedMessage) {
        assertEquals("Scoring tab form doesn't contain expected message", expectedMessage,
                     questionnairePage.getScoringFormMessage());
    }

    @Then("Questionnaire's Setup Information page contains provided details")
    @SuppressWarnings("unchecked")
    public void addQuestionnaireSetupPageContainsProvidedDetails() {
        questionnairePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        QuestionnaireData testData = ((GenericTestData<QuestionnaireData>) this.context.getScenarioContext()
                .getContext(QUESTIONNAIRE_TEST_DATA)).getDataToEnter();
        QuestionnaireData expectedDetails =
                new QuestionnaireData().setQuestionnaireName(testData.getQuestionnaireName())
                        .setCategory(testData.getCategory())
                        .setDescription(testData.getDescription())
                        .setHeader(testData.getHeader());
        if (isNull(testData.getLanguage()) || testData.getLanguage().isEmpty()) {
            expectedDetails.setLanguage(List.of(QuestionnaireConstants.DEFAULT_QUESTIONNAIRE_LANGUAGE));
        } else {
            expectedDetails.setLanguage(testData.getLanguage());
        }
        if (!expectedDetails.getLanguage().contains(QuestionnaireConstants.DEFAULT_QUESTIONNAIRE_LANGUAGE)) {
            expectedDetails.getLanguage().add(QuestionnaireConstants.DEFAULT_QUESTIONNAIRE_LANGUAGE);
        }
        if (isNull(testData.getAssigneeType()) || testData.getAssigneeType().isEmpty()) {
            expectedDetails.setAssigneeType(DEFAULT_ASSIGNEE_TYPE);
        } else {
            expectedDetails.setAssigneeType(testData.getAssigneeType());
        }
        QuestionnaireData actualDetails = questionnairePage.getSetupInformation();
        assertThat(actualDetails).usingRecursiveComparison().ignoringFields("assigneeType").ignoringCollectionOrder()
                .as("Questionnaire's Setup Information page doesn't contain provided details")
                .isEqualTo(expectedDetails);
    }

    @Then("^Questionnaire Setup button \"((.*))\" is (displayed|enabled|not displayed|disabled)$")
    public void questionnaireButtonIs(String buttonName, String state) {
        questionnairePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (state.equalsIgnoreCase(DISPLAYED)) {
            assertThat(questionnairePage.isButtonWithNameDisplayed(buttonName))
                    .as("%s questionnaire button is not displayed", buttonName)
                    .isTrue();
        } else if (state.contains(NOT)) {
            assertThat(questionnairePage.isButtonWithNameDisplayed(buttonName))
                    .as("%s questionnaire button is displayed", buttonName)
                    .isFalse();
        } else if (state.equalsIgnoreCase(DISABLED)) {
            assertThat(questionnairePage.isButtonWithNameDisabled(buttonName))
                    .as("%s questionnaire button is not disabled", buttonName)
                    .isTrue();
        } else {
            assertThat(questionnairePage.isButtonWithNameDisabled(buttonName))
                    .as("%s questionnaire button is not enabled", buttonName)
                    .isFalse();
        }
    }

    @Then("^Questionnaire tab displayed in (edit|view) mode$")
    public void questionnaireTabDisplayedInEditMode(String mode) {
        if (mode.equalsIgnoreCase(VIEW)) {
            assertThat(!questionnairePage.isEditModeDisplayed() && questionnairePage.isEditButtonDisplayed())
                    .as("Questionnaire tab is not displayed in view mode")
                    .isTrue();
        } else {
            assertThat(questionnairePage.isEditModeDisplayed())
                    .as("Questionnaire tab is not displayed in edit mode")
                    .isTrue();
        }
    }

    @Then("^Questionnaire Category drop-down (contains|does not contain) values$")
    public void questionnaireCategoryDropDownContainsValues(String state, List<String> expectedValues) {
        SoftAssertions softAssert = new SoftAssertions();
        questionnairePage.clickCategoryInput();
        List<String> categoryDropDownValues = questionnairePage.getDropDownValues();
        expectedValues.forEach(value -> {
            if (value.contains(VALUE_TO_REPLACE)) {
                value = (String) context.getScenarioContext().getContext(value);
            }
            if (state.contains(NOT)) {
                softAssert.assertThat(categoryDropDownValues)
                        .as("Questionnaire Category drop-down contains value " + value)
                        .doesNotContain(value);
            } else {
                softAssert.assertThat(categoryDropDownValues)
                        .as("Value Management table does not contain value " + value)
                        .contains(value);
            }
        });
        softAssert.assertAll();
    }

    @Then("^Questionnaire Groups field is (displayed|not displayed)$")
    public void groupsFieldIsDisplayed(String state) {
        boolean isDisplayed = !state.contains(NOT);
        assertThat(questionnairePage.isQstGroupsFieldDisplayed()).as("Groups field is not in state %s", state)
                .isEqualTo(isDisplayed);
    }

    @Then("Questionnaire Groups field value is default to {string}")
    public void groupsFieldValueIsDefaultTo(String groupValue) {
        assertThat(questionnairePage.getQstGroupsValue()).as("Default value is incorrect").isEqualTo(groupValue);
    }

    @Then("Questionnaire Groups tooltip {string} is displayed")
    public void groupTooltipIsDisplayed(String groupToolTip) {
        assertThat(questionnairePage.getQstGroupTooltip()).as(
                        "Expected Group Tooltip is not displayed")
                .isEqualTo(groupToolTip);
    }

    @Then("Questionnaire Header Froala Quick Insert link buttons are displayed")
    public void questionnaireHeaderFroalaQuickInsertLinkButtonsAreDisplayed(List<String> linkNames) {
        SoftAssertions softAssertions = new SoftAssertions();
        linkNames.forEach(
                linksName -> softAssertions.assertThat(questionnairePage.isQuickInsertLinkDisplayed(linksName))
                        .as("Froala Quick Insert link button %s is not displayed", linksName)
                        .isTrue());
        softAssertions.assertAll();
    }

    @Then("Questionnaire Header Froala Table Insert link buttons are displayed")
    public void questionnaireHeaderFroalaTableInsertLinkButtonsAreDisplayed(List<String> linkNames) {
        SoftAssertions softAssertions = new SoftAssertions();
        linkNames.forEach(
                linksName -> softAssertions.assertThat(questionnairePage.isTableInsertLinkDisplayed(linksName))
                        .as("Froala Table Insert link button %s is not displayed", linksName)
                        .isTrue());
        softAssertions.assertAll();
    }

    @Then("^Questionnaire setup \"((.*))\" tab is (active|disabled|selected)$")
    public void questionnaireSetupTabIsActive(String tabName, String state) {
        if (state.equalsIgnoreCase(ACTIVE.getStatus())) {
            assertThat(questionnairePage.isTabSelected(tabName))
                    .as("%s tab is selected", tabName)
                    .isFalse();
            assertThat(questionnairePage.isTabDisabled(tabName))
                    .as("%s tab is disabled", tabName)
                    .isFalse();
        } else if (state.equalsIgnoreCase(DISABLED)) {
            assertThat(questionnairePage.isTabDisabled(tabName))
                    .as("%s tab is not disabled", tabName)
                    .isTrue();
        } else {
            assertThat(questionnairePage.isTabSelected(tabName))
                    .as("%s tab is not selected", tabName)
                    .isTrue();

        }
    }

    @Then("Questionnaire languages are displayed {string}")
    public void questionnaireLanguagesAreDisplayed(String expectedResult) {
        assertThat(questionnairePage.getSetupInformationQuestionnaireLanguage())
                .as("Questionnaire languages are unexpected")
                .containsExactlyInAnyOrderElementsOf(asList(expectedResult.split(TestConstants.COMMA)));
    }

    @Then("Remove icon is displayed for each selected language for Questionnaire")
    public void removeIconIsDisplayedForEachSelectedLanguageForQuestionnaire() {
        SoftAssertions softAssertions = new SoftAssertions();
        questionnairePage.getSetupInformationQuestionnaireLanguage()
                .forEach(language -> assertThat(questionnairePage.idRemoveLanguageDisplayed(language))
                        .as("Questionnaire languages are unexpected")
                        .isTrue());
        softAssertions.assertAll();
    }

    @Then("Error message {string} is displayed for Questionnaire {string} field")
    public void errorMessageIsDisplayedForQuestionnaireField(String errorMessage, String fieldName) {
        assertThat(questionnairePage.getErrorMessageText(fieldName))
                .as("Error message is unexpected for %s field", fieldName)
                .isEqualTo(errorMessage);
    }

    @Then("Questionnaire Header Froala buttons are displayed")
    public void questionnaireHeaderFroalaButtonsAreDisplayed(List<String> buttons) {
        SoftAssertions softAssertions = new SoftAssertions();
        buttons.forEach(button -> softAssertions.assertThat(questionnairePage.isFroalaButtonDisplayed(button))
                .as("Froala button %s is not displayed", button)
                .isTrue());
        softAssertions.assertAll();
    }

    @Then("Questionnaire Header Froala {string} options are displayed")
    public void questionnaireHeaderFroalaOptionsAreDisplayed(String section, List<String> options) {
        SoftAssertions softAssertions = new SoftAssertions();
        options.forEach(option -> softAssertions.assertThat(questionnairePage.isFroalaOptionDisplayed(section, option))
                .as("Froala option %s is not displayed", option)
                .isTrue());
        softAssertions.assertAll();
    }

    @Then("Questionnaire Header Froala Character counter is displayed")
    public void questionnaireHeaderFroalaCharacterCounterIsDisplayed() {
        assertThat(questionnairePage.isCounterLabelDisplayed())
                .as("Character counter is not displayed")
                .isTrue();
    }

    @Then("Questionnaire View Froala text contains strong element with text {string}")
    public void questionnaireViewHeaderTextContainsStrongElementWithText(String expectedText) {
        assertThat(questionnairePage.isStrongHeaderTextDisplayed(expectedText))
                .as("Header Strong element with text %s is not displayed", expectedText)
                .isTrue();
    }

    @Then("Questionnaire View Froala text contains element with text {string} and style {string}")
    public void questionnaireViewHeaderTextContainsElementWithTextAndStyle(String expectedText, String expectedStyle) {
        assertThat(questionnairePage.isHeaderTextWithStyleDisplayed(expectedText, expectedStyle))
                .as("Header element with text %s and style %s is not displayed", expectedText, expectedStyle)
                .isTrue();
    }

    @Then("Questionnaire Information contains expected fields types")
    public void questionnaireInformationContainsExpectedFieldsTypesWithData() {
        SoftAssertions softAssertions = new SoftAssertions();
        questionnairePage.clickLanguageInput();
        softAssertions.assertThat(questionnairePage.getDropDownValues())
                .as("Questionnaire Languages list is unexpected")
                .isEqualTo(getLanguagesResponse().getObjects().stream().map(LanguageResponse.Language::getDescription)
                                   .collect(
                                           Collectors.toList()));
        questionnairePage.clickLanguageInput();
        softAssertions.assertThat(
                        questionnairePage.isLanguageClickable(QuestionnaireConstants.DEFAULT_QUESTIONNAIRE_LANGUAGE))
                .as("English Language is deletable")
                .isFalse();
        softAssertions.assertThat(questionnairePage.isSetupInformationSectionDisplayed())
                .as("Setup Information section name is not displayed")
                .isTrue();
        softAssertions.assertThat(questionnairePage.getSetupInformationQuestionnaireNameMaxLength())
                .as("Questionnaire Name character limit is unexpected")
                .isEqualTo(NAME_MAX_LENGTH);
        questionnairePage.clickCategoryInput();
        softAssertions.assertThat(questionnairePage.getDropDownValues())
                .as("Questionnaire Category list is unexpected")
                .isEqualTo(getQuestionnaireCategoryList());
        questionnairePage.clickCategoryInput();
        softAssertions.assertThat(questionnairePage.getQuestionnaireInputLabelValue(QUESTIONNAIRE_CATEGORY))
                .as("Questionnaire Category is not optional")
                .isNull();
        softAssertions.assertThat(questionnairePage.getQuestionnaireInputLabelValue(QuestionnaireConstants.DESCRIPTION))
                .as("Description is not optional")
                .isNull();
        softAssertions.assertThat(questionnairePage.getSetupInformationDescriptionMaxLength())
                .as("Questionnaire Description character limit is unexpected")
                .isEqualTo(DESCRIPTION_MAX_LENGTH);
        softAssertions.assertThat(questionnairePage.areAssigneeTypeRadioButtonsDisplayed())
                .as("Radio buttons Internal & External are not displayed")
                .isTrue();
        softAssertions.assertAll();
    }

    @Then("Questionnaire Information contains expected fields with default data")
    public void questionnaireInformationContainsExpectedFieldsWithDefaultData() {
        SoftAssertions softAssertions = new SoftAssertions();
        softAssertions.assertThat(questionnairePage.getSetupInformationQuestionnaireLanguage())
                .as("English is not the default language")
                .containsOnly(QuestionnaireConstants.DEFAULT_QUESTIONNAIRE_LANGUAGE);
        softAssertions.assertThat(questionnairePage.getCounterLabel())
                .as("Questionnaire Header Counter character limit is unexpected")
                .contains(FROALA_COUNTER_MAX);
        softAssertions.assertThat(questionnairePage.getSetupInformationQuestionnaireAssignee())
                .as("Internal is not selected by default")
                .isEqualTo(DEFAULT_ASSIGNEE_TYPE);
        softAssertions.assertAll();
    }

    @Then("Questionnaire Management questionnaire status is {string}")
    public void questionnaireManagementQuestionnaireStatusIs(String expectedStatus) {
        assertThat(questionnairePage.isStatusActive())
                .as("Questionnaire status is unexpected")
                .isEqualTo(ACTIVE.getStatus().equalsIgnoreCase(expectedStatus));

    }

    @Then("Questionnaire Reviewers Setting toggles are set to {string} and {string} drop-down")
    public void questionnaireReviewersSettingTogglesAreSetToAndDropDown(String toggleState, String dropDownState,
            Map<String, String> toggles) {
        boolean expectedToggleState = toggleState.equalsIgnoreCase(ON);
        boolean expectedDropDownState = dropDownState.equalsIgnoreCase(ENABLED);
        SoftAssertions softAssertions = new SoftAssertions();
        toggles.keySet().forEach(
                toggle -> {
                    softAssertions.assertThat(questionnairePage.isToggleChecked(toggle))
                            .as("Reviewers toggle state is unexpected")
                            .isEqualTo(expectedToggleState);
                    softAssertions.assertThat(
                                    questionnairePage.isToggleDropDownInputDisplayed(toggle, toggles.get(toggle)))
                            .as("Reviewers toggle dropdown state is unexpected")
                            .isEqualTo(expectedDropDownState);
                }
        );
        softAssertions.assertAll();
    }

    @Then("Questionnaire {string} tab is highlighted")
    public void questionnaireReviewersTabIsHighlighted(String tabName) {
        assertThat(questionnairePage.isTabHighlightedInRed(tabName))
                .as("Tab %s is not highlighted", tabName)
                .isTrue();
    }

    @Then("Questionnaire form Scoring Name field max length is {string} symbols")
    public void questionnaireFormScoringNameFieldMaxLengthIsSymbols(String expectedLength) {
        assertThat(questionnairePage.getScoringNameMaxLength())
                .as("Scoring Name field max length is unexpected")
                .isEqualTo(expectedLength);
    }

    @Then("^Questionnaire form \"((.*))\" field (is|is not) required$")
    public void questionnaireFormFieldIsRequired(String fieldName, String state) {
        if (state.contains(NOT)) {
            assertThat(questionnairePage.getQuestionnaireInputLabelValue(fieldName))
                    .as("Questionnaire %s field is displayed as required", fieldName)
                    .isNull();
        } else {
            assertThat(questionnairePage.getQuestionnaireInputLabelValue(fieldName))
                    .as("Questionnaire %s field is not displayed as required", fieldName)
                    .contains(REQUIRED_INDICATOR);
        }
    }

    @Then("Questionnaire form selected Scoring Level of Reviewer is {string}")
    public void questionnaireFormSelectedScoringLevelOfReviewerIs(String expectedLevel) {
        assertThat(questionnairePage.getScoringLevelOfReviewer())
                .as("Scoring Level of Reviewer is unexpected")
                .isEqualTo(expectedLevel);
    }

    @Then("Questionnaire scoring Min value is {string}")
    public void questionnaireScoringMinValueIs(String expectedValue) {
        assertThat(questionnairePage.getScoringMinValue())
                .as("Scoring Min value is unexpected")
                .isEqualTo(expectedValue);
    }

    @Then("Questionnaire Scoring table is displayed with columns and expected buttons")
    public void questionnaireScoringTableIsDisplayedWithColumnsAndExpectedButtons(List<String> expectedColumns) {
        SoftAssertions softAssertions = new SoftAssertions();
        softAssertions.assertThat(questionnairePage.getTableHeaders())
                .as("Scoring Table columns are unexpected")
                .isEqualTo(expectedColumns);
        softAssertions.assertThat(questionnairePage.areScoringTableEditButtonsDisplayed())
                .as("Scoring table Edit buttons are not displayed")
                .isTrue();
        softAssertions.assertThat(questionnairePage.areScoringTableDeleteButtonsDisplayed())
                .as("Scoring table Delete buttons are not displayed")
                .isTrue();
        softAssertions.assertAll();
    }

    @Then("Questionnaire scoring input fields contains expected {string} data")
    public void questionnaireScoringInputFieldsContainsExpectedData(String questionReference) {
        QuestionnaireData questionTestData =
                (new JsonUiDataTransfer<QuestionnaireData>(QUESTIONNAIRE).getTestData()
                        .get(questionReference)).getDataToEnter();
        SoftAssertions softAssertions = new SoftAssertions();
        softAssertions.assertThat(questionnairePage.getScoringNameValue())
                .as("Scoring Name input value is unexpected")
                .isEqualTo(questionTestData.getScoringName());
        softAssertions.assertThat(questionnairePage.getScoringMinValue())
                .as("Scoring Min input value is unexpected")
                .isEqualTo(questionTestData.getScoringRangeFrom());
        softAssertions.assertThat(questionnairePage.getScoringMaxValue())
                .as("Scoring Max input value is unexpected")
                .isEqualTo(questionTestData.getScoringRangeTo());
        softAssertions.assertThat(questionnairePage.getScoringLevelOfReviewer())
                .as("Scoring Level Of Reviewer input value is unexpected")
                .isEqualTo(questionTestData.getLevelOfReviewer());
        softAssertions.assertAll();
    }

    @Then("Question configuration contains expected data {string}")
    public void questionConfigurationContainsExpectedData(String dataReference) {
        QuestionData expectedResult = new JsonUiDataTransfer<QuestionData>(QUESTION).getTestData()
                .get(dataReference).getDataToEnter();
        assertThat(questionnairePage.getQuestionConfigData()).usingRecursiveComparison().ignoringCollectionOrder()
                .ignoringFields("subQuestions.option")
                .as("Question configuration data is unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("Question configuration Choices contain expected data {string}")
    public void questionConfigurationChoicesContainsExpectedData(String dataReference) {
        QuestionData expectedResult = new JsonUiDataTransfer<QuestionData>(QUESTION).getTestData()
                .get(dataReference).getDataToEnter();
        assertThat(questionnairePage.getChoicesValues())
                .usingRecursiveFieldByFieldElementComparatorIgnoringFields("isRedFlag", "option")
                .as("Question Choices configuration data is unexpected")
                .containsAll(expectedResult.getChoices());
    }

    @Then("Question configuration contains expected data {string} with Custom Field mapped {string} choices")
    public void configurationContainsDataWithCustomFieldMappedChoices(String dataReference, String customFieldType) {
        QuestionData expectedResult = new JsonUiDataTransfer<QuestionData>(QUESTION).getTestData()
                .get(dataReference).getDataToEnter();
        getCustomFieldTypeValues(customFieldType).forEach(value -> {
            expectedResult.getChoices().add(new QuestionData.Choice().setChoice(value)
                                                    .setScore(TestConstants.ZERO)
                                                    .setIsRedFlag(false));
            expectedResult.getBranchQuestion().add(new QuestionData.BranchQuestion().setIsChoiceIs(value));
        });
        assertThat(questionnairePage.getQuestionConfigData())
                .as("Question configuration data is unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("Questionnaire {string} question on position {int} is displayed with default elements")
    public void questionnaireBooleanQuestionIsDisplayedWithDefaultElements(String questionType, int position) {
        SoftAssertions softAssertions = new SoftAssertions();
        softAssertions.assertThat(questionnairePage.isQIDDisplayed(position))
                .as("Question QID is not displayed")
                .isTrue();
        softAssertions.assertThat(questionnairePage.isConfigIconDisplayed(position))
                .as("Question Configuration icon is not displayed")
                .isTrue();
        softAssertions.assertThat(questionnairePage.isDeleteButtonForQuestion(position))
                .as("Question Delete icon is not displayed")
                .isTrue();
        softAssertions.assertThat(questionnairePage.getQuestionName(position))
                .as("Question name is unexpected")
                .isEqualTo(questionType);
        if (getQuestionType(questionType) == QuestionType.BOOLEAN) {
            List<String> defaultBooleanOptions = asList("Yes (Score 0)", "No (Score 0)");
            softAssertions.assertThat(questionnairePage.getQuestionOptions())
                    .as("Boolean question default options are unexpected")
                    .isEqualTo(defaultBooleanOptions);
        } else if (getQuestionType(questionType) == QuestionType.CHECKBOX) {
            List<String> defaultBooleanOptions = asList("Check (Score 0)", "Check (Score 0)", "Check (Score 0)");
            softAssertions.assertThat(questionnairePage.getQuestionOptions())
                    .as("Checkbox question default options are unexpected")
                    .isEqualTo(defaultBooleanOptions);
        } else if (getQuestionType(questionType) == QuestionType.TEXT ||
                getQuestionType(questionType) == QuestionType.NUMBER) {
            softAssertions.assertThat(questionnairePage.isMappingIconDisplayed(position))
                    .as("Question Mapping icon is not displayed")
                    .isTrue();
        } else if (getQuestionType(questionType) == QuestionType.CURRENCY) {
            softAssertions.assertThat(questionnairePage.isDropDownWithLabelDisplayed(questionType))
                    .as("Currency Drop-down is not displayed")
                    .isTrue();
            softAssertions.assertThat(questionnairePage.isCurrencyTextFieldReadOnly())
                    .as("Currency text field is not read only")
                    .isTrue();
        } else if (getQuestionType(questionType) == QuestionType.DATE) {
            softAssertions.assertThat(questionnairePage.isInputWithLabelDisabled(questionType))
                    .as("Date input is not disabled")
                    .isTrue();
            softAssertions.assertThat(questionnairePage.getInputValue(questionType))
                    .as("Date input value is unexpected")
                    .isEqualTo(getTodayDate(REACT_FORMAT));
        } else if (getQuestionType(questionType) == QuestionType.MULTIPLE_CHOICE) {
            List<String> defaultBooleanOptions = asList("Option (Score 0)", "Option (Score 0)", "Option (Score 0)");
            softAssertions.assertThat(questionnairePage.getQuestionOptions())
                    .as("Multiple Choice question default options are unexpected")
                    .isEqualTo(defaultBooleanOptions);
        } else if (getQuestionType(questionType) == QuestionType.MULTI_SELECT ||
                getQuestionType(questionType) == QuestionType.SINGLE_SELECT) {
            List<String> expectedDropDownValues = asList("Drop (Score: 0)", "Drop (Score: 0)");
            questionnairePage.clickOpenDropDownWithLabel(questionType);
            softAssertions.assertThat(questionnairePage.getDropDownOptions())
                    .as("MultiSelect question drop-down options are unexpected")
                    .containsExactlyInAnyOrderElementsOf(expectedDropDownValues);
            questionnairePage.clickOpenDropDownWithLabel(questionType);
        } else if (getQuestionType(questionType) == QuestionType.TEXT_ENTRY_PLUS) {
            softAssertions.assertThat(questionnairePage.isInputReadOnly(QuestionType.TEXT.getName()))
                    .as("TextEntryPlus Text input is not disabled")
                    .isTrue();
            softAssertions.assertThat(questionnairePage.isInputReadOnly(QuestionType.NUMBER.getName()))
                    .as("TextEntryPlus Number input is not disabled")
                    .isTrue();
        } else if (getQuestionType(questionType) == QuestionType.ENHANCED_TEXT_ENTRY_PLUS) {
            softAssertions.assertThat(questionnairePage.isMappingIconDisplayed(position))
                    .as("Question Mapping icon is not displayed")
                    .isTrue();
            softAssertions.assertThat(questionnairePage.isInputReadOnly(FIRST_NAME))
                    .as("EnhancedTextEntryPlus First Name input is not disabled")
                    .isTrue();
            softAssertions.assertThat(questionnairePage.isInputReadOnly(LAST_NAME))
                    .as("EnhancedTextEntryPlus Last Name input is not disabled")
                    .isTrue();
            softAssertions.assertThat(questionnairePage.getEnhancedTextEntryPlusCounter())
                    .as("EnhancedTextEntryPlus question counter is unexpected")
                    .isEqualTo(TOTAL_SUB_QUESTIONS);
        } else if (getQuestionType(questionType) != QuestionType.HEADING) {
            throw new IllegalArgumentException("Unsupported question type: " + questionType);
        }
        softAssertions.assertAll();
    }

    @Then("Questionnaire Main question section is greyed out")
    public void questionnaireMainQuestionSectionIsGreyedOut() {
        assertThat(questionnairePage.getQuestionMainAreBackground())
                .as("Question background is unexpected")
                .isEqualTo(BACKGROUND_GREY.getColorRgba());
    }

    @Then("Questionnaire {string} configuration section appears with expected elements for {string}")
    public void questionnaireConfigurationSectionAppearsWithExpectedElementsFor(String questionType, String tabType) {
        SoftAssertions softAssertions = new SoftAssertions();
        softAssertions.assertThat(questionnairePage.getQuestionConfigTitle())
                .as("Question title is unexpected")
                .contains(questionType);
        softAssertions.assertThat(questionnairePage.getCounterLabel())
                .as("Question Froala Counter character limit is unexpected")
                .contains(DESCRIPTION_MAX_LENGTH);
        softAssertions.assertThat(questionnairePage.getHelpTextMaxLength())
                .as("Questionnaire Help text max length is unexpected")
                .isEqualTo(DESCRIPTION_MAX_LENGTH);
        softAssertions.assertThat(questionnairePage.isDropDownWithLabelDisplayed(SELECT_REVIEWER))
                .as("Select reviewer drop-down visibility is unexpected")
                .isEqualTo(tabType.equals(REVIEWER_USE));
        QuestionData expectedResult = new JsonUiDataTransfer<QuestionData>(QUESTION).getTestData()
                .get(questionType + SPACE + tabType).getDataToEnter();
        softAssertions.assertThat(questionnairePage.getQuestionConfigData())
                .as("Question default configuration data is unexpected")
                .isEqualTo(expectedResult);
        QuestionType type = getQuestionType(questionType);
        if (type == QuestionType.CHECKBOX || type == QuestionType.MULTIPLE_CHOICE ||
                type == QuestionType.SINGLE_SELECT || type == QuestionType.MULTI_SELECT) {
            softAssertions.assertThat(questionnairePage.areChoicesAddButtonDisplayed(CHOICE_NAME))
                    .as("Choices Add button are not displayed")
                    .isTrue();
            String defaultChoicesCounter =
                    questionType.toLowerCase().contains(SELECT) ? DEFAULT_SELECT_CHOICES_COUNTER :
                            DEFAULT_CHOICES_COUNTER;
            softAssertions.assertThat(questionnairePage.getQuestionConfigText())
                    .as("Choices counter is unexpected")
                    .contains(defaultChoicesCounter);
            softAssertions.assertThat(questionnairePage.areChoicesDeleteButtonDisplayed(CHOICE_NAME))
                    .as("Choices Delete button are not displayed")
                    .isEqualTo(!questionType.toLowerCase().contains(SELECT));
            softAssertions.assertThat(questionnairePage.getQuestionChoicesInputMaxLength(CHOICE_NAME))
                    .as("Choice input max length is unexpected")
                    .containsOnly(CHOICE_MAX_LENGTH);
            softAssertions.assertThat(questionnairePage.getQuestionScoresInputMaxLength())
                    .as("Score input max length is unexpected")
                    .containsOnly(SCORE_MAX_LENGTH);
        } else if (type == QuestionType.BOOLEAN) {
            softAssertions.assertThat(questionnairePage.getQuestionChoicesInputMaxLength(CHOICE_NAME))
                    .as("Choice input max length is unexpected")
                    .containsOnly(CHOICE_MAX_LENGTH);
            softAssertions.assertThat(questionnairePage.getQuestionScoresInputMaxLength())
                    .as("Score input max length is unexpected")
                    .containsOnly(SCORE_MAX_LENGTH);
        } else if (type == QuestionType.HEADING) {
            softAssertions.assertThat(questionnairePage.isResponseMandatoryDisabled())
                    .as("Make response mandatory is not disabled")
                    .isTrue();
        } else if (type == QuestionType.TEXT_ENTRY_PLUS) {
            int limit = 10;
            softAssertions.assertThat(questionnairePage.areChoicesAddButtonDisplayed(SUB_QUESTION_NAME))
                    .as("Sub-questions Add button are not displayed")
                    .isTrue();
            softAssertions.assertThat(questionnairePage.getQuestionConfigText())
                    .as("Sub-questions counter is unexpected")
                    .contains(String.format(DEFAULT_SUB_QUESTIONS_COUNTER, limit));
            softAssertions.assertThat(questionnairePage.getQuestionConfigText())
                    .as("Sub-questions instruction is unexpected")
                    .contains(String.format(SUB_QUESTIONS_INSTRUCTION, limit));
            softAssertions.assertThat(questionnairePage.areChoicesDeleteButtonDisplayed(SUB_QUESTION_NAME))
                    .as("Sub-questions Delete button are not displayed")
                    .isTrue();
            softAssertions.assertThat(questionnairePage.getQuestionChoicesInputMaxLength(SUB_QUESTION_NAME))
                    .as("Sub-question input max length is unexpected")
                    .containsOnly(CHOICE_MAX_LENGTH);
        } else if (type == QuestionType.ENHANCED_TEXT_ENTRY_PLUS) {
            int limit = 20;
            softAssertions.assertThat(questionnairePage.getQuestionConfigText())
                    .as("Sub-questions counter is unexpected")
                    .contains(String.format(DEFAULT_SUB_QUESTIONS_COUNTER, limit));
            softAssertions.assertThat(questionnairePage.getQuestionConfigText())
                    .as("Sub-questions instruction is unexpected")
                    .contains(String.format(SUB_QUESTIONS_INSTRUCTION, limit));
            softAssertions.assertThat(questionnairePage.areChoicesDeleteButtonDisplayed(SUB_QUESTION_NAME))
                    .as("Sub-questions Delete button are not displayed")
                    .isFalse();
            softAssertions.assertThat(questionnairePage.areChoicesAddButtonDisplayed(SUB_QUESTION_NAME))
                    .as("Sub-questions Add button are not displayed")
                    .isTrue();
            for (int i = 1; i <= 2; i++) {
                softAssertions.assertThat(questionnairePage.isChoiceToggleDisabled(SUB_QUESTION_NAME + i))
                        .as("Sub-question #%s toggle is not disabled", i)
                        .isTrue();
                softAssertions.assertThat(questionnairePage.isTypeValueInputDisplayed(SUB_QUESTION_NAME + i))
                        .as("Sub-question #%s type input displayed", i)
                        .isFalse();
            }

            softAssertions.assertThat(questionnairePage.getQuestionChoicesInputMaxLength(SUB_QUESTION_NAME))
                    .as("Sub-question input max length is unexpected")
                    .containsOnly(CHOICE_MAX_LENGTH);
        } else if (type != QuestionType.TEXT && type != QuestionType.CURRENCY && type != QuestionType.NUMBER
                && type != QuestionType.DATE) {
            throw new IllegalArgumentException("Unsupported question type: " + questionType);
        }
        softAssertions.assertAll();
    }

    @Then("Question Reviewer level is {string}")
    public void questionReviewerLevelIs(String expectedLevel) {
        assertThat(questionnairePage.getQuestionReviewer())
                .as("Question Reviewer level is unexpected")
                .isEqualTo(expectedLevel);
    }

    @Then("Question panel message is displayed {string}")
    public void questionPanelMessageIsDisplayed(String expectedMessage) {
        assertThat(questionnairePage.getQuestionTabPanelMessage())
                .as("Question panel message is unexpected")
                .isEqualTo(expectedMessage);
    }

    @Then("Question panel additional message is displayed {string}")
    public void questionPanelAdditionalMessageIsDisplayed(String expectedMessage) {
        assertThat(questionnairePage.getQuestionTabPanelAdditionalMessage())
                .as("Question panel additional message is unexpected")
                .isEqualTo(expectedMessage);
    }

    @Then("Question Reviewer level drop-down options are")
    public void questionReviewerLevelDropDownOptionsAre(List<String> expectedResult) {
        questionnairePage.clickOpenDropDownWithLabel(SELECT_REVIEWER);
        assertThat(questionnairePage.getDropDownOptions())
                .as("Reviewer level drop-down options are unexpected")
                .isEqualTo(expectedResult);
        questionnairePage.clickOpenDropDownWithLabel(SELECT_REVIEWER);
    }

    @Then("^Questionnaire choices \"((.*))\" Delete buttons are (not displayed|displayed)$")
    public void questionnaireChoicesDeleteButtonsAre(String label, String state) {
        assertThat(questionnairePage.areChoicesDeleteButtonDisplayed(label))
                .as("Delete button are not %s", state)
                .isEqualTo(state.equalsIgnoreCase(DISPLAYED));
    }

    @Then("^Questionnaire choices \"((.*))\" Add buttons are (not displayed|displayed)$")
    public void questionnaireChoicesAddButtonsAre(String label, String state) {
        assertThat(questionnairePage.areChoicesAddButtonDisplayed(label))
                .as("Choices Add button are not %s", state)
                .isEqualTo(state.equalsIgnoreCase(DISPLAYED));
    }

    @Then("Questionnaire choices counter is {string}")
    public void questionnaireChoicesCounterIs(String expectedResult) {
        assertThat(questionnairePage.getQuestionConfigText())
                .as("Choices counter is unexpected")
                .contains(expectedResult);
    }

    @Then("Questionnaire question configuration {string} button is displayed")
    public void questionnaireChoicesButtonIsDisplayed(String buttonName) {
        assertThat(questionnairePage.isChoiceButtonDisplayed(buttonName))
                .as("Choices button %s is not displayed", buttonName)
                .isTrue();
    }

    @Then("Questionnaire choices with label {string} {int} options are displayed")
    public void questionnaireChoicesOptionsAre(String label, int count) {
        List<String> expectedChoices =
                IntStream.rangeClosed(1, count).mapToObj(i -> label + i).collect(Collectors.toList());
        assertThat(questionnairePage.getChoices())
                .as("Choices list is unexpected")
                .isEqualTo(expectedChoices);
    }

    @Then("Questionnaire Add Bulk {int} Choices modal is displayed with default elements")
    public void questionnaireAddBulkChoicesModalIsDisplayedWithDefaultElements(int count) {
        SoftAssertions softAssertions = new SoftAssertions();
        softAssertions.assertThat(questionnairePage.getBulkChoicesModalHeader())
                .as("Bulk Choices counter header is unexpected")
                .isEqualTo(BULK_CHOICES_DEFAULT_HEADER);
        softAssertions.assertThat(questionnairePage.getBulkChoicesModalInstruction())
                .as("Bulk Choices instruction is unexpected")
                .isEqualTo(String.format(BULK_CHOICES_DEFAULT_INSTRUCTION, count));
        softAssertions.assertThat(questionnairePage.isBulkChoicesModalButtonDisabled(CANCEL))
                .as("Bulk Choices Cancel button is not enabled")
                .isFalse();
        softAssertions.assertThat(questionnairePage.isBulkChoicesModalButtonDisabled(ADD_BULK_CHOICES))
                .as("Bulk Choices Add Bulk Choices button is not enabled")
                .isTrue();
        softAssertions.assertAll();
    }

    @Then("Questionnaire Add Bulk Choices modal button {string} is enabled")
    public void questionnaireAddBulkChoicesModalButtonIsEnabled(String buttonName) {
        assertThat(questionnairePage.isBulkChoicesModalButtonDisabled(buttonName))
                .as("Bulk Choices %s button is not enabled", buttonName)
                .isFalse();
    }

    @Then("Questionnaire Add Bulk Choices modal is not displayed")
    public void questionnaireAddBulkChoicesModalIsNotDisplayed() {
        assertThat(questionnairePage.isBulkChoicesModalInvisible())
                .as("Bulk Choices modal is displayed")
                .isTrue();
    }

    @Then("Questionnaire question active tab type is {string}")
    public void questionnaireQuestionActiveTabTypeIs(String expectedType) {
        assertThat(questionnairePage.getUseType())
                .as("Question tab use type is unexpected")
                .isEqualTo(expectedType);
    }

    @Then("Questionnaire question tab Edit button is displayed for tab on position {int}")
    public void questionTabEditButtonIsDisplayedForTabOnPosition(int position) {
        assertThat(questionnairePage.isEditTabButtonDisplayed(position))
                .as("Edit button is not displayed for tab on position %s", position)
                .isTrue();
    }

    @Then("^Questionnaire question tab Delete button is (not displayed|displayed) for tab on position (\\d+)$")
    public void questionTabDeleteButtonIsNotDisplayedForTabOnPosition(String state, int position) {
        if (state.contains(NOT)) {
            assertThat(questionnairePage.isDeleteTabButtonDisplayed(position))
                    .as("Delete button is displayed for tab on position %s", position)
                    .isFalse();
        } else {
            assertThat(questionnairePage.isDeleteTabButtonDisplayed(position))
                    .as("Delete button is not displayed for tab on position %s", position)
                    .isTrue();
        }
    }

    @Then("Questionnaire question tab counter with value {string} is displayed for tab on position {int}")
    public void questionTabCounterWithValueIsDisplayedForTabOnPosition(String expectedValue, int position) {
        assertThat(questionnairePage.getTabCountValue(position))
                .as("Tab counter value is unexpected for tab on position %s", position)
                .isEqualTo(expectedValue);
    }

    @Then("Questionnaire Plus icon counter is displayed with value {string}")
    public void questionnairePlusIconCounterIsDisplayedWithValue(String expectedValue) {
        assertThat(questionnairePage.getPlusTabsCountValue())
                .as("Plus icon counter value is unexpected")
                .isEqualTo(expectedValue);
    }

    @Then("^Question Create Tab modal is (displayed|not displayed)$")
    public void questionCreateTabModalIsDisplayed(String state) {
        if (state.contains(NOT)) {
            assertThat(questionnairePage.isCreateTabModalInvisible())
                    .as("Create Tab modal is displayed")
                    .isTrue();
        } else {
            assertThat(questionnairePage.isCreateTabModalDisplayed())
                    .as("Create Tab modal is not displayed")
                    .isTrue();
        }
    }

    @Then("Question Create Tab modal {string} button is displayed")
    public void questionCreateTabModalButtonIsDisplayed(String buttonName) {
        assertThat(questionnairePage.isCreateTabModalButtonDisplayed(buttonName))
                .as("Create Tab modal %s button is not displayed", buttonName)
                .isTrue();
    }

    @Then("Question Create Tab modal radio buttons are displayed")
    public void questionCreateTabModalRadioButtonsAreDisplayed(List<String> expectedNames) {
        assertThat(questionnairePage.getCreateTabModalRadioButtons())
                .as("Create Tab modal radio buttons are unexpected")
                .isEqualTo(expectedNames);
    }

    @Then("Question Create Tab modal radio button {string} is selected")
    public void questionCreateTabModalRadioButtonIsSelected(String expectedSelectedButton) {
        assertThat(questionnairePage.isCreateTabModalRadioButtonSelected(expectedSelectedButton))
                .as("Create Tab modal %s radio button is not selected", expectedSelectedButton)
                .isTrue();
    }

    @Then("Question tab name on position {int} is {string}")
    public void questionTabNameOnPositionIs(int position, String expectedName) {
        assertThat(questionnairePage.getQuestionTabNameOnPosition(position))
                .as("Question tab name on position %s is unexpected", position)
                .isEqualTo(expectedName);
    }

    @Then("Question Choice {string} value is {string}")
    public void questionChoiceValueIs(String choiceLabel, String expectedValue) {
        assertThat(questionnairePage.getScoreValue(choiceLabel))
                .as("Question Choice %s value is unexpected", choiceLabel)
                .isEqualTo(expectedValue);
    }

    @Then("^Question Calculate Highest Score Only is turned (On|Off)$")
    public void questionCalculateHighestScoreOnlyIsTurnedOn(String state) {
        assertThat(questionnairePage.isCalculateHighestScoreOnlyChecked())
                .as("Calculate Highest Score Only in not turned %s", state)
                .isEqualTo(state.equals(ON));
    }

    @Then("Question drop-down {string} selected value is {string}")
    public void questionDropDownSelectedValueIs(String dropDownLabel, String expectedValue) {
        questionnairePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (context.getScenarioContext().isContains(expectedValue)) {
            expectedValue = (String) context.getScenarioContext().getContext(expectedValue);
        }
        assertThat(questionnairePage.getInputValue(dropDownLabel))
                .as("Drop-down %s selected value is unexpected", dropDownLabel)
                .isEqualTo(expectedValue);
    }

    @Then("Question drop-down {string} options are")
    public void questionDropDownOptionsAre(String dropDown, List<String> expectedResult) {
        questionnairePage.clickOpenDropDownWithLabel(dropDown);
        assertThat(questionnairePage.getDropDownOptions())
                .as("%s drop-down options are unexpected", dropDown)
                .containsExactlyInAnyOrderElementsOf(expectedResult);
        questionnairePage.clickOpenDropDownWithLabel(dropDown);
    }

    @Then("Question drop-down options are displayed")
    public void questionDropDownOptionsAre(List<String> expectedResult) {
        assertThat(questionnairePage.getDropDownOptions())
                .as("Drop-down options are unexpected")
                .containsExactlyInAnyOrderElementsOf(expectedResult);
    }

    @Then("Question draggable options are")
    public void questionDraggableOptionsAre(List<String> expectedResult) {
        assertThat(questionnairePage.getDraggableQuestionOptions())
                .as("Question options are unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("Question label {string} by QID is shown")
    public void questionLabelByQIDIsShown(String label) {
        assertThat(questionnairePage.isQIDLabelDisplayed(label))
                .as("QID label %s is not displayed", label)
                .isTrue();
    }

    @Then("Mapping details are hidden")
    public void mappingDetailsAreHidden() {
        assertThat(questionnairePage.isDropDownWithLabelDisplayed(CUSTOM_FIELDS))
                .as("Mapping details are not hidden")
                .isFalse();
    }

    @Then("Question Mapping section is displayed with default data for {string} question type")
    public void mappingSectionIsDisplayedWithDefaultDataForQuestionType(String questionType) {
        SoftAssertions softAssertions = new SoftAssertions();
        if (questionType.contains(ENHANCED_TEXT_ENTRY_PLUS.getName())) {
            softAssertions.assertThat(questionnairePage.isMappingReviewRequiredToggleChecked())
                    .as("Mapping review required is checked")
                    .isFalse();
            softAssertions.assertThat(questionnairePage.isMappingAutoScreenToggleChecked())
                    .as("Mapping Auto screen against World Check toggle is checked")
                    .isFalse();
            QuestionData questionTestData = new JsonUiDataTransfer<QuestionData>(QUESTION).getTestData()
                    .get(questionType).getDataToEnter();
            questionTestData.getSubQuestions().forEach(
                    subQuestion -> softAssertions.assertThat(
                                    questionnairePage.isMappingSubQuestionsDisplayed(subQuestion.getSubQuestionName()))
                            .as("Mapping field %s visibility is unexpected", subQuestion)
                            .isEqualTo(isNull(subQuestion.getOption()) || subQuestion.getOption().equals(ADD_FIELD))
            );
        } else {
            softAssertions.assertThat(questionnairePage.isDropDownWithLabelDisplayed(CUSTOM_FIELDS))
                    .as("Mapping details are not hidden")
                    .isTrue();
            List<String> expectedSections = asList("Map To", "Custom Field", "Questionnaire", "Other Settings");
            softAssertions.assertThat(questionnairePage.getMappingDataSections())
                    .as("Mapping sections are unexpected")
                    .isEqualTo(expectedSections);
            questionnairePage.clickOpenDropDownWithLabel(CUSTOM_FIELDS);
            List<String> expectedDropDownValues =
                    getQuestionnairesCustomFields(questionType.toUpperCase()).stream().map(
                            QuestionnaireCustomFieldsItemResponse::getName).collect(Collectors.toList());
            softAssertions.assertThat(questionnairePage.getDropDownOptions())
                    .as("Custom Fields drop-down options are unexpected")
                    .containsExactlyInAnyOrderElementsOf(expectedDropDownValues);
            questionnairePage.clickOpenDropDownWithLabel(CUSTOM_FIELDS);
            softAssertions.assertThat(questionnairePage.isDropDownWithLabelRequired(CUSTOM_FIELDS))
                    .as("Custom Fields drop-down is not required")
                    .isTrue();
            softAssertions.assertThat(questionnairePage.getMappingQuestionnaireValue())
                    .as("Mapping Questionnaire Value is unexpected")
                    .contains(questionType);
            softAssertions.assertThat(questionnairePage.isMappingClearButtonDisplayed())
                    .as("Mapping clear button is not displayed")
                    .isTrue();
            softAssertions.assertThat(questionnairePage.isMappingReviewRequiredToggleDisplayed())
                    .as("Mapping review required is not displayed")
                    .isTrue();
        }
        softAssertions.assertAll();
    }

    @Then("Question Mapping section 'Map To' with value {string} is displayed")
    public void questionMapToValueIsDisplayed(String value) {
        List<String> values = questionnairePage.getMapToValues();
        assertThat(values)
                .as("Map To value is not displayed")
                .contains(value);
    }

    @Then("Question configuration Choices contain added {string} Bulk Choices")
    @SuppressWarnings("unchecked")
    public void questionConfigurationChoicesContainAddedBulkChoices(String dataReference) {
        List<QuestionData.Choice> expectedChoices =
                (List<QuestionData.Choice>) context.getScenarioContext().getContext(dataReference);
        assertThat(questionnairePage.getChoicesValues())
                .usingRecursiveFieldByFieldElementComparatorIgnoringFields("isRedFlag")
                .as("Question Choices configuration data is unexpected")
                .containsAll(expectedChoices);
    }

    @Then("Question fields are")
    public void questionFieldsAre(List<String> expectedResult) {
        assertThat(questionnairePage.getQuestionFields())
                .as("Question fields are unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("^EnhancedTextEntryPlus modal \"((.*))\" button is (displayed|enabled|disabled)$")
    public void enhancedTextEntryPlusModalButtonIsDisplayed(String buttonName, String state) {
        if (state.equalsIgnoreCase(DISPLAYED)) {
            assertThat(questionnairePage.isModalButtonDisplayed(buttonName))
                    .as("Modal button %s is not displayed", buttonName)
                    .isTrue();
        } else {
            assertThat(questionnairePage.isModalButtonDisabled(buttonName))
                    .as("Modal button %s is not %s", buttonName, state)
                    .isEqualTo(state.equals(DISABLED));
        }
    }

    @Then("EnhancedTextEntryPlus question Add options are displayed")
    public void enhancedTextEntryPlusQuestionAddOptionsAreDisplayed(List<String> expectedOptions) {
        SoftAssertions softAssertions = new SoftAssertions();
        expectedOptions.forEach(option -> softAssertions
                .assertThat(questionnairePage.isEnhancedTextEntryPlusOptionDisplayed(option))
                .as("EnhancedTextEntryPlus question %s option is not displayed", option)
                .isTrue());
        softAssertions.assertAll();
    }

    @Then("EnhancedTextEntryPlus {string} modal is displayed with fields and checkboxes")
    public void modalIsDisplayedWithFieldsAndCheckboxes(String modalName, List<String> fields) {
        SoftAssertions softAssertions = new SoftAssertions();
        softAssertions.assertThat(questionnairePage.getModalHeader())
                .as("Modal header is unexpected")
                .isEqualTo(modalName);
        fields.forEach(field -> softAssertions.assertThat(questionnairePage.isModalCheckboxChecked(field))
                .as("Modal %s checkbox is checked", field)
                .isFalse());
        softAssertions.assertAll();
    }

    @Then("^Question EnhancedTextEntryPlus fields (are|are not) displayed$")
    public void questionEnhancedTextEntryPlusFieldsAreDisplayed(String state, List<String> expectedFields) {
        if (state.contains(NOT)) {
            assertThat(questionnairePage.getConfigQuestionFields())
                    .as("Question EnhancedTextEntryPlus fields are not displayed")
                    .doesNotContainAnyElementsOf(expectedFields);
        } else {
            assertThat(questionnairePage.getConfigQuestionFields())
                    .as("Question EnhancedTextEntryPlus fields are displayed")
                    .containsAll(expectedFields);
        }
    }

    @Then("^Question EnhancedTextEntryPlus fields (are|are not) displayed for part type \"(.*)\"$")
    public void questionEnhancedTextEntryPlusFieldsAreDisplayedForType(String state, String type,
            List<String> expectedFields) {
        if (state.contains(NOT)) {
            assertThat(questionnairePage.getMappingQuestionFieldsForPartType(type))
                    .as("Question EnhancedTextEntryPlus fields are displayed")
                    .doesNotContainAnyElementsOf(expectedFields);
        } else {
            assertThat(questionnairePage.getMappingQuestionFieldsForPartType(type))
                    .as("Question EnhancedTextEntryPlus fields are not displayed")
                    .containsAll(expectedFields);
        }
    }

    @Then("^Sub-question EnhancedTextEntryPlus values are displayed for part type \"(.*)\"$")
    public void questionEnhancedTextEntryPlusFieldsAreDisplayedForType(String type, List<String> expectedFields) {
        assertThat(questionnairePage.getConfigQuestionFieldsForPartType(type, expectedFields.size()))
                .as("Question EnhancedTextEntryPlus fields are not displayed")
                .containsAll(expectedFields);
    }

    @Then("Question EnhancedTextEntryPlus Mandatory field toggle is enabled for each added field")
    public void questionEnhancedTextEntryPlusMandatoryFieldToggleIsEnabledForEachAddedField() {
        SoftAssertions softAssertions = new SoftAssertions();
        for (int i = 1; i < parseInt(questionnairePage.getAddedChoicesCount(SUB_QUESTIONS)); i++) {
            softAssertions.assertThat(questionnairePage.isChoiceToggleDisabled(SUB_QUESTION_NAME + i))
                    .as("Sub-question #%s toggle toggle state is unexpected", i)
                    .isEqualTo(i <= 2);
        }
        softAssertions.assertAll();
    }

    @Then("Question EnhancedTextEntryPlus field Type input is not displayed for each added field")
    public void questionEnhancedTextEntryPlusFieldTypeInputIsNotDisplayedForEachAddedField() {
        SoftAssertions softAssertions = new SoftAssertions();
        for (int i = 1; i < parseInt(questionnairePage.getAddedChoicesCount(SUB_QUESTIONS)); i++) {
            softAssertions.assertThat(questionnairePage.isChoiceToggleDisabled(SUB_QUESTION_NAME + i))
                    .as("Sub-question #%s type input state is unexpected", i)
                    .isEqualTo(i <= 2);
        }
        softAssertions.assertAll();
    }

    @Then("Question EnhancedTextEntryPlus fields are draggable")
    public void questionEnhancedTextEntryPlusFieldsAreDraggable() {
        SoftAssertions softAssertions = new SoftAssertions();
        for (int i = 1; i < parseInt(questionnairePage.getAddedChoicesCount(SUB_QUESTIONS)); i++) {
            softAssertions.assertThat(questionnairePage.isChoiceDraggable(SUB_QUESTION_NAME + i))
                    .as("Sub-question #%s is not draggable", i)
                    .isTrue();
        }
        softAssertions.assertAll();
    }

    @Then("^EnhancedTextEntryPlus modal fields are (unchecked|checked)$")
    public void enhancedTextEntryPlusModalFieldsAreUnchecked(String state, List<String> fields) {
        SoftAssertions softAssertions = new SoftAssertions();
        fields.forEach(field -> softAssertions.assertThat(questionnairePage.isModalCheckboxChecked(field))
                .as("Modal %s checkbox is not %s", field, state)
                .isEqualTo(state.equals(TestConstants.CHECKED)));
        softAssertions.assertAll();
    }

    @Then("Question {string} drop-down value {string} is disabled")
    public void questionDropDownValueIsDisabled(String dropDown, String value) {
        if (context.getScenarioContext().isContains(value)) {
            value = (String) context.getScenarioContext().getContext(value);
        }
        questionnairePage.clickOpenDropDownWithLabel(dropDown);
        assertThat(questionnairePage.isDropDownValueDisabled(value))
                .as("Drop-down value %s id not disabled", value)
                .isTrue();
        questionnairePage.clickOpenDropDownWithLabel(dropDown);
    }

    @Then("Questionnaire Part Type configuration {string} is selected")
    public void questionnairePartTypeConfigurationIsSelected(String type) {
        assertThat(questionnairePage.isPartTypeCheckboxChecked(type))
                .as("%s checkbox is not checked")
                .isTrue();
    }

}
