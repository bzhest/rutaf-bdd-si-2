package com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.id;
import static org.openqa.selenium.By.xpath;

@Getter
public class OrderConfirmationPO extends BasePO {

    private final By confirmationBlock = id("order-page-summary-button");
    private final String confirmationBlockButton = "//b[contains(text(), '%s')]";
    private final By confirmationBlockRetryButton = xpath("//b[contains(text(), 'retry')]/../..");
    private final By confirmationSummaryMessage = xpath("//*[@id='order-page-summary-button']//h6");

    //Order Details and Subject details
    private final String orderAndSubjectHeaders = "//label[contains(text(), '%s')]";
    private final String orderAndSubjectValues = orderAndSubjectHeaders + "/following-sibling::div/input";

    private final By dueDiligenceScopeName =
            xpath("//h6[text()='Due Diligence Scope']/../following-sibling::div[1]//h6");
    private final By dueDiligenceScopeDescription =
            xpath("//h6[text()='Due Diligence Scope']/../following-sibling::div[2]");

    //Additional Add-Ons
    private final By additionalAddOnsSection = xpath("//h6[text()='Additional Add-Ons']/../..");

    //List of Key Principal(s)
    private final By listOfKeyPrincipalsSection = id("keyPrincipalTable");

    //List of selected questionnaire
    private final By listOfQuestionnairesSection = id("ddo-questionnaire-table");

    //Attachment
    private final By attachmentSection = xpath("//p[text()='Attachments']");

    //Comment
    private final By commentSection = xpath("//p[text()='Comments']");

    //Questionnaire
    private final By questionnaireTableColumns = xpath("//*[@id='ddo-questionnaire-table']//thead//th");
    private final By selectedQuestionnaireTableRows = xpath("//*[@id='ddo-questionnaire-table']//tbody/tr");
    private final String tableRowValue = "td[%s]";

    public OrderConfirmationPO(WebDriver driver) {
        super(driver);
    }

}
