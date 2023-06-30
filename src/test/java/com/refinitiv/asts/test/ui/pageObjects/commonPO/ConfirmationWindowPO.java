package com.refinitiv.asts.test.ui.pageObjects.commonPO;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.xpath;

@Getter
public class ConfirmationWindowPO extends BasePO {

    private final By confirmationModal =
            xpath("//*[contains(@class,'ng-modal-confirm') or @class='MuiDialogContent-root' or @role='dialog']");
    private final By confirmModalButton =
            xpath("//button[@data-ng-click='confirmBtn()' or @id='submit' or @id='simpleModalSuccessButton' or @id='AlertDialog-ok']");
    private final By cancelModalButton =
            xpath("//button[@data-ng-click='cancelBtn()' or @id='cancel' or @id='simpleModalCancelButton' or @id='AlertDialog-cancel']");
    private final By closeModalButton =
            xpath("//button[@data-ng-click='closeDialog()' or @id='simpleModalSuccessButton' or @id='alertModalOkButton']");
    private final By okModalButton =
            xpath("//*[@class='ng-modal-confirm.visible-modal' or @class='ng-modal-confirm visible-modal' or @class='MuiDialogContent-root']//*[@data-ng-click='closeDialog()']");
    private final By closeNewModalButton =
            xpath("(//div[contains(@class, 'MuiDialog-paperScrollPaper MuiDialog-paperWidthXs')]//button)[1]");
    private final String buttonWithText =
            "//*[@class='ng-modal-confirm.visible-modal' or @class='ng-modal-confirm visible-modal'" +
                    " or @class='MuiDialogContent-root']//button[contains(text(), '%s')] | //*[@role='dialog']//button/span[text()='%<s']";
    private final By crossIconButton = xpath("//div[@data-ng-click='closeDialog()']");
    private final String alertDialog = "//*[@aria-describedby='alert-dialog-description']";
    private final String alertDialogButton = alertDialog + "//span[text()='%s']/..";
    private final By modalActivityList = xpath("//*[@aria-describedby='alert-dialog-description']//li");

    public ConfirmationWindowPO(WebDriver driver) {
        super(driver);
    }

    public ConfirmationWindowPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

}
