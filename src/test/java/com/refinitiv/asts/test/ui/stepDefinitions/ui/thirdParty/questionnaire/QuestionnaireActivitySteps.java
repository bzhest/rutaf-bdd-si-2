package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.questionnaire;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.WorkflowApi;
import com.refinitiv.asts.test.ui.api.model.questionnaires.QuestionnairesResponseData;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.enums.AssigneeType;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.questionnaire.QuestionnaireActivityPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.GenericTestData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionnaireData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.QuestionnaireTabData;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import java.util.List;
import java.util.Map;

import static com.refinitiv.asts.test.ui.constants.APIConstants.ASC;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.VALUE_TO_REPLACE;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.QUESTIONNAIRE;
import static com.refinitiv.asts.test.ui.pageActions.thirdParty.questionnaire.QuestionnaireActivityPage.*;
import static com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ActivityInformationDisplayPage.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.SI_QUESTIONNAIRE_DATE_FORMAT;
import static com.refinitiv.asts.test.ui.utils.DateUtil.getDateAfterTodayDate;
import static java.util.Objects.nonNull;
import static java.util.stream.Collectors.toList;
import static org.apache.logging.log4j.util.Strings.EMPTY;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.assertEquals;
import static org.testng.AssertJUnit.assertTrue;

public class QuestionnaireActivitySteps extends BaseSteps {

    private final QuestionnaireActivityPage questionnairePage;

    public QuestionnaireActivitySteps(ScenarioCtxtWrapper context) {
        super(context);
        this.questionnairePage = new QuestionnaireActivityPage(driver, context, translator);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public QuestionnaireTabData questionnaireDetailsEntry(Map<String, String> entry) {
        return new QuestionnaireTabData()
                .setQuestionnaireName(entry.get(QUESTIONNAIRE_NAME))
                .setStatus(entry.get(STATUS))
                .setAssignee(entry.get(ASSIGNEE))
                .setReviewer(entry.get(REVIEWER))
                .setReviewerAssessment(entry.get(REVIEWER_ASSESSMENT))
                .setScore(entry.get(SCORE))
                .setScoreCategory(entry.get(SCORE_CATEGORY))
                .setDateCreated(entry.get(DATE_CREATED));
    }

    @When("User clicks on Questionnaire tab")
    public void clickOnQuestionnaireTab() {
        questionnairePage.clickOnQuestionnaireTab();
    }

    @When("User clicks on Assign Questionnaire button")
    public void clickOnAssignQuestionnaireButton() {
        questionnairePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        questionnairePage.clickOnAssignQuestionnaireButton();
    }

    @When("^User selects \"(Internal|External)\" type$")
    public void selectsType(String questionnaireType) {
        switch (AssigneeType.valueOf(questionnaireType.toUpperCase())) {
            case EXTERNAL:
                questionnairePage.selectsExternalType();
                break;
            case INTERNAL:
                questionnairePage.selectsInternalType();
                break;
            default:
                throw new IllegalArgumentException("Questionnaire type: " + questionnaireType + " is unexpected");
        }
        questionnairePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("^User clicks \"(Next|Back|Finish)\" Assign Questionnaire dialog button$")
    public void clickAssignQuestionnaireDialogButton(String buttonType) {
        questionnairePage.waitWhilePreloadProgressbarIsDisappeared();
        switch (buttonType) {
            case NEXT:
                questionnairePage.clickNextButton();
                break;
            case BACK:
                questionnairePage.clickBackButton();
                break;
            case FINISH:
                questionnairePage.clickFinishButton();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
    }

    @SuppressWarnings("unchecked")
    @When("User selects {string} questionnaire")
    public void selectQuestionnaire(String questionnaireName) {
        questionnairePage.waitWhilePreloadProgressbarIsDisappeared();
        GenericTestData<QuestionnaireData> questionnaireTestData =
                (GenericTestData<QuestionnaireData>) context.getScenarioContext().getContext(QUESTIONNAIRE_TEST_DATA);
        if (questionnaireName.equals(VALUE_TO_REPLACE) && nonNull(questionnaireTestData)) {
            questionnaireName = questionnaireTestData.getDataToEnter().getQuestionnaireName();
        }
        questionnairePage.selectQuestionnaire(questionnaireName);
        questionnairePage.clickQuestionnaireInput();
        context.getScenarioContext().setContext(QUESTIONNAIRE_NAME_CONTEXT, questionnaireName);
    }

    @When("User selects {string} questionnaires")
    public void selectQuestionnaires(String questionnaireReference) {
        questionnairePage.waitWhilePreloadProgressbarIsDisappeared();
        GenericTestData<QuestionnaireData> questionnaireTestData =
                new JsonUiDataTransfer<QuestionnaireData>(QUESTIONNAIRE).getTestData()
                        .get(questionnaireReference);
        List<String> questionnaires = questionnaireTestData.getDataToEnter().getQuestionnaireNames();
        questionnairePage.selectQuestionnaires(questionnaires);
        questionnairePage.clickQuestionnaireInput();
    }

    @When("User selects {string} assignee")
    public void selectAssignee(String assigneeName) {
        if (assigneeName.equals(USER_INITIAL_FIRST_NAME) || assigneeName.equals(USER_FIRST_NAME)) {
            assigneeName = (String) context.getScenarioContext().getContext(assigneeName);
        }
        questionnairePage.selectAssignee(assigneeName);
    }

    @When("User selects 'Skip this step' checkbox")
    public void selectSkipThisStepCheckbox() {
        questionnairePage.selectSkipThisStepCheckbox();
    }

    @When("User fills in due date - today +{int} day(s)")
    public void fillQuestionnaireDueDate(int days) {
        questionnairePage.fillInDueDate(getDateAfterTodayDate(SI_QUESTIONNAIRE_DATE_FORMAT, days));
    }

    @When("User selects {string} overall reviewer")
    public void selectAssignQuestionnaireReviewer(String userName) {
        if (userName.equals(USER_FIRST_NAME)) {
            userName = (String) context.getScenarioContext().getContext(USER_FIRST_NAME);
        }
        questionnairePage.selectOverallReviewer(userName);
    }

    @Then("Date input field is displayed")
    public void dateInputFieldIsDisplayed() {
        assertTrue("Date input field is not displayed", questionnairePage.isDateInputFieldIsDisplayed());
    }

    @Then("Reviewer input field is displayed")
    public void reviewerInputFieldIsDisplayed() {
        assertTrue("Reviewer input field is not displayed", questionnairePage.isReviewerInputFieldIsDisplayed());
    }

    @Then("Assign Questionnaire window is opened")
    public void assignQuestionnaireWindowIsOpened() {
        assertThat(questionnairePage.isAssignQuestionnaireWindowOpened()).as(
                "Assign Questionnaire window is not opened").isTrue();
    }

    @Then("{string} field is not editable on Assign Questionnaire window")
    public void assignQuestionnaireActivityFieldIsNotEditable(String fieldName) {
        assertThat(questionnairePage.isAssignQuestionnaireFieldEditable(fieldName)).as(
                fieldName + " field could be edited").isFalse();
    }

    @Then("{string} field is editable on Assign Questionnaire window")
    public void assignQuestionnaireActivityFieldIsEditable(String fieldName) {
        assertThat(questionnairePage.isAssignQuestionnaireFieldEditable(fieldName)).as(
                fieldName + " field could not be edited").isTrue();
    }

    @Then("Questionnaire tab is loaded")
    public void questionnaireTabIsLoaded() {
        assertThat(questionnairePage.isQuestionnaireTabLoaded()).as("Questionnaire tab is not loaded").isTrue();
    }

    @Then("Questionnaire tab table should contain following questionnaires")
    public void questionnaireTabTableContainsData(List<QuestionnaireTabData> expectedData) {
        List<QuestionnaireTabData> actualData = questionnairePage.getQuestionnaireTabTableData();
        assertThat(actualData).as("Questionnaire tab table is not as expected")
                .usingRecursiveComparison().ignoringExpectedNullFields()
                .isEqualTo(expectedData);
    }

    @Then("Questionnaires dropdown options are sorted alphabetically")
    public void checkQuestionnairesOptionsAreSorted() {
        if (questionnairePage.getQuestionnaireDropdownOptionsList().size() == 0) {
            questionnairePage.clickQuestionnaireInput();
        }

        assertThat(questionnairePage.getQuestionnaireDropdownOptionsList())
                .as("Options list is not alphabetically sorted")
                .isSortedAccordingTo(getStringComparator(ASC, false));
    }

    @Then("Questionnaires dropdown options contains only active questionnaires")
    public void checkAllQuestionnairesAreActive() {
        if (questionnairePage.getQuestionnaireDropdownOptionsList().size() == 0) {
            questionnairePage.clickQuestionnaireInput();
        }
        List<String> allActiveQuestionnaires =
                WorkflowApi.getActiveQuestionnaires().stream()
                        .filter(questionnaire -> questionnaire.getStatus().equals(Boolean.toString(true)))
                        .map(QuestionnairesResponseData::getName)
                        .map(String::trim)
                        .collect(toList());

        List<String> actualQuestionnaireList = questionnairePage.getQuestionnaireDropdownOptionsList().stream()
                .map(option -> option.replace("\n", EMPTY))
                .map(String::trim)
                .collect(toList());
        assertThat(allActiveQuestionnaires)
                .as("Questionnaire options list contains not active options")
                .containsAll(actualQuestionnaireList);
    }

    @Then("^Active (?:Internal|External?) Questionnaires are displayed alphabetically in Assign Questionnaire dialog window$")
    public void questionnairesAreDisplayedAlphabetically() {
        assertThat(questionnairePage.getQuestionnaireDropdownOptionsList()).as(
                        "Records are not displayed in ASC sort order")
                .isSortedAccordingTo(getStringComparator(ASC, false));
    }

    @Then("Assign Questionnaire modal {string} field value is {string}")
    public void isPreselectedQuestionnaireTypeCorrect(String fieldName, String value) {
        assertEquals(fieldName + " has incorrect value",
                     questionnairePage.getAssignQuestionnaireModalExistingFieldValue(fieldName), value);
    }

}
