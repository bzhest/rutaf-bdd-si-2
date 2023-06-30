package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.questionnaireManagement;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.WorkflowApi;
import com.refinitiv.asts.test.ui.api.model.questionnaires.QuestionnaireRequest;
import com.refinitiv.asts.test.ui.api.model.questionnaires.QuestionnairesResponseData;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.pageActions.setUp.questionnaireManagement.QuestionnaireManagementPage;
import com.refinitiv.asts.test.ui.pageActions.setUp.questionnaireManagement.QuestionnairePage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.GenericTestData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionnaireData;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;
import org.testng.SkipException;
import org.testng.asserts.SoftAssert;

import java.util.Arrays;
import java.util.List;

import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.buildInactivateQuestionnaireRequest;
import static com.refinitiv.asts.test.ui.api.BaseApi.CREATE_TIME;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.getActiveQuestionnaires;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.inactivateQuestionnaire;
import static com.refinitiv.asts.test.ui.constants.APIConstants.DESC;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.NOT;
import static com.refinitiv.asts.test.ui.constants.Pages.SLASH;
import static com.refinitiv.asts.test.ui.constants.QuestionnaireConstants.BACK_TO_OVERVIEW;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.QUESTIONNAIRE;
import static com.refinitiv.asts.test.ui.enums.QuestionnaireToBeAttachedFields.QUESTIONNAIRE_NAME;
import static com.refinitiv.asts.test.ui.utils.DateUtil.REACT_FORMAT;
import static java.lang.String.format;
import static java.util.Objects.isNull;
import static java.util.UUID.randomUUID;
import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.Assert.assertEquals;
import static org.testng.AssertJUnit.assertFalse;
import static org.testng.AssertJUnit.assertTrue;

public class QuestionnaireOverviewSteps extends BaseSteps {

    private final QuestionnaireManagementPage questionnaireManagementPage;
    private final QuestionnairePage questionnairePage;
    private String clonedQuestionnaireName;

    public QuestionnaireOverviewSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.questionnaireManagementPage = new QuestionnaireManagementPage(this.driver, translator);
        this.questionnairePage = new QuestionnairePage(this.driver, this.context, translator);
    }

    @When("User navigates to Questionnaire Management page")
    public void navigateToQuestionnaireManagementPage() {
        questionnaireManagementPage.navigateToQuestionnaireManagementPage();
    }

    @When("User navigates to Add Questionnaire Management page")
    public void navigateToAddQuestionnaireManagementPage() {
        questionnaireManagementPage.navigateToAddQuestionnaireManagementPage();
        questionnaireManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User navigates to open {string} existing Questionnaire Management page")
    public void navigateToOpenExistingQuestionnaireManagementPage(String endpoint) {
        String questionnaireID = (String) context.getScenarioContext().getContext(QUESTIONNAIRE_ID);
        questionnaireManagementPage.navigateToQuestionnaireManagementPage(SLASH + questionnaireID + endpoint);
    }

    @When("User saves Questionnaire ID from current URL")
    public void saveQuestionnaireIDFromCurrentURL() {
        context.getScenarioContext().setContext(QUESTIONNAIRE_ID, questionnaireManagementPage.getIdFromUrl());
    }

    @When("User clicks Questionnaires tab in Questionnaire Management")
    public void accessQuestionnaires() {
        questionnaireManagementPage.clickQuestionnairesTab();
    }

    @When("User clicks Add Questionnaire button")
    public void clickAddQuestionnaireBtn() {
        questionnaireManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        questionnaireManagementPage.clickAddQuestionnaireBtn();
    }

    @When("User clicks edit questionnaire with name {string}")
    public void clickEditQuestionnaireWithName(String questionnaireName) {
        questionnaireManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        questionnaireManagementPage.clickEditQuestionnaireWithName(questionnaireName);
    }

    @When("User clicks edit added questionnaire")
    @SuppressWarnings("unchecked")
    public void clickEditAddedQuestionnaire() {
        questionnaireManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        GenericTestData<QuestionnaireData> questionnaireTestData =
                (GenericTestData<QuestionnaireData>) context.getScenarioContext().getContext(QUESTIONNAIRE_TEST_DATA);
        String questionnaireName = questionnaireTestData.getDataToEnter().getQuestionnaireName();
        clickEditQuestionnaireWithName(questionnaireName);
    }

    @When("User clicks edit cloned questionnaire")
    public void clickEditClonedQuestionnaire() {
        questionnaireManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        String clonedQuestionnaireName =
                (String) this.context.getScenarioContext().getContext(CLONED_QUESTIONNAIRE_NAME);
        clickEditQuestionnaireWithName(clonedQuestionnaireName);
    }

    @When("User clicks on added questionnaire")
    @SuppressWarnings("unchecked")
    public void openAddedQuestionnaire() {
        questionnaireManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        questionnaireManagementPage.closeAlertIconIfDisplayed();
        GenericTestData<QuestionnaireData> questionnaireTestData =
                (GenericTestData<QuestionnaireData>) context.getScenarioContext().getContext(QUESTIONNAIRE_TEST_DATA);
        String expectedQuestionnaireName = questionnaireTestData.getDataToEnter().getQuestionnaireName();
        questionnaireManagementPage.clickOnQuestionnaireWithName(expectedQuestionnaireName);
        questionnaireManagementPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks on cloned questionnaire")
    public void openClonedQuestionnaire() {
        questionnaireManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        String clonedQuestionnaireName =
                (String) this.context.getScenarioContext().getContext(CLONED_QUESTIONNAIRE_NAME);
        questionnaireManagementPage.clickOnQuestionnaireWithName(clonedQuestionnaireName);
        questionnaireManagementPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks Clone questionnaire button for created Questionnaire")
    @SuppressWarnings("unchecked")
    public void clickCloneButton() {
        GenericTestData<QuestionnaireData> questionnaireData =
                (GenericTestData<QuestionnaireData>) this.context.getScenarioContext()
                        .getContext(QUESTIONNAIRE_TEST_DATA);
        String questionnaireName = questionnaireData.getDataToEnter().getQuestionnaireName();
        questionnaireManagementPage.clickCloneButton(questionnaireName);
    }

    @When("User clicks Clone questionnaire button for {string} Questionnaire")
    public void clickCloneButtonForName(String questionnaireName) {
        questionnaireManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        clonedQuestionnaireName = questionnaireName;
        questionnaireManagementPage.clickCloneButton(questionnaireName);
    }

    @When("User clears New Questionnaire Name field")
    public void clearNewQuestionnaireName() {
        questionnaireManagementPage.clearNewQuestionnaireName();
    }

    @When("User clicks Clone Questionnaire modal {string} button")
    public void clickModalButton(String buttonName) {
        questionnaireManagementPage.clickButtonWithName(buttonName);
    }

    @When("User fills in New Questionnaire Name field with {string}")
    public void fillInNewQuestionnaireName(String value) {
        if (value.equals(VALUE_TO_REPLACE)) {
            value = "CLONE_AUTO_TEST_QUESTIONNAIRE_" + randomUUID();
            context.getScenarioContext().setContext(CLONED_QUESTIONNAIRE_NAME, value);
        }
        questionnaireManagementPage.fillInNewQuestionnaireName(value);
    }

    @When("User inactivates all Questionnaires with name prefix generated by auto tests via API")
    public void inactivateAllQuestionnairesWithNamePrefixGeneratedByAutoTestsViaAPI() {
        List<String> activeTestQuestionnaires = Arrays.asList("AUTO_TEST_EXTERNAL_QUESTIONNAIRE",
                                                              "AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE",
                                                              "AUTO_TEST_INTERNAL_QUESTIONNAIRE",
                                                              "AUTO_TEST_INTERNAL_QUESTIONNAIRE_SECOND",
                                                              "AUTO_TEST_INTERNAL_QUESTIONNAIRE_CONFIG",
                                                              "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW",
                                                              "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_2_IN_REVIEW",
                                                              "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL",
                                                              "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED",
                                                              "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_BRANCHING_QUESTIONS",
                                                              "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT");
        WorkflowApi.getActiveQuestionnaires().forEach(questionnaire -> {
            if (!activeTestQuestionnaires.contains(questionnaire.getName()) &&
                    questionnaire.getName().startsWith(AUTO_TEST_NAME_PREFIX)) {
                QuestionnaireRequest inactivateRequest = buildInactivateQuestionnaireRequest(questionnaire);
                inactivateQuestionnaire(questionnaire.getId(), inactivateRequest);
            }
        });
    }

    @When("User clicks Questionnaire Management table {string} column's header")
    public void clickQuestionnaireManagementTableColumnSHeader(String headerName) {
        questionnaireManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        questionnaireManagementPage.clickColumnHeader(headerName);
    }

    @When("User searches questionnaire {string}")
    public void searchQuestionnaire(String questionnaire) {
        questionnaireManagementPage.searchQuestionnaireByName(questionnaire);
    }

    @Then("Questionnaire Overview page is displayed")
    public void questionnaireOverviewIsDisplayed() {
        assertTrue("Questionnaire Overview page is not displayed", questionnaireManagementPage.overviewIsDisplayed());
    }

    @Then("Questionnaire Management columns with the next headers are displayed")
    public void columnHeadersAreDisplayed(List<String> expectedColumnHeaders) {
        questionnaireManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(questionnaireManagementPage.getColumnHeadersList())
                .as("Column Headers are mismatched:")
                .isEqualTo(expectedColumnHeaders);
    }

    @Then("Questionnaire is displayed on questionnaires table")
    @SuppressWarnings("unchecked")
    public void questionnaireIsDisplayedOnQuestionnairesTable() {
        GenericTestData<QuestionnaireData> questionnaireTestData =
                (GenericTestData<QuestionnaireData>) context.getScenarioContext().getContext(QUESTIONNAIRE_TEST_DATA);
        String expectedQuestionnaireName = questionnaireTestData.getDataToEnter().getQuestionnaireName();
        questionnaireIsDisplayedOnQuestionnairesTable(expectedQuestionnaireName);
    }

    @Then("Questionnaire {string} is displayed on questionnaires table")
    public void questionnaireIsDisplayedOnQuestionnairesTable(String expectedQuestionnaireName) {
        questionnaireManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        assertTrue("Questionnaire with name " + expectedQuestionnaireName + " is not displayed in Questionnaire table",
                   questionnaireManagementPage.isQuestionnaireWithNameDisplayed(expectedQuestionnaireName));
    }

    @Then("Questionnaire is displayed on questionnaires table with status - {string}")
    @SuppressWarnings("unchecked")
    public void questionnaireIsDisplayedOnQuestionnairesTableWithStatus(String expectedStatus) {
        GenericTestData<QuestionnaireData> questionnaireTestData =
                (GenericTestData<QuestionnaireData>) context.getScenarioContext().getContext(QUESTIONNAIRE_TEST_DATA);
        String expectedQuestionnaireName = questionnaireTestData.getDataToEnter().getQuestionnaireName();
        questionnaireManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertEquals("Questionnaire's status is unexpected", expectedStatus,
                     questionnaireManagementPage.getQuestionnaireStatus(expectedQuestionnaireName));
    }

    @Then("Questionnaire is not displayed on questionnaires table")
    @SuppressWarnings("unchecked")
    public void questionnaireIsNotDisplayedOnQuestionnairesTable() {
        GenericTestData<QuestionnaireData> questionnaireTestData =
                (GenericTestData<QuestionnaireData>) context.getScenarioContext().getContext(QUESTIONNAIRE_TEST_DATA);
        String expectedQuestionnaireName = questionnaireTestData.getDataToEnter().getQuestionnaireName();
        questionnaireManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        assertFalse("Questionnaire with name " + expectedQuestionnaireName + " is displayed in Questionnaire table",
                    questionnaireManagementPage.isQuestionnaireWithNameDisplayed(expectedQuestionnaireName));
    }

    @Then("^Cloned Questionnaire (is|is not) displayed on questionnaires table$")
    public void clonedQuestionnaireIsDisplayedOnQuestionnairesTable(String state) {
        String expectedQuestionnaireName = (String) context.getScenarioContext().getContext(CLONED_QUESTIONNAIRE_NAME);
        questionnaireManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (state.contains(NOT)) {
            assertThat(questionnaireManagementPage.isQuestionnaireWithNameDisplayed(expectedQuestionnaireName))
                    .as("Questionnaire with name %s is displayed in Questionnaire table", expectedQuestionnaireName)
                    .isFalse();
        } else {
            assertThat(questionnaireManagementPage.isQuestionnaireWithNameDisplayed(expectedQuestionnaireName))
                    .as("Questionnaire with name %s is not displayed in Questionnaire table", expectedQuestionnaireName)
                    .isTrue();
        }
    }

    @Then("^Clone button is displayed for created Questionnaire$")
    @SuppressWarnings("unchecked")
    public void isCloneButtonDisplayed() {
        GenericTestData<QuestionnaireData> questionnaireData =
                (GenericTestData<QuestionnaireData>) this.context.getScenarioContext()
                        .getContext(QUESTIONNAIRE_TEST_DATA);
        String questionnaireName = questionnaireData.getDataToEnter().getQuestionnaireName();
        assertThat(questionnaireManagementPage.isCloneButtonDisplayed(questionnaireName)).as(
                "Clone button is not displayed for questionnaire %s", questionnaireName).isTrue();
    }

    @Then("Clone Questionnaire pop-up appears with Questionnaire Name")
    @SuppressWarnings("unchecked")
    public void checkCloneQuestionnaireModal() {
        questionnaireManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        String modalTitle = "CLONE QUESTIONNAIRE";
        if (isNull(clonedQuestionnaireName)) {
            GenericTestData<QuestionnaireData> questionnaireData =
                    (GenericTestData<QuestionnaireData>) this.context.getScenarioContext()
                            .getContext(QUESTIONNAIRE_TEST_DATA);
            clonedQuestionnaireName = questionnaireData.getDataToEnter().getQuestionnaireName();
        }
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(questionnaireManagementPage.isCloneModalDisplayed(),
                              "Clone Questionnaire pop-up did not appear!");
        softAssert.assertEquals(questionnaireManagementPage.getCloneModalTitle(), modalTitle,
                                "'Clone Questionnaire' title is not displayed!");
        softAssert.assertEquals(questionnaireManagementPage.getCloneModalMessage(), clonedQuestionnaireName,
                                "Clone Questionnaire message is not displayed!");
        softAssert.assertTrue(questionnaireManagementPage.isNewQuestionnaireNameDisplayed(),
                              "New Questionnaire Name field is not displayed!");
        softAssert.assertEquals(questionnaireManagementPage.getNewQuestionnaireNameValue(),
                                format("Clone - %s", clonedQuestionnaireName),
                                "Clone Questionnaire message is not displayed!");
        softAssert.assertAll();
    }

    @Then("New Questionnaire Name field highlighted RED with {string} message")
    public void checkNewQuestionnaireNameValidation(String message) {
        questionnaireManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertEquals(questionnaireManagementPage.getValidationMessage(), message,
                                "Message is not displayed");
        softAssert.assertTrue(questionnaireManagementPage.isNewQuestionnaireNameRed(),
                              "New Questionnaire Name field is not highlighted red!");
        softAssert.assertAll();
    }

    @Then("Cloned Questionnaire is the same as Initial one")
    @SuppressWarnings("unchecked")
    public void isClonedQuestionnaireSame() {
        GenericTestData<QuestionnaireData> questionnaireTestData =
                (GenericTestData<QuestionnaireData>) this.context.getScenarioContext()
                        .getContext(QUESTIONNAIRE_TEST_DATA);
        String questionnaireName = questionnaireTestData.getDataToEnter().getQuestionnaireName();
        QuestionnairesResponseData initialQuestionnaire =
                WorkflowApi.getActiveQuestionnaires().stream()
                        .filter(questionnaire -> questionnaire.getName().equals(questionnaireName))
                        .findFirst().orElseThrow(
                                () -> new RuntimeException(format("Questionnaire Name %s is not found", questionnaireName)));
        String clonedQuestionnaireName =
                (String) this.context.getScenarioContext().getContext(CLONED_QUESTIONNAIRE_NAME);
        QuestionnairesResponseData clonedQuestionnaire = WorkflowApi.getActiveQuestionnaires().stream()
                .filter(questionnaire -> questionnaire.getName().equals(clonedQuestionnaireName)).findFirst()
                .orElseThrow(() -> new RuntimeException(
                        format("ClonedQuestionnaire Name %s is not found", clonedQuestionnaireName)));
        assertThat(clonedQuestionnaire).usingRecursiveComparison()
                .ignoringFields("name", "createTime", "id", "questionnaireReviewerId")
                .as("Cloned Questionnaire did not copy all data from Initial Questionnaire!")
                .isEqualTo(initialQuestionnaire);
    }

    @Then("^Questionnaire with \"((.*))\" name (is not|is) created$")
    public void questionnaireWithNameIsNotCreated(String questionnaireReference, String state) {
        QuestionnaireData questionnaireTestData = new JsonUiDataTransfer<QuestionnaireData>(QUESTIONNAIRE).getTestData()
                .get(questionnaireReference).getDataToEnter();
        List<QuestionnairesResponseData> questionnaires =
                getActiveQuestionnaires(questionnaireTestData.getQuestionnaireName());
        if (state.contains(NOT)) {
            if (!questionnaires.isEmpty()) {
                throw new SkipException(questionnaireTestData.getQuestionnaireName() + " already exists!");
            }
        } else {
            assertThat(questionnaires)
                    .as("Questionnaire with name: %s is not created", questionnaireTestData.getQuestionnaireName())
                    .isNotEmpty();
        }
    }

    @Then("Questionnaire Management {string} button is displayed")
    public void questionnaireManagementButtonIsDisplayed(String buttonName) {
        assertThat(questionnaireManagementPage.isButtonWithNameDisplayed(buttonName))
                .as("Button %s is not displayed", buttonName)
                .isTrue();
    }

    @Then("Questionnaire table contains expected count for \"All\" questionnaires")
    public void questionnaireTableContainsExpectedCountForQuestionnaires() {
        assertThat(questionnaireManagementPage.getTotalCountLabel())
                .as("Unexpected the count label of questionnaires")
                .isEqualTo(RETURNED_RESULTS.toLowerCase() +
                                   WorkflowApi.getAllQuestionnaires(CREATE_TIME, DESC).getTotal());
    }

    @Then("Questionnaire Management Edit and Clone buttons are displayed for each row")
    public void questionnaireManagementEditAndCloneButtonsAreDisplayedForEachRow() {
        SoftAssertions softAssertions = new SoftAssertions();
        softAssertions.assertThat(questionnaireManagementPage.areEditButtonsDisplayed())
                .as("Edit buttons are not displayed for each row")
                .isTrue();
        softAssertions.assertThat(questionnaireManagementPage.areCloneButtonsDisplayed())
                .as("Clone buttons are not displayed for each row")
                .isTrue();
        softAssertions.assertAll();
    }

    @Then("Questionnaire Management table sorted by {string} in {string} order")
    public void questionnaireManagementTableSortedByInOrder(String sortedBy, String sortOrder) {
        questionnaireManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        List<String> valuesList = questionnaireManagementPage.getListValuesForColumn(sortedBy);
        tableIsSortedByInOrder("Questionnaire Management", sortedBy, sortOrder, REACT_FORMAT, valuesList, false);
    }

    @Then("Each recording in the Questionnaire Management table is clickable")
    public void eachRecordingInTheQuestionnaireManagementTableIsClickable() {
        SoftAssertions softAssertions = new SoftAssertions();
        List<String> questionnaireNames =
                questionnaireManagementPage.getListValuesForColumn(QUESTIONNAIRE_NAME.getName());
        for (int i = 1; i <= questionnaireNames.size(); i++) {
            questionnaireManagementPage.clickOnQuestionnaireWithIndex(i);
            questionnaireManagementPage.waitWhilePreloadProgressbarIsDisappeared();
            softAssertions.assertThat(questionnairePage.isPageDisplayed())
                    .as("Questionnaire Wizard is not displayed")
                    .isTrue();
            questionnairePage.clickButton(BACK_TO_OVERVIEW);
            questionnaireManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        }
        softAssertions.assertAll();
    }

    @Then("Questionnaire Management {string} massage is displayed")
    public void questionnaireManagementMassageIsDisplayed(String expectedResult) {
        assertThat(questionnaireManagementPage.getEmptyTableMessage())
                .as("Empty table message is unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("Questionnaire New Questionnaire Name field is displayed as required")
    public void questionnaireNameFieldIsDisplayedAsRequired() {
        assertThat(questionnaireManagementPage.getQuestionnaireNewNameLabelValue())
                .as("New Questionnaire Name field is not displayed as required")
                .contains(REQUIRED_INDICATOR);
    }

}
