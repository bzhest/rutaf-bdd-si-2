package com.refinitiv.asts.test.ui.api.model.questionnaires;

import lombok.Data;

import java.util.List;

@Data
public class QuestionnaireResponse {

    private List<QuestionnairesResponseData> objects;
    private int total;

}
