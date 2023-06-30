package com.refinitiv.asts.test.ui.pageObjects.home;

import lombok.Getter;
import org.openqa.selenium.By;

import static org.openqa.selenium.By.*;

@Getter
public class HomePO {

    private final By userMenu = cssSelector("#Header-Profile, .user");
    private final By userName = cssSelector("#Header-Profile h6");
    private final By preferencesButton = cssSelector("#preferences, #headerPreferencesExternal");
    private final By setUpButton = cssSelector("#setUp, #headerSetup");
    private final By myExportsButton = id("myExports");
    private final By logOutButton = cssSelector("#logOut, #headerLogout");
    private final By menuItems = xpath("//*[@id='menu-list-grow' or @class='menu-item']//li");
    private final By avatar = xpath("//*[contains(@class, 'MuiAvatar-root')]/img");
    private final By headerText =
            xpath("//*[@id='Header-Profile']//h6 | //*[@class='user']//*[contains(@class, 'name')]");
    private final By photo =
            xpath("//*[@class='picture pull-right'] | //*[contains(@class, 'MuiAvatar-root')] | //*[@id='Header-Profile']//*[contains(@class, 'MuiSvgIcon-root')]");
    private final By homeTab = xpath("//span[text()='Home']");
    private final By noticeBoardTitle = id("notice-board-title");
    private final By confirmCheckbox = xpath("//input[@type='checkbox']/..");
    private final By nextButton = xpath("//span[text()='Next']/ancestor::button");
    private final By acceptButton = xpath("//span[text()='Accept']/ancestor::button");
    private final By legalNoticeContent = id("notice-board-content");
    private final By errorContent = cssSelector(".error-content, #root>div>div");
    private final By refinitivLogo = xpath("//*[@id='Main-HeaderLayout']/div/div/div/div[1]/img");
    private final By footerDetails = xpath("//p[contains(@class,'-body')]");
    private final By footerLink = xpath("//*[@id='root']//a[contains(@href, 'policies')]");
    private final By backToHomeButton =
            xpath("//button[@ng-click='vm.EVENTS.onClick.backToHome()' or @id='back-button']");
    private final By helpSubMenu = id("help");
    private final String subMenu = "//*[text()='%s']/ancestor::li[@role='menuitem']";
    private final String helpValues = "//p[text()='%s']";
    private final By homePageButtons = xpath("//*[@id='Layout-HeaderButtons']//a//span");
    private final String homePageButton = "//*[@id='Layout-HeaderButtons']//a//span[text()='%s']";

}
