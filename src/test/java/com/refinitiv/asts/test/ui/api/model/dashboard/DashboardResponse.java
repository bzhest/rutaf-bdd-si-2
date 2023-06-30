package com.refinitiv.asts.test.ui.api.model.dashboard;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class DashboardResponse {

    private Payload payload;
    private String message;
    private String statusCode;

    @Data
    @NoArgsConstructor
    @JsonIgnoreProperties(ignoreUnknown = true)
    @Accessors(chain = true)
    public static class Payload {

        private List<RecordsItem> records;
        private PageInformation pageInformation;

        @Data
        public static class PageInformation {

            private int totalRecords;
            private int limit;
            private int totalPages;
            private int currentPage;

        }

        @Data
        @JsonIgnoreProperties(ignoreUnknown = true)
        public static class RecordsItem {

            private String supplierName;
            private String supplierId;
            private long dueDate;
            private boolean standalone;
            private String description;
            private Object updateTime;
            private Object createBy;
            private Object createTime;
            private String name;
            private Object userEmail;
            private String id;
            private Assignee assignee;
            private String status;

            @Data
            public static class Assignee {

                private Object userGroupId;
                private Object firstName;
                private Object lastName;
                private Object processed;
                private boolean emailed;
                private boolean notified;
                private String name;
                private Object updateTime;
                private Object type;
                private String email;
                private String status;

            }

        }

    }

}
