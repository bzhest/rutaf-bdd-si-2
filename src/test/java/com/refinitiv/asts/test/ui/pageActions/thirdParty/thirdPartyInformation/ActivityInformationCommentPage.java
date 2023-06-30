package com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation.ActivityInformationCommentPO;
import com.refinitiv.asts.test.ui.utils.data.ui.ActivityInformationCommentDTO;
import com.refinitiv.asts.test.ui.utils.data.ui.CommentDTO;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import static com.google.common.collect.Iterables.getLast;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static java.lang.String.format;
import static java.util.Objects.nonNull;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.numberOfElementsToBeMoreThan;

public class ActivityInformationCommentPage extends BasePage<ActivityInformationCommentPage> {

    private final ActivityInformationCommentPO activityInformationCommentPO;

    public ActivityInformationCommentPage(WebDriver driver, ScenarioCtxtWrapper context) {
        super(driver, context);
        activityInformationCommentPO = new ActivityInformationCommentPO(driver);
    }

    @Override
    protected ExpectedCondition<ActivityInformationCommentPage> getPageLoadCondition() {
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

    public boolean isCommentSectionExpanded() {
        return getAttributeValueWithWait(waitShort, xpath(activityInformationCommentPO.getCommentsSection()), CLASS)
                .contains(MUI_EXPANDED);
    }

    public boolean isCommentTextareaDisplayed() {
        return isElementDisplayed(waitMoment, activityInformationCommentPO.getCommentTextarea());
    }

    public boolean isCommentEditButtonDisplayed(String comment) {
        clickOnCommentAuthor(comment);
        return isElementDisplayed(waitMoment, activityInformationCommentPO.getEdit());
    }

    public boolean isCommentDeleteButtonDisplayed(String comment) {
        clickOnCommentAuthor(comment);
        return isElementDisplayed(waitMoment, activityInformationCommentPO.getDelete());
    }

    public boolean isCommentBlockButtonDisplayed(String buttonName) {
        return isElementDisplayed(waitMoment,
                                  xpath(format(activityInformationCommentPO.getCommentBlockButton(), buttonName)));
    }

    public boolean isCommentSectionButtonDisplayed(String buttonName) {
        return isElementDisplayed(waitMoment,
                                  xpath(format(activityInformationCommentPO.getCommentActionButton(), buttonName)));
    }

    public boolean isCommentSectionButtonDisabled(String buttonName) {
        return isElementAttributeContains(
                xpath(format(activityInformationCommentPO.getCommentActionButton(), buttonName)), CLASS, DISABLED);
    }

    public boolean isCommentWithTextDisplayed(String comment) {
        return isElementDisplayed(waitShort, xpath(format(activityInformationCommentPO.getCommentWithText(), comment)));
    }

    public String getCommentTextAreaText() {
        return getElementText(getLast(getElements(waitMoment, activityInformationCommentPO.getCommentTextarea())));
    }

    public List<String> getCommentsList() {
        return getElementsText(getElements(waitMoment, activityInformationCommentPO.getCommentsList()));
    }

    public void addCommentText(String contextReference, String text) {
        WebElement comment = getLast(getElements(waitMoment, activityInformationCommentPO.getCommentTextarea()));
        clearAndInputField(comment, text);
        context.getScenarioContext().setContext(contextReference, text);
    }

    public void clickActionButton(String button) {
        clickOn(xpath(format(activityInformationCommentPO.getCommentActionButton(), button)));
    }

    public void clickCommentButton(String button) {
        clickOn(xpath(format(activityInformationCommentPO.getCommentBlockButton(), button)));
    }

    public void clickOnCommentAuthor(String comment) {
        scrollIntoView(activityInformationCommentPO.getCommentNextSection());
        scrollIntoView(xpath(format(activityInformationCommentPO.getCommentWithText(), comment)));
        hoverOverElement(xpath(format(activityInformationCommentPO.getCommentAuthor(), comment)));
        clickWithJS(driver.findElement(xpath(format(activityInformationCommentPO.getCommentAuthor(), comment))));
    }

    public void clickCommentsSectionArrow() {
        clickOn(activityInformationCommentPO.getCommentsSectionArrow());
    }

    public ActivityInformationCommentDTO getActivityComment(String comment) {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        return getAllActivityComments().stream()
                .filter(element -> nonNull(element) && element.getComment().getText()
                        .contains(comment))
                .findFirst()
                .orElse(null);
    }

    public List<ActivityInformationCommentDTO> getAllActivityComments() {
        List<ActivityInformationCommentDTO> commentList = new ArrayList<>();
        try {
            waitShort.until(numberOfElementsToBeMoreThan(xpath(activityInformationCommentPO.getCommentBlock()), 0));
            List<WebElement> rows = getElements(activityInformationCommentPO.getCommentBlock());
            for (WebElement row : rows) {
                if (nonNull(getElement(waitMoment, () -> row.findElement(activityInformationCommentPO.getAuthor())))) {
                    clickOn(getElement(waitMoment, () -> row.findElement(activityInformationCommentPO.getAuthor())));
                    commentList
                            .add(new ActivityInformationCommentDTO()
                                         .setAuthor(row.findElement(activityInformationCommentPO.getAuthor()))
                                         .setDate(row.findElement(activityInformationCommentPO.getDate()))
                                         .setComment(row.findElement(activityInformationCommentPO.getComment()))
                            );
                } else {
                    commentList.add(null);
                }
            }
            return commentList;
        } catch (TimeoutException e) {
            logger.info("There are no comments on Activity Information page");
        }
        return commentList;
    }

    public List<CommentDTO> getActivitiesCommentsData() {
        return getAllActivityComments()
                .stream()
                .filter(Objects::nonNull)
                .map(comment -> new CommentDTO()
                        .setCommentText(comment.getComment().getText())
                        .setDate(comment.getDate().getText())
                        .setAuthor(comment.getAuthor().getText()))
                .collect(Collectors.toList());
    }

    public void clickOnCommentEditButton(String comment) {
        clickOnCommentAuthor(comment);
        clickOn(activityInformationCommentPO.getEdit(), waitMoment);
    }

    public void clickOnCommentDeleteButton(String comment) {
        clickOnCommentAuthor(comment);
        clickOn(activityInformationCommentPO.getDelete(), waitMoment);
    }

    public String getCommentCharacterLimitMessage() {
        return getElementText(activityInformationCommentPO.getCommentCharacterLimitMessage());
    }

}

