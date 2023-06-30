package com.refinitiv.asts.test.ui.pageActions.home.dashboard;

import com.refinitiv.asts.core.framework.webelements.SelectClz;
import com.refinitiv.asts.test.ui.constants.DashboardConstants;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.home.dashboard.ThirdPartyMetricsPO;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.Objects;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.TestConstants.BACKGROUND_COLOR;
import static com.refinitiv.asts.test.ui.enums.AdvanceSearchResultsFields.RISK_TIER;
import static com.refinitiv.asts.test.ui.stepDefinitions.ui.home.dashboard.ThirdPartyMetricsSteps.TOTAL;
import static java.lang.Integer.parseInt;
import static java.lang.String.format;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class ThirdPartyMetricsPage extends BasePage<ThirdPartyMetricsPage> {

    private static final Pattern METRIC_VALUE_PATTERN = Pattern.compile("[\\d+-]");
    private final ThirdPartyMetricsPO thirdPartyMetricsPO;

    public ThirdPartyMetricsPage(WebDriver driver) {
        super(driver);
        this.thirdPartyMetricsPO = new ThirdPartyMetricsPO(driver);
    }

    @Override
    protected ExpectedCondition<ThirdPartyMetricsPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return false;
    }

    @Override
    public void load() {

    }

    public void selectThirdPartyMetricsTab() {
        clickOn(thirdPartyMetricsPO.getThirdPartyMetricsTab());
    }

    public void selectThirdPartyDropdown(String param) {
        waitWhilePreloadProgressbarIsDisappeared();
        new SelectClz(driver.findElement(thirdPartyMetricsPO.getDashboardFilterDropdown())).selectElementByText(param);
    }

    public void clickOnOnboardingColumn(String columnName, String riskScore) {
        int rowIndex = getTableRiskTierColumnRowsNameList().indexOf(riskScore) + 1;
        int columnIndex = getTableMinorColumnNameList().indexOf(columnName) + 1;
        clickOn(xpath(format(thirdPartyMetricsPO.getOnboardingRowValue(), rowIndex, columnIndex)));
    }

    public void clickOnRenewalColumn(String columnName, String riskScore) {
        int rowIndex =
                getElementsText(thirdPartyMetricsPO.getSupplierMetricsRenewalMinorColumns()).indexOf(riskScore) + 1;
        int columnIndex = getThirdPartyMetricsRenewalMajorColumns().indexOf(columnName) + 1;
        clickOn(xpath(format(thirdPartyMetricsPO.getRenewalRowValue(), rowIndex, columnIndex)));
    }

    public List<String> getTableMajorColumnNameList() {
        return getElementsText(thirdPartyMetricsPO.getSupplierMetricsMajorColumns());
    }

    public List<String> getTableMinorColumnNameList() {
        return getElementsText(thirdPartyMetricsPO.getSupplierMetricsMinorColumns());
    }

    public List<String> getTableRiskTierColumnRowsNameList() {
        return getElementsText(thirdPartyMetricsPO.getSupplierMetricsRiskTierColumns());
    }

    public List<String> getSupplierMetricsRenewalHeaderColumns() {
        return getElementsText(thirdPartyMetricsPO.getSupplierMetricsRenewalHeaderColumns());
    }

    public List<String> getThirdPartyMetricsRenewalMajorColumns() {
        return getElementsText(thirdPartyMetricsPO.getSupplierMetricsRenewalMajorColumns());
    }

    public List<String> getThirdPartyMetricsRenewalRiskTiers() {
        ExpectedCondition<List<WebElement>> columnsAreLoaded =
                driver -> {
                    List<WebElement> columns =
                            driver.findElements(thirdPartyMetricsPO.getSupplierMetricsRenewalMinorColumns());
                    return columns.size() == 4 ? columns : null;
                };

        return waitShort.until(columnsAreLoaded).stream().map(WebElement::getText)
                .filter(field -> !field.isEmpty())
                .collect(Collectors.toList());
    }

    public List<String> getMetricDropdownOptions() {
        waitWhilePreloadProgressbarIsDisappeared();
        return new SelectClz(driver.findElement(thirdPartyMetricsPO.getDashboardFilterDropdown())).getAllOptions();
    }

    public String getMetricDropdownSelectedOption() {
        waitWhilePreloadProgressbarIsDisappeared();
        return new SelectClz(driver.findElement(thirdPartyMetricsPO.getDashboardFilterDropdown())).getSelectedElement();
    }

    public String getRiskTierThirdPartyVolCount(String tier) {
        return getRiskTier(tier, thirdPartyMetricsPO.getRiskTierThirdPartyVolCount());
    }

    public String getTotalRiskTierThirdPartyVolCount() {
        return driver.findElement(xpath(format(thirdPartyMetricsPO.getRiskTierThirdPartyVolCount(), 4))).getText();
    }

    public String getRiskTierThirdPartyVolPercent(String tier) {
        return getRiskTier(tier, thirdPartyMetricsPO.getRiskTierThirdPartyVolPercent());
    }

    public String getThirdPartyVolByRiskTierLabel() {
        return getElementText(thirdPartyMetricsPO.getPartnerVolByRiskTierLabel());
    }

    public String getOnboardingVolByStatusLabel() {
        return getElementText(thirdPartyMetricsPO.getOnboardingVolByStatusLabel());
    }

    public String getThirdPartyMetricsUpdatedDateLabel() {
        waitWhilePreloadProgressbarIsDisappeared();
        return getElementText(thirdPartyMetricsPO.getThirdPartyMetricsUpdatedDateLabel());
    }

    private String getRiskTier(String tier, String elementValue) {
        waitWhilePreloadProgressbarIsDisappeared();
        int tierResult = tier.equalsIgnoreCase(DashboardConstants.HIGH_RISK) ? 1 :
                tier.equalsIgnoreCase(DashboardConstants.MEDIUM_RISK) ? 2 :
                        tier.equalsIgnoreCase(DashboardConstants.LOW_RISK) ? 3 : 4;
        return getElementText(xpath(format(elementValue, tierResult)));
    }

    public String getCountForOnboardingColumnRow(String columnName, String riskScore) {
        int columnIndex = getTableMinorColumnNameList().indexOf(columnName) + 1;
        int rowIndex = getTableRiskTierColumnRowsNameList().indexOf(riskScore) + 1;
        waitShort.until(textMatches(xpath(format(thirdPartyMetricsPO.getOnboardingRowValue(), rowIndex, columnIndex)),
                                    METRIC_VALUE_PATTERN));
        return getElementText(xpath(format(thirdPartyMetricsPO.getOnboardingRowValue(), rowIndex, columnIndex)));
    }

    public String getCountForRenewalColumnRow(String columnName, String riskScore) {
        int columnIndex = getThirdPartyMetricsRenewalMajorColumns().indexOf(columnName) + 1;
        int rowIndex = getThirdPartyMetricsRenewalRiskTiers().indexOf(riskScore) + 1;
        waitShort.until(textMatches(xpath(format(thirdPartyMetricsPO.getRenewalRowValue(), rowIndex, columnIndex)),
                                    METRIC_VALUE_PATTERN));
        return getElementText(xpath(format(thirdPartyMetricsPO.getRenewalRowValue(), rowIndex, columnIndex)));
    }

    public String getBarChartText(String barChart) {
        return getElementText(xpath(format(thirdPartyMetricsPO.getBarChart(), barChart)));
    }

    public String getOnboardingRiskTierColumnColor(String column) {
        return getCssValue(xpath(format(thirdPartyMetricsPO.getSupplierMetricsMinorColumn(), column.toUpperCase())),
                           BACKGROUND_COLOR);
    }

    public String getRenewalRiskTierColumnColor(String column) {
        return getCssValue(
                xpath(format(thirdPartyMetricsPO.getSupplierMetricsRenewalMinorColumn(), column.toUpperCase())),
                BACKGROUND_COLOR);
    }

    public boolean isBarGraphWithLabelDisplayed(String labelName) {
        return isElementDisplayed(xpath(format(thirdPartyMetricsPO.getBarGraph(), labelName.toUpperCase())));
    }

    public boolean areOnboardingEmptyResultsDisplayed() {
        List<String> activityMetricColumns = getTableMinorColumnNameList();
        List<String> activityMetricRows = getTableRiskTierColumnRowsNameList();
        return areValuesEmpty(activityMetricColumns, activityMetricRows);
    }

    public boolean arePendingEmptyResultsDisplayed() {
        List<String> activityMetricColumns = getThirdPartyMetricsRenewalMajorColumns();
        List<String> activityMetricRows = getThirdPartyMetricsRenewalRiskTiers();
        return areValuesEmpty(activityMetricColumns, activityMetricRows);
    }

    private boolean areValuesEmpty(List<String> activityMetricColumns,
            List<String> activityMetricRows) {
        int emptyValue = 0;
        String emptyPercentValue = "0%";
        activityMetricColumns.remove(RISK_TIER.getName().toUpperCase());
        activityMetricRows.remove(TOTAL);
        return activityMetricRows.stream().mapToInt(row -> activityMetricRows.indexOf(row) + 1).allMatch(
                columnIndex -> activityMetricColumns.stream()
                        .mapToInt(column -> activityMetricColumns.indexOf(column) + 2)
                        .mapToObj(rowIndex -> getElementText(
                                xpath(format(thirdPartyMetricsPO.getRowValue(), columnIndex, rowIndex))))
                        .anyMatch(rowValue -> parseInt(rowValue) == emptyValue ||
                                Objects.equals(rowValue, emptyPercentValue)));
    }

}
