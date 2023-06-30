package com.refinitiv.asts.test.ui.pageObjects.commonPO;

import lombok.Data;
import org.openqa.selenium.By;

import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;

@Data
public class PaginationReactPO {

    private final By itemsPerPageDropdownInput =
            xpath("//*[@aria-label='pagination navigation']/ancestor::div[contains(@class, 'MuiTableContainer')]//input[not(@type='checkbox' or @type='radio')] " +
                          "| //td[contains(@class, 'MuiTablePagination')]//input | //*[@id='pagination-select']");
    private final By itemsPerPageDropdown =
            xpath("//*[@aria-label='pagination navigation']/ancestor::div[contains(@class, 'MuiTableContainer')]//input/preceding-sibling::*[not(@aria-disabled='true')] " +
                          "| //*[contains(@class, 'MuiTablePagination')]//*[@aria-haspopup='listbox']");
    private final By itemsPerPageOptions = cssSelector("li[class*=MuiListItem], li[class*=MuiTablePagination], [id='pagination-select']>option");
    private final By pagination = cssSelector("ul[class*='MuiPagination'],ul[class*='MuiMenu-list']");
    private final String itemsPerPageDropdownOption = "[role=listbox] [data-value='%s']";
    private final String paginationArrowButton = "button[aria-label*='%s']";
    private final By lastPage = cssSelector("[aria-label*='last page'], [ng-click='vm.event.lastPage()'].arrow");

    //Dashboard
    private final By rowsPerPageDropdown = cssSelector(".MuiTablePagination-input, div[class*='MuiSelect-selectMenu']:not([aria-labelledby]), [id^=RiskReport] div[class*='MuiSelect-selectMenu']");
    private final By nextPageButton = cssSelector("button[aria-label*='next page']");
    private final By previousPageButton = cssSelector("button[aria-label*='previous page']");
    private final By dropdownItems = cssSelector(".MuiMenuItem-gutters");
    private final By firstPageButton = cssSelector("[aria-label*='first page']");
    private final By currentPage = cssSelector("[aria-current='true']");

}
