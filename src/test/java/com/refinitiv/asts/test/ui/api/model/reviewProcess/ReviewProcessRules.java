package com.refinitiv.asts.test.ui.api.model.reviewProcess;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class ReviewProcessRules {

    private String method;
    private Object reviewers;
    private Object coverage;

}