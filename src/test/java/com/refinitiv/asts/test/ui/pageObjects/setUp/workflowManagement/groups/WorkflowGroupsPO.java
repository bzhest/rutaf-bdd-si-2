package com.refinitiv.asts.test.ui.pageObjects.setUp.workflowManagement.groups;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;
import static org.openqa.selenium.By.cssSelector;

@Getter
public class WorkflowGroupsPO extends BasePO {

    private final String pageName = "//li[contains(@class, 'MuiBreadcrumbs')]//*[text()='%s']";
    private final String fieldValue = "//*[text()='%s']/ancestor::tr/td[%s]";
    private final By fieldWorkFlowGroupNameInput = id("workflowGroupNameInput");
    private final By fieldWorkFlowGroupNameError = xpath("//*[@id='workflowGroupNameInput' and  @aria-invalid='true']");
    private final By fieldWorkFlowGroupNameLabel = xpath("//*[@id='workflowGroupNameInput']/../../label//span[2]");
    private final By workFlowGroupMenu =
            xpath("//*[@id='adminWorkflowGroups'] | //p[text()='Workflow Management']/../../..//p[text()='Groups']");
    private final By active = cssSelector("[type='checkbox']");
    private final By buttonAddWorkflowGroup = xpath("//button[contains(@id,'add-new')]");
    private final By buttonSave = id("workflow-management-group-submit");
    private final By buttonCancel = id("workflow-management-group-cancel");
    private final By buttonBack = id("workflow-management-groups-back-button");
    private final By buttonEdit = xpath("//*[@aria-label='edit-workflow group']");
    private final By errorMessage = xpath("//*[@id='workflowGroupNameInput']/../../p");
    private final By tableColumns = xpath("//table/thead//th");
    private final By tableFirstRow = xpath("//tbody/tr[1]/td[1]");
    private final By tableRows = xpath("//tbody/tr");
    private final String tableRowValue = "//tbody/tr[%s]/td[%s]";
    private final String tableRowName = "//td//*[text()='%s']";
    private final String tableRowEdit = tableRowName + "/ancestor::tr//*[@aria-label='edit-workflow group']";
    private final String tableRowDelete = tableRowName + "/ancestor::tr//*[@aria-label='delete-workflow group']";
    private final By deleteButton = cssSelector("[aria-label='delete-workflow group']");
    private final By editButton = cssSelector("[aria-label='edit-workflow group']");

    public WorkflowGroupsPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

    public WorkflowGroupsPO(WebDriver driver) {
        super(driver);
    }

}
