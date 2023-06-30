package com.refinitiv.asts.test.ui.utils.wc1.model;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class ResolutionResponse {

    String statusId;
    String riskId;
    String reasonId;
    String resolutionRemark;
    String resolutionDate;

}