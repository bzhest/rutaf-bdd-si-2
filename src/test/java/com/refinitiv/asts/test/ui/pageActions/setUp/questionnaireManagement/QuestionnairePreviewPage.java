package com.refinitiv.asts.test.ui.pageActions.setUp.questionnaireManagement;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.ThirdPartyOverviewPage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.questionnaireManagement.QuestionnairePreviewPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionData;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import static java.lang.String.format;
import static org.openqa.selenium.By.xpath;

public class QuestionnairePreviewPage extends BasePage<ThirdPartyOverviewPage> {

    public final QuestionnairePreviewPO questionnairePO;

    public QuestionnairePreviewPage(WebDriver driver, ScenarioCtxtWrapper context) {
        super(driver, context);
        questionnairePO = new QuestionnairePreviewPO(driver);
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

    public QuestionData getQuestionPreviewConfigData(int position) {
        return new QuestionData()
                .setHelpText(getElementText(xpath(format(questionnairePO.getQuestionHelpText(), position))))
                .setFroalaText(getElementText(xpath(format(questionnairePO.getQuestionTitle(), position))));
    }

    public boolean isQuestionFieldRequiredIndicatorDisplayed(int position, String fieldName) {
        return isElementDisplayed(xpath(format(questionnairePO.getFieldRequiredIndicator(), position, fieldName)));
    }

}
