package com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class OtherNameSectionPO extends BasePO {

    public OtherNameSectionPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

    private final String otherNamesSection =
            "//*[text()=\"" + translator.getValue("thirdPartyInformation.otherNames") +
                    "\"]/ancestor::div[contains(@class, 'MuiAccordion-root')]";
    private final String otherNameTable = otherNamesSection + "//table";
    private final By otherNamesTableColumnNameList = xpath(otherNamesSection + "//th");
    private final By otherNamesTableColumnValuesList = xpath(otherNamesSection + "//td");
    private final By otherNamesTableCreateDateValuesList = xpath(otherNamesSection + "//tbody/tr/td[3]");
    private final String otherNameRow = "//td//span[text()='%s']/ancestor::tr";
    private final String otherNameEdit = otherNameRow + "//td/div/*[2][local-name() ='svg']";
    private final String otherNameDelete = otherNameRow + "//td/div/*[3][local-name() ='svg'][@title='Delete']";
    private final String otherNameScreen =
            otherNameRow + "//td/div/*[1][local-name() ='svg'][@title=\"" +
                    translator.getValue("thirdPartyInformation.screening.clickToEnableScreening") + "\"]";
    private final By otherNameScreenIcon = xpath("//tr[1]/td[5]/div//*[@title='Click to enable screening']");
    private final String otherNameColumnValues = otherNameTable + "/tbody/tr/td[%s]";
    private final String otherNameColumn = otherNameTable + "//*[text()='%s']";
    private final String fieldError = otherNamesSection + "//span[text()='%s']/../../..//p";
    private final String inputField = otherNamesSection + "//span[text()='%s']/../../..//input";
    private final By inputFieldName = xpath("//p[text()=\"" + translator.getValue("thirdPartyInformation.otherNames") +
                                                    "\"]/../../../..//input[@name='name']");
    private final By inputNameTypeField =
            xpath("//span[text()=\"" + translator.getValue("thirdPartyInformation.otherNames.nameType") +
                          "\"]/ancestor::label/..//input");
    private final String openDropDownButton = inputField + "/following-sibling::div/button[@aria-label='Open']";
    private final String closeDropDownButton = inputField + "/following-sibling::div/button[@aria-label='Close']";
    private final String clearDropDownButton = inputField + "/following-sibling::div/button[@aria-label='Clear']";
    private final String dropDownValueWithText = "//*[@role='listbox']//*[contains(., '%s')]/ancestor-or-self::li";
    private final String checkTypeOptions = otherNamesSection +
            "//label[text()='Check type']/following-sibling::div//span[contains(@class, 'MuiFormControlLabel')]";
    private final String checkTypeSpan = "//span[text()='%s']/../span[1]";
    private final String checkType = "//*[text()='Check type']/../div//span[text()='%s']/../span";
    private final By otherNamesSubmitButton = id("submit-other-name");
    private final By cancelOtherNameButton = id("cancel-other-name");
    private final By firstDropDownOption = xpath("//*[@role='listbox']/li[1]");
    private final String checkTypeLabel = "//*[text()='Check type']/following-sibling::div//span[text()='%s']";
    private final String screenCheckType = checkTypeLabel + "/preceding-sibling::span//input";
    private final By deleteOtherNameModalBody = xpath("//div[@role='dialog']/div[2]");
    private final By deleteOtherNameModalCancelButton = id("simpleModalCancelButton");
    private final By deleteOtherNameModalProceedButton = id("simpleModalSuccessButton");
    private final String mediaCheckScreeningRecord =
            "//div[contains(@class, 'MuiDialogContent-root')]//tbody[contains(@class, 'MuiTableBody-root')]/tr['%s']/td[2]";
    private final String checkBoxCheckType = otherNamesSection + "//span[text()='%s']/preceding-sibling::span//input";
    private final By openNameTypeList =
            xpath("//*[text()=\"" + translator.getValue("thirdPartyInformation.otherNames") +
                          "\"]/ancestor::div[contains(@class, 'MuiAccordion-root')]//span[text()=\"" +
                          translator.getValue("thirdPartyInformation.otherNames.nameType") + "\"]/../../..//input");
    private final By otherNameGroupsName = xpath("//*[text()='Groups']/../..//div/input");
    private final By otherNameGroupsInput = xpath("//input[@id='Form-OtherName-GroupSelectInput']");
    private final By associatedOrgOtherNameGroupsInput =
            xpath("//*[@id='Form-OtherName-GroupSelectInput']");
    private final By otherNameLastScreeningDate =
            cssSelector("[data-cid^=ScreeningModal] [data-testid^=ScreeningHeader]>div:nth-child(1)");
    private final By otherNameNoMatchFoundMessage =
            xpath("//div[contains(@data-cid, 'ScreeningModal')]//h6[text()='No available data']");
    private final By otherNameOgsButtonDisable =
            xpath("//div[contains(@data-cid, 'ScreeningModal')]//div[@id='ongoing-screening']//div/div//span[1]/span[@aria-disabled='true']");
    private final String wcScreeningOtherNameTypeTooltip =
            "//div[@id='OtherNameTable-ScreeningModal']//span[text()='%s']/ancestor::tr//div[text()='%s']";

}