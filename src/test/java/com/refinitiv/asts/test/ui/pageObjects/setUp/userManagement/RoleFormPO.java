package com.refinitiv.asts.test.ui.pageObjects.setUp.userManagement;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;

@Getter
public class RoleFormPO extends BasePO {

    private final String roleFormWindow =
            "//*[contains(@class, 'MuiBreadcrumbs-separator')]/following-sibling::li/*";
    private final String roleFormWindowName = roleFormWindow + "[text()='%s']";
    private final By nameField = By.cssSelector("input[name=name]");
    private final By descriptionField = By.cssSelector("textarea[name=description]");
    private final By submitFormButton = By.cssSelector("button#user-management-role-submit");
    private final By cancelFormButton = By.cssSelector("button#user-management-role-cancel");
    private final By roleManagementBackButton = By.cssSelector("button#users-management-user-back-button");
    private final By editFormButton =
            xpath("//*[@name='name']/ancestor::*[contains(@class, 'MuiGrid-container')]//button");
    private final By activeCheckbox = cssSelector("[aria-label='Role Active Status']>span");

    private final String tableCheckboxRow = "//*[text()='%s']/ancestor::tr";
    private final String createCheckbox = tableCheckboxRow + "/td[2]//span[contains(@class, 'MuiButtonBase')]";
    private final String editCheckbox = tableCheckboxRow + "/td[3]//span[contains(@class, 'MuiButtonBase')]";
    private final String deleteCheckbox = tableCheckboxRow + "/td[4]//span[contains(@class, 'MuiButtonBase')]";
    private final String readCheckbox = tableCheckboxRow + "/td[5]//span[contains(@class, 'MuiButtonBase')]";
    private final String toggleButton = tableCheckboxRow + "/td[2]//span[contains(@class, 'MuiButtonBase')]";
    private final String addCheckbox = tableCheckboxRow + "/td[2]//span[contains(@class, 'MuiButtonBase')]";
    private final String downloadCheckbox = tableCheckboxRow + "/td[3]//span[contains(@class, 'MuiButtonBase')]";
    private final String createOrderReportCheckbox =
            tableCheckboxRow + "/td[2]//span[contains(@class, 'MuiButtonBase')]";
    private final String editOrderReportCheckbox = tableCheckboxRow + "/td[3]//span[contains(@class, 'MuiButtonBase')]";
    private final String readOrderReportCheckbox = tableCheckboxRow + "/td[4]//span[contains(@class, 'MuiButtonBase')]";
    private final String declineOrderReportCheckbox =
            tableCheckboxRow + "/td[5]//span[contains(@class, 'MuiButtonBase')]";
    private final String approveOrderReportCheckbox =
            tableCheckboxRow + "/td[6]//span[contains(@class, 'MuiButtonBase')]";
    private final By roleNameText = xpath("//span[text()='Name']/ancestor::fieldset/preceding-sibling::*");
    private final By roleDescriptionText =
            xpath("//span[text()='Description']/ancestor::fieldset/preceding-sibling::*");
    private final By formPageSections = xpath("//*[@role='button']/*[contains(@class, 'MuiAccordionSummary-content')]/*/p");
    private final String sectionButton = "//*[text()='%s']/ancestor::*[@role='button']";
    private final String rightWithName = "//*[@id='users-management-user-back-button']/ancestor::*[contains(@class, 'MuiPaper')]//span[text()='%s']";

    public RoleFormPO(WebDriver driver) {
        super(driver);
    }

}
