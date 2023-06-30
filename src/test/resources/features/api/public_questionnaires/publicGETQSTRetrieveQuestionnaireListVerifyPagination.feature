@api @public_api @getPublicQSTRetrieveQuestionnaireListVerifyPagination
Feature: Get Questionnaire List

  Background:
    * def xTenantCode = tenant
    * def nextPageToken = ''

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in

  Scenario: C40180915 - Public API - GET/questionnaires - Verify pagination
    Given url getUrl = baseTestUrl
    And path 'questionnaires'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And param pageSize = 10
    When method GET
    Then status 200

    * def nextPageToken = get response.meta.nextPageToken
    And print '******** nextPageToken         = '+ nextPageToken

    Given url getUrl = baseTestUrl
    And path 'questionnaires'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And param pageSize = 25
    And param pageToken = nextPageToken
    When method GET
    Then status 200

    * def nextPageToken2 = get response.meta.nextPageToken
    And print '******** nextPageToken2         = '+ nextPageToken2

    Given url getUrl = baseTestUrl
    And path 'questionnaires'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And param pageSize = 50
    And param pageToken = nextPageToken2
    When method GET
    Then status 200