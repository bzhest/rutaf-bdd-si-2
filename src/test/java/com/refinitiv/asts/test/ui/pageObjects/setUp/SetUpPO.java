package com.refinitiv.asts.test.ui.pageObjects.setUp;

import lombok.Getter;
import org.openqa.selenium.By;

import static org.openqa.selenium.By.xpath;

@Getter
public class SetUpPO {

    public final By menuOptions =
            xpath("//*[contains(@class, 'MuiPaper-root')]/*[contains(@class, 'MuiBox-root')]/*[contains(@class, 'MuiPaper-root')]//p | //hr/following-sibling::p");
    public final String menuSection = "//p[text()='%s']/ancestor::div[@role='button']";
    public final String menuOption = "//p[text()='%s']";
    public final String menuSectionOption = "//*[text()='%s']/ancestor::div[@role='button']/parent::div//p[text()='%s']";

}
