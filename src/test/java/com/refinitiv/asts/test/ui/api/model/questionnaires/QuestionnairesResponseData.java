package com.refinitiv.asts.test.ui.api.model.questionnaires;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class QuestionnairesResponseData {

    private String categoryId;
    private String createBy;
    private Long createTime;
    private String description;
    private Boolean draft;
    private String header;
    private String id;
    private Boolean internal;
    private String[] languageIds;
    private Object lastAvailableTab;
    private int maxScore;
    private int minScore;
    private String name;
    private String overAllCommentRequired;
    private Object[] questionnaireScores;
    private Object[] questionnaireTabs;
    private Object reviewer;
    private ReviewerProcessRules[] reviewerProcessRules;
    private String status;
    private Long updateTime;
    private String questionnaireReviewerId;
    private Object questionnaireReviewer;

}
