package com.refinitiv.asts.test.ui.pageObjects.thirdParty.dataproviders;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.xpath;

@Getter
public class BusinessOverviewPO extends BasePO {

    public BusinessOverviewPO(WebDriver driver) {
        super(driver);
    }

    private final By businessOverviewTab = xpath("//span[.='Business Overview']");
    private final By runButton = xpath("//span[.='Run']");
    private final String businessOverviewMessage = "//p[.='%s']";
    private final By searchDateValue = By.xpath("//*[contains(text(),'Search Date: ')]/span");

}
