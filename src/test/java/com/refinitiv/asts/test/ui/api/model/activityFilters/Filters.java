package com.refinitiv.asts.test.ui.api.model.activityFilters;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class Filters {

    private Status status;
    private ApprovalStatus approvalStatus;
    private ReviewStatus reviewStatus;
    private QuestionnaireType questionnaireType;
    private DueDate dueDate;

    @Data
    @Accessors(chain = true)
    public static class DueDate {

        private Long dateFrom;
        private Long dateTo;
        private String filterType;
        private String type;
        private String operator;
        private DueDate condition1;
        private DueDate condition2;

    }

}