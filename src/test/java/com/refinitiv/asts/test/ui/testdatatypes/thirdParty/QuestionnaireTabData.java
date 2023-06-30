package com.refinitiv.asts.test.ui.testdatatypes.thirdParty;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class QuestionnaireTabData {

    private String questionnaireName;
    private String status;
    private String assignee;
    private String reviewer;
    private String reviewerAssessment;
    private String score;
    private String scoreCategory;
    private String dateCreated;

}
