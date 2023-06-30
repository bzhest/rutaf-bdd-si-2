package com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static java.lang.String.format;
import static org.openqa.selenium.By.*;

@Getter
public class ScreeningSectionPO extends BasePO {

    public ScreeningSectionPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

    private final String screeningSection =
            format("//*[text()=\"%s\"]/ancestor::*[contains(@class, 'MuiAccordion-root')]", translator.getValue(
                    "thirdPartyInformation.screening.screeningSection"));
    private final By screeningSectionHeader = xpath(screeningSection + "/div");
    private final By screeningSectionHidden = xpath("//p[text()='Screening']/ancestor::div[@aria-expanded='false']");
    private final String screeningTable =
            "//*[@aria-label='screening tabs']/ancestor::*[starts-with(@class, 'MuiAccordionDetails')]//tbody";
    private final String buttonWithName = "//span[text()='%s']/ancestor::button";
    private final String modalButtonWithName = "//*[@role='dialog']//span[text()='%s']/ancestor::button";
    private final By cancelResolutionButton = id("ResolveAs-button-open");
    private final By screeningTableResultList = xpath(screeningTable + "/tr");
    private final By screeningTableHeaderList = xpath(screeningSection + "//thead//th");
    private final By selectAllScreeningResults = xpath(screeningSection + "//thead//th//input/..");
    private final String screeningRecordByContent = screeningTable + "//td//*[contains(text(), '%s')]/ancestor::tr";
    private final String screeningRecordByPosition = screeningTable + "//tr[%s]";
    private final String screeningResolutionButtonsList = screeningRecordByContent + "/td[9]//*[name()='svg']";
    private final String screeningResolutionButtonsByIndex = screeningTable + "//tr[%s]/td[9]//*[name()='svg']";
    private final String screeningMatchedIconByRecordId =
            screeningRecordByContent + "/td[8]//*[contains(@id, 'matchedIcon-img')]";
    private final String screeningMatchedIconByIndex =
            screeningTable + "//tr[%s]/td[8]//*[contains(@id, 'matchedIcon-img')]";
    private final String screeningSelectRecordByRecordId = screeningRecordByContent + "//*[@type='checkbox']";
    private final String screeningResolution =
            "//ul[@id='menu-list-grow']//*[contains(text(), '%s')]/ancestor::li[@role='menuitem']";
    private final String searchCriteriaInput =
            "//div[@role='presentation']//span[starts-with(text(), '%s')]/ancestor::div/input";
    private final String searchCriteriaInputClearButton =
            "//*[contains(text(),'%s')]/..//input/following-sibling::div//button[@title='Clear']";
    private final By searchCriteriaGroups = id("ThirdParty-ScreeningCriteriaDialog-GroupSelectInput");
    private final By searchCriteriaGroupsTooltip = id("ThirdParty-ScreeningCriteriaDialog-GroupSelectInput-Tooltip");
    private final String collapseButton =
            "//span[starts-with(text(), '%s')]/ancestor::div//button[@aria-label='Close']";
    private final String searchCriteriaDropDownButton =
            "//label[contains(text(), '%s')]//following-sibling::div//button[@aria-label='%s']";
    private final By lastScreeningDate = cssSelector("[data-testid^=ScreeningHeader]>div:nth-child(1)");
    private final By ogsSwitchButton = cssSelector("#ongoing-screening input");
    private final By ogsSwitchButtonSpan = cssSelector("#ongoing-screening span[class*='switch']");
    private final By ogsButtonDisable =
            xpath("//div[@id='ongoing-screening']//div/div//span[1]/span[@aria-disabled='true']");
    private final By resolutionOptions = id("menu-list-grow");
    private final String commentModalContent = "//*[@id='add-comment-dialog-description']/../..";
    private final String commentModalButtonWithName = commentModalContent + "//span[text()='%s']/ancestor::button";
    private final By resolutionComment = xpath("//*[@name='comment']");
    private final By resolutionCommentValue = xpath("//*[@name='comment' and @value]");
    private final String resolutionCommentInput = "input[name=comment][value='%s']";
    private final By tagAsRedFlag = cssSelector("[name=add-comment-switch-redflag]");
    private final String recipientWithName =
            "//*[@data-qid='CustomDialog-Autocomplete-notifyDialog-qid']//span[contains(text(), '%s')]/..";
    private final By addRecipientModal = xpath("//h5[text()='ADD RECIPIENT']/ancestor::div[@role='dialog']");
    private final By collapsedScreening =
            xpath("//*[text()='Screening']/ancestor::div[@role='button' and @aria-expanded='false']");
    private final String screeningRecordName = screeningTable + "/tr[%s]//td[2]//span";
    private final String screeningRecordId = screeningTable + "/tr[%s]//td[7]";
    private final By riskLevelInput = xpath("//*[@type='RISK']//input");
    private final By riskLevelInputOpenClose =
            xpath("//*[@type='RISK']//input/following-sibling::div//button[@aria-label='Close' or @aria-label='Open']");
    private final By reasonInput = xpath("//*[@type='REASON']//input");
    private final By reasonInputOpenClose =
            xpath("//*[@type='REASON']//input/following-sibling::div//button[@aria-label='Close' or @aria-label='Open']");
    private final By buttonWorldCheck = xpath("//span[contains(text(),'WORLD-CHECK')]/ancestor::button");
    private final String labelWithName = "//*[@id='ongoing-screening']//p[text()='%s']";
    private final By buttonCustomWatchlist = xpath("//span[contains(text(),'CUSTOM WATCHLIST')]/ancestor::button");
    private final By buttonMediaCheck = xpath("//span[contains(text(),'MEDIA CHECK')]/ancestor::button");
    private final String displayTabs = "//*[@aria-label='screening tabs']/button/span[text()='%s']";
    private final String noAvailableDataTabs =
            "//*[text()='%s']/parent::*[@aria-selected='true']/ancestor::*[contains(@class, 'MuiAccordionDetails')]//h6[text()='No available data']";
    private final By filterIconButton = cssSelector("[data-testid^=ScreeningHeader]~* button[aria-label=FilterList]");
    private final By smartFilterSideTab = cssSelector("#mediacheck-smart-filter");
    private final String mediaCheckFilterAccordion =
            "//*[@id='mediacheck-smart-filter']//p[text()='%s']/../../../parent::div";
    private final By mediaCheckRiskLevelToolTipIcon = xpath("//p[text()='Risk Level']/..//*[local-name() = 'svg'][2]");
    private final String mediaCheckFilterArticleSubMenuButton =
            "//*[@id='mediacheck-smart-filter']/div[1]//p[text()='%s']/ancestor::button";
    private final By mediaChecksmartFilterSection = xpath("//*[@id='mediacheck-smart-filter']/div[3]");
    private final By mediaCheckArticleNumber = xpath("//div[text()='Showing']/child::span[1]");
    private final By smartFilterToggleButton =
            xpath("//*[@id='mediacheck-smart-filter']//span[contains(@class, 'Mui-checked')]");
    private final By mediaCheckTableNoMatchFound = xpath("//*[@id='media-resolution']/following-sibling::*/h6");
    private final By noMatchFoundMessage = xpath("//h6[text()='No available data']");
    private final By bellIcon = cssSelector("[data-testid^=ScreeningHeader] button");
    private final By addRecipientInput = cssSelector("input[id*=notifyDialog]");
    private final By addRecipientSaveButton =
            xpath("//*[contains(@data-qid, 'notifyDialog')]/following-sibling::*/button/span[text()=\"" +
                          translator.getValue("thirdPartyInformation.screening.addButton").toUpperCase() + "\"]");
    private final By addRecipientCancelButton =
            xpath("//*[contains(@data-qid, 'notifyDialog')]/following-sibling::*/button/span[text()=\"" +
                          translator.getValue("thirdPartyInformation.screening.cancelUppercaseButton").toUpperCase() +
                          "\"]");
    private final By mediaCheckSearchTermInScreeningResultTable =
            xpath("//*[@aria-label='FilterList']/ancestor::div[2]/div/span[2]");
    private final By mediaCheckRowPerPageDropdown =
            cssSelector("[data-testid^=ScreeningHeader]~* [class*=MuiSelect-selectMenu]");
    private final By screeningRowsPerPageDropdown = xpath("//p[text()='ROWS']/parent::div/div/div");
    private final By mediaCheckResultTableRecords = cssSelector("[data-testid^=ScreeningHeader]~* tbody>tr");
    private final By rowsPerPageLabel = cssSelector("[data-testid^=ScreeningHeader]~* [pagereferences] p[id]");
    private final String tableRowNameValue = "td[2]//span";
    private final String tableRowValue = "td[%s]";
    private final String rowResolutionList = "td[9]//*[name()='svg']";
    private final By emptyTable = xpath("//*[@data-testid='ScreeningHeader-root']/following-sibling::div//h6");
    private final String checkType = "//*[@id='CheckType-edit-form-control-label-%s']//input";
    private final By markAllAsReviewedButton = xpath("//span[text()='MARK ALL AS REVIEWED']");
    private final By mediaResolution = xpath("//div[text()='MEDIA RESOLUTION']");
    private final By mediaResolutionRiskLevelLabel = xpath("//*[@id='media-resolution']//div[text()='Risk Level']");
    private final By mediaResolutionCommentLabel = xpath("//*[@id='media-resolution']//div[text()='Comment']");
    private final String mediaCheckScreeningRecord =
            "//span[text()='MEDIA CHECK']/../../../../../../..//tr[%s]/td[2]";
    private final By mediaResolutionScreeningResult = xpath("//h6[text()='MEDIA RESOLUTION']");
    private final By searchTerm = xpath("//*[@id='SearchTerm-input' or @name='searchTerm']");
    private final String addRecipientRemoveButtonInName =
            "//div[@role='dialog']//span[text()='%s']/..//*[local-name()='svg']";
    private final By addRecipientAddButton =
            xpath("//*[contains(@data-qid, 'notifyDialog')]/following-sibling::*/button/span[text()='ADD']/..");
    private final By btnRefresh = xpath("//button//span[contains(text(), 'Refresh')]");
    private final By ongoingScreeningWorldCheckCheckbox =
            xpath("//*[@id='EnableOngoing-form-control-label-worldCheck']//input");
    private final By notificationRecipients =
            xpath(format("//*[contains(., '%s')]/ancestor::label/following-sibling::div//input",
                         translator.getValue("addThirdParty.searchCriteria.notificationRecepients")));
    private final By recipientsRadioUserButton = xpath("//*[@id='Recipients-radio-user']//input");
    private final By sameAsAddressCheckbox =
            cssSelector("#same-as-address-country-checkbox input");
    private final By sameAsAddressCountryField =
            xpath("//*[@id='same-as-address-country-checkbox']//preceding-sibling::span/../preceding-sibling::div//input");
    private final String addRecipientOpenCloseDropDownButton =
            "//*[@data-qid='CustomDialog-Autocomplete-notifyDialog-qid']//button[@title='%s']";
    private final String ogsAlertMessage = "//div[@class='MuiAlert-message'] and text()='%s']";
    private final String typeOfLinkedRecord =
            "//div[@role='tabpanel'][5]//span[text()='%s']/ancestor::tr//span[text()='%s']";
    private final String tooltipOflinkedRecord = "//div[text()='%s']";
    private final String wcScreeningTypeTooltip = "//span[text()='%s']/ancestor::tr//div[text()='%s']";
    private final By matchStrengthButton = xpath("//div[@id='matchStrength']//div");
    private final String resolutionTypeButton = "//tbody/tr[1]/td[9]//div//*[@type='button'][%d]";
    private final String tooltipResolutionType = "//div[@id='resolution-%s-icon']//div";
    private final String tooltipOfWCType = "//div[@role='tooltip']//p[text()='%s']";
    private final By matchStrengthTooltip = xpath("//div[@role='tooltip']//p[contains(text(),'Strength')]");
    private final By resolutionTypeText = xpath("//div[@role='tooltip']//p[contains(text(),'Modified')]");
    private final String mediaCheckItemsSelected =
            "//div[@id='media-resolution']//p[text()='%s' and text()='Items Selected']";
    private final String mediaCheckScreeningRecordRow = screeningTable + "/tr[%s]//td/ancestor::tr";
    private final String mediaCheckScreeningSelectRecord = mediaCheckScreeningRecordRow + "//*[@type='checkbox']";
    private final String mediaCheckLinkName = "//div[@id='media-resolution']//p[text()='%s']";
    private final String mediacheckScreeningRecordChecked =
            screeningTable + "/tr[%s]//td/ancestor::tr//*[contains(@class, 'Mui-checked')]";
    private final String resolutionPopupDropdownMandatoryField =
            "//div[@type='%s']/child::*/child::label//span[text()=' *']";
    private final String resolutionPopupRequiredErrorMessage = "//div[@type='%s']/ancestor::div[2]//p";
    private final String resolutionPopupDropdownFieldValue = "//div[@type='%s']/child::*/child::*[2]/input";
    private final String screeningDetailResolution = "//*[@id='resolution-%s']";
    private final By screeningResult = xpath("//nav[@aria-label='pagination navigation']/..//p//span");
    private final By mediaCheckSelectAll = xpath("//input[@name='checkboxSelectAll']");
    private final String mediaCheckRiskLevel =
            "(//div[@id='media-resolution']//*[@id='MediaResolution-RiskLevel-Button-%s'])[last()]";
    private final String mediaCheckProfileRiskLevel =
            "//*[@id='MediaCheckProfileResolution-RiskLevel-Button-%s']";
    private final By mediaCheckAttach = xpath("(//button[@id='MediaResolution-Attach-Button'])[last()]");
    private final By mediaCheckProfileAttach = xpath("//button[@id='MediaCheckProfileResolution-Attach-Button']");
    private final By mediaCheckAttachModal =
            xpath("//div[@role='dialog']//h2[text()='ATTACH']/../..//p[text()='Are you sure you want to save the following changes?']");
    private final String mediaCheckAttachModalRiskLevel =
            "//div[@role='dialog']//h2[text()='ATTACH']/../..//p[text()='Risk Level']/../p[text()='%s']";
    private final String mediaCheckAttachModalComment =
            "//div[@role='dialog']//h2[text()='ATTACH']/../..//p[text()='Comment']/../..//p[text()='%s']";
    private final By modalMediaResolutionTagAsRedFlag = cssSelector("[data-cid^=MediaResolutionModal-RedFlag-Switch]");
    private final By profileMediaResolutionTagAsRedFlag =
            cssSelector("[data-cid^=MediaCheckProfileResolution-RedFlag]");
    private final String mediaCheckAttachModalButtonWithName = "//button[@type='button']//span[text()='%s']";
    private final String mediaCheckFilterRiskLevel =
            "//div[@id='mediacheck-smart-filter']//*[contains(@class,'MuiButton-label')]//p[contains(text(),'%s')]";
    private final String mediaCheckFilterRiskLevelButton =
            "//div[@id='mediacheck-smart-filter']//*[contains(@class,'MuiButton-label')]//p[contains(text(),'%s')]/ancestor::button";
    private final String mediaCheckFilterRiskLevelSelected =
            "//button[contains(@class,'MuiButton-contained')]//p[contains(text(),'%s')]";
    private final By paginationSection = xpath("//table[@id='media-check-table-results']/following-sibling::div");
    private final String similarArticleOrSeeMore =
            "//table[@id='media-check-table-results']//descendant::tr[%s]//div//div[4]//span[normalize-space()='%s']";
    private final String titleName =
            "//table[@id='media-check-table-results']//descendant::tr[%s]//td[2]//div//*[text()=\"%s\"]";
    private final By nextPageButton = xpath("//button[@aria-label='next page']");
    private final By clearAllButton = xpath("//p[text()='Clear All']");
    private final By previousPageButton = xpath("//button[@aria-label='previous page']");
    private final By backToTheFullListLink = xpath("//div[@id='media-resolution']//p[text()='Back to the full list']");
    private final By mediaCheckRedFlagToggle = id("MediaResolutionModal-RedFlag-Switch");
    private final String mediaCheckScreeningRecordRiskIcon =
            screeningTable + "/tr[%s]//td/ancestor::tr//div[contains(@class,'MuiChip-sizeSmall')]";
    private final String mediaCheckScreeningRecordRiskToolTip = "//div[contains(@class,'MuiTooltip')]//p[text()='%s']";
    private final By countryOfRegistrationInput = id("CountryOfReg-root-countryOfRegistration");
    private final By toastMessages = xpath("//div[@class='MuiAlert-message']");
    private final By countryOfLocationInput = id("CountryOfReg-root-countryOfLocation");
    private final By placeOfBirthInput = id("CountryOfReg-root-placeOfBirth");
    private final By citizenshipInput = id("CountryOfReg-root-citizenship");
    private final By searchCriteriaModal = xpath("//*[text()='SEARCH CRITERIA']/ancestor::div[@role='dialog']");
    private final By commentCounter = xpath("//*[@id='WorldCheckScreeningPage-Comment-helper-text']//span[3]");
    private final String resolutionDropDownInput = "//span[text()='%s']/ancestor::label/following-sibling::div/input";
    private final String riskLevelButton = "//*[@id='MediaCheckProfileResolution-RiskLevel-Button-%s']";
    private final By mediaCheckName = cssSelector("[name='Name']");
    private final String mediaCheckDetails = "//*[contains(@id,'header-detail-%d')]//div/span";
    private final String changeSearchInputField = "//*[contains(@data-cid,'%s')]//input";
    private final String changeSearchFieldErrorMessage =
            "//*[contains(@data-cid,'%s')]/..//p";
    private final String mediaCheckUserNameCommentSection =
            "//div[@data-testid='comment-body'][%s]/div[1]/p[text()='%s']";
    private final String mediaCheckCommentAtCommentSection =
            "//div[@data-testid='comment-body'][%s]/div[2]/p[text()='%s']";
    private final By mediaCheckTagAsRedFlagToolTip =
            xpath("//*[contains(@data-cid, 'MediaCheckDetail')]//*[local-name() = 'svg']");
    private final String mediaCheckTagAsRedFlagToolTipMessage = "//div[@role='tooltip']//div[contains(text(),'%s')]";
    private final String inputField = "//label[text()='%s']/following-sibling::div//input";
    private final By firstDropDownOption = xpath("//*[@role='listbox']/li[1]");
    private final String similarArticleResult =
            "//*[@id='media-check-table-results']//tr[%s]//div[text()='see less']/parent::div";
    private final String similarArticleDateAndSourceData =
            "//*[@id='media-check-table-results']//tr[%s]//div[text()='see less']/parent::div//p//span[contains(text(),'%s')]";
    private final String seeLessLabel = "//*[@id='media-check-table-results']//tr[%s]//div[text()='see less']";
    private final String titleArticleMediaCheckForContact =
            "//table[@id='media-check-table-results']//descendant::tr[%s]//td[2]//descendant::div[3]//a[contains(text(),\"%s\")]";
    private final String mediaCheckPhases =
            "//table[@id='media-check-table-results']//tr[%s]//div[@id='resolution']//span[6]";
    private final String mediaCheckTopics =
            "//table[@id='media-check-table-results']//tr[%s]//div[@id='resolution']//span[7]";
    private final String mediaCheckPublicationName =
            "//table[@id='media-check-table-results']//tr[%s]//div[@id='resolution']//span[3]";
    private final String mediaCheckDate =
            "//table[@id='media-check-table-results']//tr[%s]//div[@id='resolution']//span[1]";
    private final By mediaCheckFirstPageButton = xpath("//button[@aria-label='first page']");
    private final By mediaCheckLastPageButton = xpath("//button[@aria-label='last page']");
    private final String mediaCheckTitle = "//table[@id='media-check-table-results']//tr[%s]//a";
    private final String keyDataValue =
            "//span[text()='Key data']/ancestor::div//p[text()='%s']/parent::div/parent::span/following-sibling::p";
    private final By convertToThirdPartyButton = xpath("//button[@data-testid='convert-to-third-party-button']");
    private final String buttonOnConvertTPModal =
            "//button[@data-testid='convert-to-third-party-%s-button']";
    private final By convertToThirdPartyModal = xpath("//div[@data-testid='convert-to-third-party-modal']");

}
