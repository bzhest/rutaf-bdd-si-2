package com.refinitiv.asts.test.ui.stepDefinitions.util;

import org.openqa.selenium.WebDriver;

import java.util.Set;

public class WindowsHandler {

    private final String parentWindow;
    private final WebDriver driver;

    public WindowsHandler(WebDriver driver) {
        this.driver = driver;
        this.parentWindow = driver.getWindowHandle();
    }

    public void switchToWindow(int windowNumber) {
        Set<String> windows = driver.getWindowHandles();
        String neededWindow = (String) windows.toArray()[windowNumber];
        driver.switchTo().window(neededWindow);
    }

    public void switchToParentWindow() {
        driver.switchTo().window(parentWindow);
    }

    public int getWindowsNumber() {
        return driver.getWindowHandles().size();
    }

    public void closeWindowsExceptParent() {
        driver.getWindowHandles().stream()
                .filter(window -> !window.equals(parentWindow))
                .forEach(window -> driver.switchTo().window(window).close());
        switchToParentWindow();
    }

}
