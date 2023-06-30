package com.refinitiv.asts.test.ui.stepDefinitions.ui.home;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.home.HomePage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang.StringUtils;
import org.assertj.core.api.Assertions;
import org.assertj.core.api.SoftAssertions;

import java.util.List;

import static com.refinitiv.asts.test.ui.api.ApiClient.clearCookies;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.DISPLAYED;
import static com.refinitiv.asts.test.ui.enums.Colors.*;
import static com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.thirdPartyInformation.ScreeningSteps.ELLIPSIS;
import static org.assertj.core.api.Assertions.assertThat;

public class HomeSteps extends BaseSteps {

    private static final String ERROR_PAGE_404_ENDPOINT = "errorpage404";
    private static final int MAX_NAME_LENGTH = 12;
    private final HomePage homePage;

    public HomeSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.homePage = new HomePage(this.driver, context);
    }

    @When("User clicks Log Out button")
    public void clicksLogoutUserButton() {
        homePage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        homePage.clickLogOutButton();
        clearCookies();
    }

    @When("User clicks Preferences option")
    public void clickExternalPreferencesOption() {
        homePage.clickPreferences();
    }

    @When("User navigates to Home page")
    public void navigateToHomePage() {
        homePage.navigateToHomePage();
    }

    @When("User clicks Home page")
    public void clickHomePage() {
        homePage.clickHomePage();
    }

    @When("User clicks Set Up option")
    public void clickSetUp() {
        homePage.clickSetUpMenu();
    }

    @When("User clicks My Exports option")
    public void clickMyExports() {
        homePage.clickMyExportsMenu();
    }

    @When("User clicks footer link")
    public void clickFooterDetails() {
        homePage.clickFooterLink();
    }

    @When("User clicks 'Back to home' button")
    public void clicksButton() {
        homePage.clickBackToHomeButton();
    }

    @When("User accepts notice")
    public void acceptNoticeIfDisplayed() {
        homePage.waitWhilePreloadProgressbarIsDisappeared();
        int count = 0;
        int maxTries = 20;
        while (count < maxTries && homePage.isNoticeBoardDisplayed()) {
            homePage.scrollLegalNoticeContentBottom();
            homePage.clickConfirmCheckbox();
            homePage.clickNextButtonIfDisplayed();
            homePage.clickAcceptButtonIfDisplayed();
            count++;
        }
    }

    @When("User hovers to Help submenu")
    public void hoverToHelp() {
        homePage.hoverToHelp();
    }

    @When("User menu item background color is changed to grey when hover over it")
    public void hoverOverMenuWithName(List<String> menuItems) {
        SoftAssertions softAssert = new SoftAssertions();
        menuItems.forEach(menu -> {
            softAssert.assertThat(homePage.getSubMenuItemColor(menu))
                    .as("Background color is incorrect")
                    .isEqualTo(NONE.getColorRgba());
            homePage.hoverOverSubMenuItem(menu);
            softAssert.assertThat(homePage.getSubMenuItemColor(menu))
                    .as("Background color is incorrect")
                    .isEqualTo(HOME_MENU_DROP_DOWN_GREY.getColorRgba());
        });
        softAssert.assertAll();
    }

    @When("User selects {string} from Help submenu")
    public void selectFromHelp(String value) {
        homePage.selectFromHelp(value);
    }

    @When("User navigates back to RDDC page")
    public void navigateBackToRddcPage() {
        homePage.closeTab(1);
        homePage.switchToTab(0);
    }

    @When("User clicks User Menu")
    public void clickUserName() {
        homePage.clickUserName();
    }

    @When("User hovers over User Menu")
    public void hoverOverUserMenu() {
        homePage.hoverUserMenu();
    }

    @When("User hovers over {string} home page button")
    public void hoverOverHomePageButton(String buttonName) {
        homePage.hoverOverHomePageButton(buttonName);
    }

    @When("User clicks on {string} home page button")
    public void clickOnHomePageButton(String buttonName) {
        homePage.clickOnHomePageButton(buttonName);
        homePage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @Then("Home page is loaded")
    public void validateUserHeaderDisplayed() {
        assertThat(homePage.isPageLoaded()).as("Home Page is not loaded")
                .isTrue();
        homePage.saveVersionToContext();
    }

    @Then("Footer contains text {string}")
    public void isFooterDetailsDisplayed(String expectedText) {
        assertThat(homePage.getFooterText()).as("Footer is not displayed with text")
                .contains(expectedText);
    }

    @Then("Refinitiv Logo is displayed")
    public void isRefinitivLogoDisplayed() {
        assertThat(homePage.isRefinitivLogoDisplayed()).as("Refinitiv Logo is not displayed")
                .isTrue();
    }

    @Then("User is redirected to page 404")
    public void userIsRedirectedToPageWithErrorMessage() {
        homePage.waitWhilePreloadProgressbarIsDisappeared();
        homePage.waitWhileUrlContains("Wait for error URL with 404 error appears", ERROR_PAGE_404_ENDPOINT);
        assertThat(driver.getCurrentUrl()).as("Unexpected current url")
                .contains(ERROR_PAGE_404_ENDPOINT);
    }

    @Then("^User menu items are (displayed|not displayed)$")
    public void userMenuItemsAreDisplayed(String state, List<String> menuItems) {
        homePage.clickUserName();
        if (state.equalsIgnoreCase(DISPLAYED)) {
            assertThat(homePage.getUserMenuItems()).as("User menu items are unexpected")
                    .isEqualTo(menuItems);
        } else {
            assertThat(homePage.getUserMenuItems()).as("User menu items contain unexpected ones")
                    .doesNotContainAnyElementsOf(menuItems);
        }

    }

    @Then("User menu items are hidden")
    public void userMenuItemsAreHidden() {
        assertThat(homePage.isMenuItemsListDisappeared())
                .as("User menu items are shown")
                .isTrue();
    }

    @Then("The following error message is displayed")
    public void theFollowingErrorMessageIsDisplayed(List<String> expectedError) {
        String actualError = homePage.getErrorText();
        expectedError.forEach(text -> assertThat(actualError).as("Error message doesn't contain expected text")
                .contains(text));
    }

    @Then("Back button is displayed")
    public void backButtonIsDisplayed() {
        assertThat(homePage.isBackHomeButtonDisplayed()).as("Back button is not displayed")
                .isTrue();
    }

    @Then("Profile photo icon on the upper right corner of the screen is displayed")
    public void profilePhotoIconOnTheUpperRightCornerOfTheScreenIsDisplayed() {
        String expectedPhoto = (String) context.getScenarioContext().getContext(USER_EDITED_PHOTO);
        assertThat(homePage.getAvatarLocation())
                .as("Profile photo icon on the upper right corner of the screen is not displayed")
                .contains(expectedPhoto);
    }

    @Then("Profile photo icon on the upper right corner of the screen is displayed for External User")
    public void profilePhotoIconOnTheUpperRightCornerOfIsDisplayedForExternalUser() {
        String expectedPhoto = (String) context.getScenarioContext().getContext(USER_EDITED_PHOTO);
        assertThat(homePage.getAvatarLocation()).as(
                        "Profile photo icon on the upper right corner of the screen is not displayed")
                .contains(expectedPhoto);
    }

    @Then("Header {string} label is displayed")
    public void headerLabelIsDisplayed(String expectedText) {
        if (expectedText.contains(USER_EDITED_FIRST_NAME)) {
            expectedText = expectedText.replace(USER_EDITED_FIRST_NAME, (CharSequence) context.getScenarioContext()
                    .getContext(USER_EDITED_FIRST_NAME));
        } else {
            expectedText =
                    expectedText.length() > MAX_NAME_LENGTH ? expectedText.substring(0, MAX_NAME_LENGTH) + ELLIPSIS :
                            expectedText;
        }
        assertThat(homePage.isHeaderTextAppeared(expectedText)).as("Header label is not expected")
                .isTrue();
    }

    @Then("Header photo placeholder is displayed")
    public void headerPhotoPlaceholderIsDisplayed() {
        assertThat(homePage.isPhotoPlaceholderDisplayed()).as("Header photo placeholder is not displayed").isTrue();
    }

    @Then("Help option {string} is displayed")
    public void isHelpOptionDisplayed(String value) {
        assertThat(homePage.isHelpOptionDisplayed(value)).as("Help option is not displayed").isTrue();
    }

    @Then("Home Page buttons are displayed in the header")
    public void homePageButtonsAreDisplayedInTheHeader(List<String> expectedResult) {
        assertThat(homePage.getHomePageButtonsNames())
                .as("Home Page buttons are unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("Home Page {string} button color is blue")
    public void homePageButtonColorIsBlue(String buttonName) {
        assertThat(homePage.getHomePageButtonColor(buttonName))
                .as("Home Page '%s' button color is not blue")
                .isEqualTo(REACT_BLUE.getColorRgba());
    }

    @Then("Tooltip with first name of logged in user is displayed")
    public void tooltipWithFirstNameOfLoggedInUserIsDisplayed() {
        UserData userData = (UserData) this.context.getScenarioContext().getContext(USER_DATA);
        Assertions.assertThat(homePage.getTooltipText())
                .as("Tooltip text is not as expected")
                .isEqualTo(userData.getFirstName());
    }

    @Then("First {int} characters of the user's First Name is displayed on Setup menu dropdown after {string}")
    public void firstCharactersOfTheUserSFirstNameIsDisplayedOnSetupMenuDropdown(int charCount, String startText) {
        String actualText = StringUtils.strip(homePage.getHeaderText(), startText);
        String expectedUser = ((UserData) this.context.getScenarioContext().getContext(USER_DATA)).getFirstName();
        String expectedText = expectedUser.length() > charCount ?
                expectedUser.substring(0, charCount) + ELLIPSIS : expectedUser;
        Assertions.assertThat(actualText).as("Actual First name text is not equal to expected one")
                .isEqualTo(expectedText);
    }

    @Then("Profile photo icon on the upper right corner is default one")
    public void profilePhotoIconOnTheUpperRightCornerIsDefault() {
        String filePath = "ui/filesForUpload/%s";
        String fileName = "defaultAvatar.jpg";
        assertThat(homePage.isAvatarImageCorrect(filePath, fileName))
                .as("Profile photo icon on the upper right corner of the screen is not displayed")
                .isTrue();
    }

    @Then("Verify Legal Notice is not displayed")
    public void verifyNoticeIsNotDisplayed() {
        assertThat(homePage.isNoticeBoardDisplayed()).as("Legal Notice is displayed").isFalse();
    }

}