package com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class OtherNameScreeningSectionPO extends BasePO {

    public OtherNameScreeningSectionPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

    private final String screeningOtherModal = "//*[@id='OtherNameTable-ScreeningModal']";
    private final String screeningOtherNameTable = screeningOtherModal + "//table | //*[@role='dialog']";
    private final By otherNameScreeningTableHeaderList = xpath(screeningOtherModal + "//table//th");
    private final By otherNameScreeningTableResultList = xpath(screeningOtherModal + "//table//tbody/tr");
    private final By screeningTableHeaderList = xpath(screeningOtherModal + "//table//thead//th");
    private final String screeningOtherNameTableColumn = screeningOtherModal + "//table//thead//*[text()='%s']/..";
    private final String otherNameScreeningResultValue = screeningOtherModal + "//table//tbody/tr[%s]/td[%s]/div";
    private final String otherNameScreeningResolutionList =
            screeningOtherModal + "//table//tbody/tr[%s]//td[%s]//*[name()='svg']";
    private final String rowResolutionList = "td[9]//*[name()='svg']";
    private final String otherNameScreeningResolutionButton =
            screeningOtherModal + "//table//tbody//td//*[text()='%s']/../following-sibling::td//button[%s]";
    private final String otherNameScreeningBulkResolutionButton =
            "//ul[@id='menu-list-grow']//*[contains(text(), '%s')]/ancestor::li";
    private final String otherNameScreeningRowCheckbox = screeningOtherModal + "//table//tr[%s]/td//input";
    private final String otherNameScreeningRowCheckboxSpan = screeningOtherModal + "//table//tr[%s]/td//input/..";
    private final String otherNameScreeningPaginationOption = "//*[@role='listbox']/li[text()='%s']";
    private final String paginationButton = "//button[contains(@aria-label, '%s')]";
    private final String paginationButtonOtherNames = screeningOtherModal + "//button[contains(@aria-label, '%s')]";
    private final String screeningResult = screeningOtherModal + "//tbody/tr[%s]";
    private final String screeningRecordByReferenceId =
            screeningOtherModal + "//*[contains(., '%s')]/ancestor::tr";
    private final String screeningResolutionButtonsListByReferenceId =
            screeningOtherModal + "//*[contains(text(), '%s')]/ancestor::tr//*[contains(@id, 'resolution-')]/div/*";
    private final By otherNameResultsCloseButton = id("ScreeningModal-Close-Button");
    private final String otherNameTabButton = screeningOtherModal + "//span[text()='%s']/ancestor::button";
    private final By otherNameOGSToggle = xpath(screeningOtherModal + "//*[@id='ongoing-screening']");
    private final By otherNameOGSToggleChecked =
            xpath(screeningOtherModal +
                          "//div[@role='dialog']//*[@id='ongoing-screening']//span[@aria-disabled='false' and contains(@class, 'checked')]");
    private final By otherNameOGSToggleUnchecked =
            xpath(screeningOtherModal +
                          "//div[@role='dialog']//*[@id='ongoing-screening']//span[@aria-disabled='false' and not(contains(@class, 'checked'))]");
    private final By otherNamePaginationValuesList = xpath("//*[@role='listbox']/li");
    private final By otherNameScreeningResultPopUpHeader = xpath(screeningOtherModal + "//h2");
    private final By otherNameLastScreeningDate =
            xpath(screeningOtherModal + "//*[@data-testid='ScreeningHeader-root']");
    private final By otherNameScreeningTableText = xpath(screeningOtherModal + "//h6");
    private final By otherNameScreeningTableRefreshButton = xpath(screeningOtherModal + "//button/*[text()='Refresh']");
    private final By otherNameScreeningPagination =
            xpath(screeningOtherModal + "//*[@aria-label='pagination navigation']");
    private final By otherNameScreeningPaginationNextButton =
            xpath(screeningOtherModal +
                          "//*[@aria-label='pagination navigation']//button[@aria-label='Go to next page']");
    private final By otherNameScreeningPaginationDropDown =
            xpath(screeningOtherModal + "//p[text()='ROWS']/following-sibling::div");
    private final By paginationSelection =
            xpath(screeningOtherModal + "//div[contains(@class, 'MuiSelect-selectMenu')]");
    private final By otherNameScreeningHeaderCheckboxInput = xpath(screeningOtherModal + "//thead//tr[1]//input");
    private final By otherNameScreeningHeaderCheckboxSpan =
            xpath(screeningOtherModal + "//thead//tr[1]//input[@type='checkbox']/..");
    private final By resolveAsButton = id("ResolveAs-button-open");
    private final String tableRowValue = "td[%s]";
    private final String tableRowNameValue = "td[2]//span";
    private final By otherNamesogsSwitchButtonSpan =
            cssSelector("#OtherNameTable-ScreeningModal span[class*='switch']");
    private final By otherNamesOgsSwitchButton =
            cssSelector("#OtherNameTable-ScreeningModal div[role=dialog] div#ongoing-screening input");
    private final String labelWithName = "//span[text()='%s']";
    private final String screeningTab =
            "//*[@id='OtherNameTable-ScreeningModal']//*[@aria-label='screening tabs']//button//span[text()='%s']";
    private final By otherNamesMediaCheckRowPerPageDropdown = cssSelector(
            "[id=OtherNameTable-ScreeningModal] [data-testid^=ScreeningHeader]~* [class*=MuiSelect-selectMenu]");
    private final By otherNamesMediaCheckResultTableRecords =
            cssSelector("[id=OtherNameTable-ScreeningModal] [data-testid^=ScreeningHeader]~* tbody>tr");
    private final String mediaCheckOtherNamesScreeningSelectRecord =
            screeningOtherModal + "//tbody//tr[%s]//td/ancestor::tr//*[@type='checkbox']";
    private final String mediaCheckOtherNamesScreeningRecord =
            screeningOtherModal + "//tbody//tr[%s]//td/ancestor::tr";
    private final String mediacheckOtherNamesScreeningRecordChecked =
            screeningOtherModal + "//tr[%s]//td/ancestor::tr//*[contains(@class, 'Mui-checked')]";
    private final String screeningRecordName = screeningOtherModal + "//tr[%s]//td[2]//span";
    private final String screeningRecordId = screeningOtherModal + "//tr[%s]//td[7]/a";
    private final String mediaCheckScreeningRecordId = screeningOtherModal + "//tr[%s]";
    private final By resolutionTypeButtons =
            xpath("//*[contains(text(), 'Resolution type')]/parent::*/following-sibling::button " +
                          "| //*[@id='OtherNameTable-ScreeningModal']//table//tbody//tr[1]//button");
    private final String mediaCheckOtherNamesScreeningRecordRiskIcon =
            screeningOtherModal + "//tbody//tr[%s]//td/ancestor::tr//div[contains(@class,'MuiChip-sizeSmall')]";
    private final By noAvailableMassage = xpath("//*[@role='dialog']//h6[text()=\"" + translator.getValue(
            "thirdPartyInformation.screening.noAvailableData") + "\"]");
    private final By paginationLabel = xpath(screeningOtherModal + "//p[text()='ROWS']/../following-sibling::div/p");
    private final By totalPages =
            xpath(screeningOtherModal + "//*[@aria-label='Go to next page']/../preceding-sibling::li[position() < 2]");
    private final String otherNameScreening =
            "//p[text()=\"" + translator.getValue("thirdPartyInformation.otherNames") +
                    "\"]/ancestor::div//span[text()='%s']/ancestor::tr//following-sibling::td/div/*[1]";
    private final By resolutionOtherNameComment =
            xpath("//div[contains(@data-cid,'MediaCheckProfileResolution-Comment')]/input[@name='comment']");
    private final By screeningTableBody = xpath("(//table/tbody)[2]");
    private final String commentsSection =
            "//*[text()='Comments']/ancestor::div[contains(@class, 'MuiButtonBase') and contains(@class, 'MuiAccordionSummary')]";
    private final By commentLengthMessage = xpath("//*[@id='CommentsV2-container']/div/div[1]/div/p/span");
    private final By commentTextarea = cssSelector("textarea#comment");
    private final String commentActionButton = commentsSection + "/..//button/span[text()='%s']/..";
    private final By mediaCheckSearchTermInScreeningOtherNamesResultTable =
            xpath("//div[@id='OtherNameTable-ScreeningModal']//*[@aria-label='FilterList']/ancestor::div[2]/div/span[2]");
    private final By otherNamesLastScreeningDate =
            cssSelector("[id=OtherNameTable-ScreeningModal] [data-testid^=ScreeningHeader]>div:nth-child(1)");
    private final String mediaCheckOtherNamesPhases =
            "//table[@id='media-check-table-results']//tr[%s]//div[@id='resolution']//span[6]";
    private final String mediaCheckOtherNamesTopics =
            "//table[@id='media-check-table-results']//tr[%s]//div[@id='resolution']//span[7]";
    private final String mediaCheckOtherNamesPublicationName =
            "//table[@id='media-check-table-results']//tr[%s]//div[@id='resolution']//span[3]";
    private final String mediaCheckOtherNamesDate =
            "//table[@id='media-check-table-results']//tr[%s]//div[@id='resolution']//span[1]";
    private final By mediaCheckOtherNamesArticleNumber = xpath("//div[text()='Showing']/child::span[1]");
    private final String mediaCheckOtherNameTitle = "//table[@id='media-check-table-results']//tr[%s]//a";
    private final By ogsButtonOtherNameDisable =
            xpath("//div[@id='OtherNameTable-ScreeningModal']//div[@id='ongoing-screening']//span[1]/span[@aria-disabled='true']");
    private final By ogsOtherNameSwitchButtonSpan =
            cssSelector("#OtherNameTable-ScreeningModal div[role=dialog] div#ongoing-screening span[class*='switch']");
    private final String mediaCheckOtherNameScreeningRecordRiskToolTip = "//div[contains(@class,'MuiTooltip')]//p[text()='%s']";

}
