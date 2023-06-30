package com.refinitiv.asts.test.ui.pageActions.home;

import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.home.NotificationPO;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.regex.Pattern;

import static com.refinitiv.asts.test.ui.constants.TestConstants.CLASS;
import static com.refinitiv.asts.test.ui.constants.TestConstants.INVISIBLE;
import static java.lang.Integer.parseInt;
import static java.lang.String.format;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class NotificationPage extends BasePage<NotificationPage> {

    public static final String MORE_THAN_ZERO_REGEX = "(^[1-9]\\d*)";
    public static final String PLUS = "+";
    private final NotificationPO notificationPO;

    public NotificationPage(WebDriver driver) {
        super(driver);
        notificationPO = new NotificationPO();
    }

    @Override
    protected ExpectedCondition<NotificationPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    public List<String> getNotificationList() {
        return getElementsText(driver.findElements(notificationPO.getNotificationList()));
    }

    public int getNotificationCounter() {
        try {
            waitLong.until(textMatches(notificationPO.getNotificationCounter(), Pattern.compile(MORE_THAN_ZERO_REGEX)));
            return parseInt(getElementText(notificationPO.getNotificationCounter()).replace(PLUS, EMPTY));
        } catch (TimeoutException e) {
            return 0;
        }

    }

    public int getNotificationsCount() {
        return driver.findElements(notificationPO.getNotifications()).size();
    }

    public boolean isNotificationsPopupClosed() {
        return isElementDisappeared(waitShort, notificationPO.getNotificationsPopup());
    }

    public boolean isNotificationPopupDisplayed() {
        return isElementDisplayed(waitShort, notificationPO.getNotificationsPopup());
    }

    @Override
    public boolean isPageLoaded() {
        return false;
    }

    public boolean isNotificationDisplayed(String notification, String activity) {
        return isElementDisplayed(xpath(format(notificationPO.getNotification(), notification, activity)));
    }

    public boolean isNotificationCounterInvisible() {
        return waitLong.until(attributeContains(notificationPO.getNotificationCounter(), CLASS, INVISIBLE));
    }

    @Override
    public void load() {

    }

    public void clickNotificationButton() {
        clickOn(notificationPO.getNotificationButton(), waitLong);
    }

    public boolean isNotificationBellDisplayed() {
        return isElementDisplayed(waitShort, notificationPO.getNotificationButton());
    }

    public void clickNotification(String notification, String activity) {
        clickOn(xpath(format(notificationPO.getNotification(), notification, activity)), waitMoment);
    }

}
