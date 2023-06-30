package com.refinitiv.asts.test.ui.pageObjects.setUp;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class ApprovalProcessPO extends BasePO {

    public ApprovalProcessPO(WebDriver driver) {
        super(driver);
    }

    private final By approvalProcessRow = xpath("//table/tbody/tr");

    //SetUp - Approval Process
    private final By processName = xpath("td[1]");
    private final By description = xpath("td[2]");
    private final By status = xpath("td[3]");
    private final By editButton = xpath("td[4]//*[name()='svg' and @title=\"Edit\"]");
    private final By deleteButton = xpath("td[4]//*[name()='svg' and @title=\"Delete\"]");
    private final By approvalProcessMenu = xpath("//*[@id='adminApprovalProcess'] | //p[text()='Approval Process']");
    private final By addApprovalProcessButton = cssSelector("#add-new-approval");
    private final By addApprovalProcessHeaderLink = xpath("//button[@type='button']/following-sibling::p");
    private final By approvalProcessOverviewHeader = xpath("//h6[text()='Approval Process']");
    private final String modalWithName =
            "//*[text()='Approval Process']/ancestor::li/following-sibling::li//*[text()='%s']";
    private final By approvalProcessNameInput = xpath("//*[@name='approvalProcessName']");
    private final By activeCheckbox = xpath("//input[@name=\"isActive\"]");
    private final By activeCheckboxState = xpath("//input[@name=\"isActive\"]/../..");
    private final By defaultApproverFieldValue =
            xpath("//span[text()='Approver']/ancestor::label//following-sibling::div//input");
    private final By dropDownDefaultApprover =
            xpath("//span[text()='Approver']/ancestor::label//following-sibling::div//input");
    private final By clearDropdownCrossIcon = xpath("following-sibling::div/button[@title='Clear']");
    private final By approvalProcessEditButton = xpath("//button[@title=\"Edit\"]");
    private final String dropDownAddRulesFor =
            "(//*[contains(text(), 'Add Rules For')]/..//input)[%s] | (//*[text()='Add Rules For']/../../..//input)[%<s]";
    private final String dropdownInput =
            "//div[contains(@style, 'border') and text()='%s']/ancestor::div[contains(@class, 'MuiGrid-root')]" +
                    "//*[text()[contains(., '%s')]]/ancestor::label/following-sibling::div//input";
    private final String multiSelectActivityOwner =
            "(//span[text()='Activity Owner']/ancestor::label//following-sibling::div//input)[%d] | " +
                    "(//*[@data-qaid='reviewer-activityOwner']//input)[%<d]";
    private final String addRuleFor = "(//span[text()='%s']/ancestor::label//following-sibling::div//input)[%d]";
    private final String addRuleForValue =
            "(//span[text()='Rule Value']/ancestor::label//following-sibling::div//input)[1]";
    private final String multiSelectActivityOwnerValues =
            "(//span[text()='%s']/ancestor::label//following-sibling::div//input)[%s]/..//div/span/span[@data-cid='TextEllipsis-root']";
    private final String multiSelectApprover =
            "(//div/p[text()='Approver']/..//span[text()='Approver']/ancestor::label//following-sibling::div//input)[%d] | " +
                    "(//div[contains(text(), 'Approver')]/parent::div//div[@class='multi-select']//input)[%<d]";
    private final String multiSelectApproverValues =
            "//div[text()='%s']/ancestor::div[contains(@class, 'MuiGrid-container')]//span[text()='Approver']/ancestor::label/following-sibling::div/div/span/span | " +
                    "(//*[@data-qaid='reviewer-reviewer'])[%<s]//li[contains(@class, 'items')]";
    private final String approverMethodField =
            "(//label[text()='Approver Method']/../div)[%d]";
    private final String radioApproverMethod =
            "(//label[text()='Approver Method']/../div//input[@value='%s'])[%s]";
    private final String isDropDownWithNameRequired =
            "//span[text()='%s']/following-sibling::span[contains(@class,'asterisk')] | " +
                    "//span[text()='%<s']/../following-sibling::span[contains(@class,'asterisk')] | " +
                    "//div[contains(text(), '%<s')]/span[contains(@data-ng-show, 'isRequired') and not(contains(@class, 'hide'))]";
    private final By buttonAddRule =
            xpath("//button[contains(@id,'contactSectionAdd')] | //span[contains(@data-ng-click,'addRule')]");
    private final String buttonRemove = "(//button[@title=\"Delete\"])[%d]";
    private final String editButtonForProcessWithName =
            "//td[1]//*[contains(., '%s')]/ancestor::tr/td[4]//*[name()='svg' and @title='Edit']";
    private final String deleteButtonForProcessWithName =
            "//td[1]//*[contains(., '%s')]/ancestor::tr/td[4]//*[name()='svg' and @title='Delete']";
    private final String approvalProcessWithName = "//td[1]//*[contains(., '%s')]/..";
    private final By approvalProcessName = xpath("//td[2]");
    private final String validationMessage =
            "//span[contains(.,'%s')]/../following-sibling::p[contains(@class,'Mui-error')]";

    //'Add Existing Approval Process' link on page admin/workflowmanagement/workflow
    private final By selectRadioButton = xpath("//tr/td[1]//input");
    private final String approvalProcessButtons =
            "//button/span[contains(text(), '%s')] | //button[contains(text(), '%<s')]";
    private final By title = xpath("//li[contains(@class, 'MuiBreadcrumbs')]//h6");
    private final By tableColumnsNames = xpath("//*/tr/th");
    private final By modal = xpath("//*[@class='modal']");
    private final By approvalProcessFieldTitles =
            xpath("//*[@class='approval']//div[contains(@class, 'col-md-4')] | //label/span[1] | " +
                          "//*[name()='svg']/ancestor::span[contains(@class, 'MuiCheckbox')]/following-sibling::span |" +
                          "//*[@role='radiogroup']/preceding-sibling::label");
    private final By addApprovalTableBody = className("add-approval-body");
    private final By noApprovalProcessAvailable =
            xpath("//*[contains(@class, 'empty')]//i | //h6[text()='No Match Found']");

}
