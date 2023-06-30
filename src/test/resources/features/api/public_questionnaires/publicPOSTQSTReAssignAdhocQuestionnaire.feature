@api @public_api @postPublicQSTReAssignAdhocQuestionnaire
Feature: Post ReAssign Adhoc Questionnaire

  As a user
  I would like to verify Post ReAssign Adhoc Questionnaire test script
  So that I can ReAssign Adhoc Questionnaire

  Background:
    * def xTenantCode = tenant

    * def fileA = call read('publicPOSTThirdPartyCreateThirdPartySingle.feature')
    * def thirdPartyId = fileA.response.data.id
    * print thirdPartyId

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


  Scenario:
     # Assign Questionnaire
    Given url postUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId, 'assign-questionnaire'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header RequestorEmail = requestorEmail
    And request newPostAssignQST
    When method POST
    Then status 200

    # Retrieve Questionnaire Assignment List by Third-party ID
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId, 'questionnaires'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def activityId = get response.data.questionnaires[0].activityId
    And match thirdPartyId == get response.data.id

    And print '******** activityId         = '+ activityId

    * def newPostReAssignQST =
        """
          {
          "activityId": "#(activityId)",
          "email": "jarmel.fuentes@refinitiv.com"
          }
        """

    * configure logPrettyResponse = true

    # Reassign Adhoc Questionnaire
    Given url postUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId, 'reassign-questionnaire-assignment-activity'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request newPostReAssignQST
    When method POST
    Then status 200




