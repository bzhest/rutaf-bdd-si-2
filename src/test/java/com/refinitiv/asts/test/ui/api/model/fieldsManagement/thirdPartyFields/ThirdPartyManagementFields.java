package com.refinitiv.asts.test.ui.api.model.fieldsManagement.thirdPartyFields;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class ThirdPartyManagementFields {

    FieldStates name;
    FieldStates referenceNo;
    FieldStates industryType;
    FieldStates incorporationDate;
    FieldStates responsibleParty;
    FieldStates currency;
    FieldStates companyType;
    FieldStates divisions;
    FieldStates businessType;
    FieldStates affiliation;
    FieldStates organizationSize;
    FieldStates workflowGroupId;
    FieldStates revenue;
    FieldStates description;
    FieldStates spendCategory;
    FieldStates productDesignAgreement;
    FieldStates relationshipVisibility;
    FieldStates commodityType;
    FieldStates liquidationDate;
    FieldStates sourcingMethod;
    FieldStates sourcingType;
    FieldStates productImpact;
    BankDetails bankDetails;
    Address address;
    ContactInformation contactInformation;

    public static ThirdPartyManagementFields setDefaults() {
        return new ThirdPartyManagementFields().setName(FieldStates.setDefaultRequired())
                .setResponsibleParty(FieldStates.setDefaultRequired())
                .setDivisions(FieldStates.setDefaultRequired())
                .setWorkflowGroupId(FieldStates.setDefaultRequired())
                .setReferenceNo(FieldStates.unsetRequired())
                .setIndustryType(FieldStates.unsetRequired())
                .setIncorporationDate(FieldStates.unsetRequired())
                .setCurrency(FieldStates.unsetRequired())
                .setCompanyType(FieldStates.unsetRequired())
                .setBusinessType(FieldStates.unsetRequired())
                .setCommodityType(FieldStates.unsetRequired())
                .setAffiliation(FieldStates.unsetRequired())
                .setLiquidationDate(FieldStates.unsetRequired())
                .setOrganizationSize(FieldStates.unsetRequired())
                .setRevenue(FieldStates.unsetRequired())
                .setDescription(FieldStates.unsetRequired())
                .setSpendCategory(FieldStates.unsetRequired())
                .setProductDesignAgreement(FieldStates.unsetRequired())
                .setRelationshipVisibility(FieldStates.unsetRequired())
                .setSourcingMethod(FieldStates.unsetRequired())
                .setSourcingType(FieldStates.unsetRequired())
                .setProductImpact(FieldStates.unsetRequired())
                .setAddress(Address.setDefault())
                .setBankDetails(BankDetails.setDefault())
                .setContactInformation(ContactInformation.setDefault());
    }

    public static ThirdPartyManagementFields setRequiredGeneralInformationAndThirdPartySegmentationFields() {
        return new ThirdPartyManagementFields().setName(FieldStates.setDefaultRequired())
                .setResponsibleParty(FieldStates.setDefaultRequired())
                .setDivisions(FieldStates.setDefaultRequired())
                .setWorkflowGroupId(FieldStates.setDefaultRequired())
                .setReferenceNo(FieldStates.setRequired())
                .setIndustryType(FieldStates.setRequired())
                .setIncorporationDate(FieldStates.setRequired())
                .setCurrency(FieldStates.setRequired())
                .setCompanyType(FieldStates.setRequired())
                .setBusinessType(FieldStates.setRequired())
                .setCommodityType(FieldStates.unsetRequired())
                .setAffiliation(FieldStates.setRequired())
                .setLiquidationDate(FieldStates.setRequired())
                .setOrganizationSize(FieldStates.setRequired())
                .setRevenue(FieldStates.setRequired())
                .setDescription(FieldStates.unsetRequired())
                .setSpendCategory(FieldStates.setRequired())
                .setProductDesignAgreement(FieldStates.setRequired())
                .setRelationshipVisibility(FieldStates.setRequired())
                .setCommodityType(FieldStates.setRequired())
                .setSourcingMethod(FieldStates.setRequired())
                .setSourcingType(FieldStates.setRequired())
                .setProductImpact(FieldStates.setRequired())
                .setAddress(Address.setDefault())
                .setBankDetails(BankDetails.setDefault())
                .setContactInformation(ContactInformation.setDefault());
    }

    public static ThirdPartyManagementFields setRequiredGeneralInformationFields() {
        return new ThirdPartyManagementFields().setName(FieldStates.setDefaultRequired())
                .setResponsibleParty(FieldStates.setDefaultRequired())
                .setDivisions(FieldStates.setDefaultRequired())
                .setWorkflowGroupId(FieldStates.setDefaultRequired())
                .setReferenceNo(FieldStates.setRequired())
                .setIndustryType(FieldStates.setRequired())
                .setIncorporationDate(FieldStates.setRequired())
                .setCurrency(FieldStates.setRequired())
                .setCompanyType(FieldStates.setRequired())
                .setBusinessType(FieldStates.setRequired())
                .setCommodityType(FieldStates.unsetRequired())
                .setAffiliation(FieldStates.setRequired())
                .setLiquidationDate(FieldStates.setRequired())
                .setOrganizationSize(FieldStates.setRequired())
                .setRevenue(FieldStates.setRequired())
                .setDescription(FieldStates.unsetRequired())
                .setSpendCategory(FieldStates.unsetRequired())
                .setProductDesignAgreement(FieldStates.unsetRequired())
                .setRelationshipVisibility(FieldStates.unsetRequired())
                .setSourcingMethod(FieldStates.unsetRequired())
                .setSourcingType(FieldStates.unsetRequired())
                .setProductImpact(FieldStates.unsetRequired())
                .setAddress(Address.setDefault())
                .setBankDetails(BankDetails.setDefault())
                .setContactInformation(ContactInformation.setDefault());
    }

    public static ThirdPartyManagementFields unsetActiveThirdPartySegmentationFields() {
        return new ThirdPartyManagementFields().setName(FieldStates.setDefaultRequired())
                .setResponsibleParty(FieldStates.setDefaultRequired())
                .setDivisions(FieldStates.setDefaultRequired())
                .setWorkflowGroupId(FieldStates.setDefaultRequired())
                .setReferenceNo(FieldStates.unsetRequired())
                .setIndustryType(FieldStates.unsetRequired())
                .setIncorporationDate(FieldStates.unsetRequired())
                .setCurrency(FieldStates.unsetRequired())
                .setCompanyType(FieldStates.unsetRequired())
                .setBusinessType(FieldStates.unsetRequired())
                .setCommodityType(FieldStates.unsetActive())
                .setAffiliation(FieldStates.unsetRequired())
                .setLiquidationDate(FieldStates.unsetRequired())
                .setOrganizationSize(FieldStates.unsetRequired())
                .setRevenue(FieldStates.unsetRequired())
                .setDescription(FieldStates.unsetRequired())
                .setSpendCategory(FieldStates.unsetActive())
                .setProductDesignAgreement(FieldStates.unsetActive())
                .setRelationshipVisibility(FieldStates.unsetActive())
                .setSourcingMethod(FieldStates.unsetActive())
                .setSourcingType(FieldStates.unsetActive())
                .setProductImpact(FieldStates.unsetActive())
                .setAddress(Address.setDefault())
                .setBankDetails(BankDetails.setDefault())
                .setContactInformation(ContactInformation.setDefault());
    }

    public static ThirdPartyManagementFields setSubSectionsActiveFields() {
        return new ThirdPartyManagementFields().setName(FieldStates.setDefaultRequired())
                .setResponsibleParty(FieldStates.setDefaultRequired())
                .setDivisions(FieldStates.setDefaultRequired())
                .setWorkflowGroupId(FieldStates.setDefaultRequired())
                .setReferenceNo(FieldStates.unsetRequired())
                .setIndustryType(FieldStates.unsetActive())
                .setIncorporationDate(FieldStates.setRequired())
                .setCurrency(FieldStates.unsetActive())
                .setCompanyType(FieldStates.unsetActive())
                .setBusinessType(FieldStates.unsetActive())
                .setCommodityType(FieldStates.unsetRequired())
                .setAffiliation(FieldStates.unsetActive())
                .setLiquidationDate(FieldStates.unsetActive())
                .setOrganizationSize(FieldStates.unsetRequired())
                .setRevenue(FieldStates.unsetActive())
                .setDescription(FieldStates.unsetRequired())
                .setSpendCategory(FieldStates.unsetRequired())
                .setProductDesignAgreement(FieldStates.unsetActive())
                .setRelationshipVisibility(FieldStates.unsetActive())
                .setSourcingMethod(FieldStates.unsetActive())
                .setSourcingType(FieldStates.unsetActive())
                .setProductImpact(FieldStates.unsetActive())
                .setAddress(Address.setActiveCityAndRegionFields())
                .setBankDetails(BankDetails.setRequiredBankNameAndAccountFields())
                .setContactInformation(ContactInformation.setAllFieldsRequired());
    }

    public static ThirdPartyManagementFields setDefaultsWithRequiredBankDetailsAndContacts() {
        return new ThirdPartyManagementFields().setName(FieldStates.setDefaultRequired())
                .setResponsibleParty(FieldStates.setDefaultRequired())
                .setDivisions(FieldStates.setDefaultRequired())
                .setWorkflowGroupId(FieldStates.setDefaultRequired())
                .setReferenceNo(FieldStates.unsetRequired())
                .setIndustryType(FieldStates.unsetRequired())
                .setIncorporationDate(FieldStates.unsetRequired())
                .setCurrency(FieldStates.unsetRequired())
                .setCompanyType(FieldStates.unsetRequired())
                .setBusinessType(FieldStates.unsetRequired())
                .setCommodityType(FieldStates.unsetRequired())
                .setAffiliation(FieldStates.unsetRequired())
                .setLiquidationDate(FieldStates.unsetRequired())
                .setOrganizationSize(FieldStates.unsetRequired())
                .setRevenue(FieldStates.unsetRequired())
                .setDescription(FieldStates.unsetRequired())
                .setSpendCategory(FieldStates.unsetRequired())
                .setProductDesignAgreement(FieldStates.unsetRequired())
                .setRelationshipVisibility(FieldStates.unsetRequired())
                .setSourcingMethod(FieldStates.unsetRequired())
                .setSourcingType(FieldStates.unsetRequired())
                .setProductImpact(FieldStates.unsetRequired())
                .setAddress(Address.setRequiredCityAndRegionFields())
                .setBankDetails(BankDetails.setRequiredBankNameAndAccountFields())
                .setContactInformation(ContactInformation.setAllFieldsRequired());
    }

    public static ThirdPartyManagementFields setAllFieldsInactiveExceptDefaultRequired() {
        return new ThirdPartyManagementFields().setName(FieldStates.setDefaultRequired())
                .setResponsibleParty(FieldStates.setDefaultRequired())
                .setDivisions(FieldStates.setDefaultRequired())
                .setWorkflowGroupId(FieldStates.setDefaultRequired())
                .setReferenceNo(FieldStates.unsetActive())
                .setIndustryType(FieldStates.unsetActive())
                .setIncorporationDate(FieldStates.unsetActive())
                .setCurrency(FieldStates.unsetActive())
                .setCompanyType(FieldStates.unsetActive())
                .setBusinessType(FieldStates.unsetActive())
                .setCommodityType(FieldStates.unsetActive())
                .setAffiliation(FieldStates.unsetActive())
                .setLiquidationDate(FieldStates.unsetActive())
                .setOrganizationSize(FieldStates.unsetActive())
                .setRevenue(FieldStates.unsetActive())
                .setDescription(FieldStates.unsetActive())
                .setSpendCategory(FieldStates.unsetActive())
                .setProductDesignAgreement(FieldStates.unsetActive())
                .setRelationshipVisibility(FieldStates.unsetActive())
                .setSourcingMethod(FieldStates.unsetActive())
                .setSourcingType(FieldStates.unsetActive())
                .setProductImpact(FieldStates.unsetActive())
                .setAddress(Address.setAllFieldsInactiveExceptDefaultRequired())
                .setBankDetails(BankDetails.setAllFieldsInactive())
                .setContactInformation(ContactInformation.setAllFieldsInactive());
    }

}
