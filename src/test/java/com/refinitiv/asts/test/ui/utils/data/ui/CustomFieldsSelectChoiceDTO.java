package com.refinitiv.asts.test.ui.utils.data.ui;

import lombok.Data;
import lombok.experimental.Accessors;
import org.openqa.selenium.WebElement;

@Data
@Accessors(chain = true)
public class CustomFieldsSelectChoiceDTO {

    private WebElement choiceField;
    private WebElement choiceLabel;
    private WebElement plusButton;
    private WebElement deleteButton;
    private WebElement redFlagToggle;

}
