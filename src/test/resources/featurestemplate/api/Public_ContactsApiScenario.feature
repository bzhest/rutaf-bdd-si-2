
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



    Given Run API Tests with custom hooks features:[public_contacts],tags:@getPublicContactsRetrieveSupplierContacts
    Given Run API Tests with custom hooks features:[public_contacts],tags:@getPublicContactsRetrieveSupplierContactById
    Given Run API Tests with custom hooks features:[public_contacts],tags:@postPublicContactsCreateContact
    Given Run API Tests with custom hooks features:[public_contacts],tags:@patchPublicContactsUpdateContact
    Given Run API Tests with custom hooks features:[public_contacts],tags:@deletePublicContactsDeleteContact

    Given Run API Tests with custom hooks features:[public_contacts],tags:@postContactBulkCreate
    Given Run API Tests with custom hooks features:[public_contacts],tags:@postContactBulkElevenOtherNames
    Given Run API Tests with custom hooks features:[public_contacts],tags:@postContactBulkErrorRequireFields
    Given Run API Tests with custom hooks features:[public_contacts],tags:@postContactBulkExistingEmail
    Given Run API Tests with custom hooks features:[public_contacts],tags:@postContactBulkFalseAutoScreen
    Given Run API Tests with custom hooks features:[public_contacts],tags:@postContactBulkFiveAddresses
    Given Run API Tests with custom hooks features:[public_contacts],tags:@postContactBulkFiveContactInfo
    Given Run API Tests with custom hooks features:[public_contacts],tags:@postContactBulkInvalidDataParameter
    Given Run API Tests with custom hooks features:[public_contacts],tags:@postContactBulkInvalidFormat
    Given Run API Tests with custom hooks features:[public_contacts],tags:@postContactBulkMaxChar
    Given Run API Tests with custom hooks features:[public_contacts],tags:@postContactBulkSixAddresses
    Given Run API Tests with custom hooks features:[public_contacts],tags:@postContactBulkSixContactInfo
    Given Run API Tests with custom hooks features:[public_contacts],tags:@postContactBulkSupplierIdNotExist
    Given Run API Tests with custom hooks features:[public_contacts],tags:@postContactBulkTenOtherNames

