package com.refinitiv.asts.test.ui.pageActions.thirdParty;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.thirdParty.Address;
import com.refinitiv.asts.test.ui.api.model.thirdParty.ObjectsItem;
import com.refinitiv.asts.test.ui.constants.Pages;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.commonPO.ShowAngularPO;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.ThirdPartyOverviewPO;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.ThirdPartyData;
import com.refinitiv.asts.test.ui.utils.data.ui.ThirdPartyOverviewTableDTO;
import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.SIPublicApi.getLastCreatedThirdPartyIdByName;
import static com.refinitiv.asts.test.ui.constants.APIConstants.SAME_DIVISION;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.THIRD_PARTY_DATA_CONTEXT;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.THIRD_PARTY_ID;
import static com.refinitiv.asts.test.ui.constants.Pages.SLASH;
import static com.refinitiv.asts.test.ui.constants.Pages.THIRD_PARTY;
import static com.refinitiv.asts.test.ui.constants.TestConstants.THIRD_PARTY_NAME_SIMILAR;
import static java.lang.String.format;
import static java.util.stream.Collectors.toList;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.numberOfElementsToBeMoreThan;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated;

public class ThirdPartyOverviewPage extends BasePage<ThirdPartyOverviewPage> {

    private final ThirdPartyOverviewPO thirdPartyOverviewPO;
    private final ShowAngularPO showAngularPO;

    public ThirdPartyOverviewPage(WebDriver driver, ScenarioCtxtWrapper context) {
        super(driver, context);
        thirdPartyOverviewPO = new ThirdPartyOverviewPO(driver);
        showAngularPO = new ShowAngularPO();
    }

    @Override
    protected ExpectedCondition<ThirdPartyOverviewPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        waitWhilePreloadProgressbarIsDisappeared();
        return isElementDisplayed(waitShort, thirdPartyOverviewPO.getThirdPartyTable());
    }

    @Override
    public void load() {

    }

    public void navigateToThirdPartyPage() {
        driver.get(URL + THIRD_PARTY);
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void openCreatedThirdParty() {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        driver.get(URL + Pages.THIRD_PARTY + SLASH + thirdPartyId);
    }

    public void openThirdParty(String name) {
        String thirdPartyId = getLastCreatedThirdPartyIdByName(name, SAME_DIVISION);
        driver.get(URL + Pages.THIRD_PARTY + SLASH + thirdPartyId);
        context.getScenarioContext().setContext(THIRD_PARTY_DATA_CONTEXT, new ThirdPartyData().setName(name));
    }

    public void navigateToAdvanceSearch() {
        clickOn(thirdPartyOverviewPO.getAdvanceSearch());
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void clickOnAddThirdPartyButton() {
        clickOn(thirdPartyOverviewPO.getAddThirdPartyButton(), waitLong);
    }

    public void clickOnConfirmDeleteThirdPartyButton() {
        clickOn(waitShort.until(visibilityOfElementLocated(thirdPartyOverviewPO.getConfirmDeleteButton())));
    }

    public void clickDeleteThirdPartyWithName(String thirdPartyName) {
        clickOn(xpath(format(thirdPartyOverviewPO.getDeleteRowWithNameButton(), thirdPartyName)));
    }

    public void clickDeleteThirdPartyWithSimilarName(int rowNumber) {
        String similarThirdPartyName = (String) context.getScenarioContext().getContext(THIRD_PARTY_NAME_SIMILAR);
        clickOn(xpath(format(thirdPartyOverviewPO.getDeleteButtonForSimilarNameThirdParty(), similarThirdPartyName,
                             rowNumber)));
    }

    public boolean isThirdPartySectionFieldDisplayed(String section, String field) {
        return isElementDisplayed(xpath(format(thirdPartyOverviewPO.getThirdPartySectionField(), section, field)));
    }

    public void clickOpenThirdPartyWithName(String thirdPartyName) {
        clickOn(xpath(format(thirdPartyOverviewPO.getRowWithName(), thirdPartyName)), waitShort);
    }

    public void clickEditButtonOnThirdParty(String thirdPartyName) {
        clickOn(waitLong.until(
                visibilityOfElementLocated(xpath(format(thirdPartyOverviewPO.getEditButton(), thirdPartyName)))));
        waitForAngularPageIsLoaded();
    }

    public void clickColumnHeader(String columnName) {
        clickWithJS(driver.findElement(xpath(format(thirdPartyOverviewPO.getThirdPartyColumn(), columnName))));
        waitForAngularPageIsLoaded();
    }

    public boolean isThirdPartyWithNameDisplayed(String thirdPartyName) {
        waitLong.until(ExpectedConditions.visibilityOfElementLocated(
                xpath(format(thirdPartyOverviewPO.getRowWithName(), thirdPartyName))));
        return isElementDisplayedNow(xpath(format(thirdPartyOverviewPO.getRowWithName(), thirdPartyName)));
    }

    public boolean isThirdPartyWithNameDisappeared(String thirdPartyName) {
        return isElementDisappeared(waitShort, xpath(format(thirdPartyOverviewPO.getRowWithName(), thirdPartyName)));
    }

    public boolean isConfirmationDialogDisplayed() {
        waitWhilePreloadProgressbarIsDisappeared();
        return isElementDisplayedNow(thirdPartyOverviewPO.getDeleteConfirmationDialog());
    }

    public List<String> getAllThirdPartiesNames() {
        waitShort.until(numberOfElementsToBeMoreThan(showAngularPO.getTableRows(), 0));
        return getElementsText(thirdPartyOverviewPO.getName());
    }

    public List<ThirdPartyOverviewTableDTO> getAllThirdParties() {
        waitShort.until(numberOfElementsToBeMoreThan(showAngularPO.getTableRows(), 0));
        return getElements(showAngularPO.getTableRows())
                .stream()
                .map(row -> new ThirdPartyOverviewTableDTO()
                        .setName(row.findElement(thirdPartyOverviewPO.getName()))
                        .setIndustryType(row.findElement(thirdPartyOverviewPO.getIndustryType()))
                        .setCountry(row.findElement(thirdPartyOverviewPO.getCountry()))
                        .setStatus(row.findElement(thirdPartyOverviewPO.getStatus()))
                        .setRiskTier(row.findElement(thirdPartyOverviewPO.getRiskTier()))
                        .setDateCreated(row.findElement(thirdPartyOverviewPO.getDateCreated()))
                        .setLastUpdated(row.findElement(thirdPartyOverviewPO.getLastUpdated()))
                        .setScreeningStatus(row.findElement(thirdPartyOverviewPO.getScreeningStatus()))
                        .setEdit(getElement(waitMoment, () -> row.findElement(thirdPartyOverviewPO.getEdit())))
                        .setDelete(getElement(waitMoment, () -> row.findElement(thirdPartyOverviewPO.getDelete()))))
                .collect(toList());
    }

    public List<WebElement> getEditButtonsList() {
        return getElements(thirdPartyOverviewPO.getEdit());
    }

    public List<ObjectsItem> getThirdPartiesListFullDetails() {
        return getElements(showAngularPO.getTableRows()).stream()
                .map(row -> new ObjectsItem().setName(getElementText(row.findElement(thirdPartyOverviewPO.getName())))
                        .setIndustryType(getElementText(row.findElement(thirdPartyOverviewPO.getIndustryType())))
                        .setAddress(new Address().setCountry(
                                getElementText(row.findElement(thirdPartyOverviewPO.getCountry()))))
                        .setStatus(getElementText(row.findElement(thirdPartyOverviewPO.getStatus())))
                        .setRiskLevel(getElementText(row.findElement(thirdPartyOverviewPO.getRiskTier())))
                        .setCreateTime(getElementText(row.findElement(thirdPartyOverviewPO.getDateCreated())))
                        .setUpdateTime(getElementText(row.findElement(thirdPartyOverviewPO.getLastUpdated())))
                        .setOverallStatus(getElementText(row.findElement(thirdPartyOverviewPO.getScreeningStatus()))))
                .collect(Collectors.toList());
    }

    public ThirdPartyOverviewTableDTO getThirdPartyByName(String name) {
        return getAllThirdParties()
                .stream()
                .filter(thirdParty -> thirdParty.getName().getText().contains(name))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("Third-party wasn't find with name " + name));

    }

    public String getRiskTierColumnValueCssValue(ThirdPartyOverviewTableDTO thirdParty, String attribute) {
        return thirdParty.getRiskTier().getCssValue(attribute);
    }

    public String getEmptyTableMessage() {
        return getElementText(waitShort, thirdPartyOverviewPO.getTableMessage());
    }

    public void waitRowsNumberAppearance(int rowsNumber) {
        waitShort.until(numberOfElementsToBeMoreThan(showAngularPO.getTableRows(), rowsNumber));
    }

    public boolean isHeaderWithTextDisplayed(String headerText) {
        return isElementDisplayed(waitMoment, xpath(format(thirdPartyOverviewPO.getHeader(), headerText)));
    }

    public boolean isAddThirdPartyButtonDisplayed() {
        return isElementDisplayed(waitMoment, thirdPartyOverviewPO.getAddThirdPartyButton());
    }

    public boolean isTableDisplayed() {
        return isElementDisplayed(waitMoment, thirdPartyOverviewPO.getThirdPartyTable());
    }

    public boolean isThirdPartyColumnDisplayed(String columnName) {
        return isElementDisplayed(waitLong,
                                  xpath(format(thirdPartyOverviewPO.getThirdPartyColumnHeader(), columnName)));
    }

    public boolean isAdvancedSearchIsDisplayed() {
        return isElementDisplayed(waitMoment, thirdPartyOverviewPO.getAdvanceSearch());
    }

    public boolean isColumnBetween(String columnName, String beforeColumn, String afterColumn) {
        List<WebElement> sectionList = driver.findElements(thirdPartyOverviewPO.getColumnNamesList());
        int columnIndex = getColumnIndex(sectionList, columnName.toUpperCase());
        int beforeColumnIndex = getColumnIndex(sectionList, beforeColumn.toUpperCase());
        int afterColumnIndex = getColumnIndex(sectionList, afterColumn.toUpperCase());
        return columnIndex - beforeColumnIndex == 1 && afterColumnIndex - columnIndex == 1;
    }

    private int getColumnIndex(List<WebElement> sectionList, String sectionText) {
        int index = 0;
        for (int i = 0; i < sectionList.size(); i++) {
            if (sectionList.get(i).getText().contains(sectionText)) {
                logger.info(sectionText + " column index: " + i);
                return i;
            }
        }
        return index;
    }

    public boolean isThirdPartyOnListHasStatus(String name, String status) {
        try {
            return waitShort.ignoring(StaleElementReferenceException.class)
                    .until(driver -> getElementText(
                            xpath(format(thirdPartyOverviewPO.getStatusForThirdParty(), name))).equals(status));
        } catch (TimeoutException exception) {
            return false;
        }
    }

    public String getThirdPartyIdFromUrl() {
        return StringUtils.substringAfter(driver.getCurrentUrl(), "thirdparty/");
    }

}
