@api @public_api @postContactBulkMaxChar
Feature: Post Contacts Bulk

  As a user
  I would like to verify Post Contacts Bulk test script
  So that I can create bulk contacts

  Background:
    * def urlPath = '/contacts/bulk'
    * def xTenantCode = tenant



    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in

    * configure logPrettyResponse = true


  Scenario: C36333420 : Public API - POST /contacts/bulk - Verify error validation for fields with maximum character limitations


#
# CREATE PARENT third-party PARENT of new contact
#

    * def requestBody_createThirdParty =
      """
          {
            "referenceNo": null,
            "name": "ABC Corp",
            "currency": "USD",
            "companyType": "CORP",
            "industryType": "AHI",
            "organizationSize": "11-50",
            "businessType": "PRS",
            "incorporationDate": "2021-06-18T05:32:07-0800",
            "revenue": "10M",
            "responsibleParty": "rddcentre.admin.np@refinitiv.com",
            "liquidationDate": "2021-06-18T05:32:07-0800",
            "divisions": [
              "MyDivision"
            ],
            "affiliation": "SOE",
            "workflowGroupId": "#(workflowGroupId)",
            "spendCategory": "OTS",
            "sourcingMethod": "DIST_M_SRC",
            "productDesignAgreement": "OTS",
            "sourcingType": "MULTI",
            "relationshipVisibility": "LITTLE_VIS",
            "productImpact": "COMMODITIZED_PRODUCT",
            "commodityType": "A3P",
            "address": {
              "addressLine": "Address Line 1",
              "city": "City 1",
              "country": "US",
              "postalCode": "31080",
              "province": "Province 1",
              "region": "#(region)"
            },
            "contactInformation": {
              "email": [
                "john.smith@company1.com"
              ],
              "fax": [
                "+91 (123) 456-7890"
              ],
              "phoneNumber": [
                "123-456-7890"
              ],
              "website": [
                "http://www.company1.com"
              ]
            },
            "description": "This is supplier description",
            "customFields": [],
            "bankDetails": [
              {
                "accountNo": "111-11111111-1",
                "addressLine": "Address 1",
                "branchName": "Branch Name",
                "city": "City 1",
                "country": "US",
                "name": "Bank Name"
              }
            ],
            "otherNames": [
            ]
          }
      """

    Given url postUrl = baseTestUrl
    And path 'thirdparty'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_createThirdParty
    When method POST
    Then status 201

    * def thirdPartyId = response.data.id



#
# CHECK: Retrieve PARENT third-party BY ID - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200


    * def thirdPartyIdResult = response.data.id
    And match thirdPartyId == thirdPartyIdResult



    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: CREATE & RETRIEVE (PARENT) THIRD-PARTY BY ID'
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'


#
# CREATE contact
#

    * def newPostRequestBodyBulkMaxChar =
        """
          [
            {
              "parent": "#(thirdPartyId)",
              "title": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do e",
              "firstName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do e",
              "middleName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do e",
              "lastName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do e",
              "personalDetails": {
                "citizenship": "US",
                "placeOfBirth": "US"
              },
              "addresses": [
                {
                  "addressLine": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do e",
                  "city": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do e",
                  "country": "US",
                  "postalCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do e",
                  "province": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do e",
                  "region": "#(region)"
                }
              ],
              "contactInformation": {
                "email": [
                  "john.smith@company1.com"
                ],
                "fax": [
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do e"
                ],
                "phoneNumber": [
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do e"
                ],
                "website": [
                  "http://www.company1.com"
                ]
              },
              "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit",
              "otherNames": [],
              "isActive": false,
              "isPrincipal": false,
              "autoScreen": false
            }
          ]
        """

    Given url postUrl = baseTestUrl
    And path urlPath
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request newPostRequestBodyBulkMaxChar
    When method POST
    Then status 207
    And match response.data[0].status ==
      """
      400
      """
    And match response.data[0].errors ==
      """
        [{
            "code": '##string',
            "field": '##string',
            "description": '##regex ^.*[(should not exceed the maximum length!)]$'
        }, {
            "code": '##string',
            "field": '##string',
            "description": '##regex ^.*[(should not exceed the maximum length!)]$'
        }, {
            "code": '##string',
            "field": '##string',
            "description": '##regex ^.*[(should not exceed the maximum length!)]$'
        }, {
            "code": '##string',
            "field": '##string',
            "description": '##regex ^.*[(should not exceed the maximum length!)]$'
        }, {
            "code": '##string',
            "field": '##string',
            "description": '##regex ^.*[(should not exceed the maximum length!)]$'
        }, {
            "code": '##string',
            "field": '##string',
            "description": '##regex ^.*[(should not exceed the maximum length!)]$'
        }, {
            "code": '##string',
            "field": '##string',
            "description": '##regex ^.*[(should not exceed the maximum length!)]$'
        }, {
            "code": '##string',
            "field": '##string',
            "description": '##regex ^.*[(should not exceed the maximum length!)]$'
        }, {
            "code": '##string',
            "field": '##string',
            "description": '##regex ^.*[(should not exceed the maximum length!)]$'
        }, {
            "code": '##string',
            "field": "##string",
            "description": '##regex ^.*[(should not exceed the maximum length!)]$'
        }, {
            "code": '##string',
            "field": '##string',
            "description": '##regex ^.*[(should not exceed the maximum length!)]$'
        }]
      """




