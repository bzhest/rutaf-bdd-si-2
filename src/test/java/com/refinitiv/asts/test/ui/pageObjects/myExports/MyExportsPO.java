package com.refinitiv.asts.test.ui.pageObjects.myExports;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.xpath;

@Getter
public class MyExportsPO extends BasePO {

    public MyExportsPO(WebDriver driver) {
        super(driver);
    }

    public final String fileLink = "//td[7]//span[text()='%s'] | //td[7]//span[text()[contains(., '%<s')]]";
    public final String column = "//th//*[text()='%s']";
    public final By columns = xpath("//th");
    public final By message = xpath("//*[contains(@class, 'MuiTableContainer')]//h6");
    public final String summaryForStatus = "//td//*[text()='%s']/ancestor::td/following-sibling::td[1]";

}
