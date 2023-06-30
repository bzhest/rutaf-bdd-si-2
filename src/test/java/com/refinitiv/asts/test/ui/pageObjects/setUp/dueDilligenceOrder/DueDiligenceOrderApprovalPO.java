package com.refinitiv.asts.test.ui.pageObjects.setUp.dueDilligenceOrder;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class DueDiligenceOrderApprovalPO extends BasePO {

    public DueDiligenceOrderApprovalPO(WebDriver driver) {
        super(driver);
    }

    private final By dueDiligenceApprovalPage = xpath("//h6[text()='Due Diligence Order Approval']");
    private final String defaultApproverRadioButton = "//p[text()= '%s']/../..//input[@name='defaultApprover']/..";
    private final By defaultApproverAdvancedSearchLink = id("defaultAssigneeSearchButton");
    private final String advancedSearchInput = "//span[text()='%s']/ancestor::label/following-sibling::div/input";
    private final String advancedSearchButton = "//*[@role='dialog']//span[text()='%s']/..";
    private final String advancedSearchRadioButton = "//*[text()='%s']/ancestor::td/preceding-sibling::*//input";
    private final By advancedSearchDialogTitle = xpath("//*[@role='dialog']//h2");
    private final By advancedSearchDialogEmptyResult = xpath("//*[@role='dialog']//h6");
    private final By addRulesButton = id("addRuleButton");
    private final By defaultApproverDropdownInput = xpath("//span[contains(.,'Default Approver')]/../..//input");
    private final By dropdownOptions = xpath("//li[@role='option']");
    private final String dropdownOption = "//li[@role='option']//*[text()=\"%s\"]";
    private final String defaultApproverRadios =
            "//p[text()='Default Approver']/..//p[text()='%s']/../..//input[@type='radio']";
    private final String ruleTypeInput = "(//input[contains(@id,'ddoApprovalRules-rule-')])[%d]";
    private final String ruleTypeInputOpen =
            "(//input[contains(@id,'ddoApprovalRules-rule-')])[%s]/following-sibling::div/button[@aria-label='Open']";
    private final String ruleSubTypeInput = "(//input[contains(@id,'ddoApprovalRules-ruleValues')])[%d]";
    private final String ruleSubTypeInputOpen =
            "(//input[contains(@id,'ddoApprovalRules-ruleValues')])[%d]/following-sibling::div/button[@aria-label='Open']";
    private final String dropdownWithErrorText = "//span[contains(., '%s')]/../..//p";
    private final String ruleRadio = "(//input[@name='ddoApprovalRules' and @value='%s'])[%d]";
    private final String ruleApproverInput = "(//span[text()='Approver']/../../..//input)[%d]";
    private final String ruleApproverInputOpen =
            "(//span[text()='Approver']/../../..//input)[%d]/following-sibling::div/button[@aria-label='Open']";
    private final String ruleAdvancedSearchLink = "(//button[@id='defaultAssigneeSearchButton'])[%d]";
    private final String deleteRuleIcon = "//*[@aria-label='Delete Rule #%s']";
    private final String dropdownRuleCrossIcon =
            "(//label[contains(@for,'ddoApprovalRules-rule-')])[%s]/following-sibling::div//*[@type='button']//*[contains(@class, 'MuiSvgIcon')]";
    private final By resetButton = id("ddoApprovalResetButton");
    private final By approvalRules = xpath("//p[text()='Approver Rules']/following-sibling::div/div");
    private final String tableRowValue = "td[%s]";
    private final By searchResultTableRows = xpath("//*[@role='dialog']//tbody/tr");
    private final By searchResultTableColumns = xpath("//*[@role='dialog']//thead//th");
    private final By clearButton = cssSelector("[aria-label='Clear']");
    private final String columnSortIcon =
            "//thead//th//span[text()='%s']/ancestor-or-self::span/following-sibling::*[contains(@class, 'MuiSvgIcon')]";
    private final By saveButton = id("ddoApprovalSaveButton");

}
