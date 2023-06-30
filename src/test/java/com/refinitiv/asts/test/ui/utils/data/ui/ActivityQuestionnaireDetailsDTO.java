package com.refinitiv.asts.test.ui.utils.data.ui;

import lombok.Data;
import lombok.experimental.Accessors;
import org.openqa.selenium.WebElement;

@Data
@Accessors(chain = true)
public class ActivityQuestionnaireDetailsDTO {

    private WebElement row;
    private WebElement questionnaireName;
    private WebElement status;
    private WebElement state;

}