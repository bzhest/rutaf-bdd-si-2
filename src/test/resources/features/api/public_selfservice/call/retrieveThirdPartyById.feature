@ignore
Feature: REUSABLE - Retrieve Third-Party by Id



  Background:
#    * def baseTestUrl =        'https://api.qa-sprint2.supplierintegrity.com'
    * def xTenantCode =        tenant
    * def invalidXTenantCode = 'xxx'
    * def eTag =               ''
    * configure retry =        { count: 40, interval: 3000 }

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in



  Scenario: Retrieve third-party by id

    * def thirdPartyIdRETRIEVE = thirdPartyId

    And print '\n'
    And print '================================'
    And print '******** RETRIEVE THIRD-PARTY: RETRIEVE THIRD-PARTY BY ID'
    And print '******** baseTestUrl          = '+ baseTestUrl
    And print '******** xTenantCode          = '+ xTenantCode
    And print '******** isSwaggerDirect      = '+ isSwaggerDirect
    And print '******** thirdPartyIdRETRIEVE = '+ thirdPartyIdRETRIEVE
    And print '================================\n'
    And print '\n'


#
# RETRIEVE third-party BY ID
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdRETRIEVE
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def thirdPartyIdRESULT = response.data.id

    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** RETRIEVE THIRD-PARTY BY ID'
    And print '******** thirdPartyIdRETRIEVE        = '+ thirdPartyIdRETRIEVE
    And print '******** thirdPartyIdRESULT          = '+ thirdPartyIdRESULT
    And print '******** VALIDATE: SAME              = '+ ( thirdPartyIdRETRIEVE == thirdPartyIdRESULT )
    And print '******** ETag                        = '+ eTag
    And print '================================\n'
    And print '\n'


#
# VALIDATE response body SCHEMA
#

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
              message:  '##string',
              data:     {
                          id:                     '##string',
                          referenceNo:            '##string',
                          name:                   '##string',
                          currency:               '##string',
                          companyType:            '##string',
                          industryType:           '##string',
                          organizationSize:       '##string',
                          businessType:           '##string',
                          incorporationDate:      '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
                          revenue:                '##string',
                          responsibleParty:       '##string',
                          liquidationDate:        '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
                          divisions:              '##[] ##string',
                          affiliation:            '##string',
                          workflowGroupId:        '##string',
                          assessmentDetail:       '##string',
                          address:                {
                                                    addressLine: '##string',
                                                    city:        '##string',
                                                    province:    '##string',
                                                    postalCode:  '##string',
                                                    region:      '##string',
                                                    country:     '##string',
                                                  },
                          spendCategory:          '##string',
                          sourcingMethod:         '##string',
                          productDesignAgreement: '##string',
                          sourcingType:           '##string',
                          relationshipVisibility: '##string',
                          productImpact:          '##string',
                          commodityType:          '##string',
                          customFields:           '##[] ^^ {
                                                              id:                    "##string",
                                                              name:                  "##string",
                                                              description:           "##string",
                                                              options:               "##[] #object",
                                                              type:                  "##string",
                                                              value:                 "#ignore",
                                                              active:                "##string",
                                                              orderNumber:           "##number",
                                                              usePredefinedValues:   "##boolean",
                                                              status:                "##string",
                                                              required:              "##boolean",
                                                              createTime:            "##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$",
                                                              updateTime:            "##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$",
                                                           }',
                          bankDetails:            '##[] ^^ {
                                                              name:                  "##string",
                                                              accountNo:             "##string",
                                                              branchName:            "##string",
                                                              addressLine:           "##string",
                                                              city:                  "##string",
                                                              country:               "##string",
                                                           }',
                          contactInformation:     '#( \"##( contactInformation_schema )\" )',
                          status:                 '##string',
                          overallRiskScore:       '##number',
                          riskTier:               '#? riskTier_enums.contains(_)',
                          overallStatus:          '##string',
                          screeningStatus:        '##string',
                          otherNames:             '##[] ^^ {
                                                              name:                  "##string",
                                                              iwNameType:            "##string",
                                                              countryOfRegistration: "##string",
                                                              createTime:            "##string",
                                                              updateTime:            "##string"
                                                           }',
                          autoScreen:             '##boolean',
                          countryAlerts:          '##[] ^^ {
                                                              alertType:             "##string",
                                                              alertMessage:          "##string",
                                                           }',
                          description:            '##string',
                          createTime:             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
                          updateTime:             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',

                        }
            }
          """



##
## CHECK: Get third-parties LIST for this day - expected: FOUND
##
#    Given url getUrl = baseTestUrl
#    And path 'thirdparty'
#    And param pageSize =       100
#    And param start =          nowStartISODate4
#    And param end =            nowEndISODate4
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method GET
#    Then status 200
#
#    * def thirdPartyIds = get response.data[*].id
#    And assert thirdPartyIds.contains( thirdPartyIdRETRIEVE )
#
#    * def count = response.data.length
#    And print '\n'
#    And print '================================'
#    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
#    And print '******** COUNT: data.length   = '+ count
#    And print '******** thirdPartyIdRETRIEVE = '+ thirdPartyIdRETRIEVE
#    And print '******** thirdPartyIds        = '+ thirdPartyIds
#    And print '================================\n'
#    And print '\n'
