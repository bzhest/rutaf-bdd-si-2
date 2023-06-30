package com.refinitiv.asts.test.ui.pageObjects.setUp.userManagement;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class RoleTablePO extends BasePO {

    private final By addNewRoleButton = id("add-new-" + translator.getValue("user.role").toLowerCase());
    private final By deactivateRoleButton = id("role-deactivate-roles");
    private final By tableRow = cssSelector("tbody tr");
    private final By tableRowsNameValues = cssSelector("td:nth-child(2)>span");
    private final By tableColumnHeader = cssSelector("thead th");
    private final String editRoleButton = "//span[text()[contains(.,\"%s\")]]/ancestor::tr//*[@aria-label='edit-" +
            translator.getValue("user.role").toLowerCase() + "']";
    private final String deleteRoleButton = "//span[text()[contains(.,\"%s\")]]/ancestor::tr//*[@aria-label='delete-" +
            translator.getValue("user.role").toLowerCase() + "']";
    private final String roleCheckbox =
            "//span[text()[contains(.,\"%s\")]]/ancestor::tr/td[1]//span[contains(@class, 'MuiCheckbox')]";
    private final String roleName = "//tbody//td[2]//span[text()=\"%s\"]";
    private final String lastUpdateField = "//span[text()='%s']/ancestor::tr/td[5]/span";
    private final String statusField = "//span[text()='%s']/ancestor::tr/td[6]/span";
    private final String dateCreatedField = "//span[text()='%s']/ancestor::tr/td[4]/span";
    private final String roleTableRowValue = "//tbody/tr[%s]/td[%s]/span";
    private final String roleTableColumn = "//thead//th//span[text()='%s']";
    private final By roleManagementHeader =
            xpath("//*[@id='add-new-role']/ancestor::div[contains(@class, 'MuiPaper')]//h6");


    public RoleTablePO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

}
