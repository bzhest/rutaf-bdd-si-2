package com.refinitiv.asts.test.ui.api.model.emailManagement;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class EmailTemplatesResponse {

    private List<EmailTemplate> records;

    @Data
    public static class EmailTemplate {

        private List<String> cc;
        private List<String> bcc;
        private String subject;
        private int notificationReminder;
        private boolean active;
        private String type;
        private String body;
        private String variableId;
        private long dateUpdated;
        private boolean currentUser;
        private long dateCreated;
        private boolean isDeleted;
        private String sender;
        private String notificationReminderLabel;
        private String name;
        private String _id;
        private String categoryId;
        private LanguagePreference languagePreference;

        @Data
        public static class LanguagePreference {

            private String languageId;

        }

    }

}