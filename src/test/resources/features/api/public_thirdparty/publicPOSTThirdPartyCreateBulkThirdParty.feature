@api @public_api @postPublicThirdPartyCreateBulkThirdParty
Feature: Create Bulk Third Party



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
    * print '******** workflowGroupId  = '+ workflowGroupId
    * print '******** parent           = '+ parent
    * print '================================'
    And print '\n'



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

    And match nowISODate ==   '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'




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



  Scenario: 1) C36332292 Public API - POST /thirdparty/bulk
               - Verify that third party is successfully created

#
# CREATE bulk third-party
#
    * def requestBody_createBulkThirdParty =
      """
          [
            {
              "referenceNo": null,
              "name": "ABC-20210819 Corp",
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
            },
            {
              "referenceNo": null,
              "name": "XYZ-20210819 Corp",
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
          ]
      """

    Given url postUrl = baseTestUrl
    And path 'thirdparty/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_createBulkThirdParty
    When method POST
    Then status 207

    * def resultThirdPartyIds = get response.data[*].resource.id

    * def countReceived = response.data.length
    * def countCreated =  resultThirdPartyIds.length
    And match countReceived == 2
    And match countCreated == 2

    And print '\n'
    And print '================================'
    And print '******** CREATE BULK THIRD-PARTY: 2 THIRD-PARTYS'
    And print '******** COUNT RECEIVED      = '+ countReceived
    And print '******** COUNT CREATED       = '+ countCreated
    And print '******** resultThirdPartyIds = '+ resultThirdPartyIds
    And print '================================\n'
    And print '\n'



#
# VALIDATE response body SCHEMA
#
    And match response ==
          """
              {
                "message": '##string',
                "data":    '##[] ^ {
                                       "index":              "##number",
                                       "message":            "201(Created) The request has been created successfully.",
                                       "resource":           {
                                                                 "id":   "##string",
                                                                 "link": "##string"
                                                             },
                                       "errors":             null,
                                       "status":             201
                                   }'
              }
          """



#
# CONVERT ARRAY 'resultThirdPartyIds' into key-value
# JSON ARRAY OBJECT
# [
#    { 'thirdPartyId': 'XXXXXXXX' },
#    { 'thirdPartyId': 'XXXXXXXX' }
# ]
#
    * def thirdPartyIdsObj = karate.mapWithKey( resultThirdPartyIds, 'thirdPartyId' )



#
# RETRIEVE third-party by id: ITERATE over array
#
    * def getByIdResponses =         call read( './publicPOSTThirdPartyCreateBulkThirdParty_RetrieveById.feature' ) thirdPartyIdsObj
    * def getByIdThirdPartyIds =     $getByIdResponses[*].response.data.id
    And match resultThirdPartyIds == getByIdThirdPartyIds

    * def count = getByIdThirdPartyIds.length
    And print '\n'
    And print '================================'
    And print '******** CREATE BULK THIRD-PARTY'
    And print '******** COUNT: getByIdThirdPartyIds.length = '+ count
    And print '********        getByIdThirdPartyIds        = '+ getByIdThirdPartyIds
    And print '================================\n'
    And print '\n'



#
# DELETE third-party by id: ITERATE over array
#
    * def deleteByIdResponses = call read( './publicPOSTThirdPartyCreateBulkThirdParty_DeleteById.feature' ) thirdPartyIdsObj



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

    * def checkThirdPartyIds = get response.data[*].id
    And assert !checkThirdPartyIds.contains( resultThirdPartyIds )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE BULK THIRD-PARTY: DELETE THIRD-PARTY CLEANUP'
    And print '******** COUNT: data.length =  '+ count
    And print '******** resultThirdPartyIds = '+ resultThirdPartyIds
    And print '******** checkThirdPartyIds =  '+ checkThirdPartyIds
    And print '================================\n'
    And print '\n'



## = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
## = = = = = = = = CLEAN-UP! = = = = = = = = = = = = = = = = = = = = = = = = = = =
## = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
#
#
#
#
##
## DELETE third-party by id: ITERATE over array
##
##
## CONVERT ARRAY 'resultThirdPartyIds' into key-value
## JSON ARRAY OBJECT
## [
##    { 'thirdPartyId': 'XXXXXXXX' },
##    { 'thirdPartyId': 'XXXXXXXX' }
## ]
##
#    * def thirdPartyIdsObj = karate.mapWithKey( checkThirdPartyIds, 'thirdPartyId' )
#
#
#
##
## DELETE third-party by id: ITERATE over array
##
#    * def deleteByIdResponses = call read( './publicPOSTThirdPartyCreateBulkThirdParty_DeleteById.feature' ) thirdPartyIdsObj
#



  Scenario: 2) C36332294 Public API - POST /thirdparty/bulk
               - Verify error in response body if fields did not exist/invalid

#
# CREATE bulk third-party
#
    * def requestBody_createThirdParty =
      """
          [
              {
                "referenceNo": null,
                "name": "ABC Corp",
                "currency": "USDX",
                "companyType": "CORPX",
                "industryType": "AHIX",
                "organizationSize": "11-50X",
                "businessType": "PRSX",
                "incorporationDate": "2021-06-18T05:32:07-0800",
                "revenue": "10MX",
                "responsibleParty": "rddcentre.admin.np@refinitiv.com",
                "liquidationDate": "2021-06-18T05:32:07-0800",
                "divisions": [
                  "InvalidDivisionX"
                ],
                "affiliation": "SOEX",
                "workflowGroupId": "#(workflowGroupId)",
                "spendCategory": "OTSX",
                "sourcingMethod": "DIST_M_SRCX",
                "productDesignAgreement": "OTSX",
                "sourcingType": "MULTIX",
                "relationshipVisibility": "LITTLE_VISX",
                "productImpact": "COMMODITIZED_PRODUCTX",
                "commodityType": "A3PX",
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
              },
              {
                "referenceNo": null,
                "name": "XYZ Corp",
                "currency": "USDX",
                "companyType": "CORPX",
                "industryType": "AHIX",
                "organizationSize": "11-50X",
                "businessType": "PRSX",
                "incorporationDate": "2021-06-18T05:32:07-0800",
                "revenue": "10MX",
                "responsibleParty": "rddcentre.admin.np@refinitiv.com",
                "liquidationDate": "2021-06-18T05:32:07-0800",
                "divisions": [
                  "InvalidDivisionX"
                ],
                "affiliation": "SOEX",
                "workflowGroupId": "#(workflowGroupId)",
                "spendCategory": "OTSX",
                "sourcingMethod": "DIST_M_SRCX",
                "productDesignAgreement": "OTSX",
                "sourcingType": "MULTIX",
                "relationshipVisibility": "LITTLE_VISX",
                "productImpact": "COMMODITIZED_PRODUCTX",
                "commodityType": "A3PX",
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
          ]
      """

    Given url postUrl = baseTestUrl
    And path 'thirdparty/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_createThirdParty
    When method POST
    Then status 207

    * def resultThirdPartyIds = get response.data[*].resource.id

    * def countReceived = response.data.length
    * def countCreated =  resultThirdPartyIds.length
    And match countReceived == 2
    And match countCreated == 0

    And print '\n'
    And print '================================'
    And print '******** CREATE BULK THIRD-PARTY: INVALID DATA'
    And print '******** COUNT RECEIVED      = '+ countReceived
    And print '******** COUNT CREATED       = '+ countCreated
    And print '******** resultThirdPartyIds = '+ resultThirdPartyIds
    And print '================================\n'
    And print '\n'



#
# VALIDATE response body SCHEMA
#
    And match response ==
          """
              {
                "message": "##string",
                "data":    "##[] ^ {
                                       index:              '##number',
                                       message:            'Bad Request',
                                       resource:           null,
                                       errors:             '##[] ^ {
                                                                         field:       \"#string\",
                                                                         code:        \"##regex ^.*[(SI\-ERR\-003)|(SI\-ERR\-006)]$\",
                                                                         description: \"##regex ^.*[(did not match!)|(is not valid.)]$\"
                                                                     }',
                                       status:             400
                                   }"
              }
          """


#
#    * def thirdPartyIdsObj = karate.mapWithKey( resultThirdPartyIds, 'thirdPartyId' )
#
#
#
##
## RETRIEVE third-party by id: ITERATE over array
##
#    * def getByIdResponses =         call read( './publicPOSTThirdPartyCreateBulkThirdParty_RetrieveById.feature' ) thirdPartyIdsObj
#    * def getByIdThirdPartyIds =     $getByIdResponses[*].response.data.id
#    And match resultThirdPartyIds == getByIdThirdPartyIds
#
#    * def count = getByIdThirdPartyIds.length
#    And print '\n'
#    And print '================================'
#    And print '******** CREATE BULK THIRD-PARTY'
#    And print '******** COUNT: getByIdThirdPartyIds.length = '+ count
#    And print '********        getByIdThirdPartyIds        = '+ getByIdThirdPartyIds
#    And print '================================\n'
#    And print '\n'
#
#
#
##
## DELETE third-party by id: ITERATE over array
##
#    * def deleteByIdResponses = call read( './publicPOSTThirdPartyCreateBulkThirdParty_DeleteById.feature' ) thirdPartyIdsObj
#
#
#
##
## CHECK: Get third-parties LIST for this day - expected: NOT FOUND
##
#    Given url getUrl = baseTestUrl
#    And path 'thirdparty'
#    And param pageSize =       400
#    And param start =          nowStartISODate4
#    And param end =            nowEndISODate4
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method GET
#    Then status 200
#
#    * def checkThirdPartyIds = get response.data[*].id
#    And assert !checkThirdPartyIds.contains( resultThirdPartyIds )
#
#    * def count = response.data.length
#    And print '\n'
#    And print '================================'
#    And print '******** CREATE BULK THIRD-PARTY: DELETE THIRD-PARTY CLEANUP'
#    And print '******** COUNT: data.length =  '+ count
#    And print '******** resultThirdPartyIds = '+ resultThirdPartyIds
#    And print '******** checkThirdPartyIds =  '+ checkThirdPartyIds
#    And print '================================\n'
#    And print '\n'



  Scenario: 3) C36332295 Public API - POST /thirdparty/bulk
               - Verify error if Reference No. already exists

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

    And match nowISODate ==   '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'


#
# CREATE third-party
#
    * def requestBody_createThirdParty =
      """
          {
            "referenceNo": '#(nowMs)',
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
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY BY ID'
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
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIds      = '+ thirdPartyIds
    And print '================================\n'
    And print '\n'



#
# CREATE bulk third-party: DUPLICATE REFERENCE NO.
#
    * def requestBody_createBulkThirdParty =
      """
          [
              {
                "referenceNo": '#(nowMs)',
                "name": "XYZ Corp",
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
          ]
      """

    Given url postUrl = baseTestUrl
    And path 'thirdparty/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_createBulkThirdParty
    When method POST
    Then status 207

    * def resultThirdPartyIds = get response.data[*].resource.id

    * def countReceived = response.data.length
    * def countCreated =  resultThirdPartyIds.length
    And match countReceived == 1
    And match countCreated == 0

    And print '\n'
    And print '================================'
    And print '******** CREATE BULK THIRD-PARTY: DUPLICATE REFERENCE NO.'
    And print '******** COUNT RECEIVED      = '+ countReceived
    And print '******** COUNT CREATED       = '+ countCreated
    And print '******** resultThirdPartyIds = '+ resultThirdPartyIds
    And print '================================\n'
    And print '\n'



#
# VALIDATE response body SCHEMA
#
    And match response ==
          """
              {
                "message": "##string",
                "data":    "##[] ^ {
                                       index:              0,
                                       message:            'Bad Request',
                                       resource:           null,
                                       errors:             [
                                                             {
                                                               field:       \"referenceNo\",
                                                               code:        \"##regex ^.*[(SI\-ERR\-003)]$\",
                                                               description: \"##regex ^.*[(did not match!)|(is not valid.)]$\"
                                                             }
                                                           ],
                                       status:             400
                                   }"
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
    And print '******** CREATE BULK THIRD-PARTY: DUPLICATE REFERENCE NO.; DELETE THIRD-PARTY'
    And print '******** COUNT: data.length = '+ count
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIds      = '+ thirdPartyIds
    And print '================================\n'
    And print '\n'



  Scenario: 4) C36332296 Public API - POST /thirdparty/bulk
               - Verify error if correlated values did not match


#
# CREATE third-party: UNCORRELATED DATA
#
# Business Type that doesn't match with Industry Type
# Example:
# "industryType": "AHI",
# "businessType": "MIL",
#
# Country that doesn't match with Region
# Example:
# "region": "142"
# "country": "CA"
#
# Division that doesn't match with responsible party
# "responsibleParty": "si_admin@yopmail.com"
# "divisions": [
#     "New Division"
# ]
#

    * def requestBody_createBulkThirdParty =
      """
          [
              {
                "referenceNo": null,
                "name": "ABC Corp",
                "currency": "USD",
                "companyType": "CORP",
                "industryType": "AHI",
                "organizationSize": "11-50",
                "businessType": "MIL",
                "incorporationDate": "2021-06-18T05:32:07-0800",
                "revenue": "10M",
                "responsibleParty": "rddcentre.admin.np@refinitiv.com",
                "liquidationDate": "2021-06-18T05:32:07-0800",
                "divisions": [
                  "NewDivision"
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
                  "country": "CA",
                  "postalCode": "31080",
                  "province": "Province 1",
                  "region": "#(regionX)"
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
          ]
      """

    Given url postUrl = baseTestUrl
    And path 'thirdparty/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_createBulkThirdParty
    When method POST
    Then status 207

    * def resultThirdPartyIds = get response.data[*].resource.id

    * def countReceived = response.data.length
    * def countCreated =  resultThirdPartyIds.length
    And match countReceived == 1
    And match countCreated == 0

    And print '\n'
    And print '================================'
    And print '******** CREATE BULK THIRD-PARTY: UNCORRELATED DATA'
    And print '******** COUNT RECEIVED      = '+ countReceived
    And print '******** COUNT CREATED       = '+ countCreated
    And print '******** resultThirdPartyIds = '+ resultThirdPartyIds
    And print '================================\n'
    And print '\n'



#
# VALIDATE response body SCHEMA
#
    And match response ==
          """
              {
                "message": "##string",
                "data":    "##[] ^ {
                                       index:              '#number',
                                       message:            'Bad Request',
                                       resource:           null,
                                       errors:             '##[] ^ {
                                                                         field:       \"#string\",
                                                                         code:        \"##regex ^.*[(SI\-ERR\-006)]$\",
                                                                         description: \"##regex ^.*[(did not match!)]$\"
                                                                   }',
                                       status:             400
                                   }"
              }
          """




  Scenario: 5) C36332297 Public API - POST /thirdparty/bulk
               - Verify error for invalid format ('email', 'phoneNumber', 'website')


#
# CREATE BULK Third Party:
#
# BAD FORMAT: 'email', 'phoneNumber', 'website'
#

    * def requestBody_createBulkThirdParty =
      """
          [
            {
              "referenceNo": null,
              "name": "ABC-20210819 Corp",
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
                  "john.smith#company1.com"
                ],
                "fax": [
                  "+91 (123) 456-7890"
                ],
                "phoneNumber": [
                  "123-ABC-7890"
                ],
                "website": [
                  "company123"
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
          ]
      """

    Given url postUrl = baseTestUrl
    And path 'thirdparty/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_createBulkThirdParty
    When method POST
    Then status 207

    * def resultThirdPartyIds = get response.data[*].resource.id

    * def countReceived = response.data.length
    * def countCreated =  resultThirdPartyIds.length
    And match countReceived == 1
    And match countCreated == 0

#   * def requestBadFields = [ "contactInformation.email", "contactInformation.phoneNumber", "contactInformation.website" ]
#   * def requestBadFields = [ "contactInformation.email[0].<list element>", "contactInformation.website[0].<list element>" ]
    * def requestBadFields = [ "contactInformation.email[0].<list element>", "contactInformation.website[0].<list element>", "contactInformation.phoneNumber[0].<list element>" ]
    * def responseBadFields = get response.data[*].errors[*].field

    And print '\n'
    And print '================================'
    And print '******** CREATE BULK THIRD-PARTY: BAD FORMAT DATA'
    And print '******** COUNT RECEIVED      = '+ countReceived
    And print '******** COUNT CREATED       = '+ countCreated
    And print '******** resultThirdPartyIds = '+ resultThirdPartyIds
    And print '******** requestBadFields    = '+ requestBadFields
    And print '******** responseBadFields   = '+ responseBadFields
    And print '================================\n'
    And print '\n'

#   And match requestBadFields contains only responseBadFields
    And match responseBadFields contains      requestBadFields



#
# VALIDATE response body SCHEMA
#
    And match response ==
          """
              {
                "message": "##string",
                "data":    "##[] ^ {
                                       index:              '#number',
                                       message:            'Bad Request',
                                       resource:           null,
                                       errors:             '##[] ^ {
                                                                         field:       \"#? requestBadFields.contains(_)\",
                                                                         code:        \"##regex ^.*[(SI\-ERR\-003)]$\",
                                                                         description: \"##regex ^.*[(is not valid.)]$\"
                                                                   }',
                                       status:             400
                                   }"
              }
          """




  Scenario: 6) C36332298 Public API - POST /thirdparty/bulk
               - Verify error for invalid values in data parameter


#
# CREATE BULK Third Party:
#
#
# "currency":               "USDX",
# "companyType":            "CORPX",
# "industryType":           "AHIX",
# "organizationSize":       "11-50X",
# "businessType":           "PRSX",
# "revenue":                "10MX",
# "affiliation":            "SOEX",
# "spendCategory":          "OTSX",
# "sourcingMethod":         "DIST_M_SRCX",
# "productDesignAgreement": "OTSX",
# "sourcingType":           "MULTIX",
# "relationshipVisibility": "LITTLE_VISX",
# "productImpact":          "COMMODITIZED_PRODUCTX",
# "commodityType":          "A3PX",

    * def requestBody_createBulkThirdParty =
      """
          [
              {
                "referenceNo": null,
                "name": "ABC Corp",
                "currency": "USDX",
                "companyType": "CORPX",
                "industryType": "AHIX",
                "organizationSize": "11-50X",
                "businessType": "PRSX",
                "incorporationDate": "2021-06-18T05:32:07-0800",
                "revenue": "10MX",
                "responsibleParty": "rddcentre.admin.np@refinitiv.com",
                "liquidationDate": "2021-06-18T05:32:07-0800",
                "divisions": [
                  "MyDivision"
                ],
                "affiliation": "SOEX",
                "workflowGroupId": "#(workflowGroupId)",
                "spendCategory": "OTSX",
                "sourcingMethod": "DIST_M_SRCX",
                "productDesignAgreement": "OTSX",
                "sourcingType": "MULTIX",
                "relationshipVisibility": "LITTLE_VISX",
                "productImpact": "COMMODITIZED_PRODUCTX",
                "commodityType": "A3PX",
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
          ]
      """

    Given url postUrl = baseTestUrl
    And path 'thirdparty/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_createBulkThirdParty
    When method POST
    Then status 207

    * def resultThirdPartyIds = get response.data[*].resource.id

    * def countReceived = response.data.length
    * def countCreated =  resultThirdPartyIds.length
    And match countReceived == 1
    And match countCreated == 0

    And print '\n'
    And print '================================'
    And print '******** CREATE BULK THIRD-PARTY: INVALID DATA'
    And print '******** COUNT RECEIVED      = '+ countReceived
    And print '******** COUNT CREATED       = '+ countCreated
    And print '******** resultThirdPartyIds = '+ resultThirdPartyIds
    And print '================================\n'
    And print '\n'

    * def requestBadFields = [ "relationshipVisibility", "sourcingType", "productImpact", "commodityType", "spendCategory", "revenue", "sourcingMethod", "companyType", "affiliation", "organizationSize", "currency", "industryType", "productDesignAgreement", "businessType", "businessType"  ]
    * def responseBadFields = get response.data[*].errors[*].field

#   And match requestBadFields contains only responseBadFields
    And match requestBadFields contains      responseBadFields



#
# VALIDATE response body SCHEMA
#
    And match response ==
          """
              {
                "message": "##string",
                "data":    "##[] ^ {
                                       index:              '#number',
                                       message:            'Bad Request',
                                       resource:           null,
                                       errors:             '##[] ^ {
                                                                         field:       \"#? requestBadFields.contains(_)\",
                                                                         code:        \"##regex ^.*[(SI\-ERR\-003)|(SI\-ERR\-006)]$\",
                                                                         description: \"##regex ^.*[(is not valid.)|(did not match!)]$\"
                                                                   }',
                                       status:             400
                                   }"
              }
          """


  Scenario: 7) C36332299 Public API - POST /thirdparty/bulk
               - Verify that third party with 10 bank details and other names is created


#
# CREATE bulk third-party
#
    * def requestBody_createThirdParty =
      """
          [
              {
                "referenceNo": null,
                "name": "ABC-XYZ Corporation",
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
                ],
                "otherNames": [
                ]
              }
          ]
      """

    Given url postUrl = baseTestUrl
    And path 'thirdparty/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_createThirdParty
    When method POST
    Then status 207

    * def resultThirdPartyIds = get response.data[*].resource.id

    * def countReceived = response.data.length
    * def countCreated =  resultThirdPartyIds.length
    And match countReceived == 1
    And match countCreated == 1

    And print '\n'
    And print '================================'
    And print '******** CREATE BULK THIRD-PARTY: 10 BANK DETAILS'
    And print '******** COUNT RECEIVED      = '+ countReceived
    And print '******** COUNT CREATED       = '+ countCreated
    And print '******** resultThirdPartyIds = '+ resultThirdPartyIds
    And print '================================\n'
    And print '\n'



#
# VALIDATE response body SCHEMA
#
    And match response ==
          """
              {
                "message": '##string',
                "data":    '##[] ^ {
                                       "index":              "##number",
                                       "message":            "201(Created) The request has been created successfully.",
                                       "resource":           {
                                                                 "id":   "##string",
                                                                 "link": "##string"
                                                             },
                                       "errors":             null,
                                       "status":             201
                                   }'
              }
          """



#
# CONVERT ARRAY 'resultThirdPartyIds' into key-value
# JSON ARRAY OBJECT
# [
#    { 'thirdPartyId': 'XXXXXXXX' },
#    { 'thirdPartyId': 'XXXXXXXX' }
# ]
#
    * def thirdPartyIdsObj = karate.mapWithKey( resultThirdPartyIds, 'thirdPartyId' )



#
# CHECK: RETRIEVE third-party by id: ITERATE over array
#
    * def getByIdResponses =         call read( './publicPOSTThirdPartyCreateBulkThirdParty_RetrieveById.feature' ) thirdPartyIdsObj
    * def getByIdThirdPartyIds =     $getByIdResponses[*].response.data.id
    And match resultThirdPartyIds == getByIdThirdPartyIds

    * def count = getByIdThirdPartyIds.length
    And print '\n'
    And print '================================'
    And print '******** CREATE BULK THIRD-PARTY'
    And print '******** COUNT: getByIdThirdPartyIds.length = '+ count
    And print '********        getByIdThirdPartyIds        = '+ getByIdThirdPartyIds
    And print '================================\n'
    And print '\n'



#
# DELETE third-party by id: ITERATE over array
#
    * def deleteByIdResponses = call read( './publicPOSTThirdPartyCreateBulkThirdParty_DeleteById.feature' ) thirdPartyIdsObj



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

    * def checkThirdPartyIds = get response.data[*].id
    And assert !checkThirdPartyIds.contains( resultThirdPartyIds )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE BULK THIRD-PARTY: DELETE THIRD-PARTY CLEANUP'
    And print '******** COUNT: data.length =  '+ count
    And print '******** resultThirdPartyIds = '+ resultThirdPartyIds
    And print '******** checkThirdPartyIds =  '+ checkThirdPartyIds
    And print '================================\n'
    And print '\n'



## = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
## = = = = = = = = CLEAN-UP! = = = = = = = = = = = = = = = = = = = = = = = = = = =
## = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
#
#
#
#
##
## DELETE third-party by id: ITERATE over array
##
##
## CONVERT ARRAY 'resultThirdPartyIds' into key-value
## JSON ARRAY OBJECT
## [
##    { 'thirdPartyId': 'XXXXXXXX' },
##    { 'thirdPartyId': 'XXXXXXXX' }
## ]
##
#    * def thirdPartyIdsObj = karate.mapWithKey( checkThirdPartyIds, 'thirdPartyId' )
#
#
#
##
## DELETE third-party by id: ITERATE over array
##
#    * def deleteByIdResponses = call read( './publicPOSTThirdPartyCreateBulkThirdParty_DeleteById.feature' ) thirdPartyIdsObj






  Scenario: 8) C36332300 Public API - POST /thirdparty/bulk
               - Verify error when adding more than 10 Bank Details and Other Names

#
# CREATE bulk third-party
#
    * def requestBody_createBulkThirdParty =
      """
          [
            {
              "referenceNo": null,
              "name": "ABC-20210819 Corp",
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
              ],
              "otherNames": [
              ]
            }
          ]
      """

    Given url postUrl = baseTestUrl
    And path 'thirdparty/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_createBulkThirdParty
    When method POST
    Then status 207

    * def resultThirdPartyIds = get response.data[*].resource.id

    * def countReceived = response.data.length
    * def countCreated =  resultThirdPartyIds.length
    And match countReceived == 1
    And match countCreated == 0

    And print '\n'
    And print '================================'
    And print '******** CREATE BULK THIRD-PARTY: EXCEEDS MAX. 10 BANK DETAILS'
    And print '******** COUNT RECEIVED      = '+ countReceived
    And print '******** COUNT CREATED       = '+ countCreated
    And print '******** resultThirdPartyIds = '+ resultThirdPartyIds
    And print '================================\n'
    And print '\n'

    * def requestBadFields = [ "bankDetails"  ]
    * def responseBadFields = get response.data[*].errors[*].field

#   And match requestBadFields contains only responseBadFields
    And match requestBadFields contains      responseBadFields



#
# VALIDATE response body SCHEMA
#
    And match response ==
          """
              {
                "message": "##string",
                "data":    "##[] ^ {
                                       index:              '#number',
                                       message:            'Bad Request',
                                       resource:           null,
                                       errors:             '##[] ^ {
                                                                         field:       \"#? requestBadFields.contains(_)\",
                                                                         code:        \"##regex ^.*[(SI\-ERR\-002)]$\",
                                                                         description: \"##regex ^.*[(should not exceed the maximum length!)]$\"
                                                                   }',
                                       status:             400
                                   }"
              }
          """




  Scenario: 9) C36332301 Public API - POST/thirdparty/bulk
               - Verify error validation for fields with maximum character limitations


#
# CREATE BULK Third Party: data EXCEEDS MAXIMUM CHAR.
#

    * def requestBody_createBulkThirdParty =
      """
          [
              {
                "referenceNo": null,
                "name": "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901",
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
                  "addressLine": "12345678901234567890123456789012345678901234567890123456789012345",
                  "city": "12345678901234567890123456789012345678901234567890123456789012345",
                  "country": "US",
                  "postalCode": "12345678901234567890123456789012345678901234567890123456789012345",
                  "province": "12345678901234567890123456789012345678901234567890123456789012345",
                  "region": "#(region)"
                },
                "contactInformation": {
                  "email": [
                    "123456789012345678901234567890123456789012345678901234567@abc.com"
                  ],
                  "fax": [
                    "12345678901234567890123456789012345678901234567890123456789012345"
                  ],
                  "phoneNumber": [
                    "12345678901234567890123456789012345678901234567890123456789012345"
                  ],
                  "website": [
                    "http://www.23456789012345678901234567890123456789012345678901.com"
                  ]
                },
                "description": "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345",
                "customFields": [],
                "bankDetails": [
                  {
                    "accountNo": "12345678901234567890123456789012345678901234567890123456789012345",
                    "addressLine": "12345678901234567890123456789012345678901234567890123456789012345",
                    "branchName": "12345678901234567890123456789012345678901234567890123456789012345",
                    "city": "12345678901234567890123456789012345678901234567890123456789012345",
                    "country": "US",
                    "name": "12345678901234567890123456789012345678901234567890123456789012345"
                  }
                ],
                "otherNames": [
                ]
              }
          ]
      """

    Given url postUrl = baseTestUrl
    And path 'thirdparty/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_createBulkThirdParty
    When method POST
    Then status 207

    * def resultThirdPartyIds = get response.data[*].resource.id

    * def countReceived = response.data.length
    * def countCreated =  resultThirdPartyIds.length
    And match countReceived == 1
    And match countCreated == 0

    And print '\n'
    And print '================================'
    And print '******** CREATE BULK THIRD-PARTY: EXCEEDS MAX. CHAR.'
    And print '******** COUNT RECEIVED      = '+ countReceived
    And print '******** COUNT CREATED       = '+ countCreated
    And print '******** resultThirdPartyIds = '+ resultThirdPartyIds
    And print '================================\n'
    And print '\n'

    * def requestBadFields = [ "name", "address.addressLine", "address.city", "address.postalCode", "address.province", "contactInformation.email[0].<list element>", "contactInformation.fax[0].<list element>", "contactInformation.phoneNumber[0].<list element>", "contactInformation.website[0].<list element>", "bankDetails[0].name", "bankDetails[0].accountNo", "bankDetails[0].addressLine", "bankDetails[0].branchName", "bankDetails[0].city", "description" ]
    * def responseBadFields = get response.data[*].errors[*].field

#   And match requestBadFields contains only responseBadFields
    And match requestBadFields contains      responseBadFields



#
# VALIDATE response body SCHEMA
#
    And match response ==
          """
              {
                "message": "##string",
                "data":    "##[] ^ {
                                       index:              '#number',
                                       message:            'Bad Request',
                                       resource:           null,
                                       errors:             '##[] ^ {
                                                                         field:       \"#? requestBadFields.contains(_)\",
                                                                         code:        \"##regex ^.*[(SI\-ERR\-002)]$\",
                                                                         description: \"##regex ^.*[(should not exceed the maximum length!)]$\"
                                                                   }',
                                       status:             400
                                   }"
              }
          """




  Scenario: 10) C36333192 Public API - POST /thirdparty/bulk
                - Verify error for required fields


#
# CREATE BULK Third Party: MISSING REQUIRED FIELDS:
#   Third-Party Name,  Country,  Responsible Party,  Division
#

    * def requestBody_createBulkThirdParty =
      """
          [
            {
              "referenceNo": null,

              "currency": "USD",
              "companyType": "CORP",
              "industryType": "AHI",
              "organizationSize": "11-50",
              "businessType": "PRS",
              "incorporationDate": "2021-06-18T05:32:07-0800",
              "revenue": "10M",

              "liquidationDate": "2021-06-18T05:32:07-0800",
              "divisions": [

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
          ]
      """

    Given url postUrl = baseTestUrl
    And path 'thirdparty/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_createBulkThirdParty
    When method POST
    Then status 207

    * def resultThirdPartyIds = get response.data[*].resource.id

    * def countReceived = response.data.length
    * def countCreated =  resultThirdPartyIds.length
    And match countReceived == 1
    And match countCreated == 0

    And print '\n'
    And print '================================'
    And print '******** CREATE BULK THIRD-PARTY: BAD FORMAT DATA'
    And print '******** COUNT RECEIVED      = '+ countReceived
    And print '******** COUNT CREATED       = '+ countCreated
    And print '******** resultThirdPartyIds = '+ resultThirdPartyIds
    And print '================================\n'
    And print '\n'

    * def requestBadFields = [ "name", "address.country", "responsibleParty", "divisions" ]
    * def responseBadFields = get response.data[*].errors[*].field

#   And match requestBadFields contains only responseBadFields
    And match requestBadFields contains      responseBadFields



#
# VALIDATE response body SCHEMA
#
    And match response ==
          """
              {
                "message": "##string",
                "data":    "##[] ^ {
                                       index:              '#number',
                                       message:            'Bad Request',
                                       resource:           null,
                                       errors:             '##[] ^ {
                                                                         field:       \"#? requestBadFields.contains(_)\",
                                                                         code:        \"##regex ^.*[(SI\-ERR\-005)]$\",
                                                                         description: \"##regex ^.*[(is a required field)]$\"
                                                                   }',
                                       status:             400
                                   }"
              }
          """


