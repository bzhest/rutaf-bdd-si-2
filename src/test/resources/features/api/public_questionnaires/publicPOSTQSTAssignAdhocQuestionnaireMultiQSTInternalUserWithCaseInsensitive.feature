@api @public_api @postPublicQSTAssignAdhocQuestionnaireMultiQSTInternalUserWithCaseInsensitive
Feature: Post Assign Adhoc Questionnaire Multi QST Internal User with Case Insensitive

  As a user
  I would like to verify Post Assign Adhoc Questionnaire test script
  So that I can Assign Adhoc Questionnaire

  Background:
    * def xTenantCode = tenant

    * def fileA = call read('publicPOSTThirdPartyCreateThirdPartySingle.feature')
    * def thirdPartyIdNew = fileA.response.data.id
    * print thirdPartyIdNew

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in


    * def newPostAssignQST =
        """
          {
         "assignee": "rddcentre.admin.np@refinitiv.com",
         "dueDate": "2022-10-30",
         "overallReviewer": "rddcentre.admin.np@refinitiv.com",
         "questionnaireNames": ["sample auto questionnaire", "sample auto questionnaire 2", "sample auto questionnaire 3"],
         "questionnaireType": "INTERNAL",
         "initiatedBy": "rddcentre.admin.np@refinitiv.com"
          }
        """

    * configure logPrettyResponse = true


  Scenario: C41032242 : Public API - POST /thirdparty/{id}/assign-questionnaire - Assign Multiple Questionnaire (Internal) with case insensitive Questionnaire Name
    Given url postUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdNew, 'assign-questionnaire'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header RequestorEmail = requestorEmail
    And request newPostAssignQST
    When method POST
    Then status 200



