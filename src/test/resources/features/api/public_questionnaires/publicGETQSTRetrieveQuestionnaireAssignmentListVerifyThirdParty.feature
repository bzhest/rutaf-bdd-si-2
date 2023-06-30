@api @public_api @getPublicQSTRetrieveQuestionnaireAssignmentListVerifyThirdParty
Feature: Get Questionnaire Assignment List

  Background:
    * def xTenantCode = tenant
    * def nextPageToken = ''
    * def thirdPartyId = 'id'

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in

  Scenario: C39215984 : Public API - GET/thirdparty/{id}/questionnaires - Verify error if Third-party does not exist
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId, 'questionnaires'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 404