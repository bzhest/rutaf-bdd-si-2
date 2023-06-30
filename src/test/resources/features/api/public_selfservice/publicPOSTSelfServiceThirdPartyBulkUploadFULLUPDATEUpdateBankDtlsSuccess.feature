@api @public_api @postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdateBankDtlsSuccess
Feature: Bulk Upload to Third Party



  Background:
#    * def baseTestUrl =        'https://api.qa-sprint2.supplierintegrity.com'
    * def xTenantCode =        tenant
    * def invalidXTenantCode = 'xxx'
    * def eTag =               ''
    * configure retry =        { count: 40, interval: 3000 }



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



    * def pauseExecution = function( millis ) { java.lang.Thread.sleep(millis); }




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
            var TextFileWriter = Java.type( 'com.refinitiv.asts.test.utils.TextFileWriter' );
            var tfw = new TextFileWriter();
            tfw.writeToFile( fqFilename, text );
        }
      """



    * def archiveToZipFile =
      """
        function( fqZipArchiveFilename, fqZipEntryFilename ) {
            var ZipFileArchiver = Java.type( 'com.refinitiv.asts.test.utils.ZipFileArchiver' );
            var zfa = new ZipFileArchiver();
            return zfa.archiveToZipFile( fqZipArchiveFilename, fqZipEntryFilename );
        }
      """



    * def addOrReplaceEntry =
      """
        function( fqZipArchiveFilename, fqZipEntryFilename ) {
            var ZipFileArchiver = Java.type( 'com.refinitiv.asts.test.utils.ZipFileArchiver' );
            var zfa = new ZipFileArchiver();
            return zfa.addOrReplaceEntry( fqZipArchiveFilename, fqZipEntryFilename );
        }
      """



#    * def iterateOverAndCollectBySpecifiedValue =
#      """
#        function( iteratingArrayElem, collectingArray, targetValue ) {
#            if ( iteratingArrayElem.status == targetValue ) {
#                karate.append( collectingArray, iteratingArrayElem.filename );
#            }
#        }
#      """



    * def createThirdPartyIdsArrFn =
      """
        function( thirdPartyIds ) {

          var thirdPartyIdsArr = [];
          for (var i=0; i<thirdPartyIds.length; i++ ) {
            thirdPartyIdsArr.push( { 'thirdPartyId': thirdPartyIds[i] } );
          }
          return thirdPartyIdsArr;
        }
      """



    * configure logPrettyResponse = true



  Scenario: 7) C37786777 Third-party - FULLUPDATE
               - Update Bank Details

    * def nowMs = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 7) BANK DETAILS'
    And print '******** nowMs = '+ nowMs
    And print '================================\n'
    And print '\n'


#
# CREATE third-party
#
    * def requestBody_createThirdParty =
      """
          {
            "referenceNo": "#(''+ nowMs)",
            "name": "ABC-3P-BULKUPLOAD Corp",
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

    * def riskTier_enums = [ "Low", "Medium", "High" ]

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
                                                          "addressLine":          '##string',
                                                          "city":                 '##string',
                                                          "province":             '##string',
                                                          "postalCode":           '##string',
                                                          "region":               '##string',
                                                          "country":              '##string'
                                                        },
                              "spendCategory":          '##string',
                              "sourcingMethod":         '##string',
                              "productDesignAgreement": '##string',
                              "sourcingType":           '##string',
                              "relationshipVisibility": '##string',
                              "productImpact":          '##string',
                              "commodityType":          '##string',
                              "customFields":           '##[] ^ {
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
                              "riskTier":               '#? riskTier_enums.contains(_)',
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

#  ,
#  "regionAndCountryPair": {
#  "value2": '##string',
#  "value1": '##string'
#  }

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


#   * def csvRows00 = "Action Type|Third-party ID|Reference Number|Group ID|Third-party Name|Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party|Division|Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact|Commodity Type|Bank Name|Bank Address Line|Account No.|Bank City|Branch Name|Bank Country|Address Line|State/Province|City|Region|Zip/Postal Code|Country|Phone Number|Website|Fax|Email Address|Description|Other Names Old Name|Other Name|Other Name Type|Other Name Country|Custom Fields Name|Custom Fields Value\n"
#   * def csvRows01 = "FULLUPDATE||qwerty1|1|FULLUPDATE ABCXYZ-123789||||||||||rddcentre.admin.np@refinitiv.com|MyDivision|Default|||||||||||||||||||Philippines|||||||||||"

    * def csvRows00 = "Action Type|Third-party ID          |Reference Number|Group ID|Third-party Name        |Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party               |Division  |Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact|Commodity Type|Bank Name|Bank Address Line|Account No.|Bank City|Branch Name|Bank Country|Address Line|State/Province|City|Region|Zip/Postal Code|Country    |Phone Number|Website|Fax|Email Address|Description|Other Names Old Name|Other Name|Other Name Type|Other Name Country|Custom Fields Name|Custom Fields Value|Case System ID|Other Name Case System ID|Notify List|Screening Groups|Other Name Screening Groups\n"
#   * def csvRows01 = "FULLUPDATE |61711a8c1f851700016d60ce|qwerty1         |1       |FULLUPDATE - "+ nowMs +"|            |        |                 |             |                 |                     |       |                |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |               |                |             |                       |              |              |         |                 |           |         |           |            |            |              |    |      |               |Philippines|            |       |   |             |           |                    |          |               |                  |                  |                     "

# Success: Bank Details
    * def csvRows01 = "FULLUPDATE |"+ thirdPartyId       +"|                |1       |FULLUPDATE - "+ nowMs +"|            |        |                 |             |                 |                     |       |                |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |               |                |             |                       |              |              |MayBank01|111 Main Ave.    |1234567890 |New Jersey|Branch 01 |Canada      |            |              |    |      |               |Canada     |            |       |   |             |           |                    |          |               |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows02 = "           |                        |                |1       |                        |            |        |                 |             |                 |                     |       |                |           |                                |          |              |              |               |                |             |                       |              |              |MayBank02|222 Main Ave.    |2345678901 |New Manila|Branch 02 |Canada      |            |              |    |      |               |           |            |       |   |             |           |                    |          |               |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows03 = "           |                        |                |1       |                        |            |        |                 |             |                 |                     |       |                |           |                                |          |              |              |               |                |             |                       |              |              |MayBank03|333 Main Ave.    |3456789012 |New Oslo  |Branch 03 |Canada      |            |              |    |      |               |           |            |       |   |             |           |                    |          |               |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows04 = "           |                        |                |1       |                        |            |        |                 |             |                 |                     |       |                |           |                                |          |              |              |               |                |             |                       |              |              |MayBank04|444 Main Ave.    |4567890123 |New York  |Branch 04 |Canada      |            |              |    |      |               |           |            |       |   |             |           |                    |          |               |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows05 = "           |                        |                |1       |                        |            |        |                 |             |                 |                     |       |                |           |                                |          |              |              |               |                |             |                       |              |              |MayBank05|555 Main Ave.    |5678901234 |New Tokyo |Branch 05 |Canada      |            |              |    |      |               |           |            |       |   |             |           |                    |          |               |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows06 = "           |                        |                |1       |                        |            |        |                 |             |                 |                     |       |                |           |                                |          |              |              |               |                |             |                       |              |              |MayBank06|666 Main Ave.    |6789012345 |New Osaka |Branch 06 |Canada      |            |              |    |      |               |           |            |       |   |             |           |                    |          |               |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows07 = "           |                        |                |1       |                        |            |        |                 |             |                 |                     |       |                |           |                                |          |              |              |               |                |             |                       |              |              |MayBank07|777 Main Ave.    |7890123456 |New Berlin|Branch 07 |Canada      |            |              |    |      |               |           |            |       |   |             |           |                    |          |               |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows08 = "           |                        |                |1       |                        |            |        |                 |             |                 |                     |       |                |           |                                |          |              |              |               |                |             |                       |              |              |MayBank08|888 Main Ave.    |8901234567 |New Milan |Branch 08 |Canada      |            |              |    |      |               |           |            |       |   |             |           |                    |          |               |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows09 = "           |                        |                |1       |                        |            |        |                 |             |                 |                     |       |                |           |                                |          |              |              |               |                |             |                       |              |              |MayBank09|999 Main Ave.    |9012345678 |New Paris |Branch 09 |Canada      |            |              |    |      |               |           |            |       |   |             |           |                    |          |               |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows10 = "           |                        |                |1       |                        |            |        |                 |             |                 |                     |       |                |           |                                |          |              |              |               |                |             |                       |              |              |MayBank10|000 Main Ave.    |0123456789 |New Delhi |Branch 10 |Canada      |            |              |    |      |               |           |            |       |   |             |           |                    |          |               |                  |                  |                   |              |                         |           |                |\n"

# Success: reference no.
#   * def csvRows01 = "FULLUPDATE||qwerty1|1|FULLUPDATE - "+ nowMs +"||||||||||rddcentre.admin.np@refinitiv.com|MyDivision|Default|||||||||||||||||||Philippines|||||||||||"

# Success: thirdParty id
#   * def csvRows01 = "FULLUPDATE|61711a8c1f851700016d60ce|qwerty1|1|FULLUPDATE - "+ nowMs +"||||||||||rddcentre.admin.np@refinitiv.com|MyDivision|Default|||||||||||||||||||Philippines|||||||||||"

# Error: Non-existent 'thirdParty id'
#   * def csvRows01 = "FULLUPDATE|xxxxxxxxxx||1|FULLUPDATE - "+ nowMs +"||||||||||rddcentre.admin.np@refinitiv.com|MyDivision|Default|||||||||||||||||||Philippines|||||||||||"

# Error: Non-existent 'referenceNo'
#   * def csvRows01 = "FULLUPDATE||qwerty1-xxx|1|FULLUPDATE - "+ nowMs +"||||||||||rddcentre.admin.np@refinitiv.com|MyDivision|Default|||||||||||||||||||Philippines|||||||||||"

    * def csvRowsT = csvRows00 + csvRows01 + csvRows02 + csvRows03 + csvRows04 + csvRows05 + csvRows06 + csvRows07 + csvRows08 + csvRows09 + csvRows10
#   * def csvRowsA = "Action Type|Third-party ID|Reference Number|Group ID|Third-party Name|Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party|Division|Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact|Commodity Type|Bank Name|Bank Address Line|Account No.|Bank City|Branch Name|Bank Country|Address Line|State/Province|City|Region|Zip/Postal Code|Country|Phone Number|Website|Fax|Email Address|Description|Other Names Old Name|Other Name|Other Name Type|Other Name Country|Custom Fields Name|Custom Fields Value\nFULLUPDATE||qwerty1|1|FULLUPDATE - "+ nowMs +"||||||||||rddcentre.admin.np@refinitiv.com|MyDivision|Default|||||||||||||||||||Philippines|||||||||||"

#   * def writeToFileResult = writeToFile( "./src/test/resources/features/api/public_thirdparty/ThirdPartyBulkUpdate/ThirdParty_Add_Update_Delete_FULLUPDATE.csv", csvRowsT )


# PAUSE to allow for server processing of file attachment

    * pauseExecution( 1000 )


    Given url postUrl = baseTestUrl
    And path 'selfservice'
    And param ProcessType = 'THIRD_PARTY_ADD_EDIT_DELETE'
#   And multipart file file = { read:'./ThirdPartyBulkUpdate/ThirdParty_Add_Update_Delete_FULLUPDATE.csv', filename:'ThirdParty_Add_Update_Delete_FULLUPDATE.csv', contentType: 'application/vnd.ms-excel' }
    And multipart file file = { value: '#(csvRowsT)', filename:'ThirdParty_Add_Update_Delete_FULLUPDATE.csv', contentType: 'application/vnd.ms-excel' }
    And header X-Tenant-Code = xTenantCode
    And header RequestorEmail = requestorEmail
    And header Authorization = 'Bearer '+ accessToken
    When method POST
    Then status 202

    Then print response

    * def processId = response.data.processId

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE: UPLOAD FLAT FILE - THIRD_PARTY_ADD_EDIT_DELETE - FULLUPDATE'
    And print '******** nowMs          = '+ nowMs
    And print '******** xTenantCode    = '+ xTenantCode
    And print '******** requestorEmail = '+ requestorEmail
    And print '******** PROCESS ID     = '+ processId
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
                               "processId": '##string'
                           }
              }
          """


# PAUSE to allow for server processing of file attachment
#
#   * pauseExecution( 30000 )


#
# Retrieve PROCESS ID details
#

    Given url postUrl = baseTestUrl
    And path 'selfservice', processId
    And header X-Tenant-Code = xTenantCode
    And header RequestorEmail = requestorEmail
    And header Authorization = 'Bearer '+ accessToken
    And retry until response.data.status == 'COMPLETED'
    When method GET
    Then status 200

    Then print response

    * def status = response.data.status

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: UPLOAD FLAT FILE - THIRD_PARTY_ADD_EDIT_DELETE - FULLUPDATE'
    And print '******** nowMs          = '+ nowMs
    And print '******** xTenantCode    = '+ xTenantCode
    And print '******** requestorEmail = '+ requestorEmail
    And print '******** PROCESS ID     = '+ processId
    And print '******** STATUS         = '+ status
    And print '================================\n'
    And print '\n'


#
# VALIDATE response body SCHEMA
#
    And match response ==
          """
            {
              "message": "200(OK) The request was successful.",
              "data":    {
                             "processId":           "#string",
                             "filename":            "#string",
                             "meta":                {
                                                        "filename":  "#string",
                                                        "fileSize":  "#number",
                                                        "location":  "#string"
                                                    },
                             "uploadTime":          "##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$",
                             "uploadDate":          "##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}$",
                             "status":              "COMPLETED",
                             "relatedFilesStatus":  null,
                             "errors":              null,
                             "successResponseFile": {
                                                        "filename":  "#string",
                                                        "fileSize":  "#number",
                                                        "location":  "#string"
                                                    },
                             "errorResponseFile":   null,
                             "numberOfRecords":     1,
                             "recordProcessed":     1,
                             "recordWithErrors":    0,
                             "entityType":          "##string",
                             "entityId":            "##string",
                             "childReferenceId":    "##string",
                             "triggeredBy":         "#string",
                             "processType":         "THIRD_PARTY_ADD_EDIT_DELETE"
                         }
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
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIds      = '+ thirdPartyIds
    And print '================================\n'
    And print '\n'











