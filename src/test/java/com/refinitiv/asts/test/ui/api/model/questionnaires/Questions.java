package com.refinitiv.asts.test.ui.api.model.questionnaires;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class Questions {

    private String acceptedBranchedQuestionIds;
    private String answer;
    private String approvedMapping;
    private String assessment;
    private String attachment;
    private String category;
    private int commentCount;
    private String defaultLanguage;
    private String enhancedTextEntryPlusQuestions;
    private String hasAcceptedScore;
    private String hasActiveParentRevision;
    private String hasNewRevision;
    private String hasNewRevisionAnswer;
    private String hasNewSentComment;
    private String isComputeHighScore;
    private String mandatory;
    private String mappedCategory;
    private String mappedField;
    private String questionComments;
    private String questionRevisions;
    private String relatedFile;
    private String reviewMappingRequired;
    private String reviewedMapping;
    private String revision;
    private int revisionCount;
    private String score;
    private String scoreComputedInParent;
    private String selectedOptions;
    private String taggedAsRedFlag;
    private String textEntryPlusQuestions;
    private String type;
    private String visibleWhen;
    private String autoScreen;
    private String id;
    private Object title;
    private Object helpText;
    private Options[] options;

}
