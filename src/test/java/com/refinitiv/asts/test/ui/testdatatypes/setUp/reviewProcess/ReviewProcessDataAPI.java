package com.refinitiv.asts.test.ui.testdatatypes.setUp.reviewProcess;

import com.refinitiv.asts.test.ui.api.model.reviewProcess.ReviewProcessRules;
import com.refinitiv.asts.test.ui.api.model.reviewProcess.Reviewers;
import lombok.Data;

@Data
public class ReviewProcessDataAPI {

    private String name;
    private String description;
    private String type;
    private String status;
    private ReviewProcessRules reviewProcessRules;
    private Reviewers reviewers;

}