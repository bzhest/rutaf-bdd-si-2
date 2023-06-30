package com.refinitiv.asts.test.ui.pageObjects.setUp.workflowManagement.workflow;

import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class ReviewerTabPO extends WorkflowPO {

    private final By buttonAddReviewer = cssSelector("[id='contactSectionAdd Reviewer']");
    private final By buttonAddExistingRule = xpath("//*[text()='ADD EXISTING Reviewer PROCESS']/ancestor::button");
    private final String buttonRemoveRule = "(//p[text()='Reviewer']/../div/div[%s]//button)[1]";
    private final By firstRow = xpath("//tbody/tr[1]/td[2]");
    private final By tableReviewProcess = xpath("//table");
    private final By pageTitle = xpath("//li[contains(@class, 'MuiBreadcrumbs')]//h6");
    private final By inputDefaultReviewer =
            xpath("//p[text()='Default Reviewer']/..//span[text()='Reviewer']/../../following-sibling::div//input");
    private final By reviewProcessOverviewPage = xpath("//li/h6[not(text()='Review Process')]");
    private final String sectionFields =
            "(//nav/following-sibling::div[contains(@class, 'MuiBox')])[%s]//div[not(@role='radiogroup')]/label";
    private final By tableColumns = xpath("//th");
    private final By tableRowsNameValues = xpath("//tbody//tr/td[2]");
    private final String inputReviewer =
            "(//p[text()='Reviewer']/../div/div/div)[%s]//span[text()='%s']/../../following-sibling::div//input";
    private final String inputReviewerValue =
            "//p[text()='Reviewer']/../div/div[%s]//*[text()='%s']/../../following-sibling::div//input/..//span[contains(@class, 'MuiChip')]";
    private final String radioButtonReviewerMethod = "(//input[@type='radio' and @value='%s'])[%s]";
    private final String radioButtonReviewerMethodLabel =
            "//p[text()='Reviewer']/../div/div[%s]//input[@type='radio' and @checked]/../../following-sibling::span";
    private final String radioButtonReviewProcess = "//td//*[text()='%s']/ancestor::tr//input";
    private final By reviewRules =
            xpath("//div[@id='reviewer-section']//*[contains(@class, 'MuiGrid-spacing')]/div[1] | //p[text()='Reviewer']/../div/div/div//div[@style]");
    private final String reviewRule =
            "(//div[@id='reviewer-section']//*[contains(@class, 'MuiGrid-spacing')]/div[1])[%s] | (//p[text()='Reviewer']/../div/div/div//div[@style])[%<s]";
    private final By noReviewProcessAvailable =
            xpath("//h6[text()='No Available Data'] | //h6[text()='No Match Found']");
    private final String processNameInTable = "//td//*[text()='%s']";

    public ReviewerTabPO(WebDriver driver) {
        super(driver);
    }

}
