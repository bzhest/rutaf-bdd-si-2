@api @public_api @postPublicQSTReAssignAdhocQuestionnaireExternalQSTToInternalUser
Feature: Post ReAssign Adhoc Questionnaire External QST To Internal User

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
         "overallReviewer": "",
         "questionnaireNames": ["SAMPLE AUTO QUESTIONNAIRE - EXTERNAL"],
         "questionnaireType": "EXTERNAL",
         "initiatedBy": "rddcentre.admin.np@refinitiv.com"
          }
        """

    * configure logPrettyResponse = true


  Scenario: C39241095 : Public API -POST /thirdparty/{id}/reassign-questionnaire-assignment-activity - Verify error if if External Questionnaire is reassigned to Internal User
     # Assign Questionnaire
    Given url postUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdNew, 'assign-questionnaire'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header RequestorEmail = requestorEmail
    And request newPostAssignQST
    When method POST
    Then status 200

    # Retrieve Questionnaire Assignment List by Third-party ID
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdNew, 'questionnaires'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def activityId = get response.data.questionnaires[0].activityId
    And match thirdPartyIdNew == get response.data.id

    And print '******** activityId         = '+ activityId

    * def newPostReAssignQST =
        """
          {
          "activityId": "#(activityId)",
          "email": "rddcentre.admin.np@refinitiv.com"
          }
        """

    * configure logPrettyResponse = true

    # Reassign Adhoc Questionnaire
    Given url postUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdNew, 'reassign-questionnaire-assignment-activity'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request newPostReAssignQST
    When method POST
    Then status 400




