package com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation.OrderConfirmationPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionnaireData;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.TestConstants.VALUE;
import static com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.DueDiligenceOrderPage.*;
import static java.lang.String.format;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated;

public class OrderConfirmationPage extends BasePage<OrderConfirmationPage> {

    private final OrderConfirmationPO orderConfirmationPO;

    public OrderConfirmationPage(WebDriver driver, ScenarioCtxtWrapper context, LanguageConfig translator) {
        super(driver, context, translator);
        orderConfirmationPO = new OrderConfirmationPO(driver);
    }

    @Override
    protected ExpectedCondition<OrderConfirmationPage> getPageLoadCondition() {
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

    public void clickConfirmationBlockButton(String button) {
        clickOn(xpath(format(orderConfirmationPO.getConfirmationBlockButton(), button)), waitLong);
    }

    public void clickConfirmationBlockRetryButton() {
        clickOn(orderConfirmationPO.getConfirmationBlockRetryButton(), waitLong);
    }

    public boolean isConfirmationBlockRetryButtonDisplayed() {
        return isElementDisplayed(waitLong, orderConfirmationPO.getConfirmationBlockRetryButton());
    }

    public String getOrderOrSubjectDetailsFieldValue(String fieldName) {
        return getAttributeValue(xpath(format(orderConfirmationPO.getOrderAndSubjectValues(), fieldName)), VALUE);
    }

    public String getScopeName() {
        return getElementText(orderConfirmationPO.getDueDiligenceScopeName());
    }

    public String getScopeDescription() {
        return getElementText(orderConfirmationPO.getDueDiligenceScopeDescription());
    }

    public String getConfirmationMessage() {
        waitWhilePreloadProgressbarIsDisappeared();
        waitWhileLoadingImageIsDisappeared();
        return getElementText(
                waitLong.until(visibilityOfElementLocated(orderConfirmationPO.getConfirmationSummaryMessage())));
    }

    public boolean isOrderOrSubjectDetailsFieldDisplayed(String fieldName) {
        return isElementDisplayed(xpath(format(orderConfirmationPO.getOrderAndSubjectHeaders(), fieldName)));
    }

    public boolean isConfirmationBlockDisplayed() {
        return isElementDisplayed(waitShort, orderConfirmationPO.getConfirmationBlock());
    }

    public boolean isAdditionalAddOnsSectionDisplayed() {
        return isElementDisplayed(orderConfirmationPO.getAdditionalAddOnsSection());
    }

    public boolean isListOfKeyPrincipalsSectionDisplayed() {
        return isElementDisplayed(orderConfirmationPO.getListOfKeyPrincipalsSection());
    }

    public boolean isAttachmentSectionDisplayed() {
        return isElementDisplayed(orderConfirmationPO.getAttachmentSection());
    }

    public boolean isCommentSectionDisplayed() {
        return isElementDisplayed(orderConfirmationPO.getCommentSection());
    }

    public List<QuestionnaireData> getSelectedQuestionnaires() {
        List<String> columnNames = getQuestionnaireTableColumns();
        return driver.findElements(orderConfirmationPO.getSelectedQuestionnaireTableRows()).stream()
                .map(row -> QuestionnaireData.builder()
                        .questionnaireName(getColumnValue(row, columnNames, QUESTIONNAIRE_NAME.toUpperCase()))
                        .questionType(getColumnValue(row, columnNames, QUESTIONNAIRE_TYPE.toUpperCase()))
                        .assignee(getColumnValue(row, columnNames, ASSIGNEE.toUpperCase()))
                        .dateCompleted(getColumnValue(row, columnNames, DATE_COMPLETED.toUpperCase()))
                        .overallScore(getColumnValue(row, columnNames, OVERALL_SCORE.toUpperCase())).build())
                .collect(Collectors.toList());
    }

    private List<String> getQuestionnaireTableColumns() {
        scrollIntoView(orderConfirmationPO.getQuestionnaireTableColumns());
        return driver.findElements(orderConfirmationPO.getQuestionnaireTableColumns()).stream().map(WebElement::getText)
                .collect(Collectors.toList());
    }

    private String getColumnValue(WebElement row, List<String> columnNames, String columnName) {
        int columnNameIndex = columnNames.indexOf(columnName) + 1;
        return columnNameIndex == 0 ? null :
                getElementText(row.findElement(xpath(format(orderConfirmationPO.getTableRowValue(),
                                                            columnNameIndex))));
    }

}
