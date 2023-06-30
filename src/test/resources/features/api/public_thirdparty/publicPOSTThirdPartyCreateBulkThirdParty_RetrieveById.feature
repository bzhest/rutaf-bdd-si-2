@ignore @getThirdPartyById
Feature: Get Third-Party by Id



  Background:

  Scenario: Get Third-Party by Id

    * def thirdPartyIdObj = { 'thirdPartyId': '#(thirdPartyId)' }

    * def thirdPartyId =    thirdPartyIdObj.thirdPartyId
    * print '================================'
    * print '******** thirdPartyId  = '+ thirdPartyId
    * print '================================'



#
# RETRIEVE third-party BY ID
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

