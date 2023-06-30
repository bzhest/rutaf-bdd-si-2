package com.refinitiv.asts.test.ui.pageObjects.setUp;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import static org.openqa.selenium.By.xpath;

@Getter
public class ThirdPartyFieldsPO extends BasePO {

    public ThirdPartyFieldsPO(WebDriver driver) {
        super(driver);
    }

    private final By thirdPartyFieldsSetUpMenuOption = xpath("//p[contains(text(),'Third-party Fields')]");
    private final By thirdPartyFieldsHeader = xpath("//h6[text()='Third-party fields']");
    private final By informationMessage = xpath("//span[@role='button']/parent::p");
    private final By saveButton = xpath("//span[text()='Save']/..");
    private final By resetButton = xpath("//span[text()='Reset']/..");
    private final String tableRow = "//p[text()='%s']/parent::div//tbody/tr";
    private final String tableRowName = "//p[text()='%s']/parent::div//tbody/tr/td/p";
    private final By dismissInformationMessageButton = xpath("//span[@role='button' and text()='Dismiss']");
    private final String checkboxActiveColumn = tableRowName +
            "[text()='%s']/../following-sibling::*[1]//input[@id='active']/../..";
    private final String checkboxRequiredColumn = tableRowName +
            "[text()='%s']/../following-sibling::*[2]//input[@id='required']/../..";
    private final By toastMessage = xpath("//div[@role='alert']");

}
