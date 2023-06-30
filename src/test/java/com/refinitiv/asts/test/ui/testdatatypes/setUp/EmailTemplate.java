package com.refinitiv.asts.test.ui.testdatatypes.setUp;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class EmailTemplate {

    String templateName;
    String category;
    String status;

}
