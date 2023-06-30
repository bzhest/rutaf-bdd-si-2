package com.refinitiv.asts.test.ui.testdatatypes.thirdParty;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class QuestionnaireAnswersData {

    private String currency;
    private String currencyAmount;
    private String singleSelectValue;
    private String multiSelectValue;
    private String checkboxDefaultName;
    private String enhancedTextFirstNameField;
    private String textEntryPlusTextField;
    private String textEntryPlusTextValue;
    private String textEntryPlusNumberField;
    private String textEntryPlusNumberValue;
    private String numberValue;
    private String textValue;
    private String enhancedTextFirstNameValue;
    private String enhancedTextLastNameField;
    private String enhancedTextLastNameValue;
    private String checked;

}
