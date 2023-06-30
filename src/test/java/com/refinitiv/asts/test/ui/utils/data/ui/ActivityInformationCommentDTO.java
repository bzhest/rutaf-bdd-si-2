package com.refinitiv.asts.test.ui.utils.data.ui;

import lombok.Data;
import lombok.experimental.Accessors;
import org.openqa.selenium.WebElement;

@Data
@Accessors(chain = true)
public class ActivityInformationCommentDTO {

    private WebElement author;
    private WebElement date;
    private WebElement comment;
    private WebElement deleteIcon;
    private WebElement editIcon;

}
