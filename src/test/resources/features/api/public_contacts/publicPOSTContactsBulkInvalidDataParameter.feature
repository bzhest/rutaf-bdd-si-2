@api @public_api @postContactBulkInvalidDataParameter
Feature: Post Contacts Bulk

  As a user
  I would like to verify Post Contacts Bulk test script
  So that I can create bulk contacts

  Background:
    * def urlPath = '/contacts/bulk'
    * def xTenantCode = 'qa-sprint2'



    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in

    * configure logPrettyResponse = true


  Scenario: C36333419 : Public API - POST /contacts/bulk - Verify error for invalid values in data parameter

    * def newPostRequestBodyForInvalidDataParameter =
        """
          [
           "TEST123"
          ]
        """

    Given url postUrl = baseTestUrl
    And path urlPath
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request newPostRequestBodyForInvalidDataParameter
    When method POST
    Then status 400




