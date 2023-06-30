package com.refinitiv.asts.test.ui.pageObjects.reports;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class ReportsPO extends BasePO {

    private final String filterPanelButton = "(//button[@ref='eToggleButton'])[%s]";
    private final String reportsTab = "//span[text()='%s']/ancestor::button";
    private final By reportsTabs = cssSelector("button[id^=metrics]");
    private final By columnsSearchField =
            xpath("//div[contains(@class,'ag-column-select-header-filter-wrapper')]//input");
    private final By filtersSearchField =
            xpath("//*[@class='ag-set-filter']//div[contains(@class,'ag-text-field-input-wrapper')]//input");
    private final String columnFieldCheckbox = "//*[@class='ag-column-select-column-label'][text()= '%s']" +
            "/parent::div//*[contains(@class,'ag-column-select-checkbox')]//input[@type = 'checkbox']/..";
    private final String agFilterFieldTitle =
            "//span[text()='%s'][@class='ag-group-title ag-filter-toolpanel-group-title']";
    private final String agFilterFieldLabel =
            "//div[text()='%s'][@class='ag-input-field-label ag-label ag-checkbox-label']/..//input/..";
    private final String activityResultCount = "//*[@id='DrilldownTable-Pagination']/div/div[3]/h3";
    private final By searchFiltersList = xpath("//*[@data-cid='SearchFilters-root']/div/div/div/div/h6");
    private final By searchTableFieldsList =
            xpath("//*[@id='SearchResults-SearchResultsTable']/div/table/thead/tr/th/span");
    private final String riskAreasTableFields = "//*/table/thead/tr/th[%s]/span/div/div";
    private final String riskAreasTableField = "//*/table/thead/tr/th//div[text()='%s']";
    private final By noMatchFound = xpath("//*[@id='CenterTableOverlay-noDataAvailable']/span");
    private final By tableReportList = xpath("//*/div[2]/div/div/div/div[2]/div[2]/div[3]/div[2]/div/div/div");
    private final By thirdPartyDropdown = xpath("//select[@id='table-category-id']");
    private final By filterPageButton = xpath("//button[@ref='applyFilterButton']");
    private final By searchFiltersFrom = xpath("//input[@id='SearchFilters-CustomDate-From']");
    private final By searchFiltersTo = xpath("//input[@id='SearchFilters-CustomDate-To']");
    private final By reportCategoryDropdown = xpath("//select[@id='supplier-option-id']");
    private final By filterResetAll = xpath("//*[@id='filter-reset-all']");
    private final By exportButton = xpath("//*[@id='export-button'] | //*[@id='export-csv-button']");
    private final By paginationSelect = xpath("//*[@id='pagination-select']");
    private final By riskAreas = xpath("//*[@id='SearchFilters-Autocomplete-Autocomplete']");
    private final By generateResultButton = xpath("//h6[contains(text(), 'Generate Result')]");
    private final By clearFilterButton = xpath("//button[@ref='clearFilterButton' or @ref='resetFilterButton']");
    private final By firstRowReport = xpath("//*[@class='ag-center-cols-container']//*[@row-id='0']");
    private final By rowReport = cssSelector(".ag-center-cols-container [row-id], [id*=Report][id$=Results] tbody>tr");
    private final By rowValue = xpath("div | td");
    private final By noAvailableData = xpath("//*[text()='No Available Data']");
    private final By exportToExcelLabel = xpath("//*[text()='Export to Excel']");
    private final By searchResultsLabel = xpath("//*[@id='SearchResults-SearchResulstView']/div/div/h2");
    private final By searchFiltersCustomDateFrom = xpath("//p[@id='SearchFilters-CustomDate-From-helper-text']");
    private final By searchFiltersCustomDateTo = xpath("//p[@id='SearchFilters-CustomDate-To-helper-text']");
    private final By cancelButton =
            xpath("//*[@id='react-container-answer-questionnaire']/div/div/div[2]/form/div[3]/div[1]/button");
    private final String columnName =
            "//*[contains(@class,'ag-cell-label-container ag-header-cell-sorted')]//*[contains(., '%s')]";
    private final By exportOptions = xpath("//*[@id='export-button-MenuList']/li");
    private final By iconButton = xpath("//*/div[1]/div/div[3]/div/h6/button");
    private final By iconInfo = xpath("//*[@id='CustomPopper-category-content']");
    private final String reportTabButton = "//span[text()='%s']/ancestor::button";
    private final String filterCheckbox = "//*[@ref='eSetFilterList']//*[text()='%s']/following-sibling::div";
    private final By tableColumns =
            xpath("//*[@class='ag-cell-label-container ag-header-cell-sorted-none']//*[@ref='eText']");
    private final String tableColumn =
            "//*[@class='ag-cell-label-container ag-header-cell-sorted-none']//*[@ref='eText' and text()='%s']";
    private final By filterOptionOpen =
            xpath("//*[@ref='filtersToolPanelListPanel']//*[@ref='eGroupClosedIcon' or @ref='eGroupOpenedIcon']");
    private final String filterOptionButton = "//*[@class='ag-filter-apply-panel']/button[contains(text(),'%s')]";
    private final String tableColumnValues = "//*[@ref='eViewport']//*[@role='row']/div[%s]";
    private final String riskScoreValues = "//*[@ref='eViewport']//*[@role='row']/div[%s]//h6";
    private final String statusTableColumnValues = "//tbody//td[%s]";
    private final String reportPanel = "//*[contains(@class, 'ag-tool-panel-wrapper')][%s]";
    private final String filterIcon =
            "//span[text()='%s']/following-sibling::span[@class='ag-header-icon ag-header-label-icon ag-filter-icon']";
    private final By selectAllColumns = cssSelector("[aria-label='Toggle Select All Columns']");
    private final By flatFileTemplateButton = id("flat-file-template-button");
    private final By informationIcon = id("BulkTransactions-Button-InfoIcon");
    private final By bulkProcessTypeDropDown = id("BulkTransactions-BulkProcessType-Select");
    private final String bulkProcessTypeDropdownOption = "//ul[@role='listbox']/li[text()='%s']";
    private final By uploadFileButton = id("upload-file-button");
    private final By uploadFileInput = xpath("//input[@type='file']");
    private final By uploadFileCrossButton = xpath("//button[@id='file-input-clear-icon']");
    private final By uploadButtonModalWindow = xpath("//button[@id='dialog-proceed-button']");
    private final By uploadModalWindow = xpath("//div[@role='dialog']");
    private final String statusValueBulkTransactionsTable = "//div[@role='rowgroup']/div[@row-id='%d']/div[@col-id='status']";
    private final String statusReportRecord = "//td//*[text()='%s']";
    private final String thirdPartyValue = "//h2[text()='%s:']/../following-sibling::div/p";
    private final String thirdPartyValueWithCircle = "//h2[text()='%s:']/../../../following-sibling::div/p";
    private final String activityStatusCircle = "//h2[text()='%s:']/../../div/*[contains(@class,'MuiSvgIcon')]/*";
    private final By workflowEmptyMessage = xpath("//h2[text()='Third-party Status:']/../following-sibling::div//h5");
    private final By completionProgressbarPercentage = id("SearchResultsView-CustomCircularProgress");
    private final By wizardsProgress =
            xpath("//div[@data-cid='CustomProgressBar-root']//h2[contains(@style, 'black')]");
    private final By wizardsGreenProgress = xpath("//*[contains(@style, 'rgb(117, 192, 68)')]/h2");
    private final By wizardsComponentName = xpath("../../../..//p");
    private final By statusReportThirdPartiesNames = xpath("//tbody/tr/td[1]");
    private final By statusReportTooltip = cssSelector("#CustomProgressBar-CustomTooltip h2");
    private final By riskAreaTableIcon = cssSelector("img[alt$=score]");
    private final By dropDownValuesList = xpath("//*[@role='listbox']/li");
    private final By filterValueInput = cssSelector("[aria-label='Filter Value'],[aria-label='Search filter values']");
    private final By firstCheckBoxValue = xpath("(//*[@ref='eCheckbox'])[2]");
    private final By
            staticCheckBoxOptions = xpath("//*[@ref='eCheckbox']/*[@ref='eLabel' and not(text()='(Select All)')]");
    private final By filterOptions = cssSelector("[ref='eTitle']");
    private final By horizontalScroll = xpath("//div[@class='ag-body-horizontal-scroll-viewport']");
    private final String errorFileButtonBulkTransactionsTable = "//div[@row-id='%d']//div[@col-id='errorResponseFile']";
    public ReportsPO(WebDriver driver) {
        super(driver);
    }

}
