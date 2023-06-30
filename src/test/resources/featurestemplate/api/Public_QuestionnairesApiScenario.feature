
#@apidemo
@api
Feature: A Generic feature file to run all API features or single feature file or feature file under a specific folder

  Scenario: Run all or single API Scenario

    # Questionnaire List
    #C39176280
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@getPublicQSTRetrieveQuestionnaireList
    #C40180915
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@getPublicQSTRetrieveQuestionnaireListVerifyPagination
    #C40180916
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@getPublicQSTRetrieveQuestionnaireListSpecificFields
    #C40181896
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@getPublicQSTRetrieveQuestionnaireListVerifyInvalidValue

    # Questionnaire Assignment List
    #C39176281
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@getPublicQSTRetrieveQuestionnaireAssignmentList
    #C39215984
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@getPublicQSTRetrieveQuestionnaireAssignmentListVerifyThirdParty

    # Questionnaire Details
    #C40449218
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@getPublicQSTRetrieveQuestionnaireAssignmentDetails
    #C39176282
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@getPublicQSTRetrieveQuestionnaireAssignmentDetailsWithoutReviewer
    #C39215945
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@getPublicQSTRetrieveQuestionnaireAssignmentDetailsSpecificLanguage
    #C39215947
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@getPublicQSTRetrieveQuestionnaireAssignmentDetailsVerifyInvalidQSTAssignmentID
    #C39215948
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@getPublicQSTRetrieveQuestionnaireAssignmentDetailsVerifyInvalidLanguage

    # Assign Questionnaire
    #C39241074
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTAssignAdhocQuestionnaire
    #C39241075
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTAssignAdhocQuestionnaireExternalUser
    #C39241076
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTAssignAdhocQuestionnaireMultiQSTInternalUser
    #C39241077
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTAssignAdhocQuestionnaireMultiQSTExternalUser
    #C39241078
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTAssignAdhocQuestionnaireInternalUserOverallReviewer
    #C39241080
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTAssignAdhocQuestionnaireThirdPartyIDNotExist
    #C39241082
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTAssignAdhocQuestionnaireInvalidValues
    #C39241083
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTAssignAdhocQuestionnaireIncorrectDueDate
    #C39241084
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTAssignAdhocQuestionnaireQSTAlreadyAssigned
    #C39241085
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTAssignAdhocQuestionnaireInternalQSTToExternalUser
    #C39241086
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTAssignAdhocQuestionnaireExternalQSTToInternalUser
    #C41030851
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTAssignAdhocQuestionnaireWithCaseInsensitiveInternal
    #C41031002
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTAssignAdhocQuestionnaireWithCaseInsensitiveExternal
    #C41032242
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTAssignAdhocQuestionnaireMultiQSTInternalUserWithCaseInsensitive
    #C41033392
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTAssignAdhocQuestionnaireMultiQSTExternalUserWithCaseInsensitive

    # ReAssign Questionnaire
    #C39241087
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReAssignAdhocQuestionnaireInternal
    #C39241091
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReAssignAdhocQuestionnaireInvalidValues
    #C39241092
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReAssignAdhocQuestionnaireBlankFields
    #C39241094
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReAssignAdhocQuestionnaireInternalQSTToExternalUser
    #C39241095
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReAssignAdhocQuestionnaireExternalQSTToInternalUser

#    # Receive Questionnaire Response
    #C40181686
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReceiveQuestionnaireResponseThirdPartyIdNotExist
    #C40181689
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReceiveQuestionnaireResponseAssignmentIdNotExist
    #C40181690
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReceiveQuestionnaireResponseQuestionIdNotExist
    #C40181695
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReceiveQuestionnaireResponseLanguageNotExist
    #C40181696
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReceiveQuestionnaireResponseBooleanValidation
    #C40181699
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReceiveQuestionnaireResponseCheckBoxValidation
    #C40181700
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReceiveQuestionnaireResponseCurrencyValidation
    #C40181701
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReceiveQuestionnaireResponseDateValidation
    #C40181730
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReceiveQuestionnaireResponseNumbersValidation
    #C40181731
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReceiveQuestionnaireResponseTextValidation

    # Receive Bulk Questionnaire Response Attachment
    #C40231167
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReceiveBulkQuestionnaireResponseAttachmentThirdPartyNotExist