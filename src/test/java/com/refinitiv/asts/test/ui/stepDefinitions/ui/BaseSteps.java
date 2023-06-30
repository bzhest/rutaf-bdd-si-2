package com.refinitiv.asts.test.ui.stepDefinitions.ui;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.core.framework.drivers.DriverFactory;
import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.ui.api.ConnectApi;
import com.refinitiv.asts.test.ui.api.model.SiPublicReferencesResponse;
import com.refinitiv.asts.test.ui.api.model.valueManagement.RiskScoreEngineResponse;
import com.refinitiv.asts.test.ui.enums.Providers;
import com.refinitiv.asts.test.ui.enums.Resolution;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import com.refinitiv.asts.test.ui.utils.wc1.model.ResultsResponseDTO;
import io.cucumber.datatable.DataTable;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.openqa.selenium.WebDriver;

import java.lang.invoke.MethodHandles;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.SIPublicApi.getReferencesCountries;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.getRiskScoreEngineRanges;
import static com.refinitiv.asts.test.ui.constants.APIConstants.DESC;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.UPDATE;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.constants.UserRoleConst.*;
import static com.refinitiv.asts.test.ui.enums.CountryType.LOCATION;
import static com.refinitiv.asts.test.ui.enums.CountryType.REGISTEREDIN;
import static com.refinitiv.asts.test.ui.enums.EntityType.SUPPLIER;
import static com.refinitiv.asts.test.ui.enums.Providers.CLIENT_WATCHLIST;
import static com.refinitiv.asts.test.ui.enums.Providers.WATCHLIST;
import static com.refinitiv.asts.test.ui.enums.Resolution.FALSE;
import static com.refinitiv.asts.test.ui.enums.Resolution.UNRESOLVED;
import static com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.thirdPartyInformation.ScreeningSteps.ELLIPSIS;
import static com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.thirdPartyInformation.ScreeningSteps.NUMBER_OF_CHARACTERS_NAME;
import static com.refinitiv.asts.test.ui.utils.DateUtil.getDateFromStringDate;
import static com.refinitiv.asts.test.ui.utils.ScreeningCSVReportBuilder.getResolutionStatus;
import static com.refinitiv.asts.test.ui.utils.wc1.CountriesReferenceResponseDataTransfer.getCountryNameByCode;
import static com.refinitiv.asts.test.ui.utils.wc1.ScreeningResultExpectedDataBuilder.getCategoriesAbbreviation;
import static com.refinitiv.asts.test.ui.utils.wc1.ScreeningResultExpectedDataBuilder.getCountriesListByType;
import static com.refinitiv.asts.test.ui.utils.wc1.WCOApiResponseExtractor.DATE;
import static java.lang.String.join;
import static java.util.Comparator.naturalOrder;
import static java.util.Comparator.reverseOrder;
import static java.util.Objects.nonNull;
import static java.util.stream.Collectors.toList;
import static org.apache.commons.lang3.RandomStringUtils.randomAlphanumeric;
import static org.apache.commons.lang3.StringUtils.*;
import static org.assertj.core.api.Assertions.assertThat;

public abstract class BaseSteps {

    protected final static Logger logger = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());
    protected WebDriver driver;
    protected ScenarioCtxtWrapper context;
    protected final LanguageConfig translator;

    protected BaseSteps() {
        this.driver = DriverFactory.getDriver();
        translator = LanguageConfig.getInstance();
    }

    protected BaseSteps(ScenarioCtxtWrapper context) {
        this();
        this.context = context;
    }

    public <T extends BasePage<T>> void alertIconIsDisplayedWithText(BasePage<T> page, DataTable dataTable) {
        String actualAlertMessage = page.getAlertIconText();
        assertThat(actualAlertMessage).as("Alert Icon is not displayed").isNotNull();
        dataTable.asList().forEach(text -> {
            text = adjustMessageWithTranslations(text);
            if (text.contains(ALREADY_EXIST_NAME)) {
                text = text.replace(ALREADY_EXIST_NAME,
                                    (String) context.getScenarioContext().getContext(ALREADY_EXIST_NAME));
            }
            if (text.contains(APPROVAL_PROCESS_NAME_CONTEXT)) {
                text = text.replace(APPROVAL_PROCESS_NAME_CONTEXT,
                                    (String) context.getScenarioContext().getContext(APPROVAL_PROCESS_NAME_CONTEXT));
            }
            assertThat(actualAlertMessage)
                    .as("Actual alert message '%s' doesn't contain expected text '%s'", actualAlertMessage, text)
                    .contains(text);
        });
    }

    public String adjustMessageWithTranslations(String message) {
        String lessAndMoreSignsPattern = "[<>]";
        if (message.contains(LESS) && message.contains(MORE)) {
            String textToTranslate = substringBetween(message, LESS, MORE);
            message = message.replaceAll(lessAndMoreSignsPattern, EMPTY);
            String translation = translator.getValue(textToTranslate);
            return message.replaceAll(textToTranslate, translation).replaceAll(NBSP_CODE, SPACE);
        } else {
            return message;
        }
    }

    public DataTable adjustMessageWithTranslations(DataTable dataTable) {
        List<String> adjustedMessages =
                dataTable.asList().stream().map(this::adjustMessageWithTranslations).collect(toList());
        return DataTable.create(List.of(adjustedMessages));
    }

    public UserData getUserCredentialsByRole(String role) {
        switch (role.toLowerCase()) {
            case ADMIN:
                return new UserData()
                        .setUsername(Config.get().value("admin.username"))
                        .setPassword(Config.get().value("admin.password"))
                        .setFirstName(Config.get().value("admin.firstName"))
                        .setLastName(Config.get().value("admin.lastName"));
            case SUPER_ADMIN:
                return new UserData()
                        .setUsername(Config.get().value("super.admin.username"))
                        .setPassword(Config.get().value("super.admin.password"))
                        .setFirstName(Config.get().value("super.admin.firstName"))
                        .setLastName(Config.get().value("super.admin.lastName"));
            case EXTERNAL:
                return new UserData()
                        .setUsername(Config.get().value("user.external.username"))
                        .setPassword(Config.get().value("user.external.password"))
                        .setFirstName(Config.get().value("user.external.firstName"))
                        .setLastName(Config.get().value("user.external.lastName"));
            case RESTRICTED:
                return new UserData()
                        .setUsername(Config.get().value("restricted.username"))
                        .setPassword(Config.get().value("restricted.password"));
            case RESTRICTED_WITH_EDIT_PERMISSIONS:
                return new UserData()
                        .setUsername(Config.get().value("restricted.with.edit.username"))
                        .setPassword(Config.get().value("restricted.with.edit.password"))
                        .setFirstName(Config.get().value("restricted.with.edit.firstName"))
                        .setLastName(Config.get().value("restricted.with.edit.lastName"));
            case SECOND_WITH_EDIT_PERMISSIONS:
                return new UserData()
                        .setUsername(Config.get().value("second.with.edit.username"))
                        .setPassword(Config.get().value("second.with.edit.password"));
            case ASSIGNEE:
                return new UserData()
                        .setUsername(Config.get().value("assignee.username"))
                        .setPassword(Config.get().value("assignee.password"))
                        .setFirstName(Config.get().value("assignee.firstName"))
                        .setLastName(Config.get().value("assignee.lastName"));
            case APPROVER:
                return new UserData()
                        .setUsername(Config.get().value("user.approver.username"))
                        .setPassword(Config.get().value("user.approver.password"))
                        .setFirstName(Config.get().value("user.approver.firstName"))
                        .setLastName(Config.get().value("user.approver.lastName"));
            case USER_NO_ONBOARDING_RENEWAL:
                return new UserData()
                        .setUsername(Config.get().value("user.no.onboarding.renewal.username"))
                        .setPassword(Config.get().value("user.no.onboarding.renewal.password"))
                        .setFirstName(Config.get().value("user.no.onboarding.renewal.firstName"))
                        .setLastName(Config.get().value("user.no.onboarding.renewal.lastName"));
            case ADMIN_DOUBLE:
                return new UserData()
                        .setUsername(Config.get().value("admin.double.username"))
                        .setPassword(Config.get().value("admin.double.password"))
                        .setFirstName(Config.get().value("admin.double.firstName"))
                        .setLastName(Config.get().value("admin.double.lastName"));
            case CREATED_DURING_TEST:
                String userName = (String) context.getScenarioContext().getContext(EMAIL_CONTEXT);
                String password = (String) context.getScenarioContext().getContext(PASSWORD_CONTEXT);
                return new UserData()
                        .setUsername(userName)
                        .setPassword(password);
            case EXTERNAL_USER_FOR_EDITING:
                return new UserData()
                        .setUsername(Config.get().value("user.external.for.editing.username"))
                        .setPassword(Config.get().value("user.external.for.editing.password"));
            case EXTERNAL_USER_PASSWORD_EDIT:
                return new UserData()
                        .setUsername(Config.get().value("user.external.for.password.recovery.username"))
                        .setFirstName(Config.get().value("user.external.for.password.recovery.firstName"))
                        .setLastName(Config.get().value("user.external.for.password.recovery.lastName"))
                        .setPassword(Config.get().value("user.external.for.password.recovery.password"));
            case INTERNAL_USER_FOR_EDITING:
                return new UserData()
                        .setUsername(Config.get().value("user.internal.for.editing.username"))
                        .setPassword(Config.get().value("user.internal.for.editing.password"));
            case INTERNAL_USER:
                return new UserData()
                        .setUsername(Config.get().value("user.internal.username"))
                        .setPassword(Config.get().value("user.internal.password"));
            case EXTERNAL_USER_WITH_SIMILAR_EMAIL:
                return new UserData()
                        .setUsername(Config.get().value("user.external.similar.username"))
                        .setPassword(Config.get().value("user.external.similar.password"));
            case FORGOT_PASSWORD:
                return new UserData()
                        .setUsername(Config.get().value("user.forgot.username"))
                        .setPassword(Config.get().value("user.forgot.password"));
            case EXTERNAL_FORGOT_PASSWORD:
                return new UserData()
                        .setUsername(Config.get().value("user.external.forgot.username"))
                        .setPassword(Config.get().value("user.external.forgot.password"));
            case INACTIVE_USER:
                return new UserData()
                        .setUsername(Config.get().value("user.inactive.username"))
                        .setPassword(Config.get().value("user.inactive.password"));
            case EXTERNAL_INACTIVE_USER:
                return new UserData()
                        .setUsername(Config.get().value("user.external.inactive.username"))
                        .setPassword(Config.get().value("user.external.inactive.password"));
            case RESET_PASSWORD_USER:
                return new UserData()
                        .setUsername(Config.get().value("user.reset.password.username"))
                        .setPassword(Config.get().value("user.reset.password.password"));
            case EMPTY_METRICS_USER:
                return new UserData()
                        .setUsername(Config.get().value("user.empty.metrics.username"))
                        .setPassword(Config.get().value("user.empty.metrics.password"));
            case MEDIACHECK_PERMISSION_ON_USER:
                return new UserData()
                        .setFirstName(Config.get().value("user.media.check.permission.on.firstName"))
                        .setLastName(Config.get().value("user.media.check.permission.on.lastName"))
                        .setUsername(Config.get().value("user.media.check.permission.on.username"))
                        .setPassword(Config.get().value("user.media.check.permission.on.password"));
            case MEDIACHECK_PERMISSION_OFF_USER:
                return new UserData()
                        .setFirstName(Config.get().value("user.media.check.permission.off.firstName"))
                        .setLastName(Config.get().value("user.media.check.permission.off.lastName"))
                        .setUsername(Config.get().value("user.media.check.permission.off.username"))
                        .setPassword(Config.get().value("user.media.check.permission.off.password"));
            case SCREENING_PERMISSION_OFF_USER:
                return new UserData()
                        .setFirstName(Config.get().value("user.screening.permission.off.firstName"))
                        .setLastName(Config.get().value("user.screening.permission.off.lastName"))
                        .setUsername(Config.get().value("user.screening.permission.off.username"))
                        .setPassword(Config.get().value("user.screening.permission.off.password"));
            case CHANGING_ROLE_USER:
                return new UserData()
                        .setUsername(Config.get().value("user.internal.for.changing.roles.username"))
                        .setPassword(Config.get().value("user.internal.for.changing.roles.password"));
            case EXTERNAL_QUESTIONNAIRE:
                return new UserData()
                        .setUsername(Config.get().value("user.external.questionnaire.username"))
                        .setPassword(Config.get().value("user.external.questionnaire.password"));
            case SCREENING_PERMISSION_ON_USER:
                return new UserData()
                        .setFirstName(Config.get().value("user.screening.permission.on.firstName"))
                        .setLastName(Config.get().value("user.screening.permission.on.lastName"))
                        .setUsername(Config.get().value("user.screening.permission.on.username"))
                        .setPassword(Config.get().value("user.screening.permission.on.password"));
            default:
                throw new IllegalArgumentException("Incorrect role: " + role);
        }
    }

    public void removeEmailsFromList(List<String> list) {
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).contains(ROW_DELIMITER)) {
                String test = list.get(i).split(ROW_DELIMITER)[0];
                list.set(i, test);
            }
        }
    }

    protected Providers getProvider(String provider) {
        return WATCHLIST.getProvider().contains(provider) ? WATCHLIST : CLIENT_WATCHLIST;
    }

    public String getCountryWithoutChecklist() {
        String checklistCountries = ConnectApi.getCountryChecklistCountriesList();
        List<String> countries =
                getReferencesCountries().getData().stream().map(SiPublicReferencesResponse.Reference::getCode)
                        .collect(toList());
        List<String> unusedCountriesList = new ArrayList<>();
        for (String country : countries) {
            if (!checklistCountries.contains(country)) {
                unusedCountriesList.add(country);
            }
        }
        return getCountryNameByCode(unusedCountriesList.stream().findFirst().orElse(null));
    }

    public Function<String, String> getAllActiveUsersWithParentheses() {
        return item -> {
            item = item.replace(ROW_DELIMITER, SPACE);
            String[] itemsArray = item.split(SPACE);
            String lastWord = itemsArray[itemsArray.length - 1];
            if (!lastWord.startsWith(OPENED_PARENTHESIS) && !lastWord.endsWith(CLOSED_PARENTHESIS)) {
                item = item.replace(
                        itemsArray[itemsArray.length - 1],
                        OPENED_PARENTHESIS + itemsArray[itemsArray.length - 1] + CLOSED_PARENTHESIS);
            }
            return item;
        };
    }

    public String getCountries(String pageType, List<ResultsResponseDTO.CountryLink> countryLinks) {
        List<String> countriesByType = pageType.contains(SUPPLIER.toString().toLowerCase()) ?
                getCountriesListByType(countryLinks, REGISTEREDIN) : getCountriesListByType(countryLinks, LOCATION);
        return countriesByType.isEmpty() ? null : join(ROW_DELIMITER, countriesByType);
    }

    public List<ResultsResponseDTO> getScreeningData(List<ResultsResponseDTO> results, String pageType) {
        return results.stream()
                .map(result ->
                             new ResultsResponseDTO().setPrimaryName(result.getPrimaryName())
                                     .setCountryLinksString(getCountries(pageType, result.getCountryLinks()))
                                     .setCategory(result.getCategories().isEmpty() ? null :
                                                          join(ROW_DELIMITER,
                                                               getCategoriesAbbreviation(result.getCategories())))
                                     .setMatchStrength(result.getMatchStrength())
                                     .setProviderTypeString(result.getProviderType().getProvider())
                                     .setReferenceId(result.getReferenceId().replaceAll(ID_REGEX, StringUtils.EMPTY))
                                     .setResolutionPosition(Resolution.valueOf(
                                                     getResolutionStatus(result.getResolution(), result.getProviderType()))
                                                                    .getResolutionPosition())
                                     .setDisplayName(result.getPrimaryName().length() > NUMBER_OF_CHARACTERS_NAME ?
                                                             result.getPrimaryName()
                                                                     .substring(0, NUMBER_OF_CHARACTERS_NAME) +
                                                                     ELLIPSIS : result.getPrimaryName())
                ).collect(toList());
    }

    public Comparator<Float> getFloatComparator(String order) {
        Comparator<Float> comparator;
        if (order.equals(DESC)) {
            comparator = reverseOrder();
        } else {
            comparator = naturalOrder();
        }
        return comparator;
    }

    public Comparator<String> getStringComparator(String order, boolean isCaseSensitive) {
        Comparator<String> comparator;
        if (isCaseSensitive) {
            if (order.equals(DESC)) {
                comparator = Comparator.reverseOrder();
            } else {
                comparator = Comparator.naturalOrder();
            }
        } else {
            if (order.equals(DESC)) {
                comparator = String.CASE_INSENSITIVE_ORDER.reversed();
            } else {
                comparator = String.CASE_INSENSITIVE_ORDER;
            }
        }
        return comparator;
    }

    public Comparator<Date> getDateComparator(String order) {
        Comparator<Date> comparator;
        if (order.equals(DESC)) {
            comparator = reverseOrder();
        } else {
            comparator = naturalOrder();
        }
        return comparator;
    }

    public void tableIsSortedByInOrder(String tableName, String columnName, String sortOrder, String sortingFormat,
            List<String> valuesList, boolean isCaseSensitive) {
        valuesList.removeAll(Collections.singleton(null));
        if (columnName.toUpperCase().contains(DATE.toUpperCase()) ||
                columnName.toUpperCase().contains(UPDATE.toUpperCase())) {
            List<Date> dateList = valuesList.stream().map(date -> getDateFromStringDate(date, sortingFormat))
                    .collect(toList());
            assertThat(dateList).as("%s table is not sorted in %s order", tableName, sortOrder)
                    .isSortedAccordingTo(getDateComparator(sortOrder));
        } else {
            assertThat(valuesList).as("%s table is not sorted in %s order", tableName, sortOrder)
                    .isSortedAccordingTo(getStringComparator(sortOrder, isCaseSensitive));
        }
    }

    public String getRandomValue(String value) {
        return nonNull(value) && value.contains(VALUE_TO_REPLACE) ?
                AUTO_TEST_NAME_PREFIX + randomAlphanumeric(5) : value;
    }

    @SuppressWarnings("unchecked")
    public void updateResolutionList(boolean shouldBeRemoved, String resolutionType, String referenceId) {
        List<String> resolvedRecordsIdList =
                (List<String>) context.getScenarioContext().getContext(RESOLVED_RECORDS_ID_LIST);
        if (shouldBeRemoved ||
                Arrays.asList(UNRESOLVED.toString(), FALSE.toString()).contains(resolutionType.toUpperCase())) {
            resolvedRecordsIdList.remove(referenceId);
        } else {
            resolvedRecordsIdList.add(referenceId);
        }
        context.getScenarioContext().setContext(RESOLVED_RECORDS_ID_LIST, resolvedRecordsIdList);
    }

    public Map<String, String> getRiskColors() {
        return getRiskScoreEngineRanges().getData().get(0).getRanges().stream().collect(Collectors.toMap(
                RiskScoreEngineResponse.DataItem.RangesItem::getName,
                RiskScoreEngineResponse.DataItem.RangesItem::getColor));
    }

}
