package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.thirdPartyInformation;

import com.neovisionaries.i18n.CountryCode;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.worldCheck.PepResponse;
import com.refinitiv.asts.test.ui.api.model.mediacheck.MediaCheckResponse;
import com.refinitiv.asts.test.ui.api.model.mediacheck.PublicationDateResponse;
import com.refinitiv.asts.test.ui.api.model.mediacheck.SimilarArticleResponse;
import com.refinitiv.asts.test.ui.constants.APIConstants;
import com.refinitiv.asts.test.ui.constants.TestConstants;
import com.refinitiv.asts.test.ui.enums.Resolution;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ScreeningSectionPage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ThirdPartyInformationPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.MediaCheckProfileData;
import com.refinitiv.asts.test.ui.utils.DateUtil;
import com.refinitiv.asts.test.ui.utils.wc1.model.CaseResponseDTO;
import com.refinitiv.asts.test.ui.utils.wc1.model.ResultsResponseDTO;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.assertj.core.api.SoftAssertions;
import org.testng.asserts.SoftAssert;

import java.util.*;

import static com.refinitiv.asts.test.ui.api.AppApi.getAllActiveInternalUsersStream;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.COMMENT_DATE;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.CHECKED;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.Colors.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static com.refinitiv.asts.test.ui.utils.wc1.CountriesReferenceResponseDataTransfer.getWC1CountriesNamesList;
import static com.refinitiv.asts.test.ui.utils.wc1.ScreeningResultExpectedDataBuilder.*;
import static com.refinitiv.asts.test.ui.utils.wc1.WCOApiResponseExtractor.getCaseResponse;
import static java.lang.String.format;
import static java.util.Objects.nonNull;
import static java.util.stream.Collectors.toList;
import static org.apache.commons.lang3.RandomStringUtils.randomAlphanumeric;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.*;

public class ScreeningSteps extends BaseSteps {

    public static final String ON = "on";
    public static final String OFF = "off";
    public static final String ELLIPSIS = "...";
    public static final int NUMBER_OF_CHARACTERS_NAME = 29;
    public static final String WORLD_CHECK_ONE = "World-Check One";
    public static final String CUSTOM_WATCHLIST_PREFIX_REF_ID = "e_clwl_";
    public static final String UNKNOWN_VALUE = "UNKNOWN";
    public static final String[] RISK_LEVEL_OPTIONS = {HIGH, MEDIUM, LOW, NO_RISK, UNKNOWN};
    public static final String SCREENING_NUMBER_BEFORE_RE_SCREENING = "screeningNumberBeforeReScreen";
    private static final String SIMILAR_ARTICLES_LABEL = "Similar Articles";
    private static final String SEE_MORE_LABEL = "see more";
    private static final String DUPLICATE_KEY_IS_NOT_NULL = "not null";
    private final ScreeningSectionPage screeningPage;
    private final ThirdPartyInformationPage thirdPartyPage;
    private final int itemsPerPage = 10;
    private final int currentPage = 0;
    private final Map<String, String> screeningMarkedResultContext = new HashMap<>();
    private final Map<String, String> screeningReferenceIdContext = new HashMap<>();

    public ScreeningSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.screeningPage = new ScreeningSectionPage(this.driver, this.context, this.translator);
        this.thirdPartyPage = new ThirdPartyInformationPage(this.driver, this.context, this.translator);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public MediaCheckProfileData mediaCheckEntry(Map<String, String> entry) {
        return MediaCheckProfileData.builder()
                .name(entry.get(ScreeningSectionPage.NAME))
                .articleId(entry.get(ScreeningSectionPage.ARTICLE_ID))
                .countryOfRegistration(entry.get(ScreeningSectionPage.COUNTRY_OF_REGISTRATION))
                .lastScreeningDate(entry.get(ScreeningSectionPage.LAST_SCREENING_DATE))
                .dataProvider(entry.get(ScreeningSectionPage.DATA_PROVIDER))
                .createdBy(entry.get(ScreeningSectionPage.CREATED_BY))
                .lastUpdatedBy(entry.get(ScreeningSectionPage.LAST_UPDATED_BY))
                .build();
    }

    private void prepareSimilarArticle(MediaCheckResponse results, String duplicateKey) {
        MediaCheckResponse.Article mediaCheckArticle;
        if (DUPLICATE_KEY_IS_NOT_NULL.equals(duplicateKey)) {
            mediaCheckArticle =
                    results.getResults().stream().filter(a -> a.getArticleSummary().getDuplicatesKey() != null)
                            .findFirst()
                            .orElseThrow(() -> new RuntimeException("Key was not found"));
        } else {
            mediaCheckArticle =
                    results.getResults().stream().filter(a -> a.getArticleSummary().getDuplicatesKey() == null)
                            .findFirst()
                            .orElseThrow(() -> new RuntimeException("Key was not found"));

        }
        int indexOfArticle = screeningPage.getIndexOfArticle(results, mediaCheckArticle);
        String titleName = mediaCheckArticle.getArticleSummary().getTitle();
        context.getScenarioContext().setContext(INDEX_OF_ARTICLES, indexOfArticle);
        context.getScenarioContext().setContext(TITLE_NAME, titleName);
        if (DUPLICATE_KEY_IS_NOT_NULL.equals(duplicateKey)) {
            String duplicatesKey = mediaCheckArticle.getArticleSummary().getDuplicatesKey();
            SimilarArticleResponse similarArticleResults = screeningPage.getSimilarArticleListResponse(duplicatesKey);
            int totalSimilarArticleFromApi = similarArticleResults.getDuplicates().size();
            String sourceName = similarArticleResults.getDuplicates().get(0).getPublication().getName();
            String dateOfSimilarArticle = similarArticleResults.getDuplicates().get(0).getPublicationDate();
            String dateFormat =
                    DateUtil.updateDateFormat(API_DATE_FORMAT, SI_SIMILAR_ARTICLE_DATE, dateOfSimilarArticle);
            context.getScenarioContext().setContext(TOTAL_SIMILAR_ARTICLE_FROM_API, totalSimilarArticleFromApi);
            context.getScenarioContext().setContext(SOURCE_NAME, sourceName);
            context.getScenarioContext().setContext(DATE_FORMAT, dateFormat);
        }
    }

    private void prepareNoExternalArticle(MediaCheckResponse results) {
        MediaCheckResponse.Article mediaCheckArticle;
        mediaCheckArticle =
                results.getResults().stream().filter(a -> !Objects.equals(a.getArticleSummary().getSnippet(), EMPTY) &&
                                a.getArticleSummary().getPhases() != null && a.getArticleSummary().getTopics() != null)
                        .findFirst()
                        .orElseThrow(() -> new RuntimeException("Data was not found"));
        int indexOfArticle = screeningPage.getIndexOfArticle(results, mediaCheckArticle);
        context.getScenarioContext().setContext(INDEX_OF_ARTICLES, indexOfArticle);
        List<MediaCheckResponse.Article> mediaCheckResult = results.getResults();
        List<String> phases = mediaCheckResult.get(indexOfArticle - 1).getArticleSummary().getPhases();
        String phasesComma = String.join(COMMA_SPACE, phases);
        context.getScenarioContext().setContext(MEDIA_CHECK_PHASES, phasesComma);
        List<String> topics = mediaCheckResult.get(indexOfArticle - 1).getArticleSummary().getTopics();
        String topicsComma = String.join(COMMA_SPACE, topics);
        String topicsUpdate = COMMA_SPACE + topicsComma;
        context.getScenarioContext().setContext(MEDIA_CHECK_TOPICS, topicsUpdate);
        String titleName = mediaCheckResult.get(indexOfArticle - 1).getArticleSummary().getPublication().getName();
        context.getScenarioContext().setContext(TITLE_NAME, titleName);
        String publicationDate = mediaCheckResult.get(indexOfArticle - 1).getArticleSummary().getPublicationDate();
        String dateFormat = DateUtil.convertDateFormat(API_DATE_FORMAT, SI_SIMILAR_ARTICLE_DATE, publicationDate);
        context.getScenarioContext().setContext(PUBLICATION_DATE, dateFormat);

    }

    private void prepareExternalArticle(MediaCheckResponse results) {
        MediaCheckResponse.Article mediaCheckArticle;
        mediaCheckArticle =
                results.getResults().stream().filter(a -> a.getArticleSummary().getSnippet().equals(EMPTY) &&
                                a.getArticleSummary().getTopics() != null && a.getArticleSummary().getPhases() != null)
                        .findFirst()
                        .orElseThrow(() -> new RuntimeException("Data was not found"));
        int indexOfArticle = screeningPage.getIndexOfArticle(results, mediaCheckArticle);
        context.getScenarioContext().setContext(INDEX_OF_ARTICLES, indexOfArticle);
        List<MediaCheckResponse.Article> mediaCheckResult = results.getResults();
        List<String> phases = mediaCheckResult.get(indexOfArticle - 1).getArticleSummary().getPhases();
        String phasesComma = String.join(COMMA_SPACE, phases);
        context.getScenarioContext().setContext(MEDIA_CHECK_PHASES, phasesComma);
        List<String> topics = mediaCheckResult.get(indexOfArticle - 1).getArticleSummary().getTopics();
        String topicsComma = String.join(COMMA_SPACE, topics);
        String topicsUpdate = COMMA_SPACE + topicsComma;
        context.getScenarioContext().setContext(MEDIA_CHECK_TOPICS, topicsUpdate);
        String titleName = mediaCheckResult.get(indexOfArticle - 1).getArticleSummary().getPublication().getName();
        context.getScenarioContext().setContext(TITLE_NAME, titleName);
        String publicationDate = mediaCheckResult.get(indexOfArticle - 1).getArticleSummary().getPublicationDate();
        String dateFormat = DateUtil.convertDateFormat(API_DATE_FORMAT, SI_SIMILAR_ARTICLE_DATE, publicationDate);
        context.getScenarioContext().setContext(PUBLICATION_DATE, dateFormat);
    }

    @When("User clicks resolve Other Name screening record under number {int} on main screening list as {string}")
    public void markOtherNameScreeningRecord(int recordReference, String resolution) {
        String referenceId = (String) context.getScenarioContext().getContext(RECORD_ID + recordReference);
        screeningPage
                .clickResolveScreeningElementById(referenceId, Resolution.valueOf(resolution).getResolutionPosition());
        if (context.getScenarioContext().isContains(RESOLVED_RECORDS_ID_LIST)) {
            updateResolutionList(Resolution.valueOf(resolution).getResolutionPosition() ==
                                         screeningPage.getSelectedResolutionIndexById(referenceId),
                                 resolution, referenceId);
        }
    }

    @When("User marks {string} screening record for {string} on position {int} on main screening list as {string}")
    public void markScreeningRecord(String provider, String resultsFor, int recordReference, String resolution) {
        clickResolveScreeningRecord(provider, resultsFor, recordReference, resolution);
        screeningPage.selectFirstRiskLevel();
        screeningPage.selectFirstReason();
        screeningPage.fillInResolutionComment(randomAlphanumeric(5));
        screeningPage.clickOnModalButton(SAVE);
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User marks {string} screening record for {string} on position {int} on main screening list as {string} with comment {string}")
    public void markScreeningRecord(String provider, String resultsFor, int recordReference, String resolution,
            String comment) {
        clickResolveScreeningRecord(provider, resultsFor, recordReference, resolution);
        screeningPage.enterScreeningCommentAndSave(comment);
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks resolve {string} screening record for {string} on position {int} on main screening list as {string} resolution")
    public void clickResolveScreeningRecord(String provider, String resultsFor, int recordReference,
            String resolution) {
        screeningResultsTableIsLoaded();
        List<ResultsResponseDTO> screeningResults =
                getScreeningResults(context, resultsFor, getProvider(provider));
        ResultsResponseDTO markedResult = screeningPage.getScreeningResultsData(resultsFor)
                .get(recordReference - 1);
        screeningPage.clickResolveScreeningElementById(markedResult.getReferenceId(),
                                                       Resolution.valueOf(resolution).getResolutionPosition());
        context.getScenarioContext().setContext(SCREENING_RESULTS_BEFORE_REVIEW, screeningResults);
        context.getScenarioContext().setContext(RECORD_ID + recordReference, markedResult.getReferenceId());
        context.getScenarioContext().setContext(SCREENING_MARKED_RESULT_CONTEXT, markedResult);
    }

    @When("User selects screening record for {string} on position {int}")
    public void selectScreeningRecordForOnPosition(String resultsFor, int recordReference) {
        screeningResultsTableIsLoaded();
        ResultsResponseDTO selectedResult =
                screeningPage.getScreeningResultsData(resultsFor).get(recordReference - 1);
        screeningPage.clickSelectScreeningElementById(selectedResult.getReferenceId());
        context.getScenarioContext().setContext(RECORD_ID + recordReference, selectedResult.getReferenceId());
    }

    @When("User resolves selected records as {string} with empty comment")
    public void resolveSelectedRecordsAsWithEmptyCommentAndRandomReason(String resolution) {
        clicksResolutionTypeMenuOption(resolution);
        screeningPage.selectFirstRiskLevel();
        screeningPage.selectFirstReason();
        screeningPage.clickOnModalButton(SAVE);
        screeningResultsTableIsLoaded();
    }

    @When("User fills random Risk Level and Reason")
    public void fillRandomRiskLevelAndReason() {
        screeningPage.selectFirstRiskLevel();
        screeningPage.selectFirstReason();
    }

    @When("User resolves selected records as {string} with {string} comment")
    public void resolveSelectedRecordsAsWithEmptyComment(String resolution, String comment) {
        clicksResolutionTypeMenuOption(resolution);
        screeningPage.selectFirstRiskLevel();
        screeningPage.selectFirstReason();
        screeningPage.enterScreeningCommentAndSave(comment);
        screeningResultsTableIsLoaded();
    }

    @When("User clicks {string} resolution type menu option")
    public void clicksResolutionTypeMenuOption(String resolution) {
        screeningPage.clickOnResolution(screeningPage.getFromDictionaryIfExists(resolution));
    }

    @When("User selects all screening results")
    public void selectAllScreeningResults() {
        screeningResultsTableIsLoaded();
        screeningPage.selectAllScreeningResults();
    }

    @When("User clears Search Criteria {string}")
    public void clearSearchCriteria(String elementName) {
        screeningPage.clearSearchCriteria(elementName);
    }

    @When("User clicks on screening confirmation button with name {string}")
    public void clickOnConfirmationWithName(String buttonName) {
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        screeningPage.clickOnModalButton(buttonName);
    }

    @When("User clicks on screening button with name {string}")
    public void clickOnButtonWithName(String buttonName) {
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        screeningPage.clickOnButtonWithName(buttonName);
    }

    @When("User edits Search Term with value {string}")
    public void editSearchTermWithValueString(String searchTerm) {
        screeningPage.editSearchCriteria(searchTerm);
    }

    @When("User changes Search Criteria {string} with value {string}")
    public void changeSearchCriteriaWithValue(String searchCriteria, String value) {
        searchCriteria = screeningPage.getFromDictionaryIfExists(searchCriteria);
        screeningPage.scrollToScreeningTable();
        screeningResultsTableIsLoaded();
        screeningPage.clickEnableScreeningOrSearchCriteria(screeningPage.getFromDictionaryIfExists(
                "thirdPartyInformation.screening.changeSearchCriteriaButton"));
        screeningPage.updateSearchCriteria(searchCriteria, value);
        searchCriteriaContainsValue(searchCriteria, value);
        screeningPage.clickOnModalButton(
                screeningPage.getFromDictionaryIfExists("thirdPartyInformation.screening.searchButton").toUpperCase());
    }

    @When("User reviews {string} screening results for {string} with comment {string}")
    public void reviewScreeningResultsForWithComment(String provider, String resultsFor, String comment) {
        List<ResultsResponseDTO> wcoScreeningResults =
                getScreeningResults(context, resultsFor, getProvider(provider));
        context.getScenarioContext().setContext(SCREENING_RESULTS_BEFORE_REVIEW, wcoScreeningResults);
        screeningPage.clickOnButtonWithName(REVIEW);
        fillInComment(comment);
        screeningPage.clickOnButtonWithName(ADD.toUpperCase());
    }

    @When("^User clicks \"(Cancel|Add|Save)\" Add Comment modal button$")
    public void clickAddCommentModalButton(String buttonType) {
        if (buttonType.equals(SAVE)) {
            String commentDate =
                    getCurrentCommentDateTime(ACTIVITY_COMMENT_DATE_FORMAT).replace(PM, P_M_).replace(AM, A_M_);
            context.getScenarioContext().setContext(COMMENT_DATE, commentDate);
            screeningPage.clickOnCommentModalButtonWithName(
                    screeningPage.getFromDictionaryIfExists("contact.saveButton"));
        } else {
            screeningPage.clickOnCommentModalButtonWithName(buttonType);
        }

    }

    @When("^User turns (on|off) 'Tag as red flag'$")
    public void turnOnTafAsRedFlag(String turnOption) {
        if ((turnOption.equals(ON) && !screeningPage.isRedFlagTurnOn()) ||
                (turnOption.equals(OFF) && screeningPage.isRedFlagTurnOn())) {
            screeningPage.turnOnTagAsRedFlag();
        }
    }

    @When("^User turns (on|off) 'Tag as red flag' of Media Check Media Resolution Profile$")
    public void turnOnTagAsRedFlagMediaCheckProfile(String turnOption) {
        if ((turnOption.equals(ON) && !screeningPage.isMediaResolutionRedFlagTurnOn()) ||
                (turnOption.equals(OFF) && screeningPage.isMediaResolutionRedFlagTurnOn())) {
            screeningPage.clickMediaCheckTagAsRedFlagToggle();
        }
    }

    @When("User fills in comment {string}")
    public void fillInComment(String comment) {
        screeningPage.fillInResolutionComment(comment);
    }

    @When("User random {int} characters")
    public void randomValue(int number) {
        String comment = RandomStringUtils.randomAlphabetic(number);
        context.getScenarioContext().setContext(MEDIA_CHECK_COMMENT, comment);
    }

    @When("User fills in random comment characters")
    public void fillInRandomValue() {
        String commentValue = (String) context.getScenarioContext().getContext(MEDIA_CHECK_COMMENT);
        screeningPage.fillInResolutionComment(commentValue);
    }

    @When("User clicks on {int} number screening record")
    public void clickOnNumberScreeningRecord(int recordNo) {
        screeningResultsTableIsLoaded();
        String referenceId = (String) context.getScenarioContext().getContext(RECORD_ID + recordNo);
        if (nonNull(referenceId)) {
            screeningPage.clickOnScreeningElement(referenceId);
        } else {
            String recordName = screeningPage.getScreeningRecordName(recordNo);
            String recordId = screeningPage.getScreeningRecordId(recordNo);
            screeningPage.clickOnScreeningElement(recordNo);
            context.getScenarioContext().setContext(RECORD_NAME + recordNo, recordName);
            context.getScenarioContext().setContext(RECORD_ID + recordNo, recordId);
        }
    }

    @When("User clicks Resolve As screening button")
    public void clickResolveAsScreeningButton() {
        screeningPage.scrollToScreeningTable();
        screeningPage.clickOnButtonWithName(
                screeningPage.getFromDictionaryIfExists("thirdPartyInformation.screening.resolveAs"));
    }

    @When("User clicks Cancel search criteria button")
    public void clickCancelSearchCriteriaButton() {
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        screeningPage.clickOnButtonWithName(CANCEL.toUpperCase());
    }

    @When("User clicks Search On Search criteria button")
    public void clickSearchCriteriaButton() {
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        screeningPage.clickOnButtonWithName(SEARCH.toUpperCase());
    }

    @When("User clicks Change Search Criteria screening button")
    public void clickChangeSearchCriteriaScreeningButton() {
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        screeningPage.clickOnButtonWithName(CHANGE_SEARCH_CRITERIA);
    }

    @When("User clicks Enable screening button")
    public void clickEnableScreeningButton() {
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        screeningPage.clickOnButtonWithName(ENABLE_SCREENING_BUTTON);
    }

    @When("User clicks OGS slider to ON")
    public void clickAndVerifyOgsON() {
        thirdPartyPage.closeAlertIconIfDisplayed();
        screeningResultsTableIsLoaded();
        screeningPage.clickOnOgs();
    }

    @When("User clicks OGS slider to OFF")
    public void clickAndVerifyOgsOFF() {
        screeningPage.clickOnOgs();
    }

    @When("User adds notification in Add Recipient modal {string}")
    public void addRecipient(String recipient) {
        screeningPage.addRecipient(recipient);
    }

    @When("User clicks Screening Bell icon")
    public void clickBellIcon() {
        screeningPage.clickBellIcon();
    }

    @When("User clicks 'Cancel' ADD RECIPIENT button")
    public void clickCancelNotifyButton() {
        screeningPage.cancelAddingRecipient();
    }

    @When("User clicks 'Add' ADD RECIPIENT button")
    public void clickAddNotifyButton() {
        thirdPartyPage.closeAlertIconIfDisplayed();
        screeningPage.clickSaveNotifyButton();
    }

    @When("User collapses Screening Section")
    public void collapseScreeningSection() {
        screeningPage.collapseScreeningSection();
    }

    @When("User selects {string} Risk Level")
    public void selectRiskLevel(String riskLevel) {
        screeningPage.selectRiskLevel(riskLevel);
    }

    @When("User selects {string} Reason")
    public void selectReason(String reason) {
        screeningPage.selectReason(reason);
    }

    @When("User clicks WORLD-CHECK tab and {string} tab is appeared")
    public void clickWorldCheck(String tabValue) {
        screeningPage.isTabOnScreeningPageAppear(tabValue);
        screeningPage.clickWorldCheck();
    }

    @When("User clicks CUSTOM WATCHLIST tab at Screening section")
    public void clickCustomWatchlist() {
        screeningPage.clickCustomWatchlist();
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks Media Check tab on Screening section")
    public void clickMediaCheckOnScreening() {
        screeningPage.clickMediaCheck();
    }

    @When("User clicks on {string} tab")
    public void clickOnScreeningTab(String tabName) {
        screeningResultsTableIsLoaded();
        screeningPage.clickOnScreeningTab(tabName);
    }

    @When("User clicks on Filter icon in Media Check tab")
    public void clickFilterIconOnMediaCheckTab() {
        screeningPage.clickFilterIcon();
    }

    @When("User clicks on smart filter toggle button")
    public void clickSmartFilterToggleButtonOnMediaCheckTab() {
        screeningPage.clickSmartFilterToggleButton();
    }

    @When("User clicks CUSTOM WATCHLIST tab at Screening section without waiting for loading to disappear")
    public void clickCustomWatchlistWithoutWaitingForLoadingToDisappear() {
        screeningPage.clickCustomWatchlist();
    }

    @When("User selects {string} option from Rows Per Page dropdown list")
    public void selectRowsPerPageDropdown(String rowsPerPage) {
        screeningPage.clickRowsPerPageDropDown();
        screeningPage.clickItemsRowsPerPageOption(rowsPerPage);
    }

    @When("User clicks on Check Type {string}")
    public void clickOnCheckType(String checkType) {
        screeningPage.clickCheckTypeCheckbox(checkType);
    }

    @When("User removes notification in Add Recipient modal {string}")
    public void removeNotificationInAddRecipientModal(String recipientName) {
        screeningPage.removeAddRecipientDropdownValue(recipientName);
    }

    @When("User fills in Search Term with random value")
    public void fillInSearchTerm() {
        screeningPage.fillInSearchTermRandomValue();
    }

    @When("User clicks ADD RECIPIENT modal Recipient drop-down {string} button")
    public void clickOpenCloseDropDownButton(String state) {
        screeningPage.clickOpenCloseDropDownButton(state);
    }

    @When("User fills Search Term with {string}")
    public void fillInSearchTermWithValue(String searchTermValue) {
        screeningPage.fillInSearchTermWithValue(searchTermValue);
    }

    @When("User hovers WC Screening {string} Type {string} icon")
    public void hoverWCScreeningTypeIcon(String name, String type) {
        screeningPage.scrollIntoViewWCRecord(name, type);
        screeningPage.hoversOverWCScreeningType(name, type);
    }

    @When("User hovers WC Screening Match Strength")
    public void hoverMatchStrength() {
        screeningPage.hoversOverMatchStrength();
    }

    @When("User hovers WC Screening Resolution Type at position no.{int}")
    public void hoverResolutionType(int resolutionTypePosition) {
        screeningPage.hoversOverResolutionType(resolutionTypePosition);
    }

    @When("User marks resolution on position no.{int}")
    public void markResolutionButton(int resolutionTypePosition) {
        screeningPage.clickResolutionButton(resolutionTypePosition);
    }

    @When("User selects {string} resolution in screening detail page")
    public void selectResolutionInScreeningDetail(String resolutionType) {
        screeningPage.clickResolutionOnScreeningDetail(resolutionType);
    }

    @When("User clicks on {int} items selected link")
    public void clickOnItemsSelectedLink(int expectedItems) {
        screeningPage.clickOnItemsSelectedLink(expectedItems);
    }

    @When("User clicks on Media Check screening record on position {int}")
    public void clickMediaCheckScreeningRecordForOnPosition(int record) {
        screeningPage.clickOnMediaCheckRecord(record);
    }

    @When("^User remembers (Third-party Reference|Third-party Other Names Reference|Third-party Associated Party Individual Reference\\d?|Third-party Associated Party Organisation Reference|Third-party Associated Party Individual Other Names Reference\\d?|Third-party Associated Party Organisation Other Names Reference) Media Check context selection$")
    public void rememberMediaCheckScreeningRecord(String recordType) {
        if (recordType.equals(THIRD_PARTY + SPACE + REFERENCE)) {
            context.getScenarioContext()
                    .setContext(recordType, context.getScenarioContext().getContext(THIRD_PARTY_MEDIA_CHECK_RECORD));
        }
        if (recordType.contains(THIRD_PARTY + SPACE + OTHER_NAMES)) {
            context.getScenarioContext()
                    .setContext(recordType,
                                context.getScenarioContext().getContext(THIRD_PARTY_OTHER_NAME_MEDIA_CHECK_RECORD));
        }
        if (recordType.contains(ASSOCIATED_PARTY_INDIVIDUAL) && !recordType.contains(OTHER_NAMES)) {
            context.getScenarioContext()
                    .setContext(recordType,
                                context.getScenarioContext()
                                        .getContext(ASSOCIATED_PARTY_INDIVIDUAL_MEDIA_CHECK_RECORD));
        }
        if (recordType.contains(ASSOCIATED_PARTY_ORGANISATION) && !recordType.contains(OTHER_NAMES)) {
            context.getScenarioContext()
                    .setContext(recordType,
                                context.getScenarioContext()
                                        .getContext(ASSOCIATED_PARTY_ORGANIZATIONAL_MEDIA_CHECK_RECORD));
        }
        if (recordType.contains(ASSOCIATED_PARTY_INDIVIDUAL) && recordType.contains(OTHER_NAMES)) {
            context.getScenarioContext()
                    .setContext(recordType,
                                context.getScenarioContext()
                                        .getContext(ASSOCIATED_PARTY_INDIVIDUAL_OTHER_NAME_MEDIA_CHECK_RECORD));
        }
        if (recordType.contains(ASSOCIATED_PARTY_ORGANISATION) && recordType.contains(OTHER_NAMES)) {
            context.getScenarioContext()
                    .setContext(recordType,
                                context.getScenarioContext()
                                        .getContext(ASSOCIATED_PARTY_ORGANIZATIONAL_OTHER_NAME_MEDIA_CHECK_RECORD));
        }
    }

    @When("^User selects (Third-party|Associated Party Individual|Associated Party Organisation) Media Check screening record on position (\\d+)$")
    public void selectMediaCheckCheckboxOnPosition(String screeningLevel, int recordReference) {
        screeningResultsTableIsLoaded();
        while (screeningPage.getMediaCheckRecordName(recordReference).contains(DOLLAR_SIGN)) {
            recordReference++;
        }
        screeningPage.clickSelectMediaCheckScreeningRecord(recordReference);
        if (screeningLevel.contains(THIRD_PARTY)) {
            context.getScenarioContext()
                    .setContext(THIRD_PARTY_MEDIA_CHECK_RECORD, screeningPage.getMediaCheckRecordName(recordReference));
        }
        if (screeningLevel.contains(ASSOCIATED_PARTY_INDIVIDUAL)) {
            context.getScenarioContext()
                    .setContext(ASSOCIATED_PARTY_INDIVIDUAL_MEDIA_CHECK_RECORD,
                                screeningPage.getMediaCheckRecordName(recordReference));
        }
        if (screeningLevel.contains(ASSOCIATED_PARTY_ORGANISATION)) {
            context.getScenarioContext()
                    .setContext(ASSOCIATED_PARTY_ORGANIZATIONAL_MEDIA_CHECK_RECORD,
                                screeningPage.getMediaCheckRecordName(recordReference));
        }
    }

    @When("User gets Third-party media check screening first and last record")
    public void getMediaCheckFirstAndLastRecord() {
        context.getScenarioContext()
                .setContext(THIRD_PARTY_MEDIA_CHECK_FIRST_RECORD, screeningPage.getMediaCheckRecordName(1));
        context.getScenarioContext()
                .setContext(THIRD_PARTY_MEDIA_CHECK_LAST_RECORD,
                            screeningPage.getMediaCheckRecordName(
                                    screeningPage.getTotalRecordsFromMediaCheckResultTable()));
    }

    @When("User clicks on select all checkBox of media check page")
    public void clickOnSelectAllMediaCheck() {
        screeningPage.clickOnSelectAllCheckBoxMediaCheck();
    }

    @When("User selects risk level as {string}")
    public void selectMediaCheckRiskLevel(String riskLevel) {
        screeningPage.clickOnMediaCheckRiskLevel(riskLevel);
    }

    @When("User clicks attach button")
    public void clickOnAttachButton() {
        screeningPage.clickOnAttachButton();
    }

    @When("User clicks Media Check 'Tag as Red Flag' toggle")
    public void clickMediaCheckTagAsRedFlagToggle() {
        screeningPage.clickMediaCheckTagAsRedFlagToggle();
    }

    @When("^User clicks \"(CANCEL|SAVE)\" Media Check Attach modal button$")
    public void clicksMediaCheckAttachModalButton(String buttonType) {
        screeningPage.clickOnAttachModalButtonWithName(buttonType);
    }

    @When("User clicks on Risk Level Filter {string} {string}")
    public void clicksRiskLevelFilter(String riskLevel, String recordNumber) {
        screeningPage.clickOnFilterRiskLevel(riskLevel, recordNumber);
    }

    @When("User clicks next page")
    public void clickOnNextPage() {
        screeningPage.clickOnNextPage();
    }

    @When("User clicks last page")
    public void clickOnLastPage() {
        screeningPage.clickOnLastPage();
    }

    @When("User clicks first page")
    public void clickOnFirstPage() {
        screeningPage.clickOnFirstPage();
    }

    @When("User deletes Comment Media Resolution")
    public void clearCommentMediaResolution() {
        screeningPage.clearCommentMediaResolutionValue();
    }

    @When("User clicks clear all button")
    public void clickOnClearAllButton() {
        screeningPage.clickOnClearAllButton();
    }

    @When("User clicks previous page")
    public void clickOnPreviousPage() {
        screeningPage.clickOnPreviousPage();
    }

    @When("User clicks Back to the full list Link")
    public void clickOnBackToTheFullListLink() {
        screeningPage.clickOnBackToTheFullListLink();
    }

    @When("User hovers Media Check Risk Level icon on Screening record {int}")
    public void hoverMediaCheckRiskLevelRecordIcon(int recordReference) {
        screeningResultsTableIsLoaded();
        screeningPage.scrollIntoViewMediaCheckRecord(recordReference);
        screeningPage.hoversOverMediaCheckRiskLevelRecordIcon(recordReference);
    }

    @When("User selects a Screening Group {int} from Search Criteria")
    public void selectContactGroup(int groupIndex) {
        screeningPage.selectGroup(groupIndex);
    }

    @When("User hovers to Screening Groups field in Search Criteria")
    public void hoverScreeningGroupsField() {
        screeningPage.hoverScreeningGroups();
    }

    @When("User changes Search Term to {string}")
    public void changeSearchTerm(String searchTermValue) {
        screeningPage.editSearchTerm(searchTermValue);
    }

    @When("User changes Country of Registration value to {string}")
    public void changeCountryOfRegistration(String value) {
        screeningPage.selectCountryOfRegistration(value);
    }

    @When("^User remembers (Third-party Reference|Third-party AP Individual Reference\\d?|Third-party AP Organisation Reference|Third-party Other Names Reference|Third-party AP Individual Other Names Reference\\d?|Third-party AP Organisation Other Names Reference) context selection$")
    public void rememberScreeningRecord(String recordType) {
        ResultsResponseDTO markedResult =
                (ResultsResponseDTO) this.context.getScenarioContext().getContext(SCREENING_MARKED_RESULT_CONTEXT);
        screeningMarkedResultContext.put(recordType, markedResult.getPrimaryName());
        screeningReferenceIdContext.put(recordType, markedResult.getReferenceId());
        String referenceIdWithPrefix = "e_tr_wci_" + markedResult.getReferenceId();
        context.getScenarioContext().setContext(SCREENING_SELECTED_RESULTS_CONTEXT, screeningMarkedResultContext);
        context.getScenarioContext().setContext(SCREENING_REFERENCE_IDS_CONTEXT, screeningReferenceIdContext);
        context.getScenarioContext().setContext(SCREENING_REFERENCE_IDS_WITH_PREFIX_CONTEXT, referenceIdWithPrefix);
    }

    @When("^User clears (?:Third-party|Third-party Contacts|Third-party Other Names|Third-party Contacts Other Names?) screening record on position (\\d+) context$")
    public void clearScreeningRecordContext(int elementIndex) {
        if (context.getScenarioContext().isContains(RECORD_ID + elementIndex)) {
            context.getScenarioContext().setContext(RECORD_ID + elementIndex, null);
        }
    }

    @When("User selects Country of Location value to {string}")
    public void selectCountryOfLocation(String country) {
        screeningPage.selectCountryOfLocationDropdown(country);
    }

    @When("User selects Place of Birth value to {string}")
    public void selectPlaceOfBirth(String placeOfBirth) {
        screeningPage.selectPlaceOfBirthDropdown(placeOfBirth);
    }

    @When("User selects Citizenship value to {string}")
    public void selectCitizenship(String citizenship) {
        screeningPage.selectCitizenshipDropdown(citizenship);
    }

    @When("User clears {string} on Change Search Criteria")
    public void clearChangeSearchCriteria(String elementName) {
        screeningPage.clearChangeSearchCriteria(elementName);
    }

    @When("User selects risk level on MediaCheck Profile as {string}")
    public void selectMediaCheckProfileRiskLevel(String riskLevel) {
        screeningPage.clickOnMediaCheckProfileRiskLevel(riskLevel);
    }

    @When("User clicks attach button on MediaCheck Profile")
    public void clickOnAttachButtonMediaCheckProfile() {
        screeningPage.clickOnAttachButtonMediaCheckProfile();
    }

    @When("User clicks Tag as red flag tooltip icon on MediaCheck Profile")
    public void clickTagAsRedFlagIcon() {
        screeningPage.clickMediaCheckTagAsRedFlagIcon();
    }

    @When("User gets Screening Number before Re-Screening")
    public void getScreeningNumber() {
        String screeningNumberBeforeReScreen = screeningPage.getScreeningResult();
        context.getScenarioContext().setContext(SCREENING_NUMBER_BEFORE_RE_SCREENING, screeningNumberBeforeReScreen);
    }

    @When("User edits {string} field with value {string} on Change Search Criteria")
    public void editFieldWithValueOnChangeSearchCriteria(String fieldName, String inputString) {
        screeningPage.selectInputValue(fieldName, inputString);
    }

    @When("^The system calls the Media Check API (without Other Name|with Other Name) is \"((.*))\" and (\\d+) records to find a Duplicate Key is \"((.*))\"$")
    public void clickTheSeeMoreLabel(String type, String otherName, int numberOfRecords, String duplicateKey) {
        MediaCheckResponse results;
        if (TestConstants.WITH_OTHER_NAME.equals(type)) {
            results = screeningPage.getMediaCheckTpOtherNameResponse(numberOfRecords, otherName);
        } else {
            results = screeningPage.getMediaCheckResponse(numberOfRecords);
        }
        prepareSimilarArticle(results, duplicateKey);
    }

    @When("^The system calls the Media Check Associated IND API (without Other Name|with Other Name) and (\\d+) records for \"((.*))\" \"((.*))\" to find a Duplicate Key is \"((.*))\"$")
    public void clickTheSeeMoreLabelInFor(String type, int paginationNumber, String firstName,
            String lastName, String duplicateKey) {
        MediaCheckResponse results;
        if (TestConstants.WITH_OTHER_NAME.equals(type)) {
            results =
                    screeningPage.getMediaCheckResponseForIndOtherName(paginationNumber, firstName, lastName);
        } else {
            results =
                    screeningPage.getMediaCheckResponseForAssociatedIndividual(paginationNumber, firstName, lastName);
        }

        prepareSimilarArticle(results, duplicateKey);
    }

    @When("User clicks the see more label")
    public void clickTheSeeMoreLabelInFor() {
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        screeningPage.clickSeeMoreLabel(indexOfArticle, SEE_MORE_LABEL);

    }

    @When("User clicks the see less label")
    public void clickSeeLessLabel() {
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        screeningPage.clickSeeLessLabel(indexOfArticle);
    }

    @When("^User gets Media check \"(current|first|last|next|previous)\" page references value from API$")
    public void getMediaCheckPageReference(String expectedReference) {
        screeningPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        PublicationDateResponse publicationDate = screeningPage.getPublicationDate();
        String minDate = publicationDate.getMin();
        String maxDate = publicationDate.getMax();
        MediaCheckResponse results =
                screeningPage.getMediaCheckResponseWithPublicationDate(PAGINATION, minDate, maxDate);
        MediaCheckResponse.PageReferences mediaCheckPageReference = results.getPageReferences();
        switch (expectedReference) {
            case CURRENT:
                String mediaCheckCurrentReference = mediaCheckPageReference.getCurrent();
                context.getScenarioContext().setContext(MEDIA_CHECK_CURRENT_REFERENCE, mediaCheckCurrentReference);
                break;
            case FIRST:
                String mediaCheckFirstReference = mediaCheckPageReference.getFirst();
                context.getScenarioContext().setContext(MEDIA_CHECK_FIRST_REFERENCE, mediaCheckFirstReference);
                break;
            case LAST:
                String mediaCheckLastReference = mediaCheckPageReference.getLast();
                context.getScenarioContext().setContext(MEDIA_CHECK_LAST_REFERENCE, mediaCheckLastReference);
                break;
            case NEXT:
                String mediaCheckNextReference = mediaCheckPageReference.getNext();
                context.getScenarioContext().setContext(MEDIA_CHECK_NEXT_REFERENCE, mediaCheckNextReference);
                break;
            case PREVIOUS:
                String mediaCheckPreviousReference = mediaCheckPageReference.getPrevious();
                context.getScenarioContext().setContext(MEDIA_CHECK_PREVIOUS_REFERENCE, mediaCheckPreviousReference);
                break;
            default:
                throw new IllegalArgumentException("State: " + expectedReference + " is incorrect");
        }

    }

    @When("User clicks Convert to third-party button")
    public void clickConvertTPButton() {
        screeningPage.clickConvertTPButton();
    }

    @When("^User clicks \"(cancel|proceed)\" on Convert to third-party modal$")
    public void clickModalConvertTP(String buttonName) {
        screeningPage.clickModalConvertTP(buttonName);
        screeningPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    /**
     * Validate that screening table is loaded.
     * States of table: empty, with results, refresh button is displayed due to RMS-734.
     * In case if refresh button is displayed it click on it and wait while preloader is disappeared
     * Refresh button can be shown twice, so search wor it is done twice
     */
    @Then("Screening results table is loaded")
    public void screeningResultsTableIsLoaded() {
        screeningPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        int retriesToFindRefreshButton = 2;
        for (int i = 0; i < retriesToFindRefreshButton; i++) {
            screeningPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
            if (screeningPage.isRefreshScreeningTableButtonDisplayed()) {
                screeningPage.clickRefreshScreeningTableButton();
                screeningPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
            } else {
                break;
            }
        }
        assertTrue("Screening table is not loaded", screeningPage.isScreeningTableLoaded());
    }

    @Then("Screening record under number {int} appears in the main screening table with {string} resolution")
    public void otherNameScreeningRecordAppearsInTheMainScreeningTableWithResolution(int recordNo, String resolution) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        screeningPage.scrollToScreeningTable();
        screeningResultsTableIsLoaded();
        thirdPartyPage.closeAlertIconIfDisplayed();
        String referenceId = (String) context.getScenarioContext().getContext(RECORD_ID + recordNo);
        assertTrue("Screening record with ID: " + referenceId + " doesn't appear in the main screening table",
                   screeningPage.isScreeningRecordWithIdDisplayed(referenceId));
        assertEquals(
                "Screening resolution status index for record with ID: " + referenceId + " doesn't equals expected",
                Resolution.valueOf(resolution).getResolutionPosition(),
                screeningPage.getSelectedResolutionIndexById(referenceId));
    }

    @Then("Screening record under number {int} does not appear in the main screening table")
    public void screeningRecordUnderNumberDoesNotAppearInTheMainScreeningTable(int recordReference) {
        screeningPage.scrollToScreeningTable();
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        String referenceId = (String) context.getScenarioContext().getContext(RECORD_ID + recordReference);
        assertFalse("Screening record with ID: " + referenceId + " still appears in the main screening table",
                    screeningPage.isScreeningRecordWithIdDisplayed(referenceId));
    }

    @Then("Matched indicator for screening with reference {int} is not displayed")
    public void matchedIndicatorForScreeningWithReferenceIsNotDisplayed(int recordReference) {
        String referenceId = (String) context.getScenarioContext().getContext(RECORD_ID + recordReference);
        assertFalse("Matched indicator for record with ID: " + referenceId + " is displayed",
                    screeningPage.isMatchedIndicatorDisplayedForRecordWithId(referenceId));
    }

    @Then("Matched indicator is not displayed for each record in the main screening table")
    public void matchedIndicatorIsNotDisplayedForEachRecordInTheMainScreeningTable() {
        screeningPage.scrollToScreeningTable();
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        int resultsCount = screeningPage.getScreeningResultsList().size();
        for (int i = 1; i <= resultsCount; i++) {
            assertFalse("Matched indicator for record on position " + i + " is displayed",
                        screeningPage.isMatchedIndicatorDisplayedForRecordWithIndex(i));
        }
    }

    @Then("Resolution type {string} is selected for each record in the main screening table")
    public void resolutionTypeIsSelectedForEachRecordInTheMainScreeningTable(String resolution) {
        screeningPage.scrollToScreeningTable();
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        int resultsCount = screeningPage.getScreeningResultsList().size();
        for (int i = 1; i <= resultsCount; i++) {
            assertEquals("Screening resolution status index doesn't equals expected",
                         Resolution.valueOf(resolution).getResolutionPosition(),
                         screeningPage.getSelectedResolutionIndexByIndex(i));
        }
    }

    @Then("Sorted search {string} results for {string} appear in main screening table for current page with {string} other name positive or possible resolved results")
    public void sortedSearchResultsForAppearWithOtherNameResults(String provider, String resultsFor, String otherName) {
        screeningResultsTableIsLoaded();
        List<ResultsResponseDTO> allResults = getScreeningWithOtherNameResults(getProvider(provider), this.context,
                                                                               otherName, resultsFor);
        List<ResultsResponseDTO> expected =
                getScreeningData(getResultsForCurrentPage(allResults, currentPage, itemsPerPage), resultsFor);
        List<ResultsResponseDTO> actual = screeningPage.getScreeningResultsData(resultsFor);
        assertThat(actual).as("Screening table results with other name are not expected").isEqualTo(expected);
    }

    @Then("Sorted search {string} results for {string} appear in main screening table for current page")
    public void sortedSearchResultsForAppearInMainScreeningTable(String provider, String resultsFor) {
        screeningResultsTableIsLoaded();
        List<ResultsResponseDTO> allResults = getScreeningResults(context, resultsFor, getProvider(provider));
        List<ResultsResponseDTO> expected =
                getScreeningData(getResultsForCurrentPage(allResults, currentPage, itemsPerPage), resultsFor);
        List<ResultsResponseDTO> actual = screeningPage.getScreeningResultsData(resultsFor);
        assertThat(actual).as("Screening table results are not expected").usingRecursiveComparison()
                .ignoringFields("category").isEqualTo(expected);

        List<String> expectedCategories = screeningPage.getSortedCategories(expected);
        List<String> actualCategories = screeningPage.getSortedCategories(actual);
        assertThat(actualCategories).as("The categories are not expected").isEqualTo(expectedCategories);
    }

    @Then("New Match indicator is present for {string} records according to WC1 results for {string}")
    public void newMatchIndicatorIsPresentForRecordsAccordingToWCResults(String provider, String resultsFor) {
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        List<ResultsResponseDTO> expectedScreeningResults =
                getResultsForCurrentPage(getScreeningResults(context, resultsFor, getProvider(provider)),
                                         currentPage, itemsPerPage);
        CaseResponseDTO caseResponse = getCaseResponse(getSearchId(context, resultsFor));
        expectedScreeningResults.forEach(result -> {
            String referenceId = result.getReferenceId().replaceAll(ID_REGEX, StringUtils.EMPTY);
            if (isResultNewMatch(result, caseResponse)) {
                assertTrue("Matched indicator for record with ID: " + referenceId + " is not displayed",
                           screeningPage.isMatchedIndicatorDisplayedForRecordWithId(referenceId));
            } else {
                assertFalse("Matched indicator for record with ID: " + referenceId + " is displayed",
                            screeningPage.isMatchedIndicatorDisplayedForRecordWithId(referenceId));
            }
        });
    }

    @Then("Search criteria {string} contains {string} value")
    public void searchCriteriaContainsValue(String criteriaName, String expectedValue) {
        assertEquals(criteriaName + " search criteria doesn't contain expected value",
                     expectedValue.isEmpty() ? null : expectedValue,
                     screeningPage.getSearchCriteriaValue(criteriaName));
    }

    @Then("Search criteria value of {string} is")
    public void searchCriteriaValueIs(String criteriaName, DataTable dataTable) {
        SoftAssert soft = new SoftAssert();
        dataTable.asList().forEach(text -> soft.assertEquals(text, screeningPage.getSearchCriteriaValue(criteriaName),
                                                             " search criteria doesn't contain expected value"));
        soft.assertAll();
    }

    @Then("Search criteria {string} is empty")
    public void searchCriteriaValueEMPTY(String criteriaName) {
        assertNull(criteriaName + " search criteria is not empty",
                   screeningPage.getSearchCriteriaValue(criteriaName));
    }

    @Then("Search criteria {string} drop-down field is displayed with list of countries from WC1")
    public void addDropDownFieldIsDisplayedWithListOfCountriesFromWC(String countryType) {
        List<String> expectedDropDownValues = getWC1CountriesNamesList();
        List<String> actualDropDownValues = screeningPage.openAndGetSearchCriteriaDropDownListValues(countryType);
        assertThat(actualDropDownValues)
                .as("%s drop-down list doesn't contains expected values", countryType)
                .isEqualTo(expectedDropDownValues);
        screeningPage.clickSearchCriteriaOpenDropDown(countryType, "Close");
    }

    @Then("Button with name {string} is displayed on screening modal window")
    public void buttonWithNameIsDisplayed(String buttonName) {
        screeningPage.isModalButtonDisplayed(buttonName);
    }

    @Then("Selected {string} country {string} is disabled")
    public void selectedCountryIsDisabled(String countryType, String value) {
        screeningPage.clickSearchCriteriaOpenDropDown(countryType, OPEN);
        assertTrue(value + " option is not disabled", screeningPage.isDropDownOptionWithTextDisabled(value));
    }

    @Then("Review button is displayed")
    public void reviewButtonIsDisplayed() {
        assertTrue("Review button is not displayed", screeningPage.isButtonWithNameDisplayed(REVIEW));
    }

    @Then("Review button is not displayed")
    public void reviewButtonIsNotDisplayed() {
        assertFalse("Review button is still displayed", screeningPage.isButtonWithNameDisplayed(REVIEW));
    }

    @Then("Resolution is not changed for {string} {string} screening results")
    @SuppressWarnings("unchecked")
    public void resolutionIsNotChangedForScreeningResults(String provider, String resultsFor) {
        List<ResultsResponseDTO> screeningResultsBeforeReview =
                (List<ResultsResponseDTO>) context.getScenarioContext().getContext(SCREENING_RESULTS_BEFORE_REVIEW);
        List<ResultsResponseDTO> screeningResultsAfterReview =
                getScreeningResults(context, resultsFor, getProvider(provider));
        screeningResultsBeforeReview.forEach(resultBeforeReview -> {
            ResultsResponseDTO resultAfterReview = screeningResultsAfterReview
                    .stream()
                    .filter(resultAfter -> resultAfter.getReferenceId().equals(resultBeforeReview.getReferenceId()))
                    .findFirst()
                    .orElseThrow(() -> new RuntimeException("Screening Result is not found"));
            assertEquals("Resolution is changed after review", resultBeforeReview.getResolution(),
                         resultAfterReview.getResolution());
        });
    }

    @Then("Add Comment modal is disappeared")
    public void addCommentDialogIsDisappeared() {
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        assertTrue("Add Comment Dialog isn't disappeared", screeningPage.isAddCommentDialogDisappeared());
    }

    @Then("Add Comment modal is displayed")
    public void addCommentDialogIsDisplayed() {
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        assertTrue("Add Comment modal is not displayed", screeningPage.isAddCommentDialogDisplayed());
    }

    @Then("Screening section displays Last Screening Date message with date in format: {string}")
    public void screeningSectionDisplaysLastScreeningDateInFormat(String date) {
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        String lastScreeningDate = translator.getValue("thirdPartyInformation.screening.lastScreeningDateUppercase");
        String formattedDate = date.replace(SI_MAIN_SCREENING_DATE_FORMAT, getTodayDate(SI_MAIN_SCREENING_DATE_FORMAT));
        String expectedText = lastScreeningDate + SPACE + formattedDate;
        assertEquals("Screening section displays unexpected text", expectedText,
                     screeningPage.getLasScreeningDateText());
    }

    @Then("Screening date has value {string}")
    public void screeningSectionDisplaysLastScreeningDateEmpty(String expectedText) {
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        assertEquals("Screening section displays date", expectedText,
                     screeningPage.getLasScreeningDateText());
    }

    @Then("Screening section Change Search Criteria button is displayed")
    public void screeningSectionChangeSearchCriteriaButtonIsDisplayed() {
        assertTrue("Screening section Change Search Criteria button is not displayed",
                   screeningPage.isButtonWithNameDisplayed(
                           translator.getValue("thirdPartyInformation.screening.changeSearchCriteriaButton")));
    }

    @Then("Screening section Export to Excel button is displayed")
    public void screeningSectionExportToExcelButtonIsDisplayed() {
        assertTrue("Screening section Export to Excel button is not displayed",
                   screeningPage.isButtonWithNameDisplayed(translator.getValue(
                           "thirdPartyInformation.screening.exportToExcel")));
    }

    @Then("Screening section Bell icon is displayed")
    public void screeningSectionBellIconIsDisplayed() {
        assertTrue("Screening section Bell icon is not displayed",
                   screeningPage.isNotifyButtonDisplayed());
    }

    @Then("ADD RECIPIENT modal is displayed with {string} recipient")
    public void addRecipientModalIsDisplayedWithRecipient(String recipient) {
        assertTrue("ADD RECIPIENT modal is not displayed with " + recipient + " recipient",
                   screeningPage.isRecipientDisplayed(recipient));
    }

    @Then("ADD RECIPIENT modal is displayed without {string} recipient")
    public void addRecipientModalIsDisplayedWithoutRecipient(String recipient) {
        assertFalse("ADD RECIPIENT modal is not displayed with " + recipient + " recipient",
                    screeningPage.isRecipientDisplayed(recipient));
    }

    @Then("ADD RECIPIENT modal is displayed with user role {string} recipient")
    public void addRecipientModalIsDisplayedWithUserRoleRecipient(String userReference) {
        UserData userData = getUserCredentialsByRole(userReference);
        String expectedAssignee =
                format(USER_FORMAT, (userData.getFirstName()), userData.getLastName());
        assertTrue("ADD RECIPIENT modal is not displayed with " + expectedAssignee + " recipient",
                   screeningPage.isRecipientDisplayed(expectedAssignee));
    }

    @Then("Add recipient modal is disappeared")
    public void addRecipientModalIsDisappeared() {
        assertTrue("Add recipient modal is not disappeared",
                   screeningPage.isAddRecipientModalDisappeared());
    }

    @Then("Screening section Ongoing Screening slider is displayed")
    public void screeningSectionOngoingScreeningButtonIsDisplayed() {
        assertTrue("Screening section Ongoing Screening button is not displayed",
                   screeningPage.isOgsSliderDisplayed());
    }

    @Then("Screening section table displays expected columns")
    public void screeningSectionTableDisplaysExpectedColumns(DataTable expectedColumns) {
        List<String> columns =
                expectedColumns.asList().stream().map(translator::getValue).map(String::toUpperCase).collect(toList());
        assertEquals("Screening section table doesn't display expected columns",
                     columns, screeningPage.getScreeningTableColumnNames());
    }

    @Then("Add Comment modal is displayed with text")
    public void addCommentModalIsDisplayedWithText(List<String> expectedText) {
        String actualText = screeningPage.getCommentModalContentText();
        expectedText.forEach(text ->
                                     assertTrue("Add Comment modal text '" + actualText +
                                                        "' doesn't contain expected text: " +
                                                        screeningPage.getFromDictionaryIfExists(text),
                                                actualText.contains(screeningPage.getFromDictionaryIfExists(text))));
    }

    @Then("^Add Comment modal \"(Cancel|Add|Save)\" button is displayed$")
    public void addCommentModalButtonIsDisplayed(String buttonType) {
        boolean result;
        switch (buttonType) {
            case ADD:
                result = screeningPage.isModalButtonDisplayed(ADD);
                break;
            case CANCEL:
                result = screeningPage.isModalButtonDisplayed(
                        screeningPage.getFromDictionaryIfExists("thirdPartyInformation.relatedFiles.cancelButton"));
                break;
            case SAVE:
                result = screeningPage.isModalButtonDisplayed(
                        screeningPage.getFromDictionaryIfExists("contact.saveButton"));
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
        assertTrue(String.format("%s button is not displayed", buttonType), result);
    }

    @Then("Resolution menu is displayed with options")
    public void resolutionMenuIsDisplayedWithOptions(DataTable dataTable) {
        List<String> expectedOptions = dataTable.asList();
        String actualOptions = screeningPage.getResolutionOptionsText();
        expectedOptions.forEach(
                text -> assertTrue("Add Comment modal " + actualOptions + " is not displayed with text " +
                                           screeningPage.getFromDictionaryIfExists(text),
                                   actualOptions.contains(screeningPage.getFromDictionaryIfExists(text))));
    }

    @Then("Cancel resolution button is displayed")
    public void cancelResolutionButtonIsDisplayed() {
        assertTrue("Cancel resolution button is not displayed", screeningPage.isCancelButtonDisplayed());
    }

    @Then("Screening section is collapsed")
    public void screeningSectionIsCollapsed() {
        assertTrue("Screening section is not collapsed", screeningPage.isScreeningSectionCollapsed());
    }

    @Then("Label toggle is displayed as {string}")
    public void OGSLabel(String label) {
        assertEquals("Screening section displays unexpected text", label,
                     screeningPage.getOGSLabel(label));
    }

    @Then("MEDIA CHECK page is hidden OGS Toggle {string} for Screening section")
    public void ogsToggleShouldBeInvisible(String label) {
        assertTrue("MEDIA CHECK page is not hidden OGS Toggle for Screening section",
                   screeningPage.checkOGSToggleShouldBeInvisible(label));
    }

    @Then("{string} tab is displayed")
    public void tabIsDisplayed(String tabName) {
        assertTrue(tabName + " Tab is not displayed",
                   screeningPage.isTabOnScreeningPageAppear(tabName));
    }

    @Then("{string} tab on modal is displayed")
    public void tabOnModalIsDisplayed(String tabName) {
        assertTrue(tabName + " Tab is not displayed",
                   screeningPage.isTabOnScreeningModalAppear(tabName));
    }

    @Then("No Available Data on {string} tab is displayed")
    public void noMatchFoundIsDisplayed(String tabName) {
        assertTrue("No Match Found on" + tabName + " tab is not displayed",
                   screeningPage.isNoAvailableDataDisplayed(tabName));
    }

    @Then("Smart filter toggle button should be on")
    public void smarFilterToggleShouldBeOn() {
        assertTrue("Smart filter is not turned on", screeningPage.isSmartFilterButtonTurnOn());
    }

    @Then("MEDIA CHECK tab is disabled")
    public void mediaCheckTabIsDisabled() {
        assertTrue("MEDIA CHECK tab is enabled", screeningPage.isMediaCheckTabDisabled());
    }

    @Then("MEDIA CHECK tab screening result contains No Match Found")
    public void isNoMatchFoundMessageDisplayed() {
        assertTrue("No Match Found Message is not displayed!",
                   screeningPage.isMediaCheckTableNoMatchFoundMessageDisplayed());
    }

    @Then("User should see {string} in Media Check Screening Result Table")
    public void isScreeningDateDislayCorrectly(String searchTerm) {
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        assertEquals("Search term is displayed incorrectly", searchTerm,
                     screeningPage.getMediaCheckSearchTermInScreeningResultTable());
    }

    @Then("Rows per page Drop-Down list is displayed with values")
    public void rowsPerPageDropDownListIsDisplayedWithValues(DataTable dataTable) {
        List<String> expectedOptions = dataTable.asList();
        screeningPage.clickRowsPerPageDropDown();
        assertEquals("Rows per page Drop-Down list is not displayed with expected values", expectedOptions,
                     screeningPage.getRowsPerPageDropDownOptions());
    }

    @Then("Rows per page dropdown value should be {string}")
    public void getMediaCheckRowsPerPageValue(String expectedValue) {
        assertEquals("Rows per page value does not match with the expected value", expectedValue,
                     screeningPage.getMediaCheckRowsPerPageValue());
    }

    @Then("Media Check Result Table should contain {int} records")
    public void getMediaCheckRecordsFromResultTable(int expectedNumRecords) {
        assertEquals("Number of records display in result table does not match with the expected value",
                     expectedNumRecords, screeningPage.getTotalRecordsFromMediaCheckResultTable());
    }

    @Then("User should see Rows per page label")
    public void getRowsPerPageLabel() {
        assertEquals("Rows per page label is incorrect", "Rows per page:", screeningPage.getRowsPerPageLabel());
    }

    @Then("Notify button is invisible in Media Check tab")
    public void isNotifyButtonInvisible() {
        assertTrue("Notify button is visible", screeningPage.checkNotifyButtonDoesNotDisplay());
    }

    @Then("OGS slider is turned ON")
    public void ogsSliderIsTurnedOn() {
        assertThat(screeningPage.isOgsSliderTurned()).as("OGS slider is turned OFF").isTrue();
    }

    @Then("OGS slider is turned OFF")
    public void ogsSliderIsTurnedOff() {
        assertThat(screeningPage.isOgsSliderTurned()).as("OGS slider is turned ON").isFalse();
    }

    @Then("OGS alert message {string} is displayed")
    public void ogsAlertMessageIsDisplayed(String alertMessage) {
        assertTrue("OGS Toggle is not disable",
                   screeningPage.isOGSAlertMessageDisplayed(alertMessage));
    }

    @Then("^Check Type is (checked|unchecked)$")
    public void checkTypeIsCheckedOnTheFollowingList(String checkType, DataTable dataTable) {
        SoftAssert soft = new SoftAssert();
        if (checkType.equals(CHECKED)) {
            dataTable.asList()
                    .forEach(text -> soft.assertTrue(screeningPage.isCheckTypeInChangeSearchCriteriaChecked(text),
                                                     "Check Type '" + text + "' isn't checked"));
        } else {
            dataTable.asList()
                    .forEach(text -> soft.assertFalse(screeningPage.isCheckTypeInChangeSearchCriteriaChecked(text),
                                                      "Check Type '" + text + "' is checked"));
        }
        soft.assertAll();
    }

    @Then("Mark all as reviewed button is displayed")
    public void markAllAsReviewedButtonIsDisplayed() {
        assertTrue("Mark all as reviewed Button is not displayed",
                   screeningPage.isMarkAllAsReviewedButtonDisplay());
    }

    @Then("Mark all as reviewed button is not displayed")
    public void markAllAsReviewedButtonIsNotDisplayed() {
        assertFalse("Mark all as reviewed Button is still displayed",
                    screeningPage.isMarkAllAsReviewedButtonDisplay());
    }

    @Then("Media Resolution is displayed")
    public void mediaResolutionIsDisplayed() {
        assertTrue("Media Resolution is not displayed",
                   screeningPage.isMediaResolutionDisplay());
    }

    @Then("Media Resolution is not displayed")
    public void mediaResolutionIsNotDisplayed() {
        assertFalse("Media Resolution is still displayed",
                    screeningPage.isMediaResolutionDisplay());
    }

    @Then("Media Resolution on Screening Result is displayed")
    public void mediaResolutionScreeningResultIsDisplayed() {
        screeningPage.waitWhileSeveralPreloadProgressBarsAreDisappeared(20);
        assertTrue("Media Resolution on Screening Result is not displayed",
                   screeningPage.isMediaResolutionScreeningResultDisplay());
    }

    @Then("Media Resolution on Screening Result is not displayed")
    public void mediaResolutionScreeningResultIsNotDisplayed() {
        assertFalse("Media Resolution on Screening Result is still displayed",
                    screeningPage.isMediaResolutionScreeningResultDisplay());
    }

    @Then("Screening Section is not displayed")
    public void screeningSectionIsNotDisplayed() {
        assertFalse("Screening Section is still displayed",
                    screeningPage.isScreeningSectionDisplay());
    }

    @Then("Verify third-party screening record for {string} on the positions from {string}")
    public void selectRecordOnPosition(String resultsFor, String sourceData) {
        screeningResultsTableIsLoaded();
        SoftAssert softAssert = new SoftAssert();
        List<ResultsResponseDTO> list = screeningPage.getScreeningResultsData(resultsFor);
        for (ResultsResponseDTO selectedResult : list) {
            boolean isPrimaryNameLongerExpected = selectedResult.getPrimaryName().length() > NUMBER_OF_CHARACTERS_NAME;
            String expectedDisplayName;
            if (isPrimaryNameLongerExpected) {
                expectedDisplayName =
                        selectedResult.getPrimaryName().substring(0, NUMBER_OF_CHARACTERS_NAME).concat(ELLIPSIS);
            } else {
                expectedDisplayName = selectedResult.getDisplayName();
            }
            if (WORLD_CHECK_ONE.equals(sourceData)) {
                expectedDisplayName = expectedDisplayName.toUpperCase();
                softAssert.assertNotNull(selectedResult.getCategory(), "There aren't value in Type field");
                softAssert.assertTrue(StringUtils.isNumeric(selectedResult.getReferenceId()),
                                      "Value of ReferenceId isn't numeric");
            } else {
                softAssert.assertTrue(selectedResult.getReferenceId().startsWith(CUSTOM_WATCHLIST_PREFIX_REF_ID),
                                      "Prefix of ReferenceId isn't e_clwl_");
            }
            softAssert.assertNotNull(selectedResult.getDisplayName(), "There aren't value in Name field");
            softAssert.assertEquals(selectedResult.getDisplayName(), expectedDisplayName,
                                    "Display name not correct format");
            if (!UNKNOWN_VALUE.equalsIgnoreCase(selectedResult.getCountryLinksString())) {
                softAssert.assertTrue(Arrays.stream(CountryCode.values())
                                              .anyMatch(code -> code.getName().toUpperCase()
                                                      .equals(selectedResult.getCountryLinksString())),
                                      "Value of Country Of Registration isn't full country name");
            } else {
                softAssert.assertTrue(UNKNOWN_VALUE.equals(selectedResult.getCountryLinksString()),
                                      "Value of Country Of Registration (UNKNOWN) isn't uppercase");
            }
            softAssert.assertEquals(selectedResult.getMatchStrength().toUpperCase(),
                                    selectedResult.getMatchStrength(), "Value of Match Strength isn't uppercase");
            softAssert.assertEquals(sourceData, selectedResult.getProviderTypeString(),
                                    "Value doesn't match with World-Check One or Custom WatchList");
        }
        softAssert.assertAll();
    }

    @Then("ADD RECIPIENT modal is not displayed with {string} recipient")
    public void addRecipientModalIsNotDisplayedWithRecipient(String recipient) {
        assertFalse("ADD RECIPIENT modal is displayed with " + recipient + " recipient",
                    screeningPage.isRecipientDisplayed(recipient));
    }

    @Then("Add recipient ADD button should be disabled")
    public void addRecipientAddButtonIsDisabled() {
        assertThat(screeningPage.isAddRecipientAddButtonDisabled()).as("Add button is enabled").isTrue();
    }

    @Then("Add Third-party Search criteria Notification Recipients field displayed with {string}")
    public void checkNotificationRecipientsFieldValue(String recipient) {
        assertThat(screeningPage.getNotificationRecipient()).as("Unexpected Notification Recipients field value")
                .isEqualTo(recipient);
    }

    @Then("Add Third-party Search criteria sections Search Term is displayed")
    public void isSearchTermDisplayed() {
        thirdPartyPage.expandSectionIfCollapsed(SCREENING_CRITERIA);
        assertThat(screeningPage.isSearchItemDisplayed()).as("Search Term field is not displayed").isTrue();
    }

    @Then("^Add Third-party Search criteria Country field is displayed with Same as address country checkbox (checked|unchecked)$")
    public void checkCountryFieldAndCheckBox(String state) {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(screeningPage.isSameAsAddressCountryFieldDisplayed(),
                              "Same As Address Country field is not displayed");
        if (state.equals(CHECKED)) {
            softAssert.assertTrue(screeningPage.isSameAsAddressCountryCheckboxChecked(),
                                  "Same As Address Country Checkbox is not checked");
        } else {
            softAssert.assertFalse(screeningPage.isSameAsAddressCountryCheckboxChecked(),
                                   "Same As Address Country Checkbox is checked");
        }
        softAssert.assertAll();
    }

    @Then("^Add Third-party Search criteria Ongoing Screening World-check checkbox is (checked|unchecked)$")
    public void checkOngoingScreeningWorldCheckCheckbox(String state) {
        if (state.equals(CHECKED)) {
            assertThat(screeningPage.isOngoingScreeningWorldCheckCheckboxChecked()).as(
                    "Ongoing Screening World-check checkbox is not checked").isTrue();
        } else {
            assertThat(screeningPage.isOngoingScreeningWorldCheckCheckboxChecked()).as(
                    "Ongoing Screening World-check checkbox is checked").isFalse();
        }
    }

    @Then("^Add Third-party Search criteria Notification Recipients User checkbox is (checked|unchecked)$")
    public void checkNotificationRecipientsUserCheckbox(String state) {
        if (state.equals(CHECKED)) {
            assertThat(screeningPage.isNotificationRecipientsUserCheckboxChecked()).as(
                    "Notification Recipients User checkbox is not checked").isTrue();
        } else {
            assertThat(screeningPage.isNotificationRecipientsUserCheckboxChecked()).as(
                    "Notification Recipients User checkbox is checked").isFalse();
        }
    }

    @Then("ADD RECIPIENT modal Recipient drop-down contains all Active Internal Users in the System except {string} responsible party")
    public void checkRecipientDropDownActiveUsersList(String userReference) {
        String responsibleParty = getUserCredentialsByRole(userReference).getFirstName() + SPACE +
                getUserCredentialsByRole(userReference).getLastName();
        String uiAdditionalInfo = " (OOO)";
        List<String> expectedUsersList =
                getAllActiveInternalUsersStream(APIConstants.DESC).map(
                                name -> name.getName().replace(DOUBLE_SPACE, SPACE).trim())
                        .sorted().collect(toList());
        expectedUsersList.remove(responsibleParty);
        List<String> actualUsersList = screeningPage.getRecipientDropDownList().stream().sorted()
                .map(name -> name.replace(uiAdditionalInfo, StringUtils.EMPTY)).collect(toList());
        assertThat(actualUsersList).as("Recipient dropdown does not contain Active Internal Users")
                .containsAll(expectedUsersList);
    }

    @Then("OGS Toggle label as {string} is hidden")
    public void ogsToggleLabelIsHidden(String label) {
        assertTrue("OGS Toggle label is not hidden",
                   screeningPage.checkOGSToggleShouldBeInvisible(label));
    }

    @Then("OGS Toggle is hidden")
    public void ogsToggleIsHidden() {
        assertTrue("OGS Toggle is not hidden",
                   screeningPage.isOGSToggleHidden());
    }

    @Then("Screening Bell icon is hidden")
    public void screeningBellIconIsHidden() {
        assertTrue("Screening Bell icon is not hidden",
                   screeningPage.isBellIconHidden());
    }

    @Then("OGS Toggle is disable")
    public void ogsToggleIsDisable() {
        assertTrue("OGS Toggle is not disable",
                   screeningPage.isOGSToggleDisable());
    }

    @Then("WC Screening Tooltip {string} is displayed in TYPE column")
    public void wcScreeningTooltipIsDisplayed(String tooltip) {
        assertThat(screeningPage.isTooltipWCTypeDisplayed(tooltip)).as("Expected WC Screening Tooltip is not displayed")
                .isTrue();
    }

    @Then("Match Strength Pattern is matched")
    public void matchStrengthPatternIsMatched() {
        String matchStrengthText = screeningPage.getMatchStrengthText();
        assertTrue("Match Strength is not matched", screeningPage.isStrengthPatternMatched(matchStrengthText));
    }

    @Then("Match Strength tooltip is displayed")
    public void matchStrengthToolTipIsDisplayed() {
        assertTrue("Match Strength is not displayed", screeningPage.isMatchStrengthDisplayed());
    }

    @Then("Resolution Type tooltip {string} is displayed")
    public void resolutionTypeTooltipIsDisplayed(String resolutionName) {
        assertTrue("The Resolution Typ tooltip isn't displayed",
                   screeningPage.isResolutionToolTipDisplayed(resolutionName));
    }

    @Then("Resolution Type Pattern is matched")
    public void resolutionTypePatternIsMatched() {
        String resolutionText = screeningPage.getResolutionTypeText();
        assertTrue("Resolution Type pattern is not matched",
                   screeningPage.isResolutionTypePatternMatched(resolutionText));
    }

    @Then("Tooltip {string} is displayed under ConnectionsRelationships Tab after User clicks on {string} Linked record and Type {string}")
    public void tooltipIsDisplayed(String tooltip, String recordName, String typeName) {
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        screeningPage.scrollIntoViewWCProfileRecord(recordName, typeName);
        screeningPage.clickTypeOfLinkedRecord(recordName, typeName);
        assertThat(screeningPage.isTooltipDisplayed(tooltip)).as("Expected Tooltip is not displayed").isTrue();
    }

    @Then("Verify contacts screening record for {string} on {int} positions from {string}")
    public void selectRecordOnPositionOfContacts(String resultsFor, int records, String sourceData) {
        screeningResultsTableIsLoaded();
        SoftAssert softAssert = new SoftAssert();
        List<ResultsResponseDTO> list = screeningPage.getScreeningResultsData(resultsFor);
        for (int i = 0; i < records; i++) {
            ResultsResponseDTO selectedResult = list.get(i);
            boolean isPrimaryNameLongerExpected = selectedResult.getPrimaryName().length() > NUMBER_OF_CHARACTERS_NAME;
            String expectedDisplayName;
            if (isPrimaryNameLongerExpected) {
                expectedDisplayName =
                        selectedResult.getPrimaryName().substring(0, NUMBER_OF_CHARACTERS_NAME).concat(ELLIPSIS);
            } else {
                expectedDisplayName = selectedResult.getDisplayName();
            }
            if (WORLD_CHECK_ONE.equals(sourceData)) {
                softAssert.assertNotNull(selectedResult.getCategory(), "There aren't value in Type field");
                softAssert.assertTrue(StringUtils.isNumeric(selectedResult.getReferenceId()),
                                      "Value of ReferenceId isn't numeric");
            } else {
                softAssert.assertTrue(selectedResult.getReferenceId().startsWith(CUSTOM_WATCHLIST_PREFIX_REF_ID),
                                      "Prefix of ReferenceId isn't e_clwl_");
            }
            softAssert.assertNotNull(selectedResult.getDisplayName(), "There aren't value in Name field");
            softAssert.assertEquals(selectedResult.getDisplayName(), expectedDisplayName,
                                    "Display name not correct format");
            if (!UNKNOWN_VALUE.equalsIgnoreCase(selectedResult.getCountryLinksString())) {
                softAssert.assertTrue(Arrays.stream(CountryCode.values()).anyMatch(code ->
                                                                                           code.getName().toUpperCase()
                                                                                                   .equals(selectedResult.getCountryLinksString())),
                                      "Value of Country Of Location isn't full country name");
            } else {
                softAssert.assertTrue(UNKNOWN_VALUE.equals(selectedResult.getCountryLinksString()),
                                      "Value of Country Of Registration (UNKNOWN) isn't uppercase");
            }
            softAssert.assertEquals(selectedResult.getMatchStrength().toUpperCase(),
                                    selectedResult.getMatchStrength(), "Value of Match Strength isn't uppercase");
            softAssert.assertEquals(sourceData,
                                    selectedResult.getProviderTypeString(),
                                    "Value doesn't match with World-Check One or Custom WatchList");
        }
        softAssert.assertAll();
    }

    @Then("{string} is a mandatory field")
    public void resolutionPopupDropdownMandatoryField(String fieldName) {
        switch (fieldName) {
            case RISK_LEVEL:
                assertThat(screeningPage.isResolutionPopupDropDownFieldMandatory(
                        RISK_LEVEL.substring(0, 4).toUpperCase())).as(
                                "Risk Level is not a mandatory field")
                        .isTrue();
                break;
            case REASON:
                assertThat(screeningPage.isResolutionPopupDropDownFieldMandatory(REASON.toUpperCase())).as(
                                "Reason is not a mandatory field")
                        .isTrue();
                break;
            default:
                throw new IllegalArgumentException("Field name: " + fieldName + " is unexpected");
        }
    }

    @Then("{string} dropdown should show {string} message")
    public void resolutionPopupShowsErrorRequiredMessage(String fieldName, String expectedRequiredErrorMessage) {
        String actualRequiredErrorMessage;
        switch (fieldName) {
            case RISK_LEVEL:
                actualRequiredErrorMessage = screeningPage.getResolutionPopupErrorRequiredMessageText(
                        RISK_LEVEL.substring(0, 4).toUpperCase());
                assertEquals("Risk Level required error message is incorrect",
                             expectedRequiredErrorMessage, actualRequiredErrorMessage);
                break;
            case REASON:
                actualRequiredErrorMessage =
                        screeningPage.getResolutionPopupErrorRequiredMessageText(REASON.toUpperCase());
                assertEquals("Reason required error message is incorrect",
                             expectedRequiredErrorMessage, actualRequiredErrorMessage);
                break;
            default:
                throw new IllegalArgumentException("Field name: " + fieldName + " is unexpected");
        }
    }

    @Then("{string} value should be empty")
    public void resolutionPopupDropdownValueIsEmpty(String fieldName) {
        String actualValue;
        switch (fieldName) {
            case RISK_LEVEL:
                actualValue = screeningPage.getResolutionPopupDropdownValue(RISK_LEVEL.substring(0, 4).toUpperCase());
                assertEquals("Risk Level is not empty", "", actualValue);
                break;
            case REASON:
                actualValue = screeningPage.getResolutionPopupDropdownValue(REASON.toUpperCase());
                assertEquals("Reason is not empty", "", actualValue);
                break;
            default:
                throw new IllegalArgumentException("Field name: " + fieldName + " is unexpected");
        }
    }

    @Then("Media Check displays {int} items selected")
    public void mediaCheckDisplayItemsSelected(int expectedItems) {
        assertTrue("Media Check items selected displayed with the unexpected value",
                   screeningPage.isItemsSelectedDisplayed(expectedItems));
    }

    @Then("Media Check items selected link Change to {string} is displayed")
    public void selectMediaCheckCheckboxOnPosition(String name) {
        assertTrue(String.format("Media Check items selected link Change to %s is not displayed", name),
                   screeningPage.isItemsSelectedDisplayed(name));
    }

    @Then("Media check screening record on position {int} is checked")
    public void mediaCheckCheckboxOnPositionIsChecked(int recordReference) {
        assertTrue(String.format("Media check screening record on position %s is not checked", recordReference),
                   screeningPage.isMediaCheckScreeningRecordChecked(recordReference));
    }

    @Then("Media Check attach modal is displayed")
    public void isMediaCheckAttachDisplayed() {
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        assertTrue("Media Check attach modal is not displayed", screeningPage.isMediaCheckAttachDisplayed());
    }

    @Then("Media Check Risk Level Filter {string} {string} is displayed")
    public void isMediaCheckRiskLevelFilterDisplayed(String riskLevel, String recordNumber) {
        assertEquals("Media Check Risk Level Filter value is not match with the expected value", recordNumber,
                     screeningPage.getFilterRiskLevel(riskLevel));
    }

    @Then("Media Check Risk Level Filter {string} is selected")
    public void isMediaCheckRiskLevelFilterSelected(String riskLevel) {
        assertTrue("Media Check Risk Level Filter is not selected", screeningPage.isFilterRiskLevel(riskLevel));
    }

    @Then("Media Check attach button is disable")
    public void isMediaCheckAttachButtonDisable() {
        assertTrue("Media Check attach button is enable", screeningPage.isMediaCheckAttachButtonDisabled());
    }

    @Then("Clear All button is disappeared")
    public void isClearAllButtonDisappeared() {
        assertTrue("Clear All button is appeared", screeningPage.isClearAllButtonDisappeared());
    }

    @Then("^Media Check Result (\\d+) Records (is|is not) checked$")
    public void isMediaCheckRecordsFromResultTable(int recordsNumber, String recordStatus) {
        screeningResultsTableIsLoaded();
        SoftAssert softAssert = new SoftAssert();
        for (int i = 1; i < recordsNumber + 1; i++) {
            if (recordStatus.equals(IS)) {
                softAssert.assertTrue(screeningPage.isMediaCheckScreeningRecordChecked(i),
                                      "Media Check Result Records is not checked");
            } else {
                softAssert.assertFalse(screeningPage.isMediaCheckScreeningRecordChecked(i),
                                       "Media Check Result Records is checked");
            }
        }
        softAssert.assertAll();
    }

    @Then("Media Check attach modal is displayed data as Risk level:{string}, Comment:{string}")
    public void isMediaCheckAttachModalDataDisplayed(String riskLevel, String comment) {
        assertTrue("Media Check attach modal is displays unexpected data",
                   screeningPage.isMediaCheckAttachModalDataDisplayed(riskLevel, comment));
    }

    @Then("Media Resolution Tag as red flag is turn off")
    public void isMediaResolutionRedFlagTurnOff() {
        assertFalse("Media Resolution Tag as red flag is turn on", screeningPage.isMediaResolutionRedFlagTurnOn());
    }

    @Then("^Screening Rows Per Page is \"(enabled|disabled)\"$")
    public void screeningRowsPerPageState(String expectedState) {
        boolean isRowsPerPageDisabled = screeningPage.isRowsPerPageDisabled();
        switch (expectedState) {
            case ENABLED:
                assertFalse("Rows Per Page is not " + ENABLED, isRowsPerPageDisabled);
                break;
            case DISABLED:
                assertTrue("Rows Per Page is not " + DISABLED, isRowsPerPageDisabled);
                break;
            default:
                throw new IllegalArgumentException("State: " + expectedState + " is incorrect");
        }
    }

    @Then("World-Check tab is selected")
    public void worldCheckTabIsSelected() {
        assertTrue("World-Check tab is not selected", screeningPage.worldCheckIsSelected());
    }

    @Then("Clear All button is displayed")
    public void isClearAllButtonDisplayed() {
        assertTrue("Clear All button is not displayed", screeningPage.isClearAllButtonDisplayed());
    }

    @Then("Media Check does not displays {int} items selected")
    public void mediaCheckNotDisplayItemsSelected(int itemsCount) {
        assertFalse("Media Check items selected is displayed with the expected value",
                    screeningPage.isItemsSelectedDisplayed(itemsCount));
    }

    @Then("Search criteria {string} is not blank")
    public void searchCriteriaValueNotBlank(String criteriaName) {
        assertNotNull(criteriaName + "is blank", screeningPage.getSearchCriteriaValue(criteriaName));
    }

    @Then("Groups field is disabled")
    public void groupsFieldIsDisabled() {
        assertThat(screeningPage.isGroupsFieldDisabled()).as("Groups field is enabled").isTrue();
    }

    @Then("^(Third-party|Contacts) Media Check screening record on position (\\d+) displays (High|Medium|Low|No Risk|Unknown) icon$")
    public void isMediaCheckDisplayedIcon(String screeningLevel, int recordReference, String riskLevelName) {
        SoftAssert soft = new SoftAssert();
        soft.assertEquals(screeningPage.getMediaCheckRecordRiskLevelIconName(recordReference), riskLevelName,
                          screeningLevel + " media check screening record displays as " + riskLevelName);
        soft.assertTrue(screeningPage.isMediaCheckRecordRiskLevelIconDisplayed(recordReference, riskLevelName),
                        "media check screening record displays incorrect color");
        soft.assertAll();
    }

    @Then("Media Check Risk Level ToolTip {string} is displayed on record {int}")
    public void isMediaCheckToolTipDisplayed(String toolTipName, int recordNumber) {
        screeningPage.scrollIntoViewMediaCheckRecord(recordNumber);
        assertTrue("Media Check Risk Level ToolTip is not displayed",
                   screeningPage.isMediaCheckRiskLevelToolTipDisplayed(toolTipName));
    }

    @Then("Groups field value in Search Criteria modal is default to {string}")
    public void groupsFieldValueInSearchCriteriaModalIsDefaultTo(String groupValue) {
        assertEquals("Groups field value is incorrect", groupValue, screeningPage.isGroupFieldDefaultValueDisplayed());
    }

    @Then("Screening Groups tooltip {string} in Search Criteria is displayed")
    public void screeningGroupsTooltipIsDisplayed(String groupTooltip) {
        assertThat(screeningPage.getGroupTooltipText())
                .as("Groups Tooltip is not matched on selected value")
                .isEqualTo(groupTooltip);
    }

    @Then("Screening Groups field contains {string}")
    public void screeningGroupsValueIsDisplayed(String groupsValue) {
        assertEquals("Groups field value is incorrect", groupsValue, screeningPage.isGroupValueDisplayed());
    }

    @Then("Search Criteria modal is disappeared")
    public void isSearchCriteriaModalDisappeared() {
        assertTrue("Search Criteria modal did not disappear", screeningPage.isSearchCriteriaModalDisappeared());
    }

    @Then("Toast message {string} is displayed")
    public void toastMessageIsDisplayed(String alertMessage) {
        assertEquals("Toast message is not displayed as expected", alertMessage, screeningPage.getToastMessages());
    }

    @Then("Add Comment modal {string} drop-down contains values")
    public void addCommentModalDropDownContainsValues(String dropDownName, List<String> expectedValues) {
        assertThat(expectedValues)
                .as("%s drop-down doesn't contain expected values", dropDownName)
                .containsAll(screeningPage.getDropDownList(dropDownName));
    }

    @Then("Add Comment modal character counter {string} is displayed")
    public void addCommentModalCharacterCounterIsDisplayed(String expectedLabel) {
        assertThat(screeningPage.getCommentCounter())
                .as("Comment modal character counter is unexpected")
                .isEqualTo(expectedLabel);
    }

    @Then("Comment modal Tag as red is turned off")
    public void commentModalTagAsRedIsTurnedOff() {
        assertThat(screeningPage.isRedFlagTurnOn())
                .as("Comment modal Tag as red is not turned off")
                .isFalse();
    }

    @Then("Screening result displays No available data")
    public void isNoAvailableDataMessageDisplayed() {
        assertTrue("Screening result is not displays No available data",
                   screeningPage.isNoMatchFoundMessageDisplayed());
    }

    @Then("Media check alert toast message is not displayed with text$")
    public void mediaCheckAlertMessageToastMessageIsNotDisplayedWithText(List<String> expectedAlertMessagesList) {
        if (screeningPage.isMediaCheckAlertToastMessageDisplayed()) {
            List<String> actualAlertMessagedList = screeningPage.getMediaCheckAlertToastMessage();
            SoftAssertions softAssert = new SoftAssertions();
            expectedAlertMessagesList.forEach(
                    message -> softAssert.assertThat(actualAlertMessagedList)
                            .as("Actual alert messages: '%s' contain expected message '%s'", actualAlertMessagedList,
                                message)
                            .doesNotContain(message));
            softAssert.assertAll();
        }
    }

    @Then("Media Check Media Resolution Risk Level {string} is highlighted")
    public void isMediaCheckMediaResolutionRiskLevelHighlighted(String riskLevel) {
        assertThat(screeningPage.isRikLevelButtonHighlighted(riskLevel)).as(
                "Media Check Media Resolution Risk Level %s is not highlighted", riskLevel).isTrue();
    }

    @Then("^Media Check Media Resolution Tag as Red Flag (is|is not) toggled$")
    public void checkRedFlagToggleState(String state) {
        screeningPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (state.equals(IS)) {
            assertThat(screeningPage.isProfileMediaResolutionRedFlagTurnOn()).as(
                    "Media Check Media Resolution Tag as Red Flag is not toggled").isTrue();
        } else {
            assertThat(screeningPage.isProfileMediaResolutionRedFlagTurnOn()).as(
                    "Media Check Media Resolution Tag as Red Flag is toggled").isFalse();
        }
    }

    @Then("Media Check record profile is displayed with next details")
    public void checkMediaCheckRecordDetails(MediaCheckProfileData expectedDetails) {
        if (expectedDetails.getName().equals(VALUE_TO_REPLACE)) {
            String recordName = (String) context.getScenarioContext().getContext(SELECTED_RECORD_NAME);
            expectedDetails.setName(recordName);
        }
        if (expectedDetails.getArticleId().equals(VALUE_TO_REPLACE)) {
            String articleId = (String) context.getScenarioContext().getContext(ARTICLE_ID);
            String uiArticleId = Arrays.stream(articleId.split(UTF_VERTICAL_BAR, -2)).collect(toList()).get(2);
            expectedDetails.setArticleId(uiArticleId);
        }
        if (expectedDetails.getLastScreeningDate().equals(TODAY_LABEL)) {
            expectedDetails.setLastScreeningDate(getTodayDate(SI_PROFILE_DATE_FORMAT));
        }
        MediaCheckProfileData actualDetails = screeningPage.getMediaCheckProfileDetails();
        assertThat(actualDetails).as("Media Check details are not expected").isEqualTo(expectedDetails);
    }

    @Then("Media check {string} accordion in the filter sidebar is expanded by default")
    public void articleAccordionIsExpanded(String menu) {
        assertThat(screeningPage.isMediaCheckFilterAccordionExpanded(menu))
                .as(menu + " menu is not expanded by default")
                .isTrue();
    }

    @Then("Media check Articles accordion in the filter sidebar displayed sub-menus")
    public void articleAccordionDisplayedSubMenus(List<String> expectedText) {
        SoftAssert soft = new SoftAssert();
        expectedText.forEach(text -> soft.assertTrue(screeningPage.isMediaCheckFilterArticleSubMenuDisplayed(text),
                                                     "Media check Articles accordion sub-menu '" + text +
                                                             "' is not displayed"));
        soft.assertAll();
    }

    @Then("Media check Articles accordion sub-menus articles number in the filter sidebar displayed the correct value")
    public void articleNumberInSubMenuIsMatched(List<String> expectedText) {
        //TODO: enhance this method later to check article number directly from the world check API
        SoftAssert soft = new SoftAssert();
        expectedText.forEach(text -> {
            String mediaCheckArticleNumber = screeningPage.getMediaCheckArticleNumber();
            if (!text.equals(PENDING_REVIEW)) {
                screeningPage.clickOnMediaCheckFilterArticleSubMenuButton(text);
                screeningResultsTableIsLoaded();
                mediaCheckArticleNumber = screeningPage.getMediaCheckArticleNumber();
            }
            soft.assertTrue(screeningPage.getMediaCheckFilterArticleSubMenusText(text)
                                    .contains(mediaCheckArticleNumber),
                            "Media check Articles accordion sub-menu '" + text +
                                    "' displays incorrect article numbers");
        });
        soft.assertAll();
    }

    @Then("Media check Smart filter section in the filter sidebar is not visible")
    public void smartFilterIsNotVisible() {
        assertThat(screeningPage.isSmartFilterSectionDisplayed())
                .as("Smart filter section in media check is visible")
                .isFalse();
    }

    @Then("Media check Smart filter section in the filter sidebar is visible")
    public void smartFilterIsVisible() {
        assertThat(screeningPage.isSmartFilterSectionDisplayed())
                .as("Smart filter section in media check is not visible")
                .isTrue();
    }

    @Then("Media check Risk Level tooltip icon in the filter sidebar is visible with the tooltip message {string}")
    public void riskLevelToolTipIconWithMessageIsVisible(String expectedTooltipMessage) {
        assertThat(screeningPage.getRiskLevelToolTipIconMessage()).as(
                "Tooltip message does not match the expected value").isEqualTo(expectedTooltipMessage);
    }

    @Then("Media check {string} Risk Level sub-menu in the filter sidebar is highlighted")
    public void riskLevelIsHighlighted(String riskLevel) {
        assertThat(screeningPage.isMediaCheckFilterRiskLevelSubMenuButtonHighlighted(riskLevel)).as(
                "Risk level button is not highlighted").isTrue();
    }

    @Then("Media check {string} Risk Level sub-menu in the filter sidebar is not highlighted")
    public void riskLevelIsNotHighlighted(String riskLevel) {
        assertThat(screeningPage.isMediaCheckFilterRiskLevelSubMenuButtonHighlighted(riskLevel)).as(
                        "Risk level button is highlighted")
                .isFalse();
    }

    @Then("Media check pagination is not visible")
    public void paginationIsNotDisplayed() {
        assertThat(screeningPage.isMediaCheckPaginationSectionDisplayed()).as("Pagination is visible").isFalse();
    }

    @Then("Media check pagination is visible")
    public void paginationIsDisplayed() {
        assertThat(screeningPage.isMediaCheckPaginationSectionDisplayed()).as("Pagination is not visible").isTrue();
    }

    @Then("Error message {string} in red color is displayed on changes Search Criteria field")
    public void errorMessageInRedColorIsDisplayedNearChangesSearchField(String errorMessage, DataTable dataTable) {
        SoftAssert softAssert = new SoftAssert();
        dataTable.asList().forEach(text -> {
            softAssert.assertTrue(screeningPage.isChangesSearchFieldInvalidAriaDisplayed(text),
                                  "Changes Search Criteria field invalid aria is not displayed");
            softAssert.assertEquals(screeningPage.getChangesSearchElementErrorMessage(text), errorMessage,
                                    "Changes Search Criteria field error message is not displayed");
            softAssert.assertEquals(screeningPage.getChangesSearchErrorMessageElementCSS(text, COLOR),
                                    REACT_RED.getColorRgba(),
                                    "Changes Search Criteria field error message is not red");
        });
        softAssert.assertAll();
    }

    @Then("^Third-party media check article name on position (\\d+) in risk level filter matches with the previous selected article$")
    public void isMediaCheckArticleNameMatched(int recordReference) {
        screeningResultsTableIsLoaded();
        String expectedName = (String) context.getScenarioContext().getContext(THIRD_PARTY_MEDIA_CHECK_RECORD);
        String actualName = screeningPage.getMediaCheckRecordName(recordReference);
        assertThat(expectedName).as("Article name does not match").isEqualTo(actualName);
    }

    @Then("Media check {string} Articles sub-menu in the filter sidebar is highlighted")
    public void isMediaCheckArticlesMenuHighlighted(String articleSubMenu) {
        assertThat(screeningPage.isMediaCheckFilterArticlesSubMenuButtonHighlighted(articleSubMenu)).as(
                "Articles sub menu button is not highlighted").isTrue();
    }

    @Then("^Media Check Profile attach button is \"(enabled|disabled)\"$")
    public void isMediaCheckProfileAttachButtonState(String expectedState) {
        boolean isAttachButtonDisable = screeningPage.isMediaCheckProfileAttachButtonDisabled();
        switch (expectedState) {
            case ENABLED:
                assertFalse("Media Check Profile attach button is not " + ENABLED, isAttachButtonDisable);
                break;
            case DISABLED:
                assertTrue("Media Check Profile attach button is not " + DISABLED, isAttachButtonDisable);
                break;
            default:
                throw new IllegalArgumentException("State: " + expectedState + " is incorrect");
        }
    }

    @Then("Media Check Profile risk level is selected")
    public void isMediaCheckProfileRiskLevelSelected(DataTable dataTable) {
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        SoftAssert softAssert = new SoftAssert();
        {
            dataTable.asList().forEach(text -> {
                softAssert.assertTrue(screeningPage.isMediaCheckProfileRiskLevelSelected(text),
                                      "Media Check Profile risk level is not selected");
                softAssert.assertEquals(screeningPage.getMediaCheckProfileRiskLevelCSS(text, COLOR),
                                        DARK_BLUE.getColorRgba(),
                                        "Media Check Profile risk level is displayed unexpected color");
            });
            softAssert.assertAll();
        }
    }

    @Then("Media Check Profile comment section is displayed username as {string} on position {int}")
    public void isMediaCheckProfileCommentUserNameDisplayed(String userName, int position) {
        assertTrue("Media Check Profile comment section is displayed unexpected username",
                   screeningPage.isMediaCheckProfileCommentUserNameDisplayed(position, userName));
    }

    @Then("Media Check Profile comment section is displayed comment as {string} on position {int}")
    public void isMediaCheckProfileCommentDisplayed(String comment, int position) {
        assertTrue("Media Check Profile comment section is displayed unexpected comment",
                   screeningPage.isMediaCheckProfileCommentDisplayed(position, comment));
    }

    @Then("Media Check Profile comment section is displayed random comment on position {int}")
    public void isMediaCheckProfileRandomCommentDisplayed(int position) {
        String commentValue = (String) context.getScenarioContext().getContext(MEDIA_CHECK_COMMENT);
        assertTrue("Media Check Profile comment section is displayed unexpected random comment as" + commentValue,
                   screeningPage.isMediaCheckProfileCommentDisplayed(position, commentValue));
    }

    @Then("Media Check Profile risk level is not selected")
    public void isMediaCheckProfileRiskLevelNotSelected(DataTable dataTable) {
        SoftAssert softAssert = new SoftAssert();
        {
            dataTable.asList().forEach(text -> {
                softAssert.assertTrue(screeningPage.isMediaCheckProfileRiskLevelNotSelected(text),
                                      "Media Check Profile risk level is selected");
                softAssert.assertEquals(screeningPage.getMediaCheckProfileRiskLevelCSS(text, COLOR),
                                        BLACK_REACT.getColorRgba(),
                                        "Media Check Profile risk level is displayed unexpected color");
            });
        }
    }

    @Then("Media Check Resolution Profile comment text box has value")
    public void mediaCheckProfileCommentHasValue(DataTable dataTable) {
        SoftAssert soft = new SoftAssert();
        dataTable.asList().forEach(text -> soft.assertEquals(text, screeningPage.getResolutionCommentValue(),
                                                             "Media Check Resolution Profile comment text box has unexpected value"));
        soft.assertAll();
    }

    @Then("Media Check Profile Tag as red flag ToolTip contains value as {string}")
    public void isMediaCheckProfileTagAsRedFlagToolTipDisplayed(String toolTipValue) {
        assertTrue("Media Check Profile Tag as red flag ToolTip contains unexpected value",
                   screeningPage.isMediaCheckProfileTagAsRedFlagToolTipDisplayed(toolTipValue));
    }

    @Then("The system re-screening with the new search term and screening results should be updated")
    public void isSystemReScreening() {
        String screeningResult =
                (String) context.getScenarioContext().getContext(SCREENING_NUMBER_BEFORE_RE_SCREENING);
        assertThat(screeningPage.getScreeningResult()).as("Screening Results are not updated")
                .isNotEqualTo(screeningResult);
    }

    @Then("The system re-screening with the original search term and screening results shouldn't be updated")
    public void isSystemReScreeningWithOriginalSearchTerm() {
        String screeningResult =
                (String) context.getScenarioContext().getContext(SCREENING_NUMBER_BEFORE_RE_SCREENING);
        assertEquals("Screening Result is not the same.", screeningResult, screeningPage.getScreeningResult());
    }

    @Then("Media check showing articles must be {string}")
    public void isMediaCheckArticleNumberMatched(String expectedArticleNumber) {
        String actualMediaCheckArticleNumber = screeningPage.getMediaCheckArticleNumber();
        assertEquals("Article number displayed unexpected value",
                     actualMediaCheckArticleNumber, expectedArticleNumber);
    }

    @Then("All media check articles must be marked as {string}")
    public void isAllMediaCheckArticleRiskLevelMarkedAsExpectedValue(String riskLevelName) {
        int recordNumber = screeningPage.getTotalRecordsFromMediaCheckResultTable();
        SoftAssert soft = new SoftAssert();
        for (int i = 1; i < recordNumber + 1; i++) {
            soft.assertEquals(screeningPage.getMediaCheckRecordRiskLevelIconName(i), riskLevelName,
                              " Media check article record displays as " + riskLevelName);
            soft.assertTrue(screeningPage.isMediaCheckRecordRiskLevelIconDisplayed(i, riskLevelName),
                            "Media check screening record displays incorrect color");
        }
        soft.assertAll();
    }

    @Then("First and last article name should matched with the previous selected first and last article name")
    public void isFirstAndLastArticleNameMatched() {
        String expectedFirstArticleName =
                (String) context.getScenarioContext().getContext(THIRD_PARTY_MEDIA_CHECK_FIRST_RECORD);
        String expectedLastArticleName =
                (String) context.getScenarioContext().getContext(THIRD_PARTY_MEDIA_CHECK_LAST_RECORD);
        assertEquals("Article first name does not match",
                     expectedFirstArticleName, screeningPage.getMediaCheckRecordName(1));
        assertEquals("Article last name does not match",
                     expectedLastArticleName,
                     screeningPage.getMediaCheckRecordName(screeningPage.getTotalRecordsFromMediaCheckResultTable()));
    }

    @Then("^The similar articles and see more label are (invisible|visible) for \"((.*))\"$")
    public void isSimilarArticlesAndSeeMoreVisible(String expectedResult, String type) {
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        String titleName = (String) context.getScenarioContext().getContext(TITLE_NAME);
        SoftAssert soft = new SoftAssert();
        soft.assertTrue(screeningPage.isTitleNameDisplayed(type, indexOfArticle, titleName),
                        "The title name is not displayed");
        if (TestConstants.VISIBLE.equals(expectedResult)) {
            soft.assertTrue(screeningPage.isSimilarArticleAndSeeMoreDisplayed(indexOfArticle, SIMILAR_ARTICLES_LABEL),
                            "The Similar Articles text is displayed");
            soft.assertTrue(screeningPage.isSimilarArticleAndSeeMoreDisplayed(indexOfArticle, SEE_MORE_LABEL),
                            "The see more text is displayed");
        } else {
            soft.assertTrue(screeningPage.isSimilarArticlesAndSeeMoreInvisible(indexOfArticle, SIMILAR_ARTICLES_LABEL),
                            "The Similar Articles label is visible");
            soft.assertTrue(screeningPage.isSimilarArticlesAndSeeMoreInvisible(indexOfArticle, SEE_MORE_LABEL),
                            "The see more label is visible");

        }
        soft.assertAll();
    }

    @Then("The source name and similar article date are displayed")
    public void isSourceNameAndDateDisplayed() {
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        int totalSimilarArticleFromApi = (int) context.getScenarioContext().getContext(TOTAL_SIMILAR_ARTICLE_FROM_API);
        String sourceName = (String) context.getScenarioContext().getContext(SOURCE_NAME);
        String dateFormat = (String) context.getScenarioContext().getContext(DATE_FORMAT);
        int totalSimilarArticle = screeningPage.getTotalSimilarArticleResultTable(indexOfArticle);
        SoftAssert soft = new SoftAssert();
        soft.assertEquals(totalSimilarArticle, totalSimilarArticleFromApi,
                          "Total of the similar articles is not equals");
        soft.assertTrue(screeningPage.isSourceNameAndSimilarArticleDateDisplayed(indexOfArticle, sourceName),
                        "The source name is not displayed");
        soft.assertTrue(screeningPage.isSourceNameAndSimilarArticleDateDisplayed(indexOfArticle, dateFormat),
                        "The similar article date is not displayed");
        soft.assertAll();
    }

    @Then("Risk Level label is displayed")
    public void riskLevelLabelIsDisplayed() {
        assertThat(screeningPage.isMediaCheckRiskLevelLabelDisplayed()).as(
                "Risk level label is not displayed").isTrue();
    }

    @Then("Risk Level options are displayed")
    public void riskLevelOptionsAreDisplayed() {
        SoftAssert soft = new SoftAssert();
        for (String riskLevel : RISK_LEVEL_OPTIONS) {
            soft.assertTrue(
                    screeningPage.isMediaCheckRiskLevelDisplayed(riskLevel.toUpperCase().replace(SPACE, UNDERSCORE)),
                    "Risk level option '" + riskLevel + "' is missing");
        }
        soft.assertAll();
    }

    @Then("Risk Level options are not selected by default")
    public void riskLevelOptionsIsNotSelectedByDefault() {
        SoftAssert soft = new SoftAssert();
        for (String riskLevel : RISK_LEVEL_OPTIONS) {
            soft.assertTrue(screeningPage.isMediaCheckRiskLevelOptionSelected(
                                    riskLevel.toUpperCase().replace(SPACE, UNDERSCORE)),
                            "Risk level option '" + riskLevel + "' is selected");
        }
        soft.assertAll();
    }

    @Then("Comment label is displayed")
    public void commentLabelIsDisplayed() {
        assertThat(screeningPage.isMediaCheckCommentLabelDisplayed()).as("Comment label is not displayed")
                .isTrue();
    }

    @Then("Media check showing articles must be as same as API value")
    public void isMediaCheckArticleNumberMatchedWithApi() {
        MediaCheckResponse results = screeningPage.getMediaCheckResponse(PAGINATION);
        String mediaCheckTotalArticle = results.getTotalResultCount();
        String actualMediaCheckArticleNumber = screeningPage.getMediaCheckArticleNumber();
        assertEquals("Article Total number displayed unexpected value",
                     actualMediaCheckArticleNumber, mediaCheckTotalArticle);
    }

    @Then("Media check first record with no external articles displays phases as blue color")
    public void isMediaCheckNoExternalArticlePhasesDisplay() {
        MediaCheckResponse results = screeningPage.getMediaCheckResponse(PAGINATION);
        prepareNoExternalArticle(results);
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        String mediaCheckPhases = (String) context.getScenarioContext().getContext(MEDIA_CHECK_PHASES);
        SoftAssert soft = new SoftAssert();
        soft.assertTrue(screeningPage.isMediaCheckPhasesColorDisplayed(indexOfArticle),
                        "Media Check Phases is displayed unexpected color");
        soft.assertEquals(screeningPage.getMediaCheckPhases(indexOfArticle), mediaCheckPhases,
                          "Media Check Phases is not matched with Phases from API");
        soft.assertAll();
    }

    @Then("Media check first record with no external articles displays topics as black color")
    public void isMediaCheckNoExternalArticleTopicsDisplay() {
        MediaCheckResponse results = screeningPage.getMediaCheckResponse(PAGINATION);
        prepareNoExternalArticle(results);
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        String mediaCheckTopics = (String) context.getScenarioContext().getContext(MEDIA_CHECK_TOPICS);
        SoftAssert soft = new SoftAssert();
        soft.assertTrue(screeningPage.isMediaCheckTopicsColorDisplayed(indexOfArticle),
                        "Media Check Topics is displayed unexpected color");
        soft.assertEquals(screeningPage.getMediaCheckTopics(indexOfArticle), mediaCheckTopics,
                          "Media Check Topics is not matched with Phases from API");
        soft.assertAll();
    }

    @Then("Media check first record with no external articles displays name as same as API value")
    public void isMediaCheckNoExternalArticleNameDisplay() {
        MediaCheckResponse results = screeningPage.getMediaCheckResponse(PAGINATION);
        prepareNoExternalArticle(results);
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        String titleName = (String) context.getScenarioContext().getContext(TITLE_NAME);
        SoftAssert soft = new SoftAssert();
        soft.assertEquals(screeningPage.getMediaCheckPublicationName(indexOfArticle), titleName,
                          "Media Check Publication Name is not matched with Phases from API");
        soft.assertAll();
    }

    @Then("Media check first record with no external articles displays date in format: {string}")
    public void mediaCheckNoExternalDisplaysDateInFormat(String date) {
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        MediaCheckResponse results = screeningPage.getMediaCheckResponse(PAGINATION);
        prepareNoExternalArticle(results);
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        String publicationDate = (String) context.getScenarioContext().getContext(PUBLICATION_DATE);
        String formattedDate = date.replace(SI_SIMILAR_ARTICLE_DATE, publicationDate);
        SoftAssert soft = new SoftAssert();
        soft.assertEquals(screeningPage.getMediaCheckDateText(indexOfArticle), formattedDate,
                          "Media Check articles displays unexpected text");
        soft.assertAll();
    }

    @Then("Media check first record with external articles displays phases as blue color")
    public void isMediaCheckExternalArticlePhasesDisplay() {
        MediaCheckResponse results = screeningPage.getMediaCheckResponse(PAGINATION);
        prepareExternalArticle(results);
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        String mediaCheckPhases = (String) context.getScenarioContext().getContext(MEDIA_CHECK_PHASES);
        SoftAssert soft = new SoftAssert();
        soft.assertTrue(screeningPage.isMediaCheckPhasesColorDisplayed(indexOfArticle),
                        "Media Check Phases is displayed unexpected color");
        soft.assertEquals(screeningPage.getMediaCheckPhases(indexOfArticle), mediaCheckPhases,
                          "Media Check Phases is not matched with Phases from API");
        soft.assertAll();
    }

    @Then("Media check first record with external articles displays topics as black color")
    public void isMediaCheckExternalArticleTopicsDisplay() {
        MediaCheckResponse results = screeningPage.getMediaCheckResponse(PAGINATION);
        prepareExternalArticle(results);
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        String mediaCheckTopics = (String) context.getScenarioContext().getContext(MEDIA_CHECK_TOPICS);
        SoftAssert soft = new SoftAssert();
        soft.assertTrue(screeningPage.isMediaCheckTopicsColorDisplayed(indexOfArticle),
                        "Media Check Topics is displayed unexpected color");
        soft.assertEquals(screeningPage.getMediaCheckTopics(indexOfArticle), mediaCheckTopics,
                          "Media Check Topics is not matched with Phases from API");
        soft.assertAll();
    }

    @Then("Media check first record with external articles displays name as same as API value")
    public void isMediaCheckExternalArticleNameDisplay() {
        MediaCheckResponse results = screeningPage.getMediaCheckResponse(PAGINATION);
        prepareExternalArticle(results);
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        String titleName = (String) context.getScenarioContext().getContext(TITLE_NAME);
        SoftAssert soft = new SoftAssert();
        soft.assertEquals(screeningPage.getMediaCheckPublicationName(indexOfArticle), titleName,
                          "Media Check Publication Name is not matched with Phases from API");
        soft.assertAll();
    }

    @Then("Media check first record with external articles displays date in format: {string}")
    public void mediaCheckExternalDisplaysDateInFormat(String date) {
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        MediaCheckResponse results = screeningPage.getMediaCheckResponse(PAGINATION);
        prepareExternalArticle(results);
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        String publicationDate = (String) context.getScenarioContext().getContext(PUBLICATION_DATE);
        String formattedDate = date.replace(SI_SIMILAR_ARTICLE_DATE, publicationDate);
        SoftAssert soft = new SoftAssert();
        soft.assertEquals(screeningPage.getMediaCheckDateText(indexOfArticle), formattedDate,
                          "Media Check articles displays unexpected text");
        soft.assertAll();
    }

    @Then("^Media Check First Page button is \"(enabled|disabled)\"$")
    public void isMediaCheckFirstPageButtonState(String expectedState) {
        boolean isFirstPageButtonDisable = screeningPage.isMediaCheckFirstPageButtonDisabled();
        switch (expectedState) {
            case ENABLED:
                assertFalse("Media Check First Page button is not " + ENABLED, isFirstPageButtonDisable);
                break;
            case DISABLED:
                assertTrue("Media Check First Page button is not " + DISABLED, isFirstPageButtonDisable);
                break;
            default:
                throw new IllegalArgumentException("State: " + expectedState + " is incorrect");
        }
    }

    @Then("^Media Check Previous Page button is \"(enabled|disabled)\"$")
    public void isMediaCheckPreviousPageButtonState(String expectedState) {
        boolean isPreviousPageButtonDisable = screeningPage.isMediaCheckPreviousPageButtonDisabled();
        switch (expectedState) {
            case ENABLED:
                assertFalse("Media Check Previous Page button is not " + ENABLED, isPreviousPageButtonDisable);
                break;
            case DISABLED:
                assertTrue("Media Check Previous Page button is not " + DISABLED, isPreviousPageButtonDisable);
                break;
            default:
                throw new IllegalArgumentException("State: " + expectedState + " is incorrect");
        }
    }

    @Then("^Media Check Next Page button is \"(enabled|disabled)\"$")
    public void isMediaCheckNextPageButtonState(String expectedState) {
        boolean isNextPageButtonDisable = screeningPage.isMediaCheckNextPageButtonDisabled();
        switch (expectedState) {
            case ENABLED:
                assertFalse("Media Check Next Page button is not " + ENABLED, isNextPageButtonDisable);
                break;
            case DISABLED:
                assertTrue("Media Check Next Page button is not " + DISABLED, isNextPageButtonDisable);
                break;
            default:
                throw new IllegalArgumentException("State: " + expectedState + " is incorrect");
        }
    }

    @Then("^Media Check Last Page button is \"(enabled|disabled)\"$")
    public void isMediaCheckLastPageButtonState(String expectedState) {
        boolean isLastPageButtonDisable = screeningPage.isMediaCheckLastPageButtonDisabled();
        switch (expectedState) {
            case ENABLED:
                assertFalse("Media Check Last Page button is not " + ENABLED, isLastPageButtonDisable);
                break;
            case DISABLED:
                assertTrue("Media Check Last Page button is not " + DISABLED, isLastPageButtonDisable);
                break;
            default:
                throw new IllegalArgumentException("State: " + expectedState + " is incorrect");
        }
    }

    @Then("Media check last articles on last page displays title as same as value from API")
    public void isMediaCheckArticleTitleLastPageDisplay() {
        String mediaCheckLastReference = (String) context.getScenarioContext().getContext(MEDIA_CHECK_LAST_REFERENCE);
        PublicationDateResponse publicationDate = screeningPage.getPublicationDate();
        String minDate = publicationDate.getMin();
        String maxDate = publicationDate.getMax();
        MediaCheckResponse results =
                screeningPage.getMediaCheckResponseForPageReference(PAGINATION, mediaCheckLastReference, minDate,
                                                                    maxDate);
        List<MediaCheckResponse.Article> mediaCheckArticle = results.getResults();
        long recordCount = mediaCheckArticle.size();
        int recordCountInt = (int) recordCount;
        String title = mediaCheckArticle.get(recordCountInt - 1).getArticleSummary().getTitle();
        assertEquals("Media Check title is not matched with title from API", title,
                     screeningPage.getMediaCheckTitle(recordCountInt));
    }

    @Then("{string} is displayed status as {string} under Kay Data Tab")
    public void pepStatusIsDisplayed(String recordName, String status) {
        screeningPage.waitWhilePreloadProgressbarIsDisappeared();
        screeningPage.scrollIntoViewWCKeyData(recordName);
        assertEquals("Key Data status is not displayed", status, screeningPage.getKeyDataValue(recordName));
    }

    @Then("WC Screening {string} Type {string} icon is displayed as grey color")
    public void IsWcIconGreyColorDisplayed(String name, String type) {
        screeningPage.scrollIntoViewWCRecord(name, type);
        assertTrue("WC Screening icon displayed unexpected color", screeningPage.isWCRecordIconDisplayed(name, type));
    }

    @Then("CONVERT TO THIRD PARTY modal is displayed")
    public void convertToThirdPartyModalIsDisplayed() {
        assertTrue("CONVERT TO THIRD PARTY modal is not displayed",
                   screeningPage.isConvertToThirdPartyModalDisplayed());
    }

    @Then("Enable screening button is displayed")
    public void isEnableScreeningButtonDisplayed() {
        assertTrue("Enable screening button is not displayed",
                   screeningPage.isEnableScreeningButtonDisplayed(ENABLE_SCREENING_BUTTON));
    }

    @Then("{string} displays the same value as value from API")
    public void isMediaCheckArticleTitleLastPageDisplay(String recordName) {
        String screeningReferenceID =
                (String) context.getScenarioContext().getContext(SCREENING_REFERENCE_IDS_WITH_PREFIX_CONTEXT);
        PepResponse results = screeningPage.getPepResponse(screeningReferenceID);
        String pepDate = results.getPayload().pepStatus;
        assertEquals("Key Data status is not displayed", pepDate, screeningPage.getKeyDataValue(recordName));
    }

}