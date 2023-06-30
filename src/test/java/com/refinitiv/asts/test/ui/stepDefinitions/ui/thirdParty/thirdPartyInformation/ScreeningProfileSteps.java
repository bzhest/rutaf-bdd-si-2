package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.constants.ContextConstants;
import com.refinitiv.asts.test.ui.enums.ScreeningProfileHeaderColumns;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ScreeningProfileSectionPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.utils.data.ui.CommentDTO;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang3.RandomStringUtils;
import org.assertj.core.api.SoftAssertions;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.DISABLED;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static org.apache.commons.lang3.RandomStringUtils.randomAscii;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.*;

public class ScreeningProfileSteps extends BaseSteps {

    private final ScreeningProfileSectionPage profilePage;
    private String commentDate;
    private UserData commentAuthor;
    private final List<CommentDTO> commentsData = new ArrayList<>();

    public ScreeningProfileSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.profilePage = new ScreeningProfileSectionPage(driver, this.context, translator);
    }

    @When("User adds screening record {string} {string} reviewer due to today date")
    public void addScreeningRecordReviewerDueToTodayDate(String reviewerType, String reviewerName) {
        profilePage.waitWhileSeveralPreloadProgressBarsAreDisappeared(5);
        profilePage.clickAddReviewerButton();
        profilePage.waitWhilePreloadProgressbarIsDisappeared();
        profilePage.selectReviewerType(reviewerType);
        profilePage.fillInReviewer(reviewerName);
        profilePage.fillInCurrentDueDate();
        profilePage.clickSaveButton();
    }

    @When("User adds screening record {string} {string} Ad Hoc reviewer due to today date")
    public void addScreeningRecordAdHocReviewerDueToTodayDate(String reviewerType, String reviewerName) {
        profilePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        profilePage.clickAddReviewerButton();
        profilePage.waitWhilePreloadProgressbarIsDisappeared();
        profilePage.selectReviewerType(reviewerType);
        profilePage.fillInReviewer(reviewerName);
        profilePage.fillInCurrentDueDate();
        profilePage.clickCreateAdHocActivity();
        profilePage.waitWhilePreloadProgressbarIsDisappeared();
        profilePage.clickSaveButton();
    }

    @When("User selects screening record reviewer {string} from drop-down")
    public void selectReviewer(String reviewerName) {
        profilePage.waitWhilePreloadProgressbarIsDisappeared();
        profilePage.fillInReviewer(reviewerName);
    }

    @When("User clicks screening record reviewer Save button")
    public void clickSaveEditButton() {
        profilePage.clickSaveEditButton();
        profilePage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User edits screening record reviewer to {string}")
    public void editScreeningRecordReviewer(String reviewerName) {
        profilePage.fillInEditReviewer(reviewerName);
        profilePage.clickSaveEditButton();
    }

    @When("User clicks on the 'Review' screening profile button")
    public void clickOnTheReviewScreeningProfileButton() {
        profilePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        profilePage.clickReviewButton();
        profilePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User clicks on the 'Screening Results' screening profile button")
    public void clickTheScreeningResultsButton() {
        profilePage.clickBackToScreeningResultsButton();
        profilePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User clicks on {string} tab on Screening results page")
    public void clickTabOnScreeningResultsPage(String tabName) {
        profilePage.waitWhilePreloadProgressbarIsDisappeared();
        profilePage.clickTabOnScreeningResultsPage(tabName);
    }

    @When("User clicks on third-party back button")
    public void clickThirdPartyBackButton() {
        profilePage.clickThirdPartyBackButton();
    }

    @When("User clicks on third-party other name back button")
    public void clickThirdPartyOtherNamesBackButton() {
        profilePage.clickThirdPartyOtherNamesBackButton();
    }

    @When("User clicks Screening profile's reviewer Clear button")
    public void clickScreeningProfileSReviewerClearButton() {
        profilePage.clickReviewerClearButton();
    }

    @When("User fills in screening profile comment {string}")
    public void fillInScreeningProfileComment(String commentText) {
        profilePage.fillInComment(commentText);
        context.getScenarioContext().setContext(SCREENING_COMMENT_TEXT, commentText);
        commentAuthor = (UserData) context.getScenarioContext().getContext(USER_DATA);
        commentDate = getCurrentCommentDateTime(ACTIVITY_COMMENT_DATE_FORMAT).replace(AM, A_M_).replace(PM, P_M_);
        commentsData.add(new CommentDTO()
                                 .setCommentText(commentText)
                                 .setDate(commentDate)
                                 .setAuthor(commentAuthor.getFirstName() + SPACE + commentAuthor.getLastName()));
    }

    @When("User clicks screening profile Comment button")
    public void clickScreeningProfileCommentButton() {
        profilePage.clickCommentButton();
        commentDate = getCurrentCommentDateTime(ACTIVITY_COMMENT_DATE_FORMAT).replace(PM, P_M_).replace(AM, A_M_);
    }

    @When("User clicks screening profile comment button {string}")
    public void clickScreeningProfileCommentButton(String buttonName) {
        profilePage.clickCommentButton(buttonName);
        if (buttonName.equals("Show all comments")) {
            profilePage.waitForCommentButtonToAppear("Hide comments");
        }
        if (buttonName.equals(CANCEL)) {
            int expectedCommentsSize = commentsData.size();
            if (expectedCommentsSize > 0) {
                commentsData.remove(expectedCommentsSize - 1);
            }
        }
    }

    @When("User on Screening profile page adds {int} comment(s) {string}")
    public void addActivityInformationComments(int commentsCount, String comment) {
        commentAuthor = (UserData) context.getScenarioContext().getContext(USER_DATA);
        for (int i = 1; i <= commentsCount; i++) {
            profilePage.waitWhilePreloadProgressbarIsDisappeared();
            String expectedComment = comment + i;
            commentDate = getCurrentCommentDateTime(ACTIVITY_COMMENT_DATE_FORMAT).replace(AM, A_M_).replace(PM, P_M_);
            profilePage.fillInComment(comment + i);
            profilePage.clickCommentButton();
            profilePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
            commentsData.add(new CommentDTO()
                                     .setCommentText(expectedComment)
                                     .setDate(commentDate)
                                     .setAuthor(commentAuthor.getFirstName() + SPACE + commentAuthor.getLastName()));
        }

    }

    @When("User on Screening Profile page edits comment {string} with text {string}")
    public void editCommentOnActivityInformationPage(String comment, String newComment) {
        profilePage.clickOnCommentEditButton(comment);
        profilePage.fillInComment(newComment);
        context.getScenarioContext().setContext(SCREENING_COMMENT_TEXT, newComment);
        commentsData.forEach(record -> {
            if (record.getCommentText().equals(comment)) {
                record.setCommentText(newComment);
            }
        });
    }

    @When("User on Screening Profile page deletes comment {string}")
    public void deleteCommentOnActivityInformationPage(String comment) {
        profilePage.clickOnCommentDeleteButton(comment);
    }

    @When("User clicks screening profile Legal Notice link")
    public void clickScreeningProfileLegalNoticeLink() {
        profilePage.clickLegalNoticeLink();
    }

    @When("^User turns (On|Off) 'Tag as red flag' on Screening Profile page$")
    public void turnOnTagAsRedFlagOnScreeningProfile(String turnOption) {
        profilePage.waitWhilePreloadProgressbarIsDisappeared();
        if ((turnOption.equals(ON) && !profilePage.isRedFlagTurnOn()) ||
                (turnOption.equals(OFF) && profilePage.isRedFlagTurnOn())) {
            profilePage.turnOnTagAsRedFlag();
        }
    }

    @When("User on Screening Profile page edits comment {string} with {int} alphanumeric and special characters")
    public void editCommentOnScreeningProfilePage(String comment, int commentLength) {
        this.profilePage.clickOnCommentEditButton(comment);
        String newComment = randomAscii(commentLength);
        this.profilePage.fillInComment(newComment);
        context.getScenarioContext().setContext(SCREENING_COMMENT_TEXT, newComment);
        commentsData.forEach(record -> {
            if (record.getCommentText().equals(comment)) {
                record.setCommentText(newComment);
            }
        });
    }

    @When("User on Screening Profile page adds comment with {int} alphanumeric and special characters")
    public void addScreeningProfileComments(int commentLength) {
        String newComment = randomAscii(commentLength);
        this.profilePage.fillInComment(newComment);
        context.getScenarioContext().setContext(SCREENING_COMMENT_TEXT, newComment);
        String initialCommentDate = getCurrentCommentDateTime(ACTIVITY_COMMENT_DATE_FORMAT);
        commentAuthor = (UserData) context.getScenarioContext().getContext(USER_DATA);
        commentsData.add(new CommentDTO()
                                 .setCommentText(newComment)
                                 .setDate(initialCommentDate)
                                 .setAuthor(commentAuthor.getFirstName() + SPACE + commentAuthor.getLastName()));
    }

    @When("^User clicks (Open|Close) accordion icon of Comments section on Screening Profile page$")
    public void clickCommentAccordionIconOnScreeningProfile(String turnOption) {
        profilePage.waitWhilePreloadProgressbarIsDisappeared();
        if ((turnOption.equals(OPEN) && !profilePage.isCommentSectionDetailPageExpanded()) ||
                (turnOption.equals(CLOSE) && profilePage.isCommentSectionDetailPageExpanded())) {
            profilePage.clickCommentAccordion();
        }
    }

    @When("User random {int} characters and fills in random comment characters on Comment profile section")
    public void fillInRandomValue(int number) {
        String comment = RandomStringUtils.randomAlphabetic(number);
        context.getScenarioContext().setContext(WORLD_CHECK_COMMENT, comment);
        String commentValue = (String) context.getScenarioContext().getContext(WORLD_CHECK_COMMENT);
        profilePage.fillInComment(commentValue);
    }

    @When("User clicks 'See more' button on comment position {int}")
    public void clickSeeMoreOnScreeningProfile(int position) {
        profilePage.clickSeeMore(position);
    }

    @When("User clicks 'See less' button on comment position {int}")
    public void clickSeeLessOnScreeningProfile(int position) {
        profilePage.clickSeeLess(position);
    }

    @When("User clicks 'Show More' button")
    public void clickShowMoreOnScreeningProfile() {
        profilePage.clickShowMore();
    }

    @When("User clicks 'Hide Comments' button")
    public void clickHideCommentsOnScreeningProfile() {
        profilePage.clickHideComments();
    }

    @When("User clicks 'Show All comments' button")
    public void clickShowAllCommentsOnScreeningProfile() {
        profilePage.clickShowAllComments();
    }

    @When("User clicks screening profile Cancel button")
    public void clickCancelButtonOnScreeningProfile() {
        profilePage.clickCancelButton();
    }

    @When("User saves current record name as {string}")
    public void saveCurrentRecordNameAs(String nameReference) {
        context.getScenarioContext()
                .setContext(nameReference,
                            profilePage.getElementText(ScreeningProfileHeaderColumns.NAME.getColumnName()));
    }

    @Then("Screening result profile details is displayed")
    public void screeningResultProfileDetailsIsDisplayed() {
        profilePage.waitWhilePreloadProgressbarIsDisappeared();
        assertTrue("Screening Results profile page is not displayed",
                   profilePage.isScreeningProfileDisplayed());
    }

    @Then("Contact Screening result profile details is displayed")
    public void contactScreeningResultProfileDetailsIsDisplayed() {
        profilePage.waitWhilePreloadProgressbarIsDisappeared();
        assertTrue("Contact Screening Results profile page is not displayed",
                   profilePage.isContactScreeningProfileDisplayed());
    }

    @Then("Comment profile section contains expected text {string}")
    public void commentProfileSectionContainsExpectedText(String comment) {
        profilePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(profilePage.getCommentText()).as("Comment profile text is unexpected").isEqualTo(comment);
    }

    @Then("Comment profile section contains expected author {string}")
    public void commentProfileSectionContainsExpectedAuthor(String expectedAuthor) {
        assertThat(profilePage.getCommentAuthor()).as("Comment profile author is unexpected")
                .isEqualTo(expectedAuthor);
    }

    @Then("Comment profile section contains expected date")
    public void commentProfileSectionContainsExpectedDate() {
        if (Objects.isNull(commentDate)) {
            commentDate = (String) context.getScenarioContext().getContext(ContextConstants.COMMENT_DATE);
        }
        assertThat(profilePage.getCommentDate()).as("Comment profile date is unexpected").isEqualTo(commentDate);
    }

    @Then("Comment profile section is not displayed")
    public void commentProfileSectionIsNotDisplayed() {
        profilePage.waitWhilePreloadProgressbarIsDisappeared();
        assertFalse("Comment profile section is displayed", profilePage.isCommentSectionDisplayed());
    }

    @Then("^Profile Add Comment modal \"(Save|Cancel|Add Reviewer)\" button is displayed$")
    public void profileAddCommentModalButtonIsDisplayed(String buttonType) {
        boolean result;
        switch (buttonType) {
            case SAVE:
                result = profilePage.isSaveProfileCommentButtonDisplayed();
                break;
            case CANCEL:
                result = profilePage.isCancelProfileCommentButtonDisplayed();
                break;
            case ADD_REVIEWER:
                result = profilePage.isAddReviewerProfileCommentButtonDisplayed();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
        assertThat(result).as("Profile Add Comment modal %s button is not displayed", buttonType).isTrue();
    }

    @Then("Screening profile's Review Status is {string}")
    public void screeningProfileSReviewStatusIs(String expectedResult) {
        profilePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertEquals("Review Status is unexpected", expectedResult, profilePage.getReviewStatus());
    }

    @Then("Screening profile's Reviewer is {string}")
    public void screeningProfileSReviewerIs(String expectedResult) {
        profilePage.waitWhilePreloadProgressbarIsDisappeared();
        assertEquals("Reviewer is unexpected", expectedResult, profilePage.getReviewer());
    }

    @Then("Text of screening profile's Reviewer is {string}")
    public void screeningProfileReviewerTextIs(String expectedResult) {
        profilePage.waitWhilePreloadProgressbarIsDisappeared();
        assertEquals("Reviewer is unexpected", expectedResult, profilePage.getReviewerText());
    }

    @Then("Screening profile's Reviewer Assigned By is {string}")
    public void screeningProfileSReviewerAssignedByIs(String expectedResult) {
        assertEquals("Reviewer Assigned By is unexpected", expectedResult, profilePage.getReviewerAssignedBy());
    }

    @Then("Screening profile's Resolution is displayed")
    public void screeningProfileSResolutionIsDisplayed() {
        profilePage.waitWhilePreloadProgressbarIsDisappeared();
        assertTrue("Resolution is not displayed", profilePage.isResolutionDisplayed());
    }

    @Then("Screening profile's Tags is displayed")
    public void screeningProfileSTagsIsDisplayed() {
        assertTrue("Tags button is not displayed", profilePage.isTagsDisplayed());
    }

    @Then("Screening profile's Review button is enabled")
    public void screeningProfileSReviewButtonIsEnabled() {
        profilePage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(profilePage.isReviewButtonEnabled()).as("Tags button is not displayed").isTrue();
    }

    @Then("Screening profile's Reviewer Details is not displayed")
    public void screeningProfileSReviewerDetailsIsNotDisplayed() {
        assertThat(profilePage.isReviewerDetailsDisplayed())
                .as("Screening profile's Reviewer Details is displayed")
                .isFalse();
    }

    @Then("^'Tag as red flag' is turned (on|off)$")
    public void turnsOnTafAsRedFlag(String turnOption) {
        profilePage.waitWhilePreloadProgressbarIsDisappeared();
        boolean shouldBeTurnedOn = turnOption.equals(ON.toLowerCase());
        assertThat(profilePage.isTagAsRedFlagSwitched())
                .as("'Tag as red flag' is not turned %s", turnOption)
                .isEqualTo(shouldBeTurnedOn);
    }

    @Then("Risk Level value on Screening profile page is {string}")
    public void riskLevelValueIs(String expectedValue) {
        assertThat(profilePage.getRiskLevelProfileValue())
                .as("Risk Level value is not %s", expectedValue)
                .isEqualTo(expectedValue);
    }

    @Then("Reason value on Screening profile page is {string}")
    public void reasonValueIs(String expectedValue) {
        assertThat(profilePage.getReasonProfileValue())
                .as("Reason value is not %s", expectedValue)
                .isEqualTo(expectedValue);
    }

    @Then("Only {int} last comments are displayed by default on Screening Profile page")
    public void onlyLastCommentsAreDisplayedByDefault(int commentsCount) {
        profilePage.waitWhilePreloadProgressbarIsDisappeared();
        List<CommentDTO> actualComments = profilePage.getAllProfileComments();
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(actualComments.size())
                .as("Actual displayed comments size is not %s", commentsCount)
                .isEqualTo(commentsCount);
        Collections.reverse(commentsData);
        IntStream.rangeClosed(0, commentsCount - 1)
                .forEach(i -> softAssert.assertThat(actualComments.get(i))
                        .as("Comment isn't matched with expected one")
                        .isEqualTo(commentsData.get(i)));
        softAssert.assertAll();
        Collections.reverse(commentsData);
    }

    @Then("Created comments on screening profile page are displayed and sorted by upload date")
    public void commentsAreDisplayedAndSortedByUploadDate() {
        profilePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        List<CommentDTO> actualComments = profilePage.getAllProfileComments();
        Collections.reverse(commentsData);
        assertThat(actualComments)
                .as("Expected comments list are not equal or sorted as actual ones")
                .isEqualTo(commentsData);
        Collections.reverse(commentsData);
    }

    @Then("^Screening profile page comment section button \"(.*)\" (is displayed|is not displayed)$")
    public void commentSectionButtonIsDisplayed(String buttonName, String buttonState) {
        boolean shouldBeDisplayed = !buttonState.contains(IS_NOT.toLowerCase());
        assertThat(profilePage.isCommentButtonDisplayed(buttonName))
                .as("%s button state doesn't match with expected: %s", buttonName, buttonState)
                .isEqualTo(shouldBeDisplayed);
    }

    @Then("^Screening profile page comment section button \"(.*)\" is (disabled|enabled)$")
    public void commentSectionButtonIsEnabled(String buttonName, String buttonState) {
        boolean shouldBeDisabled = buttonState.contains(DISABLED);
        assertThat(profilePage.isCommentButtonDisabled(buttonName))
                .as("%s button state doesn't match with expected: %s", buttonName, buttonState)
                .isEqualTo(shouldBeDisabled);
    }

    @Then("^Screening profile page comment section text input area (is displayed|is not displayed)$")
    public void commentSectionTextInputAreaIsDisplayed(String state) {
        boolean shouldBeDisplayed = !state.contains(IS_NOT.toLowerCase());
        assertThat(profilePage.isTextInputAreDisplayed())
                .as("Text input are state doesn't match with expected: %s", state)
                .isEqualTo(shouldBeDisplayed);
    }

    @Then("Screening profile page comment text area contains {string}")
    public void activityInformationPageCommentTextAreaContains(String expectedText) {
        expectedText = expectedText.isEmpty() ? null : expectedText;
        assertThat(profilePage.getCommentTextAreaText())
                .as("Screening profile page comment text area doesn't contain expected text")
                .isEqualTo(expectedText);
    }

    @Then("^Screening profile Comment \"((.*))\" edit button (is displayed|is not displayed)$")
    public void commentEditButtonIsDisplayed(String comment, String state) {
        boolean shouldBeDisplayed = !state.contains(NOT);
        assertThat(profilePage.isCommentEditButtonDisplayed(comment))
                .as("Activity information Comment %s edit button is displayed", comment)
                .isEqualTo(shouldBeDisplayed);
    }

    @Then("^Screening profile Comment \"((.*))\" delete button (is displayed|is not displayed)$")
    public void commentDeleteButtonIsDisplayed(String comment, String state) {
        profilePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        boolean shouldBeDisplayed = !state.contains(NOT);
        assertThat(profilePage.isCommentDeleteButtonDisplayed(comment))
                .as("Activity information Comment %s delete button is not in state: %s", comment, state)
                .isEqualTo(shouldBeDisplayed);
    }

    @Then("Edited comment on Screening Profile page is displayed")
    public void editedCommentOnScreeningProfilePageIsDisplayed() {
        profilePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        String expectedCommentText = (String) context.getScenarioContext().getContext(SCREENING_COMMENT_TEXT);
        CommentDTO expectedComment =
                new CommentDTO()
                        .setCommentText(expectedCommentText)
                        .setDate(commentDate)
                        .setAuthor(commentAuthor.getFirstName() + SPACE + commentAuthor.getLastName());
        List<CommentDTO> actualComments = profilePage.getAllProfileComments();
        assertThat(actualComments)
                .as("Expected comment is not equal to actual one")
                .contains(expectedComment);
    }

    @Then("Edited comment on Screening Profile page is marked with 'Edited' label")
    public void editedCommentIsMarkedWithEditedLabel() {
        String expectedComment = (String) context.getScenarioContext().getContext(SCREENING_COMMENT_TEXT);
        assertThat(profilePage.isEditedLabelDisplayedOnComment(expectedComment)).
                as("'Edited' label is not displayed")
                .isTrue();
    }

    @Then("Edited comment on Screening Profile is on initial position in comments list")
    public void editedCommentIsOnTheSamePosition() {
        String expectedCommentText = (String) context.getScenarioContext().getContext(SCREENING_COMMENT_TEXT);
        Collections.reverse(commentsData);
        List<CommentDTO> actualComments = profilePage.getAllProfileComments();
        CommentDTO expectedComment = commentsData.stream()
                .filter(comment -> comment.getCommentText().equals(expectedCommentText))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("Comment not found in the list"));
        int actualCommentPosition = actualComments.indexOf(expectedComment);
        int expectedCommentPosition = commentsData.indexOf(expectedComment);
        assertThat(actualCommentPosition)
                .as("Actual comment position in comments list is different from expected one")
                .isEqualTo(expectedCommentPosition);
        Collections.reverse(commentsData);
    }

    @Then("Screening profile comment is deleted from list")
    public void commentIsDeletedFromList() {
        profilePage.waitWhilePreloadProgressbarIsDisappeared();
        String expectedCommentText = (String) context.getScenarioContext().getContext(SCREENING_COMMENT_TEXT);
        Collections.reverse(commentsData);
        List<CommentDTO> actualComments = profilePage.getAllProfileComments();
        CommentDTO expectedComment = commentsData.stream()
                .filter(comment -> comment.getCommentText().equals(expectedCommentText))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("Comment not found in the list"));
        assertThat(actualComments)
                .as("Actual comments list contains deleted comment")
                .doesNotContain(expectedComment);
        Collections.reverse(commentsData);
    }

    @Then("^Comment \"((.*))\" on Screening Profile page (should not|should) be shown$")
    public void validateScreeningProfileCommentVisibility(String expectedCommentText, String state) {
        if (state.contains(NOT)) {
            assertThat(this.profilePage.isCommentEditButtonDisplayed(expectedCommentText))
                    .as("Comment is displayed").isFalse();
        } else {
            assertThat(this.profilePage.isCommentEditButtonDisplayed(expectedCommentText))
                    .as("Comment is not displayed").isTrue();
        }
    }

    @Then("The 5000-character comment on Screening Profile page (is displayed|is not displayed)$")
    public void validate5000CharactersOnCommentTextArea(String state) {
        String expectedCommentText =
                (((String) context.getScenarioContext().getContext(SCREENING_COMMENT_TEXT)).substring(0, 5000));
        if (state.contains(NOT)) {
            validateScreeningProfileCommentVisibility(expectedCommentText, NOT);
        } else {
            assertThat(this.profilePage.getCommentTextAreaText())
                    .as("Screening profile page comment text area doesn't contain expected text")
                    .isEqualTo(expectedCommentText);
        }
    }

    @Then("Comment profile section displays 'See more' label on comment position {int}")
    public void isSeeMoreOnProfileCommentDisplayed(int position) {
        assertTrue("Comment profile section does not display 'See more' label",
                   profilePage.isSeeMoreOnProfileCommentDisplayed(position));
    }

    @Then("Comment profile section displays 'See less' label on comment position {int}")
    public void isSeeLessOnProfileCommentDisplayed(int position) {
        assertTrue("Comment profile section does not display 'See less' label",
                   profilePage.isSeeLessOnProfileCommentDisplayed(position));
    }

    @Then("Comment profile section displays 'Show More' button")
    public void isShowMoreOnProfileCommentDisplayed() {
        assertTrue("Comment profile section does not display 'Show More' button",
                   profilePage.isShowMoreOnProfileCommentDisplayed());
    }

    @Then("Comment profile section displays 'Show All Comments' button")
    public void isShowAllCommentOnProfileCommentDisplayed() {
        assertTrue("Comment profile section does not display 'Show All Comments' button",
                   profilePage.isShowAllCommentOnProfileCommentDisplayed());
    }

    @Then("Comment profile section displays 'Hide comments' button")
    public void isHideCommentsOnProfileCommentDisplayed() {
        assertTrue("Comment profile section does not display 'Hide comments' button",
                   profilePage.isHideCommentOnProfileCommentDisplayed());
    }

    @Then("Comment profile section displays author as {string} on position {int}")
    public void isMediaCheckProfileCommentUserNameDisplayed(String userName, int position) {
        assertTrue("Comment profile section displays unexpected username",
                   profilePage.isProfileCommentUserNameDisplayed(position, userName));
    }

    @Then("Comment profile section displays comment as {string} on position {int}")
    public void isMediaCheckProfileCommentDisplayed(String comment, int position) {
        assertTrue("Comment profile section displays unexpected comment",
                   profilePage.isProfileCommentTextDisplayed(position, comment));
    }

    @Then("Comment profile section displays random comment on position {int}")
    public void isWorldCheckProfileRandomCommentDisplayed(int position) {
        String commentValue = (String) context.getScenarioContext().getContext(WORLD_CHECK_COMMENT);
        assertTrue("Comment profile section displays unexpected random comment as" + commentValue,
                   profilePage.isWorldCheckProfileCommentDisplayed(position, commentValue));
    }

    @Then("Comment profile section comment length message {string} is displayed")
    public void commentLengthMessageIsDisplayed(String expectedMessage) {
        assertThat(this.profilePage.getCommentLengthMessage())
                .as("Screening page comment length message is unexpected")
                .isEqualTo(expectedMessage);
    }

}
