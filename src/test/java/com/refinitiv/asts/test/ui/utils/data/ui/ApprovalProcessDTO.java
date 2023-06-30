package com.refinitiv.asts.test.ui.utils.data.ui;

import lombok.Data;
import lombok.experimental.Accessors;
import org.openqa.selenium.WebElement;

@Data
@Accessors(chain = true)
public class ApprovalProcessDTO {

    private WebElement processName;
    private WebElement description;
    private WebElement status;
    private WebElement edit;
    private WebElement delete;
    private WebElement selectRadio;

}
