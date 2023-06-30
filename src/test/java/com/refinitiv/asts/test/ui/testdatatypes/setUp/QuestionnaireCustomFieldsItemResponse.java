package com.refinitiv.asts.test.ui.testdatatypes.setUp;

import lombok.Data;

@Data
public class QuestionnaireCustomFieldsItemResponse {

    private String name;
    private boolean available;
    private String customFieldId;
    private Object assignedQuestionId;
    private String type;
    private boolean usePredefinedValues;

}