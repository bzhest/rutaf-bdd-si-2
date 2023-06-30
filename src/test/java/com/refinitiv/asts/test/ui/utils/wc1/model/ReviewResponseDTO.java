package com.refinitiv.asts.test.ui.utils.wc1.model;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class ReviewResponseDTO {

    Boolean reviewRequired;
    String reviewRequiredDate;
    String reviewRemark;
    String reviewDate;

}