@api @public_api @postPublicQSTAssignAdhocQuestionnaireExternalUser
Feature: Post Assign Adhoc Questionnaire

  As a user
  I would like to verify Post Assign Adhoc Questionnaire test script
  So that I can Assign Adhoc Questionnaire

  Background:
    * def xTenantCode = tenant

    * def fileA = call read('publicPOSTThirdPartyContactsCreateContact.feature')
    * def thirdPartyIdNew = fileA.response.data.parent
    * def externalEmail = fileA.response.data.contactInformation.email[0]
    * print thirdPartyIdNew

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in


    * def newPostAssignQST =
        """
          {
         "assignee": "#(externalEmail)",
         "dueDate": "2022-10-30",
         "overallReviewer": "rddcentre.admin.np@refinitiv.com",
         "questionnaireNames": ["SAMPLE AUTO QUESTIONNAIRE - EXTERNAL"],
         "questionnaireType": "EXTERNAL",
         "initiatedBy": "rddcentre.admin.np@refinitiv.com"
          }
        """

    * configure logPrettyResponse = true


  Scenario: C39241075 : Public API - POST /thirdparty/{id}/assign-questionnaire - Assign Single Questionnaire to External User
    Given url postUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdNew, 'assign-questionnaire'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header RequestorEmail = requestorEmail
    And request newPostAssignQST
    When method POST
    Then status 200


    # DELETE third-party by id
#    Given url deleteUrl = baseTestUrl
#    And path 'thirdparty', thirdPartyIdNew
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method DELETE
#    Then status 204



