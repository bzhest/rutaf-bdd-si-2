package com.refinitiv.asts.test.ui.utils.testRail;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class AddResultForCaseRequest {

    private int status_id;
    private String comment;
    private String defects;
    private String version;

}
