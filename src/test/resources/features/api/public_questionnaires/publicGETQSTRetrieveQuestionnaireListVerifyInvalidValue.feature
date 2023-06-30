@api @public_api @getPublicQSTRetrieveQuestionnaireListVerifyInvalidValue
Feature: Get Questionnaire List

  Background:
    * def xTenantCode = tenant
    * def nextPageToken = ''

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in

  Scenario: C40181896 - Public API - GET/questionnaires - Verify error message for invalid value
    Given url getUrl = baseTestUrl
    And path 'questionnaires'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And param pageSize = 'invalid'
    When method GET
    Then status 400

    Given url getUrl = baseTestUrl
    And path 'questionnaires'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And param pageSize = 10
    And param pageToken = 'invalid'
    When method GET
    Then status 400

    Given url getUrl = baseTestUrl
    And path 'questionnaires'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And param pageSize = 10
    And param fields = 'invalid'
    And param orderBy = 'invalid'
    When method GET
    Then status 200