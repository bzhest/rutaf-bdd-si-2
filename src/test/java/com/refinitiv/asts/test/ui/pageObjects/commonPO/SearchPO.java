package com.refinitiv.asts.test.ui.pageObjects.commonPO;

import lombok.Data;
import org.openqa.selenium.By;

import static org.openqa.selenium.By.cssSelector;

@Data
public class SearchPO {

    private final By searchField = By.xpath("//input[contains(@id,'search')]");
    private final By searchButton = By.xpath("//input[contains(@id,'search')]/..//button");
    private final By tableRows = By.cssSelector("tbody tr");

}
