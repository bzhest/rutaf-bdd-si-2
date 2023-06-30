@api @public_api @postPublicQSTReceiveBulkQuestionnaireResponse
Feature: Receive Bulk Questionnaire Response

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

    * def tabId0 = get response.data.tabs[0].tabId
    * def questionId0 = get response.data.tabs[0].questions[0].questionId
    * def optionId0 = get response.data.tabs[0].questions[0].options[0].optionId

    * def tabId = get response.data.tabs[1].tabId
    * def questionId = get response.data.tabs[1].questions[0].questionId
    * def optionId = get response.data.tabs[1].questions[0].options[0].optionId

    * def tabId2 = get response.data.tabs[2].tabId
    * def questionId2 = get response.data.tabs[2].questions[0].questionId
    * def optionId2 = get response.data.tabs[2].questions[0].options[0].optionId
    And match assignmentId == get response.data.assignmentId

    And print '******** tabId0         = '+ tabId0
    And print '******** questionId0         = '+ questionId0
    And print '******** optionId0         = '+ optionId0

    And print '******** tabId         = '+ tabId
    And print '******** questionId         = '+ questionId
    And print '******** optionId         = '+ optionId

    And print '******** tabId2         = '+ tabId2
    And print '******** questionId2         = '+ questionId2
    And print '******** optionId2         = '+ optionId2


    * def newPostReceiveQSTResponse =
        """
        [{
            "assignmentId": "#(assignmentId)",
            "language": "#(language)",
            "tabs": [{
                "tabId": "#(tabId0)",
                "questions": [{
                    "questionId": "#(questionId0)",
                    "answers": ["#(optionId0)"]
                }]
            }, {
                "tabId": "#(tabId)",
                "questions": [{
                    "questionId": "#(questionId)",
                    "answers": ["#(optionId)"]
                }]
            }, {
                "tabId": "#(tabId2)",
                "questions": [{
                    "questionId": "#(questionId2)",
                    "answers": ["#(optionId2)"]
                }]
            }]

        }]
        """

    * configure logPrettyResponse = true

    Given url postUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId, 'questionnaires'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request newPostReceiveQSTResponse
    When method POST
    Then status 207

