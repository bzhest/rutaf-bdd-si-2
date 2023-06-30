@api @public_api @getPublicReferencesAllCustomFields
Feature: Get All Custom Fields



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



  Scenario: 1) C36182840 Public API - GET Custom Field List
               - Verify that list of Custom Fields are displayed

#
# Get All Custom Fields
#


    Given url getUrl = baseTestUrl
    And path 'references/custom-fields'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200


    * def count = response.data.length
#    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** CUSTOM FIELDS'
    And print '******** COUNT: data.length = '+ count
#    And print '******** ETag = '+ eTag
    And print '================================\n'
    And print '\n'



    * def typeEnums =   [ 'TEXT', 'NUMBER', 'DATE', 'SINGLE_SELECT', 'MULTI_SELECT' ]
    * def statusEnums = [ 'ACTIVE', 'INACTIVE' ]
    And match response ==
      """
        {
          "message": '##string',
          "data":    '##[] ^^ {
                                id:                  "#string",
                                name:                "#string",
                                description:         "##string",
                                active:              "##string",
                                type:                "#? typeEnums.contains(_)",
                                orderNumber:         "##number",
                                options:             "##[] ^^ {
                                                                option:  #string,
                                                                redFlag: ##boolean
                                                              }",
                                usePredefinedValues: "##boolean",
                                status:              "#string",
                                required:            "##boolean",
                                createTime:          "#regex  ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}[.][0-9]{3}Z$",
                                updateTime:          "##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}[.][0-9]{3}Z$",
                              }'
        }
      """



##
## Test when 'X-Tenant-Code' header is invalid
##
#    Given url getUrl = baseTestUrl
#    And path 'references/custom-fields'
#    And header X-Tenant-Code = invalidXTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method GET
#    Then status 200
#    And match response ==
#      """
#        {
#          "message": '##string',
#          "data":    '##[0]'
#        }
#      """



  Scenario: 2) C36188701 Public API - GET Custom Field List
               - Verify that specific fields are displayed when 'field' parameter is populated

#
# Test when 'fields' is supplied with comma-separated fields
# to be displayed in response 'data.id,data.name,data.type'
#

    Given url getUrl = baseTestUrl
    And path 'references/custom-fields'
    And header Authorization = 'Bearer '+ accessToken
    And param fields =         'data.id,data.name,data.type'
    And header X-Tenant-Code = xTenantCode
    When method GET
    Then status 200



    * def typeEnums =   [ 'TEXT', 'NUMBER', 'DATE', 'SINGLE_SELECT', 'MULTI_SELECT' ]
    * def statusEnums = [ 'ACTIVE', 'INACTIVE' ]
    And match response ==
      """
        {
          "message": '##string',
          "data":    '##[] ^^ {
                                id:                  "#string",
                                name:                "#string",
                                type:                "#? typeEnums.contains(_)",
                              }'
        }
      """



    * def count = response.data.length
#    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** CUSTOM FIELDS: TEST FIELDS MATCH RESPONSE'
    And print '******** COUNT: data.length = '+ count
#    And print '******** ETag = '+ eTag
    And print '================================\n'
    And print '\n'
