package com.refinitiv.asts.test.ui.pageObjects.setUp.workflowManagement.renewalSettings;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static java.lang.String.format;
import static org.openqa.selenium.By.*;

@Getter
public class RenewalSettingsPO extends BasePO {

    private final By renewalSettingMenu =
            xpath("//*[@id='adminWorkflowRenewal'] | //*[contains(text(), 'Renewal Settings')]");
    private final By renewalSettingPageHeader = xpath("//h6[text()='Renewal Settings']");
    private final String sectionName = "//p[text()='%s']/parent::*[contains(@class, 'MuiBox')]";
    private final String radioButton = "//p[text()='%s']/parent::span/preceding-sibling::span";
    private final By buttonSave = id("renewalSettingsSaveButton");
    private final By dropdownListOfValues = xpath("//li[@role='option']");

    //Default Assignee
    private final String radioButtonDefaultAssigneeSpan = format(sectionName, "Default Assignee") + radioButton;
    private final String radioButtonDefaultAssigneeButton =
            format(sectionName, "Default Assignee") + "//p[text()='%s']/ancestor::label//input/..";
    private final By dropdownDefaultAssignee =
            xpath("//*[text()='Default Assignee']/ancestor::label/following-sibling::div/input");
    private final String dropDownFoundAssignee = "//*[contains(@class, 'MuiAutocomplete-listbox')]//*[text()='%s']";
    private final By dropdownDefaultAssigneeDisabled =
            xpath("//span[text()='Default Assignee']/ancestor::label/following-sibling::div[contains(@class, MuiInput) and contains(@class, 'disabled')]");
    private final By errorMessage = cssSelector("[id^=defaultAssignee][id$=helper-text]");
    private final By dropdownDefaultAssigneeError =
            xpath("//span[text()='Default Assignee']/ancestor::label[contains(@class, 'error')]");
    private final By linkAdvanceSearch =
            xpath(format(sectionName, "Default Assignee") + "//button[@id='defaultAssigneeSearchButton']");

    //Renewal Assignee Rules
    private final By renewalSettingsRulesHeader = xpath("//*[text()='Renewal Assignee Rules']");
    private final By renewalSettingsRulesSection = xpath(format(sectionName, "Renewal Assignee Rules"));
    private final By renewalSettingsAddRulesButton = cssSelector("button#addRuleButton");
    private final String dropDownRule = "(//input[contains(@id, 'renewalAssigneeRules-rule-')])[%s]";
    private final String dropDownRuleOpen =
            dropDownRule + "/following-sibling::div/button[@title='Open' or @title='Close']";
    private final String dropDownRuleValue = "(//input[contains(@id, 'renewalAssigneeRules-ruleValues')])[%s]";
    private final String dropDownRuleValueOpen =
            dropDownRuleValue + "/following-sibling::div/button[@title='Open' or @title='Close']";
    private final String dropDownRuleValueDeleteIcon = dropDownRuleValue + "/preceding-sibling::div/*[name()='svg']";
    private final String dropDownRuleClearIcon = dropDownRule + "/following-sibling::div/button[@title='Clear']";
    private final String dropDownAssignee = "(//*[text()='Assignee']/ancestor::label/following-sibling::div/input)[%s]";
    private final String radioAssigneeRules =
            "(" + format(sectionName, "Renewal Assignee Rules") + radioButton + ")[%s]";
    private final String dropDownRuleValueSelected = dropDownRuleValue + "/preceding-sibling::div[@role='button']/span";
    private final String dropDownRuleLabel = dropDownRule + "/parent::*/preceding-sibling::label";
    private final String dropDownAssigneeLabel = dropDownAssignee + "/parent::*/preceding-sibling::label/span[1]";
    private final By assigneeRulesCount = xpath("//p[text()='Renewal Assignee Rules']/following-sibling::div/div");
    private final String dropDownRuleValueError =
            dropDownRuleValue + "/parent::*/preceding-sibling::label[contains(@class, 'error')]";
    private final String dropDownRuleValueErrorText =
            dropDownRuleValue + "/parent::*/following-sibling::*[contains(@class, 'error')]";
    private final String dropDownAssigneeError =
            dropDownAssignee + "/parent::div/preceding-sibling::label[contains(@class, 'error')]";
    private final String dropDownAssigneeErrorText =
            dropDownAssignee + "/parent::*/following-sibling::*[contains(@class, 'error')]";
    private final String iconRemoveRule = "(//button[contains(@aria-label, 'Delete Rule')])[%s]";

    //Renewal Trigger By
    private final By radioNextRenewalDate =
            xpath("//*[@value='nextRenewalDate']/ancestor::span[contains(@class, 'Radio')]");
    private final By radioNextRenewalDateName = xpath("//*[@value='nextRenewalDate']/ancestor::label//span/p");
    private final By radioDaysBeforeRenewal = cssSelector("[value=customNextRenewalDate]");
    private final By radioDaysBeforeRenewalName =
            xpath("//*[@value='customNextRenewalDate']/ancestor::label//label/span");
    private final By textInputDaysBeforeRenewal = cssSelector("input[id^= renewalTriggerBy]");
    private final By textInputDaysBeforeRenewalErrorMessage =
            xpath("//input[contains(@id,  'renewalTriggerBy')]/parent::*/following-sibling::p");

    public RenewalSettingsPO(WebDriver driver) {
        super(driver);
    }

}
