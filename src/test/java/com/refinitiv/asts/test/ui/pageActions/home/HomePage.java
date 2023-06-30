package com.refinitiv.asts.test.ui.pageActions.home;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.home.HomePO;
import com.refinitiv.asts.test.ui.utils.ImageUtil;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.List;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.VERSION;
import static com.refinitiv.asts.test.ui.constants.Pages.HOME;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.pageActions.setUp.CountryChecklistPage.dimensionWithPixelRatio_1_25;
import static java.lang.String.format;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class HomePage extends BasePage<HomePage> {

    private final HomePO homePO;

    public HomePage(WebDriver driver, ScenarioCtxtWrapper context) {
        super(driver, context);
        homePO = new HomePO();
    }

    @Override
    protected ExpectedCondition<HomePage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        boolean isHomePageLoaded = false;
        int count = 1;
        int maxTries = 3;
        while (!isHomePageLoaded && count++ <= maxTries) {
            if (!isElementDisplayed(waitShort, homePO.getUserMenu())) {
                driver.navigate().refresh();
            } else {
                isHomePageLoaded = true;
            }
        }
        return isHomePageLoaded;
    }

    public boolean isRefinitivLogoDisplayed() {
        return isElementDisplayed(homePO.getRefinitivLogo());
    }

    public boolean isPageOnReact() {
        return isElementAttributeContains(homePO.getUserMenu(), ID, HEADER_PROFILE);
    }

    public boolean isPhotoPlaceholderDisplayed() {
        return isElementDisplayed(homePO.getPhoto());
    }

    public boolean isNoticeBoardDisplayed() {
        return isElementDisplayed(waitMoment, homePO.getNoticeBoardTitle());
    }

    public boolean isBackHomeButtonDisplayed() {
        return isElementDisplayed(waitShort, homePO.getBackToHomeButton());
    }

    @Override
    public void load() {

    }

    public void navigateToHomePage() {
        this.driver.get(URL + HOME);
    }

    public void clickSetUpMenu() {
        waitMoment.until(ExpectedConditions.elementToBeClickable(homePO.getUserName()));
        clickOn(homePO.getUserName(), waitShort);
        moveToElementAndClick(getElement(homePO.getSetUpButton()));
    }

    public void clickMyExportsMenu() {
        waitMoment.until(ExpectedConditions.elementToBeClickable(homePO.getUserName()));
        clickOn(homePO.getUserName());
        moveToElementAndClick(getElement(homePO.getMyExportsButton()));
    }

    public void clickUserName() {
        clickOn(homePO.getUserName());
    }

    public void hoverUserMenu() {
        hoverOverElement(homePO.getUserName());
    }

    public void clickPreferences() {
        clickOn(homePO.getPreferencesButton(), waitShort);
    }

    public void clickLogOutButton() {
        if (isPageOnReact()) {
            clickOn(homePO.getUserMenu(), waitMoment);
        } else {
            hoverOverElement(homePO.getUserMenu());
        }
        clickOn(homePO.getLogOutButton(), waitShort);
    }

    public void clickFooterLink() {
        clickOn(homePO.getFooterLink());
    }

    public void clickBackToHomeButton() {
        clickOn(waitShort.until(visibilityOfElementLocated(homePO.getBackToHomeButton())));
    }

    public void clickHomePage() {
        clickOn(homePO.getHomeTab());
    }

    public void clickConfirmCheckbox() {
        waitWhilePreloadProgressbarIsDisappeared();
        if (isElementDisplayed(homePO.getNextButton()) || isElementDisplayed(homePO.getAcceptButton())) {
            try {
                waitMoment.ignoring(StaleElementReferenceException.class)
                        .until(driver -> {
                            clickOn(homePO.getConfirmCheckbox());
                            logger.info("Checkbox is checked");
                            return true;
                        });
            } catch (TimeoutException ex) {
                logger.info("Checkbox is disappeared");
            }
        }
    }

    public void scrollLegalNoticeContentBottom() {
        if (isElementDisplayed(homePO.getNextButton()) || isElementDisplayed(homePO.getAcceptButton())) {
            try {
                hoverOverElement(homePO.getLegalNoticeContent());
                scrollToElementBottom(getElement(homePO.getLegalNoticeContent()));
            } catch (Exception ignored) {
                logger.info("Unable to scroll legal notice bottom");
            }
        }
    }

    public void clickNextButtonIfDisplayed() {
        if (isElementDisplayed(homePO.getNextButton())) {
            try {
                clickOn(homePO.getNextButton(), waitMoment);
                logger.info("Next button clicked");
            } catch (TimeoutException ignored) {
                logger.info("Next button is already disappeared");
            }
        }
    }

    public boolean clickAcceptButtonIfDisplayed() {
        if (isElementDisplayed(homePO.getAcceptButton())) {
            try {
                clickOn(homePO.getAcceptButton(), waitMoment);
                logger.info("Accept button clicked");
                return true;
            } catch (TimeoutException ignored) {
                logger.info("Accept button is already disappeared");
                return true;
            }
        } else {
            return false;
        }
    }

    public List<String> getUserMenuItems() {
        List<String> elementsText = getElementsText(driver.findElements(homePO.getMenuItems()));
        if (elementsText.size() == 0) {
            clickUserName();
            return getElementsText(waitMoment.until(numberOfElementsToBeMoreThan(homePO.getMenuItems(), 0)));
        }
        return elementsText;
    }

    public List<String> getHomePageButtonsNames() {
        return getElementsText(homePO.getHomePageButtons());
    }

    public String getErrorText() {
        waitMoment.until(driver -> getElementText(homePO.getErrorContent()) != null);
        return getElementText(homePO.getErrorContent());
    }

    public String getAvatarLocation() {
        return getAttributeValue(homePO.getAvatar(), SRC);
    }

    public String getHeaderText() {
        return getElementText(waitShort, homePO.getHeaderText());
    }

    public String getFooterText() {
        return getElementText(homePO.getFooterDetails());
    }

    public void saveVersionToContext() {
        if (!context.getScenarioContext().isContains(VERSION)) {
            WebElement versionLabel = driver.findElements(homePO.getFooterDetails()).get(2);
            String version = versionLabel.getText();
            context.getScenarioContext().setContext(VERSION, version);
        }
    }

    public void hoverToHelp() {
        hoverOverElement(homePO.getHelpSubMenu());
    }

    public void hoverOverSubMenuItem(String name) {
        hoverOverElement(xpath(format(homePO.getSubMenu(), name)));
    }

    public String getSubMenuItemColor(String name) {
        return getCssValue(xpath(format(homePO.getSubMenu(), name)), BACKGROUND_COLOR);
    }

    public void selectFromHelp(String value) {
        clickOn(xpath(format(homePO.getHelpValues(), value)));
    }

    public boolean isHelpOptionDisplayed(String value) {
        return isElementDisplayed(xpath(format(homePO.getHelpValues(), value)));
    }

    public void hoverOverHomePageButton(String buttonName) {
        hoverOverElement(xpath(format(homePO.getHomePageButton(), buttonName)));
    }

    public String getHomePageButtonColor(String buttonName) {
        return getCssValue(xpath(format(homePO.getHomePageButton(), buttonName)), COLOR);
    }

    public void clickOnHomePageButton(String buttonName) {
        clickOn(xpath(format(homePO.getHomePageButton(), buttonName)));
    }

    public boolean isAvatarImageCorrect(String filePath, String fileName) {
        driver.manage().window().setPosition(new Point(0, 0));
        driver.manage().window().setSize(dimensionWithPixelRatio_1_25);
        WebElement avatar = getElement(homePO.getPhoto());
        return ImageUtil.isImageCorrect(filePath, fileName, avatar);
    }

    public boolean isMenuItemsListDisappeared() {
        return isElementDisappeared(waitMoment, homePO.getMenuItems());
    }

    public boolean isHeaderTextAppeared(String expectedText) {
        try {
            return waitShort.until(ExpectedConditions.textToBe(homePO.getHeaderText(), expectedText));
        } catch (TimeoutException timeoutException) {
            return false;
        }
    }

}