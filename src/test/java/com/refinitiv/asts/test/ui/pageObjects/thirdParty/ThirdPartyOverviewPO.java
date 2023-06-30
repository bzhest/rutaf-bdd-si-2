package com.refinitiv.asts.test.ui.pageObjects.thirdParty;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class ThirdPartyOverviewPO extends BasePO {

    private final By advanceSearch = id("overviewAdvancedSearchButton");
    private final By byRequiredCountryFieldIndicator =
            xpath("//span[contains(text(),'Country')]/..//following-sibling::div//span[text()='This field is required']");
    private final By addThirdPartyButton = id("overviewAddThirdPartyButton");
    private final By thirdPartyTable = cssSelector("table");
    private final By name = cssSelector("td:nth-child(1)");
    private final By industryType = cssSelector("td:nth-child(2)");
    private final By country = cssSelector("td:nth-child(3)");
    private final By status = cssSelector("td:nth-child(4)");
    private final String statusForThirdParty = "//*[text()='%s']/ancestor::tr//td[4]";
    private final By riskTier = cssSelector("td:nth-child(6)");
    private final By dateCreated = cssSelector("td:nth-child(7)");
    private final By lastUpdated = cssSelector("td:nth-child(8)");
    private final By screeningStatus = cssSelector("td:nth-child(9)");
    private final By edit = cssSelector("td:nth-child(10) [title=Edit]");
    private final By delete = cssSelector("td:nth-child(10) [title=Delete]");
    private final String editButton = "//*[text()='%s']/ancestor::tr//td//*[@title='Edit']";
    private final String header = "//div[contains(@class, 'MuiPaper')]//h6[contains(., '%s')]";
    private final String thirdPartyColumn = "//table//th//span[1][contains(.,'%s')]";
    private final String thirdPartyColumnHeader = "//span[text()='%s']/ancestor::th";
    private final By columnNamesList = cssSelector("th > span > span");
    private final By tableMessage = xpath("//*[contains(@class, 'MuiTableContainer')]//h6");
    private final String deleteButtonForSimilarNameThirdParty =
            "(//span[text()='%s']/../../..//*[@title='Delete'])[%d]";
    private final String thirdPartySectionField =
            "//p[text()='%s']/ancestor::div[contains(@class,'expanded') and (@role='button')]/following-sibling::div//*[text()='%s']";

    public ThirdPartyOverviewPO(WebDriver driver) {
        super(driver);
    }

}
