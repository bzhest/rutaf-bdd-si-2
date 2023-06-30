package com.refinitiv.asts.test.ui.testdatatypes.thirdParty;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
public class RiskRemediationQuestionnaireData {

    private String questionnaireName;
    private String question;
    private String answer;
    private String attachment;
    private String assignee;
    private String dateSubmitted;

}
