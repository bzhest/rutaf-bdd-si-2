package com.refinitiv.asts.test.ui.api.model.questionnaires;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class QuestionnaireRequest {

    private String action;
    private String categoryId;
    private String description;
    private Boolean draft;
    private String header;
    private String internal;
    private Boolean isDraft;
    private String[] languageIds;
    private int maxScore;
    private int minScore;
    private String name;
    private Object[] questionnaireScores;
    private Object[] questionnaireTabs;
    private Reviewer reviewer;
    private Object[] reviewerProcessRules;
    private String status;
    private String questionnaireReviewerId;
    private Object questionnaireReviewer;

}
