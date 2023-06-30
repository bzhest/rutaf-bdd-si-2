package com.refinitiv.asts.test.ui.pageObjects.setUp.workflowManagement.workflow;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static java.lang.String.format;
import static org.openqa.selenium.By.*;

@Getter
public class WorkflowPO extends BasePO {

    protected final String inputWithLabel =
            "//*[text()='%s']/../following-sibling::div//input | //*[text()='%<s']/../../following-sibling::div//input | //*[text()='%<s']/../following-sibling::div//span";
    private final By workflowManagementMenu = xpath("//p[text()='Workflow Management']");
    private final By workflowMenu = xpath("//*[@id='adminWorkflow'] | //p[text()='Workflow']");
    private final By pageHeader = xpath("//ol");
    private final By workflowTable = xpath("//table");
    private final By workflowNameTableRow = xpath("//tbody//tr");
    private final By workflowNameTableField = xpath("td[1]");
    private final By workflowTypeTableField = xpath("td[2]");
    private final By dateCreatedTableField = xpath("td[3]");
    private final By lastUpdateTableField = xpath("td[4]");
    private final By statusTableField = xpath("td[5]");
    private final By tableColumns = xpath("//table/thead//th");
    private final By tableColumnEditButton = xpath("(//*[@aria-label='edit-workflow'])[1]");
    private final String tableFieldValue = "//tr[1]/td[%s]/span";
    private final By workflowTypeInput = xpath(format(inputWithLabel, "Workflow Type"));
    private final By riskScoringRangeInput = xpath(format(inputWithLabel, "Risk Scoring Range"));
    private final By workflowGroupInput = xpath(format(inputWithLabel, "Workflow Group"));
    private final String inputValidationMessage =
            "//*[text()='%s']/ancestor::label/following-sibling::div//p | //*[text()='%<s']/ancestor::label/following-sibling::p";
    private final String inputRequiredIndicator =
            "//*[text()='%s']/../following-sibling::span | //*[text()='%<s']/span";
    private final By nameInput = cssSelector("[name='name']");
    private final By descriptionInput = cssSelector("[name='description']");
    private final By checkboxActive = cssSelector("[name='status']");
    private final By buttonNext = id("user-management-user-save");
    private final By buttonAddWorkflow = id("add-new-workflow");
    private final String pageButton = "//*[contains(text(), '%s')]/ancestor::button";
    private final By addWizardComponentButton = xpath("//span[.='ADD WIZARD COMPONENT']");
    private final String editWizardButton = "//*[@data-rbd-draggable-id]/*/button[1]";
    private final String componentHeader = "(//*[@data-rbd-draggable-id]//p)[%s]";
    private final String componentNameInput = "//*[@data-rbd-draggable-id][%s]//input";
    private final String componentCheckButton = componentNameInput + "/following-sibling::*";
    private final String componentEditButton = "//*[@data-rbd-draggable-id][%s]//button[@title='Edit']";
    private final String componentDeleteButton = "//*[@data-rbd-draggable-id][%s]//button[@title='Delete']";
    private final String linkAddActivity = "(//*[@data-rbd-droppable-id]/following-sibling::button)[%s]";
    private final By workflowFieldsLabels = xpath("//label/span[contains(@class, 'MuiTypography')]");
    private final By workflowOverviewEditButton =
            xpath("//form//div[contains(@class, 'root')]/button/span/*[contains(@class, 'Svg')]");
    private final By buttonSave = xpath("//span[.='Save']");
    private final String componentActivity = "//div[@data-rbd-drag-handle-draggable-id]//*[@title='%s']";
    private final String activityAssignedGroup =
            "//*[@data-rbd-draggable-context-id][%s]" + componentActivity + "/preceding-sibling::div";
    private final String editActivityButton = componentActivity + "/../..//button[1]";
    private final String deleteActivityButton = componentActivity + "/../..//button[2]";
    // TODO Change to more stable locators once IDs are back for buttonSave, addWizardComponentButton and linkAddActivity

    public WorkflowPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

    public WorkflowPO(WebDriver driver) {
        super(driver);
    }

}