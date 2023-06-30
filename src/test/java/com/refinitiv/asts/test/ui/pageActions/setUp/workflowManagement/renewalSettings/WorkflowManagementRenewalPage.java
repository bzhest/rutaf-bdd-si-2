package com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.renewalSettings;

import com.google.common.collect.Iterables;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.workflowManagement.renewalSettings.RenewalSettingsPO;
import org.apache.logging.log4j.util.Strings;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.Objects;

import static com.refinitiv.asts.test.ui.constants.Pages.WORKFLOW_RENEWAL_SETTINGS;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static java.lang.Boolean.parseBoolean;
import static java.lang.String.format;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class WorkflowManagementRenewalPage extends BasePage<WorkflowManagementRenewalPage> {

    private final RenewalSettingsPO renewalSettingsPO;

    public WorkflowManagementRenewalPage(WebDriver driver) {
        super(driver);
        this.renewalSettingsPO = new RenewalSettingsPO(driver);
    }

    @Override
    protected ExpectedCondition<WorkflowManagementRenewalPage> getPageLoadCondition() {
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

    public void clickWorkflowManagementSubmenuRenewalSettings() {
        clickOn(renewalSettingsPO.getRenewalSettingMenu());
    }

    public void clickDefaultAssigneeRadioButton(String radioButtonName) {
        clickOn(xpath(format(renewalSettingsPO.getRadioButtonDefaultAssigneeButton(), radioButtonName)), waitLong);
    }

    public void clickSaveButton() {
        clickOn(renewalSettingsPO.getButtonSave());
    }

    public void clickRuleDropDownOfLastAddedRule() {
        clickRuleDropDownOfRuleWithIndex(getIndexNumberOfLastAddedRule());
    }

    public void selectValueFromDefaultAssigneeDropdown(String value) {
        clearAndFillInValueAndSelectFromDropDown(value,
                                                 renewalSettingsPO.getDropdownDefaultAssignee(),
                                                 renewalSettingsPO.getDropDownFoundAssignee());
    }

    public void selectValueFromValueDropdown(String value) {
        clearAndFillInValueAndSelectFromDropDown(value, Iterables.getLast(
                                                         getElements(format(renewalSettingsPO.getDropDownRule(),
                                                                            getIndexNumberOfLastAddedRule()))),
                                                 renewalSettingsPO.getDropDownFoundAssignee());
    }

    public void selectValueFromRuleDropDownOfLastAddedRule(String value) {
        selectValueFromRuleDropDownWithIndex(value, getIndexNumberOfLastAddedRule());
    }

    public void selectRandomValuesInRuleValueDropDownForLastAddedRule(int numberOfValues) {
        List<String> availableValues = getRuleValueDropDownValuesForLastAddedRule();
        for (int i = 0; i < numberOfValues; i++) {
            selectValueFromRuleValueDropDownForLastAddedRule(availableValues.get(i));
        }
    }

    public void selectAssigneeRulesRadioOfLastAddedRule(String name) {
        selectAssigneeRulesRadioOfRuleWithIndex(getIndexNumberOfLastAddedRule(), name);
    }

    public void clickDefaultAssigneeSectionAdvanceSearchLink() {
        clickOn(waitMoment.until(visibilityOfAllElements(getElements(renewalSettingsPO.getLinkAdvanceSearch())))
                        .get(0));
    }

    public void removeRandomValuesFromRuleValueDropDownOfLastAddedRule(int number) {
        if (getNumberOfRuleValueRemoveIconsOfRuleWithIndex(getIndexNumberOfLastAddedRule()) > 0) {
            for (int i = 0; i < number; i++) {
                clickOn(xpath(
                        format(renewalSettingsPO.getDropDownRuleValueDeleteIcon(), getIndexNumberOfLastAddedRule())));
            }
        } else {
            logger.info("No values are available to be removed!");
        }
    }

    public void clickAddRulesButton() {
        clickOn(renewalSettingsPO.getRenewalSettingsAddRulesButton());
    }

    public void selectRuleAssignee(String assignee, String ruleIndex) {
        clearAndFillInValueAndSelectFromDropDown(assignee,
                                                 By.xpath(String.format(renewalSettingsPO.getDropDownAssignee(),
                                                                        ruleIndex)),
                                                 By.xpath(String.format(renewalSettingsPO.getDropDownFoundAssignee(),
                                                                        assignee)));
    }

    public void selectRuleValue(String value, String ruleIndex) {
        clearAndFillInValueAndSelectFromDropDown(value,
                                                 By.xpath(String.format(renewalSettingsPO.getDropDownRuleValue(),
                                                                        ruleIndex)),
                                                 renewalSettingsPO.getDropDownFoundAssignee());
    }

    public void deleteRuleValueIcons(String ruleIndex) {
        By deleteRuleValueIcon = By.xpath(format(renewalSettingsPO.getDropDownRuleValueDeleteIcon(), ruleIndex));
        while (driver.findElements(deleteRuleValueIcon).size() > 0) {
            WebElement lastDeleteIcon = Iterables.getLast(getElements(deleteRuleValueIcon));
            clickOn(lastDeleteIcon, waitShort);
        }
    }

    public void deleteRedundantRuleValues(String ruleIndex) {
        List<WebElement> deleteRuleValueIcons =
                getElements(xpath(format(renewalSettingsPO.getDropDownRuleValueDeleteIcon(), ruleIndex)));
        if (deleteRuleValueIcons.size() > 1) {
            deleteRuleValueIcons(ruleIndex);
        }
    }

    public void navigateToWorkflowRenewalSettings() {
        driver.get(URL + WORKFLOW_RENEWAL_SETTINGS);
    }

    public void clickRemoveRuleIconForRuleWithIndex(String ruleNumber) {
        By removeIcon = By.xpath(format(renewalSettingsPO.getIconRemoveRule(), ruleNumber));
        if (isElementDisplayed(removeIcon)) {
            clickOn(removeIcon, waitMoment);
        }
    }

    public void clickNextRenewalDateRadio() {
        clickOn(renewalSettingsPO.getRadioNextRenewalDate());
    }

    public void clickDaysBeforeRenewalRadio() {
        clickOn(renewalSettingsPO.getRadioDaysBeforeRenewal());
    }

    public void fillInDaysBeforeRenewalText(String daysNumber) {
        WebElement daysBeforeRenewalText = getElement(renewalSettingsPO.getTextInputDaysBeforeRenewal());
        clickOn(daysBeforeRenewalText);
        clearInputAndEnterField(daysBeforeRenewalText, daysNumber);
    }

    public boolean isRenewalSettingsPageDisplayed() {
        waitShort.until(visibilityOfElementLocated(renewalSettingsPO.getRenewalSettingPageHeader()));
        return isElementDisplayed(renewalSettingsPO.getRenewalSettingPageHeader());
    }

    public boolean isSectionWithNameDisplayed(String sectionName) {
        return isElementDisplayed(xpath(format(renewalSettingsPO.getSectionName(), sectionName)));
    }

    public boolean isDefaultAssigneeRadioButtonDisplayedWithName(String radioButtonName) {
        return isElementDisplayed(
                xpath(format(renewalSettingsPO.getRadioButtonDefaultAssigneeSpan(), radioButtonName)));
    }

    public boolean isRenewalSettingsDefaultAssigneeDropdownDisplayed() {
        return isElementDisplayed(renewalSettingsPO.getDropdownDefaultAssignee());
    }

    public boolean isDefaultAssigneeDropdownDisabled() {
        return isElementDisplayed(renewalSettingsPO.getDropdownDefaultAssigneeDisabled());
    }

    public boolean isSaveButtonDisplayed() {
        return isElementDisplayed(renewalSettingsPO.getButtonSave());
    }

    public boolean isDefaultAssigneeDropdownEmpty() {
        return Strings.isEmpty(getElement(renewalSettingsPO.getDropdownDefaultAssignee()).getAttribute(VALUE));
    }

    public boolean doesDefaultAssigneeDropdownContainError() {
        return isElementDisplayed(renewalSettingsPO.getDropdownDefaultAssigneeError());
    }

    public boolean doesRuleValueDropDownOfLastAddedRuleContainError() {
        return doesDropDownOfRuleWithIndexContainError(renewalSettingsPO.getDropDownRuleValueError(),
                                                       getIndexNumberOfLastAddedRule());
    }

    public boolean doesAssigneeDropDownOfLastAddedRuleContainError() {
        return doesDropDownOfRuleWithIndexContainError(renewalSettingsPO.getDropDownAssigneeError(),
                                                       getIndexNumberOfLastAddedRule());
    }

    public boolean isDefaultAssigneeRadioButtonChecked(String radioButtonName) {
        return getAttributeValue(
                xpath(format(renewalSettingsPO.getRadioButtonDefaultAssigneeSpan(), radioButtonName)), CLASS)
                .contains(MUI_CHECKED);
    }

    public boolean isDefaultAssigneeSectionAdvanceSearchLinkDisplayed() {
        waitShort.until(visibilityOfAllElements(getElements(renewalSettingsPO.getLinkAdvanceSearch())));
        return isElementDisplayed(getElements(renewalSettingsPO.getLinkAdvanceSearch()).get(0));
    }

    public boolean isRenewalSettingsRulesSectionHeaderDisplayed() {
        waitWhilePreloadProgressbarIsDisappeared();
        waitLong.until(visibilityOfElementLocated(renewalSettingsPO.getRenewalSettingsRulesHeader()));
        return isElementDisplayed(renewalSettingsPO.getRenewalSettingsRulesHeader());
    }

    public boolean isRenewalSettingsRulesSectionDisplayed() {
        return isElementDisplayed(renewalSettingsPO.getRenewalSettingsRulesSection());
    }

    public boolean isAddRulesButtonDisplayed() {
        return isElementDisplayed(renewalSettingsPO.getRenewalSettingsAddRulesButton());
    }

    public boolean isAddRulesButtonEnabled() {
        return isElementEnabled(renewalSettingsPO.getRenewalSettingsAddRulesButton());
    }

    public boolean isRuleDropDownOfLastAddedRuleContainsValue(String value) {
        return getRuleDropDownValuesOfLastAddedRule().stream().anyMatch(v -> v.equals(value));
    }

    public boolean isRuleDropDownEnabledOfLastAddedRule() {
        return isRuleDropDownWithIndexEnabled(getIndexNumberOfLastAddedRule());
    }

    public boolean isRuleDropDownOfLastAddedRuleDisplayed() {
        return isRuleDropDownWithIndexDisplayed(getIndexNumberOfLastAddedRule());
    }

    public boolean isAssigneeDropDownOfLastAddedRuleDisplayed() {
        return isAssigneeDropDownWithIndexDisplayed(getIndexNumberOfLastAddedRule());
    }

    public boolean isRuleValueDropDownOfLastAddedRuleDisplayed() {
        return isRuleValueDropDownWithIndexDisplayed(getIndexNumberOfLastAddedRule());
    }

    public boolean isRuleValueDropDownOfLastAddedRuleEnabled() {
        return isRuleValueDropDownWithRuleIndexEnabled(getIndexNumberOfLastAddedRule());
    }

    public boolean isRulesRadioButtonOfLastAddedRuleEnabled(String name) {
        return isRulesRadioButtonWithRuleIndexEnabled(getIndexNumberOfLastAddedRule(), name);
    }

    public boolean isRulesRadioButtonOfLastAddedRuleDisplayed(String name) {
        return isRulesRadioButtonWithRuleIndexDisplayed(getIndexNumberOfLastAddedRule(), name);
    }

    public boolean isAssigneeDropDownOfLastAddedRuleEnabled() {
        return isAssigneeDropDownWithRuleIndexEnabled(getIndexNumberOfLastAddedRule());
    }

    public boolean isNextRenewalDateRadioDisplayed() {
        return isElementDisplayed(waitMoment, renewalSettingsPO.getRadioNextRenewalDate());
    }

    public boolean isDaysBeforeRenewalRadioDisplayed() {
        return isElementDisplayed(renewalSettingsPO.getRadioNextRenewalDate());
    }

    public boolean isDaysBeforeRenewalTextInputDisplayed() {
        return isElementDisplayed(renewalSettingsPO.getTextInputDaysBeforeRenewal());
    }

    public boolean isDaysBeforeRenewalTextDisabled() {
        return parseBoolean(getAttributeValue(renewalSettingsPO.getTextInputDaysBeforeRenewal(), DISABLED));
    }

    public boolean isDaysBeforeRenewalTextEmpty() {
        return Objects.isNull(getAttributeValue(renewalSettingsPO.getTextInputDaysBeforeRenewal(), VALUE));
    }

    public String getDaysBeforeRenewalInputValue() {
        return getElementValue(renewalSettingsPO.getTextInputDaysBeforeRenewal());
    }

    public boolean isNextRenewalDateRadioChecked() {
        return getAttributeValue(renewalSettingsPO.getRadioNextRenewalDate(), CLASS)
                .contains(MUI_CHECKED);
    }

    public boolean isRuleDropDownWithIndexDisplayed(String ruleNumber) {
        return isElementDisplayed(xpath(format(renewalSettingsPO.getDropDownRule(), ruleNumber)));
    }

    public List<String> getListOfValuesFromDefaultAssigneeDropDown() {
        String radioResponsibleParty = "Responsible Party";
        String radioUser = "User";
        if (!isDefaultAssigneeDropdownEmpty()) {
            clickDefaultAssigneeRadioButton(radioResponsibleParty);
            clickDefaultAssigneeRadioButton(radioUser);
        }
        return getListOfValuesFromDropDown(renewalSettingsPO.getDropdownDefaultAssignee());
    }

    public List<String> getListOfValuesFromAssigneeDropDownOfLastAddedRule() {
        return getListOfValuesFromAssigneeDropDownOfRuleWithIndex(getIndexNumberOfLastAddedRule());
    }

    public String getDefaultAssigneeDropdownValue() {
        WebElement defaultDropdownValue = findElement(waitMoment, renewalSettingsPO.getDropdownDefaultAssignee());
        waitMoment.until(attributeToBeNotEmpty(defaultDropdownValue, VALUE));
        return defaultDropdownValue.getAttribute(VALUE);
    }

    public String getAssigneeDropdownValueOfLastAddedRule() {
        return getAssigneeDropdownValueOfRuleWithIndex(getIndexNumberOfLastAddedRule());
    }

    public String getDefaultAssigneeFieldErrorMessageElementCSS(String cssValue) {
        return getErrorMessageElementCSS(cssValue, renewalSettingsPO.getDropdownDefaultAssigneeError());
    }

    public String getRuleValueErrorMessageElementCSSOfLastAddedRule(String cssValue) {
        return getErrorMessageElementCSS(cssValue, xpath(format(renewalSettingsPO.getDropDownRuleValueError(),
                                                                getIndexNumberOfLastAddedRule())));
    }

    public String getAssigneeErrorMessageElementCSSOfLastAddedRule(String cssValue) {
        return getErrorMessageElementCSS(cssValue, xpath(format(renewalSettingsPO.getDropDownAssigneeError(),
                                                                getIndexNumberOfLastAddedRule())));
    }

    public String getDefaultAssigneeRadioButtonTypeAttribute(String radioButtonName) {
        return getElement(xpath(format(renewalSettingsPO.getRadioButtonDefaultAssigneeSpan(), radioButtonName)))
                .findElement(renewalSettingsPO.getInput())
                .getAttribute(TYPE);
    }

    public String getDefaultAssigneeRadioButtonEnabledAttribute(String radioButtonName) {
        return getElement(
                xpath(format(renewalSettingsPO.getRadioButtonDefaultAssigneeSpan(), radioButtonName)))
                .getAttribute(ARIA_DISABLED);
    }

    public String getErrorMessageText() {
        return getElement(renewalSettingsPO.getErrorMessage()).getText();
    }

    public String getErrorMessageTextOfLastAddedRuleRuleValueDropDown() {
        return getErrorMessageTextOfRuleWithIndex(getIndexNumberOfLastAddedRule(),
                                                  renewalSettingsPO.getDropDownRuleValueErrorText());
    }

    public String getErrorMessageTextOfLastAddedRuleAssigneeDropDown() {
        return getErrorMessageTextOfRuleWithIndex(getIndexNumberOfLastAddedRule(),
                                                  renewalSettingsPO.getDropDownAssigneeErrorText());
    }

    public int getNumberOfValuesSelectedInRuleValueOfLastAddedRule() {
        return getNumberOfValuesSelectedInRuleValueOfRuleWithIndex(getIndexNumberOfLastAddedRule());
    }

    public String getRuleDropDownActualNameOfLastAddedRule() {
        return getRuleDropDownWithIndexActualName(getIndexNumberOfLastAddedRule());
    }

    public String getAssigneeDropDownActualNameOfLastAddedRule() {
        return getAssigneeDropDownWithIndexActualName(getIndexNumberOfLastAddedRule());
    }

    public String getIndexNumberOfLastAddedRule() {
        return Integer.toString(getAddedAssigneeRulesCount());
    }

    public String getNextRenewalDateRadioTypeAttribute() {
        return getElement(renewalSettingsPO.getRadioNextRenewalDate())
                .findElement(renewalSettingsPO.getInput())
                .getAttribute(TYPE);
    }

    public String getNextRenewalDateRadioName() {
        return getElementText(renewalSettingsPO.getRadioNextRenewalDateName());
    }

    public String getDaysBeforeRenewalRadioName() {
        return getElementText(renewalSettingsPO.getRadioDaysBeforeRenewalName());
    }

    public String getDaysBeforeRenewalRadioTypeAttribute() {
        return getElement(renewalSettingsPO.getRadioDaysBeforeRenewal()).getAttribute(TYPE);
    }

    public String getDaysBeforeRenewalTextErrorMessage() {
        return getElementText(renewalSettingsPO.getTextInputDaysBeforeRenewalErrorMessage());
    }

    public String getDaysBeforeRenewalErrorMessageCSS(String cssValue) {
        return getErrorMessageElementCSS(cssValue, renewalSettingsPO.getTextInputDaysBeforeRenewalErrorMessage());
    }

    public List<String> getRuleValueDropDownValuesForLastAddedRule() {
        return getRuleValueDropDownValuesForRuleWithIndex(getIndexNumberOfLastAddedRule());
    }

    public int getAddedAssigneeRulesCount() {
        return getElements(renewalSettingsPO.getAssigneeRulesCount()).size();
    }

    public List<String> getRuleDropDownValuesOfLastAddedRule() {
        return getDropDownOptions(renewalSettingsPO.getDropdownListOfValues());
    }

    public boolean isDeleteRuleIconPresent(String ruleNumber) {
        return isElementDisplayed(xpath(format(renewalSettingsPO.getIconRemoveRule(), ruleNumber)));
    }

    private String getErrorMessageElementCSS(String cssValue, By elementLocator) {
        waitMoment.until(
                attributeContains(getElement(elementLocator), CLASS,
                                  ERROR));
        return getElement(elementLocator).getCssValue(cssValue);
    }

    private String getRuleDropDownWithIndexActualName(String ruleNumber) {
        return getElementText(xpath(format(renewalSettingsPO.getDropDownRuleLabel(), ruleNumber)));
    }

    private String getAssigneeDropDownWithIndexActualName(String ruleNumber) {
        return getElementText(xpath(format(renewalSettingsPO.getDropDownAssigneeLabel(), ruleNumber)));
    }

    private List<String> getRuleValueDropDownValuesForRuleWithIndex(String ruleNumber) {
        return getListOfValuesFromDropDown(xpath(format(renewalSettingsPO.getDropDownRuleValueOpen(), ruleNumber)));
    }

    private int getNumberOfRuleValueRemoveIconsOfRuleWithIndex(String ruleNumber) {
        return getElements(format(renewalSettingsPO.getDropDownRuleValueDeleteIcon(), ruleNumber)).size();
    }

    private List<String> getListOfValuesFromDropDown(By dropDownLocator) {
        List<String> listOfValues;
        clickOn(dropDownLocator, waitShort);
        listOfValues = getDropDownOptions(renewalSettingsPO.getDropdownListOfValues());
        if (listOfValues.stream().anyMatch(v -> v.equals(DROPDOWN_PLACEHOLDER))) {
            waitShort.until(numberOfElementsToBeMoreThan(renewalSettingsPO.getDropdownListOfValues(), 1));
            listOfValues = getDropDownOptions(renewalSettingsPO.getDropdownListOfValues());
        }
        clickOn(dropDownLocator);
        return listOfValues;
    }

    private List<String> getListOfValuesFromAssigneeDropDownOfRuleWithIndex(String ruleNumber) {
        return getListOfValuesFromDropDown(xpath(format(renewalSettingsPO.getDropDownAssignee(), ruleNumber)));
    }

    private int getNumberOfValuesSelectedInRuleValueOfRuleWithIndex(String ruleNumber) {
        return getElements(format(renewalSettingsPO.getDropDownRuleValueSelected(), ruleNumber)).size();
    }

    private String getAssigneeDropdownValueOfRuleWithIndex(String ruleNumber) {
        return findElementByXpath(waitMoment, format(renewalSettingsPO.getDropDownAssignee(), ruleNumber)).getAttribute(
                VALUE);
    }

    private String getErrorMessageTextOfRuleWithIndex(String ruleNumber, String fieldLocator) {
        return getElementText(xpath(format(fieldLocator, ruleNumber)));
    }

    private boolean isFieldEnabled(By path) {
        isElementDisplayed(path);
        return driver.findElement(path).getAttribute(ARIA_DISABLED).equals(Boolean.toString(false));
    }

    private boolean isRuleDropDownWithIndexEnabled(String ruleNumber) {
        return isElementEnabled(xpath(format(renewalSettingsPO.getDropDownRule(), ruleNumber)));
    }

    private boolean isAssigneeDropDownWithIndexDisplayed(String ruleNumber) {
        return isElementDisplayed(xpath(format(renewalSettingsPO.getDropDownAssignee(), ruleNumber)));
    }

    private boolean isRuleValueDropDownWithIndexDisplayed(String ruleNumber) {
        return isElementDisplayed(xpath(format(renewalSettingsPO.getDropDownRuleValue(), ruleNumber)));
    }

    private boolean isRuleValueDropDownWithRuleIndexEnabled(String ruleNumber) {
        return isElementEnabled(xpath(format(renewalSettingsPO.getDropDownRuleValue(), ruleNumber)));
    }

    private boolean isRulesRadioButtonWithRuleIndexEnabled(String ruleNumber, String name) {
        return isFieldEnabled(xpath(format(renewalSettingsPO.getRadioAssigneeRules(), name, ruleNumber)));
    }

    private boolean isRulesRadioButtonWithRuleIndexDisplayed(String ruleNumber, String name) {
        return isElementDisplayed(xpath(format(renewalSettingsPO.getRadioAssigneeRules(), name, ruleNumber)));
    }

    private boolean isAssigneeDropDownWithRuleIndexEnabled(String ruleNumber) {
        return isElementEnabled(xpath(format(renewalSettingsPO.getDropDownAssignee(), ruleNumber)));
    }

    private boolean doesDropDownOfRuleWithIndexContainError(String fieldLocator, String ruleNumber) {
        return isElementDisplayed(xpath(format(fieldLocator, ruleNumber)));
    }

    private void selectValueFromRuleValueDropDownForLastAddedRule(String value) {
        selectValueFromRuleValueDropDownForRuleWithIndex(value, getIndexNumberOfLastAddedRule());
    }

    private void selectValueFromRuleValueDropDownForRuleWithIndex(String value, String ruleNumber) {
        clickOn(xpath(format(renewalSettingsPO.getDropDownRuleValueOpen(), ruleNumber)));
        clickOn(xpath(format(renewalSettingsPO.getDropDownOption(), value)));
    }

    private void selectValueFromRuleDropDownWithIndex(String value, String ruleNumber) {
        clearInputAndEnterField(getElementByXPath(format(renewalSettingsPO.getDropDownRule(), ruleNumber)), value);
    }

    private void selectAssigneeRulesRadioOfRuleWithIndex(String ruleNumber, String name) {
        clickOn(xpath(format(renewalSettingsPO.getRadioAssigneeRules(), name, ruleNumber)));
    }

    private void clickRuleDropDownOfRuleWithIndex(String ruleNumber) {
        clickOn(xpath(format(renewalSettingsPO.getDropDownRuleOpen(), ruleNumber)), waitMoment);
    }

}
