package com.refinitiv.asts.test.ui.api.model.questionnaires;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class Options {

    private String[] branchedQuestionIdList;
    private String id;
    private int score;
    private String selected;
    private Object value;

}
