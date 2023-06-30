@ignore
Feature: REUSABLE - Retrieve Third-Party List for Today



  Background:
#    * def baseTestUrl =        'https://api.qa-sprint2.supplierintegrity.com'
    * def xTenantCode =        tenant
    * def invalidXTenantCode = 'xxx'
    * def eTag =               ''
    * configure retry =        { count: 40, interval: 3000 }

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in



  Scenario: Retrieve third-party list for today

#    * def thirdPartyIdRETRIEVE = thirdPartyId
    * def pageSize =             pageSize
    * def start =                start
    * def end =                  end

    And print '\n'
    And print '================================'
    And print '******** RETRIEVE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** baseTestUrl          = '+ baseTestUrl
    And print '******** xTenantCode          = '+ xTenantCode
    And print '******** isSwaggerDirect      = '+ isSwaggerDirect
    And print '******** pageSize             = '+ pageSize
    And print '******** start                = '+ start
    And print '******** end                  = '+ end
    And print '================================\n'
    And print '\n'


#
# RETRIEVE third-party LIST for this day
#

    Given url getUrl = baseTestUrl
    And path 'thirdparty'
    And param pageSize =       pageSize
    And param start =          start
    And param end =            end
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

