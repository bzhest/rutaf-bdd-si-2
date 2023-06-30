package com.refinitiv.asts.test.ui.pageObjects.setUp;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static com.refinitiv.asts.test.ui.constants.TestConstants.LAST_ELEMENT;
import static java.lang.String.format;
import static org.openqa.selenium.By.*;

@Getter
public class ReviewProcessPO extends BasePO {

    public ReviewProcessPO(WebDriver driver) {
        super(driver);
    }

    private final By addReviewProcessButton = By.cssSelector("#add-new-review");
    private final By dropdownCrossIcon = By.cssSelector("[class*=deleteIconSmall]");
    private final By name = xpath("td[1]");
    private final By tableDescription = xpath("td[2]");
    private final By status = xpath("td[3]");
    private final By edit = xpath("td[4]//*[@title='Edit']");
    private final By delete = xpath("td[4]//*[@title='Delete']");
    private final String footerButtons = "button[id*=%s]";
    private final String errorMessage =
            "//span[text()='%s']/ancestor::label/following-sibling::p[text()='This field is required']";
    private final By editButton =
            xpath("(//*[@id='general-info-section']//*[contains(@class, 'Svg')])[1] | //*[@title='Edit']");
    private final String editPage = "//*[text()='Review Process']/ancestor::li/following-sibling::li//*[text()='%s']";
    private final String modalField =
            "//*[text()='%s']/ancestor-or-self::label/following-sibling::div/descendant-or-self::*[contains(@class, 'Radio') " +
                    "or contains(@class, 'InputBase-root')] | //*[text()='%<s']/preceding-sibling::*[contains(@class, 'Checkbox')]";

    private final String modalFieldInput = "//*[text()='%s']/ancestor::label/following-sibling::div/*";
    private final String rowValue = "//span[text()='%s']/ancestor::td";
    private final String deleteButton = rowValue + "/parent::tr//*[@title='Delete' or @aria-label='delete-review']";
    private final String editRowButton = rowValue + "/parent::tr//*[@title='Edit']";
    private final String rowButton = "//tr//*[@title='%s' or contains(@aria-label, '%s')]";
    private final String itemInDropdown = "//*[contains(@id, 'popup')]//li//*[contains(., '%s')]";
    private final String overviewHeader = "//h6[text()='Review Process']";
    private final By emptyTableMessage = xpath(overviewHeader + "/following-sibling::div//h6");
    private final By tableColumns = xpath("//th");
    private final By breadcrumb = xpath("//nav");
    private final By breadcrumbButton = xpath("//nav//button");

    /**
     * Main Block
     */
    private final String mainBlockField = "//*[@id='general-info-section']//*[text()='%s']/ancestor-or-self::label";
    private final By processNameInput = By.cssSelector("[name=reviewProcessName]");
    private final By description = By.cssSelector("[name=description]");
    private final By activeCheckbox = xpath("//*[@name='isActive']/ancestor::*[contains(@class, 'MuiCheckbox')]");

    /**
     * Default Reviewer
     */
    private final String defaultReviewerField =
            "//*[@id='default-reviewer-section']//*[text()='%s']/ancestor-or-self::label";
    private final By defaultReviewerInput =
            xpath("//p[text()='Default Reviewer']/..//span[text()='Reviewer']/../../../..//input");
    private final By dropDownItems =
            xpath("//*[@id = 'item'] | //li[@role='option'] | //*[contains(@id, 'popup')]//li//div");

    /**
     * Reviewer
     */
    private final String reviewerField = "//*[@id='reviewer-section']//div[text()='%s']" +
            "/ancestor::div[contains(@class, 'MuiGrid-container')]//label/descendant-or-self::*[text()='%s']";
    private final String dropDownAddRulesFor =
            "(//p[text()='Reviewer']/../div/div/div)[%s]//span[text()='Add Rules For']/../../following-sibling::div//input";
    private final By addRulesForInput = xpath(format(dropDownAddRulesFor, LAST_ELEMENT));
    private final String dropDownActivityOwner =
            "(//*[@aria-label='Reviewer Rules - Activity Owner']//input)[%s]";
    private final By activityOwnerInput = xpath(format(dropDownActivityOwner, LAST_ELEMENT));
    private final String dropDownReviewer = "(//*[@aria-label='Reviewer Rules - Reviewer']//input)[%s]";
    private final By reviewerInput = xpath(format(dropDownReviewer, LAST_ELEMENT));
    private final By reviewerInputButton = xpath(format(dropDownReviewer, LAST_ELEMENT) +
                                                         "/following-sibling::div//button[@title='Open' or @title='Close']");
    private final String reviewerMethod = "[name*=radio-button][value=%s]";
    private final By addReviewerButton = id("contactSectionAdd Reviewer");
    private final String removeReviewerBlockIcon = "//div[text()='%s']/parent::*/following-sibling::div/button";
    private final String ruleValues =
            "//*[text()='%s']/ancestor::label/following-sibling::div/div/span[contains(@class, 'label')]";
    private final String ruleInput = "//*[text()='%s']/ancestor::label/following-sibling::div/input";
    private final String ruleInputButton =
            "//*[text()='%s']/ancestor::label/following-sibling::div//button[@title='Open' or @title='Close']";
    private final By reviewerValues =
            xpath("//*[text()='Reviewer']/ancestor::label/following-sibling::div/div/span[contains(@class, 'label')]");
    private final By selectedMethod =
            xpath("//input[@type='radio']/ancestor::label/span[contains(@class, 'checked')]/following-sibling::span");
    private final String inputAsterisk = "(//span[contains(., '%s')]/following-sibling::span)[%s]";
    private final By ruleNumber =
            xpath("//*[@id='reviewer-section']//*[contains(@class, 'MuiGrid-container')]/div[1]/div");

}