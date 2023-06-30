package com.refinitiv.asts.test.ui.testdatatypes.thirdParty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import org.openqa.selenium.WebElement;

import java.util.List;

@Data
@AllArgsConstructor
@Accessors(chain = true)
@Builder
public class ActivityInformationData {

    public String activityType;
    public String activityName;
    public String description;
    public String riskArea;
    public String orderDetails;
    public String startDate;
    public String dueDate;
    public String lastUpdate;
    public String priority;
    public String assessment;
    public String assignee;
    public String initiatedBy;
    public String status;
    private List<Approver> approvers;

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    @Accessors(chain = true)
    public static class Approver {

        private String assignedTo;
        private String lastUpdate;
        private String action;
        private String status;

    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    @Builder
    @Accessors(chain = true)
    public static class ActivityQuestionnaireDetails {

        private String questionnaireName;
        private String status;
        private String assignee;
        private String reviewer;
        private String overallAssessment;
        private String score;
        private String button;

    }

    @Data
    @Accessors(chain = true)
    public static class QuestionnaireDetails {

        private WebElement name;
        private WebElement status;
        private WebElement assignee;
        private WebElement reviewer;
        private WebElement reviewerAssessment;
        private WebElement score;
        private WebElement scoreCategory;
        private WebElement actions;

    }

    @Data
    @Accessors(chain = true)
    public static class ReviewTask {

        private String name;
        private String referenceId;
        private String reviewer;
        private String reviewStatus;
        private String dueDate;
        private String type;
        private String buttonName;

    }

}
