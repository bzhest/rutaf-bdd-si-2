package com.refinitiv.asts.test.ui.testdatatypes.setUp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class QuestionnaireData {

    //    Information Tab
    public String questionnaireName;
    public List<String> questionnaireNames;
    public String category;
    public String description;
    public String header;
    public List<String> language;
    public String assigneeType;
    //    Question details
    public String scoringName;
    public String scoringRangeFrom;
    public String scoringRangeTo;
    public String scoringRange;
    public String levelOfReviewer;
    public String questionName;
    public String questionType;
    public String assignee;
    public String dateCompleted;
    public String overallScore;
    public String helpText;

}
