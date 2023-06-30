
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



    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicThirdPartyRetrieveThirdPartyList
    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicThirdPartyRetrieveThirdPartyById
    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@postPublicThirdPartyCreateThirdParty
    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@patchPublicThirdPartyUpdateThirdParty
    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@deletePublicThirdPartyDeleteThirdParty

    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicThirdPartyRetrieveThirdPartyWithStatusChangeList
    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicThirdPartyRetrieveThirdPartyWithScreeningStatusChangeList

    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@postPublicThirdPartyCreateBulkThirdParty

    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@postPublicThirdPartyBulkAttachFiles





##   Given Run API Tests with custom hooks features:[public_thirdparty],tags:@postPublicThirdPartyCreateThirdPartyTestEmptyStringToDBNull
##   Given Run API Tests with custom hooks features:[public_thirdparty],tags:@postPublicCreateThirdParty





    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicThirdPartyRetrieveAllThirdPartyOffsetList
    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicThirdPartyRetrieveSameDivThirdPartyOffsetList
    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicThirdPartyRetrieveAllThirdPartyOffsetListSortByName
    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicThirdPartyRetrieveAllThirdPartyOffsetListSortByIndType
    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicThirdPartyRetrieveAllThirdPartyOffsetListSortByCountry
    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicThirdPartyRetrieveAllThirdPartyOffsetListSortByStatus
    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicThirdPartyRetrieveAllThirdPartyOffsetListSortByRiskTier

    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicThirdPartyRelatedFilesRetrieveThirdPartyRelatedFiles

    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicUsersRetrieveAllUsersOffsetList
    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicUsersRetrieveActiveUsersOffsetList
    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicUsersRetrieveInactiveUsersOffsetList

    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicThirdPartyContactsRetrieveAllContactsOffsetList
    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicThirdPartyContactsRetrieveRecentContactsOffsetList
    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicThirdPartyContactsRetrieveNoContactsOffsetList
    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicThirdPartyContactsRetrieveAllContactsOffsetListInvThirdPartyId
    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicThirdPartyContactsRetrieveAllContactsOffsetListRelSearchByName
    Given Run API Tests with custom hooks features:[public_thirdparty],tags:@getPublicThirdPartyContactsRetrieveAllContactsOffsetListSpecFields


