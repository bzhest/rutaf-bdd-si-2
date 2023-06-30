@api @public_api @getPublicReferencesAllOtherNameTypes
Feature: Get All Other Name Types



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



  Scenario: 1) C36101738 RMS-5611 SIConnect Public API V2
               - Get Supplier Other Name Type List (Static)

#
# Get All Other Name Types - Supplier
#

    Given url getUrl = baseTestUrl
    And path 'references/other-name-types'
    And param type = 'SUPPLIER'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200



    * def count = response.data.length
    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** OTHER NAME TYPES - SUPPLIER'
    And print '******** COUNT: data.length = '+ count
    And print '******** ETag = '+ eTag
    And print '================================\n'
    And print '\n'



    And match response ==
      """
        {
          "message": '##string',
          "data":    '##[] ^^ {
                                code:        "##string",
                                name:        "##string",
                                description: "#string",
                                createTime:  "#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}[.][0-9]{3}Z$",
                                updateTime:  "#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}[.][0-9]{3}Z$",
                              }'
        }
      """



  Scenario: 2) C36101747 RMS-5611 SIConnect Public API V2
               - Get Supplier Other Name Type List (Static)
               - Response code: 304 - Not modified

#
# Get All Other Name Types - Supplier
#

    Given url getUrl = baseTestUrl
    And path 'references/other-name-types'
    And param type = 'SUPPLIER'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200



    * def count = response.data.length
    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** OTHER NAME TYPES - SUPPLIER'
    And print '******** COUNT: data.length = '+ count
    And print '******** ETag = '+ eTag
    And print '================================\n'
    And print '\n'

#
# Test when 'If-None-Match' header is supplied in request (from response header 'ETag')
#
    Given url getUrl = baseTestUrl
    And path 'references/other-name-types'
    And param type = 'SUPPLIER'
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
#  Scenario: 3) C36101745 RMS-5611 SIConnect Public API V2
#               - Get Supplier Other Name Type List (Static)
#               - Invalid Tenant Code/No tenant code
#
##
## Test when X-Tenant-Code is invalid/missing
##
#    Given url getUrl = baseTestUrl
#    And path 'references/other-name-types'
#    And param type = 'SUPPLIER'
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
#    And path 'references/other-name-types'
#    And param type = 'SUPPLIER'
##    And header X-Tenant-Code = invalidXTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method GET
#    Then status 200
#    And match response != '#null'
#    And match response != '#object'
#    And match response != '#[0]'
#    And match response == ''






  Scenario: 4) C36102774 RMS-5620 SIConnect Public API V2
            - Get Supplier Contact Other Name Type List (Static Value)

#
# Get All Other Name Types - Contact
#

    Given url getUrl = baseTestUrl
    And path 'references/other-name-types'
    And param type = 'CONTACT'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200



    * def count = response.data.length
    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** OTHER NAME TYPES - CONTACT'
    And print '******** COUNT: data.length = '+ count
    And print '******** ETag = '+ eTag
    And print '================================\n'
    And print '\n'



    And match response ==
      """
        {
          "message": '##string',
          "data":    '##[] ^^ {
                                code:        "##string",
                                name:        "##string",
                                description: "#string",
                                createTime:  "#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}[.][0-9]{3}Z$",
                                updateTime:  "#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}[.][0-9]{3}Z$",
                              }'
        }
      """



  Scenario: 5) C36105285 RMS-5620 SIConnect Public API V2
               - Get Supplier Contact Other Name Type List (Static Value)
               - Response code: 304 - Not modified

#
# Get All Other Name Types - Contact
#

    Given url getUrl = baseTestUrl
    And path 'references/other-name-types'
    And param type = 'CONTACT'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200


    * def count = response.data.length
    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** OTHER NAME TYPES - CONTACT'
    And print '******** COUNT: data.length = '+ count
    And print '******** ETag = '+ eTag
    And print '================================\n'
    And print '\n'


#
# Test when 'If-None-Match' header is supplied in request (from response header 'ETag')
#
    Given url getUrl = baseTestUrl
    And path 'references/other-name-types'
    And param type = 'CONTACT'
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
#  Scenario: 6) C36104354 RMS-5620 SIConnect Public API V2
#               - Get Supplier Contact Other Name Type List (Static Value)
#               - Invalid Tenant Code/No tenant code
#
##
## Test when X-Tenant-Code is invalid/missing
##
#    Given url getUrl = baseTestUrl
#    And path 'references/other-name-types'
#    And param type = 'CONTACT'
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
#    And path 'references/other-name-types'
#    And param type = 'CONTACT'
##    And header X-Tenant-Code = invalidXTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method GET
#    Then status 200
#    And match response != '#null'
#    And match response != '#object'
#    And match response != '#[0]'
#    And match response == ''
