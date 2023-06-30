package com.refinitiv.asts.test.ui.pageObjects.commonPO;

import lombok.Data;
import org.openqa.selenium.By;

import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;

@Data
public class PaginationAngularPO {

    private final By itemsPerPageDropdown = xpath("//*[@data-qaid='paginator-page-limit-dropdown'] " +
                                                          "| //*[contains(@class, 'MuiTablePagination-select MuiSelect-selectMenu')]");
    private final By itemsPerPageOptions = xpath("//*[@data-qaid='paginator-page-limit-dropdown']//option " +
                                                         "| //*[contains(@class, 'MuiTablePagination-menuItem')]");
    private final By pagination = cssSelector("[class*='pagination']>ul");
    private final By numberedPage = cssSelector("[ng-click='vm.event.setPage(i)']");
    private final String itemsPerPageDropdownOption = "[data-qaid*='paginator-page-limit-dropdown']>option[label='%s']";
    private final String paginationArrowButton = "[ng-click*='%s'][class*='arrow']";
    private final By paginationSelectedOption = xpath("//*[@data-qaid='paginator-page-limit-dropdown']");

}
