package com.refinitiv.asts.test.ui.stepDefinitions.util;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.ui.api.model.emailManagement.EmailTemplatesResponse;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.AssociatedPartyIndividualData;
import com.refinitiv.asts.test.ui.utils.email.EmailUtil;
import com.refinitiv.asts.test.ui.utils.email.gmail.GmailUtil;
import com.refinitiv.asts.test.ui.utils.email.mailHog.MailHogUtil;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import lombok.SneakyThrows;
import org.apache.commons.lang.RandomStringUtils;
import org.assertj.core.api.SoftAssertions;
import org.awaitility.core.ConditionTimeoutException;

import java.util.Locale;
import java.util.Map;

import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.RDDC_FULL_NAME;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.utils.AwaitUtil.await;
import static com.refinitiv.asts.test.ui.utils.email.gmail.EmailConfig.isGmailEmailUtil;
import static java.lang.String.format;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.*;

public class EmailStepDef extends BaseSteps {

    private static final String BRAND_NAME = "<Brand_Name>";
    private static final String SIGNATURE = "<Signature>";
    private static final String CLIENT_NAME = "<Client_Name>";
    private static final String WC1_RECORD_NAME = "<WC1_Record_Name>";
    private static final String CURRENT = "current";
    public static final String THIRD_PARTY_TYPE_PLACEHOLDER = "<Third_Party_Type>";
    public static final String USER_NAME_PLACEHOLDER = "<User_First_Name>";
    public static final String THIRD_PARTY_VALUE = "Third-party";
    private final EmailUtil emailUtil;
    private final String emailTemplate;
    private String email;
    private String subject;

    public EmailStepDef(ScenarioCtxtWrapper context) {
        super(context);
        if (isGmailEmailUtil()) {
            this.emailUtil = new GmailUtil(context);
            emailTemplate = Config.get().value("mail.username").replace("@", "+%s@");
        } else {
            this.emailUtil = new MailHogUtil(context);
            emailTemplate = "%s@lseg.com";
        }
        context.getScenarioContext().setContext(EMAIL_UTIL, emailUtil);
    }

    /**
     * Email constants - https://jira.refinitiv.com/browse/RMS-10004
     */
    private String getExpectedEmailSubject(String emailTemplateName, DataTable dataTable, String userReference) {
        EmailTemplatesResponse.EmailTemplate expectedEmailTemplate = getEmailTemplates().getRecords().stream()
                .filter(template -> template.getName().equals(emailTemplateName)).findFirst()
                .orElseThrow(() -> new RuntimeException(
                        "Email template with name '" + emailTemplateName + "' wasn't found"));
        subject = expectedEmailTemplate.getSubject()
                .replace(BRAND_NAME, RDDC_FULL_NAME)
                .replace(THIRD_PARTY_TYPE_PLACEHOLDER, THIRD_PARTY_VALUE)
                .replace(CLIENT_NAME, Config.get().value("client.name"));
        if (!userReference.equals(CURRENT) && nonNull(getUserCredentialsByRole(userReference).getFirstName())) {
            subject = subject.replace(USER_NAME_PLACEHOLDER, getUserCredentialsByRole(userReference).getFirstName());
        }

        if (nonNull(dataTable)) {
            Map<String, String> valuesToReplace = dataTable.asMap(String.class, String.class);
            for (String key : valuesToReplace.keySet()) {
                if (key.equals(WC1_RECORD_NAME)) {
                    String recordName =
                            (String) context.getScenarioContext().getContext(RECORD_NAME + valuesToReplace.get(key));
                    subject = subject.replace(key, recordName);
                } else {
                    subject = subject.replace(key, valuesToReplace.get(key));
                }
                if (subject.contains(THIRD_PARTY_NAME)) {
                    subject = subject.replace(THIRD_PARTY_NAME,
                                              (String) context.getScenarioContext().getContext(THIRD_PARTY_NAME));
                }
            }
        }
        logger.info("Expected subject: " + subject);
        return subject;
    }

    private String getEmail(String userReference) {
        if (userReference.equals(CURRENT)) {
            if (context.getScenarioContext().isContains(EMAIL_CONTEXT)) {
                email = (String) context.getScenarioContext().getContext(EMAIL_CONTEXT);
            } else {
                email = ((AssociatedPartyIndividualData) context.getScenarioContext()
                        .getContext(CONTACT_TEST_DATA)).getEmailAddress();
            }
        } else {
            email = getUserCredentialsByRole(userReference).getUsername();
        }
        return email;
    }

    @When("User creates valid email")
    public void createValidEmail() {
        String emailAddress;
        String randomValue = RandomStringUtils.randomAlphanumeric(10).toUpperCase(Locale.ROOT);
        emailAddress = format(emailTemplate, randomValue);
        if (emailUtil instanceof GmailUtil) {
            context.getScenarioContext().setContext(DELETE_EMAIL_FLAG_CONTEXT, true);
        }
        context.getScenarioContext().setContext(EMAIL_CONTEXT, emailAddress);
    }

    @When("User creates valid email with special symbols")
    public void createValidEmailWithSpecialSymbols() {
        String emailAddress;
        String randomValue = RandomStringUtils.randomAlphanumeric(10).toUpperCase(Locale.ROOT) + DASH + UNDERSCORE;
        emailAddress = format(emailTemplate, randomValue);
        if (emailUtil instanceof GmailUtil) {
            context.getScenarioContext().setContext(DELETE_EMAIL_FLAG_CONTEXT, true);
        }
        context.getScenarioContext().setContext(EMAIL_CONTEXT, emailAddress);
    }

    @When("User opens {string} email link")
    public void openEmailLink(String subject) {
        String lastMailLink = emailUtil.getLastMailLink(emailUtil.getLastMailBodyData(email, subject));
        driver.get(lastMailLink);
    }

    /**
     * Use it after call emailNotificationWithFollowingValuesIsReceivedByUser() step
     */
    @When("User opens email link")
    public void userOpensEmailLink() {
        driver.get(emailUtil.getLastMailLink(emailUtil.getLastMailBodyData(email, subject)));
    }

    @When("User deletes last emails for user {string}")
    public void deleteLastMessagesForEmailAddress(String userReference) {
        String email = getEmail(userReference);
        emailUtil.deleteAllNewMessagesForRecipient(email);
        logger.info("Last messages for " + email + " are deleted");
    }

    @When("User deletes all emails")
    public void deleteAllMessagesForEmailAddress() {
        emailUtil.deleteAllMessages();
        logger.info("All messages are deleted");
    }

    @SneakyThrows
    @Then("Emails list is empty")
    public void checkEmailsListIsEmpty() {
        assertThat(emailUtil.getAllMessagesListSize())
                .as("Not all emails were deleted")
                .isEqualTo(0);
    }

    @Then("Email notification {string} is received")
    public void emailNotificationIsReceived(String expectedSubject) {
        String email = getEmail(CURRENT);
        emailNotificationIsReceivedByEmail(expectedSubject, email);
    }

    @Then("Email notification {string} is not received")
    public void emailNotificationIsNotReceived(String expectedSubject) {
        emailNotificationIsNotReceivedByUser(expectedSubject, CURRENT);
    }

    @Then("Email notification {string} is received by {string} user")
    public void emailNotificationIsReceivedByUser(String expectedSubject, String userReference) {
        if (expectedSubject.contains(CLIENT_NAME)) {
            expectedSubject = expectedSubject.replace(CLIENT_NAME, Config.get().value("client.name"));
        }
        if (context.getScenarioContext().isContains(AD_HOC_ACTIVITY_CONTEXT_NAME)) {
            expectedSubject = String.format(expectedSubject,
                                            context.getScenarioContext().getContext(AD_HOC_ACTIVITY_CONTEXT_NAME));
        }
        if (context.getScenarioContext().isContains(QUESTIONNAIRE_NAME_CONTEXT)) {
            expectedSubject = String.format(expectedSubject,
                                            context.getScenarioContext().getContext(QUESTIONNAIRE_NAME_CONTEXT));
        }
        if (expectedSubject.contains(THIRD_PARTY_TYPE_PLACEHOLDER)) {
            expectedSubject =
                    expectedSubject.replace(THIRD_PARTY_TYPE_PLACEHOLDER, (String) context.getScenarioContext()
                            .getContext(THIRD_PARTY_NAME));
        }
        String email = getEmail(userReference);
        emailNotificationIsReceivedByEmail(expectedSubject, email);
    }

    @Then("Email notification {string} is not received by {string} user")
    public void emailNotificationIsNotReceivedByUser(String expectedSubject, String userReference) {
        if (context.getScenarioContext().isContains(AD_HOC_ACTIVITY_CONTEXT_NAME)) {
            expectedSubject = String.format(expectedSubject,
                                            context.getScenarioContext().getContext(AD_HOC_ACTIVITY_CONTEXT_NAME));
        }
        String email = getEmail(userReference);
        String finalExpectedSubject = expectedSubject;
        try {
            await("Await for email with subject: " + expectedSubject, 60, 1, 5)
                    .until(() -> emailUtil.isMailWithSubjectExist(context, email, finalExpectedSubject));
            throw new AssertionError(
                    format("Expected email with subject '%s' is received by %s user", expectedSubject, email));
        } catch (ConditionTimeoutException e) {
            assertFalse(format("Expected email with subject '%s' is received by %s user", expectedSubject, email),
                        emailUtil.isMailWithSubjectExist(context, email, finalExpectedSubject));
        }
    }

    @Then("Email notification {string} is received by {string} email")
    public void emailNotificationIsReceivedByEmail(String expectedSubject, String emailAddress) {
        email = emailAddress;
        subject = expectedSubject;
        try {
            await("Await for email with subject: " + expectedSubject, 180, 1, 5)
                    .until(() -> emailUtil.isMailWithSubjectExist(context, email, expectedSubject));
        } catch (ConditionTimeoutException e) {
            throw new AssertionError(
                    format("Expected email with subject '%s' is not received by %s user", expectedSubject, email));
        }
    }

    @Then("Email {string} contains the following text")
    public void emailContainsTheFollowingText(String subject, DataTable dataTable) {
        SoftAssertions softAssert = new SoftAssertions();
        String mailBody = emailUtil.getLastMailBodyData(email, subject);
        dataTable.asList().forEach(text -> {
            String formattedText = format(text, email);
            if (text.contains(USER_EDITED_FIRST_NAME)) {
                String editedFirstName = (String) context.getScenarioContext().getContext(USER_EDITED_FIRST_NAME);
                formattedText = formattedText.replace(USER_EDITED_FIRST_NAME, editedFirstName);
            } else if (text.contains(USER_FIRST_NAME)) {
                formattedText = context.getScenarioContext().isContains(USER_FIRST_NAME) ?
                        (String) context.getScenarioContext().getContext(USER_FIRST_NAME) :
                        formattedText.replace(USER_FIRST_NAME,
                                              (String) getUserDataByEmail(email, FIRST_NAME_FILTER));
            } else if (text.contains(CONTACT_TEST_DATA)) {
                AssociatedPartyIndividualData
                        contactTestData =
                        (AssociatedPartyIndividualData) context.getScenarioContext().getContext(CONTACT_TEST_DATA);
                String contactFirstName = contactTestData.getFirstName();
                formattedText = formattedText.replace(CONTACT_TEST_DATA, contactFirstName);
            } else if (text.contains(BRAND_NAME)) {
                formattedText = formattedText.replace(BRAND_NAME, Config.get().value("brand.name"));
            } else if (text.contains(SIGNATURE)) {
                formattedText = formattedText.replace(SIGNATURE, Config.get().value("email.signature"));
            }
            softAssert.assertThat(mailBody).as("Mail body doesn't contains expected text %s", formattedText)
                    .contains(formattedText);
        });
        softAssert.assertAll();
    }

    /**
     * Use it after call emailNotificationWithFollowingValuesIsReceivedByUser() step
     */
    @Then("Email contains the following text")
    public void emailForSubjectContainsTheFollowingText(DataTable dataTable) {
        String mailBody = emailUtil.getLastMailBodyData(email, subject);
        SoftAssertions softAssert = new SoftAssertions();
        dataTable.asList().forEach(text -> softAssert.assertThat(mailBody)
                .as("Mail body doesn't contains expected text")
                .contains(text)
        );
        softAssert.assertAll();
    }

    @Then("Email received by {string} user with template {string} contains created today third party in For Renewal status")
    public void emailContainsTheFollowingText(String userReference, String templateName) {
        String subject = getExpectedEmailSubject(templateName, null, userReference);
        String mailBody = emailUtil.getLastMailBodyData(email, subject).replace(EQUALS_SIGN, EMPTY);
        String thirdPartyName = (String) context.getScenarioContext().getContext(THIRD_PARTY_NAME);
        assertTrue("Mail body " + mailBody + " doesn't contains expected ThirdParty: " + thirdPartyName,
                   mailBody.contains(thirdPartyName));
    }

    /**
     * @param emailTemplateName e.g. Reset Password
     * @param userReference     for retrieve from context or get from property file
     * @param dataTable         contains map of elements for replacing
     *                          <p>
     *                          Note that method works only for authenticated user, in other case getEmailTemplates API call will fail.
     */
    @Then("Email notification {string} with following values is received by {string} user")
    public void emailNotificationWithFollowingValuesIsReceivedByUser(String emailTemplateName, String userReference,
            DataTable dataTable) {
        email = getEmail(userReference);
        subject = getExpectedEmailSubject(emailTemplateName, dataTable, userReference);
        emailNotificationIsReceivedByEmail(subject, email);
    }

    @Then("Email notification for template {string} is received by {string} user")
    public void emailNotificationTemplateIsReceivedByUser(String emailTemplateName, String userReference) {
        emailNotificationWithFollowingValuesIsReceivedByUser(emailTemplateName, userReference, null);
    }

    @Then("Email notification {string} with following values is not received by {string} user")
    public void emailNotificationWithFollowingValuesIsNotReceivedByUser(String emailTemplateName, String userReference,
            DataTable dataTable) {
        email = getEmail(userReference);
        String subject = getExpectedEmailSubject(emailTemplateName, dataTable, userReference);
        try {
            await("Await for email with subject: " + subject, 60, 1, 5)
                    .until(() -> emailUtil.isMailWithSubjectExist(context, email, subject));
            throw new AssertionError(
                    format("Unexpected email notification %s is received by %s user", subject, email));
        } catch (ConditionTimeoutException e) {
            logger.info(format("Email notification %s is not received by %s user within 30 seconds", subject, email));
        }

    }

    @Then("Email received by {string} user with template {string} contains links to Third-parties profiles")
    public void thirdPartiesEmailBodiesLinksShouldOpenThirdPartiesProfiles(String userReference, String templateName) {
        String subject = getExpectedEmailSubject(templateName, null, userReference);
        String emailBody = emailUtil.getLastMailBodyData(email, subject);
        Map<String, String> lastMailLinks = emailUtil.getLastMailLinks(emailBody);
        String thirdPartyName = (String) context.getScenarioContext().getContext(THIRD_PARTY_NAME);
        for (String key : lastMailLinks.keySet()) {
            driver.get(key.replaceAll("=", EMPTY));
            assertEquals("Third Party name is incorrect", lastMailLinks.get(key), thirdPartyName);
        }
    }

    @Then("Email notification sender is {string}")
    public void emailNotificationSenderIs(String expectedResult) {
        assertThat(emailUtil.getMailSender(subject)).as("Email %s sender is unexpected", subject)
                .isEqualTo(expectedResult);
    }

}
