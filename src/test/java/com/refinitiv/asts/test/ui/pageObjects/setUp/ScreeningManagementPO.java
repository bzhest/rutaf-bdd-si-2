package com.refinitiv.asts.test.ui.pageObjects.setUp;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class ScreeningManagementPO extends BasePO {

    public ScreeningManagementPO(WebDriver driver) {
        super(driver);
    }

    private final String screeningSettingsIsTurnedOn = "//p[text()='%s']/..//span[contains(@class,'Mui-checked')]";
    private final String toggleButton = "//p[text()='%s']/following-sibling::span[contains(@class, 'MuiSwitch')]";
    private final By cancelButton = id("screening-management-cancel-button");
    private final By saveButton = id("screening-management-save-button");
    private final By screeningSettingsAlertMessage = xpath("//div[@class='MuiAlert-message']");
    private final By enableScreeningAssociatedPartyToggle = name("ENABLE_SCREENING_NEW_ASSOCIATED_PARTY");
    private final By enableScreeningThirdPartyToggle = name("ENABLE_SCREENING_NEW_THIRDPARTY");
    private final By enableOngoingScreeningToggle = name("ENABLE_WORLDCHECK_AND_CUSTOM_WATCHLIST");
    private final By screeningManagementUnderDDOrder =
            xpath("//p[text()='Due Diligence Order Management']/../../../../p[2]");
    private final By pageHeader = xpath("//h6[text()='SCREENING MANAGEMENT']");

}