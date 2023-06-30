package com.refinitiv.asts.test.ui.testdatatypes.setUp;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
public class QuestionCustomFieldRequest {

    List<String> languageSetup;

}
