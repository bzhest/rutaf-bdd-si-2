@api @public_api @postPublicQSTAssignAdhocQuestionnaireInvalidValues
Feature: Post Assign Adhoc Questionnaire Invalid Values

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
         "assignee": "invalid",
         "dueDate": "2022-10-30",
         "overallReviewer": "invalid",
         "questionnaireNames": ["invalid"],
         "questionnaireType": "invalid",
         "initiatedBy": "invalid"
          }
        """

    * configure logPrettyResponse = true


  Scenario: C39241082 : Public API - POST /thirdparty/{id}/assign-questionnaire - Verify error for Invalid values
    Given url postUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdNew, 'assign-questionnaire'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header RequestorEmail = requestorEmail
    And request newPostAssignQST
    When method POST
    Then status 400



