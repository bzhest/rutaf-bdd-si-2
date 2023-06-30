package com.refinitiv.asts.test.ui.utils.email.gmail;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.utils.email.EmailUtil;
import lombok.SneakyThrows;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.mail.*;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.lang.invoke.MethodHandles;
import java.util.*;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.EMAILS_TO_DELETE;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.START_TIME;
import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;

public class GmailUtil implements EmailUtil {

    private static final Logger LOGGER = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());
    public static final String NBSP = "&nbsp;";
    public static final String CENTRE = "centre";
    private final Map<String, Message> savedMessage = new HashMap<>();
    private Folder gmailFolder;
    protected ScenarioCtxtWrapper context;

    public GmailUtil(ScenarioCtxtWrapper context) {
        this.context = context;
    }

    @Override
    @SneakyThrows
    public String getLastMailBodyData(String recipient, String subject) {
        Message message;
        if (savedMessage.containsKey(subject)) {
            message = savedMessage.get(subject);
        } else {
            List<Message> messages = getNewMessagesBySubject(recipient, subject);
            if (messages.isEmpty()) {
                return StringUtils.EMPTY;
            }
            message = messages.get(messages.size() - 1);
        }
        return getMessageContent(message).replace(NBSP, StringUtils.SPACE);
    }

    @SneakyThrows
    @Override
    public String getMailSender(String subject) {
        return savedMessage.get(subject).getFrom()[0].getType();
    }

    @Override
    @SneakyThrows
    public boolean isMailWithSubjectExist(ScenarioCtxtWrapper context, String recipient, String subject) {
        List<Message> messages = getNewMessagesBySubject(recipient, subject);
        if (!messages.isEmpty()) {
            context.getScenarioContext().setContext(EMAILS_TO_DELETE, messages);
            savedMessage.put(subject, messages.get(messages.size() - 1));
        }
        return !messages.isEmpty();
    }

    @Override
    @SneakyThrows
    public void deleteAllNewMessagesForRecipient(String emailAddress) {
        deleteAllMessages(getAllNewMessagesForRecipient(emailAddress));
    }

    @Override
    @SneakyThrows
    public void deleteAllMessages() {
        deleteAllMessages(getAllMessages());
    }

    @Override
    @SneakyThrows
    public int getAllMessagesListSize() {
        return getAllMessages().size();
    }

    @SneakyThrows
    public void deleteAllMessages(List<Message> messages) {
        if (nonNull(messages)) {
            messages.forEach(this::deleteMessage);
            gmailFolder.close(true);
        }
    }

    private String getMessageContent(Message message) throws Exception {
        StringBuilder buffer = new StringBuilder();
        BufferedReader reader = new BufferedReader(new InputStreamReader(message.getInputStream()));
        String line;
        while ((line = reader.readLine()) != null) {
            buffer.append(line);
        }
        return buffer.toString();
    }

    private List<Message> getNewMessagesBySubject(String recipient, String subject) throws Exception {
        List<Message> list = new ArrayList<>();
        for (Message message : getAllNewMessagesForRecipient(recipient)) {
            if (message.getSubject().equals(subject)) {
                list.add(message);
            }
        }
        return list;
    }

    private List<Message> getAllNewMessagesForRecipient(String recipient) throws Exception {
        connect();
        Message[] messages = gmailFolder.getMessages();
        long testStartTime = (long) context.getScenarioContext().getContext(START_TIME);
        if (messages.length > 0) {
            List<Message> allMessagesForRecipient = new ArrayList<>();
            for (Message message : messages) {
                if (getRecipients(message).contains(recipient) && message.getReceivedDate().getTime() > testStartTime) {
                    allMessagesForRecipient.add(message);
                    LOGGER.info("Message with subject '" + message.getSubject() + "' was added");
                }
            }
            return allMessagesForRecipient;
        } else {
            return new ArrayList<>();
        }
    }

    private List<Message> getAllMessages() throws Exception {
        connect();
        Message[] messages = gmailFolder.getMessages();
        if (messages.length > 0) {
            List<Message> allMessagesForRecipient = new ArrayList<>();
            for (Message message : messages) {
                allMessagesForRecipient.add(message);
                LOGGER.info("Message with subject '" + message.getSubject() + "' was added");
            }
            return allMessagesForRecipient;
        } else {
            return new ArrayList<>();
        }
    }

    @SneakyThrows
    private void deleteMessage(Message message) {
        message.setFlag(Flags.Flag.DELETED, true);
        LOGGER.info("Message " + message.getSubject() + " is deleted");
    }

    @SneakyThrows
    private List<String> getRecipients(Message message) {
        Address[] recipients = message.getRecipients(Message.RecipientType.TO);
        return recipients.length == 0 ? new ArrayList<>() :
                Arrays.stream(recipients).map(Address::toString).collect(Collectors.toList());
    }

    private void connect() {
        if (isNull(gmailFolder) || !gmailFolder.isOpen()) {
            try {
                this.gmailFolder = GmailConnector.connect();
                LOGGER.info("Connected to Gmail");
            } catch (MessagingException e) {
                LOGGER.error("Error while connection to Gmail");
                e.printStackTrace();
            }
        }
    }

}