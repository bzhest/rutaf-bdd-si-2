package com.refinitiv.asts.test.ui.pageObjects.setUp.questionnaireManagement;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.WebDriver;

@Getter
public class QuestionnairePreviewPO extends BasePO {

    public QuestionnairePreviewPO(WebDriver driver) {
        super(driver);
    }

    private final String question = "(//*[@data-rbd-draggable-context-id])[%s]";
    private final String questionTitle = question + "/div/div/div/p";
    private final String questionHelpText = question + "//span[@width]/span/span";
    private final String fieldRequiredIndicator =
            question + "//span[text()='%s']/../following-sibling::span[text()='*']";

}
