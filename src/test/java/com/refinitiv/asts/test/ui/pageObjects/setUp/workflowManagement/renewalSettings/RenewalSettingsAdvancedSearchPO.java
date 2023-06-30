package com.refinitiv.asts.test.ui.pageObjects.setUp.workflowManagement.renewalSettings;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class RenewalSettingsAdvancedSearchPO extends BasePO {

    private final String modalUsers = "//*[contains(text(), '%s')]";
    private final By modalButtonSearch = xpath("//*[@role='dialog']//*[text()='Search']/ancestor::button");
    private final By modalButtonSearchLabel =
            cssSelector("button#advancedSearchSuccessButton [class^=MuiButton-label]");
    private final By modalButtonCancel = xpath("//*[@role='dialog']//*[text()='Cancel']/ancestor::button");
    private final By modalButtonCancelLabel =
            cssSelector("button#advancedSearchCancelButton [class^=MuiButton-label]");
    private final By rowsPerPage = xpath("//*[@role='button' and @aria-haspopup='listbox']");
    private final String rowsPerPageOption = "//li[@data-value='%s']";
    private final By nextPage = cssSelector("button[aria-label$='next page']");
    private final By lastPage = cssSelector("button[aria-label$='last page']");
    private final By noMatchFoundMessage = xpath("//h6[text()='No Match Found']");
    private final By radioButtons = cssSelector("[aria-label*=table] input[type=radio]");
    private final By modalButtonAdd = xpath("//*[@role='dialog']//*[text()='Add']/ancestor::button");
    private final By modalSearchResults = cssSelector("[aria-label=simple-table-body-row]");
    private final By modalSearchHeader = cssSelector("thead tr");

    //Advanced Search - Users
    private final By modalUsersFirstName = cssSelector("#advancedSearch-firstName");
    private final By modalUsersFirstNameLabel = cssSelector("label[for=advancedSearch-firstName]>span");
    private final By modalUsersLastName = cssSelector("#advancedSearch-lastName");
    private final By modalUsersLastNameLabel = cssSelector("label[for=advancedSearch-lastName]>span");
    private final By modalUsersSearchResultsFirstName =
            cssSelector("[aria-label=simple-table-body-row]>td:nth-child(2)>span");
    private final By modalUsersSearchResultsLastName =
            cssSelector("[aria-label=simple-table-body-row]>td:nth-child(3)>span");

    //Advanced Search - Users Group
    private final By modalUsersGroupGroupName = cssSelector("#advancedSearch-groupName");
    private final By modalUsersGroupGroupNameLabel = cssSelector("[for=advancedSearch-groupName]>span");

    public RenewalSettingsAdvancedSearchPO(WebDriver driver) {
        super(driver);
    }

}
