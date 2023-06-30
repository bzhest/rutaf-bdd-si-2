@ignore @deleteThirdPartyById
Feature: Delete Third-Party by Id



  Background:

  Scenario: Delete Third-Party by Id

    * def thirdPartyIdObj = { 'thirdPartyId': '#(thirdPartyId)' }

    * def thirdPartyId =    thirdPartyIdObj.thirdPartyId
    * print '================================'
    * print '******** thirdPartyId  = '+ thirdPartyId
    * print '================================'



#
# DELETE third-party by id
#
    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204

