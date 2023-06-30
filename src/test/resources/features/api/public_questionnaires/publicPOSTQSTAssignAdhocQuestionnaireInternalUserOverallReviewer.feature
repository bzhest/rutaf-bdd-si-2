@api @public_api @postPublicQSTAssignAdhocQuestionnaireInternalUserOverallReviewer
Feature: Post Assign Adhoc Questionnaire Internal User as Overall Reviewer

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
         "questionnaireNames": ["SAMPLE AUTO QUESTIONNAIRE"],
         "questionnaireType": "INTERNAL",
         "initiatedBy": "rddcentre.admin.np@refinitiv.com"
          }
        """

    * configure logPrettyResponse = true


  Scenario: C39241078 : Public API - POST /thirdparty/{id}/assign-questionnaire - Assign Adhoc Questionnaire - Select Internal User as Overall Reviewer
    Given url postUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdNew, 'assign-questionnaire'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header RequestorEmail = requestorEmail
    And request newPostAssignQST
    When method POST
    Then status 200



