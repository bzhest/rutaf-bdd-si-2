package com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.workflow;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.workflowManagement.workflow.ReviewerTabPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowReviewerApproverData;
import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static java.lang.String.format;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class ReviewerPage extends BasePage<ReviewerPage> {

    private static final String ADD_RULES_FOR = "Add Rules For";
    public static final String REVIEWER = "Reviewer";

    private final ReviewerTabPO reviewerPO;

    public ReviewerPage(WebDriver driver, ScenarioCtxtWrapper context) {
        super(driver, context);
        reviewerPO = new ReviewerTabPO(driver);
    }

    @Override
    protected ExpectedCondition<ReviewerPage> getPageLoadCondition() {
        return null;
    }

    @Override
    public String getPageTitle() {
        return driver.findElement(reviewerPO.getPageTitle()).getText();
    }

    private String getEditField(int sectionPosition) {
        return getAttributeValueWithWait(waitShort, xpath(format(reviewerPO.getInputReviewer(), sectionPosition,
                                                                 ADD_RULES_FOR)), VALUE);
    }

    private String getReviewerMethod(int sectionPosition) {
        return getElementText(xpath(format(reviewerPO.getRadioButtonReviewerMethodLabel(), sectionPosition)));
    }

    public List<String> getColumnNames() {
        return driver.findElements(reviewerPO.getTableColumns()).stream().map(WebElement::getText)
                .filter(field -> !field.isEmpty() && !field.equals(StringUtils.SPACE)).collect(Collectors.toList());
    }

    public List<WorkflowReviewerApproverData> getReviewerDetails() {
        return IntStream.rangeClosed(1, driver.findElements(reviewerPO.getReviewRules()).size())
                .mapToObj(i -> {
                    String resultsFor = getEditField(i);
                    return new WorkflowReviewerApproverData()
                            .setAddRulesFor(resultsFor)
                            .setActivityOwner(getEditMultiplyField(resultsFor, i))
                            .setReviewer(getEditMultiplyField(REVIEWER, i))
                            .setReviewerMethod(getReviewerMethod(i));
                }).collect(Collectors.toList());

    }

    public List<String> getReviewProcessOverviewFields(int sectionIndex) {
        return getElementsText(driver.findElements(xpath(format(reviewerPO.getSectionFields(), sectionIndex))));
    }

    @Override
    public boolean isPageLoaded() {
        return isElementDisplayed(waitLong, reviewerPO.getTableReviewProcess());
    }

    public boolean isRemoveRuleButtonDisplayed(int sectionIndex) {
        return isElementDisplayed(xpath(format(reviewerPO.getButtonRemoveRule(), sectionIndex)));
    }

    public boolean isAddReviewerButtonDisabled() {
        return isElementAttributeContains(reviewerPO.getButtonAddReviewer(), CLASS, DISABLED);
    }

    public boolean isRoleSectionDisplayed(int sectionPosition) {
        return isElementDisplayed(xpath(format(reviewerPO.getReviewRule(), sectionPosition)));
    }

    public boolean isReviewModalDisplayed() {
        return isElementDisplayed(reviewerPO.getReviewProcessOverviewPage());
    }

    public boolean isResultsFilteredByKeyword(String keyWord) {
        List<WebElement> allResults = driver.findElements(reviewerPO.getTableRowsNameValues());
        return allResults.stream().allMatch(role -> role.getText().toLowerCase().contains(keyWord.toLowerCase()));
    }

    @Override
    public void load() {

    }

    public void clickAddReviewerButton() {
        clickOn(reviewerPO.getButtonAddReviewer());
    }

    public void clickAddExistingRuleButton() {
        clickOn(waitShort.until(visibilityOfElementLocated(reviewerPO.getButtonAddExistingRule())));
    }

    public void clickRemoveRuleButton(int sectionIndex) {
        clickOn(xpath(format(reviewerPO.getButtonRemoveRule(), sectionIndex)));
    }

    public void clickFirstRuleRow() {
        clickOn(reviewerPO.getFirstRow());
    }

    public void fillInDefaultReviewerField(String value) {
        clearAndFillInValueAndSelectFromDropDown(value, reviewerPO.getInputDefaultReviewer(),
                                                 reviewerPO.getDropDownOption());
    }

    public void fillInReviewerDetails(WorkflowReviewerApproverData reviewerData, int sectionPosition) {
        waitWhilePreloadProgressbarIsDisappeared();
        fillInAddRuleFor(reviewerData, sectionPosition);
        fillInRuleFor(reviewerData, sectionPosition);
        fillInReviewer(reviewerData, sectionPosition);
        selectReviewerMethod(reviewerData.getReviewerMethod(), sectionPosition);
    }

    public void selectReviewProcess(String processName) {
        clickOn(xpath(format(reviewerPO.getRadioButtonReviewProcess(), processName)));
    }

    public boolean isNoReviewProcessMsgDisplayed() {
        return isElementDisplayed(waitShort, reviewerPO.getNoReviewProcessAvailable());
    }

    public boolean isReviewProcessDisplayed(String processName) {
        return isElementDisplayed(waitShort, xpath(format(reviewerPO.getProcessNameInTable(), processName)));
    }

    private void selectReviewerMethod(String reviewerMethod, int sectionPosition) {
        clickOn(xpath(format(reviewerPO.getRadioButtonReviewerMethod(),
                             reviewerMethod.toUpperCase().replace(StringUtils.SPACE, EMPTY),
                             sectionPosition)));
    }

    private void fillInReviewer(WorkflowReviewerApproverData reviewerData, int sectionPosition) {
        String[] reviewers = reviewerData.getReviewer().split(COMMA);
        if (context.getScenarioContext().isContains(reviewers[0])) {
            clearAndFillInValueAndSelectFromDropDown(
                    ((UserData) context.getScenarioContext().getContext(reviewers[0])).getFirstName(),
                    xpath(format(reviewerPO.getInputReviewer(), sectionPosition, REVIEWER)),
                    format(reviewerPO.getDropDownOption(),
                           ((UserData) context.getScenarioContext().getContext(reviewers[0])).getFirstName()));
        } else {
            clearAndFillInValueAndSelectFromDropDown(
                    reviewers[0], xpath(format(reviewerPO.getInputReviewer(), sectionPosition, REVIEWER)),
                    format(reviewerPO.getDropDownOption(), reviewers[0]));
        }
        IntStream.rangeClosed(1, reviewers.length - 1).forEach(
                i -> {
                    String reviewer = reviewers[i];
                    if (context.getScenarioContext().isContains(reviewer)) {
                        reviewer = ((UserData) context.getScenarioContext().getContext(reviewer)).getFirstName();
                    }
                    fillInValueAndSelectFromDropDown(
                            reviewer,
                            xpath(format(reviewerPO.getInputReviewer(), sectionPosition, REVIEWER)),
                            xpath(format(reviewerPO.getDropDownOption(), reviewer)));
                });
    }

    private void fillInRuleFor(WorkflowReviewerApproverData reviewerData, int sectionPosition) {
        waitMoment.until(elementToBeClickable(
                xpath(format(reviewerPO.getInputReviewer(), sectionPosition, reviewerData.getAddRulesFor()))));
        clearAndFillInValueAndSelectFromDropDown(reviewerData.getActivityOwner(),
                                                 xpath(format(reviewerPO.getInputReviewer(), sectionPosition,
                                                              reviewerData.getAddRulesFor())),
                                                 format(reviewerPO.getDropDownOption(),
                                                        reviewerData.getActivityOwner()));
    }

    private void fillInAddRuleFor(WorkflowReviewerApproverData reviewerData, int sectionPosition) {
        clearAndFillInValueAndSelectFromDropDown(reviewerData.getAddRulesFor(),
                                                 xpath(format(reviewerPO.getInputReviewer(), sectionPosition,
                                                              ADD_RULES_FOR)),
                                                 format(reviewerPO.getDropDownOption(), reviewerData.getAddRulesFor()));
    }

    private String getEditMultiplyField(String field, int sectionPosition) {
        return waitMoment.until(visibilityOfElementLocated(
                        xpath(format(reviewerPO.getInputReviewerValue(), sectionPosition, field))))
                .getText().replace(DOUBLE_SPACE, EMPTY);
    }

    public String getRuleSectionNumber(String sectionPosition) {
        return getElementText(xpath(format(reviewerPO.getReviewRule(), sectionPosition)));
    }

}