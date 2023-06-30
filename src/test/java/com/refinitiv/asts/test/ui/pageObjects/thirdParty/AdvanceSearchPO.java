package com.refinitiv.asts.test.ui.pageObjects.thirdParty;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class AdvanceSearchPO extends BasePO {

    private final By advanceSearchWindow = cssSelector(".MuiGrid-container");
    private final By searchButton = id("searchButton");
    private final By filterDropdown = id("searchFilterSelect");
    private final By dropdownItems = cssSelector(".MuiMenuItem-gutters");
    private final By clearSearchButton = id("clearResultsButton");
    private final By addButton = cssSelector(".MuiIconButton-colorSecondary");
    private final By resultsCount = xpath("//*[@id='advancedSearchTable']/table/tfoot/tr/td/div/p[2]");
    private final String paramDropdownRow1 = "//*[@id='root']//div[2]/div[2]/div[1]/div[%s]/div[1]//input";
    private final String paramDropdownRow2 = "//*[@id='root']//div[2]/div[2]/div[1]/div[%s]/div[2]//input";
    private final String parameterValueLine = "//label[text()='Parameter']/..//*[@value='%s']/../../../../..//" +
            "label[text()='Value']/..//*[@value='%s']";
    private final String deleteButton =
            "(//fieldset//span[text()='Value']/ancestor::div[contains(@class, 'MuiBox')][1]/following-sibling::button)[%s]";
    private final String screeningStatusColumn = "//table//th[9]//span[contains(text(),'%s')]";
    private final By noRecordsFound = cssSelector("#advancedSearchTable h6");
    private final By exportToExcelButton = xpath("//*[text()= 'Export to Excel']");
    private final String searchResultTableColumnHeader = "//thead/tr/th/span[text()='%s']";
    private final By columnNames = xpath("//th/span");
    private final By tableRows = cssSelector("tbody>tr");
    private final String rowColumn = "//tbody/tr/td[%s]";
    private final By rowsPerPage = xpath("//*[text()='Rows per page:']/..//input/..");

    public AdvanceSearchPO(WebDriver driver) {
        super(driver);
    }

}
