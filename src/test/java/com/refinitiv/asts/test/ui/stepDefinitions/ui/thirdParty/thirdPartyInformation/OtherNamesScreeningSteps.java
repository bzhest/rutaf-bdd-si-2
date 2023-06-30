package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.thirdPartyInformation;

import com.google.common.collect.Iterables;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.mediacheck.MediaCheckResponse;
import com.refinitiv.asts.test.ui.api.model.mediacheck.PublicationDateResponse;
import com.refinitiv.asts.test.ui.constants.TestConstants;
import com.refinitiv.asts.test.ui.enums.CountryType;
import com.refinitiv.asts.test.ui.enums.KeyData;
import com.refinitiv.asts.test.ui.enums.Resolution;
import com.refinitiv.asts.test.ui.enums.ScreeningProfileHeaderColumns;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.OtherNameScreeningSectionPage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ScreeningProfileSectionPage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ThirdPartyInformationPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.utils.DateUtil;
import com.refinitiv.asts.test.ui.utils.wc1.model.ProfileResponseDTO;
import com.refinitiv.asts.test.ui.utils.wc1.model.ResultsResponseDTO;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.assertj.core.api.SoftAssertions;
import org.testng.asserts.SoftAssert;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.AppApi.NAME_FILTER;
import static com.refinitiv.asts.test.ui.api.AppApi.getUserDataByEmail;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.ConnectionTableColumns.getConnectionColumnNames;
import static com.refinitiv.asts.test.ui.enums.CountryType.LOCATION;
import static com.refinitiv.asts.test.ui.enums.CountryType.REGISTEREDIN;
import static com.refinitiv.asts.test.ui.enums.EntityType.SUPPLIER;
import static com.refinitiv.asts.test.ui.enums.EventType.BIRTH;
import static com.refinitiv.asts.test.ui.enums.EventType.DEATH;
import static com.refinitiv.asts.test.ui.enums.FurtherInformation.*;
import static com.refinitiv.asts.test.ui.enums.KeyData.*;
import static com.refinitiv.asts.test.ui.enums.KeywordsTableColumns.getKeywordColumnNames;
import static com.refinitiv.asts.test.ui.enums.NameTypes.*;
import static com.refinitiv.asts.test.ui.enums.Resolution.UNRESOLVED;
import static com.refinitiv.asts.test.ui.enums.Resolution.UNSPECIFIED;
import static com.refinitiv.asts.test.ui.enums.ScreeningProfileTabs.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static com.refinitiv.asts.test.utils.FileUtil.readDownloadedPdfFile;
import static com.refinitiv.asts.test.ui.utils.PaginationUtil.getTotalPages;
import static com.refinitiv.asts.test.ui.utils.ScreeningCSVReportBuilder.getResolutionStatus;
import static com.refinitiv.asts.test.ui.utils.wc1.ProfileExpectedDataBuilder.*;
import static com.refinitiv.asts.test.ui.utils.wc1.ScreeningResultExpectedDataBuilder.*;
import static com.refinitiv.asts.test.ui.utils.wc1.WCOApiResponseExtractor.getProfileResponse;
import static java.lang.Integer.parseInt;
import static java.lang.String.join;
import static java.util.Objects.nonNull;
import static java.util.stream.Collectors.toList;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.*;

@Slf4j
public class OtherNamesScreeningSteps extends BaseSteps {

    public static final String SYSTEM_NOTICE = "System Notice";
    public static final String DECEASED = "DECEASED";
    private final OtherNameScreeningSectionPage otherNameScreeningSectionPage;
    private final ThirdPartyInformationPage thirdPartyPage;
    private final ScreeningProfileSectionPage profileSectionPage;
    private List<ResultsResponseDTO> wcoScreeningResults;
    private ProfileResponseDTO profile;
    private int currentPage;
    private int itemsPerPage = 10;
    private int openedResultIndex;

    public OtherNamesScreeningSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.otherNameScreeningSectionPage = new OtherNameScreeningSectionPage(this.driver, this.context, translator);
        this.profileSectionPage = new ScreeningProfileSectionPage(this.driver, this.context, translator);
        this.thirdPartyPage = new ThirdPartyInformationPage(this.driver, this.context, this.translator);
        context.getScenarioContext().setContext(RESOLVED_RECORDS_ID_LIST, new ArrayList<>());
    }

    private String getReferenceId(String screeningResultsFor, int elementIndex, String resolution) {
        String referenceId;
        ResultsResponseDTO markedResult;
        List<ResultsResponseDTO> otherNameScreeningResultsData =
                otherNameScreeningSectionPage.getOtherNameScreeningResultsData(screeningResultsFor);
        if (context.getScenarioContext().isContains(RECORD_ID + elementIndex) &&
                nonNull(context.getScenarioContext().getContext(RECORD_ID + elementIndex))) {
            referenceId = (String) context.getScenarioContext().getContext(RECORD_ID + elementIndex);
            markedResult =
                    otherNameScreeningResultsData.stream().filter(result -> result.getReferenceId().equals(referenceId))
                            .findFirst().orElseThrow(() -> new RuntimeException("Marked result was not found"));
        } else {
            markedResult = otherNameScreeningResultsData.get(elementIndex - 1);
            referenceId = markedResult.getReferenceId();
            context.getScenarioContext().setContext(RECORD_ID + elementIndex, referenceId);
        }
        updateResolutionList(
                Resolution.valueOf(resolution).getResolutionPosition() == markedResult.getResolutionPosition(),
                resolution, referenceId);
        context.getScenarioContext().setContext(SCREENING_MARKED_RESULT_CONTEXT, markedResult);
        return referenceId;
    }

    private void prepareNoExternalArticleForOtherNames(MediaCheckResponse results) {
        MediaCheckResponse.Article mediaCheckArticle;
        mediaCheckArticle =
                results.getResults().stream().filter(a -> !Objects.equals(a.getArticleSummary().getSnippet(), EMPTY) &&
                                a.getArticleSummary().getPhases() != null && a.getArticleSummary().getTopics() != null)
                        .findFirst()
                        .orElseThrow(() -> new RuntimeException("Data was not found"));
        int indexOfArticle = otherNameScreeningSectionPage.getIndexOfArticleOtherName(results, mediaCheckArticle);
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

    private void prepareExternalArticleForOtherNames(MediaCheckResponse results) {
        MediaCheckResponse.Article mediaCheckArticle;
        mediaCheckArticle =
                results.getResults().stream().filter(a -> a.getArticleSummary().getSnippet().equals(EMPTY) &&
                                a.getArticleSummary().getTopics() != null && a.getArticleSummary().getPhases() != null)
                        .findFirst()
                        .orElseThrow(() -> new RuntimeException("Data was not found"));
        int indexOfArticle = otherNameScreeningSectionPage.getIndexOfArticleOtherName(results, mediaCheckArticle);
        context.getScenarioContext().setContext(INDEX_OF_ARTICLES, indexOfArticle);
        List<MediaCheckResponse.Article> mediaCheckResult = results.getResults();
        List<String> phases = mediaCheckResult.get(indexOfArticle - 1).getArticleSummary().getPhases();
        String phasesComma = String.join(COMMA_SPACE, phases);
        context.getScenarioContext().setContext(MEDIA_CHECK_PHASES, phasesComma);
        List<String> topics = mediaCheckResult.get(indexOfArticle - 1).getArticleSummary().getTopics();
        String topicsComma = String.join(COMMA_SPACE, topics);
        String topicsUpdate = COMMA_SPACE + topicsComma;
        context.getScenarioContext().setContext(MEDIA_CHECK_TOPICS, topicsUpdate);
        mediaCheckResult = results.getResults();
        String titleName = mediaCheckResult.get(indexOfArticle - 1).getArticleSummary().getPublication().getName();
        context.getScenarioContext().setContext(TITLE_NAME, titleName);
        String publicationDate = mediaCheckResult.get(indexOfArticle - 1).getArticleSummary().getPublicationDate();
        String dateFormat = DateUtil.convertDateFormat(API_DATE_FORMAT, SI_SIMILAR_ARTICLE_DATE, publicationDate);
        context.getScenarioContext().setContext(PUBLICATION_DATE, dateFormat);
    }

    @When("User clicks on {string} Other name screening element")
    public void clickOnScreeningElement(String elementName) {
        otherNameScreeningSectionPage.clickOn(elementName);
    }

    @When("User clicks on {int} number Other name screening record")
    public void clickOnScreeningRecord(int elementIndex) {
        otherNameScreeningSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        openedResultIndex = elementIndex - 1;
        String referenceId = (String) context.getScenarioContext().getContext(RECORD_ID + elementIndex);
        if (nonNull(referenceId)) {
            otherNameScreeningSectionPage.clickOnScreeningElement(referenceId);
        } else {
            String recordName = otherNameScreeningSectionPage.getOtherNameScreeningRecordName(elementIndex);
            String recordId = otherNameScreeningSectionPage.getOtherNameScreeningRecordId(elementIndex);
            otherNameScreeningSectionPage.clickOnScreeningElement(elementIndex);
            context.getScenarioContext().setContext(RECORD_NAME + elementIndex, recordName);
            context.getScenarioContext().setContext(RECORD_ID + elementIndex, recordId);
        }
    }

    @When("User clicks on {int} number Media check other name screening record")
    public void clickOnMediaCheckScreeningRecord(int elementIndex) {
        otherNameScreeningSectionPage.clickOnScreeningElement(elementIndex);
    }

    @When("User clicks resolve Other Name screening record for {string} under number {int} as {string}")
    public void clickResolveOtherNameScreeningRecord(String screeningResultsFor, int elementIndex, String resolution) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        thirdPartyPage.closeAlertIconIfDisplayed();
        String referenceId = getReferenceId(screeningResultsFor, elementIndex, resolution);
        otherNameScreeningSectionPage
                .clickResolveScreeningElement(referenceId, Resolution.valueOf(resolution).getResolutionPosition());
    }

    @When("User selects {int} rows per page")
    public void selectRowsPerPage(int items) {
        itemsPerPage = items;
        otherNameScreeningSectionPage.selectPaginationOption(items);
    }

    @When("User clicks Other Name screening results {string} button")
    public void clickToTheOtherNameScreeningResultsNextPageButton(String pageReference) {
        otherNameScreeningSectionPage.waitWhilePreloadProgressbarIsDisappeared();
        otherNameScreeningSectionPage.clickOnOtherNamesPagination(pageReference);
        if (pageReference.contains("next")) {
            currentPage += 1;
        } else if (pageReference.contains("previous")) {
            currentPage -= 1;
        } else if (pageReference.contains("first")) {
            currentPage = 0;
        } else if (pageReference.contains("last")) {
            currentPage = getTotalPages(wcoScreeningResults.size(), itemsPerPage) - 1;
        } else {
            currentPage = parseInt(pageReference) - 1;
        }
    }

    @When("User clicks on the {string} screening profile")
    public void clickOnTheScreeningProfile(String elementName) {
        profileSectionPage.clickOn(elementName);
    }

    @When("User clicks resolve screening profile under number {int} record as {string}")
    public void clicksResolveScreeningProfile(int recordReference, String resolutionType) {
        profileSectionPage.waitWhilePreloadProgressbarIsDisappeared();
        String resolvedResultId =
                profileSectionPage.getElementText(ScreeningProfileHeaderColumns.REFERENCE_ID.getColumnName());
        context.getScenarioContext().setContext(RECORD_ID + recordReference, resolvedResultId);
        int currentResolution = profileSectionPage.getSelectedResolutionPosition();
        updateResolutionList(Resolution.valueOf(resolutionType).getResolutionPosition() == currentResolution,
                             resolutionType, resolvedResultId);
        profileSectionPage.clickResolveScreeningProfile(Resolution.valueOf(resolutionType).getResolutionPosition());
    }

    @When("User selects all Other name screening records for {string} and resolve as {string}")
    public void selectAllOtherNameScreeningRecordsAndResolveAs(String resultsFor, String resolutionType) {
        List<ResultsResponseDTO> actualScreeningResults =
                otherNameScreeningSectionPage.getOtherNameScreeningResultsData(resultsFor);
        for (ResultsResponseDTO record : actualScreeningResults) {
            updateResolutionList(Resolution.valueOf(resolutionType.toUpperCase()).getResolutionPosition() ==
                                         record.getResolutionPosition(), resolutionType, record.getReferenceId());
        }
        otherNameScreeningSectionPage.clickOn(SELECT_ALL);
        allOtherNameScreeningRecordsAreSelected();
        otherNameScreeningSectionPage.clickOn(RESOLVE_AS);
        otherNameScreeningSectionPage.clickResolveScreeningProfiles(resolutionType);
    }

    @When("User selects Other Name screening record for {string} on position {int}")
    public void selectOtherNameScreeningRecordForOnPosition(String screeningResultsFor, int elementIndex) {
        thirdPartyPage.closeAlertIconIfDisplayed();
        otherNameScreeningSectionPage.selectCheckboxForRow(elementIndex);
        context.getScenarioContext()
                .setContext(RECORD_ID + elementIndex, otherNameScreeningSectionPage.getOtherNameScreeningResultsData(
                        screeningResultsFor).get(elementIndex - 1).getReferenceId());
    }

    @When("User clicks Close Other Name Results button")
    public void clickCloseOtherNameResultsButton() {
        otherNameScreeningSectionPage.waitWhilePreloadProgressbarIsDisappeared();
        otherNameScreeningSectionPage.clickCloseScreeningResultsButton();
    }

    @When("User clicks on {string} other name screening tab")
    public void clickOtherNameWorldCheck(String tabName) {
        otherNameScreeningSectionPage.waitWhilePreloadProgressbarIsDisappeared();
        otherNameScreeningSectionPage.clickOtherNameScreeningTab(tabName);
    }

    @When("User clicks Other Names OGS slider")
    public void clickOgsOtherNames() {
        otherNameScreeningSectionPage.closeAlertIconIfDisplayed();
        otherNameScreeningSectionPage.waitWhilePreloadProgressbarIsDisappeared();
        otherNameScreeningSectionPage.clickOtherNamesOGS();
    }

    @When("^User turns (Off|On) Other Names OGS slider$")
    public void turnOgsOtherNames(String state) {
        if ((state.equals(ON) && otherNameScreeningSectionPage.isOtherNameOGSTurnedOnDisplayed()) ||
                (state.equals(OFF) && otherNameScreeningSectionPage.isOtherNameOGSTurnedOffDisplayed())) {
            clickOgsOtherNames();
        }
    }

    @When("^User selects Media Check (Third-party|Associated Party Individual|Associated Party Organisation) Other Names screening record on position (\\d+)$")
    public void selectMediaCheckOtherNamesCheckboxOnPosition(String screeningLevel, int recordReference) {
        isOtherNameScreeningTableLoaded();
        if (nonNull(context.getScenarioContext().getContext(THIRD_PARTY_MEDIA_CHECK_RECORD))) {
            while (context.getScenarioContext().getContext(THIRD_PARTY_MEDIA_CHECK_RECORD)
                    .equals(otherNameScreeningSectionPage.getOtherNameMediaCheckRecordName(recordReference)) ||
                    otherNameScreeningSectionPage.getOtherNameMediaCheckRecordName(recordReference)
                            .contains(DOLLAR_SIGN)) {
                recordReference++;
            }
        }
        otherNameScreeningSectionPage.clickSelectMediaCheckOtherNamesScreeningRecord(recordReference);
        if (screeningLevel.contains(THIRD_PARTY)) {
            context.getScenarioContext()
                    .setContext(THIRD_PARTY_OTHER_NAME_MEDIA_CHECK_RECORD,
                                otherNameScreeningSectionPage.getOtherNameMediaCheckRecordName(recordReference));
        }
        if (screeningLevel.contains(ASSOCIATED_PARTY_INDIVIDUAL)) {
            context.getScenarioContext()
                    .setContext(ASSOCIATED_PARTY_INDIVIDUAL_OTHER_NAME_MEDIA_CHECK_RECORD,
                                otherNameScreeningSectionPage.getOtherNameMediaCheckRecordName(recordReference));
        }
        if (screeningLevel.contains(ASSOCIATED_PARTY_ORGANISATION)) {
            context.getScenarioContext()
                    .setContext(ASSOCIATED_PARTY_ORGANIZATIONAL_OTHER_NAME_MEDIA_CHECK_RECORD,
                                otherNameScreeningSectionPage.getOtherNameMediaCheckRecordName(recordReference));
        }
    }

    @When("User hovers Media Check Other Names Risk Level icon on Screening record {int}")
    public void hoverMediaCheckRiskLevelRecordIcon(int recordReference) {
        isOtherNameScreeningTableLoaded();
        otherNameScreeningSectionPage.hoversOverMediaCheckOtherNamesRiskLevelRecordIcon(recordReference);
    }

    @When("User opens screening results for Associated Party {string} Other name")
    public void openScreeningResultsForOtherName(String otherName) {
        otherNameScreeningSectionPage.waitWhilePreloadProgressbarIsDisappeared();
        otherNameScreeningSectionPage.clickScreenOtherNameScreeningIcon(otherName);
    }

    @When("User fills in comment {string} on media check other names")
    public void fillsInCommentOtherNames(String comment) {
        otherNameScreeningSectionPage.fillInResolutionOtherNameComment(comment);
    }

    @When("User fills in random comment characters on media check other names")
    public void fillInRandomValueOtherNames() {
        String commentValue = (String) context.getScenarioContext().getContext(MEDIA_CHECK_COMMENT);
        otherNameScreeningSectionPage.fillInResolutionOtherNameComment(commentValue);
    }

    @When("User deletes Comment Media Resolution on media check other names")
    public void clearCommentMediaResolutionOtherNames() {
        otherNameScreeningSectionPage.clearCommentMediaResolutionOtherNamesValue();
    }

    @When("^User gets Media check Other Name \"((.*))\" for \"(current|first|last|next|previous)\" page references value from API$")
    public void getMediaCheckOtherNamePageReference(String otherNames, String expectedReference) {
        otherNameScreeningSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        PublicationDateResponse publicationDate = otherNameScreeningSectionPage.getPublicationDate();
        String minDate = publicationDate.getMin();
        String maxDate = publicationDate.getMax();
        MediaCheckResponse results =
                otherNameScreeningSectionPage.getMediaCheckOtherNameResponseWithPublicationDate(PAGINATION,
                                                                                                minDate, maxDate,
                                                                                                otherNames);
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

    @Then("{string} for other name screening is displayed with text")
    public void forOtherNameScreeningIsDisplayed(String elementName, DataTable dataTable) {
        otherNameScreeningSectionPage.waitWhilePreloadProgressbarIsDisappeared();
        assertTrue(elementName + " is not displayed", otherNameScreeningSectionPage.isElementDisplayed(elementName));
        String expectedText =
                dataTable.asList().get(0)
                        .replace("thirdPartyInformation.screening.lastScreeningDate",
                                 translator.getValue("thirdPartyInformation.screening.lastScreeningDate").toUpperCase())
                        .replace(SI_MAIN_SCREENING_DATE_FORMAT, getTodayDate(SI_MAIN_SCREENING_DATE_FORMAT));
        assertThat(otherNameScreeningSectionPage.getElementText(elementName))
                .as("Screening pop-up displays unexpected text").contains(expectedText);
    }

    @Then("{string} for other name screening is displayed")
    public void forOtherNameScreeningIsDisplayed(String elementName) {
        assertTrue(elementName + " is not displayed", otherNameScreeningSectionPage.isElementDisplayed(elementName));
    }

    @Then("{string} for other name screening is not displayed")
    public void forOtherNameScreeningIsNotDisplayed(String elementName) {
        assertFalse(elementName + " for other name is displayed",
                    otherNameScreeningSectionPage.isElementDisplayed(elementName));
    }

    @Then("Other Name Screening Pagination Drop-Down list is displayed with values")
    public void otherNameScreeningPaginationDropDownListIsDisplayedWithValues(List<String> expectedPaginationValues) {
        List<String> actualPaginationValues = otherNameScreeningSectionPage.getPaginationDropDownValues();
        assertEquals("Pagination drop-down list doesn't contain expected values", expectedPaginationValues,
                     actualPaginationValues);
    }

    @Then("Screening Table displays {string} pagination selection")
    public void screeningTableDisplaysPaginationSelection(String expectedPagination) {
        assertTrue("Screening Table for other Name doesn't displays expected pagination text",
                   otherNameScreeningSectionPage.getOtherNameScreeningResults().size() <= itemsPerPage);
        assertEquals("Selected pagination value doesn't expected", expectedPagination,
                     otherNameScreeningSectionPage.getPaginationSelection());
    }

    @Then("Screening Table for Other name displays up to {int} items per page")
    public void screeningTableForOtherNameDisplaysUpToResults(int itemsPerPage) {
        assertTrue("Screening Table for other Name displays unexpected results count",
                   otherNameScreeningSectionPage.getOtherNameScreeningResults().size() <= itemsPerPage);
    }

    @Then("Checkbox is displayed in front of table header and each row")
    public void checkboxIsDisplayedInFrontOfTableHeaderAndEachRow() {
        otherNameScreeningSectionPage.waitWhilePreloadProgressbarIsDisappeared();
        assertTrue("Checkbox is not displayed in front of header",
                   otherNameScreeningSectionPage.isHeaderCheckboxDisplayed());
        int resultsCount = otherNameScreeningSectionPage.getOtherNameScreeningResults().size();
        for (int i = 1; i <= resultsCount; i++) {
            assertTrue("Checkbox is not displayed in front of each row",
                       otherNameScreeningSectionPage.isCheckboxDisplayedForRow(i));
        }
    }

    @Then("All Other name screening records on current page are selected")
    public void allOtherNameScreeningRecordsAreSelected() {
        otherNameScreeningSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertTrue("Checkbox is not selected in front of header",
                   otherNameScreeningSectionPage.isHeaderCheckboxSelected());
        int resultsCount = otherNameScreeningSectionPage.getOtherNameScreeningResults().size();
        for (int i = 1; i <= resultsCount; i++) {
            assertTrue("Checkbox is not selected in front of each row",
                       otherNameScreeningSectionPage.isCheckboxSelectedForRow(i));
        }
    }

    @Then("All Other name screening records on current page are not selected")
    public void allOtherNameScreeningRecordsOnCurrentPageAreNotSelected() {
        otherNameScreeningSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertFalse("Checkbox is selected in front of header",
                    otherNameScreeningSectionPage.isHeaderCheckboxSelected());
        int resultsCount = otherNameScreeningSectionPage.getOtherNameScreeningResults().size();
        for (int i = 1; i <= resultsCount; i++) {
            assertFalse("Checkbox is selected in front of each row",
                        otherNameScreeningSectionPage.isCheckboxSelectedForRow(i));
        }
    }

    @Then("Other Name dialog is loaded")
    public void isOtherNameScreeningTableLoaded() {
        otherNameScreeningSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        otherNameScreeningSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertTrue("Other Name Screening table is not loaded", otherNameScreeningSectionPage.isOtherNameDialogLoaded());
    }

    @Then("Sorted search {string} results for {string} {string} appear in other names screening table for current page")
    public void searchResultsForOtherNameAreDisplayed(String provider, String otherName, String pageType) {
        otherNameScreeningSectionPage.waitWhilePreloadProgressbarIsDisappeared();
        isOtherNameScreeningTableLoaded();
        wcoScreeningResults =
                getScreeningResultsForOtherNameWithoutResolved(context, otherName, pageType, getProvider(provider));
        List<ResultsResponseDTO> expected =
                getScreeningData(getResultsForCurrentPage(wcoScreeningResults, currentPage, itemsPerPage),
                                 pageType);
        List<ResultsResponseDTO> actual = otherNameScreeningSectionPage.getOtherNameScreeningResultsData(pageType);
        assertThat(actual).usingRecursiveComparison().ignoringFields("displayName")
                .as("Screening table doesn't contains expected results")
                .isEqualTo(expected);
    }

    @Then("Other name screening result profile details is displayed")
    public void screeningResultProfileDetailsIsDisplayed() {
        profileSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertTrue("Back to Screening Results button is not displayed",
                   profileSectionPage.isBackToScreeningResultsButtonDisplayed());
        profile = getProfileResponse(wcoScreeningResults.get(openedResultIndex).getReferenceId());
    }

    @Then("Other name screening result contains 'Refinitiv World-Check' logo")
    public void screeningResultProfileLogoIsDisplayed() {
        assertThat(profileSectionPage.isWorldCheckLogoPresent())
                .as("World-check logo is not correct or is not present")
                .isTrue();
    }

    @Then("Screening {string} profile header contains correspond data")
    public void screeningProfilesHeaderContainsCorrespondData(String profileType) {
        UserData userTestData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        ResultsResponseDTO expected = wcoScreeningResults.get(openedResultIndex);
        profileSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertEquals(profileSectionPage.getElementText(ScreeningProfileHeaderColumns.NAME.getColumnName()),
                                expected.getPrimaryName(), "Header Name value doesn't contain expected WC1 value");
        if (nonNull(profile.getIsDeceased()) && profile.getIsDeceased()) {
            softAssert.assertTrue(profileSectionPage.getElementText(ScreeningProfileHeaderColumns.NAME.getColumnName())
                                          .contains(DECEASED), "Header Name value doesn't contain DECEASED label");
        }
        if (profileType.contains(SUPPLIER.toString().toLowerCase())) {
            String countries = join(ROW_DELIMITER, getCountriesListByType(expected.getCountryLinks(), REGISTEREDIN));
            softAssert.assertEquals(countries.isEmpty() ? DASH : countries, profileSectionPage.getElementText(
                                            ScreeningProfileHeaderColumns.COUNTRY_OF_REGISTRATION.getColumnName()),
                                    "Header Country of Registration value doesn't contain expected WC1 value");
        } else {
            String countries = join(ROW_DELIMITER, getCountriesListByType(expected.getCountryLinks(), LOCATION));
            softAssert.assertEquals(countries.isEmpty() ? DASH : countries, profileSectionPage
                                            .getElementText(ScreeningProfileHeaderColumns.COUNTRY_OF_LOCATION.getColumnName()),
                                    "Header Country of Location value doesn't contain expected WC1 value");
        }
        softAssert.assertEquals(profileSectionPage.getElementText(
                                        ScreeningProfileHeaderColumns.MATCH_STRENGTH.getColumnName()),
                                expected.getMatchStrength(),
                                "Header Match Strength value doesn't contain expected WC1 value");
        softAssert.assertEquals(profileSectionPage.getElementText(
                                        ScreeningProfileHeaderColumns.REFERENCE_ID.getColumnName()),
                                expected.getReferenceId().replaceAll(ID_REGEX, StringUtils.EMPTY),
                                "Header Reference ID value doesn't contain expected WC1 value");
        softAssert.assertEquals(profileSectionPage.getElementText(
                                                ScreeningProfileHeaderColumns.DATA_PROVIDER.getColumnName())
                                        .toUpperCase(),
                                expected.getProviderType().getProvider().toUpperCase(),
                                "Header Data Provider value doesn't contain expected WC1 value");
        softAssert.assertEquals(
                profileSectionPage.getElementText(ScreeningProfileHeaderColumns.LAST_SCREENING_DATE.getColumnName()),
                getTodayDate(SI_PROFILE_DATE_FORMAT),
                "Header Last Screening Date value doesn't contain expected value");
        softAssert.assertEquals(
                profileSectionPage.getElementText(ScreeningProfileHeaderColumns.CREATED_BY.getColumnName()),
                getUserDataByEmail(userTestData.getUsername(), NAME_FILTER),
                "Header Created By value doesn't contain expected value");
        softAssert.assertEquals(
                profileSectionPage.getElementText(ScreeningProfileHeaderColumns.LAST_UPDATED_BY.getColumnName()),
                wcoScreeningResults.get(openedResultIndex).getResolution() == null ? SYSTEM_NOTICE :
                        getUserDataByEmail(userTestData.getUsername(), NAME_FILTER),
                "Header Last Updated By value doesn't contain expected value");
        softAssert.assertTrue(profileSectionPage.isElementDisplayed(EXPORT_TO_PDF),
                              "Header Export To PDF button is not displayed");
        softAssert.assertAll();
    }

    @Then("Screening profiles Resolution Type contains correspond data")
    public void screeningProfilesResolutionTypeContainsCorrespondData() {
        ResultsResponseDTO expected = wcoScreeningResults.get(openedResultIndex);
        assertThat(profileSectionPage.getSelectedResolutionPosition()).as("Screening Profile Resolution is unexpected")
                .isEqualTo(Resolution.valueOf(getResolutionStatus(expected.getResolution(), expected.getProviderType()))
                                   .getResolutionPosition());
    }

    @Then("Screening profiles Resolution Type is {string}")
    public void screeningProfilesResolutionTypeIs(String resolutionType) {
        assertThat(profileSectionPage.getSelectedResolutionPosition())
                .as("Screening Profile Resolution type is not %s", resolutionType)
                .isEqualTo(Resolution.valueOf(resolutionType).getResolutionPosition());
    }

    @Then("{string} profile details is displayed")
    public void profileDetailsIsDisplayed(String elementName) {
        String expectedLegalNoticeText =
                "The contents of this record are private and confidential and should not be disclosed to third parties unless: ( i ) the " +
                        "terms of your agreement with Refinitiv allow you to do so; (ii) the record subject requests any data that you may hold " +
                        "on them, and such data includes their World-Check record; or (iii) you are under some other legal obligation to do so. " +
                        "You must consider and abide by your own obligations in relation to the data privacy rights of individuals and must " +
                        "notify them of your intention to search against World-Check and provide them with information contained in the " +
                        "World-Check privacy statement: https://www.refinitiv.com/en/products/world-check-kyc-screening/privacy-statement. " +
                        "You shall not rely upon the content of this report without making independent checks to verify the information " +
                        "contained therein. Information correlated is necessarily brief and should be read by you in the context of the fuller " +
                        "details available in the external sources to which links are provided. The accuracy of the information found in the " +
                        "underlying sources must be verified with the record subject before any action is taken and you should inform us if " +
                        "any links to the sources are broken. If this record contains negative allegations, it should be assumed that such " +
                        "allegations are denied by the subject. You should not draw any negative inferences about individuals or entities " +
                        "merely because they are identified in the database, nor because they are shown as \"Reported being linked to\" others " +
                        "identified in the database. The nature of linking varies considerably. Many persons are included solely because they " +
                        "hold or have held prominent political positions or are connected to such individuals.";
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(profileSectionPage.isElementDisplayed(elementName),
                              "Legal Notice profile details is not displayed");
        softAssert.assertEquals(profileSectionPage.getLegalNoticeText(), expectedLegalNoticeText,
                                "Legal Notice text is unexpected");
        softAssert.assertAll();
    }

    @Then("Screening result {string} profile Key Data tab displays correspond data")
    public void screeningResultProfileKeyDataTabDisplayCorrespondData(String entityType) {
        profileSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        SoftAssert softAssert = new SoftAssert();
        getProfileResponse(wcoScreeningResults.get(openedResultIndex).getReferenceId());
        softAssert.assertTrue(profileSectionPage.isTabEnabled(KEYWORDS.getTabName()), "Key Data tab is disabled");
        profileSectionPage.clickOnTab(KEY_DATA.getTabName());
        softAssert.assertEquals(profileSectionPage.getTextFieldText(CATEGORY.getName()),
                                getStringValue(profile.getCategory()),
                                "Category key data is not expected");
        softAssert.assertEquals(profileSectionPage.getTextFieldText(SUB_CATEGORY.getName()),
                                getStringValue(profile.getSubCategory()),
                                "Sub Category key data is not expected");
        softAssert.assertEquals(profileSectionPage.getTableColumns(RECORD_UPDATE.getName()),
                                getRecordUpdateColumnNames(),
                                "Record Update table columns are not expected");
//        TODO uncomment when RMS-16039 will be fixed
//        softAssert.assertEquals(profileSectionPage.getRecordUpdateDates(), getRecordUpdateDates(profile),
//                                "Record Update key data is not expected");
        List<List<String>> locationDetails = getLocationDetails(profile);
        if (locationDetails.isEmpty()) {
            softAssert.assertTrue(profileSectionPage.getTableColumns(LOCATION_DETAILS.getName()).isEmpty(),
                                  "Location Details table columns are not empty");
        } else {
            softAssert.assertEquals(profileSectionPage.getTableColumns(LOCATION_DETAILS.getName()),
                                    getLocationDetailsColumnNames(),
                                    "Location Details table columns are not expected");
            softAssert.assertEquals(profileSectionPage.getTableValues(LOCATION_DETAILS.getName()), locationDetails,
                                    "Location Details key data is not expected");
        }
        if (!profile.getIdentityDocuments().isEmpty()) {
            softAssert.assertEquals(profileSectionPage.getTableColumns(IDENTIFICATION_NUMBER.getName()),
                                    getIdentificationNumberColumnNames().stream().map(String::toUpperCase).collect(
                                            Collectors.toList()),
                                    "Identification Number(s) table columns are not expected");
            softAssert.assertEquals(profileSectionPage.getTableValues(IDENTIFICATION_NUMBER.getName()),
                                    getIdentificationNumber(profile),
                                    "Identification Number(s) key data is not expected");
        } else {
            softAssert.assertTrue(profileSectionPage.isEmptyTableDisplayed(IDENTIFICATION_NUMBER.getName()),
                                  "Identification Number(s) empty table is not display");
        }
        if (entityType.contains(SUPPLIER.toString().toLowerCase())) {
            softAssert.assertEquals(profileSectionPage.getTextFieldText(ORGANISATION_NAME.getName()),
                                    getPrimaryName(profile),
                                    "Organisation Name key data is not expected");
            softAssert.assertEquals(profileSectionPage.getTextFieldText(REGISTERED_COUNTRY.getName()),
                                    getCountryByType(profile, REGISTEREDIN),
                                    "Registered Country key data is not expected");
        } else {
            softAssert.assertEquals(profileSectionPage.getTextFieldText(KeyData.NAME.getName().toUpperCase()),
                                    getPrimaryName(profile),
                                    "Name key data is not expected");
            softAssert.assertEquals(profileSectionPage.getTextFieldText(TITLE.getName()), getTitle(profile),
                                    "Title key data is not expected");
            softAssert.assertEquals(profileSectionPage.getTextFieldText(POSITION.getName()), getPosition(profile),
                                    "Position key data is not expected");
            softAssert.assertEquals(profileSectionPage.getTextFieldText(KeyData.CITIZENSHIP.getName()),
                                    getCountryByType(profile, CountryType.NATIONALITY),
                                    "Nationality key data is not expected");
            softAssert.assertEquals(profileSectionPage.getTextFieldText(AGE.getName()), getAge(profile),
                                    "Age key data is not expected");
            softAssert.assertEquals(profileSectionPage.getTextFieldText(AGE_AS_OF_DATE.getName()),
                                    getAgeAsOfDate(profile),
                                    "Age as of date key data is not expected");
            softAssert.assertEquals(profileSectionPage.getTextFieldText(GENDER.getName()),
                                    getStringValue(profile.getGender()),
                                    "Gender key data is not expected");
            getDateByType(profile, BIRTH.toString()).forEach(
                    date -> softAssert.assertTrue(
                            profileSectionPage.getTextFieldText(DATE_OF_BIRTH.getName()).contains(date),
                            "Date of birth key data is not expected"));
            if (!getDateByType(profile, DEATH.toString()).isEmpty()) {
                softAssert.assertEquals(profileSectionPage.getTextFieldText(DECEASED_DATE.getName()),
                                        getDateByType(profile, DEATH.toString()).get(0),
                                        "Deceased date key data is not expected");
            }
            getPlaceOfBirth(profile).forEach(place -> softAssert.assertTrue(
                    profileSectionPage.getTextFieldText(KeyData.PLACE_OF_BIRTH.getName()).contains(place),
                    "Place of birth key data is not expected"));
        }
        softAssert.assertAll();
    }

    @Then("^Screening result (?:\"supplier\"|\"contact\"?) profile Aliases tab displays correspond data$")
    public void screeningResultProfileAliasesTabDisplayCorrespondData() {
        List<String> aliasesList = getAliasesList(profile, AKA);
        List<String> langList = getAliasesList(profile, LANG_VARIATION);
        List<String> lowQuality = getAliasesList(profile, LOW_QUALITY_AKA);
        List<String> nativeList = getAliasesList(profile, NATIVE_AKA);
        if (aliasesList.isEmpty() && langList.isEmpty() && lowQuality.isEmpty() && nativeList.isEmpty()) {
            assertFalse("Aliases tab is not disabled", profileSectionPage.isTabEnabled(ALIASES.getTabName()));
        } else {
            profileSectionPage.clickOnTab(ALIASES.getTabName());

            assertEquals("Aliases data is not expected", aliasesList, profileSectionPage.getAliasValues(AKA.getName()));
            assertEquals("Alternate spelling are not expected", langList,
                         profileSectionPage.getAliasValues(LANG_VARIATION.getName()));
            assertEquals("Low quality alias(es) are not expected", lowQuality,
                         profileSectionPage.getAliasValues(LOW_QUALITY_AKA.getName()));
            assertEquals("Native character name(s) are not expected", nativeList,
                         profileSectionPage.getAliasValues(NATIVE_AKA.getName()));
        }
    }

    @Then("Screening result {string} profile Further Information tab displays correspond data")
    public void screeningResultProfileFurtherInformationTabDisplaysCorrespondData(String entityType) {
        profileSectionPage.clickOnTab(FURTHER_INFORMATION.getTabName());
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertEquals(profileSectionPage.getDetailsValues(), getDetailsList(profile),
                                "Further information is not expected");
        if (entityType.contains(SUPPLIER.toString().toLowerCase())) {
            softAssert.assertEquals(profileSectionPage.getFurtherInformation(OWNERS.getName()), DASH,
                                    "Further Owners information is not expected");
            softAssert.assertEquals(profileSectionPage.getFurtherInformation(RELEVANT_ASSOCIATES.getName()), DASH,
                                    "Further Relevant associates information is not expected"
            );
        } else {
            softAssert.assertEquals(profileSectionPage.getFurtherInformation(RELATIVES.getName()), DASH,
                                    "Further Relatives information is not expected");
            softAssert.assertEquals(profileSectionPage.getCommentsFurtherInformation(),
                                    getStringValue(profile.getComments()),
                                    "Further Additional comments information is not expected"
            );
        }
    }

    @Then("^Screening result (?:\"supplier\"|\"contact\"?) profile Keywords tab displays correspond data$")
    public void screeningResultProfileKeywordsTabDisplaysCorrespondData() {
        List<List<String>> keywords = getKeywords(profile);
        if (keywords.isEmpty()) {
            assertFalse("Keywords tab is not disabled", profileSectionPage.isTabEnabled(KEYWORDS.getTabName()));
        } else {
            profileSectionPage.clickOnTab(KEYWORDS.getTabName());
            assertEquals("Keywords table columns are not expected", getKeywordColumnNames(),
                         profileSectionPage.getKeywordsTableColumns());
            assertEquals("Keywords are not expected", keywords, profileSectionPage.getKeywordsList());
        }
    }

    @Then("^Screening result (?:\"supplier\"|\"contact\"?) profile Connections and Relationships tab displays correspond data$")
    public void screeningResultProfileConnectionsRelationshipsTabDisplaysCorrespondData() {
        List<List<Object>> connections = getConnections(profile);
        if (connections.isEmpty()) {
            assertFalse("Connections/Relationships tab is not disabled",
                        profileSectionPage.isTabEnabled(CONNECTIONS.getTabName()));
        } else {
            profileSectionPage.clickOnTab(CONNECTIONS.getTabName());
            assertEquals("Connections/Relationships table columns are not expected", getConnectionColumnNames(),
                         profileSectionPage.getConnectionsTableColumns());
            assertEquals("Connections/Relationships are not expected", connections,
                         profileSectionPage.getConnectionsList());
        }
    }

    @Then("^Screening result (?:\"supplier\"|\"contact\"?) profile Sources tab displays correspond data$")
    public void screeningResultProfileSourcesTabDisplaysCorrespondData() {
        List<String> webLinksList = getWebLinksList(profile);
        if (webLinksList.isEmpty()) {
            assertFalse("Sources tab is not disabled", profileSectionPage.isTabEnabled(SOURCES.getTabName()));
        } else {
            profileSectionPage.clickOnTab(SOURCES.getTabName());
            assertEquals("Sources is not expected", webLinksList, profileSectionPage.getExternalSourcesList());
        }
    }

    @Then("Other name screening record under number {int} appears in the other name screening table with {string} resolution")
    public void screeningRecordAppearsWithExpectedResolution(int recordReference, String resolutionType) {
        otherNameScreeningSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        isOtherNameScreeningTableLoaded();
        String referenceId = (String) context.getScenarioContext().getContext(RECORD_ID + recordReference);
        assertTrue("Screening record with ID: " + referenceId + " doesn't appear in the other name screening table",
                   otherNameScreeningSectionPage.isScreeningRecordWithIdDisplayed(referenceId));
        assertEquals(
                "Screening resolution for record with ID: " + referenceId + " status index doesn't equals expected",
                Resolution.valueOf(resolutionType).getResolutionPosition(),
                otherNameScreeningSectionPage.getSelectedResolutionIndexById(referenceId));
    }

    @Then("Other name screening record under number {int} does not appear in the other name screening table")
    public void otherNameScreeningRecordUnderNumberDoesNotAppearInTheOtherNameScreeningTable(int resultReference) {
        isOtherNameScreeningTableLoaded();
        otherNameScreeningSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        String referenceId = (String) context.getScenarioContext().getContext(RECORD_ID + resultReference);
        assertFalse("Screening record with ID: " + referenceId + " still appears in the other name screening table",
                    otherNameScreeningSectionPage.isScreeningRecordWithIdDisplayed(referenceId));
    }

    @Then("Other Name OGS Toggle Label should display as {string}")
    public void verifyOtherNameToggleLabel(String otherNameOGSLabel) {
        assertThat(otherNameScreeningSectionPage.getOtherNameOGSToggleLabel())
                .as("Other Name OGS Toggle Label is unexpected").isEqualTo(otherNameOGSLabel);
    }

    @Then("MEDIA CHECK page is hidden OGS Toggle for Other Name section")
    public void ogsLabelShouldBeInvisible() {
        assertThat(otherNameScreeningSectionPage.isOGSToggleLabelInvisible())
                .as("OGS Toggle label is displayed").isTrue();
    }

    @Then("{string} other name tab is selected")
    public void otherNameTabIsSelected(String tabName) {
        otherNameScreeningSectionPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(otherNameScreeningSectionPage.isOtherNameTabSelected(tabName))
                .as("%s other name tab is not selected", tabName).isTrue();
    }

    @Then("^World-Check & Custom WatchList Ongoing Screening toggle is turned (On|Off)$")
    public void worldCheckCustomWatchListOngoingScreeningToggleIsTurnedOn(String ogsState) {
        otherNameScreeningSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (ogsState.equals(ON)) {
            assertThat(otherNameScreeningSectionPage.isOtherNameOGSTurnedOnDisplayed())
                    .as("World-Check & Custom WatchList Ongoing Screening toggle is not turned On").isTrue();
        } else {
            assertThat(otherNameScreeningSectionPage.isOtherNameOGSTurnedOffDisplayed())
                    .as("World-Check & Custom WatchList Ongoing Screening toggle is not turned Off").isTrue();
        }
    }

    @Then("Other Name Screening Pagination is disabled")
    public void otherNameScreeningPaginationIsDisabled() {
        assertThat(otherNameScreeningSectionPage.isPaginationDisabled())
                .as("Other Name Screening Pagination is enabled").isTrue();
    }

    @Then("Other Names OGS Toggle label is hidden")
    public void otherNamesOGSToggleLabelIsHidden() {
        assertTrue("Other Names OGS Toggle label is not hidden",
                   otherNameScreeningSectionPage.checkOtherNamesOGSToggleShouldBeInvisible());
    }

    @Then("Other Names OGS Toggle is hidden")
    public void otherNamesOGSToggleIsHidden() {
        assertTrue("Other Names OGS Toggle is not hidden",
                   otherNameScreeningSectionPage.isOtherNamesOGSToggleHidden());
    }

    @Then("^Other Name \"((.*))\" tab is (invisible|visible)$")
    public void theTabIsVisible(String tabName, String expectedResult) {
        if (TestConstants.VISIBLE.equals(expectedResult)) {
            assertTrue("Tab is invisible", otherNameScreeningSectionPage.isTabVisible(tabName));
        } else {
            assertTrue("Tab is visible", otherNameScreeningSectionPage.isTabInvisible(tabName));
        }
    }

    @When("User selects {string} option from Rows Per Page dropdown list on Other Names")
    public void selectOtherNamesRowsPerPageDropdown(String rowsPerPage) {
        otherNameScreeningSectionPage.clickOtherNamesRowsPerPageDropDown();
        otherNameScreeningSectionPage.clickOtherNamesItemsRowsPerPageOption(rowsPerPage);
    }

    @Then("Media Check Other Names Result Table should contain {int} records")
    public void getMediaCheckRecordsFromResultTable(int expectedNumRecords) {
        assertEquals(
                "Media Check Other Names Number of records display in result table does not match with the expected value",
                expectedNumRecords, otherNameScreeningSectionPage.getOtherNamesTotalRecordsFromMediaCheckResultTable());
    }

    @Then("Media Check Other Names Rows per page dropdown value should be {string}")
    public void getMediaCheckRowsPerPageValue(String expectedValue) {
        assertEquals("Media Check Other Names Rows per page value does not match with the expected value",
                     expectedValue,
                     otherNameScreeningSectionPage.getOtherNamesMediaCheckRowsPerPageValue());
    }

    @Then("Media Check Other Names Rows per page Drop-Down list is displayed with values")
    public void otherNamesRowsPerPageDropDownListIsDisplayedWithValues(DataTable dataTable) {
        List<String> expectedOptions = dataTable.asList();
        otherNameScreeningSectionPage.clickOtherNamesRowsPerPageDropDown();
        assertEquals("Media Check Other Names Rows per page Drop-Down list is not displayed with expected values",
                     expectedOptions,
                     otherNameScreeningSectionPage.getOtherNamesRowsPerPageDropDownOptions());
    }

    @Then("Media check Other Names screening record on position {int} is checked")
    public void mediaCheckCheckOtherNamesCheckBoxOnPositionIsChecked(int recordReference) {
        assertTrue(String.format("Media check Other Names screening record on position %s is not checked",
                                 recordReference),
                   otherNameScreeningSectionPage.isMediaCheckOtherNamesScreeningRecordChecked(recordReference));
    }

    @Then("^Media Check Other Names Result (\\d+) Records (is|is not) checked$")
    public void isMediaCheckOtherNamesRecordsFromResultTable(int recordsNumber, String recordStatus) {
        isOtherNameScreeningTableLoaded();
        SoftAssert softAssert = new SoftAssert();
        for (int i = 1; i < recordsNumber + 1; i++) {
            if (recordStatus.equals(IS)) {
                softAssert.assertTrue(otherNameScreeningSectionPage.isMediaCheckOtherNamesScreeningRecordChecked(i),
                                      "Media Check Other Names Result Records is not checked");
            } else {
                softAssert.assertFalse(
                        otherNameScreeningSectionPage.isMediaCheckOtherNamesScreeningRecordChecked(i),
                        "Media Check Other Names Result Records is checked");
            }
        }
        softAssert.assertAll();
    }

    @Then("Resolution type contains following tooltip text when hover on it")
    public void resolutionTypeContainsTooltipTexts(List<String> expectedTooltips) {
        assertThat(otherNameScreeningSectionPage.getResolutionTypeTooltipTexts())
                .as("Resolution type tooltip texts are incorrect")
                .isEqualTo(expectedTooltips);
    }

    @Then("Other Names Screening results tabs are present")
    public void otherNamesScreeningResultsTabsArePresent(DataTable tabNames) {
        tabNames.asList().forEach(tabName -> assertThat(profileSectionPage.isTabPresent(tabName))
                .as("%s tab is not present", tabName)
                .isTrue());
    }

    @Then("Other Names Screening profile details are present in PDF file {string}")
    public void otherNamesScreeningProfileDetailsArePresentInPDFFile(String fileName) {
        String errorMessage = "Downloaded pdf file does not contain expected %s ";
        if (fileName.equals(DOWNLOADED_FILE_NAME)) {
            fileName = (String) context.getScenarioContext().getContext(DOWNLOADED_FILE_NAME);
        }

        String actualPdfDetails = readDownloadedPdfFile(fileName)
                .replace(CARRIAGE_RETURN, EMPTY)
                .replace(COLON_ROW_DELIMITER, SPACE)
                .replace(ROW_DELIMITER, SPACE)
                .replace(UNRESOLVED.name(), UNSPECIFIED.name());
        List<String> expectedHeaders = profileSectionPage.getHeaderDetailsList();
        List<Resolution> resolutions = Arrays.stream(Resolution.values())
                .filter(resolution -> resolution.getResolutionPosition() ==
                        profileSectionPage.getSelectedResolutionPosition())
                .collect(Collectors.toList());
        String resolutionType = "Resolution Type " + Iterables.getLast(resolutions).name();
        String tagAsRedFlag = "Tag as red flag " + (profileSectionPage.isTagAsRedFlagSwitched() ? YES : NO);

        profileSectionPage.clickOnTab(KEY_DATA.getTabName());
        List<String> keyData = profileSectionPage.getScreeningProfileTabDataList();
        keyData = keyData.stream()
                .map(record -> StringUtils.replace(record, "UPDATE CATEGORIZATION", "UPDATED CATEGORIZATION"))
                .collect(Collectors.toList());
        profileSectionPage.clickOnTab(ALIASES.getTabName());
        List<String> aliases = profileSectionPage.getScreeningProfileTabDataList();
        profileSectionPage.clickOnTab(FURTHER_INFORMATION.getTabName());
        List<String> furtherInformation = profileSectionPage.getScreeningProfileTabDataList();
        profileSectionPage.clickOnTab(KEYWORDS.getTabName());
        List<String> keywords = profileSectionPage.getKeywordsTabDataList();
        SoftAssertions softAssert = new SoftAssertions();
        if (profileSectionPage.isTabEnabled(CONNECTIONS.getTabName())) {
            profileSectionPage.clickOnTab(CONNECTIONS.getTabName());
            List<String> connections = profileSectionPage.getConnectionsTabDataList();
            connections.forEach(connection -> softAssert.assertThat(actualPdfDetails)
                    .as(errorMessage, connection).contains(connection));
        }
        if (profileSectionPage.isTabEnabled(SOURCES.getTabName())) {
            profileSectionPage.clickOnTab(SOURCES.getTabName());
            List<String> sources = profileSectionPage.getSourcesTabDataList();
            sources.forEach(source ->
                                    softAssert.assertThat(actualPdfDetails).as(errorMessage, source).contains(source));
        }
        expectedHeaders.forEach(header -> softAssert.assertThat(actualPdfDetails)
                .as(errorMessage, header).contains(header));
        softAssert.assertThat(actualPdfDetails).as(errorMessage, "Resolution Type").contains(resolutionType);
        softAssert.assertThat(actualPdfDetails).as(errorMessage, "Tag as red flag").contains(tagAsRedFlag);
        keyData.forEach(data ->
                                softAssert.assertThat(actualPdfDetails).as(errorMessage, data).contains(data));
        aliases.forEach(alias ->
                                softAssert.assertThat(actualPdfDetails).as(errorMessage, alias).contains(alias));
        furtherInformation.forEach(info -> softAssert.assertThat(actualPdfDetails)
                .as(errorMessage, info).contains(info));
        keywords.forEach(keyword ->
                                 softAssert.assertThat(actualPdfDetails).as(errorMessage, keyword).contains(keyword));
        softAssert.assertAll();
    }

    @Then("^(Third-party|Contacts) media check Other Names screening record on position (\\d+) displays (High|Medium|Low|No Risk|Unknown) icon$")
    public void isMediaCheckOtherNamesDisplayedIcon(String screeningLevel, int recordReference, String riskLevelName) {
        isOtherNameScreeningTableLoaded();
        SoftAssert soft = new SoftAssert();
        soft.assertEquals(otherNameScreeningSectionPage.getMediaCheckOtherNamesRecordRiskLevelIconName(recordReference),
                          riskLevelName,
                          screeningLevel + " media check other names screening record displays as " + riskLevelName);
        soft.assertTrue(
                otherNameScreeningSectionPage.isMediaCheckOtherNamesRecordRiskLevelIconDisplayed(recordReference,
                                                                                                 riskLevelName),
                "media check other names screening record displays incorrect color");
        soft.assertAll();
    }

    @Then("Other Name screening table displays expected columns")
    public void otherNameScreeningTableDisplaysExpectedColumns(List<String> expectedColumns) {
        List<String> columns =
                expectedColumns.stream().map(translator::getValue).map(String::toUpperCase).collect(toList());
        assertEquals("Other Name screening section table doesn't display expected columns",
                     columns, otherNameScreeningSectionPage.getScreeningTableColumnNames());
    }

    @Then("Label for {string} results {string} {string} Other Name is expected")
    public void labelForResultsOtherNameIsExpected(String provider, String otherName, String pageType) {
        isOtherNameScreeningTableLoaded();
        assertThat(otherNameScreeningSectionPage.getPaginationLabel())
                .as("Pagination label is unexpected")
                .isEqualTo(RETURNED_RESULTS.toLowerCase() +
                                   getScreeningResultsForOtherNameWithoutResolved(context, otherName, pageType,
                                                                                  getProvider(provider)).size());
    }

    @Then("Results page number for {string} results {string} {string} Other Name is expected")
    public void resultsPageNumberForResultsOtherNameIsExpected(String provider, String otherName, String pageType) {
        isOtherNameScreeningTableLoaded();
        assertThat(otherNameScreeningSectionPage.getTotalPages())
                .as("Total pages are unexpected")
                .isEqualTo(getTotalPages(
                        getScreeningResultsForOtherNameWithoutResolved(context, otherName, pageType,
                                                                       getProvider(provider)).size(),
                        10));
    }

    @Then("Ongoing Screening toggle contains {string} tooltip text when hover on it")
    public void ongoingScreeningToggleContainsTooltipTextWhenHoverOnIt(String expectedTooltip) {
        assertThat(otherNameScreeningSectionPage.getOGSTooltipTexts())
                .as("OGS tooltip texts are incorrect")
                .isEqualTo(expectedTooltip);
    }

    @Then("Other Name Screening comment length message {string} is displayed")
    public void otherNameScreeningSectionPageCommentLengthMessageIsDisplayed(String expectedMessage) {
        assertThat(this.otherNameScreeningSectionPage.getEditCommentLengthMessage())
                .as("Screening page comment length message is unexpected")
                .isEqualTo(expectedMessage);
    }

    @Then("Media check Other Name {string} showing articles must be as same as API value")
    public void isMediaCheckOtherNameArticleNumberMatchedWithApi(String otherNames) {
        int paginationNumber = 10;
        MediaCheckResponse results =
                otherNameScreeningSectionPage.getMediaCheckOtherNameResponse(paginationNumber, otherNames);
        String mediaCheckTotalArticle = results.getTotalResultCount();
        String actualMediaCheckArticleNumber = otherNameScreeningSectionPage.getMediaCheckOtherNameArticleNumber();
        assertEquals("Article Total number displayed unexpected value",
                     actualMediaCheckArticleNumber, mediaCheckTotalArticle);
    }

    @Then("User should see {string} in Media Check Other Name Screening Result Table")
    public void isScreeningDateOtherNameDisplayCorrectly(String searchTerm) {
        otherNameScreeningSectionPage.waitWhilePreloadProgressbarIsDisappeared();
        assertEquals("Other Name Search term is displayed incorrectly", searchTerm,
                     otherNameScreeningSectionPage.getMediaCheckSearchTermInScreeningOtherNamesResultTable());
    }

    @Then("Other Name Screening section displays Last Screening Date message with date in format: {string}")
    public void screeningSectionOtherNameDisplaysLastScreeningDateInFormat(String date) {
        otherNameScreeningSectionPage.waitWhilePreloadProgressbarIsDisappeared();
        String lastScreeningDate = translator.getValue("thirdPartyInformation.screening.lastScreeningDateUppercase");
        String formattedDate = date.replace(SI_MAIN_SCREENING_DATE_FORMAT, getTodayDate(SI_MAIN_SCREENING_DATE_FORMAT));
        String expectedText = lastScreeningDate + SPACE + formattedDate;
        assertEquals("Other Name Screening section displays unexpected text", expectedText,
                     otherNameScreeningSectionPage.getOtherNameLastScreeningDateText());
    }

    @Then("Media check Other Name {string} first record with no external articles displays phases as blue color")
    public void isMediaCheckOtherNameNoExternalArticlePhasesDisplay(String otherNames) {
        MediaCheckResponse results =
                otherNameScreeningSectionPage.getMediaCheckOtherNameResponse(PAGINATION, otherNames);
        prepareNoExternalArticleForOtherNames(results);
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        String mediaCheckPhases = (String) context.getScenarioContext().getContext(MEDIA_CHECK_PHASES);
        SoftAssert soft = new SoftAssert();
        soft.assertTrue(otherNameScreeningSectionPage.isMediaCheckOtherNamePhasesColorDisplayed(indexOfArticle),
                        "Media Check Other Name Phases is displayed unexpected color");
        soft.assertEquals(otherNameScreeningSectionPage.getMediaCheckOtherNamePhases(indexOfArticle), mediaCheckPhases,
                          "Media Check Other Name Phases is not matched with Phases from API");
        soft.assertAll();
    }

    @Then("Media check Other Name {string} first record with no external articles displays topics as black color")
    public void isMediaCheckOtherNameNoExternalArticleTopicsDisplay(String otherNames) {
        MediaCheckResponse results =
                otherNameScreeningSectionPage.getMediaCheckOtherNameResponse(PAGINATION, otherNames);
        prepareNoExternalArticleForOtherNames(results);
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        String mediaCheckTopics = (String) context.getScenarioContext().getContext(MEDIA_CHECK_TOPICS);
        SoftAssert soft = new SoftAssert();
        soft.assertTrue(otherNameScreeningSectionPage.isMediaCheckOtherNameTopicsColorDisplayed(indexOfArticle),
                        "Media Check Other Name Topics is displayed unexpected color");
        soft.assertEquals(otherNameScreeningSectionPage.getMediaCheckOtherNameTopics(indexOfArticle), mediaCheckTopics,
                          "Media Check Other Name Topics is not matched with Phases from API");
        soft.assertAll();
    }

    @Then("Media check Other Name {string} first record with no external articles displays name as same as API value")
    public void isMediaCheckOtherNameNoExternalArticleNameDisplay(String otherNames) {
        MediaCheckResponse results =
                otherNameScreeningSectionPage.getMediaCheckOtherNameResponse(PAGINATION, otherNames);
        prepareNoExternalArticleForOtherNames(results);
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        String titleName = (String) context.getScenarioContext().getContext(TITLE_NAME);
        SoftAssert soft = new SoftAssert();
        soft.assertEquals(otherNameScreeningSectionPage.getMediaCheckOtherNamePublicationName(indexOfArticle),
                          titleName,
                          "Media Check Other Name Publication Name is not matched with Phases from API");
        soft.assertAll();
    }

    @Then("Media check Other Name {string} first record with no external articles displays date in format: {string}")
    public void mediaCheckOtherNameNoExternalDisplaysDateInFormat(String otherNames, String date) {
        otherNameScreeningSectionPage.waitWhilePreloadProgressbarIsDisappeared();
        MediaCheckResponse results =
                otherNameScreeningSectionPage.getMediaCheckOtherNameResponse(PAGINATION, otherNames);
        prepareNoExternalArticleForOtherNames(results);
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        String publicationDate = (String) context.getScenarioContext().getContext(PUBLICATION_DATE);
        String formattedDate = date.replace(SI_SIMILAR_ARTICLE_DATE, publicationDate);
        SoftAssert soft = new SoftAssert();
        soft.assertEquals(otherNameScreeningSectionPage.getMediaCheckOtherNameDateText(indexOfArticle), formattedDate,
                          "Media Check Other Name Articles displays unexpected text");
        soft.assertAll();
    }

    @Then("Media check Other Name {string} first record with external articles displays phases as blue color")
    public void isMediaCheckOtherNameExternalArticlePhasesDisplay(String otherNames) {
        MediaCheckResponse results =
                otherNameScreeningSectionPage.getMediaCheckOtherNameResponse(PAGINATION, otherNames);
        prepareExternalArticleForOtherNames(results);
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        String mediaCheckPhases = (String) context.getScenarioContext().getContext(MEDIA_CHECK_PHASES);
        SoftAssert soft = new SoftAssert();
        soft.assertTrue(otherNameScreeningSectionPage.isMediaCheckOtherNamePhasesColorDisplayed(indexOfArticle),
                        "Media Check Other Name Phases is displayed unexpected color");
        soft.assertEquals(otherNameScreeningSectionPage.getMediaCheckOtherNamePhases(indexOfArticle), mediaCheckPhases,
                          "Media Check Other Name Phases is not matched with Phases from API");
        soft.assertAll();
    }

    @Then("Media check Other Name {string} first record with external articles displays topics as black color")
    public void isMediaCheckOtherNameExternalArticleTopicsDisplay(String otherNames) {
        MediaCheckResponse results =
                otherNameScreeningSectionPage.getMediaCheckOtherNameResponse(PAGINATION, otherNames);
        prepareExternalArticleForOtherNames(results);
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        String mediaCheckTopics = (String) context.getScenarioContext().getContext(MEDIA_CHECK_TOPICS);
        SoftAssert soft = new SoftAssert();
        soft.assertTrue(otherNameScreeningSectionPage.isMediaCheckOtherNameTopicsColorDisplayed(indexOfArticle),
                        "Media Check Other Name Topics is displayed unexpected color");
        soft.assertEquals(otherNameScreeningSectionPage.getMediaCheckOtherNameTopics(indexOfArticle), mediaCheckTopics,
                          "Media Check Other Name Topics is not matched with Phases from API");
        soft.assertAll();
    }

    @Then("Media check Other Name {string} first record with external articles displays name as same as API value")
    public void isMediaCheckOtherNameExternalArticleNameDisplay(String otherNames) {
        MediaCheckResponse results =
                otherNameScreeningSectionPage.getMediaCheckOtherNameResponse(PAGINATION, otherNames);
        prepareExternalArticleForOtherNames(results);
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        String titleName = (String) context.getScenarioContext().getContext(TITLE_NAME);
        SoftAssert soft = new SoftAssert();
        soft.assertEquals(otherNameScreeningSectionPage.getMediaCheckOtherNamePublicationName(indexOfArticle),
                          titleName,
                          "Media Check Other Name Publication Name is not matched with Phases from API");
        soft.assertAll();
    }

    @Then("Media check Other Name {string} first record with external articles displays date in format: {string}")
    public void mediaCheckOtherNameExternalDisplaysDateInFormat(String otherNames, String date) {
        otherNameScreeningSectionPage.waitWhilePreloadProgressbarIsDisappeared();
        MediaCheckResponse results =
                otherNameScreeningSectionPage.getMediaCheckOtherNameResponse(PAGINATION, otherNames);
        prepareExternalArticleForOtherNames(results);
        int indexOfArticle = (int) context.getScenarioContext().getContext(INDEX_OF_ARTICLES);
        String publicationDate = (String) context.getScenarioContext().getContext(PUBLICATION_DATE);
        String formattedDate = date.replace(SI_SIMILAR_ARTICLE_DATE, publicationDate);
        SoftAssert soft = new SoftAssert();
        soft.assertEquals(otherNameScreeningSectionPage.getMediaCheckOtherNameDateText(indexOfArticle), formattedDate,
                          "Media Check Other Name Articles displays unexpected text");
        soft.assertAll();
    }

    @Then("Media check Other Name {string} last articles on last page displays title as same as value from API")
    public void isMediaCheckOtherNameArticleTitleLastPageDisplay(String otherNames) {
        String mediaCheckLastReference = (String) context.getScenarioContext().getContext(MEDIA_CHECK_LAST_REFERENCE);
        PublicationDateResponse publicationDate = otherNameScreeningSectionPage.getPublicationDate();
        String minDate = publicationDate.getMin();
        String maxDate = publicationDate.getMax();
        MediaCheckResponse results =
                otherNameScreeningSectionPage.getMediaCheckOtherNameResponseForPageReference(PAGINATION,
                                                                                             mediaCheckLastReference,
                                                                                             minDate, maxDate,
                                                                                             otherNames);
        List<MediaCheckResponse.Article> mediaCheckArticle = results.getResults();
        long recordCount = mediaCheckArticle.size();
        int recordCountInt = (int) recordCount;
        String title = mediaCheckArticle.get(recordCountInt - 1).getArticleSummary().getTitle();
        assertEquals("Media Check Other Name title is not matched with title from API", title,
                     otherNameScreeningSectionPage.getMediaCheckOtherNameTitle(recordCountInt));
    }

    @Then("OGS Toggle Other Name is disable")
    public void ogsToggleOtherNameIsDisable() {
        assertTrue("OGS Toggle Other Name is not disable",
                   otherNameScreeningSectionPage.isOGSToggleOtherNameDisable());
    }

    @Then("OGS Other Name is turned OFF")
    public void ogsOtherNameIsTurnedOff() {
        assertThat(otherNameScreeningSectionPage.isOgsOtherNameTurned()).as("OGS Other Name is turned ON").isFalse();
    }

    @Then("OGS Other Name is turned ON")
    public void ogsSliderIsTurnedOn() {
        assertThat(otherNameScreeningSectionPage.isOgsOtherNameTurned()).as("OGS Other Name is turned OFF").isTrue();
    }

    @Then("Media Check Other Name Risk Level ToolTip {string} is displayed")
    public void isMediaCheckOtherNameToolTipDisplayed(String toolTipName) {
        assertTrue("Media Check Other Name Risk Level ToolTip is not displayed",
                   otherNameScreeningSectionPage.isMediaCheckOtherNameRiskLevelToolTipDisplayed(toolTipName));
    }

}