package com.refinitiv.asts.test.ui.pageObjects.home;

import lombok.Getter;
import org.openqa.selenium.By;

import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;

@Getter
public class NotificationPO {

    private final By notificationCounter =
            xpath("//*[@id='Main-HeaderLayout']//button//span[contains(@class, 'MuiBadge-badge')]");
    private final By notificationButton =
            xpath("//*[@data-qaid='supplier-notification-button' or contains(@class, 'MuiButtonBase-root MuiIconButton-root')]");
    private final String notification = "//*[text()='%s']//following-sibling::*//*[text()='%s']/ancestor::li";
    private final By notifications = xpath("//li[@role='menuitem']");
    private final By notificationsPopup = cssSelector("#Header-Notification-CustomPopper");
    private final By notificationList = xpath("//li[@role='menuitem']//p[contains(@class, 'body1')]");

}
