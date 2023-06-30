package com.refinitiv.asts.test.ui.pageActions;

import com.refinitiv.asts.test.ui.pageObjects.commonPO.ConfirmationWindowPO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static java.lang.String.format;
import static java.time.Duration.ofMillis;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated;

public class ConfirmationWindowPage extends BasePage<ConfirmationWindowPage> {

    private final ConfirmationWindowPO confirmationPO;
    public static final String NUMERATION = "(\\d. )";

    public ConfirmationWindowPage(WebDriver driver) {
        super(driver);
        confirmationPO = new ConfirmationWindowPO(driver);
    }

    public ConfirmationWindowPage(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
        confirmationPO = new ConfirmationWindowPO(driver, translator);
    }

    @Override
    protected ExpectedCondition<ConfirmationWindowPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    public String getConfirmationModalText() {
        return getElementText(waitShort, confirmationPO.getConfirmationModal());
    }

    public String getAlertModalText() {
        final String[] text = new String[1];
        try {
            WebDriverWait noWait = new WebDriverWait(driver, Duration.ofMillis(0));
            waitLong.pollingEvery(ofMillis(50)).until(driver -> {
                text[0] = getElementText(noWait, xpath(confirmationPO.getAlertDialog()));
                return Objects.nonNull(text[0]);
            });
            return text[0];
        } catch (TimeoutException ex) {
            return null;
        }
    }

    public List<String> getAlertModalActivityList() {
        return getElementsText(driver.findElements(confirmationPO.getModalActivityList())).stream()
                .map(activity -> activity.replaceAll(NUMERATION, StringUtils.EMPTY)).collect(
                        Collectors.toList());
    }

    @Override
    public boolean isPageLoaded() {
        return false;
    }

    public boolean isConfirmationModalDisplayed() {
        return isElementDisplayed(waitShort, confirmationPO.getConfirmationModal());
    }

    public boolean isConfirmationModalDisappeared() {
        return isElementDisappeared(waitShort, confirmationPO.getConfirmationModal());
    }

    public boolean isCloseModalButtonDisplayed() {
        return isElementDisplayed(confirmationPO.getCloseModalButton());
    }

    public String getCloseModalButtonName() {
        return getElementText(confirmationPO.getCloseModalButton());
    }

    public boolean isOkModalButtonDisplayed() {
        return isElementDisplayed(confirmationPO.getOkModalButton());
    }

    public String getOkModalButtonName() {
        return getElementText(confirmationPO.getOkModalButton());
    }

    public boolean isButtonWithTextDisplayed(String buttonText) {
        return isElementDisplayed(xpath(format(confirmationPO.getButtonWithText(), buttonText)));
    }

    public boolean isAlertDialogButtonDisplayed(String button) {
        return isElementDisplayed(xpath(format(confirmationPO.getAlertDialogButton(), button)));
    }

    public boolean isCrossIconDisplayed() {
        return isElementDisplayed(confirmationPO.getCrossIconButton());
    }

    @Override
    public void load() {
    }

    public void closeModal() {
        if (isOkModalButtonDisplayed()) {
            clickOn(confirmationPO.getOkModalButton());
        } else {
            clickOn(confirmationPO.getCloseNewModalButton());
        }
        waitShort.until(invisibilityOfElementLocated(confirmationPO.getConfirmationModal()));
    }

    public void clickCancelModalButton() {
        clickOn(confirmationPO.getCancelModalButton());
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void clickConfirmModalButton() {
        clickOn(confirmationPO.getConfirmModalButton(), waitMoment);
    }

    public void clickOkModalButton() {
        clickOn(confirmationPO.getCloseModalButton());
        waitShort.until(invisibilityOfElementLocated(confirmationPO.getConfirmationModal()));
    }

    public void clickOffboardModalButton() {
        clickOn(confirmationPO.getConfirmModalButton());
        waitShort.until(invisibilityOfElementLocated(confirmationPO.getConfirmationModal()));
    }

    public void clickAlertDialogButton(String button) {
        clickOn(xpath(format(confirmationPO.getAlertDialogButton(), button)), waitMoment);
    }

    public boolean isNoButtonDisplayed() {
        return isElementDisplayed(waitMoment, confirmationPO.getCancelModalButton());
    }

    public String getNoButtonName() {
        return getElementText(waitMoment, confirmationPO.getCancelModalButton());
    }

    public String getConfirmButtonName() {
        return getElementText(waitMoment, confirmationPO.getConfirmModalButton());
    }

    public boolean isConfirmButtonDisplayed() {
        return isElementDisplayed(waitMoment, confirmationPO.getConfirmModalButton());
    }

    public boolean verifyConfirmationButtonIsShown(String button) {
        switch (button) {
            case CANCEL:
            case NO:
                return isNoButtonDisplayed();
            case OFFBOARD_BUTTON:
            case DELETE:
            case REJECT:
            case PROCEED:
            case YES:
                return isConfirmButtonDisplayed();
            case CLOSE:
                return isCloseModalButtonDisplayed();
            case OK:
                return isOkModalButtonDisplayed();
            default:
                throw new IllegalArgumentException(button + " button element couldn't be found on modal window");
        }
    }

    public String getConfirmationButtonName(String button) {
        switch (button) {
            case CANCEL:
            case NO:
                return getNoButtonName();
            case OFFBOARD_BUTTON:
            case DELETE:
            case REJECT:
            case PROCEED:
            case YES:
                return getConfirmButtonName();
            case CLOSE:
                return getCloseModalButtonName();
            case OK:
                return getOkModalButtonName();
            default:
                throw new IllegalArgumentException(button + " button element couldn't be found on modal window");
        }
    }

}
