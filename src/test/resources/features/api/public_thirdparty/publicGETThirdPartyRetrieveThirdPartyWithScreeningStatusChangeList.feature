@api @public_api @getPublicThirdPartyRetrieveThirdPartyWithScreeningStatusChangeList
Feature: Get Third Party With Screening Status Change List



  Background:
#    * def baseTestUrl =        'https://api.qa-sprint2.supplierintegrity.com'
    * def xTenantCode =        tenant
    * def invalidXTenantCode = 'xxx'
    * def nextPageToken =      ''



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

    * def fnGetISODateStartOfTodayMinus365 =
      """
        function( givenEpochTimeMs ) {
          var givenDate = new Date( givenEpochTimeMs );
          var givenDateStart = new Date( givenDate.getFullYear() - 1, givenDate.getMonth(), givenDate.getDate(), 0, 0, 0, 0 );
          return givenDateStart.toISOString();
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

    * def now365AgoISODate =  fnGetISODateStartOfTodayMinus365( nowMs )
    * def now000000ISODate =  call fnGetISODateStartOfDay nowMs
    * def now235959ISODate =  call fnGetISODateEndOfDay   nowMs

    * def now365AgoISODate4 = fnAbbrevISODateTzo( fnConvertISODateTzoToGivenTzo( now365AgoISODate, "+0800" ) )
    * def nowStartISODate4 =  fnAbbrevISODateTzo( fnConvertISODateTzoToGivenTzo( now000000ISODate, "+0800" ) )
    * def nowEndISODate4 =    fnAbbrevISODateTzo( fnConvertISODateTzoToGivenTzo( now235959ISODate, "+0800" ) )

    * def nowISODateAsUTC =   call fnCreateDateAsUTC      nowMs
    * def nowISODateToUTC =   call fnConvertDateToUTC     nowMs

#    * def incDateReq =        requestBody_createThirdParty.incorporationDate
#    * def incDateResp =       response.data.incorporationDate

    And match nowISODate ==   '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'
#    And match incDateReq ==   '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'
#    And match incDateResp ==  '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'





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



  Scenario: 1) C36509401 RMS-5878 SIConnect Public API V2
               - Get Supplier list with Change of Screening Status by Update Date Range

#
# Get Third Party With SCREENING-STATUS Change List
#


    Given url getUrl = baseTestUrl
    And path 'thirdparty', 'monitor', 'screening-status'
    And param pageSize =       100
    And param start =          now365AgoISODate4
#    And param start =          nowStartISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200



    * def count = response.data.length
    * def nextPageToken = response.meta.nextPageToken
    And print '\n'
    And print '================================'
    And print '******** RETRIEVE THIRD-PARTY WITH SCREENING STATUS CHANGE LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** nextPageToken      = '+ nextPageToken
    And print '================================\n'
    And print '\n'



    And match response ==
      """
         {
           message: '##string',
           meta:    {
                      totalSize:     '#number',
                      nextPageToken: '##string'
                    },
           data: '##[] ^ {
                              id:                "#string",
                              name:              "##string",
                              status:            "##string",
                              updateTime:        "##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}[.][0-9]{3}(Z|[+-][0-9]{2}:[0-9]{2})$"
                            }'
         }
      """



  Scenario: 2) C36509424 RMS-5878 SIConnect Public API V2
               - Get Supplier list with Change of Screening Status Date Range
               - Invalid date range

#
# Test when 'start' datetime > 'end' datetime
#

    Given url getUrl = baseTestUrl
    And path 'thirdparty', 'monitor', 'screening-status'
    And param pageSize =       100
    And param start =          nowEndISODate4
    And param end =            nowStartISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 400


    And match response ==
      """
        {
          errors: [
            {
              field:       'start',
              code:        'SI-ERR-007',
              description: 'Start Date should not be greater than End date'
            }
          ]
        }
      """



#
# Test when 'start' and 'end' datetimes are invalid
#

    Given url getUrl = baseTestUrl
    And path 'thirdparty', 'monitor', 'screening-status'
    And param pageSize =       100
    And param start =          'ABC'+ nowStartISODate4
    And param end =            'XYZ'+ nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 400


    And match response ==
      """
        {
          errors: [
            {
              field:       'start',
              code:        'SI-ERR-003',
              description: '##regex ^.*[(is not valid.)]$'
            }
          ]
        }
      """



  Scenario: 3) C36509426 RMS-5878 SIConnect Public API V2
               - Get Supplier list with Change of Screening Status Date Range
               - pagesize is null

#
# Get Third Party With SCREENING-STATUS Change List
#

    Given url getUrl = baseTestUrl
    And path 'thirdparty', 'monitor', 'screening-status'
#    And param pageSize =       100
    And param start =          now365AgoISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 400


    And match response ==
      """
        {
          errors: [
            {
              field:       'size',
              code:        'SI-ERR-003',
              description: '##regex ^.*[(is not valid.)]$'
            }
          ]
        }
      """



  Scenario: 4) C36509429 RMS-5878 SIConnect Public API V2
               - Get Supplier list with Change of Screening Status Date Range
               - Retrieve by field parameter

#
# Get Third Party With SCREENING-STATUS Change List
#

    Given url getUrl = baseTestUrl
    And path 'thirdparty', 'monitor', 'screening-status'
    And param pageSize =       100
    And param fields =         'data.id, data.name, data.status'
    And param start =          now365AgoISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200



    * def count = response.data.length
#    * def nextPageToken = response.meta.nextPageToken
    And print '\n'
    And print '================================'
    And print '******** RETRIEVE THIRD-PARTY WITH SCREENING-STATUS CHANGE LIST'
    And print '******** COUNT: data.length = '+ count
#    And print '******** nextPageToken      = '+ nextPageToken
    And print '================================\n'
    And print '\n'



    And match response ==
      """
         {
           data: '##[] ^ {
                              id:                "#string",
                              name:              "##string",
                              status:            "##string"
                            }'
         }
      """




##
## Test when invalid header 'X-Tenant-Code'
##
#    Given url getUrl = baseTestUrl
#    And path 'thirdparty', 'monitor', 'status'
#    And param pageSize =       100
#    And param start =          '2021-08-13T00:00:00+0800'
#    And param end =            '2021-08-13T23:59:59+0800'
#    And header X-Tenant-Code = invalidXTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method GET
#    Then status 200
#
#
#
#    And match response ==
#      """
#         {
#           "message": '##string',
#           "meta": {
#             "totalSize": 0,
#             "nextPageToken": '##string'
#           },
#           "data": '##[0]'
#
#         }
#      """
#
#
#
##
## Test when 'start' datetime > 'end' datetime
##
#    Given url getUrl = baseTestUrl
#    And path 'thirdparty'
#    And param pageSize =       100
#    And param start =          '2022-08-13T23:59:59+0800'
#    And param end =            '2021-08-13T00:00:00+0800'
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method GET
#    Then status 400
#
#
#
#    And match response ==
#      """
#        {
#          errors: [
#            {
#              field:       '##string',
#              code:        '##string',
#              description: '##string'
#            }
#          ]
#        }
#      """
#
#
#
##
## TODO: Test when using 'pageToken' = 'nextPageToken'
##
##    Given url getUrl = baseTestUrl
##    And path 'contacts'
##    And param pageToken = nextPageToken
##    And param pageSize = 10
##    And param start = '2021-01-01T01:00:00+0800'
##    And param end = '2021-08-01T01:00:00+0800'
##    And header X-Tenant-Code = xTenantCode
##   And header Authorization = 'Bearer '+ accessToken
##   When method GET
##   Then status 200