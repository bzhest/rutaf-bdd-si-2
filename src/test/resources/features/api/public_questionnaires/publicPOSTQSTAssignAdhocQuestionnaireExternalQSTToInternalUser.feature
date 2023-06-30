@api @public_api @postPublicQSTAssignAdhocQuestionnaireExternalQSTToInternalUser
Feature: Post Assign Adhoc Questionnaire

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
         "overallReviewer": "",
         "questionnaireNames": ["SAMPLE AUTO QUESTIONNAIRE"],
         "questionnaireType": "EXTERNAL",
         "initiatedBy": "rddcentre.admin.np@refinitiv.com"
          }
        """

    * configure logPrettyResponse = true


  Scenario: C39241086 : Public API - POST /thirdparty/{id}/assign-questionnaire - Verify error if External Questionnaire is assigned to Internal user
    Given url postUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdNew, 'assign-questionnaire'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header RequestorEmail = requestorEmail
    And request newPostAssignQST
    When method POST
    Then status 400



