package com.refinitiv.asts.test.ui.testdatatypes.setUp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class MessageManagementData {

    private String updatedBy;
    private String createdDateTime;
    private Integer version;
    private String noticeId;
    private String content;
    private String publishTo;
    private Frequency frequency;
    private String updatedDateTime;
    private String effectiveDateTime;
    private String createdBy;
    private String name;
    private String agreementMessage;
    private String header;
    private String id;
    private String status;

    @Data
    @Accessors(chain = true)
    public static class Frequency {

        private String unit;
        private Integer value;

    }

}