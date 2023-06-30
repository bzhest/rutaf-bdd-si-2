
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

    #Run specific feature files under siconnect by adding tags
#    Given Run API Tests with custom hooks features:[siconnect],tags:@getContact
#    Given Run API Tests with custom hooks features:[siconnect],tags:@getSupplier
#    Given Run API Tests with custom hooks features:[siconnect],tags:@patchContacts
#    Given Run API Tests with custom hooks features:[siconnect],tags:@patchSupplier
#    Given Run API Tests with custom hooks features:[siconnect],tags:@postCases
#    Given Run API Tests with custom hooks features:[siconnect],tags:@putCases





    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrieveOnboardingVolume
    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrievePartnerVolume
    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrieveOnboardingMatrix
    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrieveOnboardingCycleTime

    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrieveRenewalVolume
    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrievePendingRenewalVolume
    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrieveRenewalMatrix
    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrieveRenewalCycleTime

    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrieveActiveOrder
    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrieveActivitiesToApprove
    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrieveActivitiesToReview
    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrieveAssignedActivities
    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrieveOrderForApproval
    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrieveQuestionnaireToReview
    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrieveScreeningResultsToReview
    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrieveSuppliersForRenewal

    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrieveActivityCount
    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrieveActivityMatrix
    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrieveDueDiligenceCount
    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrieveQuestionnaireCount

    Given Run API Tests with custom hooks features:[dashboard],tags:@getRetrieveAnalyticsAuditLastUpdated
