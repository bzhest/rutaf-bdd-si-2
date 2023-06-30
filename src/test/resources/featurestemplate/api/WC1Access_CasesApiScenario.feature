
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





    Given Run API Tests with custom hooks features:[wcaccess],tags:@getCasesCaseReferenceByCaseId
    Given Run API Tests with custom hooks features:[wcaccess],tags:@getCasesCaseIdentifierByCaseId
    Given Run API Tests with custom hooks features:[wcaccess],tags:@getCasesCaseByCaseSystemId
    Given Run API Tests with custom hooks features:[wcaccess],tags:@getCasesCaseResultResolutionStatistics
    Given Run API Tests with custom hooks features:[wcaccess],tags:@getCasesCaseScreeningResultByCaseSystemIdAndResultId
    Given Run API Tests with custom hooks features:[wcaccess],tags:@getCasesCaseResultCommentsByResultId

    Given Run API Tests with custom hooks features:[wcaccess],tags:@postCreateCase
    Given Run API Tests with custom hooks features:[wcaccess],tags:@postCreateCaseWAsyncScreening
    Given Run API Tests with custom hooks features:[wcaccess],tags:@postCreateCaseWSyncScreening
    Given Run API Tests with custom hooks features:[wcaccess],tags:@postCaseRetrieveCaseScreeningResultByCaseSystemId

    Given Run API Tests with custom hooks features:[wcaccess],tags:@putCasesAssignCaseToUserId
    Given Run API Tests with custom hooks features:[wcaccess],tags:@putCasesUpdateCaseByCaseSystemId
    Given Run API Tests with custom hooks features:[wcaccess],tags:@putCasesResolveResultsForCaseSystemId
    Given Run API Tests with custom hooks features:[wcaccess],tags:@putCasesArchiveCaseByCaseSystemId

    Given Run API Tests with custom hooks features:[wcaccess],tags:@deleteCasesUnarchiveCaseByCaseSystemId
    Given Run API Tests with custom hooks features:[wcaccess],tags:@deleteCasesUnassignCaseByCaseSystemId

    Given Run API Tests with custom hooks features:[wcaccess],tags:@putCasesArchiveCaseByCaseSystemId
    Given Run API Tests with custom hooks features:[wcaccess],tags:@deleteCasesDeleteCaseByCaseSystemId

    Given Run API Tests with custom hooks features:[wcaccess],tags:@postDelegateReviewByCaseSystemIdAndResultId
    Given Run API Tests with custom hooks features:[wcaccess],tags:@deleteDelegateReviewByCaseSystemIdAndResultId

    Given Run API Tests with custom hooks features:[wcaccess],tags:@postFilterCaseAuditEventsByCaseSystemId
    Given Run API Tests with custom hooks features:[wcaccess],tags:@postMonitorUserActivity
    Given Run API Tests with custom hooks features:[wcaccess],tags:@postRetrieveStatusOfMultipleCases
    Given Run API Tests with custom hooks features:[wcaccess],tags:@postCreateCaseResultComments
    Given Run API Tests with custom hooks features:[wcaccess],tags:@postCreateCaseResultCommentsInBulk

    Given Run API Tests with custom hooks features:[wcaccess],tags:@putCasesCreateCaseResultComment

# Error
#    Given Run API Tests with custom hooks features:[wcaccess],tags:@patchReplaceUpdatedUpdateIndicatorOfCaseResult
#

    # Error? Any caseSystemId accepted
    Given Run API Tests with custom hooks features:[wcaccess],tags:@deleteCasesArchiveAndDeleteCaseInBulk
    #

    Given Run API Tests with custom hooks features:[wcaccess],tags:@postCreateMultipleCasesSaveAndScreen


