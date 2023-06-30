package com.refinitiv.asts.test.ui.utils.email.mailHog;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.utils.email.EmailUtil;
import com.refinitiv.asts.test.ui.utils.email.mailHog.model.MailHogResponse;
import org.apache.commons.lang3.StringUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.START_TIME;
import static com.refinitiv.asts.test.ui.constants.Pages.SLASH;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static com.refinitiv.asts.test.ui.utils.email.mailHog.MailHogApiRouter.getMailHogClient;
import static com.refinitiv.asts.test.ui.utils.email.mailHog.MailHogApiRouter.isWSO2MailHogClient;
import static com.refinitiv.asts.test.ui.utils.email.mailHog.MailHogEndpoints.*;
import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;

public class MailHogUtil implements EmailUtil {

    private static final String KIND = "kind";
    private static final String TO = "to";
    private static final String QUERY = "query";
    private MailHogApiClient mailHogApi;
    private final Map<String, MailHogResponse.Message> savedMessage = new HashMap<>();
    private final ScenarioCtxtWrapper context;

    public MailHogUtil(ScenarioCtxtWrapper context) {
        this.context = context;
    }

    @Override
    public void deleteAllMessages() {
        mailHogApi = getMailHogClient(false);
        mailHogApi.delete(DELETE_MESSAGE.getPath());
        mailHogApi = getMailHogClient(true);
        mailHogApi.delete(DELETE_MESSAGE.getPath());
    }

    @Override
    public void deleteAllNewMessagesForRecipient(String recipient) {
        mailHogApi = getMailHogClient(false);
        getAllMessagesForRecipient(recipient).forEach(
                message -> mailHogApi.delete(DELETE_MESSAGE.getPath() + SLASH + message.getId()));
    }

    @Override
    public int getAllMessagesListSize() {
        mailHogApi = getMailHogClient(false);
        int siEmailCount = getAllMessagesResponse().getCount();
        mailHogApi = getMailHogClient(true);
        int wso2EmailCount = getAllMessagesResponse().getCount();
        return siEmailCount + wso2EmailCount;
    }

    @Override
    public String getLastMailBodyData(String recipient, String subject) {
        mailHogApi = getMailHogClient(isWSO2MailHogClient(subject));
        if (savedMessage.containsKey(subject)) {
            return savedMessage.get(subject).getRaw().getData();
        } else {
            MailHogResponse.Message message = getNewMessageBySubjectAndRecipient(recipient, subject);
            return isNull(message) ? StringUtils.EMPTY : message.getRaw().getData();
        }
    }

    @Override
    public boolean isMailWithSubjectExist(ScenarioCtxtWrapper context, String recipient, String subject) {
        MailHogResponse.Message message = getNewMessageBySubjectAndRecipient(recipient, subject);
        if (nonNull(message)) {
            savedMessage.put(subject, message);
        }
        return nonNull(message);
    }

    @Override
    public String getMailSender(String subject) {
        return savedMessage.get(subject).getRaw().getFrom();
    }

    private MailHogResponse.Message getNewMessageBySubjectAndRecipient(String recipient, String subject) {
        mailHogApi = getMailHogClient(isWSO2MailHogClient(subject));
        List<MailHogResponse.Message> allMessagesForRecipient = getAllMessagesResponse().getItems();
        return filterMessagesByRecipientSubjectAndTime(recipient, subject, allMessagesForRecipient);
    }

    private MailHogResponse.Message filterMessagesByRecipientSubjectAndTime(String recipient, String subject,
            List<MailHogResponse.Message> allMessages) {
        long testStartTime = (long) context.getScenarioContext().getContext(START_TIME);
        for (MailHogResponse.Message message : allMessages) {
            if (message.getRaw().getTo().get(0).equals(recipient)
                    && getLongFromMailDateString(message.getCreated()) > testStartTime
                    && message.getContent().getHeaders().getSubject().get(0).equals(subject)) {
                return message;
            }
        }
        return null;
    }

    private List<MailHogResponse.Message> getAllMessagesForRecipient(String recipient) {
        Map<String, String> params = new HashMap<>();
        params.put(KIND, TO);
        params.put(QUERY, recipient);
        MailHogResponse mailHogResponse = mailHogApi.get(SEARCH_MESSAGES.getPath(), params).as(MailHogResponse.class);
        return mailHogResponse.getItems();
    }

    private MailHogResponse getAllMessagesResponse() {
        return mailHogApi.get(RETRIEVE_MESSAGES_LIST.getPath()).as(MailHogResponse.class);
    }

}
