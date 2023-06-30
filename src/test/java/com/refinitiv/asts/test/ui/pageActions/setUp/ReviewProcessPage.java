package com.refinitiv.asts.test.ui.pageActions.setUp;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.ReviewProcessPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.reviewProcess.ReviewProcessData;
import com.refinitiv.asts.test.ui.utils.data.ui.ReviewProcessDTO;
import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.REVIEW_PROCESSES_LIST;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.UNCHECKED;
import static com.refinitiv.asts.test.ui.constants.Pages.ADD_REVIEW_PROCESS;
import static com.refinitiv.asts.test.ui.constants.Pages.REVIEW_PROCESS;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static java.lang.String.format;
import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class ReviewProcessPage extends BasePage<ReviewProcessPage> {

    private final ReviewProcessPO reviewProcessPO;

    public ReviewProcessPage(WebDriver driver, ScenarioCtxtWrapper context) {
        super(driver, context);
        reviewProcessPO = new ReviewProcessPO(driver);
    }

    @Override
    protected ExpectedCondition<ReviewProcessPage> getPageLoadCondition() {
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

    public void deleteAllSelectedOptionsFromDropdown() {
        List<WebElement> iconsToDelete = getElements(reviewProcessPO.getDropdownCrossIcon());
        Collections.reverse(iconsToDelete);
        iconsToDelete.forEach(this::clickOn);
    }

    public void navigateToReviewProcessPage() {
        driver.get(URL + REVIEW_PROCESS);
    }

    public void navigateToReviewProcessPage(String endpoint) {
        driver.get(URL + REVIEW_PROCESS + endpoint);
    }

    public void navigateToAddReviewProcessPage() {
        driver.get(URL + ADD_REVIEW_PROCESS);
    }

    public void clickReviewProcessButton() {
        clickOn(reviewProcessPO.getAddReviewProcessButton(), waitShort);
    }

    public void clickReviewProcessButton(String button) {
        clickOn(cssSelector(format(reviewProcessPO.getFooterButtons(), button.toLowerCase())));
    }

    public boolean isReviewProcessButtonDisplayed(String button) {
        return isElementDisplayedNow(cssSelector(format(reviewProcessPO.getFooterButtons(), button.toLowerCase())));
    }

    public boolean isReviewProcessMainBlockFieldDisplayed(String field) {
        return isElementDisplayed(xpath(format(reviewProcessPO.getMainBlockField(), field)));
    }

    public boolean isReviewProcessDefaultReviewerBlockFieldDisplayed(String field) {
        return isElementDisplayed(xpath(format(reviewProcessPO.getDefaultReviewerField(), field)));
    }

    public boolean isReviewProcessReviewerBlockFieldDisplayed(String blockNumber, String field) {
        return isElementDisplayed(xpath(format(reviewProcessPO.getReviewerField(), blockNumber, field)));
    }

    public boolean isModalDisplayed(String pageName) {
        return isElementDisplayed(xpath(format(reviewProcessPO.getEditPage(), pageName)));
    }

    public boolean isAddButtonIsActive() {
        return isElementEnabled(reviewProcessPO.getAddReviewerButton());
    }

    public boolean isAddButtonIsDisplayed() {
        return isElementDisplayed(reviewProcessPO.getAddReviewerButton());
    }

    public void clickAddReviewButton() {
        clickOn(reviewProcessPO.getAddReviewerButton());
    }

    public boolean isErrorMessageDisplayed(String fieldName) {
        return isElementDisplayedNow(xpath(format(reviewProcessPO.getErrorMessage(), fieldName)));
    }

    public boolean isReviewProcessFieldEnabled(String fieldName) {
        return isReactFieldEnabled(reviewProcessPO.getModalField(), fieldName);
    }

    public boolean isReviewProcessOverviewPageDisplayed() {
        return isElementDisplayed(waitShort, xpath(reviewProcessPO.getOverviewHeader()));
    }

    public boolean isDeleteReviewProcessButtonDisplayed(String reviewProcessName) {
        return isElementDisplayed(xpath(format(reviewProcessPO.getDeleteButton(), reviewProcessName)));
    }

    public boolean isEditReviewProcessButtonDisplayed(String reviewProcessName) {
        return isElementDisplayed(xpath(format(reviewProcessPO.getEditRowButton(), reviewProcessName)));
    }

    public boolean isAddReviewProcessButtonDisplayed() {
        return isElementDisplayed(reviewProcessPO.getAddReviewProcessButton());
    }

    public boolean isEditButtonDisplayed() {
        return isElementDisplayed(reviewProcessPO.getEditButton());
    }

    public boolean isActiveCheckboxSelected() {
        return isElementAttributeContains(reviewProcessPO.getActiveCheckbox(), CLASS, CHECKED);
    }

    public void removeReviewerBlock(String blockNumber) {
        By removeIcon = xpath(format(reviewProcessPO.getRemoveReviewerBlockIcon(), blockNumber));
        clickOn(removeIcon);
        waitMoment.until(invisibilityOfElementLocated(removeIcon));
    }

    public void selectDefaultReviewer(String defaultReviewer) {
        clearAndFillInValueAndSelectFromDropDown(defaultReviewer,
                                                 reviewProcessPO.getDefaultReviewerInput());
    }

    public void clickDropDownDefaultReviewer() {
        clickOn(reviewProcessPO.getDefaultReviewerInput());
    }

    public void fillInMainBlock(ReviewProcessData reviewerProcessData) {
        fillInName(reviewerProcessData.getReviewProcessName());
        clearInputAndEnterField(reviewProcessPO.getDescription(), reviewerProcessData.getDescription());
        selectActiveCheckbox(reviewerProcessData.getActive());
    }

    public void fillInName(String name) {
        waitLong.until(visibilityOfElementLocated(reviewProcessPO.getProcessNameInput()));
        clearInputAndEnterField(reviewProcessPO.getProcessNameInput(), name);
    }

    public void selectActiveCheckbox(String status) {
        selectReactCheckbox(reviewProcessPO.getActiveCheckbox(), status);
    }

    public void fillInReviewerBlock(ReviewProcessData data) {
        fillInAddRuleFor(data.getAddRulesFor());
        data.getActivityOwner()
                .forEach(owner -> fillInValueAndSelectFromMultiSelectActivityOwnerDropDown(owner,
                                                                                           reviewProcessPO.getActivityOwnerInput()));
        data.getReviewer()
                .forEach(reviewer -> fillInValueAndSelectFromMultiSelectReviewerDropDown(reviewer,
                                                                                         reviewProcessPO
                                                                                                 .getReviewerInput()));
        clickReviewerMethod(data.getReviewerMethod());
    }

    public void selectRuleValue(String ruleFor, String value) {
        fillInValueAndSelectFromMultiSelectReviewerDropDown(value,
                                                            xpath(format(reviewProcessPO.getRuleInput(), ruleFor)));
    }

    public void fillInAddRuleFor(String addRuleFor) {
        waitShort.until(visibilityOfElementLocated(reviewProcessPO.getAddRulesForInput()));
        clearAndFillInValueAndSelectFromDropDown(addRuleFor, reviewProcessPO.getAddRulesForInput());
    }

    public void clickReviewerMethod(String reviewerMethod) {
        clickOn(cssSelector(format(reviewProcessPO.getReviewerMethod(), reviewerMethod)));
    }

    public void clickRuleValueInputButton(String reviewerMethod) {
        clickOn(xpath(format(reviewProcessPO.getRuleInputButton(), reviewerMethod)));
    }

    public void clickRuleReviewerInputButton() {
        clickOn(reviewProcessPO.getReviewerInputButton());
    }

    public ReviewProcessData getReviewerProcessDetails() {
        String rulesFor = getAttributeOrText(reviewProcessPO.getAddRulesForInput(), VALUE);
        return new ReviewProcessData()
                .setReviewProcessName(getAttributeOrText(reviewProcessPO.getProcessNameInput(), VALUE))
                .setDescription(getAttributeOrText(reviewProcessPO.getDescription(), VALUE).replace(StringUtils.LF,
                                                                                                    StringUtils.EMPTY))
                .setActive(isActiveCheckboxSelected() ? CHECKED : UNCHECKED)
                .setDefaultReviewer(getAttributeOrText(reviewProcessPO.getDefaultReviewerInput(), VALUE))
                .setAddRulesFor(rulesFor)
                .setActivityOwner(getRuleValues(rulesFor))
                .setReviewer(getRuleReviewers())
                .setReviewerMethod(getSelectedReviewerMethod().toUpperCase());
    }

    public List<String> getRuleValues(String rulesFor) {
        return getElementsText(xpath(format(reviewProcessPO.getRuleValues(), rulesFor)));
    }

    public List<String> getRuleReviewers() {
        return getElementsText(reviewProcessPO.getReviewerValues());
    }

    public List<ReviewProcessDTO> getAllReviewerProcesses() {
        List<ReviewProcessDTO> reviewProcessList = new ArrayList<>();
        waitShort.until(
                ExpectedConditions.numberOfElementsToBeMoreThan(reviewProcessPO.getRow(), 1));
        List<WebElement> rows = getElements(reviewProcessPO.getRow());
        for (WebElement row : rows) {
            reviewProcessList.add(new ReviewProcessDTO()
                                          .setName(row.findElement(reviewProcessPO.getName()))
                                          .setDescription(row.findElement(reviewProcessPO.getTableDescription()))
                                          .setStatus(row.findElement(reviewProcessPO.getStatus()))
                                          .setEdit(row.findElement(reviewProcessPO.getEdit()))
                                          .setDelete(row.findElement(reviewProcessPO.getDelete())));

        }
        context.getScenarioContext().setContext(REVIEW_PROCESSES_LIST, reviewProcessList);
        return reviewProcessList;
    }

    public ReviewProcessDTO getReviewProcessByName(String name) {
        return getAllReviewerProcesses()
                .stream()
                .filter(process -> process.getName().getText().equals(name))
                .findFirst()
                .orElse(null);
    }

    public ReviewProcessDTO getReviewProcessByDescription(String description) {
        return getAllReviewerProcesses()
                .stream()
                .filter(process -> process.getDescription().getText().equals(description))
                .findFirst()
                .orElse(null);
    }

    public String getStatusText(String reviewProcessName) {
        return getElementText(getReviewProcessByName(reviewProcessName).getStatus());
    }

    public String getEmptyTableMessage() {
        return getElementText(reviewProcessPO.getEmptyTableMessage());
    }

    public String getBreadcrumbText() {
        return getElementText(reviewProcessPO.getBreadcrumb()).replace(StringUtils.LF, StringUtils.EMPTY);
    }

    public String getSelectedReviewerMethod() {
        return getElementText(reviewProcessPO.getSelectedMethod());
    }

    public String getInputFieldIndicator(String fieldName, int elementPosition) {
        return getElementText(xpath(format(reviewProcessPO.getInputAsterisk(), fieldName, elementPosition)));
    }

    public String getInputMaxLength(String fieldName) {
        return getAttributeValue(xpath(format(reviewProcessPO.getModalFieldInput(), fieldName)), MAX_LENGTH);
    }

    public String getTableButtonColor(String buttonName) {
        return getCssValue(xpath(format(reviewProcessPO.getRowButton(), buttonName, buttonName.toLowerCase())), COLOR);
    }

    public List<String> getReviewerMethods() {
        return getElementsText(reviewProcessPO.getReviewerMethods());
    }

    public List<Integer> getRuleNumbers() {
        return getElementsText(reviewProcessPO.getRuleNumber()).stream().map(Integer::parseInt)
                .collect(Collectors.toList());
    }

    public List<String> getAllReviewerProcessesNames() {
        return getElements(reviewProcessPO.getRow()).stream()
                .map(row -> getElementText(row.findElement(reviewProcessPO.getName()))).collect(Collectors.toList());
    }

    public List<String> getListValuesForColumn(String columnName) {
        int columnIndex = getTableColumnNames().indexOf(columnName) + 1;
        return getElementsText(cssSelector(format(reviewProcessPO.getCellsWithIndex(), columnIndex)));
    }

    private List<String> getTableColumnNames() {
        return getElementsText(reviewProcessPO.getTableColumns());
    }

    public void clickDropDownAddRulesFor(int ruleNumber) {
        clickOn(xpath(format(reviewProcessPO.getDropDownAddRulesFor(), ruleNumber)));
    }

    public void selectValueInAddRulesForDropDown(String value, int ruleNumber) {
        By dropDownInputLocator = xpath(format(reviewProcessPO.getDropDownAddRulesFor(), ruleNumber));
        clearAndFillInValueAndSelectFromDropDown(value, dropDownInputLocator);
    }

    public void selectValueInActivityOwnerDD(String value, int ruleNumber) {
        By dropDownInputLocator = xpath(format(reviewProcessPO.getDropDownActivityOwner(), ruleNumber));
        waitShort.until(elementToBeClickable(dropDownInputLocator));
        fillInValueAndSelectFromMultiSelectDropDown(value, dropDownInputLocator);
    }

    public void selectValueInReviewerDropDown(String value, int ruleNumber) {
        By dropDownInputLocator = xpath(format(reviewProcessPO.getDropDownReviewer(), ruleNumber));
        fillInValueAndSelectFromMultiSelectReviewerDropDown(value, dropDownInputLocator);
    }

    public void clearAndFillInValueAndSelectFromDropDown(String inputValue, By inputFieldLocator) {
        clearAndFillInValueAndSelectFromDropDown(inputValue, inputFieldLocator, reviewProcessPO.getItemInDropdown());
    }

    private void fillInValueAndSelectFromMultiSelectDropDown(String inputValue, By inputFieldLocator) {
        waitShort.until(visibilityOfElementLocated(inputFieldLocator));
        clearAndFillInValueAndSelectFromDropDown(inputValue, inputFieldLocator,
                                                 reviewProcessPO.getItemInDropdown());
    }

    private void fillInValueAndSelectFromMultiSelectReviewerDropDown(String inputValue, By inputFieldLocator) {
        fillInValueAndSelectFromDropDown(inputValue, inputFieldLocator,
                                         xpath(format(reviewProcessPO.getDropDownOption(), inputValue)));
    }

    private void fillInValueAndSelectFromMultiSelectActivityOwnerDropDown(String inputValue, By inputFieldLocator) {
        fillInText(inputFieldLocator, inputValue);
        clickOn(xpath(format(reviewProcessPO.getDropDownOption(), inputValue)), waitMoment);
    }

    public void clearDefaultReviewerInput() {
        clearText(reviewProcessPO.getDefaultReviewerInput());
    }

    public void clearProcessNameInput() {
        clearText(reviewProcessPO.getProcessNameInput());
    }

    public void clickEditButton() {
        clickOn(reviewProcessPO.getEditButton(), waitShort);
    }

    public void hoverEditButton() {
        hoverOverElement(reviewProcessPO.getEditButton(), waitShort);
    }

    public void clickReviewProcessName(String reviewProcessName) {
        clickOn(waitShort.until(
                visibilityOfElementLocated(xpath(format(reviewProcessPO.getRowValue(), reviewProcessName)))));
    }

    public void clickReviewProcess() {
        clickOn(reviewProcessPO.getRow());
    }

    public void clickDeleteReviewProcess(String reviewProcessName) {
        clickOn(waitShort.until(
                visibilityOfElementLocated(xpath(format(reviewProcessPO.getDeleteButton(), reviewProcessName)))));
    }

    public void clickEditReviewProcess(String reviewProcessName) {
        clickOn(waitShort.until(
                visibilityOfElementLocated(xpath(format(reviewProcessPO.getEditRowButton(), reviewProcessName)))));
    }

    public void clickTableButton(String buttonName) {
        clickOn(xpath(format(reviewProcessPO.getRowButton(), buttonName, buttonName.toLowerCase())));
    }

    public void hoverTableButton(String buttonName) {
        hoverOverElement(xpath(format(reviewProcessPO.getRowButton(), buttonName, buttonName.toLowerCase())));
    }

    public void clickReviewProcessBreadcrumb() {
        clickOn(reviewProcessPO.getBreadcrumbButton());
    }

}