package com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.renewalSettings;

import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.workflowManagement.renewalSettings.RenewalSettingsAdvancedSearchPO;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.ArrayList;
import java.util.List;

import static com.refinitiv.asts.test.ui.constants.TestConstants.DISABLED;
import static java.lang.String.format;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated;

public class RenewalSettingsAdvancedSearchPage extends BasePage<RenewalSettingsAdvancedSearchPage> {

    private static final String MAX_OPTION = "50";
    private static final String HALF_MAX_OPTION = "25";

    private final RenewalSettingsAdvancedSearchPO advancedSearchPO;

    public RenewalSettingsAdvancedSearchPage(WebDriver driver) {
        super(driver);
        this.advancedSearchPO = new RenewalSettingsAdvancedSearchPO(driver);
    }

    @Override
    protected ExpectedCondition<RenewalSettingsAdvancedSearchPage> getPageLoadCondition() {
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

    public void clickAdvancedSearchUsersModalSearchButton() {
        clickOn(advancedSearchPO.getModalButtonSearch());
    }

    public void clickAdvancedSearchModalCancelButton() {
        clickOn(advancedSearchPO.getModalButtonCancel());
    }

    public void clickAdvancedSearchModalAddButton() {
        clickOn(advancedSearchPO.getModalButtonAdd());
    }

    public void clickNextPage() {
        clickOn(advancedSearchPO.getNextPage(), waitMoment);
    }

    public void tickFirstAvailableRadioButton() {
        clickOn(getElements(advancedSearchPO.getRadioButtons()).get(0));
    }

    public void fillInFirstNameField(String firstName) {
        clearInputAndEnterField(advancedSearchPO.getModalUsersFirstName(), firstName);
    }

    public void fillInLastNameField(String lastName) {
        clearInputAndEnterField(advancedSearchPO.getModalUsersLastName(), lastName);
    }

    public void fillInGroupNameField(String groupName) {
        driver.findElement(advancedSearchPO.getModalUsersGroupGroupName()).sendKeys(groupName);
    }

    public void selectMaxRowsToBeDisplayed() {
        clickRowsPerPage();
        clickRowsPerPageMaxOption();
    }

    public boolean isAdvancedSearchModalDisplayed(String modalName) {
        return isElementDisplayed(waitMoment, xpath(format(advancedSearchPO.getModalUsers(), modalName)));
    }

    public boolean isAdvancedSearchModalDisappeared(String modalName) {
        return isElementDisappeared(waitMoment, xpath(format(advancedSearchPO.getModalUsers(), modalName)));
    }

    public boolean isFirstNameFieldDisplayed() {
        return isElementDisplayed(advancedSearchPO.getModalUsersFirstName());
    }

    public boolean isLastNameFieldDisplayed() {
        return isElementDisplayed(advancedSearchPO.getModalUsersLastName());
    }

    public boolean isSearchButtonDisplayed() {
        return isElementDisplayed(advancedSearchPO.getModalButtonSearch());
    }

    public boolean isCancelButtonDisplayed() {
        return isElementDisplayed(advancedSearchPO.getModalButtonCancel());
    }

    public boolean isRowsPerPageDisplayed() {
        return isElementDisplayed(advancedSearchPO.getRowsPerPage());
    }

    public boolean isNoMatchFoundMessageDisplayed() {
        return isElementDisplayed(advancedSearchPO.getNoMatchFoundMessage());
    }

    public boolean isGroupNameFieldDisplayed() {
        return isElementDisplayed(advancedSearchPO.getModalUsersGroupGroupName());
    }

    public String getFirstNameFieldActualName() {
        return getElementText(advancedSearchPO.getModalUsersFirstNameLabel());
    }

    public String getLastNameFieldActualName() {
        return getElementText(advancedSearchPO.getModalUsersLastNameLabel());
    }

    public String getAdvanceSearchHeader() {
        return getElementText(advancedSearchPO.getModalSearchHeader());
    }

    public List<String> getAdvanceSearchResults() {
        waitShort.ignoring(StaleElementReferenceException.class)
                .until(visibilityOfElementLocated(advancedSearchPO.getModalSearchResults()));
        return getElementsText(getElements(advancedSearchPO.getModalSearchResults()));
    }

    public List<String> getAdvanceSearchResultsUserNames() {
        List<String> firstNameList =
                getElementsText(getElements(advancedSearchPO.getModalUsersSearchResultsFirstName()));
        List<String> lastNameList = getElementsText(getElements(advancedSearchPO.getModalUsersSearchResultsLastName()));
        List<String> userNames = new ArrayList<>();
        for (int i = 0; i < lastNameList.size(); i++) {
            String userName = firstNameList.get(i) + SPACE + lastNameList.get(i);
            userNames.add(userName);
        }
        return userNames;
    }

    public String getNextPageDisabledAttribute() {
        return getElement(advancedSearchPO.getNextPage()).getAttribute(DISABLED);
    }

    public String getGroupNameFieldActualName() {
        return getElement(advancedSearchPO.getModalUsersGroupGroupNameLabel()).getText();
    }

    private void clickRowsPerPage() {
        clickOn(advancedSearchPO.getRowsPerPage());
    }

    private void clickRowsPerPageMaxOption() {
        try {
            clickOn(xpath(format(advancedSearchPO.getRowsPerPageOption(), MAX_OPTION)));
        } catch (NoSuchElementException exception) {
            if (isElementDisplayed(xpath(format(advancedSearchPO.getRowsPerPageOption(), HALF_MAX_OPTION)))) {
                clickOn(xpath(format(advancedSearchPO.getRowsPerPageOption(), HALF_MAX_OPTION)));
            }
        }
    }

    public boolean isModalAddButtonEnabled() {
        return isElementEnabled(advancedSearchPO.getModalButtonAdd());
    }

    public boolean isModalAddButtonDisplayed() {
        return isElementDisplayed(advancedSearchPO.getModalButtonAdd());
    }

}
