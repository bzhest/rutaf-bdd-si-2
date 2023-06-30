
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





#    Given Run API Tests with custom hooks features:[public_contacts],tags:@postPublicContactsCreateContact



    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceContactBulkUploadADDContactSuccessValid1
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceContactBulkUploadADDContactSuccessAutoScreenNo
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceContactBulkUploadADDContactErrorInvalidThirdPartyId
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceContactBulkUploadADDContactErrorInvalidFileFormat
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceContactBulkUploadADDContactErrorMissingReqdFields
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceContactBulkUploadADDContactErrorInvalidActionType

###    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceContactBulkUploadADDContactErrorInvalidFileType               # FAIL: Should not allow .doc
###    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceContactBulkUploadADDContactErrorDuplicateEmailSameThirdParty  # FAIL: Should fail
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceContactBulkUploadADDContactErrorDuplicateEmailSameThirdParty
    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceContactBulkUploadADDContactErrorDuplicateEmailDiffThirdParty

    Given Run API Tests with custom hooks features:[public_selfservice],tags:@postPublicSelfServiceContactBulkUploadADDContactErrorExceedMaxLength

