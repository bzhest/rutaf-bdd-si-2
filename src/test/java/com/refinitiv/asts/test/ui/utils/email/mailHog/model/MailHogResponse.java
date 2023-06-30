package com.refinitiv.asts.test.ui.utils.email.mailHog.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.google.gson.annotations.SerializedName;
import lombok.Data;
import lombok.SneakyThrows;
import org.apache.commons.text.StringEscapeUtils;

import javax.mail.internet.MimeUtility;
import java.util.ArrayList;
import java.util.List;

import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static org.apache.commons.lang3.StringUtils.*;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class MailHogResponse {

    private int count;
    private List<Message> items;

    @Data
    public static class Message {

        @SerializedName("ID")
        private String id;
        @SerializedName("Raw")
        private Raw raw;
        @SerializedName("Created")
        private String created;
        @SerializedName("Content")
        private Content content;

        @Data
        public static class Raw {

            @SerializedName("From")
            private String from;
            @SerializedName("To")
            private List<String> to;
            @SerializedName("Data")
            private String data;

            @SneakyThrows
            public String getData() {
                return StringEscapeUtils.unescapeHtml4(data).replaceAll(NBSP_CODE, SPACE)
                        .replaceAll(THREE_D, EQUALS_SIGN)
                        .replaceAll(CR, EMPTY)
                        .replaceAll(EQUALS_SIGN + LF, EMPTY);
            }

        }

        @Data
        public static class Content {

            @SerializedName("Headers")
            private Headers headers;

        }

        @Data
        public static class Headers {

            @SerializedName("Subject")
            private List<String> subject;

            @SneakyThrows
            public List<String> getSubject() {
                List<String> decodedSubject = new ArrayList<>();
                for (String s : subject) {
                    String decodeText = MimeUtility.decodeText(s).replace(DOUBLE_SPACE, SPACE);
                    decodedSubject.add(decodeText);
                }
                return decodedSubject;
            }

        }

    }

}