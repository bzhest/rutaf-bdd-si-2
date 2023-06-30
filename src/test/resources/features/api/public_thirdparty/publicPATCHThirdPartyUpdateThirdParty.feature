@api @public_api @patchPublicThirdPartyUpdateThirdParty
Feature: Update Third Party



  Background:
#    * def baseTestUrl =        'https://api.qa-sprint2.supplierintegrity.com'
    * def xTenantCode =        tenant
    * def invalidXTenantCode = 'xxx'
    * def eTag =               ''



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

#

    * def fnGetNowMs = function() { return java.lang.System.currentTimeMillis(); }

    * def fnGetISODate =
      """
        function( givenEpochTimeMs ) {
          var givenDate = new Date( givenEpochTimeMs );
          return givenDate.toISOString();
        }
      """

    * def fnGetEpochTimeMs =
      """
        function( givenISODate ) {
          var givenDate = new Date( givenISODate );
          return givenDate.getTime();
        }
      """

    * def fnGetISODateStartOfDay =
      """
        function( givenEpochTimeMs ) {
          var givenDate = new Date( givenEpochTimeMs );
          var givenDateStart = new Date( givenDate.getFullYear(), givenDate.getMonth(), givenDate.getDate(), 0, 0, 0, 0 );
          return givenDateStart.toISOString();
        }
      """

    * def fnGetISODateEndOfDay =
      """
        function( givenEpochTimeMs ) {
          var givenDate = new Date( givenEpochTimeMs );
          var givenDateEnd = new Date( givenDate.getFullYear(), givenDate.getMonth(), givenDate.getDate(), 23, 59, 59, 999 );
          return givenDateEnd.toISOString();
        }
      """

    * def fnCreateDateAsUTC =
      """
        function( givenEpochTimeMs ) {
          var givenDate = new Date( givenEpochTimeMs );
          var utcDate = new Date( Date.UTC(givenDate.getFullYear(), givenDate.getMonth(), givenDate.getDate(), givenDate.getHours(), givenDate.getMinutes(), givenDate.getSeconds(), givenDate.getMilliseconds()) );
          return utcDate.toISOString();
        }
      """

    * def fnConvertDateToUTC =
      """
        function( givenEpochTimeMs ) {
          var givenDate = new Date( givenEpochTimeMs );
          var utcDate = new Date( givenDate.getUTCFullYear(), givenDate.getUTCMonth(), givenDate.getUTCDate(), givenDate.getUTCHours(), givenDate.getUTCMinutes(), givenDate.getUTCSeconds(), givenDate.getUTCMilliseconds() );
          return utcDate.toISOString();
        }
      """

#    * def fnConvertToISODate4 =
#      """
#        function( givenDateMsOrISODate ) {
#          var givenDate = new Date( givenDateMsOrISODate );
#          return givenDate.toISOString().substring( 0, 19 ) +'+0000';
#        }
#      """



    * def fnToISOStringLocTzo =
      """
        function( givenDateMsOrISODateTzo ) {
           var date   = new Date( givenDateMsOrISODateTzo );
           var tzoMin = -date.getTimezoneOffset();
           var s      = (tzoMin >= 0) ? '+' : '-';
           var padP   = function( n, p ) {
               var s0 = '';
               if ( n < Math.pow(10,p) ) {
                   for ( var i=0; i<p; i++ ) {
                       if ( n < Math.pow(10,p-i-1) ) {
                           s0 += '0';
                       }
                       else {
                           break;
                       }
                   }
               }
               s0 += (n>0? n.toString() : '');
               return s0;
           };
           return          date.getFullYear()
               +'-' + padP( date.getMonth() + 1,    2 )
               +'-' + padP( date.getDate(),         2 )
               +'T' + padP( date.getHours(),        2 )
               +':' + padP( date.getMinutes(),      2 )
               +':' + padP( date.getSeconds(),      2 )
               +'.' + padP( date.getMilliseconds(), 3 )
               + s  + padP( tzoMin / 60 ,           2 )
               +''  + padP( tzoMin % 60 ,           2 );
        }
      """



    * def fnToISOStringUTCTzo =
      """
        function( givenDateMsOrISODateTzo ) {
           var date   = new Date( givenDateMsOrISODateTzo );
           var tzoMin = 0; // -date.getTimezoneOffset();
           var s      = (tzoMin >= 0) ? '+' : '-';
           var padP   = function( n, p ) {
               var s0 = '';
               if ( n < Math.pow(10,p) ) {
                   for ( var i=0; i<p; i++ ) {
                       if ( n < Math.pow(10,p-i-1) ) {
                           s0 += '0';
                       }
                       else {
                           break;
                       }
                   }
               }
               s0 += (n>0? n.toString() : '');
               return s0;
           };
           return          date.getUTCFullYear()
               +'-' + padP( date.getUTCMonth() + 1,    2 )
               +'-' + padP( date.getUTCDate(),         2 )
               +'T' + padP( date.getUTCHours(),        2 )
               +':' + padP( date.getUTCMinutes(),      2 )
               +':' + padP( date.getUTCSeconds(),      2 )
               +'.' + padP( date.getUTCMilliseconds(), 3 )
               + s  + padP( tzoMin / 60 ,              2 )
               +''  + padP( tzoMin % 60 ,              2 );
        }
      """



    * def fnConvertISODateTzoToGivenTzo =
      """
        function( givenMsOrISODateTzo, givenTzo ) {
           var givenDate = new Date( givenMsOrISODateTzo );
           var tzoMin    = (givenTzo.substring(0,1) === '+' ? 1 : -1) * ( parseInt(givenTzo.substring(1,3))*60 + parseInt(givenTzo.substring(3,5)) );

           var convDate  = new Date( givenDate.getTime() + tzoMin*60000 );
           return convDate.toISOString().substring( 0, 23 ) + givenTzo;
        }
      """



    * def fnAbbrevISODateTzo =
      """
        function( givenISODateTzo ) {
          var resultISODateTzo = null;
          if ( givenISODateTzo.lastIndexOf('.') > -1 ) {
            resultISODateTzo = givenISODateTzo.substring( 0, givenISODateTzo.lastIndexOf('.') )
                              + ( givenISODateTzo.substring( givenISODateTzo.lastIndexOf('.')+4 ) === 'Z' ?
                                      "+0000"
                                    : givenISODateTzo.substring( givenISODateTzo.lastIndexOf('.')+4 )
                                );
          }
          else {
            resultISODateTzo = givenISODateTzo;
          }
          return resultISODateTzo;
        }
      """



    * def fnGetTimezoneOffset =
      """
        function( givenISODateString ) {
          return givenISODateString.substring( givenISODateString.length-1, givenISODateString.length ) === 'Z' ?
                     new Date( givenISODateString ).getTimezoneOffset()
                   : givenISODateString.lastIndexOf('+') > -1 ?
                         givenISODateString.substring( givenISODateString.lastIndexOf('+') )
                       : givenISODateString.lastIndexOf('-') > -1 ?
                             givenISODateString.substring( givenISODateString.lastIndexOf('-') )
                           : '?';
        }
      """



    * def writeToFile =
      """
        function( fqFilename, text ) {
            var TextFileWriter = Java.type( 'com.refinitiv.asts.test.ui.utils.TextFileWriter' );
            var tfw = new TextFileWriter();
            tfw.writeToFile( fqFilename, text );
        }
      """



    * def archiveToZipFile =
      """
        function( fqZipArchiveFilename, fqZipEntryFilename ) {
            var ZipFileArchiver = Java.type( 'com.refinitiv.asts.test.ui.utils.ZipFileArchiver' );
            var zfa = new ZipFileArchiver();
            return zfa.archiveToZipFile( fqZipArchiveFilename, fqZipEntryFilename );
        }
      """



    * def addOrReplaceEntry =
      """
        function( fqZipArchiveFilename, fqZipEntryFilename ) {
            var ZipFileArchiver = Java.type( 'com.refinitiv.asts.test.ui.utils.ZipFileArchiver' );
            var zfa = new ZipFileArchiver();
            return zfa.addOrReplaceEntry( fqZipArchiveFilename, fqZipEntryFilename );
        }
      """




    * configure logPrettyResponse = true



  Scenario: 1. C36132829 [RMS-5597] - Public API
               - Verify Partially Update Third Party (Successfully Updated)

#
# Update Third Party
#


#
# CREATE third-party
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



    * def nowMs =             call fnGetNowMs
    * def nowISODate =        call fnGetISODate           nowMs
    * def nowEpochTimeMs =    call fnGetEpochTimeMs       nowISODate

    * def nowISODateLocTzo =  call fnToISOStringLocTzo    nowMs
    * def nowISODateLTzoMs =  call fnGetEpochTimeMs       nowISODateLocTzo
    * def nowISODateLTzoMin = call fnGetTimezoneOffset    nowISODateLocTzo

    * def nowISODateUTCTzo =  call fnToISOStringUTCTzo    nowMs
    * def nowISODateUTCTzo8 = call fnToISOStringUTCTzo    nowISODateLocTzo
    * def nowISODateUTzoMs =  call fnGetEpochTimeMs       nowISODateUTCTzo
    * def nowISODateUTzoMin = call fnGetTimezoneOffset    nowISODateUTCTzo

    * def now000000ISODate =  call fnGetISODateStartOfDay nowMs
    * def now235959ISODate =  call fnGetISODateEndOfDay   nowMs

    * def nowStartISODate4 =  fnAbbrevISODateTzo( fnConvertISODateTzoToGivenTzo( now000000ISODate, "+0800" ) )
    * def nowEndISODate4 =    fnAbbrevISODateTzo( fnConvertISODateTzoToGivenTzo( now235959ISODate, "+0800" ) )

    * def nowISODateAsUTC =   call fnCreateDateAsUTC      nowMs
    * def nowISODateToUTC =   call fnConvertDateToUTC     nowMs

    * def incDateReq =        requestBody_createThirdParty.incorporationDate
    * def incDateResp =       response.data.incorporationDate

    And match nowISODate ==   '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'
    And match incDateReq ==   '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'
    And match incDateResp ==  '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'

    And print '\n'
    And print '================================'
    And print '******** UPDATE THIRD-PARTY: CREATE THIRD-PARTY'
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
                                                                  value:               "##[]",
                                                                  required:            "##boolean"

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
                              "autoScreen":             '##boolean',
                              "countryAlerts":          '##string',
                              "description":            '##string',
                              "createTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
                              "updateTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
                           }
              }
          """



#
# CHECK: Retrieve third-party BY ID - expected: FOUND
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
    And print '******** UPDATE THIRD-PARTY: RETRIEVE THIRD-PARTY BY ID'
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'



#
# TODO: Validate response body schema: NO NEED?
#



#
# CHECK: Get third-parties LIST for this day - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty'
    And param pageSize =       400
    And param start =          nowStartISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def thirdPartyIds = get response.data[*].id
    And assert thirdPartyIds.contains( thirdPartyIdResult )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** UPDATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIds      = '+ thirdPartyIds
    And print '================================\n'
    And print '\n'



#
# UPDATE third-party by id
#
    * def requestBody_updateThirdParty =
      """
          {
            "name": "ABC-2021 INC LLC PTY",
            "currency": "PHP",
            "industryType": "EDU",
            "businessType": "PRI",
            "address": {
              "addressLine": "22 Main Ave.",
              "city": "Zombieland City",
              "country": "US",
              "postalCode": "90210",
              "province": "California",
              "region": "#(region)"
            },
            "contactInformation": {
              "email": [
                "albert.redenson@abc.com",
                "ards@abc.com"
              ],
              "fax": [
                "+001 (017) 528-7846"
              ],
              "phoneNumber": [
                "123-8658-6053"
              ],
              "website": [
                "http://www.abc.com",
                "https://www.abc.com",
                "https://www.abc.co.uk"
              ]
            },
            "description": "Acme Ball Cojones"
          }
      """

    Given url patchUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdResult
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header If-Match = eTag
    And request requestBody_updateThirdParty
    When method PATCH
    Then status 200

    And match requestBody_updateThirdParty.name ==                           response.data.name
    And match requestBody_updateThirdParty.currency ==                       response.data.currency
    And match requestBody_updateThirdParty.industryType ==                   response.data.industryType
    And match requestBody_updateThirdParty.businessType ==                   response.data.businessType

    And match requestBody_updateThirdParty.address.addressLine ==            response.data.address.addressLine
    And match requestBody_updateThirdParty.address.city ==                   response.data.address.city
    And match requestBody_updateThirdParty.address.country ==                response.data.address.country
    And match requestBody_updateThirdParty.address.postalCode ==             response.data.address.postalCode
    And match requestBody_updateThirdParty.address.province ==               response.data.address.province
    And match requestBody_updateThirdParty.address.region ==                 response.data.address.region

    And match requestBody_updateThirdParty.contactInformation.email[*]       contains only  response.data.contactInformation.email
    And match requestBody_updateThirdParty.contactInformation.fax[*]         contains only  response.data.contactInformation.fax
    And match requestBody_updateThirdParty.contactInformation.phoneNumber[*] contains only  response.data.contactInformation.phoneNumber
    And match requestBody_updateThirdParty.contactInformation.website[*]     contains only  response.data.contactInformation.website



#
# DELETE third-party by id
#
    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdResult
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204



#
# CHECK: Retrieve third-party BY ID - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdResult
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 404



#
# CHECK: Get third-parties LIST for this day - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty'
    And param pageSize =       400
    And param start =          nowStartISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def thirdPartyIds = get response.data[*].id
    And assert !thirdPartyIds.contains( thirdPartyIdResult )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** UPDATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIds      = '+ thirdPartyIds
    And print '================================\n'
    And print '\n'




  Scenario: 2. C36158867 [RMS-5597] - Public API
               - Verify Partially Update Third Party - Validations

#
# Update Third Party
#


#
# CREATE third-party
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



    * def nowMs =             call fnGetNowMs
    * def nowISODate =        call fnGetISODate           nowMs
    * def nowEpochTimeMs =    call fnGetEpochTimeMs       nowISODate

    * def nowISODateLocTzo =  call fnToISOStringLocTzo    nowMs
    * def nowISODateLTzoMs =  call fnGetEpochTimeMs       nowISODateLocTzo
    * def nowISODateLTzoMin = call fnGetTimezoneOffset    nowISODateLocTzo

    * def nowISODateUTCTzo =  call fnToISOStringUTCTzo    nowMs
    * def nowISODateUTCTzo8 = call fnToISOStringUTCTzo    nowISODateLocTzo
    * def nowISODateUTzoMs =  call fnGetEpochTimeMs       nowISODateUTCTzo
    * def nowISODateUTzoMin = call fnGetTimezoneOffset    nowISODateUTCTzo

    * def now000000ISODate =  call fnGetISODateStartOfDay nowMs
    * def now235959ISODate =  call fnGetISODateEndOfDay   nowMs

    * def nowStartISODate4 =  fnAbbrevISODateTzo( fnConvertISODateTzoToGivenTzo( now000000ISODate, "+0800" ) )
    * def nowEndISODate4 =    fnAbbrevISODateTzo( fnConvertISODateTzoToGivenTzo( now235959ISODate, "+0800" ) )

    * def nowISODateAsUTC =   call fnCreateDateAsUTC      nowMs
    * def nowISODateToUTC =   call fnConvertDateToUTC     nowMs

    * def incDateReq =        requestBody_createThirdParty.incorporationDate
    * def incDateResp =       response.data.incorporationDate

    And match nowISODate ==   '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'
    And match incDateReq ==   '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'
    And match incDateResp ==  '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'

    And print '\n'
    And print '================================'
    And print '******** UPDATE THIRD-PARTY: CREATE THIRD-PARTY'
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
                                                                  value:               "##[]",
                                                                  required:            "##boolean"

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
                              "autoScreen":             '##boolean',
                              "countryAlerts":          '##string',
                              "description":            '##string',
                              "createTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
                              "updateTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
                           }
              }
          """



#
# CHECK: Retrieve third-party BY ID - expected: FOUND
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
    And print '******** UPDATE THIRD-PARTY: RETRIEVE THIRD-PARTY BY ID'
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'



#
# TODO: Validate response body schema: NO NEED?
#



#
# CHECK: Get third-parties LIST for this day - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty'
    And param pageSize =       400
    And param start =          nowStartISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def thirdPartyIds = get response.data[*].id
    And assert thirdPartyIds.contains( thirdPartyIdResult )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** UPDATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIds      = '+ thirdPartyIds
    And print '================================\n'
    And print '\n'



#
# UPDATE third-party by id
#
    * def requestBody_updateThirdParty =
      """
          {
            "name": "ABC-2021 INC LLC PTY",
            "currency": "PHP",
            "industryType": "EDU",
            "businessType": "PRI",
            "address": {
              "addressLine": "22 Main Ave.",
              "city": "Zombieland City",
              "country": "US",
              "postalCode": "90210",
              "province": "California",
              "region": "019"
            },
            "contactInformation": {
              "email": [
                "albert.redenson@abc.com",
                "ards@abc.com"
              ],
              "fax": [
                "+001 (017) 528-7846"
              ],
              "phoneNumber": [
                "123-8658-6053"
              ],
              "website": [
                "http://www.abc.com",
                "https://www.abc.com",
                "https://www.abc.co.uk"
              ]
            },
            "description": "Acme Ball Cojones"
          }
      """

    Given url deleteUrl = baseTestUrl
#    And path 'thirdparty', thirdPartyIdResult
    And path 'thirdparty'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header If-Match = eTag
    And request requestBody_updateThirdParty
    When method PATCH
    Then status 500


#
#    Given url deleteUrl = baseTestUrl
#    And path 'thirdparty', thirdPartyIdResult
##    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    And header If-Match = eTag
#    And request requestBody_updateThirdParty
#    When method PATCH
#    Then status 404
#
#
#
#    Given url deleteUrl = baseTestUrl
#    And path 'thirdparty', thirdPartyIdResult
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
##    And header If-Match = eTag
#    And request requestBody_updateThirdParty
#    When method PATCH
#    Then status 500



    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdResult
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header If-Match = eTag
#    And request requestBody_updateThirdParty
    And request '{}'
    When method PATCH
    Then status 500



#    And match requestBody_updateThirdParty.name ==                           response.data.name
#    And match requestBody_updateThirdParty.currency ==                       response.data.currency
#    And match requestBody_updateThirdParty.industryType ==                   response.data.industryType
#    And match requestBody_updateThirdParty.businessType ==                   response.data.businessType
#
#    And match requestBody_updateThirdParty.address.addressLine ==            response.data.address.addressLine
#    And match requestBody_updateThirdParty.address.city ==                   response.data.address.city
#    And match requestBody_updateThirdParty.address.country ==                response.data.address.country
#    And match requestBody_updateThirdParty.address.postalCode ==             response.data.address.postalCode
#    And match requestBody_updateThirdParty.address.province ==               response.data.address.province
#    And match requestBody_updateThirdParty.address.region ==                 response.data.address.region
#
#    And match requestBody_updateThirdParty.contactInformation.email[*]       contains only  response.data.contactInformation.email
#    And match requestBody_updateThirdParty.contactInformation.fax[*]         contains only  response.data.contactInformation.fax
#    And match requestBody_updateThirdParty.contactInformation.phoneNumber[*] contains only  response.data.contactInformation.phoneNumber
#    And match requestBody_updateThirdParty.contactInformation.website[*]     contains only  response.data.contactInformation.website




# DELETE third-party by id
#
    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdResult
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204



#
# CHECK: Retrieve third-party BY ID - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdResult
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 404



#
# CHECK: Get third-parties LIST for this day - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty'
    And param pageSize =       400
    And param start =          nowStartISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def thirdPartyIds = get response.data[*].id
    And assert !thirdPartyIds.contains( thirdPartyIdResult )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** UPDATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIds      = '+ thirdPartyIds
    And print '================================\n'
    And print '\n'








  Scenario: 3. C36135450 [RMS-5597] - Public API
              - Verify Partially Update Third Party
              - Adding of up to max of 10 bank details and Updating/Removing existing bank details

#
# Update Third Party
#


#
# CREATE third-party
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



    * def nowMs =             call fnGetNowMs
    * def nowISODate =        call fnGetISODate           nowMs
    * def nowEpochTimeMs =    call fnGetEpochTimeMs       nowISODate

    * def nowISODateLocTzo =  call fnToISOStringLocTzo    nowMs
    * def nowISODateLTzoMs =  call fnGetEpochTimeMs       nowISODateLocTzo
    * def nowISODateLTzoMin = call fnGetTimezoneOffset    nowISODateLocTzo

    * def nowISODateUTCTzo =  call fnToISOStringUTCTzo    nowMs
    * def nowISODateUTCTzo8 = call fnToISOStringUTCTzo    nowISODateLocTzo
    * def nowISODateUTzoMs =  call fnGetEpochTimeMs       nowISODateUTCTzo
    * def nowISODateUTzoMin = call fnGetTimezoneOffset    nowISODateUTCTzo

    * def now000000ISODate =  call fnGetISODateStartOfDay nowMs
    * def now235959ISODate =  call fnGetISODateEndOfDay   nowMs

    * def nowStartISODate4 =  fnAbbrevISODateTzo( fnConvertISODateTzoToGivenTzo( now000000ISODate, "+0800" ) )
    * def nowEndISODate4 =    fnAbbrevISODateTzo( fnConvertISODateTzoToGivenTzo( now235959ISODate, "+0800" ) )

    * def nowISODateAsUTC =   call fnCreateDateAsUTC      nowMs
    * def nowISODateToUTC =   call fnConvertDateToUTC     nowMs

    * def incDateReq =        requestBody_createThirdParty.incorporationDate
    * def incDateResp =       response.data.incorporationDate

    And match nowISODate ==   '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'
    And match incDateReq ==   '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'
    And match incDateResp ==  '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'

    And print '\n'
    And print '================================'
    And print '******** UPDATE THIRD-PARTY: CREATE THIRD-PARTY'
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
                                                                  value:               "##[]",
                                                                  required:            "##boolean"

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
                              "autoScreen":             '##boolean',
                              "countryAlerts":          '##string',
                              "description":            '##string',
                              "createTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
                              "updateTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
                           }
              }
          """



#
# CHECK: Retrieve third-party BY ID - expected: FOUND
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
    And print '******** UPDATE THIRD-PARTY: RETRIEVE THIRD-PARTY BY ID'
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'



#
# TODO: Validate response body schema: NO NEED?
#



#
# CHECK: Get third-parties LIST for this day - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty'
    And param pageSize =       400
    And param start =          nowStartISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def thirdPartyIds = get response.data[*].id
    And assert thirdPartyIds.contains( thirdPartyIdResult )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** UPDATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIds      = '+ thirdPartyIds
    And print '================================\n'
    And print '\n'



#
# UPDATE third-party by id - use MAXIMUM 10 'bank details'
#
    * def requestBody_updateThirdParty =
      """
          {
            "bankDetails": [
              {
                "accountNo": "123-45678900-01",
                "addressLine": "Address 1",
                "branchName": "Branch Name 1",
                "city": "City 1",
                "country": "US",
                "name": "Bank Name 1"
              },
              {
                "accountNo": "123-45678900-02",
                "addressLine": "Address 2",
                "branchName": "Branch Name 2",
                "city": "City 2",
                "country": "US",
                "name": "Bank Name 2"
              },
              {
                "accountNo": "123-45678900-03",
                "addressLine": "Address 3",
                "branchName": "Branch Name 3",
                "city": "City 3",
                "country": "US",
                "name": "Bank Name 3"
              },
              {
                "accountNo": "123-45678900-04",
                "addressLine": "Address 4",
                "branchName": "Branch Name 4",
                "city": "City 4",
                "country": "US",
                "name": "Bank Name 4"
              },
              {
                "accountNo": "123-45678900-05",
                "addressLine": "Address 5",
                "branchName": "Branch Name 5",
                "city": "City 5",
                "country": "US",
                "name": "Bank Name 5"
              },
              {
                "accountNo": "123-45678900-06",
                "addressLine": "Address 6",
                "branchName": "Branch Name 6",
                "city": "City 6",
                "country": "US",
                "name": "Bank Name 6"
              },
              {
                "accountNo": "123-45678900-07",
                "addressLine": "Address 7",
                "branchName": "Branch Name 7",
                "city": "City 7",
                "country": "US",
                "name": "Bank Name 7"
              },
              {
                "accountNo": "123-45678900-08",
                "addressLine": "Address 8",
                "branchName": "Branch Name 8",
                "city": "City 8",
                "country": "US",
                "name": "Bank Name 8"
              },
              {
                "accountNo": "123-45678900-09",
                "addressLine": "Address 9",
                "branchName": "Branch Name 9",
                "city": "City 9",
                "country": "US",
                "name": "Bank Name 9"
              },
              {
                "accountNo": "123-45678900-10",
                "addressLine": "Address 10",
                "branchName": "Branch Name 10",
                "city": "City 10",
                "country": "US",
                "name": "Bank Name 10"
              }
            ]
          }
      """

    Given url patchUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdResult
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header If-Match = eTag
    And request requestBody_updateThirdParty
    When method PATCH
    Then status 200


    * def requestBody_updateThirdParty_bankDetails_length =                  requestBody_updateThirdParty.bankDetails.length
    * def response_data_bankDetails_length =                                 response.data.bankDetails.length
    And match requestBody_updateThirdParty_bankDetails_length ==             response_data_bankDetails_length
    And match requestBody_updateThirdParty.bankDetails[*]     contains only  response.data.bankDetails

    * def eTag = responseHeaders['ETag'][0].split('"')[1]

    And print '\n'
    And print '================================'
    And print '******** UPDATE THIRD-PARTY: UPDATE BANK DETAILS: EXCEED MAX COUNT'
    And print '******** thirdPartyIdResult        = '+ thirdPartyIdResult
    And print '******** COUNT: bankDetails.length = '+ response_data_bankDetails_length
    And print '******** eTag                      = '+ eTag
    And print '================================\n'
    And print '\n'



##
## UPDATE third-party by id - use MAXIMUM 10 'other names'
##
#    * def requestBody_updateThirdParty =
#      """
#          {
#            "otherNames": [
#              {
#                "name": "Local Name  01",
#                "iwNameType": "Local Language Name",
#                "countryOfRegistration": "US"
#              },
#              {
#                "name": "Local Name  02",
#                "iwNameType": "Local Language Name",
#                "countryOfRegistration": "US"
#              },
#              {
#                "name": "Local Name  03",
#                "iwNameType": "Local Language Name",
#                "countryOfRegistration": "US"
#              },
#              {
#                "name": "Local Name  04",
#                "iwNameType": "Local Language Name",
#                "countryOfRegistration": "US"
#              },
#              {
#                "name": "Local Name  05",
#                "iwNameType": "Local Language Name",
#                "countryOfRegistration": "US"
#              },
#              {
#                "name": "Local Name  06",
#                "iwNameType": "Local Language Name",
#                "countryOfRegistration": "US"
#              },
#              {
#                "name": "Local Name  07",
#                "iwNameType": "Local Language Name",
#                "countryOfRegistration": "US"
#              },
#              {
#                "name": "Local Name  08",
#                "iwNameType": "Local Language Name",
#                "countryOfRegistration": "US"
#              },
#              {
#                "name": "Local Name  09",
#                "iwNameType": "Local Language Name",
#                "countryOfRegistration": "US"
#              },
#              {
#                "name": "Local Name  10",
#                "iwNameType": "Local Language Name",
#                "countryOfRegistration": "US"
#              }
#            ]
#          }
#      """
#
#    Given url patchUrl = baseTestUrl
#    And path 'thirdparty', thirdPartyIdResult
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    And header If-Match = eTag
#    And request requestBody_updateThirdParty
#    When method PATCH
#    Then status 200
#
#
#    * def requestBody_updateThirdParty_otherNames_length =                  requestBody_updateThirdParty.otherNames.length
#    * def response_data_otherNames_length =                                 response.data.otherNames.length
#    And match requestBody_updateThirdParty_otherNames_length ==             response.data.otherNames.length
#    And match requestBody_updateThirdParty.otherNames[*]     contains only  response.data.otherNames
#
#    And print '\n'
#    And print '================================'
#    And print '******** UPDATE THIRD-PARTY: UPDATE OTHER NAMES'
#    And print '******** thirdPartyIdResult        = '+ thirdPartyIdResult
#    And print '******** COUNT: otherNames.length  = '+ response_data_otherNames_length
#    And print '================================\n'
#   And print '\n'



#
# UPDATE third-party by id - use 11 'bank details' (EXCEEDS maximum 10)
#
    * def requestBody_updateThirdParty =
      """
          {
            "bankDetails": [
              {
                "accountNo": "123-45678900-01",
                "addressLine": "Address 1",
                "branchName": "Branch Name 1",
                "city": "City 1",
                "country": "US",
                "name": "Bank Name 1"
              },
              {
                "accountNo": "123-45678900-02",
                "addressLine": "Address 2",
                "branchName": "Branch Name 2",
                "city": "City 2",
                "country": "US",
                "name": "Bank Name 2"
              },
              {
                "accountNo": "123-45678900-03",
                "addressLine": "Address 3",
                "branchName": "Branch Name 3",
                "city": "City 3",
                "country": "US",
                "name": "Bank Name 3"
              },
              {
                "accountNo": "123-45678900-04",
                "addressLine": "Address 4",
                "branchName": "Branch Name 4",
                "city": "City 4",
                "country": "US",
                "name": "Bank Name 4"
              },
              {
                "accountNo": "123-45678900-05",
                "addressLine": "Address 5",
                "branchName": "Branch Name 5",
                "city": "City 5",
                "country": "US",
                "name": "Bank Name 5"
              },
              {
                "accountNo": "123-45678900-06",
                "addressLine": "Address 6",
                "branchName": "Branch Name 6",
                "city": "City 6",
                "country": "US",
                "name": "Bank Name 6"
              },
              {
                "accountNo": "123-45678900-07",
                "addressLine": "Address 7",
                "branchName": "Branch Name 7",
                "city": "City 7",
                "country": "US",
                "name": "Bank Name 7"
              },
              {
                "accountNo": "123-45678900-08",
                "addressLine": "Address 8",
                "branchName": "Branch Name 8",
                "city": "City 8",
                "country": "US",
                "name": "Bank Name 8"
              },
              {
                "accountNo": "123-45678900-09",
                "addressLine": "Address 9",
                "branchName": "Branch Name 9",
                "city": "City 9",
                "country": "US",
                "name": "Bank Name 9"
              },
              {
                "accountNo": "123-45678900-10",
                "addressLine": "Address 10",
                "branchName": "Branch Name 10",
                "city": "City 10",
                "country": "US",
                "name": "Bank Name 10"
              },
              {
                "accountNo": "123-45678900-11",
                "addressLine": "Address 11",
                "branchName": "Branch Name 11",
                "city": "City 11",
                "country": "US",
                "name": "Bank Name 11"
              }
            ]
          }
      """

    Given url patchUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdResult
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header If-Match = eTag
    And request requestBody_updateThirdParty
    When method PATCH
    Then status 400



#
# VALIDATE ERROR response body SCHEMA
#
    And match response ==
          """
              {
                  "errors": '##[] ^^ {
                                         "field":       "bankDetails",
                                         "code":        "SI-ERR-002",
                                         "description": "##regex ^.*[(should not exceed the maximum length!)]$"
                                     }'
              }
          """




#
# DELETE third-party by id
#
    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdResult
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204



#
# CHECK: Retrieve third-party BY ID - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdResult
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 404



#
# CHECK: Get third-parties LIST for this day - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty'
    And param pageSize =       400
    And param start =          nowStartISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def thirdPartyIds = get response.data[*].id
    And assert !thirdPartyIds.contains( thirdPartyIdResult )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** UPDATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIds      = '+ thirdPartyIds
    And print '================================\n'
    And print '\n'



  Scenario: 4. C36132846 [RMS-5597] - Public API
               - Verify Partially Update Third Party- Request field parameter that doesn't exist

#
# Update Third Party
#


#
# CREATE third-party
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



    * def nowMs =             call fnGetNowMs
    * def nowISODate =        call fnGetISODate           nowMs
    * def nowEpochTimeMs =    call fnGetEpochTimeMs       nowISODate

    * def nowISODateLocTzo =  call fnToISOStringLocTzo    nowMs
    * def nowISODateLTzoMs =  call fnGetEpochTimeMs       nowISODateLocTzo
    * def nowISODateLTzoMin = call fnGetTimezoneOffset    nowISODateLocTzo

    * def nowISODateUTCTzo =  call fnToISOStringUTCTzo    nowMs
    * def nowISODateUTCTzo8 = call fnToISOStringUTCTzo    nowISODateLocTzo
    * def nowISODateUTzoMs =  call fnGetEpochTimeMs       nowISODateUTCTzo
    * def nowISODateUTzoMin = call fnGetTimezoneOffset    nowISODateUTCTzo

    * def now000000ISODate =  call fnGetISODateStartOfDay nowMs
    * def now235959ISODate =  call fnGetISODateEndOfDay   nowMs

    * def nowStartISODate4 =  fnAbbrevISODateTzo( fnConvertISODateTzoToGivenTzo( now000000ISODate, "+0800" ) )
    * def nowEndISODate4 =    fnAbbrevISODateTzo( fnConvertISODateTzoToGivenTzo( now235959ISODate, "+0800" ) )

    * def nowISODateAsUTC =   call fnCreateDateAsUTC      nowMs
    * def nowISODateToUTC =   call fnConvertDateToUTC     nowMs

    * def incDateReq =        requestBody_createThirdParty.incorporationDate
    * def incDateResp =       response.data.incorporationDate

    And match nowISODate ==   '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'
    And match incDateReq ==   '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'
    And match incDateResp ==  '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'

    And print '\n'
    And print '================================'
    And print '******** UPDATE THIRD-PARTY: CREATE THIRD-PARTY'
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
                                                                  value:               "##[]",
                                                                  required:            "##boolean"

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
                              "autoScreen":             '##boolean',
                              "countryAlerts":          '##string',
                              "description":            '##string',
                              "createTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
                              "updateTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
                           }
              }
          """



#
# CHECK: Retrieve third-party BY ID - expected: FOUND
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
    And print '******** UPDATE THIRD-PARTY: RETRIEVE THIRD-PARTY BY ID'
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'



#
# TODO: Validate response body schema: NO NEED?
#



#
# CHECK: Get third-parties LIST for this day - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty'
    And param pageSize =       400
    And param start =          nowStartISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def thirdPartyIds = get response.data[*].id
    And assert thirdPartyIds.contains( thirdPartyIdResult )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** UPDATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIds      = '+ thirdPartyIds
    And print '================================\n'
    And print '\n'



#
# UPDATE third-party by id: INVALID FIELD VALUES
#
    * def requestBody_updateThirdParty =
      """
          {
            "name": "ABC-2021 INC LLC PTY",
            "companyType": "CORPX",
            "organizationSize": "11-50X",
            "affiliation": "SOEX",
            "revenue": "10MX",
            "currency": "PHPX",
            "industryType": "EDUX",
            "businessType": "PRIX",
            "spendCategory": "OTSX",
            "sourcingMethod": "DIST_M_SRCX",
            "productDesignAgreement": "OTSX",
            "sourcingType": "MULTIX",
            "relationshipVisibility": "LITTLE_VISX",
            "productImpact": "COMMODITIZED_PRODUCTX",
            "commodityType": "A3PX"
          }
      """

    Given url patchUrl = baseTestUrl
    And path 'thirdparty', thirdPartyIdResult
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header If-Match = eTag
    And request requestBody_updateThirdParty
    When method PATCH
    Then status 400

    * def requestBadFields = [ "organizationSize", "relationshipVisibility", "businessType", "businessType", "companyType", "spendCategory", "industryType", "productDesignAgreement", "sourcingMethod", "commodityType", "affiliation", "sourcingType", "revenue", "productImpact", "currency" ]
    * def responseBadFields = get response.errors[*].field

    And match responseBadFields contains only requestBadFields




#
# VALIDATE ERROR response body SCHEMA
#
    And match response ==
          """
                {
                    "errors": '##[] ^^ {
                                         "field":       "#? requestBadFields.contains(_)",
                                         "code":        "##regex ^.*[(SI\-ERR\-003)|(SI\-ERR\-006)]$",
                                         "description": "##regex ^.*[(is not valid.)|(did not match!)]$"
                                       }'

                }
          """













