package com.refinitiv.asts.test.ui.pageActions;

import com.refinitiv.asts.test.ui.pageObjects.ErrorPO;
import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import static com.refinitiv.asts.test.ui.constants.Pages.ERROR_PAGE;
import static java.lang.String.join;

public class ErrorPage extends BasePage<ErrorPage> {

    private final ErrorPO errorPO;

    public ErrorPage(WebDriver driver) {
        super(driver);
        errorPO = new ErrorPO();
    }

    @Override
    protected ExpectedCondition<ErrorPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return isElementDisplayed(waitLong, errorPO.getErrorPage());
    }

    @Override
    public void load() {

    }

    public void navigateToErrorPage() {
        this.driver.get(URL + ERROR_PAGE);
    }

    public void clickErrorPageLink() {
        clickOn(errorPO.getErrorPageLink());
    }

    public boolean isErrorPageLinkDisplayed() {
        return isElementDisplayed(errorPO.getErrorPageLink());
    }

    public String getErrorPageMessage() {
        return join(StringUtils.SPACE, getElementsText(errorPO.getErrorPageText()));
    }

}
