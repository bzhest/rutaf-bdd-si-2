package com.refinitiv.asts.test.ui.pageObjects.setUp.workflowManagement.workflow;

import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static java.lang.String.format;
import static org.openqa.selenium.By.*;

@Getter
public class ApproverTabPO extends WorkflowPO {

    public ApproverTabPO(WebDriver driver) {
        super(driver);
    }

    private final By addExistingApprovalProcessButton =
            xpath("//*[text()='ADD EXISTING Approval PROCESS']/ancestor::button");
    private final By defaultApproverInput =
            xpath("//p[text()='Default Approver']/..//span[text()='Approver']/../../following-sibling::div//input");
    private final By addRulesForInput = xpath(format(inputWithLabel, "Add Rules For"));
    private final By activityOwnerValue =
            xpath("//*[text()='Add Rules For']/../../following-sibling::div//input/ancestor::div[@role='combobox']/../../following-sibling::div[1]//div/span//span[@data-cid='TextEllipsis-root']");
    private final By approverValue =
            xpath("//span[text()='Approver']/../../following-sibling::div//div/span//span[@data-cid='TextEllipsis-root']");
    private final String approverRuleInput =
            "//p[text()='Approver']/../div/div[%s]//*[text()='%s']/../../following-sibling::div//input";
    private final String approverRuleInputMultiValues = approverRuleInput + "/..//span[contains(@class, 'MuiChip')]";
    private final String approverRuleMethodRadio = "(//input[@type='radio' and @value='%s'])[%s]";
    private final By approveRules = xpath("//p[text()='Approver']/../div/div/div");
    private final String ruleOverviewSelectedMethod =
            "//p[text()='Approver']/../div/div[%s]//input[@type='radio' and @checked]/../../following-sibling::span";
    private final By buttonAddApprover = cssSelector("[id='contactSectionAdd Approver']");
    private final String approveRule = "(//p[text()='Approver']/../div/div/div//div[@style])[%s]";
    private final String buttonRemoveRule = "(//p[text()='Approver']/../div/div[%s]//button)[1]";

}
