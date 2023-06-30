@api @public_api @getPublicReferencesAllRegions
Feature: Get All Regions



  Background:
#    * def baseTestUrl = 'https://api.qa-sprint2.supplierintegrity.com'
    * def xTenantCode = tenant
    * def invalidXTenantCode = 'xxx'
    * def eTag = ''



    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in

    And print '\n'
    * print '================================'
    * print '******** baseTestUrl      = '+ baseTestUrl
    * print '******** accessToken      = '+ accessToken
    * print '******** accessTokenExp   = '+ accessTokenExp
    * print '================================'
    And print '\n'



  Scenario: 1) C36101565 RMS-5610 SIConnect Public API V2
               - Get Region & Country List (Static Value)


#
# Get All Regions
#

    Given url getUrl = baseTestUrl
    And path 'references/regions'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200



    * def count = response.data.length
    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** REGIONS'
    And print '******** COUNT: data.length = '+ count
    And print '******** ETag = '+ eTag
    And print '================================\n'
    And print '\n'



    And match response ==
      """
        {
          "message": '##string',
          "data":    '##[] ^^ {
                                code:        "#string",
                                name:        "#string",
                                description: "#string",
                                createTime:  "#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}[.][0-9]{3}Z$",
                                updateTime:  "#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}[.][0-9]{3}Z$",
                              }'
        }
      """



  Scenario: 2) C36101727 RMS-5610 SIConnect Public API V2
               - Get Region & Country List (Static Value)
               - Response code: 304 - Not modified

#
# Get All Regions
#

    Given url getUrl = baseTestUrl
    And path 'references/regions'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200



    * def count = response.data.length
    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** REGIONS'
    And print '******** COUNT: data.length = '+ count
    And print '******** ETag = '+ eTag
    And print '================================\n'
    And print '\n'

#
# Test when 'If-None-Match' header is supplied in request (from response header 'ETag')
#
    Given url getUrl = baseTestUrl
    And path 'references/regions'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header If-None-Match = eTag
    When method GET
    Then status 304

    And print '\n'
    And print '================================'
    And print '******** If-None-Match = '+ eTag
    And print '================================\n'
    And print '\n'


#
#  Scenario: 3) C36101674 RMS-5610 SIConnect Public API V2
#               - Get Region & Country List (Static Value)
#               - Invalid Tenant Code/No tenant code
#
##
## Test when 'X-Tenant-Code' header is invalid/missing
##
#    Given url getUrl = baseTestUrl
#    And path 'references/regions'
#    And header X-Tenant-Code = invalidXTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method GET
#    Then status 200
#    And match response != '#null'
#    And match response != '#object'
#    And match response != '#[0]'
#    And match response == ''
#
#
#
#    Given url getUrl = baseTestUrl
#    And path 'references/regions'
##    And header X-Tenant-Code = invalidXTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method GET
#    Then status 200
#    And match response != '#null'
#    And match response != '#object'
#    And match response != '#[0]'
#    And match response == ''
#
