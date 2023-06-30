@api @public_api @getPublicReferencesAllOrganizationSizes
Feature: Get All Organization Sizes



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



  Scenario: 1) 36098866 Public API - GET Organization Size (Static Value)
               - Verify that Organization Size details are displayed and
                 Response Code is 200
#
# Get All Organization Sizes
#
    Given url getUrl = baseTestUrl
    And path 'references/organization-sizes'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200



    * def count = response.data.length
    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** ORGANIZATION SIZES'
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



  Scenario: 2) C36098867 Public API - GET Organization Size (Static Value)
               - Populate 'etag' in 'If-None-Match' header
               - Verify that the Response Code is 304
#
# Get All Organization Sizes - 'If-None-Match' header (ETag) supplied
#


#
# Get All Organization Sizes - Retrieve 'ETag' response header
#
    Given url getUrl = baseTestUrl
    And path 'references/organization-sizes'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def count = response.data.length
    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** ORGANIZATION SIZES'
    And print '******** COUNT: data.length = '+ count
    And print '******** ETag = '+ eTag
    And print '================================\n'
    And print '\n'

#
# Test when 'If-None-Match' header is supplied in request (from response header 'ETag')
#
    Given url getUrl = baseTestUrl
    And path 'references/organization-sizes'
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
#  Scenario: C36098868 Public API - GET Organization Size (Static Value)
#            - Verify that X-Tenant-Code parameter is required
##
## Test when X-Tenant-Code is invalid/missing
##
#    Given url getUrl = baseTestUrl
#    And path 'references/organization-sizes'
#    And header X-Tenant-Code = invalidXTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method GET
#    Then status 200
#
#    And match response != '#null'
#    And match response != '#object'
#    And match response != '#[]'
#    And match response == ''
#
#
#
#    Given url getUrl = baseTestUrl
#    And path 'references/organization-sizes'
##    And header X-Tenant-Code = invalidXTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method GET
#    Then status 200
#
#    And match response != '#null'
#    And match response != '#object'
#    And match response != '#[]'
#    And match response == ''
#
