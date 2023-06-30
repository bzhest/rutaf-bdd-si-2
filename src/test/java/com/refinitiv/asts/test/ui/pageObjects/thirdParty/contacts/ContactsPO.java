package com.refinitiv.asts.test.ui.pageObjects.thirdParty.contacts;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class ContactsPO extends BasePO {

    public ContactsPO(WebDriver driver) {
        super(driver);
    }

    public ContactsPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

    private final String contactsTableRowWithText = "//tbody//span[text()='%s']";
    private final String addContactPage =
            "//*[text()='CONTACTS OVERVIEW']/ancestor::li/following-sibling::li/span[text()='ADD']";
    private final By emptyContactTable = xpath("//*[contains(@class, 'MuiTableContainer')]//h6");
    private final By addAssociatedPartyButton =
            xpath("//*[text()='" + translator.getValue("associatedParties.addAssociatedPartyButton") +
                          "']/parent::button");
    private final By contactRows = xpath("//tbody/tr");
    private final String keyPrincipal = "//tbody/tr[%s]/td[1]//span[contains(@class, 'MuiCheckbox')]";
    private final String tableCellValue = "//tbody/tr[%s]/td[%s]";
    private final String rowButtonCheckbox = "//td//span[text()='%s']/ancestor::tr/td[1]//input";
    private final By tableColumn = cssSelector("thead th");
    private final By deleteButton = cssSelector("button:nth-child(2) svg[class*=MuiSvgIcon]");
    private final By editButton = cssSelector("button:nth-child(1) svg[class*=MuiSvgIcon]");
    private final By associatedOrganisationButton =
            xpath("//*[@data-testid='add-associated-section-Associated Organisation']");
    private final By nameField = name("name");
    private final String collapseElapseButton = "//*[contains(text(), '%s')]/preceding-sibling::*/parent::*";
    private final By associatedOrganisationGroupsInput =
            xpath("//*[@id='Contacts-Org-ScreeningCriteriaAdd-GroupSelectInput-groups']");
    private final By associatedOrganisationSaveButton =
            xpath("//span[text()='Save']/parent::button[contains(@class, 'containedPrimary')]");
    protected final By dropDownOptions = cssSelector("li[role=option]");
    private final By duplicateCheckModal =
            xpath("//*[contains(@id, 'ThirdPartyDuplicateModal')]/div[3]/div");
    private final By duplicateCheckCancelButton = id("ThirdPartyDuplicateModal-CancelBtn");
    private final By duplicateCheckConfirmButton = id("ThirdPartyDuplicateModal-ConfirmBtn");

}
