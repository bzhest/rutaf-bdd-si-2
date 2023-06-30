package com.refinitiv.asts.test.ui.pageObjects.thirdParty.dataproviders;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.xpath;

@Getter
public class BitSightPO extends BasePO {

    public BitSightPO(WebDriver driver) {
        super(driver);
    }

    private final By bitSightTab = xpath("//span[.='BitSight']");
    private final By runButton = xpath("//span[.='Run']");
    private final By searchDateValue = By.xpath("//*[contains(text(),'Search Date')]/span");
    private final By statusValue = By.xpath("//span[text()='BitSight']/ancestor::div[@variant='outlined'][1]//p[contains(text(), 'Status')]");

}