package com.refinitiv.asts.test.ui.api.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class OrderApproval {

    private Assignee defaultAssignee;
    private List<ProcessRule> processRules;

    @Data
    @Accessors(chain = true)
    public static class ProcessRule {

        private Assignee assignee;
        private String rule;
        private List<String> coverage;
        private String method;

    }

    @Data
    @Accessors(chain = true)
    public static class Assignee {

        private String type;
        private String name;
        private String email;

    }

}
