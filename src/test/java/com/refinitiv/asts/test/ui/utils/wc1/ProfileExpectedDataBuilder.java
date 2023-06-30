package com.refinitiv.asts.test.ui.utils.wc1;

import com.refinitiv.asts.test.ui.enums.CountryType;
import com.refinitiv.asts.test.ui.enums.NameTypes;
import com.refinitiv.asts.test.ui.utils.wc1.model.Address;
import com.refinitiv.asts.test.ui.utils.wc1.model.ProfileResponseDTO;
import com.refinitiv.asts.test.ui.utils.wc1.model.ResultsResponseDTO;
import org.apache.commons.lang3.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.TestConstants.DASH;
import static com.refinitiv.asts.test.ui.enums.EventType.BIRTH;
import static com.refinitiv.asts.test.ui.enums.NameTypes.PRIMARY;
import static com.refinitiv.asts.test.ui.enums.RoleType.POSITION;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static com.refinitiv.asts.test.ui.utils.wc1.ScreeningResultExpectedDataBuilder.getCategoriesAbbreviation;

public class ProfileExpectedDataBuilder {

    /**
     * Filters names from WC1 API response and returns name with type PRIMARY
     *
     * @param profile response from WC1 API
     * @return primary name
     */
    public static String getPrimaryName(ProfileResponseDTO profile) {
        return profile.getNames()
                .stream()
                .filter(name -> name.getType().equals(PRIMARY.getName()))
                .findFirst().orElse(new ProfileResponseDTO.Name()).getFullName();
    }

    /**
     * Filters names from WC1 API response and returns name prefix with type PRIMARY
     *
     * @param profile response from WC1 API
     * @return primary name
     */
    public static String getTitle(ProfileResponseDTO profile) {
        String title = profile.getNames()
                .stream()
                .filter(name -> name.getType().equals(PRIMARY.getName()))
                .findFirst().orElse(new ProfileResponseDTO.Name()).getPrefix();
        return Objects.isNull(title) ? DASH : title;
    }

    /**
     * Filters events from WC1 API response by type and returns correct date.
     *
     * @param profile screening profile response
     * @param type    of date
     * @return list of birth date(s)
     */
    public static List<String> getDateByType(ProfileResponseDTO profile, String type) {
        return profile.getEvents().stream()
                .filter(event -> event.getType().equals(type))
                .map(event -> event.getMonth() == 0 ? event.getFullDate() : event.getYear().toString())
                .collect(Collectors.toList());
    }

    /**
     * Filters country links from WC1 API response and returns name with type.
     *
     * @param profile     response from WC1 API
     * @param countryType country type for filter
     * @return registered country
     */
    public static String getCountryByType(ProfileResponseDTO profile, CountryType countryType) {
        ResultsResponseDTO.CountryLink registeredCountry = profile.getCountryLinks()
                .stream()
                .filter(country -> country.getType().equals(countryType))
                .findFirst()
                .orElse(new ResultsResponseDTO.CountryLink());
        return Objects.nonNull(registeredCountry.getCountry()) ? registeredCountry.getCountry().getName() : DASH;
    }

    /**
     * Collects addresses from WC1 API response details in UI order:
     * Street, City, Region, Country
     *
     * @param profile response from WC1 API
     * @return list with address details list
     */
    public static List<List<String>> getLocationDetails(ProfileResponseDTO profile) {
        return profile.getAddresses()
                .stream()
                .map(address -> {
                    List<String> addressInfo = Arrays.asList(address.getStreet(),
                                                             address.getCity(),
                                                             address.getRegion(),
                                                             address.getCountry().getName());
                    replaceNullWithHyphen(addressInfo);
                    return addressInfo;
                })
                .collect(Collectors.toList());
    }

    /**
     * RMS-4192
     * Collects Identification Number(s) from WC1 API response details in UI order:
     * Name, Number, Issuer/Country
     *
     * @param profile response from WC1 API
     * @return list with Identification Number(s)
     */
    public static List<List<String>> getIdentificationNumber(ProfileResponseDTO profile) {
        return profile.getIdentityDocuments()
                .stream()
                .map(identificationNumber -> {
                    List<String> identificationNumberInfo =
                            Arrays.asList(identificationNumber.getLocationType().getName(),
                                          identificationNumber.getNumber(),
                                          identificationNumber.getLocationType().getCountry().getName());
                    replaceNullWithHyphen(identificationNumberInfo);
                    return identificationNumberInfo;
                })
                .collect(Collectors.toList());
    }

    /**
     * RMS-4192
     * Collect place of birth list(in WC1 could be >1 POB) by event type
     * events -> filter by BIRTH type ->  address -> region
     * if list is empty returns DASH
     *
     * @param profile response from WC1 API
     * @return list with place of birth
     */
    public static List<String> getPlaceOfBirth(ProfileResponseDTO profile) {
        List<String> pobList = profile.getEvents()
                .stream()
                .filter(event -> event.getType().equals(BIRTH.toString()))
                .map(ProfileResponseDTO.Event::getAddress)
                .filter(Objects::nonNull)
                .map(Address::getRegion)
                .distinct()
                .collect(Collectors.toList());
        return pobList.isEmpty() ? Collections.singletonList(DASH) : pobList;
    }

    /**
     * RMS-4192
     * Find and return position
     * If it is empty returns DASH
     *
     * @param profile response from WC1 API
     * @return position
     */
    public static String getPosition(ProfileResponseDTO profile) {
        ProfileResponseDTO.Role role = profile.getRoles()
                .stream()
                .filter(name -> name.getType().equals(POSITION.getType()))
                .findFirst().orElse(null);
        return Objects.isNull(role) ? DASH : role.getTitle();
    }

    /**
     * RMS-4192
     * Return age or DASH if it is empty
     *
     * @param profile response from WC1 API
     * @return age
     */
    public static String getAge(ProfileResponseDTO profile) {
        return Objects.isNull(profile.getAge()) ? DASH : profile.getAge();
    }

    /**
     * RMS-4192
     * Return age as of date or DASH if it is empty
     *
     * @param profile response from WC1 API
     * @return age as of date
     */
    public static Object getAgeAsOfDate(ProfileResponseDTO profile) {
        return Objects.isNull(profile.getAgeAsOfDate()) ? DASH :
                updateDateFormat(WC1_DATE_FORMAT, SI_PROFILE_DATE_FORMAT, profile.getAgeAsOfDate());
    }

    /**
     * Update creation and modification date in SI Profile format and returns in UI order:
     * Entered Date, Updated Date, Update Categorization
     *
     * @param profile response from WC1 API
     * @return list with two dates
     */
    public static List<String> getRecordUpdateDates(ProfileResponseDTO profile) {
        List<String> updates =
                Arrays.asList(updateDateFormat(WC1_DATE_FORMAT, SI_PROFILE_DATE_FORMAT, profile.getCreationDate()),
                              updateDateFormat(WC1_DATE_FORMAT, SI_PROFILE_DATE_FORMAT, profile.getModificationDate()),
                              profile.getUpdateCategory());
        updates.replaceAll(update -> (Objects.isNull(update) || update.equals("UNKNOWN")) ? DASH : update);
        return updates;
    }

    /**
     * Filter names by name's type and collect full names to list
     *
     * @param profile  response from WC1 API
     * @param nameType from NameTypes enum
     * @return return filtered list of names
     */
    public static List<String> getAliasesList(ProfileResponseDTO profile, NameTypes nameType) {
        return profile.getNames()
                .stream()
                .filter(name -> name.getType().equals(nameType.toString()))
                .map(ProfileResponseDTO.Name::getFullName)
                .collect(Collectors.toList());
    }

    /**
     * Collects details to list.
     * Trim space on beginning and end of string as UI trim it
     *
     * @param profile response from WC1 API
     * @return list with details
     */
    public static List<ProfileResponseDTO.Detail> getDetailsList(ProfileResponseDTO profile) {
        return profile.getDetails()
                .stream()
                .map(detail -> detail
                        .setText(getStringValue(
                                Objects.nonNull(detail.getText()) ? detail.getText().trim() : StringUtils.EMPTY))
                        .setTitle(detail.getTitle()))
                .collect(Collectors.toList());
    }

    /**
     * Collects web links to list
     *
     * @param profile response from WC1 API
     * @return list of web links
     */
    public static List<String> getWebLinksList(ProfileResponseDTO profile) {
        return profile.getWeblinks()
                .stream()
                .map(ProfileResponseDTO.Weblink::getUri)
                .collect(Collectors.toList());

    }

    /**
     * Collect sources to list with source details list in UI order:
     * Keyword,Description,Country
     *
     * @param profile response from WC1 API
     * @return list with keywords details list
     */
    public static List<List<String>> getKeywords(ProfileResponseDTO profile) {
        return profile.getSources()
                .stream()
                .map(source -> {
                    List<String> strings = Arrays.asList(source.getAbbreviation(),
                                                         source.getName(),
                                                         source.getRegionOfAuthority());
                    replaceNullWithHyphen(strings);
                    return strings;
                })
                .collect(Collectors.toList());
    }

    /**
     * Collect associates to list with associate details list in UI order:
     * Linked Individuals,Type,Category
     *
     * @param profile response from WC1 API
     * @return list of connections
     */
    public static List<List<Object>> getConnections(ProfileResponseDTO profile) {
        return profile.getAssociates()
                .stream()
                .map(associate ->
                             Arrays.asList(associate.getTargetPrimaryName(),
                                           associate.getType(),
                                           getCategoriesAbbreviation(associate.getTargetCategories()),
                                           associate.getCategory()))
                .collect(Collectors.toList());

    }

    public static String getStringValue(String value) {
        return Objects.isNull(value) || value.isEmpty() ? DASH : value.toUpperCase();
    }

    private static void replaceNullWithHyphen(List<String> addressInfo) {
        addressInfo.replaceAll(o -> Objects.isNull(o) ? DASH : o);
    }

}
