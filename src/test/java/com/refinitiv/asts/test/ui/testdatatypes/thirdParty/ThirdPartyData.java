package com.refinitiv.asts.test.ui.testdatatypes.thirdParty;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.refinitiv.asts.test.ui.api.model.Attachment;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.experimental.Accessors;

import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

@Data
@AllArgsConstructor
@RequiredArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
@Builder
public class ThirdPartyData {

    public ThirdPartyData(String addressLine, String stateProvince, String city, String zipCode, String country) {
        this.addressLine = addressLine;
        this.city = city;
        this.zipCode = zipCode;
        this.stateProvince = stateProvince;
        this.country = country;
    }

    //    General Information
    private String referenceNo;
    private String name;
    private String companyType;
    private String organisationSize;
    private String dateOfIncorporation;
    private String responsibleParty;
    private String division;
    private String workflowGroup;
    private String currency;
    private String industryType;
    private String businessCategory;
    private String revenue;
    private String liquidationDate;
    private String affiliation;

    //    Third-party Segmentation
    private String spendCategory;
    private String designAgreement;
    private String relationshipVisibility;
    private String commodityType;
    private String sourcingMethod;
    private String sourcingType;
    private String productImpact;

    //    Bank Details
    private String bankName;
    private String accountNo;
    private String branchName;
    private String bankAddressLine;
    private String bankCity;
    private String bankCountry;

    //    Address
    private String addressLine;
    private String city;
    private String zipCode;
    private String stateProvince;
    private String region;
    private String country;

    //    Contact
    private String phoneNumber;
    private String fax;
    private String website;
    private String emailAddress;

    //    ScreeningCriteria
    private String searchTerm;
    private String countryOfRegistration;

    //    Description
    private String description;

    //    Other
    private String id;
    private List<Attachment> attachments;
    private Double score;
    private Long createTime;

    public static class ThirdPartyComparator implements Comparator<ThirdPartyData> {

        private final List<Comparator<ThirdPartyData>> listComparators;

        public ThirdPartyComparator() {
            this.listComparators = Arrays.asList(new ScoreComparator(), new CreationDateComparator());
        }

        public int compare(ThirdPartyData tp1, ThirdPartyData tp2) {
            for (Comparator<ThirdPartyData> comparator : listComparators) {
                int result = comparator.compare(tp1, tp2);
                if (result != 0) {
                    return result;
                }
            }
            return 0;
        }

        private static class ScoreComparator implements Comparator<ThirdPartyData> {

            @Override
            public int compare(ThirdPartyData tp1, ThirdPartyData tp2) {
                return Double.compare(tp1.getScore(), tp2.getScore());
            }

        }

        private static class CreationDateComparator implements Comparator<ThirdPartyData> {

            @Override
            public int compare(ThirdPartyData tp1, ThirdPartyData tp2) {
                return Long.compare(tp1.getCreateTime(), tp2.getCreateTime());
            }

        }

    }

}
