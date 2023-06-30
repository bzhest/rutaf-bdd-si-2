package com.refinitiv.asts.test.ui.pageActions;

import com.google.common.base.Strings;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.core.framework.drivers.CreateDriver;
import com.refinitiv.asts.core.framework.drivers.DriverFactory;
import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.stepDefinitions.util.WindowsHandler;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import io.netty.karate.util.internal.StringUtil;
import lombok.Getter;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.openqa.selenium.*;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.interactions.MoveTargetOutOfBoundsException;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.lang.invoke.MethodHandles;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.function.Supplier;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.constants.PageElementNames.CHECKED;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.UNCHECKED;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.utils.AwaitUtil.await;
import static java.lang.String.format;
import static java.time.Duration.ofMillis;
import static java.util.Collections.shuffle;
import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.StringUtils.*;
import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public abstract class BasePage<T extends BasePage<T>> implements Page<T> {

    protected static final Logger logger = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());

    protected LanguageConfig translator;
    protected WebDriver driver;
    protected ScenarioCtxtWrapper context;
    protected Actions action;
    public static final String URL = Config.get().value("url");
    public final WebDriverWait waitLong = new WebDriverWait(CreateDriver.getInstance().getDriver(), Duration.ofSeconds(
            Long.parseLong(Config.get().value("wait.long"))));
    public final WebDriverWait waitShort = new WebDriverWait(CreateDriver.getInstance().getDriver(), Duration.ofSeconds(
            Long.parseLong(Config.get().value("wait.short"))));
    public final WebDriverWait waitMoment =
            new WebDriverWait(CreateDriver.getInstance().getDriver(), Duration.ofSeconds(
                    Long.parseLong(Config.get().value("wait.implicitly"))));
    private final BasePO basePO;
    @Getter
    private final WindowsHandler windowsHandler = new WindowsHandler(DriverFactory.getDriver());

    public BasePage(WebDriver driver) {
        synchronized (this) {
            this.driver = driver;
            this.basePO = new BasePO(driver);
            this.action = new Actions(this.driver);
            setImplicitWait(Long.parseLong(Config.get().value("wait.implicitly")));
        }
    }

    public BasePage(WebDriver driver, ScenarioCtxtWrapper context) {
        this(driver);
        this.context = context;
    }

    public BasePage(WebDriver driver, LanguageConfig translator) {
        this(driver);
        this.translator = translator;
    }

    public BasePage(WebDriver driver, ScenarioCtxtWrapper context, LanguageConfig translator) {
        this(driver, context);
        this.translator = translator;
    }

    public synchronized BasePage<T> get() {
        this.load();
        this.isPageLoaded();
        return this;
    }

    protected abstract ExpectedCondition<T> getPageLoadCondition();

    protected abstract String getPageTitle();

    public void clearAndInputField(By by, String text) {
        clearText(by);
        getElement(by).sendKeys(text);
    }

    public void clearAndInputField(WebElement inputElement, String text) {
        clearText(inputElement);
        inputElement.sendKeys(text);
    }

    public void clearInputAndEnterField(By elementLocator, String value) {
        clearInputAndEnterField(driver.findElement(elementLocator), value);
    }

    public void clearInputAndEnterField(WebElement inputElement, String value) {
        clearText(inputElement);
        inputElement.sendKeys(value);
        enterViaKeyboard(Keys.ARROW_DOWN);
        clickEnter();
    }

    public void clickEnter() {
        enterViaKeyboard(Keys.ENTER);
    }

    public void closeAlertIconIfDisplayed() {
        if (isCloseAlertIconButtonDisplayed()) {
            try {
                waitMoment.ignoring(StaleElementReferenceException.class)
                        .until(driver -> {
                            clickOn(basePO.getCloseAlertIcon());
                            return true;
                        });
            } catch (NoSuchElementException | TimeoutException ex) {
                logger.info("Alert Icon is disappeared");
            }
        }
    }

    public boolean isCloseAlertIconButtonDisplayed() {
        return isElementPresent(waitMoment, basePO.getCloseAlertIcon());
    }

    public void closeToastMessageIfDisplayed() {
        if (isElementDisplayedNow(basePO.getToastMessageCloseButton())) {
            clickOn(waitMoment.ignoring(StaleElementReferenceException.class)
                            .until(elementToBeClickable(basePO.getToastMessageCloseButton())));
        }
    }

    public void fillInText(By path, String value, WebDriverWait wait) {
        wait.until(visibilityOfElementLocated(path)).sendKeys(value);
    }

    public void fillInText(By path, String value) {
        driver.findElement(path).sendKeys(value);
    }

    public void selectText() {
        Keys controlKey = getControlKey();
        action.keyDown(controlKey).sendKeys("a").keyUp(controlKey).build().perform();
    }

    public void hoverOverElement(By elementLocator) {
        hoverOverElement(driver.findElement(elementLocator));
    }

    public void hoverOverElement(By elementLocator, WebDriverWait wait) {
        hoverOverElement(wait.ignoring(StaleElementReferenceException.class)
                                 .until(presenceOfElementLocated(elementLocator)));
    }

    public void hoverOverElement(WebElement element) {
        action.moveToElement(element)
                .pause(500)
                .build()
                .perform();
    }

    public boolean isElementEnabled(By elementLocator) {
        return isElementEnabled(getElement(elementLocator));
    }

    public boolean isElementEnabled(WebElement element) {
        try {
            scrollIntoView(element);
            return element.isEnabled();
        } catch (Exception e) {
            return false;
        }
    }

    public boolean isElementDisplayed(WebElement element) {
        try {
            scrollIntoView(element);
            return element.isDisplayed();
        } catch (Exception e) {
            return false;
        }
    }

    public boolean isElementDisplayed(WebDriverWait wait, WebElement element) {
        try {
            wait.until(visibilityOf(element));
            return true;
        } catch (TimeoutException ex) {
            return false;
        }
    }

    public boolean isElementDisplayed(WebDriverWait wait, By element) {
        try {
            return isElementDisplayed(wait.until(visibilityOfElementLocated(element)));
        } catch (TimeoutException ex) {
            return false;
        }
    }

    public boolean isElementDisappeared(WebDriverWait wait, By element) {
        try {
            wait.until(invisibilityOfElementLocated(element));
            return !isElementDisplayed(element);
        } catch (NoSuchElementException | StaleElementReferenceException e) {
            return true;
        } catch (TimeoutException ex) {
            return false;
        }
    }

    public boolean isElementDisappeared(WebDriverWait wait, WebElement element) {
        try {
            wait.until(invisibilityOf(element));
            return !isElementDisplayed(element);
        } catch (TimeoutException ex) {
            return false;
        }
    }

    public boolean isElementInvisible(WebDriverWait wait, String xpathLocator) {
        try {
            wait.until(ExpectedConditions.invisibilityOfElementLocated(xpath(xpathLocator)));
            return !isElementDisplayed(xpath(xpathLocator));
        } catch (TimeoutException e) {
            return false;
        }
    }

    public boolean isElementInvisible(WebDriverWait wait, By locator) {
        try {
            wait.until(ExpectedConditions.invisibilityOfElementLocated(locator));
            return !isElementDisplayed(locator);
        } catch (TimeoutException e) {
            return false;
        }
    }

    public boolean isElementContainsText(WebDriverWait wait, WebElement byElement, String text) {
        try {
            wait.until(textToBePresentInElement(byElement, text));
            return true;
        } catch (TimeoutException e) {
            return false;
        }
    }

    public boolean isElementDisplayed(By by) {
        try {
            WebElement element = driver.findElement(by);
            scrollIntoView(element);
            return element.isDisplayed();
        } catch (Exception e) {
            return false;
        }
    }

    public boolean isElementDisplayedNow(WebElement element) {
        try {
            setImplicitWaitToZero();
            scrollIntoView(element);
            return element.isDisplayed();
        } catch (Exception e) {
            return false;
        } finally {
            revertImplicitWaitToDefaults();
        }
    }

    public void waitElementIsClickable(WebElement element) {
        waitMoment.until(ExpectedConditions.elementToBeClickable(element));
    }

    public boolean isElementDisplayedNow(By by) {
        try {
            setImplicitWaitToZero();
            WebElement element = driver.findElement(by);
            scrollIntoView(element);
            return element.isDisplayed();
        } catch (Exception e) {
            return false;
        } finally {
            revertImplicitWaitToDefaults();
        }
    }

    public boolean isElementPresent(WebDriverWait wait, By by) {
        try {
            wait.until(presenceOfElementLocated(by));
            return isElementPresent(by);
        } catch (TimeoutException ex) {
            return false;
        }
    }

    public boolean isElementPresent(By by) {
        try {
            return nonNull(driver.findElement(by));
        } catch (Exception e) {
            return false;
        }
    }

    public boolean isAlertIconDisplayed() {
        return isElementPresent(waitLong, basePO.getAlertIconMessage());
    }

    public boolean isToastMessageDisappeared() {
        return isElementDisappeared(waitShort, basePO.getToastMessage());
    }

    public boolean isToastMessageCloseButtonDisplayed() {
        return isElementDisplayed(basePO.getToastMessageCloseButton());
    }

    public boolean isElementAttributeContains(WebElement element, String attribute, String value) {
        try {
            return waitMoment.until(attributeContains(element, attribute, value));
        } catch (TimeoutException e) {
            return false;
        }
    }

    public boolean isElementAttributeContains(By elementLocator, String attribute, String value) {
        return isElementAttributeContains(waitMoment, elementLocator, attribute, value);
    }

    public boolean isElementAttributeContains(WebDriverWait wait, By locator, String attribute, String value) {
        try {
            return wait.until(attributeContains(locator, attribute, value));
        } catch (TimeoutException e) {
            return false;
        }
    }

    public String getAlertIconText() {
        final String[] text = new String[1];
        try {
            WebDriverWait noWait = new WebDriverWait(driver, Duration.ofMillis(0));
            waitLong.pollingEvery(ofMillis(50)).until(driver -> {
                text[0] = getElementText(noWait, basePO.getAlertIconMessage());
                return Objects.nonNull(text[0]);
            });
            return text[0];
        } catch (TimeoutException ex) {
            return null;
        }
    }

    public List<String> getAlertsIconText() {
        try {
            waitLong.until(driver -> Objects.nonNull(getElementText(basePO.getAlertIconMessage())));
            return getElementsText(basePO.getAlertIconMessage());
        } catch (TimeoutException ex) {
            return new ArrayList<>();
        }
    }

    public String getAlertIconTextWithWait(String expectedText) {
        waitShort.until(textToBePresentInElement(driver.findElement(basePO.getAlertIconMessage()), expectedText));
        return getAlertIconText();
    }

    public WebElement findElementByXpath(WebDriverWait wait, String path) {
        return findElement(wait, xpath(path));
    }

    public WebElement findElement(WebDriverWait wait, By path) {
        return wait.until(ExpectedConditions.visibilityOfElementLocated(path));
    }

    /**
     * Supplier functional interface allows not to catch immediately Exception trying to locate an element,
     * but pass 'finding' action inside the method
     */
    public WebElement getElement(WebDriverWait wait, Supplier<WebElement> element) {
        try {
            wait.until(visibilityOf(element.get()));
            return element.get();
        } catch (NoSuchElementException | TimeoutException | StaleElementReferenceException | NullPointerException ex) {
            logger.info("WebElement wasn't found, " + ex.getClass().getSimpleName() + " was thrown");
            return null;
        }
    }

    public String getElementText(WebDriverWait wait, Supplier<WebElement> element, By childElement) {
        try {
            wait.until(driver -> !getElementText(element.get()).equals(EMPTY));
            return getElementText(element.get().findElement(childElement));
        } catch (NoSuchElementException | TimeoutException | StaleElementReferenceException | NullPointerException ex) {
            logger.info("WebElement wasn't found, " + ex.getClass().getSimpleName() + " was thrown");
            return null;
        }
    }

    public WebElement getElementByXPath(String path) {
        return getElement(xpath(path));
    }

    public WebElement getElement(By path) {
        try {
            return driver.findElement(path);
        } catch (NoSuchElementException e) {
            logger.error("Element is not found");
            return null;
        }
    }

    public List<WebElement> getElements(String path) {
        try {
            return driver.findElements(xpath(path));
        } catch (NoSuchElementException e) {
            logger.error("Elements are not found by XPath: " + path);
            return new ArrayList<>();
        }
    }

    public List<WebElement> getElements(By path) {
        try {
            return driver.findElements(path);
        } catch (NoSuchElementException e) {
            logger.error("Elements are not found by XPath: " + path.toString());
            return new ArrayList<>();
        }
    }

    public List<WebElement> getElements(WebDriverWait wait, By path) {
        try {
            wait.until(presenceOfElementLocated(path));
            return driver.findElements(path);
        } catch (NoSuchElementException | TimeoutException e) {
            logger.error("Elements are not found by XPath: " + path.toString());
            return new ArrayList<>();
        }
    }

    public String getCurrentUrl() {
        return driver.getCurrentUrl();
    }

    public void enterViaKeyboard(CharSequence... keys) {
        action.sendKeys(keys).build().perform();
    }

    public void clearText(By elementLocator) {
        clearText(driver.findElement(elementLocator));
    }

    public void clearText(WebElement textElement) {
        Keys controlKey = getControlKey();
        clickOn(textElement);
        action.keyDown(controlKey).sendKeys("a").keyUp(controlKey).build().perform();
        enterViaKeyboard(Keys.BACK_SPACE);
    }

    public void selectLastAddedText(String text) {
        moveToTheEndOfLine();
        for (int i = 0; i < text.length(); i++) {
            action.keyDown(Keys.LEFT_SHIFT).sendKeys(Keys.ARROW_LEFT).build().perform();
        }
        action.keyUp(Keys.LEFT_SHIFT).build().perform();
    }

    public void moveToTheEndOfLine() {
        selectText();
        enterViaKeyboard(Keys.RIGHT);
    }

    public void moveToTheEndOfText() {
        moveToTheEndOfLine();
        enterViaKeyboard(Keys.ENTER);
    }

    private Keys getControlKey() {
        String os = System.getProperty("os.name").toUpperCase();
        Keys controlKey;
        if (os.contains("MAC OS")) {
            controlKey = Keys.COMMAND;
        } else {
            controlKey = Keys.CONTROL;
        }
        return controlKey;
    }

    public void waitWhilePreloadProgressbarIsDisappeared() {
        try {
            if (isElementDisplayed(basePO.getPreloader())) {
                waitLong.until(ExpectedConditions.invisibilityOfElementLocated(basePO.getPreloader()));
            }
        } catch (NoSuchElementException | StaleElementReferenceException | ScriptTimeoutException ignored) {
        }
    }

    public void waitWhileSeveralPreloadProgressBarsAreDisappeared() {
        waitWhileSeveralPreloadProgressBarsAreDisappeared(3);
    }

    public void waitWhileSeveralPreloadProgressBarsAreDisappeared(int maxTries) {
        try {
            int count = 1;
            boolean isPreloaderDisplayed = isElementDisplayed(waitMoment, basePO.getPreloader());
            while (isPreloaderDisplayed && count++ <= maxTries) {
                waitLong.until(ExpectedConditions.invisibilityOfElementLocated(basePO.getPreloader()));
                isPreloaderDisplayed = isElementDisplayed(waitMoment, basePO.getPreloader());
            }
        } catch (NoSuchElementException | StaleElementReferenceException | TimeoutException | ScriptTimeoutException ignored) {
        }
    }

    public void waitWhilePreloadProgressBarsAreDisplayedAndDisappeared() {
        waitShort.until(visibilityOfElementLocated(basePO.getPreloader()));
        waitWhileSeveralPreloadProgressBarsAreDisappeared(5);
    }

    public void waitWhileLoadingImageIsDisappeared() {
        try {
            WebElement loadingImage = getElement(basePO.getLoadingImage());
            if (isElementDisplayedNow(loadingImage)) {
                waitLong.until(ExpectedConditions.invisibilityOf(loadingImage));
            }
        } catch (NoSuchElementException | StaleElementReferenceException ignored) {
        }
    }

    public boolean isAttributePresent(WebElement element, String attribute) {
        boolean result = false;
        try {
            ExpectedCondition<Boolean> elementPresence =
                    arg -> Objects.nonNull(element.getAttribute(attribute));
            waitMoment.until(elementPresence);
            result = true;
        } catch (NoSuchElementException | TimeoutException | StaleElementReferenceException ignored) {
        }
        return result;
    }

    public boolean isAttributePresent(By byElement, String attribute) {
        return isAttributePresent(driver.findElement(byElement), attribute);
    }

    public void waitForFieldAttributeValueUpdate(String elementXpath, String expectedText, String fieldName) {
        try {
            WebElement webElement = getElementByXPath(format(elementXpath, fieldName));
            waitMoment.until(attributeToBe(webElement, VALUE, expectedText));
        } catch (NoSuchElementException | TimeoutException | StaleElementReferenceException e) {
            WebElement webElement = getElementByXPath(format(elementXpath, fieldName));
            webElement.clear();
            waitMoment.until(attributeToBe(webElement, VALUE, EMPTY));
            webElement.sendKeys(expectedText);
        }
    }

    public boolean isSaveButtonDisappeared() {
        return isElementInvisible(waitLong, basePO.getSaveButton());
    }

    public boolean isTabOnScreeningPageAppear(String screeningTab) {
        By onScreeningTabXpath = xpath(format(basePO.getButton(), screeningTab));
        waitLong.until(ExpectedConditions.visibilityOfElementLocated(onScreeningTabXpath));
        return isElementDisplayedNow(onScreeningTabXpath);
    }

    public boolean isTabOnScreeningModalAppear(String screeningTab) {
        By onScreeningTabXpath = xpath(format(basePO.getTabOnModal(), screeningTab));
        return isElementDisplayedNow(onScreeningTabXpath);
    }

    public void selectDropDownWithRetry(By inputLocator, String value, String inputDropDownItem) {
        int count = 1;
        int maxTries = 6;
        WebElement inputDropDown = waitShort.until(visibilityOfElementLocated(inputLocator));
        while (!inputDropDown.getAttribute(VALUE).contains(value) && count++ <= maxTries) {
            clearAndFillInValueAndSelectFromDropDown(value, inputLocator, inputDropDownItem);
        }
    }

    public void clearAndFillInValueAndSelectFromDropDown(String inputValue, By inputFieldLocator,
            String matchedItemPath) {
        clearAndFillInValueAndSelectFromDropDown(inputValue, inputFieldLocator,
                                                 xpath(format(matchedItemPath, inputValue)));
    }

    public void clearAndFillInValueAndSelectFromDropDown(String inputValue, WebElement inputField,
            String matchedItemPath) {
        clearAndFillInValueAndSelectFromDropDown(inputValue, inputField, xpath(format(matchedItemPath, inputValue)));
    }

    public void clearAndFillInValueAndSelectFromDropDown(String inputValue, WebElement inputField) {
        clearAndFillInValueAndSelectFromDropDown(inputValue, inputField, basePO.getDropDownOption());
    }

    public void clearAndFillInValueAndSelectFromDropDown(String inputValue, By inputFieldLocator) {
        clearAndFillInValueAndSelectFromDropDown(inputValue, inputFieldLocator, basePO.getDropDownOption());
    }

    public void clearAndFillInValueAndSelectFromDropDown(String inputValue, By inputFieldLocator, By matchedItemPath) {
        if (nonNull(inputValue) && !inputValue.isEmpty()) {
            clearText(inputFieldLocator);
            fillInValueAndSelectFromDropDown(inputValue, inputFieldLocator, matchedItemPath);
        }
    }

    public void clearAndFillInValueAndSelectFromDropDown(String inputValue, WebElement inputField, By matchedItemPath) {
        if (nonNull(inputValue) && !inputValue.isEmpty()) {
            clearText(inputField);
            fillInValueAndSelectFromDropDown(inputValue, inputField, matchedItemPath);
        }
    }

    public void fillInValueAndSelectFromDropDown(String inputValue, By inputFieldLocator, By matchedItemPath) {
        fillInValueAndSelectFromDropDown(inputValue, driver.findElement(inputFieldLocator), matchedItemPath);
    }

    public void fillInValueAndSelectFromDropDown(String inputValue, WebElement inputField, By matchedItemPath) {
        if (nonNull(inputValue) && !inputValue.isEmpty()) {
            boolean isMatchedItemDisplayed = false;
            int count = 1;
            int maxTries = 10;
            inputField.sendKeys(inputValue);
            waitWhilePreloadProgressbarIsDisappeared();
            while (!isMatchedItemDisplayed && count++ <= maxTries) {
                try {
                    waitMoment.until(visibilityOfElementLocated(matchedItemPath));
                    isMatchedItemDisplayed = true;
                } catch (TimeoutException e) {
                    if (count == maxTries) {
                        throw new TimeoutException("Failed to find matched drop-down item \n " + e.getMessage());
                    }
                    clearAndInputField(inputField, inputValue);
                    waitWhilePreloadProgressbarIsDisappeared();
                    clickOn(inputField);
                }
            }
            try {
                waitShort.until(ExpectedConditions.visibilityOfElementLocated(matchedItemPath));
                clickOn(matchedItemPath);
            } catch (ElementNotInteractableException | StaleElementReferenceException e) {
                enterViaKeyboard(Keys.ARROW_DOWN);
                enterViaKeyboard(Keys.ENTER);
            }
        }
    }

    public void fillInDropDownWithRetry(By input, String value, String item) {
        int count = 1;
        int maxTries = 3;
        WebElement dropDownInput = driver.findElement(input);
        while (!dropDownInput.getAttribute(VALUE).equals(value) &&
                count++ <= maxTries) {
            clickOn(dropDownInput);
            clickOn(xpath(format(item, value)));
        }
    }

    public void selectRandomFromDropdown(WebDriverWait wait, By input, By dropdownOptions, String dropdownOption) {
        clickOn(input, waitShort);
        List<WebElement> options = getElements(wait, dropdownOptions);
        if (options.size() > 0) {
            shuffle(options);
            clickOn(waitMoment.until(
                    visibilityOfElementLocated(xpath(format(dropdownOption, getElementText(options.get(0)))))));
        }
    }

    public void selectAngularCheckbox(By locator, String status) {
        if (status != null) {
            switch (status.toLowerCase()) {
                case CHECKED:
                    if (isElementContainsCssValue(waitMoment, locator, BACKGROUND_POSITION, ANGULAR_CHECKBOX_CHECKED)) {
                        logger.info(getElementText(locator) + " is already checked");
                    } else {
                        tickFieldCheckbox(locator);
                    }
                    break;
                case UNCHECKED:
                    if (isElementContainsCssValue(waitMoment, locator, BACKGROUND_POSITION,
                                                  ANGULAR_CHECKBOX_UNCHEKED)) {
                        logger.info(getElementText(locator) + " is already unchecked");
                    } else {
                        tickFieldCheckbox(locator);
                    }
                    break;
                default:
                    throw new IllegalArgumentException("Checkbox status - " + status + " is unknown");
            }
        }
    }

    public void selectReactCheckbox(By locator, String status) {
        if (status != null) {
            switch (status.toLowerCase()) {
                case CHECKED:
                    if (isReactCheckboxChecked(locator)) {
                        logger.info(getElementText(locator) + " is already checked");
                    } else {
                        tickFieldCheckbox(locator);
                    }
                    break;
                case UNCHECKED:
                    if (!isReactCheckboxChecked(locator)) {
                        logger.info(getElementText(locator) + " is already unchecked");
                    } else {
                        tickFieldCheckbox(locator);
                    }
                    break;
                default:
                    throw new IllegalArgumentException("Checkbox status - " + status + " is unknown");
            }
        }
    }

    public void selectReactCheckbox(String checkboxLocator, String fieldName, String status) {
        By locator = By.xpath(format(checkboxLocator, fieldName));
        selectReactCheckbox(locator, status);
    }

    public void tickFieldCheckbox(String checkboxLocator, String fieldName) {
        clickOn(xpath(format(checkboxLocator, fieldName)));
    }

    public void tickFieldCheckbox(By checkbox) {
        clickOn(checkbox, waitMoment);
    }

    public boolean isCheckboxChecked(String checkboxLocator, String fieldName) {
        return getElementByXPath(format(checkboxLocator, fieldName)).isSelected();
    }

    public boolean isCheckboxChecked(String checkboxLocator) {
        return getElementByXPath(checkboxLocator).isSelected();
    }

    public boolean isCheckboxChecked(By checkboxLocator) {
        return getElement(checkboxLocator).isSelected();
    }

    public boolean isReactCheckboxChecked(String checkboxLocator, String fieldName) {
        return isReactCheckboxChecked(xpath(format(checkboxLocator, fieldName)));
    }

    public boolean isReactCheckboxChecked(By checkboxLocator) {
        return getAttributeValue(checkboxLocator, CLASS).contains(MUI_CHECKED);
    }

    public boolean isReactCheckboxChecked(WebDriverWait wait, By checkboxLocator) {
        return getAttributeValue(wait, checkboxLocator, CLASS).contains(MUI_CHECKED);
    }

    public boolean isReactFieldEnabled(By fieldLocator) {
        return !getAttributeValue(fieldLocator, CLASS).contains(MUI_DISABLED);
    }

    public boolean isReactFieldEnabled(String fieldLocator, String fieldName) {
        return isReactFieldEnabled(xpath(format(fieldLocator, fieldName)));
    }

    public void refreshPage() {
        driver.navigate().refresh();
    }

    public void openNewTab() {
        ((JavascriptExecutor) driver).executeScript(WINDOW_OPEN_SCRIPT);
    }

    public void switchToTab(int tabIndex) {
        ArrayList<String> tabsList = new ArrayList<>(driver.getWindowHandles());
        driver.switchTo().window(tabsList.get(tabIndex));
    }

    public List<String> getDropDownOptions() {
        waitShort.until(numberOfElementsToBeMoreThan(basePO.getDropDownItems(), 0));
        return getElementsText(driver.findElements(basePO.getDropDownItems()));
    }

    public List<String> getDropDownOptions(By elementLocator) {
        waitShort.until(numberOfElementsToBeMoreThan(elementLocator, 0));
        return getElementsText(driver.findElements(elementLocator));
    }

    public List<String> getDropDownOptions(By elementLocator, boolean isOptionDisabled) {
        waitShort.until(numberOfElementsToBeMoreThan(elementLocator, 0));
        return getElements(elementLocator).stream()
                .filter(element -> getAttributeValue(element, ARIA_DISABLED).equals(String.valueOf(isOptionDisabled)))
                .map(this::getElementText)
                .collect(Collectors.toList());
    }

    public void clickOn(WebElement element, WebDriverWait wait) {
        try {
            clickOn(wait.until(elementToBeClickable(element)));
        } catch (StaleElementReferenceException e) {
            wait.ignoring(StaleElementReferenceException.class)
                    .ignoring(RuntimeException.class)
                    .until(driver -> {
                        clickOn(element);
                        return true;
                    });
        }
    }

    public void clickOn(By by, WebDriverWait wait) {
        try {
            clickOn(wait.until(elementToBeClickable(by)));
        } catch (StaleElementReferenceException e) {
            wait.ignoring(StaleElementReferenceException.class)
                    .ignoring(RuntimeException.class)
                    .until(driver -> {
                        WebElement element = driver.findElement(by);
                        clickOn(element);
                        return true;
                    });
        }
    }

    public void clickOn(By by) {
        clickOn(driver.findElement(by));
    }

    public void clickOn(WebElement element) {
        try {
            element.click();
        } catch (RuntimeException e) {
            scrollIntoView(element);
            clickOnView(element);
        }
    }

    private void clickOnView(WebElement element) {
        try {
            element.click();
        } catch (RuntimeException e) {
            clickOnBottom(element);
        }
    }

    private void clickOnBottom(WebElement element) {
        try {
            element.click();
        } catch (RuntimeException e) {
            scrollIntoBottomView(element);
            clickOnWithAction(element);
        }
    }

    private void clickOnWithAction(WebElement element) {
        try {
            element.click();
        } catch (ElementNotInteractableException e) {
            scrollIntoView(element);
            clickWithJS(element);
        }
    }

    public void doubleClickOn(By by) {
        action.moveToElement(driver.findElement(by))
                .pause(500)
                .doubleClick()
                .build()
                .perform();
    }

    public String getErrorMessageOnFormField(String fieldName) {
        return getElementText(waitMoment.until(
                visibilityOfElementLocated(xpath(format(basePO.getFormFieldErrorMessage(), fieldName)))));
    }

    public String getToastMessageText(String headerText) {
        waitWhilePreloadProgressbarIsDisappeared();
        String textBeforeWait = getToastMessageText();
        if (!textBeforeWait.contains(headerText) || isEmpty(textBeforeWait)) {
            try {
                return waitShort.until(visibilityOfElementLocated(basePO.getToastMessage())).getText();
            } catch (TimeoutException e) {
                logger.error("Unexpected toast message text");
                return textBeforeWait;
            }
        }
        return textBeforeWait;
    }

    private String getToastMessageText() {
        return waitShort.ignoring(StaleElementReferenceException.class)
                .until(visibilityOfElementLocated(basePO.getToastMessageContent())).getText();
    }

    protected boolean isElementContainsCssValue(By elementLocator, String cssAttribute, String cssValue) {
        return isElementContainsCssValue(waitMoment.ignoring(StaleElementReferenceException.class)
                                                 .until(presenceOfElementLocated(elementLocator)), cssAttribute,
                                         cssValue);
    }

    public boolean isElementContainsCssValue(WebElement element, String cssAttribute, String cssValue) {
        return element.getCssValue(cssAttribute).equals(cssValue);
    }

    protected boolean isElementContainsCssValue(WebDriverWait wait, By elementLocator, String cssAttribute,
            String attributeValue) {
        try {
            wait.ignoring(StaleElementReferenceException.class)
                    .until(attributeToBe(getElement(elementLocator), cssAttribute, attributeValue));
        } catch (TimeoutException e) {
            logger.error(format("Unexpected CSS attribute '%s' value '%s'", cssAttribute, attributeValue));
            return false;
        }
        return true;
    }

    protected String getCssValue(By elementLocator, String cssValue) {
        return getCssValue(driver.findElement(elementLocator), cssValue);
    }

    protected String getCssValue(WebElement element, String cssValue) {
        return element.getCssValue(cssValue);
    }

    protected String getAttributeValue(By elementLocator, String attribute) {
        return getAttributeValue(driver.findElement(elementLocator), attribute);
    }

    protected String getAttributeValue(WebElement element, String attribute) {
        if (nonNull(element)) {
            String attributeValue = element.getAttribute(attribute);
            return isEmpty(attributeValue) ? null : attributeValue;
        }
        return null;
    }

    protected String getAttributeValue(WebDriverWait wait, By elementLocator, String attribute) {
        String attributeValue = wait.ignoring(StaleElementReferenceException.class)
                .until(driver -> driver.findElement(elementLocator).getAttribute(attribute));
        return isEmpty(attributeValue) ? null : attributeValue;
    }

    protected String getAttributeValueWithWait(WebDriverWait wait, By elementLocator, String attribute) {
        return findElement(wait, elementLocator).getAttribute(attribute);
    }

    protected String getAttributeValueWhenAppears(WebDriverWait wait, By elementLocator) {
        try {
            wait.until(driver -> getAttributeValue(elementLocator, VALUE) != null);
            return getAttributeValue(elementLocator, VALUE);
        } catch (TimeoutException ex) {
            return EMPTY;
        }
    }

    public String getElementText(WebElement element) {
        try {
            if (nonNull(element)) {
                String text = waitMoment.ignoring(StaleElementReferenceException.class)
                        .until(driver -> element.getText());
                return StringUtil.isNullOrEmpty(text) ? null : text.trim();
            }
        } catch (TimeoutException ex) {
            return null;
        }
        return null;
    }

    protected String getElementText(By elementLocator) {
        return getElementText(waitMoment, elementLocator);
    }

    protected String getElementText(WebDriverWait wait, By elementLocator) {
        if (nonNull(getElement(elementLocator))) {
            String text = wait.ignoring(StaleElementReferenceException.class)
                    .until(driver -> driver.findElement(elementLocator).getText());
            return StringUtil.isNullOrEmpty(text) ? null : text.trim();
        }
        return null;
    }

    protected String getElementText(WebDriverWait wait, WebElement element) {
        return getElementText(wait.ignoring(StaleElementReferenceException.class).until(visibilityOf(element)));
    }

    protected String getElementValue(By elementLocator) {
        return getAttributeValue(elementLocator, VALUE);
    }

    protected List<String> getElementsValue(By elementLocator) {
        return getElements(elementLocator).stream().map(this::getElementValue).collect(Collectors.toList());
    }

    protected String getElementValue(WebElement element) {
        return getAttributeValue(element, VALUE);
    }

    public List<String> getElementsText(List<WebElement> elements) {
        List<String> list = new ArrayList<>();
        for (WebElement element : elements) {
            String text = getElementText(element);
            if (!Strings.isNullOrEmpty(text) && !text.equals(SPACE)) {
                list.add(text);
            }
        }
        return list;
    }

    public List<String> getElementsText(WebDriverWait wait, List<WebElement> elements) {
        List<String> list = new ArrayList<>();
        for (WebElement element : elements) {
            String text = getElementText(wait, element);
            if (!Strings.isNullOrEmpty(text) && !text.equals(SPACE)) {
                list.add(text);
            }
        }
        return list;
    }

    public List<String> getElementsText(WebDriverWait wait, By elements) {
        List<String> list = new ArrayList<>();
        int elementsSize = getElements(wait, elements).size();
        IntStream.rangeClosed(0, elementsSize - 1).forEach(i -> {
            final String[] text = {null};
            wait.ignoring(StaleElementReferenceException.class)
                    .until(driver -> {
                        text[0] = getElements(elements).get(i).getText();
                        return true;
                    });
            if (!Strings.isNullOrEmpty(text[0]) && !text[0].equals(SPACE)) {
                list.add(text[0]);
            }
        });
        return list;
    }

    public List<String> getElementsText(By elementsLocator) {
        return getElementsText(waitMoment, elementsLocator);
    }

    public List<String> getElementsNonBlankTexts(List<WebElement> elements) {
        return elements.stream()
                .map(element -> getElementText(waitShort, element))
                .filter(text -> !isBlank(text))
                .collect(Collectors.toList());
    }

    public List<String> getElementsNonBlankTexts(By elements) {
        int size = getElements(elements).size();
        List<String> texts = new ArrayList<>();
        IntStream.rangeClosed(0, size - 1).forEach(i -> {
            String[] text = {null};
            waitShort.ignoring(StaleElementReferenceException.class).until(driver -> {
                text[0] = getElementText(getElements(elements).get(i));
                return true;
            });
            if (!isBlank(text[0])) {
                texts.add(text[0]);
            }
        });
        return texts;
    }

    public List<String> getElementsTextsWithBlank(By locator) {
        return getElementsTextsWithBlank(driver.findElements(locator));
    }

    public List<String> getElementsTextsWithBlank(List<WebElement> elements) {
        return elements.stream().map(WebElement::getText).collect(Collectors.toList());
    }

    protected String getElementTextWithWait(WebDriverWait wait, By elementLocator) {
        try {
            wait.until(invisibilityOfElementWithText(elementLocator, StringUtil.EMPTY_STRING));
            String text = driver.findElement(elementLocator).getText();
            return text.isEmpty() ? null : text.trim();
        } catch (TimeoutException e) {
            logger.error("Element with locator " + elementLocator + " contains empty text");
            return null;
        }
    }

    public boolean isFormFieldInError(String fieldName) {
        return isElementDisplayed(By.xpath(format(basePO.getFormFieldErrorMessage(), fieldName)));
    }

    public boolean isFieldHighlightedInRed(String fieldName) {
        return isElementDisplayed(By.xpath(format(basePO.getErrorHighlightedFormField(), fieldName)));
    }

    public boolean isFormFieldMandatory(String fieldName) {
        return isElementDisplayed(By.xpath(format(basePO.getRequiredFormField(), fieldName)));
    }

    public boolean areAllFieldsDisplayed(List<String> fieldNames, String elementLocator) {
        boolean areFieldsDisplayed = false;
        for (String fieldName : fieldNames) {
            if (isElementDisplayed(xpath(format(elementLocator, fieldName)))) {
                areFieldsDisplayed = true;
            } else {
                logger.info(fieldName + " field is not displayed");
                logger.info("Field locator " + format(elementLocator, fieldName));
                return false;
            }
        }
        return areFieldsDisplayed;
    }

    public String convertCanvasIntoString(By by) {
        return ((JavascriptExecutor) driver).executeScript(CANVAS_INTO_STRING, driver.findElement(by)).toString();
    }

    public String convertImageIntoString(By by) {
        return (String) ((JavascriptExecutor) driver).executeScript(IMAGE_INTO_STRING, driver.findElement(by));
    }

    public void scrollIntoView(WebElement element) {
        ((JavascriptExecutor) driver).executeScript(SCROLL_CENTER_SCRIPT, element);
    }

    public void scrollToElementBottom(WebElement element) {
        ((JavascriptExecutor) driver).executeScript(SCROLL_TO_ELEMENT_BOTTOM_SCRIPT, element);
    }

    public void scrollIntoView(By by) {
        scrollIntoView(driver.findElement(by));
    }

    public void scrollIntoBottomView(WebElement element) {
        ((JavascriptExecutor) driver).executeScript(SCROLL_BOTTOM_SCRIPT, element);
    }

    public void scrollIntoBottomView(By by) {
        scrollIntoView(driver.findElement(by));
    }

    public void scrollIntoCenterView(WebElement element) {
        ((JavascriptExecutor) driver).executeScript(SCROLL_ELEMENT_CENTER_SCRIPT, element);
    }

    public void scrollToTop() {
        ((JavascriptExecutor) driver).executeScript(SCROLL_TO_TOP_SCRIPT);
    }

    public void scrollToBottom() {
        ((JavascriptExecutor) driver).executeScript(SCROLL_TO_TOP_BOTTOM);
    }

    public void scrollToTop(WebElement windowElement) {
        ((JavascriptExecutor) driver).executeScript(SCROLL_TOP_SCRIPT, windowElement);
    }

    public void scrollToTop(By windowLocator) {
        scrollToTop(driver.findElement(windowLocator));
    }

    public void clickWithJS(WebElement element) {
        ((JavascriptExecutor) this.driver).executeScript(CLICK_SCRIPT, element);
    }

    public void waitForAngularPageIsLoaded() {
        ExpectedCondition<Boolean> requestAreDone = driver -> Boolean.parseBoolean(
                ((JavascriptExecutor) driver)
                        .executeScript(ANGULAR_CALLBACKS_SCRIPT)
                        .toString());
        try {
            waitShort.until(requestAreDone);
        } catch (JavascriptException exception) {
            logger.info("Angular is not attached to page document");
        }
    }

    public void moveToElement(WebElement element) {
        try {
            action.moveToElement(element)
                    .moveByOffset(0, 10)
                    .pause(500)
                    .build()
                    .perform();
        } catch (MoveTargetOutOfBoundsException e) {
            scrollIntoView(element);
        }
    }

    public void navigateToSpecificPage(String page) {
        driver.get(URL + page);
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void moveToElementAndClick(WebElement element) {
        action.moveToElement(element).click().perform();
    }

    public void moveToElementAndClick(WebElement element, long pause) {
        action.moveToElement(element).pause(pause).click().perform();
    }

    public void clickOnBlankArea() {
        clickOn(basePO.getBody());
    }

    public void clickBackBrowserButton() {
        driver.navigate().back();
    }

    public String getAttributeOrText(By elementLocator, String attribute) {
        return getAttributeOrText(driver.findElement(elementLocator), attribute);
    }

    public String getAttributeOrText(WebElement element, String attribute) {
        if (isNull(element)) {
            return null;
        }
        String attributeValue = getAttributeValue(element, attribute);
        return Strings.isNullOrEmpty(attributeValue) ? getElementText(element) : attributeValue;
    }

    public String getAttributeOrText(WebElement row, By valueLocator, String attribute) {
        WebElement elementInRow = row.findElement(valueLocator);
        return getAttributeOrText(elementInRow, attribute);
    }

    public void waitWhileUrlContains(String message, String expectedText) {
        await(message, 20, 1).until(() -> driver.getCurrentUrl().contains(expectedText));
    }

    public void waitUntilPageReady() {
        waitShort.until(webDriver -> ((JavascriptExecutor) webDriver).executeScript(RETURN_DOCUMENT_READY_STATE_SCRIPT)
                .equals(COMPLETE));
    }

    public String getRowChildElementText(By rowLocator, By childLocator) {
        return getRowChildElementText(getElement(rowLocator), childLocator);
    }

    public String getRowChildElementText(WebElement row, By childLocator) {
        final String[] text = {null};
        try {
            waitShort.ignoring(StaleElementReferenceException.class)
                    .until(driver -> {
                        text[0] = getElementText(row.findElement(childLocator));
                        return true;
                    });
            return text[0];
        } catch (TimeoutException e) {
            logger.error("Element for locator is not displayed");
        }
        return null;
    }

    public WebElement getChildElement(WebElement row, By childLocator) {
        try {
            return row.findElement(childLocator);
        } catch (Exception e) {
            return null;
        }
    }

    public String getFromDictionaryIfExists(String word) {
        return Arrays.stream(word.split(SPACE))
                .map(text -> !translator.getValue(text).equals(format(KEY_NOT_EXIST, text)) ?
                        translator.getValue(text) : text)
                .collect(Collectors.joining(SPACE));
    }

    public void closeTab(int tabIndex) {
        ArrayList<String> tabsList = new ArrayList<>(driver.getWindowHandles());
        driver.switchTo().window(tabsList.get(tabIndex));
        driver.close();
    }

    public String getTooltipText() {
        return getElementText(basePO.getTooltip());
    }

    public List<String> getTableHeaders() {
        waitShort.until(driver -> getElementsText(basePO.getTableHeaders()).size() > 0);
        return getElementsText(basePO.getTableHeaders());
    }

    public List<String> getListValuesForColumn(String columnName) {
        int columnIndex = getTableHeaders().indexOf(columnName.toUpperCase()) + 1;
        return getElementsTextsWithBlank(
                cssSelector(format(basePO.getCellsWithIndex(), columnIndex)));
    }

    protected void setImplicitWaitToZero() {
        setImplicitWait(0);
    }

    protected void revertImplicitWaitToDefaults() {
        setImplicitWait(Long.parseLong(Config.get().value("wait.implicitly")));
    }

    private void setImplicitWait(long duration) {
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(duration));
    }

}
