package com.refinitiv.asts.test.ui.utils.wc1.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class ProfileResponseDTO {

    String category;
    String subCategory;
    List<Name> names;
    String creationDate;
    String modificationDate;
    List<ResultsResponseDTO.CountryLink> countryLinks;
    List<Address> addresses;
    List<Associate> associates;
    List<Detail> details;
    List<String> sourceUris;
    List<ProviderSourceResponseDTO> sources;
    List<Weblink> weblinks;
    String gender;
    Boolean isDeceased;
    String comments;
    List<Event> events;
    String updateCategory;
    List<IdentityDocument> identityDocuments;
    String age;
    String ageAsOfDate;
    List<Role> roles;

    @Data
    public static class ProviderSourceResponseDTO {

        String abbreviation;
        String name;
        String regionOfAuthority;

        @Data
        @Accessors(chain = true)
        public static class ProviderSourceType {

            ProviderSourceTypeCategoryDetail category;
            String identifier;
            String name;

            @Data
            public static class ProviderSourceTypeCategoryDetail {

                String description;
                String identifier;
                String name;
                List<ProviderSourceType> providerSourceTypes;

            }

        }

    }

    @Data
    @Accessors(chain = true)
    public static class Detail {

        String text;
        String title;

    }

    @Data
    public static class Name {

        String fullName;
        String givenName;
        LanguageCode languageCode;
        String lastName;
        String originalScript;
        String prefix;
        String suffix;
        String type;

        @Data
        private class LanguageCode {

            String code;
            String name;

        }

    }

    @Data
    public static class Weblink {

        String caption;
        String uri;
        List<String> tags;

    }

    @Data
    public static class Associate {

        String targetPrimaryName;
        String type;
        List<String> targetCategories;
        String category;

    }

    @Data
    public static class Event {

        Address address;
        List<Address> allegedAddresses;
        int day;
        String fullDate;
        int month;
        String type;
        Integer year;

    }

    @Data
    public static class IdentityDocument {

        LocationType locationType;
        String number;

        @Data
        public static class LocationType {

            Country country;
            String name;

        }

    }

    @Data
    public static class Role {

        String end;
        String location;
        ProviderSourceResponseDTO source;
        String start;
        String title;
        String type;

    }

}
