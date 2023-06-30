
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




    Given Run API Tests with custom hooks features:[public_references],tags:@getPublicReferencesAllAffiliationTypes
    Given Run API Tests with custom hooks features:[public_references],tags:@getPublicReferencesAllBusinessTypes
    Given Run API Tests with custom hooks features:[public_references],tags:@getPublicReferencesAllCommodityTypes
    Given Run API Tests with custom hooks features:[public_references],tags:@getPublicReferencesAllCompanyTypes
    Given Run API Tests with custom hooks features:[public_references],tags:@getPublicReferencesAllCountries
    Given Run API Tests with custom hooks features:[public_references],tags:@getPublicReferencesAllCurrencies
    Given Run API Tests with custom hooks features:[public_references],tags:@getPublicReferencesAllCustomFields
    Given Run API Tests with custom hooks features:[public_references],tags:@getPublicReferencesAllIndustryTypes
    Given Run API Tests with custom hooks features:[public_references],tags:@getPublicReferencesAllOrganizationSizes
    Given Run API Tests with custom hooks features:[public_references],tags:@getPublicReferencesAllOtherNameTypes
    Given Run API Tests with custom hooks features:[public_references],tags:@getPublicReferencesAllProductDesignAgreements
    Given Run API Tests with custom hooks features:[public_references],tags:@getPublicReferencesAllProductImpactTypes
    Given Run API Tests with custom hooks features:[public_references],tags:@getPublicReferencesAllRegions
    Given Run API Tests with custom hooks features:[public_references],tags:@getPublicReferencesAllRelationshipVisibilityTypes
    Given Run API Tests with custom hooks features:[public_references],tags:@getPublicReferencesAllRevenueTypes
    Given Run API Tests with custom hooks features:[public_references],tags:@getPublicReferencesAllSourcingMethods
    Given Run API Tests with custom hooks features:[public_references],tags:@getPublicReferencesAllSourcingTypes
    Given Run API Tests with custom hooks features:[public_references],tags:@getPublicReferencesAllSpendCategories
