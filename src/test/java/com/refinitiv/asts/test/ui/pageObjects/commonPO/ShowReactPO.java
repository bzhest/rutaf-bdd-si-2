package com.refinitiv.asts.test.ui.pageObjects.commonPO;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.cssSelector;

@Getter
public class ShowReactPO extends BasePO {

    private final By showDropDownButton = By.xpath(
            "//*[@id='actionsFilterSelect'] | //*[@aria-labelledby='third-party-filter-select'] | " +
                    "//*[@aria-haspopup='listbox' and contains(@aria-labelledby, 'filter')] | //*[@aria-haspopup='listbox']");
    private final By showOptions = cssSelector("li[class*=MuiListItem]");
    private final String showDropDownOption =
            "//*[@role='listbox']/li[@data-value='%s'] | //*[@role='listbox']/li[contains(text(), '%<s')]";
    private final String showDropDown = "//*[@role='listbox']";
    private final By showDropDownCurrentOption =
            cssSelector("[aria-labelledby*=filter-select], [aria-labelledby='actionsFilterSelect'] + input");
    private final By tableRows = cssSelector("tbody tr");
    private final By tableHeaders = cssSelector("[role=columnheader]");
    private final By tableCells = cssSelector("[role=cell]");

    public ShowReactPO(WebDriver driver) {
        super(driver);
    }

}
