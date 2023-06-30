package com.refinitiv.asts.test.ui.utils.email;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import org.apache.commons.lang3.StringUtils;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public interface EmailUtil {

    String EMAIL_LINK_REGEX =
            "( |href=|\")((https:\\/\\/[-a-zA-Z0-9@:%._\\+~#=]{1,256}(.centre.rdd.refinitiv.com|.nightly.supplierintegrity.com)([-a-zA-Z0-9()@:;%_\\+.~#?&//=]*)))";
    String THIRD_PARTY_EMAIL_LINK_REGEX =
            "(https:\\/\\/[-a-zA-Z0-9@:%._\\+~#=]{1,256}\\/.[a-zA-Z0-9()]{1,256}=\\/[A-Za-z0-9_-]*)(\">)(.+?(?=<))";
    String AMP = "amp;";
    String DOT = ".";
    String NON_ASCII_EQUAL_DOT_SIGN = "=.";
    String HTTP = "http://";
    String HTTPS = "https://";
    String CENTRE_INCORRECT = "c=entre";
    String CENTRE = "centre";
    String ORDER_INCORRECT = "ord=erpage";
    String ORDER = "orderpage";

    void deleteAllNewMessagesForRecipient(String recipient);

    void deleteAllMessages();

    boolean isMailWithSubjectExist(ScenarioCtxtWrapper context, String recipient, String subject);

    int getAllMessagesListSize();

    String getLastMailBodyData(String recipient, String subject);

    String getMailSender(String subject);

    default String getLastMailLink(String mailData) {
        String link;
        mailData = mailData.replace(NON_ASCII_EQUAL_DOT_SIGN, DOT);
        Pattern pattern = Pattern.compile(EMAIL_LINK_REGEX);
        Matcher m = pattern.matcher(mailData);
        if (m.find()) {
            link = m.group(2);
        } else {
            throw new RuntimeException("Error while email link retrieval");
        }
        return link.replaceFirst(HTTPS, HTTP).replace(AMP, StringUtils.EMPTY).replace(CENTRE_INCORRECT, CENTRE)
                .replace(ORDER_INCORRECT, ORDER);
    }

    default Map<String, String> getLastMailLinks(String mailData) {
        Map<String, String> links = new HashMap<>();
        Pattern pattern = Pattern.compile(THIRD_PARTY_EMAIL_LINK_REGEX);
        Matcher m = pattern.matcher(mailData);
        while (m.find()) {
            links.put(m.group(1), m.group(3));
        }
        return links;
    }

}
