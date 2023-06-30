package com.refinitiv.asts.test.ui.pageActions.thirdParty.dataproviders;

import com.refinitiv.asts.test.ui.pageObjects.thirdParty.dataproviders.BusinessOverviewPO;
import org.openqa.selenium.WebDriver;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import lombok.Getter;
import org.openqa.selenium.support.ui.ExpectedCondition;

import static java.lang.String.format;
import static org.openqa.selenium.By.xpath;

@Getter
public class BusinessOverviewPage extends BasePage<BusinessOverviewPage> {
    private final BusinessOverviewPO businessOverviewPO;

    public BusinessOverviewPage(WebDriver driver) {
        super(driver);
        businessOverviewPO = new BusinessOverviewPO(driver);
    }

    @Override
    protected ExpectedCondition<BusinessOverviewPage> getPageLoadCondition() {
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

    public boolean isBusinessOverviewTabDisplayed() {
        return isElementDisplayed(businessOverviewPO.getBusinessOverviewTab());
    }

    public String getSearchDateValue() {
        waitWhilePreloadProgressbarIsDisappeared();
        return getElementText(businessOverviewPO.getSearchDateValue());
    }

    public boolean isBusinessOverviewRunButtonEnabled() {
        return isElementEnabled(businessOverviewPO.getRunButton());
    }

    public boolean isBusinessOverviewMessageDisplayed(String message) {
        return isElementDisplayed(xpath(format(businessOverviewPO.getBusinessOverviewMessage(), message)));
    }

    public boolean isBusinessOverviewRunButtonDisplayed() {
        return isElementDisplayed(businessOverviewPO.getRunButton());
    }

}
