@ignore
Feature: REUSABLE - Create Third-Party



  Background:
#    * def baseTestUrl =        'https://api.qa-sprint2.supplierintegrity.com'
    * def xTenantCode =        tenant
    * def invalidXTenantCode = 'xxx'
    * def eTag =               ''
    * configure retry =        { count: 40, interval: 3000 }

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in



  Scenario: Create third-party

#    * def thirdPartyIdCREATE = thirdPartyId

    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY: CREATE THIRD-PARTY LIST'
    And print '******** baseTestUrl        = '+ baseTestUrl
    And print '******** xTenantCode        = '+ xTenantCode
    And print '******** isSwaggerDirect    = '+ isSwaggerDirect
#    And print '******** thirdPartyIdCREATE = '+ thirdPartyIdCREATE
    And print '******** nowMs              = '+ nowMs
    And print '================================\n'
    And print '\n'


#
# CREATE third-party
#

    * def requestBody_createThirdParty0 =
      """
          {
            "referenceNo": "null",
            "name": "ABC Corp",
            "currency": "USD",
            "companyType": "CORP",
            "industryType": "AHI",
            "organizationSize": "11-50",
            "businessType": "PRS",
            "incorporationDate": "2021-06-18T05:32:07-0800",
            "revenue": "10M",
            "responsibleParty": "si_admin@yopmail.com",
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


    * def requestBody_createThirdParty = requestBody_createThirdParty !=null ? requestBody_createThirdParty : requestBody_createThirdParty0

    Given url postUrl = baseTestUrl
    And path 'thirdparty'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_createThirdParty
    When method POST
    Then status 201

    * def thirdPartyId = response.data.id


    * def incDateReq =        requestBody_createThirdParty.incorporationDate
    * def incDateResp =       response.data.incorporationDate

    And match incDateReq ==   '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'
    And match incDateResp ==  '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'

    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY'
    And print '******** TEST   : nowMs             = '+ nowMs
    And print '********        : nowISODate        = '+ nowISODate
    And print '********        : nowEpochTimeMs    = '+ nowEpochTimeMs
    And print '********        :'
    And print '********        : nowISODateLocTzo  = '+ nowISODateLocTzo
    And print '********        : nowISODateLTzoMs  = '+ nowISODateLTzoMs
    And print '********        : nowISODateLTzoMin = '+ nowISODateLTzoMin
    And print '********        :'
    And print '********        : nowISODateUTCTzo  = '+ nowISODateUTCTzo
    And print '********        : nowISODateUTCTzo8 = '+ nowISODateUTCTzo8
    And print '********        : nowISODateUTzoMs  = '+ nowISODateUTzoMs
    And print '********        : nowISODateUTzoMin = '+ nowISODateUTzoMin
    And print '********        :'
    And print '********        : now000000ISODate  = '+ now000000ISODate
    And print '********        : now235959ISODate  = '+ now235959ISODate
    And print '********        : nowStartISODate4  = '+ nowStartISODate4
    And print '********        : nowEndISODate4    = '+ nowEndISODate4
    And print '********        :'
    And print '********        : nowISODateAsUTC   = '+ nowISODateAsUTC
    And print '********        : nowISODateToUTC   = '+ nowISODateToUTC
    And print '********        :'
    And print '******** CREATED: thirdPartyId      = '+ thirdPartyId
    And print '********        : incDateReq        = '+ incDateReq
    And print '********        : incDateResp       = '+ incDateResp
    And print '================================\n'
    And print '\n'


#
# VALIDATE response body SCHEMA
#

#    And match response ==
#          """
#              {
#                "message": '##string',
#                "data":    {
#                              "id":                     '##string',
#                              "referenceNo":            '##string',
#                              "name":                   '##string',
#                              "currency":               '##string',
#                              "companyType":            '##string',
#                              "industryType":           '##string',
#                              "organizationSize":       '##string',
#                              "businessType":           '##string',
#                              "incorporationDate":      '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#                              "revenue":                '##string',
#                              "responsibleParty":       '##string',
#                              "liquidationDate":        '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#                              "divisions":              '##[] #string',
#                              "affiliation":            '##string',
#                              "workflowGroupId":        '##string',
#                              "assessmentDetail":       '##string',
#                              "address":                {
#                                                          "addressLine": '##string',
#                                                          "city":        '##string',
#                                                          "province":    '##string',
#                                                          "postalCode":  '##string',
#                                                          "region":      '##string',
#                                                          "country":     '##string',
#                                                        },
#                              "spendCategory":          '##string',
#                              "sourcingMethod":         '##string',
#                              "productDesignAgreement": '##string',
#                              "sourcingType":           '##string',
#                              "relationshipVisibility": '##string',
#                              "productImpact":          '##string',
#                              "commodityType":          '##string',
#                              "customFields":           '##[] ^ {
#                                                                  active:              "##boolean",
#                                                                  createTime:          "##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$",
#                                                                  description:         "##string",
#                                                                  id:                  "##string",
#                                                                  name:                "##string",
#                                                                  options:             "##[] ^ {
#                                                                                                 option:  ##string,
#                                                                                                 redFlag: ##boolean,
#                                                                                               }",
#                                                                  orderNumber:         "##number",
#                                                                  status:              "##string",
#                                                                  type:                "##string",
#                                                                  updateTime:          "##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$",
#                                                                  usePredefinedValues: "##boolean",
#                                                                  value:               "##string",
#                                                                }',
#                              "bankDetails":            '##[] ^ {
#                                                                  name:                "##string",
#                                                                  accountNo:           "##string",
#                                                                  branchName:          "##string",
#                                                                  addressLine:         "##string",
#                                                                  city:                "##string",
#                                                                  country:             "##string",
#                                                                }',
#                              "contactInformation":     {
#                                                          "phoneNumber": '##[] #string',
#                                                          "fax":         '##[] #string',
#                                                          "website":     '##[] #string',
#                                                          "email":       '##[] #string',
#                                                        },
#                              "status":                 '##string',
#                              "overallRiskScore":       '##number',
#                              "riskTier":               '#? riskTier_enums.contains(_)',
#                              "overallStatus":          '##string',
#                              "screeningStatus":        '##string',
#                              "otherNames":             '##[] ^ {
#                                                                  name:                  "##string",
#                                                                  iwNameType:            "##string",
#                                                                  countryOfRegistration: "##string",
#                                                                }',
#                              "countryAlerts":          '##string',
#                              "createTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#                              "updateTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#                           }
#              }
#          """

    * def riskTier_enums = [ "Low", "Medium", "High" ]

    * def contactInformation_schema =
        """
          {
            phoneNumber: '##[] ##string',
            fax:         '##[] ##string',
            website:     '##[] ##string',
            email:       '##[] ##string',
          }
        """

    And match response ==
          """
              {
                "message": '##string',
                "data":    {
                              "id":                     '##string',
                              "referenceNo":            '##string',
                              "name":                   '##string',
                              "description":            '##string',
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
                              "customFields":           '##[] ^ {
                                                                  id:                  "##string",
                                                                  name:                "##string",
                                                                  description:         "##string",
                                                                  options:             "##[] ^ {
                                                                                                 option:  ##string,
                                                                                                 redFlag: ##boolean,
                                                                                               }",
                                                                  type:                "##string",
                                                                  value:               "#ignore",
                                                                  active:              "##string",
                                                                  orderNumber:         "##number",
                                                                  usePredefinedValues: "##boolean",
                                                                  status:              "##string",
                                                                  updateTime:          "##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$",
                                                                  createTime:          "##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$",
                                                                }',
                              "bankDetails":            '##[] ^ {
                                                                  name:                "##string",
                                                                  accountNo:           "##string",
                                                                  branchName:          "##string",
                                                                  addressLine:         "##string",
                                                                  city:                "##string",
                                                                  country:             "##string",
                                                                }',
                              "contactInformation":     '#( \"##( contactInformation_schema )\" )',
                              "status":                 '##string',
                              "overallRiskScore":       '##number',
                              "riskTier":               '#? riskTier_enums.contains(_)',
                              "overallStatus":          '##string',
                              "screeningStatus":        '##string',
                              "otherNames":             '##[] ^ {
                                                                  name:                  "##string",
                                                                  iwNameType:            "##string",
                                                                  countryOfRegistration: "##string",
                                                                }',
                              autoScreen:               '##boolean',
                              countryAlerts:            '##[] ^^ {
                                                                   alertType:            "##string",
                                                                   alertMessage:         "##string",
                                                                 }',
                              "createTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
                              "updateTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
                           }
              }
          """
