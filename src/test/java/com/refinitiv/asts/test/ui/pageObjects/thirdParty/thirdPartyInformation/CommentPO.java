package com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class CommentPO extends BasePO {

    public CommentPO(WebDriver driver) {
        super(driver);
    }

    private final By commentField = id("comment");
    private final By commentButton = xpath("//span[contains(text(), 'Comment')]/ancestor::button");
    private final By editCommentButton = xpath("//*[@title='Edit']");
    private final String deleteCommentButton = "//*[@title='Delete']";
    private final By commentItem = cssSelector("[data-testid=comment-body]");
    private final String commentText = "//*[contains(text(), \"%s\")]";
    private final String seeMoreButton = commentText + "//span[text()='[See more]']";
    private final String seeLessButton = commentText + "//span[text()='[See less]']";
    private final String commentAuthor = commentText + "/../../div/p[1]";
    private final String commentDate = commentText + "/../../div/p[2]";

}