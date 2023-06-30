@api @public_api @getPublicQSTRetrieveQuestionnaireListSpecificFields
Feature: Get Questionnaire List

  Background:
    * def xTenantCode = tenant
    * def nextPageToken = ''

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in

  Scenario: C40180916 : Public API - GET/questionnaires - Verify that only specific fields are displayed when fields parameter is populated
    Given url getUrl = baseTestUrl
    And path 'questionnaires'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And param pageSize = 10
    And param fields = 'data.id'
    When method GET
    Then status 200

    Given url getUrl = baseTestUrl
    And path 'questionnaires'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And param pageSize = 10
    And param fields = 'data.name, data.type'
    When method GET
    Then status 200