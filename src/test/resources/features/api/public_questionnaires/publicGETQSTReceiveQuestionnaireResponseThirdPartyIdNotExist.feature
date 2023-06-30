@api @public_api @postPublicQSTReceiveQuestionnaireResponseThirdPartyIdNotExist
Feature: Receive Questionnaire Response Third Party Id Doest Not Exist

  Background:
    * def xTenantCode = tenant
    * def nextPageToken = ''

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


  Scenario: C40181686 : [QST API] Receive Questionnaire Response - Third-party ID doesn't exist
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

  * def assignmentId = get response.data.questionnaires[0].assignmentId
  * def language = get response.data.questionnaires[0].languages[0]
    And match thirdPartyIdNew == get response.data.id

    And print '******** assignmentId         = '+ assignmentId
    And print '******** language         = '+ language

    # Retrieve Questionnaire Details by Questionnaire Assignment ID
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdNew, 'questionnaires', assignmentId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And param language = language
    When method GET
    Then status 200

    * def tabId = get response.data.tabs[0].tabId
    * def questionId = get response.data.tabs[0].questions[0].questionId
    * def optionId = get response.data.tabs[0].questions[0].options[0].optionId
    And match assignmentId == get response.data.assignmentId

    And print '******** tabId         = '+ tabId
    And print '******** questionId         = '+ questionId
    And print '******** optionId         = '+ optionId

    * def newPostReceiveQSTResponse =
        """
          [
            {
              "tabId": "#(tabId)",
              "questions":
              [
                {
                  "questionId": "#(questionId)",
                  "answers": ["#(optionId)"]
                }
              ]
           }
          ]
        """

    * configure logPrettyResponse = true

    Given url postUrl = baseTestUrl
    And path 'thirdparty', 'invalid', 'questionnaires', assignmentId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And param language = language
    And request newPostReceiveQSTResponse
    When method POST
    Then status 404

