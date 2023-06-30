
#@apidemo
@api
Feature: A Generic feature file to run all API features or single feature file or feature file under a specific folder

  Scenario: Run all or single API Scenario

    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@getPublicQSTRetrieveQuestionnaireList
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTAssignAdhocQuestionnaire
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@getPublicQSTRetrieveQuestionnaireAssignmentList
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@getPublicQSTRetrieveQuestionnaireAssignmentDetails
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReAssignAdhocQuestionnaire
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReceiveQuestionnaireResponse
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReceiveBulkQuestionnaireResponseAttachment
    Given Run API Tests with custom hooks features:[public_questionnaires],tags:@postPublicQSTReceiveBulkQuestionnaireResponse
