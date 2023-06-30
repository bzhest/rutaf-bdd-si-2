@api @public_api @getPublicQSTRetrieveQuestionnaireList
Feature: Get Questionnaire List

  Background:
    * def xTenantCode = tenant
    * def nextPageToken = ''

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in

  Scenario: C39176280 : Public API - GET/questionnaires - Retrieve Questionnaire List
    Given url getUrl = baseTestUrl
    And path 'questionnaires'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And param pageSize = 10
    When method GET
    Then status 200