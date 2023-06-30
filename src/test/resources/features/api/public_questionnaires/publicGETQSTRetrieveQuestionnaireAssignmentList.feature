@api @public_api @getPublicQSTRetrieveQuestionnaireAssignmentList
Feature: Get Questionnaire Assignment List

  Background:
    * def xTenantCode = tenant
    * def nextPageToken = ''

    * def fileA = call read('publicPOSTThirdPartyCreateThirdPartySingle.feature')
    * def thirdPartyIdNew = fileA.response.data.id
    * print thirdPartyIdNew

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in

  Scenario: C39176281 : Public API - GET/thirdparty/{id}/questionnaires - Retrieve Questionnaire Assignment List by Third-party ID
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdNew, 'questionnaires'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200