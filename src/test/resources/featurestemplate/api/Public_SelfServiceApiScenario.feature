
#@apidemo
@api
Feature: A Generic feature file to run all API features or single feature file or feature file under a specific folder

  Scenario: Run all or single API Scenario
    # Provide either feature file directory or Single feature file here
    # for single feature file "testapi.feature"
    # for any API feature files directory, "demo" i.e the framework would evaluates path as src/test/resources/features/api/demo
    # "" Empty means all feature files under API

    # run all feature files under DEMO folder having tags @test or @test1
#    * Run API Tests "demo","@test,@test1"

    # run all feature files under DEMO folder with custom hooks
#    * Run API Tests "demo" with custom hooks

    # run all feature files under DEMO folder
#   * Run API Tests "demo"

    #==================== for CUSTOM HOOKS WITH TAGS
    # syntax [<featurefile or folder> or featurefile1,featureFile2],tags:@tag1,@tag2

    #Run specific feature files under 'public' by adding tags







#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUpload







#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdateSingleSuccess
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorThirdPartyIdNonExistent
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorRefNumDuplicate
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorRefNumNonExistent
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidDates
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdateOtherNamesSuccess
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdateBankDtlsSuccess
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdateDescriptionSuccess
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdateAddressSuccess
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorExceedMaxNumFaxes
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorExceedNumMaxBankDtls
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorExceedMaxNumWebsites
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorExceedMaxNumPhoneNums
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorExceedMaxNumOtherNames
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdateGenInfoSuccess
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdateOtherInfoSuccess
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdateContactInfoSuccess
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdateSegmentationSuccess
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdate10Success
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATE3Error2Success
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorIncompleteBankDtls
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorDuplicateOtherNameValues
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidRegionCountryPair
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidBusCatBadIndTypeValues
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidBankDtlsValues
#
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidGenInfoValues
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidAddressValues
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidOtherNamesValues
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidContactValues
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidSegmentationValues
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidOtherInfo
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidActionType
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorMissingFields
#
#
#
#
#
##    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidGenInfoValues
##    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidAddressValues
##    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidOtherNamesValues
##    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidContactValues
##    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidSegmentationValues
##    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidOtherInfo
##    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidActionType
##    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorMissingFields







#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartySingleSuccess
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyMultipleLinesSuccess
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdParty10Success
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdParty25Success
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdParty50Success
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyReqdFieldsSuccess
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdParty10BankDtlsSuccess
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdParty10OtherNamesSuccess
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdParty5ContactInfosSuccess
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdParty3Error2Success
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyDiffCustomFieldsSuccess
#
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidActionType
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorExceedMaxLength
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorDuplicateRefNo
#
### QA
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidRegnCtryPair
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidSegmentationValues
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidContactInfoValues
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidBankCtry
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidAddressValues
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidOtherNameValues
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidCustomFieldValues
##    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorMissingFieldValues
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidBusCatNoIndType
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidBusCatIndTypePair
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidDates
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorIncompleteBankDtls
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidGenInfoValues
#
#
#
#
#
#
#
#
#
#
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEUpdateSingleLineSuccess
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEUpdateDescSuccess
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@publicPOSTSelfServiceThirdPartyBulkUploadPARTUPDATEUpdateContactSuccess
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEUpdateGenInfoSuccess
#
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEUpdate10Success
#
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEUpdateSegmentationSuccess
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEUpdateOtherInfoSuccess
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEUpdateAddressSuccess
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEUpdateBankDtlsSuccess
#
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEUpdateOtherNamesSuccess
#
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidActionType
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorNonExistentThirdPartyId
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidGenInfoValues
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidSegmentationValues
#
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidDates
#
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidBankDetails
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorRefNumberDuplicate
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorRefNumberNonExistent
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidAddress
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidContactInfo
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidOtherInfo
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidBusCatIndTypePair
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidOtherNames
#
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidCountryRegionPair
#
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorDuplicateOtherName
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorIncompleteBankDtls
#
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorExceedMaxNumBankDtls
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorExceedMaxNumPhones
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorExceedMaxNumWebsites
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorExceedMaxNumFaxes
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorExceedMaxNumOtherNames
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorExceedMaxLength
#
#
#
#
#
#
#
#
#
#
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadDELETEThirdPartySuccess
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadDELETEThirdParty5Success
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadDELETEThirdParty10Success
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadDELETEThirdParty3Error2Success
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadDELETEThirdPartyErrorInvalidId
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadDELETEThirdPartyErrorInvalidActionType
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadDELETEThirdPartyErrorMissingFields
#-    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadDELETEThirdPartyErrorInvalidRefNo

####    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyMultipleActionsSuccess







# ====================================================================================================================================================================







#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUpload







    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdateSingleSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorThirdPartyIdNonExistent
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorRefNumDuplicate
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorRefNumNonExistent
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidDates
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdateOtherNamesSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdateBankDtlsSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdateDescriptionSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdateAddressSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorExceedMaxNumFaxes
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorExceedNumMaxBankDtls
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorExceedMaxNumWebsites
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorExceedMaxNumPhoneNums
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorExceedMaxNumOtherNames
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdateGenInfoSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdateOtherInfoSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdateContactInfoSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdateSegmentationSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdate10Success
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATE3Error2Success
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorIncompleteBankDtls
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorDuplicateOtherNameValues
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidRegionCountryPair
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidBusCatBadIndTypeValues
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidBankDtlsValues

    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidGenInfoValues
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidAddressValues
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidOtherNamesValues
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidContactValues
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidSegmentationValues
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidOtherInfo
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidActionType
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorMissingFields





##    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidGenInfoValues
##    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidAddressValues
##    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidOtherNamesValues
##    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidContactValues
##    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidSegmentationValues
##    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidOtherInfo
##    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorInvalidActionType
##    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEErrorMissingFields







    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartySingleSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyMultipleLinesSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdParty10Success
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdParty25Success
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdParty50Success
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyReqdFieldsSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdParty10BankDtlsSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdParty10OtherNamesSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdParty5ContactInfosSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdParty3Error2Success
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyDiffCustomFieldsSuccess

    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidActionType
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorExceedMaxLength
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorDuplicateRefNo

## QA
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidRegnCtryPair
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidSegmentationValues
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidContactInfoValues
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidBankCtry
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidAddressValues
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidOtherNameValues
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidCustomFieldValues
#    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorMissingFieldValues
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidBusCatNoIndType
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidBusCatIndTypePair
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidDates
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorIncompleteBankDtls
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyErrorInvalidGenInfoValues










    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEUpdateSingleLineSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEUpdateDescSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@publicPOSTSelfServiceThirdPartyBulkUploadPARTUPDATEUpdateContactSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEUpdateGenInfoSuccess

    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEUpdate10Success

    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEUpdateSegmentationSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEUpdateOtherInfoSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEUpdateAddressSuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEUpdateBankDtlsSuccess

    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEUpdateOtherNamesSuccess

    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidActionType
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorNonExistentThirdPartyId
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidGenInfoValues
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidSegmentationValues

    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidDates

    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidBankDetails
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorRefNumberDuplicate
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorRefNumberNonExistent
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidAddress
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidContactInfo
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidOtherInfo
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidBusCatIndTypePair
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidOtherNames

    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorInvalidCountryRegionPair

    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorDuplicateOtherName
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorIncompleteBankDtls

    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorExceedMaxNumBankDtls
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorExceedMaxNumPhones
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorExceedMaxNumWebsites
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorExceedMaxNumFaxes
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorExceedMaxNumOtherNames
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorExceedMaxLength










    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadDELETEThirdPartySuccess
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadDELETEThirdParty5Success
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadDELETEThirdParty10Success
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadDELETEThirdParty3Error2Success
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadDELETEThirdPartyErrorInvalidId
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadDELETEThirdPartyErrorInvalidActionType
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadDELETEThirdPartyErrorMissingFields
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadDELETEThirdPartyErrorInvalidRefNo

###    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceThirdPartyBulkUploadADDThirdPartyMultipleActionsSuccess


