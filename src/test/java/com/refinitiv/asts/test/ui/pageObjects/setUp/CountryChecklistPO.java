package com.refinitiv.asts.test.ui.pageObjects.setUp;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class CountryChecklistPO extends BasePO {

    public CountryChecklistPO(WebDriver driver) {
        super(driver);
    }

    public CountryChecklistPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

    private final String countryChecklist = translator.getValue("setUp.countryChecklist");
    private final String detailsPageBreadcrumbs =
            "//p[text()='" + countryChecklist +
                    "']/ancestor::li/following-sibling::li[text()='/']/following-sibling::li//*[text()=\"%s\"]";
    private final By countryChecklistPage = xpath("//h6[contains(text(), '" + countryChecklist + "')]");
    private final String countryAssign =
            "//*[text()=\"%s\"]/..//li[@aria-label=\"%s\"]";
    private final By selectedCountriesContainer =
            xpath("//*[text()='Selected Countries']/../div");
    private final String fieldValue = "(//*[contains(., '%s')]/ancestor::tr/td)[%d]";
    private final By countryChecklistMenu =
            xpath("//*[@id='adminCountryCheckList'] | //p[text()='" + countryChecklist + "']");
    private final By listName = xpath("//input[@name=\"listName\"]");
    private final By alertMsg = xpath("//input[@name=\"alertMessage\"]");
    private final By active = cssSelector("input[type='checkbox']");
    private final By activeCheckbox = xpath("//input[@type='checkbox']/..");
    private final By saveAndAssignCountryBtn = id("country-checklist-item-save-and-assign");
    private final By saveChecklistButton = id("assignCountrySaveButton");
    private final By editSaveChecklistButton = id("country-checklist-item-save");
    private final By cancelChecklistButton = id("country-checklist-item-cancel");
    private final By cancelAssignCountryButton = id("assignCountryCancelButton");
    private final By addCountryChecklistButton = xpath("//button[contains(@id,'add-new-')]");
    private final By moveToRightAngelBtn = xpath("//button[@aria-label=\"add-from-available-countries\"]");
    private final By moveToLeftAngelBtn = xpath("//button[@aria-label=\"remove-from-selected-countries\"]");
    private final String editRowButton = "//tr//span[text()='%s']/ancestor::tr//*[@title='Edit']";
    private final String deleteRowButton = "//tr//span[text()='%s']/ancestor::tr//*[@title='Delete']";
    private final String assignRowButton = "//tr//span[text()='%s']/ancestor::tr//*[@title='Assign']";
    private final String alertTypeOptionInput = "//input[@value='%s']";
    private final By alertTypeOptions =
            xpath("//div[@aria-label='alertType']/label//p");
    private final String alertTypeOption =
            "//input[@value='%s']/ancestor::label//span[2]/div";
    private final String alertTypeIcon = "//input[@value='%s']/ancestor::label//span[2]/div/*[name()='svg']";
    protected final String buttonWithText = "//button/span[text()='%s']";
    protected final String assignCountryButtonWithText =
            "//button/span[text()='%s']";
    protected final By availableCountriesOptions = xpath("//*[text()='Available Countries']/..//li");
    protected final By selectedCountriesOptions = xpath("//*[text()='Selected Countries']/..//li");
    protected final By adminCountryCheckList = id("adminCountryCheckList");
    private final By tableRow = cssSelector("tbody>tr");
    private final By deleteButton = xpath("//*[name()='svg' and @aria-label=\"delete-country checklist\"]");
    private final By editButton = xpath("//*[name()='svg' and @aria-label=\"edit-country checklist\"]");
    private final By assignButton = xpath("//*[name()='svg' and @aria-label=\"assign-country\"]");
    private final String requiredIndicator = "//label/span[contains(., '%s')]/following-sibling::span[text()='*']";
    private final String fieldInputValue = "//label/span[contains(., '%s')]/../following-sibling::div//input";
    private final String fieldInputMessage =
            "//label/span[contains(., '%s')]/../following-sibling::div/following-sibling::p";
    private final String countryChecklistRow = "//tbody//span[contains(., '%s')]/ancestor::tr";
    private final By viewEditButton = cssSelector("[aria-label=\"edit-country checklist\"]");

    //Overview
    private final By tableHeaders = xpath("//thead/tr/th");
    private final String columnName = "//thead//th//span[contains(., '%s')]";
    private final String tableRowValue = "td[%s]";
    private final By tableMessage = xpath("(//h6)[3]");

}
