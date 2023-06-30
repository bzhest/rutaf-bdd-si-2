package com.refinitiv.asts.test.ui.pageActions.setUp.dueDilligenceOrderManagement;

import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.dueDilligenceOrder.DueDiligenceOrderApprovalPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowGroupData;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.WorkflowApi.getWorkflowGroupsList;
import static com.refinitiv.asts.test.ui.constants.Pages.DUE_DILIGENCE_ORDER_APPROVAL;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.GroupFields.GROUP_NAME_UPPER_CAMEL_CASE;
import static com.refinitiv.asts.test.ui.enums.UserFields.*;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.*;
import static java.lang.String.format;
import static java.util.Objects.nonNull;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.numberOfElementsToBeMoreThan;

public class DueDiligenceOrderApprovalPage extends BasePage<DueDiligenceOrderApprovalPage> {

    private final DueDiligenceOrderApprovalPO dueDiligenceOrderApprovalPO;

    public DueDiligenceOrderApprovalPage(WebDriver driver) {
        super(driver);
        dueDiligenceOrderApprovalPO = new DueDiligenceOrderApprovalPO(driver);
    }

    @Override
    protected ExpectedCondition<DueDiligenceOrderApprovalPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return isElementDisplayed(waitShort, dueDiligenceOrderApprovalPO.getDueDiligenceApprovalPage());
    }

    @Override
    public void load() {

    }

    public void deleteAllRulesExceptDefault() {
        By removeIcon = xpath(format(dueDiligenceOrderApprovalPO.getDeleteRuleIcon(), 1));
        while (isElementDisplayed(removeIcon)) {
            clickOn(removeIcon);
        }
    }

    public void deleteRuleValueIcons(Integer ruleIndex) {
        moveToElementAndClick(
                driver.findElement(xpath(format(dueDiligenceOrderApprovalPO.getDropdownRuleCrossIcon(), ruleIndex))),
                1);
    }

    public void navigateToDueDiligenceApprovalPage() {
        driver.get(URL + DUE_DILIGENCE_ORDER_APPROVAL);
    }

    public boolean isDefaultApproverRadioNameDisplayed(String radio) {
        return isElementDisplayed(xpath(format(dueDiligenceOrderApprovalPO.getDefaultApproverRadios(), radio)));
    }

    public boolean isDefaultApproverAdvancedSearchLinkDisabled() {
        return isElementAttributeContains(dueDiligenceOrderApprovalPO.getDefaultApproverAdvancedSearchLink(), CLASS,
                                          DISABLED);
    }

    public boolean isRuleAdvancedSearchLinkDisabled(Integer ruleNumber) {
        return isElementAttributeContains(
                xpath(format(dueDiligenceOrderApprovalPO.getRuleAdvancedSearchLink(), ruleNumber)), CLASS,
                DISABLED);
    }

    public boolean isAddRulesButtonDisabled() {
        return isElementAttributeContains(dueDiligenceOrderApprovalPO.getAddRulesButton(), CLASS, DISABLED);
    }

    public boolean isDeleteButtonDisplayed(int rulePosition) {
        return isElementDisplayed(xpath(format(dueDiligenceOrderApprovalPO.getDeleteRuleIcon(), rulePosition)));
    }

    public boolean isClearButtonDisplayed() {
        return isElementDisplayed(dueDiligenceOrderApprovalPO.getClearButton());
    }

    public void clickResetButton() {
        clickOn(dueDiligenceOrderApprovalPO.getResetButton());
    }

    public void clickAddRulesButton() {
        clickOn(dueDiligenceOrderApprovalPO.getAddRulesButton());
    }

    public void clickDefaultApproverDropdown() {
        clickOn(dueDiligenceOrderApprovalPO.getDefaultApproverDropdownInput());
    }

    public void cleanDefaultApproverDropdown() {
        clearText(dueDiligenceOrderApprovalPO.getDefaultApproverDropdownInput());
    }

    public void clickApproverDropdown(Integer ruleNumber) {
        clickOn(xpath(format(dueDiligenceOrderApprovalPO.getRuleApproverInput(), ruleNumber)));
    }

    public void cleanApproverDropdown(Integer ruleNumber) {
        clearText(xpath(format(dueDiligenceOrderApprovalPO.getRuleApproverInput(), ruleNumber)));
    }

    public void selectUserApproverForRule(String ruleType, int ruleNumber) {
        clearAndFillInValueAndSelectFromDropDown(ruleType,
                                                 xpath(format(dueDiligenceOrderApprovalPO.getRuleApproverInput(),
                                                              ruleNumber)),
                                                 xpath(format(dueDiligenceOrderApprovalPO.getDropdownOption(),
                                                              ruleType)));
    }

    public void selectUserGroupApproverForRule(String ruleType, int ruleNumber) {
        clearAndFillInValueAndSelectFromDropDown(ruleType,
                                                 xpath(format(dueDiligenceOrderApprovalPO.getRuleApproverInput(),
                                                              ruleNumber)),
                                                 xpath(format(
                                                         dueDiligenceOrderApprovalPO.getDropdownOption(), ruleType)));
    }

    public void selectRandomSubtype(Integer ruleNumber) {
        selectRandomValueFromDropdown(xpath(format(dueDiligenceOrderApprovalPO.getRuleSubTypeInputOpen(), ruleNumber)));
    }

    public void selectRandomRule(int ruleNumber) {
        selectRandomValueFromDropdown(xpath(format(dueDiligenceOrderApprovalPO.getRuleTypeInputOpen(), ruleNumber)));
    }

    public void selectRandomUserGroupApprover(Integer ruleNumber) {
        selectRandomValueFromDropdown(
                xpath(format(dueDiligenceOrderApprovalPO.getRuleApproverInputOpen(), ruleNumber)));
    }

    private void selectRandomValueFromDropdown(By fieldInput) {
        selectRandomFromDropdown(waitMoment, fieldInput, dueDiligenceOrderApprovalPO.getDropdownOptions(),
                                 dueDiligenceOrderApprovalPO.getDropdownOption());
    }

    public List<String> getDropDownValues() {
        waitMoment.until(numberOfElementsToBeMoreThan(dueDiligenceOrderApprovalPO.getDropdownOptions(), 2));
        return getDropDownOptions(dueDiligenceOrderApprovalPO.getDropdownOptions());
    }

    public void clickRuleDropdown(int ruleNumber) {
        clickOn(xpath(format(dueDiligenceOrderApprovalPO.getRuleTypeInput(), ruleNumber)));
    }

    public List<String> getRuleOptions(int ruleNumber) {
        clickRuleDropdown(ruleNumber);
        return getDropDownValues();
    }

    public List<UserData> getSearchResults() {
        List<String> columnNames = getSearchResultTableColumns();
        return driver.findElements(dueDiligenceOrderApprovalPO.getSearchResultTableRows()).stream()
                .map(row -> UserData.builder()
                        .firstName(getColumnValue(row, columnNames, FIRST_NAME.getName()))
                        .lastName(getColumnValue(row, columnNames, LAST_NAME.getName()))
                        .role(getColumnValue(row, columnNames, ROLE.getName()))
                        .group(getColumnValue(row, columnNames, GROUP_NAME_UPPER_CAMEL_CASE.getField())).build())
                .collect(Collectors.toList());
    }

    private String getColumnValue(WebElement row, List<String> columnNames, String columnName) {
        int columnNameIndex = columnNames.indexOf(columnName.toUpperCase()) + 1;
        return columnNameIndex == 0 ? null :
                getElementText(row.findElement(xpath(format(dueDiligenceOrderApprovalPO.getTableRowValue(),
                                                            columnNameIndex))));
    }

    public List<String> getSearchResultTableColumns() {
        scrollIntoView(dueDiligenceOrderApprovalPO.getSearchResultTableColumns());
        return driver.findElements(dueDiligenceOrderApprovalPO.getSearchResultTableColumns()).stream()
                .map(WebElement::getText).collect(Collectors.toList());
    }

    public void selectRuleType(String ruleType, int ruleNumber) {
        clearAndFillInValueAndSelectFromDropDown(ruleType,
                                                 xpath(format(dueDiligenceOrderApprovalPO.getRuleTypeInput(),
                                                              ruleNumber)),
                                                 xpath(format(dueDiligenceOrderApprovalPO.getDropdownOption(),
                                                              ruleType)));
    }

    public String getDropdownErrorText(String dropdownTitle) {
        return getElementText(xpath(format(dueDiligenceOrderApprovalPO.getDropdownWithErrorText(), dropdownTitle)));
    }

    public String getDialogTitle() {
        return getElementText(waitShort, dueDiligenceOrderApprovalPO.getAdvancedSearchDialogTitle());
    }

    public String getDefaultApproverValue() {
        return getAttributeValue(dueDiligenceOrderApprovalPO.getDefaultApproverDropdownInput(), VALUE);
    }

    public String getAdvancedSearchEmptyResult() {
        return getElementText(waitShort, dueDiligenceOrderApprovalPO.getAdvancedSearchDialogEmptyResult());
    }

    public void fillInValueAndSelectFromMultiSelectDropDown(String inputValue, By inputFieldLocator) {
        waitForAngularPageIsLoaded();
        clearAndFillInValueAndSelectFromDropDown(inputValue, inputFieldLocator,
                                                 dueDiligenceOrderApprovalPO.getDropdownOption());
    }

    public void selectRuleRadio(int ruleNumber, String radioValue) {
        clickOn(xpath(format(dueDiligenceOrderApprovalPO.getRuleRadio(), radioValue, ruleNumber)));
    }

    public void clickDefaultApproverAdvancedSearch() {
        clickOn(dueDiligenceOrderApprovalPO.getDefaultApproverAdvancedSearchLink());
    }

    public void fillInSearchValue(String inputField, String value) {
        clearAndInputField(xpath(format(dueDiligenceOrderApprovalPO.getAdvancedSearchInput(), inputField)), value);
    }

    public void clickAdvancedSearchButton(String buttonName) {
        clickOn(xpath(format(dueDiligenceOrderApprovalPO.getAdvancedSearchButton(), buttonName)));
    }

    public void clickAdvancedSearchResult(String resultName) {
        clickOn(xpath(format(dueDiligenceOrderApprovalPO.getAdvancedSearchRadioButton(), resultName)));
    }

    public void fillInRuleOptions(Integer ruleNumber, String values) {
        Arrays.asList(values.split(COMMA)).forEach(value -> fillInValueAndSelectFromMultiSelectDropDown(
                value, xpath(format(dueDiligenceOrderApprovalPO.getRuleSubTypeInput(), ruleNumber))));
    }

    public void fillInRuleOptions(Integer ruleNumber) {
        int numberOfGroupsForMultiSelectDropdown = 3;
        List<String> options =
                getWorkflowGroupsList(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, DEFAULT_SORT_BY, DEFAULT_SORT)
                        .stream()
                        .filter(option -> option.getStatus().equals(ACTIVE.getStatus()))
                        .map(WorkflowGroupData::getGroupName)
                        .limit(numberOfGroupsForMultiSelectDropdown)
                        .collect(Collectors.toList());
        options.forEach(value -> fillInValueAndSelectFromMultiSelectDropDown(
                value, xpath(format(dueDiligenceOrderApprovalPO.getRuleSubTypeInput(), ruleNumber))));
    }

    public void clickDefaultApproverRadioButton(String buttonName) {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(xpath(format(dueDiligenceOrderApprovalPO.getDefaultApproverRadioButton(), buttonName)));
    }

    public void clickSaveButton() {
        clickOn(dueDiligenceOrderApprovalPO.getSaveButton());
    }

    public void selectDefaultApproverDropdown(String value) {
        clearAndFillInValueAndSelectFromDropDown(value, dueDiligenceOrderApprovalPO.getDefaultApproverDropdownInput(),
                                                 dueDiligenceOrderApprovalPO.getDropdownOption());
    }

    public int getApproverRulesCount() {
        return driver.findElements(dueDiligenceOrderApprovalPO.getApprovalRules()).size();
    }

    public boolean isSearchResultMatchRequest(String firstName, String lastName, String groupName) {
        return getSearchResults().stream().allMatch(result -> {
            if (nonNull(groupName)) {
                return result.getGroup().equalsIgnoreCase(groupName);
            } else {
                if (nonNull(firstName) && nonNull(lastName)) {
                    return result.getFirstName().equalsIgnoreCase(firstName) &&
                            result.getLastName().equalsIgnoreCase(lastName);
                } else if (nonNull(firstName)) {
                    return result.getFirstName().equalsIgnoreCase(firstName);
                } else {
                    return result.getLastName().equalsIgnoreCase(lastName);
                }
            }
        });
    }

    public boolean isColumnSortable(String column) {
        return isElementDisplayed(xpath(format(dueDiligenceOrderApprovalPO.getColumnSortIcon(), column)));
    }

}
