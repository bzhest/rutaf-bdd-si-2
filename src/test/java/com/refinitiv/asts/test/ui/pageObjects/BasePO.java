package com.refinitiv.asts.test.ui.pageObjects;

import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;

@Getter
public class BasePO {

    protected LanguageConfig translator;
    protected final WebDriver driver;
    private final String deleteRowWithNameButton =
            "//tbody//td//*[text()='%s']/ancestor::tr//*[@title='Delete']";
    private final String editRowWithNameButton =
            "//tbody//td//*[text()='%s']/ancestor::tr//*[@title='Edit']";
    private final String rowWithName = "//tbody/tr//*[contains(., '%s')]/ancestor::tr";
    private final String cellsWithIndex = "table tr td:nth-child(%s)";
    private final By alertIconMessage = cssSelector("[class*='MuiAlert-message']");
    private final By closeAlertIcon =
            xpath("//*[@id='toastMessageButton'] | //*[contains(@class, 'MuiAlert-action')]//*[@aria-label='Close' or text()='Close'] | //*[@class='toast-close pull-right']");
    private final By preloader = cssSelector("[role=progressbar]");
    private final By loadingImage = cssSelector("[data-title=Loading]:not(#redirectionLoader)");
    private final String errorHighlightedFormField =
            "//*[text()='%s']/../../../..//*[contains(@class, 'error') or contains(@class, 'validationError')]";
    private final String formFieldErrorMessage =
            "//*[contains(., '%s')]/parent::label/following-sibling::p[contains(@class, 'error')]";
    private final String requiredFormField =
            "//*[contains(., '%s')]/following-sibling::span[contains(@class, 'asterisk')]";
    private final By toastMessage = cssSelector("#message, [class^=MuiAlert-icon]");
    private final By toastMessageCloseButton =
            cssSelector("[class*='toast-close pull-right'], #toastMessageButton, .MuiAlert-action>button[title=Close]");
    private final By toastMessageContent = cssSelector("[class*='toast-confirmation-content'], .MuiAlert-message");
    private final By toastMessageHeader = cssSelector(".confirmation-success.ng-binding");
    private final By body = cssSelector("body");
    private final By confirmDeleteButton = xpath("//span[text()='Delete']/parent::button");
    private final By deleteConfirmationDialog = cssSelector("[role=dialog]");
    protected final String dropDownOption =
            "//p[@id='item' and contains(.,\"%s\")] | //li[@role='option' and text()=\"%<s\"] | //li[@role='option']//*[text()[contains(., \"%<s\")]]";
    protected final By dropDownOptions = cssSelector("li[role=option]");
    protected final By dropDownFirstOption = xpath("//li[@role='option'][1]");
    protected final By modalWindow = cssSelector(".modal");
    protected final String button = "//*[text()='%s']/ancestor::button";
    protected final String buttonText = button + "//span";
    protected final String tabOnModal = "(//span[contains(text(),'%s')]/ancestor::button)[2]";
    protected final By parentElement = xpath("parent::*");
    protected final By row = xpath("//tbody/tr");
    protected final By saveButton = xpath("//*[@class='MuiButton-label' and text() = 'Save']");
    protected final By dropDownItems =
            xpath("//*[@data-ng-show='isListDisplayed()' and not(contains(@class, 'ng-hide'))]//*[@id = 'item'] | //li[@role='option']");
    protected final By input = cssSelector("input");
    protected final By tooltip = cssSelector("[role=tooltip]");
    protected final By tableHeaders = cssSelector("thead th");
    protected final By tableRows = cssSelector("tbody tr");
    protected final By tableRowColumns = cssSelector("td");
    private final String columnHeader = "//thead//span[text()='%s']/ancestor::th";
    protected final By reviewerMethods = xpath("//*[@role='radiogroup']/label");
    private final String rowColumn = "td[%s]";
    private final By breadcrumbs = xpath("//ol[contains(@class, 'Breadcrumbs')]");

    public BasePO(WebDriver driver) {
        this.driver = driver;
    }

    public BasePO(WebDriver driver, LanguageConfig translator) {
        this(driver);
        this.translator = translator;
    }

}

