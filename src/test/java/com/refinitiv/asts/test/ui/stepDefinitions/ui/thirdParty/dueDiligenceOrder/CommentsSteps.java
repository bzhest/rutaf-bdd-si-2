package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.dueDiligenceOrder;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.CommentPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.utils.data.ui.CommentDTO;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.USER_DATA;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static io.netty.karate.util.internal.StringUtil.SPACE;
import static org.apache.commons.lang3.StringUtils.join;
import static org.assertj.core.api.Assertions.assertThat;

public class CommentsSteps extends BaseSteps {

    private final CommentPage commentPage;
    private CommentDTO expectedComment;

    public CommentsSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.commentPage = new CommentPage(driver, context);
    }

    @When("User add comment with text {string}")
    public void clickAddCommentButton(String comment) {
        UserData userTestData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        commentPage.fillInCommentAndSave(comment);
        String expectedCreationDate = getTodayDate(ORDER_COMMENT_DATE_FORMAT).replace(PM.toUpperCase(), PM);
        expectedComment = new CommentDTO()
                .setAuthor(join(new String[]{userTestData.getFirstName(), userTestData.getLastName()}, SPACE))
                .setCommentText(comment)
                .setDate(expectedCreationDate);
    }

    @When("User edits comment {string} with text {string}")
    public void clickAddCommentButton(String oldComment, String newComment) {
        commentPage.clickEditComment(oldComment);
        commentPage.fillInCommentAndSave(newComment);
        expectedComment.setCommentText(newComment).setDate(getTodayDate(ORDER_COMMENT_DATE_FORMAT));
    }

    @When("User clicks Delete comment")
    public void clickDeleteCommentIcon() {
        commentPage.waitWhilePreloadProgressbarIsDisappeared();
        commentPage.clickDeleteComment(expectedComment.getCommentText());
    }

    @When("User clicks 'See More' link")
    public void clickSeeAllLink() {
        commentPage.clickSeeMoreLink(expectedComment.getCommentText());
    }

    @Then("^User should see (?:created|edited?) comment$")
    public void verifyCommentWasCreated() {
        String commentText = expectedComment.getCommentText();
        assertThat(commentPage.getCommentData(commentText))
                .usingComparatorForType(String.CASE_INSENSITIVE_ORDER, String.class)
                .usingRecursiveComparison()
                .as("Comment doesn't contain expected data")
                .isEqualTo(expectedComment);
    }

    @Then("Comment should be deleted")
    public void checkCommentIsDeleted() {
        commentPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(commentPage.isCommentDisplayed(expectedComment.getCommentText()))
                .as("Comment wasn't deleted")
                .isFalse();
    }

    @Then("Comment 'See Less' button is displayed")
    public void commentSeeLessButtonIsDisplayed() {
        assertThat(commentPage.isSeeLessButtonDisplayed(expectedComment.getCommentText()))
                .as("'See Less' button is not displayed")
                .isTrue();
    }

}
