package com.refinitiv.asts.test.ui.utils.wc1.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.refinitiv.asts.test.ui.enums.CountryType;
import com.refinitiv.asts.test.ui.enums.Providers;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class ResultsResponseDTO {

    String resultId;
    String referenceId;
    String matchStrength;
    String matchedTerm;
    String submittedTerm;
    String matchedNameType;
    List<SecondaryFieldResult> secondaryFieldResults;
    List<String> sources;
    List<String> categories;
    String creationDate;
    String modificationDate;
    ResolutionResponse resolution;
    Integer resolutionPosition;
    ReviewResponseDTO resultReview;
    String primaryName;
    List<Event> events;
    List<CountryLink> countryLinks;
    String countryLinksString;
    String category;
    Providers providerType;
    String providerTypeString;
    String gender;
    String displayName;

    @Data
    public static class CountryLink {

        Country country;
        String countryText;
        CountryType type;

    }

    @Data
    public static class SecondaryFieldResult {

        String typeId;
        Field field;
        String submittedValue;
        String submittedDateTimeValue;
        String matchedValue;
        String matchedDateTimeValue;
        String fieldResult;

    }

    @Data
    public static class Event {

        Address address;
        List<Address> allegedAddresses;
        Integer day;
        String fullDate;
        Integer month;
        String type;
        Integer year;

    }

}
