package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.questionnaireManagement;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.pageActions.setUp.questionnaireManagement.QuestionnairePreviewPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionData;
import io.cucumber.java.en.Then;

import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.QUESTION;
import static org.assertj.core.api.Assertions.assertThat;

public class QuestionnairePreviewSteps extends BaseSteps {

    private final QuestionnairePreviewPage questionnairePage;

    public QuestionnairePreviewSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.questionnairePage = new QuestionnairePreviewPage(this.driver, this.context);
    }

    @Then("Questionnaire Preview contains question {string} on position {int}")
    public void questionnairePreviewContainsQuestionOnPosition(String dataReference, int position) {
        QuestionData expectedResult = new JsonUiDataTransfer<QuestionData>(QUESTION).getTestData()
                .get(dataReference).getDataToEnter();
        assertThat(questionnairePage.getQuestionPreviewConfigData(position))
                .usingRecursiveComparison()
                .ignoringFields("isResponseMandatory", "isAttachmentAllowed", "isCalculateHighestScoreOnly",
                                "branchQuestion", "reviewerLevel")
                .as("Question Preview configuration data is unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("Questionnaire Preview contains required indicator for field {string} for question on position {int}")
    public void previewContainsRequiredIndicatorForFieldForQuestionOnPosition(String fieldName, int position) {
        assertThat(questionnairePage.isQuestionFieldRequiredIndicatorDisplayed(position, fieldName))
                .as("Required indicator for field %s is not displayed", fieldName)
                .isTrue();
    }

}
