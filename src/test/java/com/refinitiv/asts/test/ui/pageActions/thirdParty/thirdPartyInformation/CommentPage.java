package com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation.CommentPO;
import com.refinitiv.asts.test.ui.utils.data.ui.CommentDTO;
import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import static com.refinitiv.asts.test.ui.constants.TestConstants.ROW_DELIMITER;
import static java.lang.String.format;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class CommentPage extends BasePage<CommentPage> {

    private static final String DOT = ".";
    private final CommentPO commentPO;

    public CommentPage(WebDriver driver, ScenarioCtxtWrapper context) {
        super(driver, context);
        commentPO = new CommentPO(driver);
    }

    @Override
    protected ExpectedCondition<CommentPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return false;
    }

    @Override
    public void load() {

    }

    public CommentDTO getCommentData(String commentText) {
        if (commentText.length() > 550) {
            commentText = commentText.substring(0, 100);
        }
        waitShort.until(numberOfElementsToBeMoreThan(commentPO.getCommentItem(), 0));
        return new CommentDTO().setAuthor(getElementText(xpath(format(commentPO.getCommentAuthor(), commentText))))
                .setDate(driver.findElement(xpath(format(commentPO.getCommentDate(), commentText))).getText()
                                 .replace(DOT,
                                          StringUtils.EMPTY))
                .setCommentText(getElementText(xpath(format(commentPO.getCommentText(), commentText))).replace(
                        ROW_DELIMITER + "[See more]", StringUtils.EMPTY));
    }

    public void clickSeeMoreLink(String commentText) {
        clickOn(xpath(format(commentPO.getSeeMoreButton(), commentText)));
    }

    public void fillInCommentAndSave(String comment) {
        clearAndInputField(commentPO.getCommentField(), comment);
        clickOn(commentPO.getCommentButton());
    }

    public void clickEditComment(String oldComment) {
        scrollToBottom();
        moveToElementAndClick(driver.findElement(xpath(format(commentPO.getCommentText(), oldComment))));
        moveToElementAndClick(driver.findElement(commentPO.getEditCommentButton()));
    }

    public void clickDeleteComment(String currentComment) {
        scrollToBottom();
        moveToElementAndClick(driver.findElement(xpath(format(commentPO.getCommentText(), currentComment))));
        moveToElementAndClick(driver.findElement(xpath(format(commentPO.getDeleteCommentButton(), currentComment))));
    }

    public boolean isCommentDisplayed(String commentText) {
        return isElementDisplayed(xpath(format(commentPO.getCommentText(), commentText)));
    }

    public boolean isSeeLessButtonDisplayed(String commentText) {
        return isElementDisplayed(xpath(format(commentPO.getSeeLessButton(), commentText)));
    }

}
