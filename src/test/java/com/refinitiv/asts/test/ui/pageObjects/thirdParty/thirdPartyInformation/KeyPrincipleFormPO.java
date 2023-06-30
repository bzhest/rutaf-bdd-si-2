package com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class KeyPrincipleFormPO extends BasePO {

    private final By newKeyPrincipleAlert = xpath("//*[@aria-labelledby='alert-dialog-title']");
    private final By acceptDialogButton = id("AlertDialog-ok");
    private final By addButton = xpath("//div[@id='address']/following-sibling::div/button | //*[text()='save']/../..");
    private final By keyManagementPage = id("keyPrincipalForm");
    private final String buttonWithText = "//*[contains(text(), '%s')]/ancestor::button";
    private final String editButton = "//td//*[text()='%s']/ancestor::tr//*[@title='EDIT']";
    private final String rowCheckbox = "//td//*[text()='%s']/ancestor::tr//input";
    private final String fieldInput = "//label[contains(text(), '%s')]/following-sibling::div//input";
    private final String fieldInputHelpText = "//label[contains(text(), '%s')]/..//p";
    private final String indicator = "//label[contains(text(), '%s')]/span";
    private final String keyPrincipalTable = "//*[@id='keyPrincipalTable']";
    private final By keyPrincipalTableColumns = xpath(keyPrincipalTable + "//thead//th");
    private final By keyPrincipleTableRows = xpath(keyPrincipalTable + "//tbody/tr");
    private final String tableRowValue = "td[%s]";
    private final String checkbox = "(//span[contains(@class, 'MuiCheckbox')])[%s]";

    /**
     * 'Add new contact' form
     */
    private final By title = id("titleField");
    private final By firstName = id("firstNameField");
    private final By lastName = id("lastNameField");
    private final By email = id("emailField");
    private final By localLanguageName = id("iwOtherNamesField");

    /**
     * 'Address' form
     */
    private final String addressSection = "//*[@id='address']";
    private final String addressField = addressSection + fieldInput;
    private final String addressFieldIndicator = addressSection + indicator;
    private final By addressLine = xpath("//*[@name='address']");
    private final By zip = id("zipCodePostal");
    private final By city = id("city");
    private final By state = id("stateProvince");
    private final By countryInput = id("country");
    private final By addToListButton = xpath("//*[text()='add to list']/../..");
    private final By note = xpath("//span[contains(@class, 'MuiTypography-caption')]");

    public KeyPrincipleFormPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

}
