package com.refinitiv.asts.test.ui.pageActions.setUp;

import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageActions.SearchSectionPage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.ApprovalProcessPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.approvalProcess.ApprovalProcessDetailsData;
import com.refinitiv.asts.test.ui.utils.data.ui.ApprovalProcessDTO;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.ArrayList;
import java.util.List;

import static com.refinitiv.asts.test.ui.constants.Pages.APPROVAL_PROCESS_PATH;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static java.lang.String.format;
import static java.util.stream.Collectors.toList;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class ApprovalProcessPage extends BasePage<ApprovalProcessPage> {

    private final ApprovalProcessPO approvalProcessPO;
    private final SearchSectionPage searchPage;

    public ApprovalProcessPage(WebDriver driver) {
        super(driver);
        approvalProcessPO = new ApprovalProcessPO(driver);
        searchPage = new SearchSectionPage(driver);
    }

    @Override
    protected ExpectedCondition<ApprovalProcessPage> getPageLoadCondition() {
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

    public void navigateToApprovalProcessPage() {
        driver.get(URL + APPROVAL_PROCESS_PATH);
    }

    public void clickApprovalProcessHeader() {
        clickOn(waitShort.until(visibilityOfElementLocated(approvalProcessPO.getAddApprovalProcessHeaderLink())));
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public boolean isApprovalProcessOverviewPageDisplayed() {
        return isElementDisplayed(approvalProcessPO.getApprovalProcessOverviewHeader());
    }

    public void searchApprovalProcess(String processName) {
        searchPage.searchItem(processName);
        waitForAngularPageIsLoaded();
    }

    public void clickApprovalProcessButton(String button) {
        clickOn(xpath(format(approvalProcessPO.getApprovalProcessButtons(), button)));
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void clickAddApprovalProcessButton() {
        clickOn(waitShort.until(visibilityOfElementLocated(approvalProcessPO.getAddApprovalProcessButton())));
    }

    public void clickApproverProcessMenu() {
        clickOn(approvalProcessPO.getApprovalProcessMenu(), waitShort);
    }

    public void clickButtonWithName(String name) {
        clickOn(xpath(format(approvalProcessPO.getApprovalProcessButtons(), name)));
    }

    public void fillInApprovalProcessNameField(String name) {
        clearInputAndEnterField(approvalProcessPO.getApprovalProcessNameInput(), name);
    }

    public void selectValueInAddRulesForDropDown(String value, int ruleNumber) {
        By dropDownInputLocator = xpath(format(approvalProcessPO.getDropDownAddRulesFor(), ruleNumber));
        selectItemFromDropDown(dropDownInputLocator, value);
    }

    public void selectValueInDefaultApproverDropDown(String value) {
        selectItemFromDropDownDefaultApprover(approvalProcessPO.getDropDownDefaultApprover(), value);
    }

    public void selectValueInApproverDropDown(String value, int ruleNumber) {
        By dropDownInputLocator = xpath(format(approvalProcessPO.getMultiSelectApprover(), ruleNumber));
        waitShort.until(elementToBeClickable(dropDownInputLocator));
        selectItemFromMultiSelect(dropDownInputLocator, value);
        getElement(dropDownInputLocator).sendKeys(Keys.ESCAPE);
    }

    public void selectValueInActivityOwnerDD(String dropdownLabel, String value, int ruleNumber) {
        By dropDownInputLocator = xpath(format(approvalProcessPO.getDropdownInput(), ruleNumber, dropdownLabel));
        fillInText(dropDownInputLocator, value);
        clickOn(xpath(format(approvalProcessPO.getDropDownOption(), value)));
    }

    public void selectValueFromDropdown(String dropdownLabel, String value, int ruleNumber) {
        By dropDownInputLocator =
                xpath(format(approvalProcessPO.getDropdownInput(), ruleNumber, dropdownLabel));
        waitShort.until(elementToBeClickable(dropDownInputLocator));
        selectItemFromMultiSelect(dropDownInputLocator, value);
    }

    public void selectAddRuleForValueFromDropdown(String ruleValue, String rule, int ruleNumber) {
        By dropDownInputLocator = xpath(format(approvalProcessPO.getAddRuleFor(), rule, ruleNumber));
        waitShort.until(elementToBeClickable(dropDownInputLocator));
        selectItemFromDropDown(dropDownInputLocator, ruleValue);
        getElement(dropDownInputLocator).sendKeys(Keys.ESCAPE);
    }

    public List<String> selectValueInActivityOwnerDD(String dropdownLabel, int valuesNumber, int ruleNumber) {
        int count = 0;
        int maxTries = 5;
        while (count < maxTries && !isElementDisplayedNow(approvalProcessPO.getDropDownOptions())) {
            clickOn(xpath(format(approvalProcessPO.getDropdownInput(), ruleNumber, dropdownLabel)));
            count++;
        }
        List<String> selectedValues = new ArrayList<>();
        List<String> values = getElementsText(
                waitShort.until(numberOfElementsToBeMoreThan(approvalProcessPO.getDropDownOptions(), 1)));
        for (int i = 0; i < valuesNumber; i++) {
            selectValueInActivityOwnerDD(dropdownLabel, values.get(i), ruleNumber);
            selectedValues.add(values.get(i));
        }
        return selectedValues;
    }

    public List<String> selectValueInApproverDropDown(int valuesNumber, int ruleNumber) {
        By dropDownInputLocator = xpath(format(approvalProcessPO.getMultiSelectApprover(), ruleNumber));
        List<String> selectedValues = new ArrayList<>();
        clickOn(dropDownInputLocator);
        List<String> values = getFirstTenDropDownValues();
        for (int i = 0; i < valuesNumber; i++) {
            selectValueInApproverDropDown(values.get(i), ruleNumber);
            selectedValues.add(values.get(i));
        }
        return selectedValues;
    }

    public void clickAddButton() {
        clickOn(approvalProcessPO.getButtonAddRule());
    }

    public void clickRemoveButton(int ruleNumber) {
        clickOn(xpath(format(approvalProcessPO.getButtonRemove(), ruleNumber)));
    }

    public void clickEditButtonForApprovalProcess(String processName) {
        By element = xpath(format(approvalProcessPO.getEditButtonForProcessWithName(), processName));
        clickOn(waitShort.until(visibilityOfElementLocated(element)));
    }

    public void clearDefaultApproverDropDown() {
        WebElement crossIcon = getElement(approvalProcessPO.getDropDownDefaultApprover()).findElement(
                approvalProcessPO.getClearDropdownCrossIcon());
        moveToElementAndClick(crossIcon);
        clickOn(crossIcon);
    }

    public void clickFirstApprovalProcessName() {
        waitShort.until(numberOfElementsToBe(approvalProcessPO.getApprovalProcessRow(), 1));
        clickOn(approvalProcessPO.getApprovalProcessName());
    }

    public List<ApprovalProcessDTO> getAllApprovalProcessesWithinSetUpContext() {
        waitWhilePreloadProgressbarIsDisappeared();
        waitMoment.until(numberOfElementsToBeMoreThan(approvalProcessPO.getApprovalProcessRow(), 0));
        return getElements(approvalProcessPO.getApprovalProcessRow())
                .stream().map(row -> new ApprovalProcessDTO()
                        .setProcessName(getChildElement(row, approvalProcessPO.getProcessName()))
                        .setDescription(getChildElement(row, approvalProcessPO.getDescription()))
                        .setStatus(getChildElement(row, approvalProcessPO.getStatus()))
                        .setEdit(getChildElement(row, approvalProcessPO.getEditButton()))
                        .setDelete(getChildElement(row, approvalProcessPO.getDeleteButton())))
                .collect(toList());
    }

    public String getFirstApprovalProcessName() {
        waitShort.until(numberOfElementsToBeMoreThan(approvalProcessPO.getApprovalProcessRow(), 0));
        return getElementText(approvalProcessPO.getApprovalProcessName());
    }

    public List<String> getTableColumns() {
        return getElementsText(driver.findElements(approvalProcessPO.getTableColumnsNames()));
    }

    public String getPageTileValue() {
        return getElementText(approvalProcessPO.getTitle());
    }

    public List<String> getApprovalProcessFieldTitles() {
        return getElementsText(approvalProcessPO.getApprovalProcessFieldTitles());
    }

    public boolean isModalWindowVisible() {
        return isElementDisplayed(waitMoment, approvalProcessPO.getModal());
    }

    public boolean isModalWithNameDisplayed(String modalName) {
        return isElementDisplayed(waitMoment,
                                  xpath(format(approvalProcessPO.getModalWithName(), modalName)));
    }

    public boolean buttonShouldBeVisible(String button) {
        return isElementDisplayed(waitMoment, xpath(format(approvalProcessPO.getApprovalProcessButtons(), button)));
    }

    public boolean isDropDownWithNameRequired(String dropDownName) {
        return isElementDisplayed(waitMoment,
                                  xpath(format(approvalProcessPO.getIsDropDownWithNameRequired(), dropDownName)));
    }

    public boolean isAddButtonEnabled() {
        return isElementDisplayed(approvalProcessPO.getButtonAddRule());
    }

    public boolean isAddRulesForDropDownDisplayed(int ruleNumber) {
        return isElementDisplayed(xpath(format(approvalProcessPO.getDropDownAddRulesFor(), ruleNumber)));
    }

    public boolean isActivityOwnerDropDownDisplayed(int ruleNumber) {
        return isElementDisplayed(xpath(format(approvalProcessPO.getMultiSelectActivityOwner(), ruleNumber)));
    }

    public boolean isRuleValueDropDownDisplayed(int ruleNumber) {
        return isElementDisplayed(xpath(format(approvalProcessPO.getAddRuleForValue(), ruleNumber)));
    }

    public boolean isApproverDropDownDisplayed(int ruleNumber) {
        return isElementDisplayed(xpath(format(approvalProcessPO.getMultiSelectApprover(), ruleNumber)));
    }

    public boolean isApproverMethodDisplayed(int ruleNumber) {
        return isElementDisplayed(xpath(format(approvalProcessPO.getApproverMethodField(), ruleNumber)));
    }

    public boolean isRemoveButtonDisplayedForRule(int ruleNumber) {
        return isElementDisplayed(xpath(format(approvalProcessPO.getButtonRemove(), ruleNumber)));
    }

    public void clickDropDownActivityOwner(String dropdownLabel, int ruleNumber) {
        int count = 0;
        int maxTries = 5;
        while (count < maxTries && !isElementDisplayedNow(approvalProcessPO.getDropDownOptions())) {
            clickOn(xpath(format(approvalProcessPO.getDropdownInput(), ruleNumber, dropdownLabel)));
            count++;
        }
    }

    public void clickDropDownAddRulesFor(int ruleNumber) {
        clickOn(xpath(format(approvalProcessPO.getDropDownAddRulesFor(), ruleNumber)));
    }

    public void clickApproverMethod(String method, int ruleNumber) {
        clickOn(xpath(format(approvalProcessPO.getRadioApproverMethod(), method.toUpperCase(), ruleNumber)));
    }

    public boolean isApproverAddButtonDisplayed() {
        return isElementDisplayed(approvalProcessPO.getButtonAddRule());
    }

    public List<String> getDropDownValues() {
        return getDropDownOptions(approvalProcessPO.getDropDownItems());
    }

    public List<String> getFirstTenDropDownValues() {
        return getElements(approvalProcessPO.getDropDownItems()).stream()
                .limit(10)
                .map(this::getElementText)
                .collect(toList());
    }

    public List<String> getActivityOwnerDDValues(String dropDownType, int ruleNumber) {
        return getElementsText(
                xpath(format(approvalProcessPO.getMultiSelectActivityOwnerValues(), dropDownType, ruleNumber)));
    }

    public List<String> getApproverDDValues(int ruleNumber) {
        return getElements(xpath(format(approvalProcessPO.getMultiSelectApproverValues(), ruleNumber))).stream()
                .map(WebElement::getText).collect(toList());
    }

    private void selectItemFromMultiSelect(By dropDownLocator, String value) {
        fillInText(dropDownLocator, value);
        clickOn(xpath(format(approvalProcessPO.getDropDownOption(), value)));
    }

    public boolean isApprovalProcessListOpened() {
        return isElementDisplayed(approvalProcessPO.getAddApprovalTableBody());
    }

    public boolean isNoApprovalProcessMsgDisplayed() {
        return isElementDisplayed(waitShort, approvalProcessPO.getNoApprovalProcessAvailable());
    }

    private void selectItemFromDropDown(By dropDownLocator, String value) {
        By dropDownInputItem = xpath(format(approvalProcessPO.getDropDownOption(), value));
        clearAndFillInValueAndSelectFromDropDown(value, dropDownLocator, dropDownInputItem);
    }

    private void selectItemFromDropDownDefaultApprover(By dropDownLocator, String value) {
        By dropDownInputItem = xpath(format(approvalProcessPO.getDropDownOption(), value));
        clearAndFillInValueAndSelectFromDropDown(value, dropDownLocator, dropDownInputItem);
    }

    public boolean isFieldInvalidAriaDisplayed(String fieldName) {
        return isElementDisplayed(xpath(format(approvalProcessPO.getValidationMessage(), fieldName)));
    }

    public boolean isActiveCheckboxChecked() {
        return getAttributeValue(approvalProcessPO.getActiveCheckboxState(), CLASS).contains(MUI_CHECKED);
    }

    public String getErrorMessageText(String fieldName) {
        return getElementText(xpath(format(approvalProcessPO.getValidationMessage(), fieldName)));
    }

    public String getErrorMessageElementCSS(String fieldName, String attribute) {
        return getElementByXPath(format(approvalProcessPO.getValidationMessage(), fieldName)).getCssValue(attribute);
    }

    public void clickOnApprovalProcessWithName(String processName) {
        clickOn(xpath(format(approvalProcessPO.getApprovalProcessWithName(), processName)));
    }

    public void clickOnEditApprovalProcessButton() {
        clickOn(approvalProcessPO.getApprovalProcessEditButton(), waitMoment);
    }

    public ApprovalProcessDetailsData getApprovalProcessFieldValues() {
        return ApprovalProcessDetailsData.builder()
                .approvalProcessName(getAttributeValue(approvalProcessPO.getApprovalProcessNameInput(), VALUE))
                .defaultApprover(getAttributeValue(approvalProcessPO.getDefaultApproverFieldValue(), VALUE))
                .build();
    }

    public void clickOnDeleteButton(String processName) {
        clickOn(xpath(format(approvalProcessPO.getDeleteButtonForProcessWithName(), processName)));
    }

    public void clickActiveCheckbox() {
        clickOn(approvalProcessPO.getActiveCheckbox());
    }

    public void clickSelectApprovalProcess() {
        clickOn(approvalProcessPO.getSelectRadioButton());
    }

}
