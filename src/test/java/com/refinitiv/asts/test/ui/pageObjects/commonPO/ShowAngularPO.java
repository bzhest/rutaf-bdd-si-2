package com.refinitiv.asts.test.ui.pageObjects.commonPO;

import lombok.Data;
import org.openqa.selenium.By;

import static org.openqa.selenium.By.cssSelector;

@Data
public class ShowAngularPO {

    private final By showDropDownButton = cssSelector(".filter-DropDown");
    private final By showOptions = cssSelector("li[data-qaid*=filter-and-seach]");
    private final By tableColumns = cssSelector("thead th");
    private final By tableRows = cssSelector("tbody tr");
    private final String tableRowColumnValue = "tbody tr>td:nth-child(%s)";
    private final String showDropDownOption =
            "//li[contains(@data-qaid, 'filter-and-seach') and contains(text(), '%s')]";
    private final By showDropDownCurrentOption = cssSelector("[data-qaid=filter-and-seach-dropdown]");

}
