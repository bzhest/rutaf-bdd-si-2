package com.refinitiv.asts.test.ui.stepDefinitions.ui.home;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.home.NotificationPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.Assertions;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.NotificationsApi.getNotifications;
import static com.refinitiv.asts.test.ui.constants.APIConstants.*;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.VALUE_TO_REPLACE;
import static com.refinitiv.asts.test.ui.utils.DateUtil.getDateBeforeInEpoch;
import static java.lang.String.join;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;

public class NotificationSteps extends BaseSteps {

    private final NotificationPage notificationPage;

    public NotificationSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.notificationPage = new NotificationPage(this.driver);
    }

    @When("User clicks Notification Bell")
    public void clickNotificationButton() {
        notificationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        notificationPage.clickNotificationButton();
    }

    @When("User clicks {string} {string} notification")
    public void clickQuestionnaireAssignedActivity(String notification, String activity) {
        notificationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (activity.contains(ORDER_ID)) {
            activity = activity.replace(ORDER_ID, (String) context.getScenarioContext().getContext(ORDER_ID));
        }
        if (activity.equals(VALUE_TO_REPLACE)) {
            activity = (String) context.getScenarioContext().getContext(AD_HOC_ACTIVITY_CONTEXT_NAME);
        }
        if (activity.contains(THIRD_PARTY_NAME)) {
            String thirdPartyName = (String) context.getScenarioContext().getContext(THIRD_PARTY_NAME);
            activity = activity.replace(THIRD_PARTY_NAME, thirdPartyName);
        }
        notificationPage.clickNotification(notification, activity);
    }

    @Then("^\"(.*)\" notification (displayed|not displayed) with text$")
    public void notificationDisplayedWithText(String notification, String displayedState, List<String> texts) {
        List<String> textsList = new ArrayList<>(texts);
        if (texts.size() > 1) {
            textsList.set(1, (String) this.context.getScenarioContext().getContext(texts.get(1)));
        }
        String result = join(SPACE, textsList);
        if (context.getScenarioContext().isContains(ORDER_ID)) {
            result = result.replace(ORDER_ID, (String) context.getScenarioContext().getContext(ORDER_ID));
        }
        if (texts.get(0).equals(VALUE_TO_REPLACE)) {
            result = (String) context.getScenarioContext().getContext(AD_HOC_ACTIVITY_CONTEXT_NAME);
        }
        if (displayedState.equalsIgnoreCase(DISPLAYED)) {
            assertThat(notificationPage.isNotificationDisplayed(notification, result))
                    .as(notification + " notification is not displayed with text " + result)
                    .isTrue();
        } else {
            assertThat(notificationPage.isNotificationDisplayed(notification, result))
                    .as(notification + " notification is displayed with text " + result)
                    .isFalse();
        }
    }

    @Then("The list with notifications is shown")
    public void notificationsAreDisplayed() {
        assertThat(notificationPage.getNotificationsCount()).as("There are no notifications in the list").isPositive();
    }

    @Then("^The list with notifications is (displayed|closed)$")
    public void notificationsAreClosed(String displayState) {
        boolean isDisplayed = displayState.equals(DISPLAYED.toLowerCase()) ?
                notificationPage.isNotificationPopupDisplayed() :
                notificationPage.isNotificationsPopupClosed();
        assertThat(isDisplayed).as("Notification popup is not %s", displayState).isTrue();
    }

    @Then("Notification Bell Icon contains {int} new notification")
    public void notificationBellIconContainsNewNotification(int newNotificationCount) {
        assertThat(notificationPage.getNotificationCounter() >= newNotificationCount).as(
                        "Notification Bell Icon counter is unexpected")
                .isTrue();
    }

    @Then("Notification Bell Icon contains at least {int} new notification")
    public void notificationBellIconContainsAtLeastNewNotification(int newNotificationCount) {
        assertThat(notificationPage.getNotificationCounter()).as("Notification Bell Icon counter is unexpected")
                .isGreaterThan(newNotificationCount);
    }

    @Then("Notification Bell Icon counter is not displayed")
    public void notificationBellIconCounterIsNotDisplayed() {
        assertThat(notificationPage.isNotificationCounterInvisible()).as("Notification Bell Icon counter is visible")
                .isTrue();
    }

    @Then("The list with notifications contains notifications for the past {int} days")
    public void theListWithNotificationsContainsNotificationsForThePastDays(int daysLimit) {
        Long dateBeforeInEpoch = getDateBeforeInEpoch(daysLimit);
        UserData userTestData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        List<String> expectedList =
                getNotifications(userTestData.getUsername(), _ID, DESC, SCREEN).getObjects().stream()
                        .filter(notification -> notification.getCreate_time() >= dateBeforeInEpoch)
                        .collect(Collectors.toList()).stream()
                        .map(notification -> notification.getHeader().replace(SUPPLIER, THIRD_PARTY))
                        .collect(Collectors.toList());
        List<String> actualList = notificationPage.getNotificationList();
        assertThat(expectedList).as("Notification list is unexpected").containsAll(actualList);
    }

    @Then("Notification Bell is displayed")
    public void notificationBellIsDisplayed() {
        Assertions.assertThat(notificationPage.isNotificationBellDisplayed())
                .as("Notification Bell is not displayed")
                .isTrue();
    }

}