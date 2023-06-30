package com.refinitiv.asts.test.ui.utils.data.ui;

import lombok.Data;
import lombok.experimental.Accessors;
import org.openqa.selenium.WebElement;

@Data
@Accessors(chain = true)
public class ReviewProcessDTO {

    private WebElement name;
    private WebElement description;
    private WebElement status;
    private WebElement edit;
    private WebElement delete;

}