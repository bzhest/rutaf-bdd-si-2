package com.refinitiv.asts.test.ui.pageActions.thirdParty.dataproviders;

import com.refinitiv.asts.test.ui.pageObjects.thirdParty.dataproviders.BitSightPO;
import org.openqa.selenium.WebDriver;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import lombok.Getter;
import org.openqa.selenium.support.ui.ExpectedCondition;

@Getter
public class BitSightPage extends BasePage<BitSightPage> {
    private final BitSightPO bitSightPO;

    public BitSightPage(WebDriver driver) {
        super(driver);
        bitSightPO = new BitSightPO(driver);
    }

    @Override
    protected ExpectedCondition<BitSightPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return false;
    }

    @Override
    public void load() {

    }

    public boolean isBitSightTabDisplayed() {
        return isElementDisplayed(bitSightPO.getBitSightTab());
    }

    public String getSearchDateValue() {
        waitWhilePreloadProgressbarIsDisappeared();
        return getElementText(bitSightPO.getSearchDateValue());
    }

    public String getStatusValue() {
        waitWhilePreloadProgressbarIsDisappeared();
        return getElementText(bitSightPO.getStatusValue());
    }

    public boolean isBitSightRunButtonEnabled() {
        return isElementEnabled(bitSightPO.getRunButton());
    }

    public boolean isBitSightRunButtonDisplayed() {
        return isElementDisplayed(bitSightPO.getRunButton());
    }

    public void clickBitSightTab() {
        clickOn(bitSightPO.getBitSightTab(), waitLong);
    }
}