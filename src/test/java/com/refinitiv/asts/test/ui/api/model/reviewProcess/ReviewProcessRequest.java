package com.refinitiv.asts.test.ui.api.model.reviewProcess;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class ReviewProcessRequest {

    private String name;
    private String description;
    private String type;
    private String status;
    private ReviewProcessRules[] reviewProcessRules;
    private Reviewers[] reviewers;

}