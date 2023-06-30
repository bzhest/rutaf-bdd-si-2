@api @public_api @postPublicQSTReceiveQuestionnaireResponseNumbersValidation
Feature: Receive Questionnaire Response

  Background:
    * def xTenantCode = tenant
    * def nextPageToken = ''

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
         "questionnaireNames": ["SAMPLE AUTO QUESTIONNAIRE 2"],
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

  * def assignmentId = get response.data.questionnaires[0].assignmentId
  * def language = get response.data.questionnaires[0].languages[0]
    And match thirdPartyId == get response.data.id

    And print '******** assignmentId         = '+ assignmentId
    And print '******** language         = '+ language

    # Retrieve Questionnaire Details by Questionnaire Assignment ID
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId, 'questionnaires', assignmentId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And param language = language
    When method GET
    Then status 200

    * def tabId = get response.data.tabs[0].tabId
    * def questionId = get response.data.tabs[0].questions[4].questionId
    And match assignmentId == get response.data.assignmentId

    And print '******** tabId         = '+ tabId
    And print '******** questionId         = '+ questionId

    * def newPostReceiveQSTResponse =
        """
          [
            {
              "tabId": "#(tabId)",
              "questions":
              [
                {
                  "questionId": "#(questionId)",
                  "answers": 'invalid'
                }
              ]
           }
          ]
        """

    * configure logPrettyResponse = true

    Given url postUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId, 'questionnaires', assignmentId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And param language = language
    And request newPostReceiveQSTResponse
    When method POST
    Then status 400

