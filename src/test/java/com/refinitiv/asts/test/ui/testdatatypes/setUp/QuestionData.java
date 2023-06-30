package com.refinitiv.asts.test.ui.testdatatypes.setUp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class QuestionData {

    String froalaText;
    String helpText;
    List<Choice> choices;
    List<SubQuestion> subQuestions;
    Boolean isResponseMandatory;
    Boolean isAttachmentAllowed;
    Boolean isCalculateHighestScoreOnly;
    List<BranchQuestion> branchQuestion;
    String reviewerLevel;

    @Data
    @Accessors(chain = true)
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Choice {

        String choice;
        String score;
        Boolean isRedFlag;

    }

    @Data
    @Accessors(chain = true)
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class SubQuestion {

        String subQuestionName;
        String type;
        Boolean isMandatory;
        String option;

    }

    @Data
    @Accessors(chain = true)
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class BranchQuestion {

        String isChoiceIs;
        String tabName;
        String question;

    }

}
