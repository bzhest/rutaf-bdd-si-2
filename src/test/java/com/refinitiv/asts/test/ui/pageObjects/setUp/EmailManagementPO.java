package com.refinitiv.asts.test.ui.pageObjects.setUp;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class EmailManagementPO extends BasePO {

    public EmailManagementPO(WebDriver driver) {
        super(driver);
    }

    private final By emailNotificationTable = xpath("//*[text()='EMAIL MANAGEMENT']/..//table");
    private final String editRowButton = "//span[text()='%s']/ancestor::tr//*[contains(@class, 'MuiSvgIcon-root')]";
    private final String inputField = "//span[text()='%s']/../..//input | //legend/span[text()='%<s']/../../../input";
    private final By emailBody = cssSelector(".fr-element");
    private final By emailBodyParagraph = cssSelector(".fr-element p");
    private final String textStyle = "[data-cmd='%s']";
    private final String textAlign = "[data-cmd='align%s']";
    private final By quickInsert = cssSelector("[data-cmd='Insert Table']");
    private final By insertTableButton = cssSelector("[data-cmd='insertTable']");
    private final By selectTableButton =
            xpath("//*[@class='fr-select-table-size']/span[@tabindex='-1' and @data-row='2'][2]");
    private final By saveTemplateButton = id("save-new-third-party");
    private final By cancelTemplateButton = id("cancel-add-new-third-party");
    private final By tableRow = cssSelector("tbody>tr");
    private final By templateFields =
            xpath("//label[contains(@class, 'InputLabel')] | //*[@data-testid='active-input']/following-sibling::p");
    private final String rowTemplateName = "//tbody/tr[%s]/td[1]";
    private final String rowCategory = "//tbody/tr[%s]/td[2]";
    private final String rowStatus = "//tbody/tr[%s]/td[3]";
    private final String emailTemplatePage = "//*[@data-testid='header-email-text']/span[text()='%s']";
    private final By insertLinkButton = cssSelector("[data-cmd='insertLink']");
    private final By urlInput = xpath("//label[text()='URL']/preceding-sibling::input");
    private final By insertUrlButton = cssSelector("[data-cmd='linkInsert']");
    private final String boldText = "//strong[text()='%s']";
    private final String italicText = "//em[text()='%s']";
    private final String underlineText = "//u[text()='%s']";
    private final String textParagraphAlign = "//p[text()='%s' and @style='text-align: %s;']";
    private final By table = xpath("//table");
    private final String link = "//a[contains(@href,'%1$s')and text()='%1$s']";
    private final String text = "//p[text()='%s']";
    private final String errorMessage = "//span[text()='%s']/../../..//p";
    private final By activeCheckbox = id("active");

}
