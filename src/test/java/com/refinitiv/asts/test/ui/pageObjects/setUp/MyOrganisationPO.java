package com.refinitiv.asts.test.ui.pageObjects.setUp;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;

@Getter
public class MyOrganisationPO extends BasePO {

    private final String tab = "//span[text()='%s']/parent::button[@role='tab']";
    private final By addNewButton = cssSelector("button[id^=add-new]");
    private final By nameInput = cssSelector("input[name=name]");
    private final By regionInput = xpath("//span[text()='Region']/ancestor::label/following-sibling::div/input");
    private final By countryInput = xpath("//span[text()='Country']/ancestor::label/following-sibling::div/input");
    private final By cancelButton = xpath("//span[text()='Cancel']/parent::button");
    private final By saveButton = xpath("//span[text()='Save']/parent::button");
    private final By saveAndNewButton = xpath("//span[text()='Save and New']/parent::button");
    private final By backButton = cssSelector("button[id*=back]");
    private final By editModalButton = cssSelector("button[title=Edit]");
    private final By editIcon = xpath("//button[@aria-label='Edit My Organisation']");
    private final String rowWithText = "//tbody//td//span[text()='%s']";
    private final String editButton =
            rowWithText + "/ancestor::td/following-sibling::td//*[contains(@aria-label, 'edit')]";
    private final String deleteButton =
            rowWithText + "/ancestor::td/following-sibling::td//*[contains(@aria-label, 'delete')]";
    private final String modalName = "//button[@id='my-organisation-back-button']/ancestor::nav//h6/span[text()='%s']";
    private final String requiredIndicator =
            "//label/span[*[text()='%s']]/ancestor-or-self::span/following-sibling::span[text()='*']";
    private final String editableFieldInput =
            "//span[text()='%s']/ancestor::label/following-sibling::div/input |" +
                    " //span[text()='%<s']/ancestor::label/following-sibling::div/textarea |" +
                    "//span[text()='%<s']/ancestor::label//input";
    private final String fieldValue = "//span[text()='%s']/ancestor::label/following-sibling::div/span | " +
            "//span[text()='%<s']/ancestor-or-self::span/following-sibling::div/p";
    private final String fieldInputImage =
            "//span[text()='%s']/ancestor::label/following-sibling::div//button[@title='Open' or @title='Close']";
    private final String fieldInputValidationMessage =
            "//span[text()='%s']/ancestor::label/following-sibling::p[contains(@class, 'error')]";
    private final String fieldInputError =
            "//span[text()='%s']/ancestor::label/following-sibling::div/input[@aria-invalid='true']";
    private final By rows = cssSelector("tbody>tr");
    private final String rowColumn = "td[%s]";
    private final String rowWithName = "//tbody//tr//td[1]//span[text()='%s']/ancestor::tr";
    private final By activeCheckbox = cssSelector("input[type=checkbox]");
    private final String columnWithText = "//th//*[text()='%s']";
    private final By columnNames = xpath("//th/span/span");
    private final By myOrganisationFields =
            xpath("//label/span | //h6/following-sibling::div[contains(@class, 'MuiGrid')]//div/span[not(contains(@class, 'input'))] | //h6/following-sibling::div[contains(@class, 'MuiGrid')]//div//p[not(ancestor::div/preceding-sibling::span)]");
    private final By myOrganisationTabs = cssSelector("button[role=tab] span:nth-child(1)");
    private final By myOrganisationName = cssSelector("[name=name]");
    private final By phoneNumberInput = cssSelector("[name=mainPhone], [name=additionalPhones]");
    private final By addPhoneButton = xpath("//span[text()='Add Phone Number']/ancestor::button");
    private final By deletePhoneButtons = cssSelector("button[aria-label=deleteAdditionalPhone]");
    private final By noMatchFoundMessage = xpath("//h6[text()='No Match Found']");

    public MyOrganisationPO(WebDriver driver) {
        super(driver);
    }

}
