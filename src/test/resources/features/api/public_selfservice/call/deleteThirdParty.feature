@ignore
Feature: REUSABLE - Delete Third-Party by Id



  Background:
#    * def baseTestUrl =        'https://api.qa-sprint2.supplierintegrity.com'
    * def xTenantCode =        tenant
    * def invalidXTenantCode = 'xxx'
    * def eTag =               ''
    * configure retry =        { count: 40, interval: 3000 }

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in



  Scenario: Delete third-party by id

    * def thirdPartyIdDELETE = thirdPartyId

    And print '\n'
    And print '================================'
    And print '******** DELETE THIRD-PARTY: DELETE THIRD-PARTY LIST'
    And print '******** baseTestUrl        = '+ baseTestUrl
    And print '******** xTenantCode        = '+ xTenantCode
    And print '******** isSwaggerDirect    = '+ isSwaggerDirect
    And print '******** thirdPartyIdDELETE = '+ thirdPartyIdDELETE
    And print '================================\n'
    And print '\n'


#
# DELETE third-party by id
#

    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdDELETE
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204


#
# CHECK: Retrieve third-party BY ID - expected: NOT FOUND
#

    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdDELETE
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 404


#
# CHECK: Get third-parties LIST for this day - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty'
    And param pageSize =       100
    And param start =          nowStartISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def thirdPartyIdsACTIVE = get response.data[*].id
    And assert !thirdPartyIdsACTIVE.contains( thirdPartyIdDELETE )

    * def count = response.data.length

    And print '\n'
    And print '================================'
    And print '******** DELETE THIRD-PARTY: DELETE THIRD-PARTY LIST'
    And print '******** COUNT: data.length  = '+ count
    And print '******** thirdPartyIdDELETE  = '+ thirdPartyIdDELETE
    And print '******** thirdPartyIdsACTIVE = '+ thirdPartyIdsACTIVE
    And print '================================\n'
    And print '\n'
