package com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;

@Getter
public class ActivityInformationCommentPO extends BasePO {

    public ActivityInformationCommentPO(WebDriver driver) {
        super(driver);
    }

    private final String commentsSection =
            "//*[text()='Comments']/ancestor::div[contains(@class, 'MuiButtonBase') and contains(@class, 'MuiAccordionSummary')]";
    private final By commentsSectionArrow = xpath(commentsSection + "//*[@focusable='false']");
    private final String commentActionButton = commentsSection + "/..//button/span[text()='%s']/..";
    private final By commentNextSection = xpath(commentsSection + "/../following-sibling::div");
    private final By commentTextarea = cssSelector("textarea#comment");
    private final String commentBlock = "//h6[text()='Comments:' or text()='COMMENTS']/parent::*/following-sibling::*";
    private final String commentBlockButton = commentBlock + "//button/span[text()='%s']";
    private final By commentsList = xpath(commentBlock + "/div[2]/p");
    private final String commentWithText = commentBlock + "//p[contains(text(), '%s')]";
    private final By author = cssSelector("p:nth-child(1)");
    private final By date = cssSelector("p:nth-child(2)");
    private final By comment = cssSelector("div:nth-child(2)>p");
    private final By edit = xpath("//button[@title='Edit']");
    private final By delete = xpath("//button[@title='Delete']");
    private final String commentAuthor = "(//p[text()='%s']/../../div/p)[1]";
    private final By commentCharacterLimitMessage = xpath("//*[@id=\"CommentsV2-container\"]/div[1]/div[1]/div/p/span");

}
