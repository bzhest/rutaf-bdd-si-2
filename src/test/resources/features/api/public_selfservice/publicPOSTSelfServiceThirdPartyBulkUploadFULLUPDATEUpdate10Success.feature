@api @public_api @postPublicSelfServiceThirdPartyBulkUploadFULLUPDATEUpdate10Success
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




  Scenario: 19) C37786785 Third-party - FULLUPDATE
  - Update 10 third-party


#
# CREATE third-party 1
#

    * def nowMs = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 19) 10 THIRDPARTY'
    And print '******** nowMs = '+ nowMs
    And print '================================\n'
    And print '\n'


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


    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY'
    And print '******** TEST   : nowMs             = '+ nowMs
    And print '******** CREATED: thirdPartyId      = '+ thirdPartyId
    And print '================================\n'
    And print '\n'


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
# CREATE third-party 2
#

    * def nowMs = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 19) 10 THIRDPARTY'
    And print '******** nowMs = '+ nowMs
    And print '================================\n'
    And print '\n'

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

    * def thirdPartyId2 = response.data.id


    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY'
    And print '******** TEST   : nowMs             = '+ nowMs
    And print '******** CREATED: thirdPartyId2     = '+ thirdPartyId2
    And print '================================\n'
    And print '\n'


#
# CHECK: Retrieve third-party BY ID - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId2
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200


    * def thirdPartyIdResult = response.data.id
    And match thirdPartyId2 == thirdPartyIdResult


    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY BY ID'
    And print '******** thirdPartyId2      = '+ thirdPartyId2
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'


#
# CREATE third-party 3
#

    * def nowMs = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 19) 10 THIRDPARTY'
    And print '******** nowMs = '+ nowMs
    And print '================================\n'
    And print '\n'

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

    * def thirdPartyId3 = response.data.id


    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY'
    And print '******** TEST   : nowMs             = '+ nowMs
    And print '******** CREATED: thirdPartyId3     = '+ thirdPartyId3
    And print '================================\n'
    And print '\n'


#
# CHECK: Retrieve third-party BY ID - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId3
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200


    * def thirdPartyIdResult = response.data.id
    And match thirdPartyId3 == thirdPartyIdResult


    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY BY ID'
    And print '******** thirdPartyId3      = '+ thirdPartyId3
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'


#
# CREATE third-party 4
#

    * def nowMs = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 19) 10 THIRDPARTY'
    And print '******** nowMs = '+ nowMs
    And print '================================\n'
    And print '\n'

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

    * def thirdPartyId4 = response.data.id


    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY'
    And print '******** TEST   : nowMs             = '+ nowMs
    And print '******** CREATED: thirdPartyId4     = '+ thirdPartyId4
    And print '================================\n'
    And print '\n'


#
# CHECK: Retrieve third-party BY ID - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200


    * def thirdPartyIdResult = response.data.id
    And match thirdPartyId4 == thirdPartyIdResult


    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY BY ID'
    And print '******** thirdPartyId4      = '+ thirdPartyId4
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'


#
# CREATE third-party 5
#

    * def nowMs = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 19) 10 THIRDPARTY'
    And print '******** nowMs = '+ nowMs
    And print '================================\n'
    And print '\n'

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

    * def thirdPartyId5 = response.data.id


    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY'
    And print '******** TEST   : nowMs             = '+ nowMs
    And print '******** CREATED: thirdPartyId5     = '+ thirdPartyId5
    And print '================================\n'
    And print '\n'


#
# CHECK: Retrieve third-party BY ID - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId5
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200


    * def thirdPartyIdResult = response.data.id
    And match thirdPartyId5 == thirdPartyIdResult


    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY BY ID'
    And print '******** thirdPartyId5      = '+ thirdPartyId5
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'


#
# CREATE third-party 6
#

    * def nowMs = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 19) 10 THIRDPARTY'
    And print '******** nowMs = '+ nowMs
    And print '================================\n'
    And print '\n'

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

    * def thirdPartyId6 = response.data.id


    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY'
    And print '******** TEST   : nowMs             = '+ nowMs
    And print '******** CREATED: thirdPartyId6     = '+ thirdPartyId6
    And print '================================\n'
    And print '\n'


#
# CHECK: Retrieve third-party BY ID - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId6
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200


    * def thirdPartyIdResult = response.data.id
    And match thirdPartyId6 == thirdPartyIdResult


    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY BY ID'
    And print '******** thirdPartyId6      = '+ thirdPartyId6
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'


#
# CREATE third-party 7
#

    * def nowMs = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 19) 10 THIRDPARTY'
    And print '******** nowMs = '+ nowMs
    And print '================================\n'
    And print '\n'

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

    * def thirdPartyId7 = response.data.id


    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY'
    And print '******** TEST   : nowMs             = '+ nowMs
    And print '******** CREATED: thirdPartyId7     = '+ thirdPartyId7
    And print '================================\n'
    And print '\n'


#
# CHECK: Retrieve third-party BY ID - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId7
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200


    * def thirdPartyIdResult = response.data.id
    And match thirdPartyId7 == thirdPartyIdResult


    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY BY ID'
    And print '******** thirdPartyId7      = '+ thirdPartyId7
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'


#
# CREATE third-party 8
#

    * def nowMs = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 19) 10 THIRDPARTY'
    And print '******** nowMs = '+ nowMs
    And print '================================\n'
    And print '\n'

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

    * def thirdPartyId8 = response.data.id


    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY'
    And print '******** TEST   : nowMs             = '+ nowMs
    And print '******** CREATED: thirdPartyId8     = '+ thirdPartyId8
    And print '================================\n'
    And print '\n'


#
# CHECK: Retrieve third-party BY ID - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId8
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200


    * def thirdPartyIdResult = response.data.id
    And match thirdPartyId8 == thirdPartyIdResult


    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY BY ID'
    And print '******** thirdPartyId8      = '+ thirdPartyId8
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'


#
# CREATE third-party 9
#

    * def nowMs = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 19) 10 THIRDPARTY'
    And print '******** nowMs = '+ nowMs
    And print '================================\n'
    And print '\n'

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

    * def thirdPartyId9 = response.data.id


    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY'
    And print '******** TEST   : nowMs             = '+ nowMs
    And print '******** CREATED: thirdPartyId9     = '+ thirdPartyId9
    And print '================================\n'
    And print '\n'


#
# CHECK: Retrieve third-party BY ID - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId9
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200


    * def thirdPartyIdResult = response.data.id
    And match thirdPartyId9 == thirdPartyIdResult


    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY BY ID'
    And print '******** thirdPartyId9      = '+ thirdPartyId9
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'


#
# CREATE third-party 10
#

    * def nowMs = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 19) 10 THIRDPARTY'
    And print '******** nowMs = '+ nowMs
    And print '================================\n'
    And print '\n'

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

    * def thirdPartyId10 = response.data.id


    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY'
    And print '******** TEST   : nowMs             = '+ nowMs
    And print '******** CREATED: thirdPartyId10    = '+ thirdPartyId10
    And print '================================\n'
    And print '\n'


#
# CHECK: Retrieve third-party BY ID - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId10
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200


    * def thirdPartyIdResult = response.data.id
    And match thirdPartyId10 == thirdPartyIdResult


    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY BY ID'
    And print '******** thirdPartyId10     = '+ thirdPartyId10
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'


#   * def csvRows00 = "Action Type|Third-party ID|Reference Number|Group ID|Third-party Name|Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party|Division|Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact|Commodity Type|Bank Name|Bank Address Line|Account No.|Bank City|Branch Name|Bank Country|Address Line|State/Province|City|Region|Zip/Postal Code|Country|Phone Number|Website|Fax|Email Address|Description|Other Names Old Name|Other Name|Other Name Type|Other Name Country|Custom Fields Name|Custom Fields Value\n"
#   * def csvRows01 = "FULLUPDATE||qwerty1|1|FULLUPDATE ABCXYZ-123789||||||||||rddcentre.admin.np@refinitiv.com|MyDivision|Default|||||||||||||||||||Philippines|||||||||||"

    * def csvRows00 = "Action Type|Third-party ID          |Reference Number|Group ID|Third-party Name        |Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party               |Division  |Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact      |Commodity Type|Bank Name|Bank Address Line|Account No.|Bank City|Branch Name|Bank Country |Address Line|State/Province|City  |Region  |Zip/Postal Code|Country    |Phone Number|Website      |Fax|Email Address|Description|Other Names Old Name|Other Name|Other Name Type    |Other Name Country|Custom Fields Name|Custom Fields Value|Case System ID|Other Name Case System ID|Notify List|Screening Groups|Other Name Screening Groups\n"

# Success: reference no.
#   * def csvRows01 = "FULLUPDATE||qwerty1|1|FULLUPDATE - "+ nowMs +"||||||||||rddcentre.admin.np@refinitiv.com|MyDivision|Default|||||||||||||||||||Philippines|||||||||||"

# Success: thirdParty id
#   * def csvRows01 = "FULLUPDATE|61711a8c1f851700016d60ce|qwerty1|1|FULLUPDATE - "+ nowMs +"||||||||||rddcentre.admin.np@refinitiv.com|MyDivision|Default|||||||||||||||||||Philippines|||||||||||"

# Success: General Information
#   * def csvRows0x = "FULLUPDATE |61711a8c1f851700016d60ce|qwerty1         |1       |FULLUPDATE - "+ nowMs +"|CORP        |USD     |5K-10K           |AHI          |PRS              |02/22/1987            |10M    |11/02/2008      |SOE        |rddcentre.admin.np@refinitiv.com           |MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|A3P           |BN 1     |BA 1             |11223344   |BC 1     |BN1        |United States|Address 1   |State 1       |City 1|Americas|11111          |Canada     |112233      |www.test1.com|123|test1@test.ph|Desc abc123|                    |Dello     |Local Language Name|Vietnam           |Field1            |FULLUPDATE TEXT    \n"
#   * def csvRows01 = "FULLUPDATE |61711a8c1f851700016d60ce|qwerty1         |1       |FULLUPDATE - "+ nowMs +"|CORP        |USD     |5K-10K           |AHI          |PRS              |02/22/1987            |10M    |11/02/2008      |SOE        |rddcentre.admin.np@refinitiv.com           |MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|A3P           |BN 1     |BA 1             |11223344   |BC 1     |BN1        |United States|Address 1   |State 1       |City 1|Americas|11111          |Canada     |112233      |www.test1.com|123|test1@test.ph|Desc abc123|                    |Dello     |Local Language Name|Vietnam           |Field1            |FULLUPDATE TEXT    \n"


# Success: 10 Third-Party
    * def csvRows01 = "FULLUPDATE |"+    thirdPartyId    +"|                |1       |FULLUPDATE - "+ nowMs +"|            |        |                 |             |                 |                     |       |                |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|A3P           |         |                 |           |         |           |             |            |              |      |        |               |Philippines|            |             |   |             |           |                    |          |                   |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows02 = "FULLUPDATE |"+    thirdPartyId2   +"|                |2       |F7                      |            |USD     |                 |             |                 |                     |       |                |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |               |                |             |                       |                    |              |         |                 |           |         |           |             |            |              |      |Americas|               |Chile      |            |             |   |             |           |                    |          |                   |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows03 = "FULLUPDATE |"+    thirdPartyId3   +"|                |3       |F10                     |            |        |5K-10K           |             |                 |                     |       |                |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |               |                |             |                       |                    |              |         |                 |           |         |           |             |            |              |      |Americas|               |Chile      |            |             |   |             |           |                    |          |                   |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows04 = "FULLUPDATE |"+    thirdPartyId4   +"|                |4       |F4                      |            |        |                 |AHI          |PRS              |                     |       |                |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |               |                |             |                       |                    |              |         |                 |           |         |           |             |            |              |      |Americas|               |Chile      |            |             |   |             |           |                    |          |                   |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows05 = "FULLUPDATE |"+    thirdPartyId5   +"|                |5       |F2                      |            |        |                 |             |                 |02/22/1987           |       |                |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |               |                |             |                       |                    |              |         |                 |           |         |           |             |            |              |      |Americas|               |Chile      |            |             |   |             |           |                    |          |                   |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows06 = "FULLUPDATE |"+    thirdPartyId6   +"|                |6       |F6                      |            |        |                 |             |                 |                     |10M    |                |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |               |                |             |                       |                    |              |         |                 |           |         |           |             |            |              |      |Americas|               |Chile      |112233      |www.test1.com|666|             |           |                    |          |                   |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows07 = "FULLUPDATE |"+    thirdPartyId7   +"|                |7       |F3                      |            |        |                 |             |                 |                     |       |11/02/2008      |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |               |                |             |                       |                    |              |         |                 |           |         |           |             |            |              |      |Americas|               |Chile      |112233      |www.test1.com|777|             |           |                    |          |                   |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows08 = "FULLUPDATE |"+    thirdPartyId8   +"|                |8       |F8                      |            |        |                 |             |                 |                     |       |                |SOE        |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |               |                |             |                       |                    |              |         |                 |           |         |           |             |            |              |      |Americas|               |Chile      |112233      |www.test1.com|888|             |           |                    |          |                   |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows09 = "FULLUPDATE |"+    thirdPartyId9   +"|                |9       |F1                      |            |        |                 |             |                 |                     |       |                |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |DIST_M_SRC     |OTS             |             |                       |                    |              |         |                 |           |         |           |             |            |              |      |Americas|               |Chile      |112233      |www.test1.com|999|             |           |                    |          |                   |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows10 = "FULLUPDATE |"+    thirdPartyId10  +"|                |10      |F9                      |            |        |                 |             |                 |                     |       |                |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |               |                |MULTI        |LITTLE_VIS             |                    |              |         |                 |           |         |           |             |            |              |      |Americas|               |Chile      |            |             |000|             |           |                    |          |                   |                  |                  |                   |              |                         |           |                |\n"

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
                             "numberOfRecords":     10,
                             "recordProcessed":     10,
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
    And path 'thirdparty', thirdPartyId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204


#
# CHECK: Retrieve third-party BY ID - expected: NOT FOUND
#

    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId
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
    And assert !thirdPartyIds.contains( thirdPartyId )

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
# DELETE third-party by id 2
#

    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId2
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204


#
# CHECK: Retrieve third-party BY ID - expected: NOT FOUND
#

    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId2
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
    And assert !thirdPartyIds.contains( thirdPartyId2 )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** thirdPartyId2      = '+ thirdPartyId2
    And print '******** thirdPartyIds      = '+ thirdPartyIds
    And print '================================\n'
    And print '\n'


#
# DELETE third-party by id 3
#

    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId3
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204


#
# CHECK: Retrieve third-party BY ID - expected: NOT FOUND
#

    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId3
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
    And assert !thirdPartyIds.contains( thirdPartyId3 )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** thirdPartyId3      = '+ thirdPartyId3
    And print '******** thirdPartyIds      = '+ thirdPartyIds
    And print '================================\n'
    And print '\n'


#
# DELETE third-party by id 4
#

    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204


#
# CHECK: Retrieve third-party BY ID - expected: NOT FOUND
#

    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId4
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
    And assert !thirdPartyIds.contains( thirdPartyId4 )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** thirdPartyId4      = '+ thirdPartyId4
    And print '******** thirdPartyIds      = '+ thirdPartyIds
    And print '================================\n'
    And print '\n'


#
# DELETE third-party by id 5
#

    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId5
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204


#
# CHECK: Retrieve third-party BY ID - expected: NOT FOUND
#

    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId5
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
    And assert !thirdPartyIds.contains( thirdPartyId5 )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** thirdPartyId5      = '+ thirdPartyId5
    And print '******** thirdPartyIds      = '+ thirdPartyIds
    And print '================================\n'
    And print '\n'


#
# DELETE third-party by id 6
#

    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId6
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204


#
# CHECK: Retrieve third-party BY ID - expected: NOT FOUND
#

    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId6
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
    And assert !thirdPartyIds.contains( thirdPartyId6 )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** thirdPartyId6      = '+ thirdPartyId6
    And print '******** thirdPartyIds      = '+ thirdPartyIds
    And print '================================\n'
    And print '\n'


#
# DELETE third-party by id 7
#

    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId7
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204


#
# CHECK: Retrieve third-party BY ID - expected: NOT FOUND
#

    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId7
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
    And assert !thirdPartyIds.contains( thirdPartyId7 )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** thirdPartyId7      = '+ thirdPartyId7
    And print '******** thirdPartyIds      = '+ thirdPartyIds
    And print '================================\n'
    And print '\n'


#
# DELETE third-party by id 8
#

    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId8
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204


#
# CHECK: Retrieve third-party BY ID - expected: NOT FOUND
#

    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId8
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
    And assert !thirdPartyIds.contains( thirdPartyId8 )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** thirdPartyId8      = '+ thirdPartyId8
    And print '******** thirdPartyIds      = '+ thirdPartyIds
    And print '================================\n'
    And print '\n'


#
# DELETE third-party by id 9
#

    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId9
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204


#
# CHECK: Retrieve third-party BY ID - expected: NOT FOUND
#

    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId9
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
    And assert !thirdPartyIds.contains( thirdPartyId9 )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** thirdPartyId9      = '+ thirdPartyId9
    And print '******** thirdPartyIds      = '+ thirdPartyIds
    And print '================================\n'
    And print '\n'


#
# DELETE third-party by id 10
#

    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId10
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204


#
# CHECK: Retrieve third-party BY ID - expected: NOT FOUND
#

    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId10
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
    And assert !thirdPartyIds.contains( thirdPartyId10 )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** thirdPartyId10     = '+ thirdPartyId10
    And print '******** thirdPartyIds      = '+ thirdPartyIds
    And print '================================\n'
    And print '\n'









