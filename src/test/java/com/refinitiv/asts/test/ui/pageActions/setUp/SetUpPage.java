package com.refinitiv.asts.test.ui.pageActions.setUp;

import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.SetUpPO;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;

import static com.refinitiv.asts.test.ui.constants.TestConstants.ARIA_EXPANDED;
import static java.lang.Boolean.parseBoolean;
import static java.lang.String.format;
import static org.openqa.selenium.By.xpath;

public class SetUpPage extends BasePage<SetUpPage> {

    private final SetUpPO setUpPO;

    public SetUpPage(WebDriver driver) {
        super(driver);
        setUpPO = new SetUpPO();
    }

    @Override
    protected ExpectedCondition<SetUpPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    public String getNavigationOptionCssValue(String option, String cssAttribute) {
        return getCssValue(xpath(format(setUpPO.getMenuOption(), option)), cssAttribute);
    }

    @Override
    public boolean isPageLoaded() {
        return false;
    }

    public boolean isNavigationSectionButtonExpanded(String sectionName) {
        return parseBoolean(
                getAttributeValue(xpath(format(setUpPO.getMenuSection(), sectionName)), ARIA_EXPANDED));
    }

    public boolean isNavigationOptionDisplayed(String option) {
        return isElementDisplayed(waitShort, xpath(format(setUpPO.getMenuOption(), option)));
    }

    public boolean isSectionOptionDisplayed(String section, String option) {
        return isElementDisplayed(xpath(format(setUpPO.getMenuOption(), section, option)));
    }

    @Override
    public void load() {

    }

    public void clickOption(String option) {
        clickOn(xpath(format(setUpPO.getMenuOption(), option)));
    }

    public void clickNavigationSectionButton(String sectionName) {
        clickOn(xpath(format(setUpPO.getMenuSection(), sectionName)));
    }

    public void hoverNavigationOptionButton(String option) {
        hoverOverElement(xpath(format(setUpPO.getMenuOption(), option)), waitLong);
    }

    public List<String> getNavigationMenuOptions() {
        return getElementsText(setUpPO.getMenuOptions());
    }

}
