@api @public_api @postPublicCreateThirdParty
Feature: Create Third Party



  Background:

    * def xTenantCode =        tenant
    * def invalidXTenantCode = 'xxx'
    * def eTag =               ''



    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in


    * def fnGetNowMs = function() { return java.lang.System.currentTimeMillis() }

    * def fnGetISODate =
      """
        function( givenEpochTimeMs ) {
          var givenDate = new Date( givenEpochTimeMs );
          return givenDate.toISOString();
        }
      """

  Scenario: 1) C36154400 Public API - POST /thirdparty
  - Verify that third party is successfully created

#
# CREATE third-party
#
    * def requestBody_createThirdParty =
      """
          {
            "referenceNo": null,
            "name": "Gold Pharmaceuticals Corporation",
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
                "(123) 456-7890"
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

    * print "\n"
    * print "Response = ", response

    * def thirdPartyId = response.data.id



#
# VALIDATE response body SCHEMA
#
    And match response ==
          """
              {
                "message": '##string',
                "data":    {
                              "id":                     '##string',
                              "referenceNo":            '##string',
                              "name":                   '##string',
                              "currency":               '##string',
                              "companyType":            '##string',
                              "industryType":           '##string',
                              "organizationSize":       '##string',
                              "businessType":           '##string',
                              "incorporationDate":      '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
                              "revenue":                '##string',
                              "responsibleParty":       '##string',
                              "liquidationDate":        '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
                              "divisions":              '##[] #string',
                              "affiliation":            '##string',
                              "workflowGroupId":        '##string',
                              "assessmentDetail":       '##string',
                              "address":                {
                                                          "addressLine": '##string',
                                                          "city":        '##string',
                                                          "province":    '##string',
                                                          "postalCode":  '##string',
                                                          "region":      '##string',
                                                          "country":     '##string',
                                                        },
                              "spendCategory":          '##string',
                              "sourcingMethod":         '##string',
                              "productDesignAgreement": '##string',
                              "sourcingType":           '##string',
                              "relationshipVisibility": '##string',
                              "productImpact":          '##string',
                              "commodityType":          '##string',
                              "customFields":           '##[] ^^ {
                                                                  active:              "##boolean",
                                                                  createTime:          "##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$",
                                                                  description:         "##string",
                                                                  id:                  "##string",
                                                                  name:                "##string",
                                                                  options:             "##[] ^ {
                                                                                                 option:  ##string,
                                                                                                 redFlag: ##boolean,
                                                                                               }",
                                                                  orderNumber:         "##number",
                                                                  status:              "##string",
                                                                  type:                "##string",
                                                                  updateTime:          "##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$",
                                                                  usePredefinedValues: "##boolean",
                                                                  value:               "##string",
                                                                }',
                              "bankDetails":            '##[] ^ {
                                                                  name:                "##string",
                                                                  accountNo:           "##string",
                                                                  branchName:          "##string",
                                                                  addressLine:         "##string",
                                                                  city:                "##string",
                                                                  country:             "##string",
                                                                }',
                              "contactInformation":     {
                                                          "phoneNumber": '##[] #string',
                                                          "fax":         '##[] #string',
                                                          "website":     '##[] #string',
                                                          "email":       '##[] #string',
                                                        },
                              "status":                 '##string',
                              "overallRiskScore":       '##number',
                              "riskTier":               '##string',
                              "overallStatus":          '##string',
                              "screeningStatus":        '##string',
                              "otherNames":             '##[] ^ {
                                                                  name:                  "##string",
                                                                  iwNameType:            "##string",
                                                                  countryOfRegistration: "##string",
                                                                }',
                              "countryAlerts":          '##string',
                              "description":            '##string',
                              "createTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
                              "updateTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
                           }
              }
          """
