package com.refinitiv.asts.test.ui.pageObjects.setUp.dueDilligenceOrder;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.id;
import static org.openqa.selenium.By.xpath;

@Getter
public class CustomRequiredFieldsPO extends BasePO {

    public CustomRequiredFieldsPO(WebDriver driver) {
        super(driver);
    }

    private final String requiredCheckbox = "//td//*[text()=\"%s\"]/ancestor::tr//input";
    private final By fieldNameColumn = xpath("//span[@aria-label=\"simple-table-sort-fieldName\"]");
    private final By saveCustomFieldsButton = id("customRequiredFieldsSaveButton");

}
