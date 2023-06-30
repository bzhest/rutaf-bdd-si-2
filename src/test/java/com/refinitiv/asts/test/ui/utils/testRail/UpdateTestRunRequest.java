package com.refinitiv.asts.test.ui.utils.testRail;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class UpdateTestRunRequest {

    private Integer[] case_ids;
    private boolean include_all;

}
