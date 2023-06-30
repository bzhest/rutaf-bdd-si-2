package com.refinitiv.asts.test.ui.pageObjects.setUp;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class CustomFieldsManagementPO extends BasePO {

    public CustomFieldsManagementPO(WebDriver driver) {
        super(driver);
    }

    private final String fieldNameOverview = "//*[contains(@id,'Custom Field Name')]" +
            "/descendant::div//p[contains(text(),'%s')]";
    private final String descriptionOverview = "//*[contains(@id,'Description')]" +
            "/descendant::div//p[contains(text(),'%s')]";

    private final String customFieldModal = "//*[@role='dialog']//*[contains(text(), '%s')]";
    private final By breadcrumbPageButton =
            xpath("//*[contains(@class, 'MuiBreadcrumbs')]//button");
    private final String editBtn = "//*[contains(., '%s')]/ancestor::tr//*[@aria-label='edit-custom field']";
    private final String deleteBtn = "//*[contains(., '%s')]/ancestor::tr//*[@aria-label='delete-custom field']";
    private final String rowValue = "//*[contains(., '%s')]/ancestor::tr/td";
    private final String customFieldValue = "//*[@name='%s']";
    private final By fieldName = name("name");
    private final By customFieldsMenu =
            xpath("//*[@data-ng-if=\"nav.id === 'adminCustomField'\"] | //p[text()='Custom Fields']");
    private final By addCustomFieldBtn = xpath("//button[@id='add-new-custom field']");
    private final By reorderButton = xpath("//span[text()='Reorder']/..");
    private final By addCustomFieldBtnIfNoAvailable = xpath("//*[@class='btn btn-success']");
    private final By description = name("description");
    private final By saveBtn = id("confirm-button");
    private final By proceedButtonModalWindow = id("simpleModalSuccessButton");
    private final By cancelButtonModalWindow = id("simpleModalCancelButton");
    private final By confirmationModal = xpath("//*[@class='MuiDialogContent-root']/p");
    private final By dropDownFieldType = id("mui-component-select-type");
    private final String dropDownListValues = "//li[contains(., '%s')]";
    private final By fieldLabel = xpath("//fieldset/../..");
    private final By requiredCheckbox = xpath("//input[@name='required' and @type='checkbox']/..");
    private final By manageDataValuesCheckbox = cssSelector("[name='usePredefinedValues']");
    private final By manageDataValuesSpan = xpath("//*[@name='usePredefinedValues']/../..");
    private final By activeCheckbox = xpath("//input[@name='status']/../..");
    private final String noteText = "//*[@name =  'description']/../../following-sibling::div/p[text() = '%s']";
    private final String button = "//span[text()='%s']/..";
    private final By dropdownOptions = xpath("//ul/li");
    private final By choiceRows =
            xpath("//div[contains(@aria-label,'Choice #')]/input/../../../.. | //div[contains(@aria-label,'Choice #')]/../../..");
    private final By choiceInput =
            xpath("//div[contains(@aria-label,'Choice')]/input | //div[contains(@aria-label,'Choice')]/span");
    private final String choiceLabel =
            "(//div[contains(@aria-label,'Choice')]/..//legend/span/../../../..)[%s] | (//div[contains(@aria-label,'Choice #')]/../../..//div[contains(@aria-label,'Choice')]/..//legend/span/../../../../label)[%<s]";
    private final By plusButton = xpath("//button[@aria-label='Add']");
    private final String deleteButton = "(//button[@aria-label='Delete'])[%s]";
    private final By redFlagToggle =
            xpath("//button[@aria-label=\"Add\"]/..//input[@type='checkbox'] | //button[@aria-label=\"Add\"]/../..//input[@type='checkbox']");
    private final String redFlagToggleForChoice =
            "//div[contains(@aria-label,'Choice #%d')]/input/../../../..//input[@type=\"checkbox\"]/../..";
    private final By mapToLabel = xpath("//label[@id = 'source-choice-select-label']");
    private final By mapToDropdown = id("source-choice-select");
    private final String errorMessage =
            "//span[contains(., '%s')]/../../../../following-sibling::div/p | //label[contains(., '%<s')]/../p";
    private final String fieldValue =
            "//label[contains(., '%s')]/following-sibling::*";
    private final String mapToFieldValue = "//label[contains(., '%s')]/following-sibling::*/input";
    private final String fieldValueInput = "//div[@aria-label='%s']/input";
    private final String deleteChoiceButton =
            "//input[@value='%s']/../../../..//button[@aria-label='Delete']";
    private final String columnName = "//th//*[text()='%s']";
    private final By columnNameList = xpath("//th");
    private final By customFieldsTab = xpath("//*[@data-ng-if=\"nav.id === 'adminCustomField'\"]/../..");
    private final By tableRow = cssSelector("tbody>tr");
    private final String tableRowValue = "td[%s]";
    private final By deleteRowButton = cssSelector("[aria-label='delete-custom field']");
    private final By editRowButton = cssSelector("[aria-label='edit-custom field']");
    private final By customFieldsTable = xpath
            ("//div[contains(@class,'MuiTableContainer')]//h6[contains(@class,'-subtitle')]");
    private final By paginationInformation = xpath("//div[@aria-haspopup=\"listbox\"]/../../following-sibling::div/p");
    private final String reorderListItems = "//li[contains(@class,'MuiListItem-root')]";
    private final String reorderListItem = reorderListItems + "[%s]";
    private final String reorderChevronButton = "reorder-button-%s";
    private final By switchToEditButton = xpath("//button[@aria-label=\"Edit\"]");
    private final By closeButton = cssSelector("[aria-label='close']");

}
