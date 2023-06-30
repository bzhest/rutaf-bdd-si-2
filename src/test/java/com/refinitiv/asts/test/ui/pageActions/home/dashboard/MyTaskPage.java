package com.refinitiv.asts.test.ui.pageActions.home.dashboard;

import com.refinitiv.asts.test.ui.enums.DdOrderFields;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageActions.PaginationPage;
import com.refinitiv.asts.test.ui.pageObjects.home.dashboard.MyTasksPO;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.DashboardItemData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.DdOrdersData;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static java.lang.String.format;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class MyTaskPage extends BasePage<MyTaskPage> {

    public static final String THIRD_PARTY_NAME = "THIRD-PARTY NAME";
    public static final String ACTIVITY_NAME = "ACTIVITY NAME";
    public static final String QUESTIONNAIRE_NAME = "QUESTIONNAIRE NAME";
    public static final String DESCRIPTION = "DESCRIPTION";
    public static final String QUESTIONNAIRE_DESCRIPTION = "QUESTIONNAIRE DESCRIPTION";
    public static final String DUE_DATE = "DUE DATE";
    public static final String RENEWAL_DATE = "RENEWAL DATE";
    public static final String QUESTIONNAIRE_DUE_DATE = "QUESTIONNAIRE DUE DATE";
    public static final String ASSIGNED_TO = "ASSIGNED TO";
    public static final String REVIEWER_NAME = "REVIEWER NAME";
    public static final String STATUS = "STATUS";
    public static final String QUESTIONNAIRE_STATUS = "QUESTIONNAIRE STATUS";
    public static final String TYPE = "TYPE";
    public static final String RECORD_NAME = "RECORD NAME";
    public static final String REVIEWER = "REVIEWER";
    public static final String RESPONSIBLE_PARTY = "RESPONSIBLE PARTY";
    public static final String RENEWAL_ASSIGNEE = "RENEWAL ASSIGNEE";
    public static final String ACTIVITY = "Activity";
    public static final String QUESTIONNAIRE = "Questionnaire";
    public static final String SCREENING = "Screening";
    public static final int DEFAULT_TABLE_SIZE = 10;
    private final MyTasksPO myTaskPO;
    private final PaginationPage paginationPage;

    public MyTaskPage(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
        myTaskPO = new MyTasksPO(driver, translator);
        paginationPage = new PaginationPage(driver, context);
    }

    @Override
    protected ExpectedCondition<MyTaskPage> getPageLoadCondition() {
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

    public boolean isWidgetDisabled(String widget) {
        waitShort.until(visibilityOfElementLocated(xpath(format(myTaskPO.getWidget(), widget))));
        return isElementAttributeContains(xpath(format(myTaskPO.getWidget(), widget)), CLASS, DISABLED);
    }

    public boolean isWidgetEnabled(String widget) {
        waitShort.until(visibilityOfElementLocated(xpath(format(myTaskPO.getWidget(), widget))));
        waitShort.until(invisibilityOfElementLocated(xpath(format(myTaskPO.getDisabledWidget(), widget))));
        return !isElementAttributeContains(xpath(format(myTaskPO.getWidget(), widget)), CLASS, DISABLED);
    }

    public boolean isAssignedActivitiesWidgetDisabled() {
        return isElementAttributeContains(myTaskPO.getAssignedActivitiesButton(), CLASS, DISABLED);
    }

    public boolean isDueDiligenceOrderWidgetDisabled() {
        return isElementAttributeContains(myTaskPO.getDueDiligenceButton(), CLASS, DISABLED);
    }

    public boolean isDueDiligenceOrderDisplayed(String orderId) {
        return isElementDisplayed(xpath(format(myTaskPO.getPendingOrderOrderIdValue(), orderId)));
    }

    public boolean isActivityDisplayed(String name) {
        boolean isActivityDisplayed = isElementDisplayed(xpath(format(myTaskPO.getDashboardTableRow(), name)));
        while (!isActivityDisplayed && paginationPage.isNextPageButtonVisible() &&
                paginationPage.isNextPageButtonActive()) {
            paginationPage.clickNextPageButtonAndWait();
            isActivityDisplayed = isElementDisplayed(xpath(format(myTaskPO.getDashboardTableRow(), name)));
            if (isActivityDisplayed) {
                break;
            }
        }
        return isActivityDisplayed;
    }

    public boolean isDashboardTableDisplayed() {
        return isElementDisplayed(xpath(myTaskPO.getDashboardTable()));
    }

    public boolean isDashboardWidgetChevronDisplayed() {
        return isElementDisplayed(waitMoment, myTaskPO.getDashboardChevron());
    }

    public boolean isDashboardWidgetChevronDisplayed(String widgetName) {
        return isElementDisplayed(getChildElement(driver.findElement(xpath(format(myTaskPO.getWidget(), widgetName))),
                                                  myTaskPO.getDashboardChevron()));
    }

    @Override
    public void load() {
        this.driver.get(URL);
    }

    public List<String> getTableColumnNameList() {
        return getElementsText(driver.findElements(myTaskPO.getTableColumnNameList()));
    }

    public List<String> getItemsToApproveStatusTableColumnNameList() {
        return getElementsText(driver.findElements(myTaskPO.getItemsToApproveStatus()));
    }

    public List<String> getSupplierForRenewalStatusTableColumnNameList() {
        return getElementsText(driver.findElements(myTaskPO.getSupplierForRenewalStatus()));
    }

    public List<String> getListValuesForColumn(String columnName) {
        int columnIndex = getColumnTableIndex(columnName.toUpperCase());
        return driver.findElements(myTaskPO.getDashboardTableRows()).stream()
                .map(row -> getElementText(
                        row.findElement(xpath(format(myTaskPO.getDashboardTableRowValue(), columnIndex)))))
                .collect(Collectors.toList());
    }

    public List<String> getDashboardTabs() {
        return getElementsText(myTaskPO.getDashboardTabs());
    }

    public List<String> getDashboardWidgets() {
        return getElementsText(waitShort, myTaskPO.getDashboardWidgets());
    }

    public List<String> getItemToReviewOptions() {
        return getDropDownOptions(myTaskPO.getDropDownOptions());
    }

    public List<String> getAllQuestionnaireStatuses() {
        List<String> statuses;
        if (!paginationPage.isNextPageButtonVisible()) {
            return getListValuesForColumn(QUESTIONNAIRE_STATUS);
        } else {
            paginationPage.selectMaxRowsPerPage();
            statuses = getListValuesForColumn(QUESTIONNAIRE_STATUS);
        }

        while (paginationPage.isNextPageButtonActive()) {
            paginationPage.clickNextPageButtonAndWait();
            statuses.addAll(getListValuesForColumn(QUESTIONNAIRE_STATUS));
        }
        return statuses;
    }

    public List<String> getAllOrdersStatuses() {
        return getAllDdOrdersTable().stream().map(DdOrdersData.DdOrderDashboard::getOrderStatus)
                .collect(Collectors.toList());
    }

    public void clickAssignedActivities() {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(waitShort.until(visibilityOfElementLocated(myTaskPO.getAssignedActivitiesButton())), waitLong);
    }

    public void clickItemsToApprove() {
        clickOn(waitShort.ignoring(StaleElementReferenceException.class)
                        .until(visibilityOfElementLocated(myTaskPO.getItemsToApproveButton())));
    }

    public void clickItemToReview() {
        clickOn(myTaskPO.getItemsToReviewButton(), waitLong);
    }

    public void clickThirdPartyForRenewalWidget() {
        clickOn(waitShort.until(visibilityOfElementLocated(myTaskPO.getThirdPartyForRenewalButton())));
    }

    public void clickDueDiligence() {
        clickOn(myTaskPO.getDueDiligenceButton(), waitShort);
    }

    public void clickPendingOrderForApproval() {
        clickOn(waitLong.until(elementToBeClickable(myTaskPO.getPendingOrderForApprovalButton())));
    }

    public void clickItemToReviewOptions() {
        clickOn(myTaskPO.getItemToReviewOptions());
    }

    public void selectItemsToReviewDropDown(String optionText) {
        clickOn(xpath(format(myTaskPO.getDropDownOption(), optionText)));
    }

    public void selectMyTasksTab() {
        clickOn(myTaskPO.getMyTaskTab());
    }

    public void clickActivityRow(String name) {
        clickOn(waitShort.until(visibilityOfElementLocated(xpath(format(myTaskPO.getDashboardTableRow(), name)))));
    }

    public void clickActivityRowWithNames(String thirdPartyName, String activityName) {
        clickOn(xpath(format(myTaskPO.getDashboardTableRowWithNames(), thirdPartyName, activityName)));
    }

    public void clickRowForThirdParty(String thirdPartyName, String itemToReview) {
        clickWithJS(driver.findElement(xpath(format(myTaskPO.getItemToReviewRow(), thirdPartyName, itemToReview))));
    }

    public void clickFirstDueDiligenceOrder() {
        clickOn(driver.findElements(myTaskPO.getDashboardTableRows()).get(0));
    }

    public void clickFirstItemToApprove() {
        clickOn(driver.findElements(myTaskPO.getTableRow()).get(0));
    }

    public void clickLastPageIfDisplayed() {
        paginationPage.clickLastPage();
    }

    public void clickFirstPageIfDisplayed() {
        paginationPage.clickFirstPage();
    }

    public void clickOnTableColumn(String columnName) {
        clickOn(xpath(format(myTaskPO.getColumnHeader(), columnName)), waitShort);
    }

    public void hoverOverWidget(String widgetName) {
        hoverOverElement(xpath(format(myTaskPO.getWidget(), widgetName)), waitShort);
    }

    public List<DashboardItemData> getAllItemsToReviewTableRows(boolean isTableContains) {
        List<DashboardItemData> resultsData;
        if (!paginationPage.isNextPageButtonVisible()) {
            return getItemsToReviewTableRows(isTableContains);
        } else {
            paginationPage.selectMaxRowsPerPage();
            resultsData = getItemsToReviewTableRows(isTableContains);
        }

        while (paginationPage.isNextPageButtonActive()) {
            paginationPage.clickNextPageButtonAndWait();
            resultsData.addAll(getItemsToReviewTableRows(isTableContains));
        }
        return resultsData;

    }

    public List<DashboardItemData> getItemsToReviewTableRows(boolean isTableContains) {
        if (isTableContains) {
            waitShort.until(numberOfElementsToBeMoreThan(myTaskPO.getDashboardTableRows(), 0));
        }
        return driver.findElements(myTaskPO.getDashboardTableRows()).stream()
                .map(row -> DashboardItemData.builder()
                        .thirdPartyName(getElementText(row.findElement(
                                xpath(format(myTaskPO.getDashboardTableRowValue(),
                                             getColumnTableIndex(THIRD_PARTY_NAME))))))
                        .activityName(getOptionalColumnValue(row, ACTIVITY_NAME))
                        .questionnaireName(getOptionalColumnValue(row, QUESTIONNAIRE_NAME))
                        .description(getOptionalColumnValue(row, DESCRIPTION))
                        .questionnaireDescription(getOptionalColumnValue(row, QUESTIONNAIRE_DESCRIPTION))
                        .dueDate(getOptionalColumnValue(row, DUE_DATE))
                        .questionnaireDueDate(getOptionalColumnValue(row, QUESTIONNAIRE_DUE_DATE))
                        .renewalDate(getOptionalColumnValue(row, RENEWAL_DATE))
                        .assignedTo(getOptionalColumnValue(row, ASSIGNED_TO))
                        .reviewerName(getOptionalColumnValue(row, REVIEWER_NAME))
                        .responsibleParty(getOptionalColumnValue(row, RESPONSIBLE_PARTY))
                        .renewalAssignee(getOptionalColumnValue(row, RENEWAL_ASSIGNEE))
                        .status(getOptionalColumnValue(row, STATUS))
                        .questionnaireStatus(getOptionalColumnValue(row, QUESTIONNAIRE_STATUS))
                        .type(getOptionalColumnValue(row, TYPE))
                        .recordName(getOptionalColumnValue(row, RECORD_NAME))
                        .reviewer(getOptionalColumnValue(row, REVIEWER)).build())
                .collect(Collectors.toList());
    }

    private String getOptionalColumnValue(WebElement row, String columnName) {
        int columnNameIndex = getColumnTableIndex(columnName);
        return columnNameIndex == 0 ? null :
                getElementText(row.findElement(xpath(format(myTaskPO.getDashboardTableRowValue(),
                                                            columnNameIndex))));
    }

    public String getWidgetItemsToApproveCounter() {
        waitShort.until(elementToBeClickable(myTaskPO.getItemsToApproveButton()));
        return getElementText(myTaskPO.getItemsToApproveCounter());
    }

    public String getWidgetPendingOrdersForApprovalCounter() {
        waitShort.until(elementToBeClickable(myTaskPO.getPendingOrderForApprovalButton()));
        return getElementText(myTaskPO.getPendingOrdersForApprovalCounter()).replace(COMMA, EMPTY);
    }

    public String getDashboardTableName() {
        return getElementText(myTaskPO.getDashboardTableName());
    }

    private int getColumnTableIndex(String columnName) {
        return getTableColumnNameList().indexOf(columnName) + 1;
    }

    public int getItemsToReviewCounter() {
        return Integer.parseInt(getElementText(myTaskPO.getItemsToReviewCount()));
    }

    public int getThirdPartyForRenewalCounter() {
        return Integer.parseInt(getElementText(myTaskPO.getThirdPartyForRenewalCount()));
    }

    public int getDDOrdersWidgetCounter() {
        return Integer.parseInt(getElementText(myTaskPO.getDueDiligenceCounter()).replace(COMMA, EMPTY));
    }

    public int getAssignedActivitiesCounter() {
        try {
            return Integer.parseInt(getElementText(myTaskPO.getAssignedActivitiesCounter()).replace(COMMA, EMPTY));
        } catch (NullPointerException exception) {
            return -1;
        }
    }

    public void waitUntilAssignedActivitiesCounterRefreshed() {
        waitShort.until(driver -> getAssignedActivitiesCounter() > 0);
    }

    public int getTableRowCount() {
        waitWhilePreloadProgressbarIsDisappeared();
        List<WebElement> tableRows = driver.findElements(myTaskPO.getDashboardTableRows());
        return (tableRows.size() < DEFAULT_TABLE_SIZE || !isElementDisplayed(myTaskPO.getTableCount())) ?
                tableRows.size() : Integer.parseInt(getElementText(myTaskPO.getTableCount()));
    }

    public List<DdOrdersData.DdOrderDashboard> getAllDdOrdersTable() {
        List<DdOrdersData.DdOrderDashboard> resultsData;
        if (!paginationPage.isNextPageButtonVisible()) {
            return getDdOrdersTablePerPage();
        } else {
            paginationPage.selectMaxRowsPerPage();
            resultsData = getDdOrdersTablePerPage();
        }

        while (paginationPage.isNextPageButtonActive()) {
            paginationPage.clickNextPageButtonAndWait();
            resultsData.addAll(getDdOrdersTablePerPage());
        }
        return resultsData;
    }

    public List<DashboardItemData> getAllAssignedActivities() {
        List<DashboardItemData> resultsData;
        if (!paginationPage.isNextPageButtonVisible()) {
            return getAssignedActivitiesData();
        } else {
            paginationPage.selectMaxRowsPerPage();
            resultsData = getAssignedActivitiesData();
        }

        while (paginationPage.isNextPageButtonActive()) {
            paginationPage.clickNextPageButtonAndWait();
            resultsData.addAll(getAssignedActivitiesData());
        }
        return resultsData;
    }

    public List<DdOrdersData.DdOrderDashboard> getDdOrdersTablePerPage() {
        List<DdOrdersData.DdOrderDashboard> ddOrdersData = new ArrayList<>();
        List<String> headers = getElementsText(myTaskPO.getTableColumnNameList());
        List<WebElement> ddOrdersRows = getElements(myTaskPO.getDashboardTableRows());
        for (WebElement row : ddOrdersRows) {
            List<WebElement> cells = row.findElements(myTaskPO.getTableCells());
            ddOrdersData.add(
                    new DdOrdersData.DdOrderDashboard()
                            .setOrderId(getDDOrderCellValue(headers, cells, DdOrderFields.ORDER_ID_DASHBOARD))
                            .setOrderStatus(getDDOrderCellValue(headers, cells, DdOrderFields.ORDER_STATUS))
                            .setScope(getDDOrderCellValue(headers, cells, DdOrderFields.SCOPE))
                            .setRequesterName(getDDOrderCellValue(headers, cells, DdOrderFields.REQUESTER_NAME))
                            .setApproverName(getDDOrderCellValue(headers, cells, DdOrderFields.APPROVER_NAME))
                            .setOrderDate(getDDOrderCellValue(headers, cells, DdOrderFields.ORDER_DATE))
                            .setDueDate(getDDOrderCellValue(headers, cells, DdOrderFields.DUE_DATE))
            );
        }
        return ddOrdersData;
    }

    public List<DashboardItemData> getAssignedActivitiesData() {
        List<DashboardItemData> assignedActivitiesData = new ArrayList<>();
        List<String> headers = getElementsText(myTaskPO.getTableColumnNameList());
        List<WebElement> assignedActivitiesRows = getElements(myTaskPO.getDashboardTableRows());
        for (WebElement row : assignedActivitiesRows) {
            List<WebElement> cells = row.findElements(myTaskPO.getTableCells());
            assignedActivitiesData.add(
                    DashboardItemData.builder()
                            .thirdPartyName(getCellValue(headers, cells, THIRD_PARTY_NAME))
                            .activityName(getCellValue(headers, cells, ACTIVITY_NAME))
                            .description(getCellValue(headers, cells, DESCRIPTION))
                            .dueDate(getCellValue(headers, cells, DUE_DATE))
                            .assignedTo(getCellValue(headers, cells, ASSIGNED_TO))
                            .status(getCellValue(headers, cells, STATUS)).build());
        }
        return assignedActivitiesData;
    }

    private String getDDOrderCellValue(List<String> headers, List<WebElement> cells, DdOrderFields orderIdDashboard) {
        return getCellValue(headers, cells, orderIdDashboard.getName());
    }

    private String getCellValue(List<String> headers, List<WebElement> cells, String headerName) {
        return getElementText(cells.get(headers.indexOf(headerName.toUpperCase())));
    }

    public String getDueDiligenceOrdersColor() {
        return getCssValue(myTaskPO.getDueDiligenceButton(), BACKGROUND_COLOR);
    }

    public String getItemsToApproveColor() {
        waitWhilePreloadProgressbarIsDisappeared();
        return getCssValue(myTaskPO.getItemsToApproveButton(), BACKGROUND_COLOR);
    }

    public String getItemsToReviewColor() {
        return getCssValue(myTaskPO.getItemsToReviewButton(), BACKGROUND_COLOR);
    }

    public String getThirdPartyForRenewalColor() {
        return getCssValue(myTaskPO.getThirdPartyForRenewalButton(), BACKGROUND_COLOR);
    }

    public String getPendingOrdersForApprovalColor() {
        return getCssValue(myTaskPO.getPendingOrderForApprovalButton(), BACKGROUND_COLOR);
    }

    public String getAssignedActivitiesColor() {
        return getCssValue(myTaskPO.getAssignedActivitiesButton(), BACKGROUND_COLOR);
    }

    public String getItemToReviewSelectedOption() {
        return getElementText(myTaskPO.getItemToReviewOptions());
    }

    public String getSelectedOptionBackground() {
        return getCssValue(myTaskPO.getDropDownSelectedOption(), BACKGROUND_COLOR);
    }

    public String getDashboardTableMessage() {
        return getElementText(myTaskPO.getDashboardTableMessage());
    }

    public String getWidgetColor(String widgetName) {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        return getCssValue(xpath(format(myTaskPO.getWidget(), widgetName)), BACKGROUND_COLOR);
    }

}