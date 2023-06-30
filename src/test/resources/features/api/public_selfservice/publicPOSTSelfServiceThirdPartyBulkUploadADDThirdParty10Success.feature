@api @public_api @postPublicSelfServiceThirdPartyBulkUploadADDThirdParty10Success
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




  Scenario: 37) C37786688  Third-party - ADD
                - Create 10 third-party

    * def nowMs = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 01) ADD 10 SUCCESS'
    And print '******** nowMs = '+ nowMs
    And print '================================\n'
    And print '\n'

    * def nameVarTARGET =       'ADD-3P-10-SUCC'
    * def nameTARGET =          nameVarTARGET +'-'+ nowMs


#
# ADD third-party: by SELF-SERVICE ThirdParty Bulk Upload
#

#   * def csvRows00 = "Action Type|Third-party ID          |Reference Number|Group ID|Third-party Name           |Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party   |Division  |Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact      |Commodity Type|Bank Name|Bank Address Line|Account No.|Bank City|Branch Name|Bank Country |Address Line|State/Province|City  |Region  |Zip/Postal Code|Country      |Phone Number|Website      |Fax|Email Address|Description|Other Names Old Name|Other Name|Other Name Type    |Other Name Country|Custom Fields Name|Custom Fields Value\n"
    * def csvRows00 = "Action Type|Third-party ID          |Reference Number|Group ID|Third-party Name           |Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party               |Division  |Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact      |Commodity Type|Bank Name|Bank Address Line|Account No.|Bank City|Branch Name|Bank Country |Address Line|State/Province|City  |Region  |Zip/Postal Code|Country      |Phone Number|Website      |Fax|Email Address|Description|Other Names Old Name|Other Name|Other Name Type    |Other Name Country|Custom Fields Name|Custom Fields Value|Case System ID|Other Name Case System ID|Notify List|Screening Groups|Other Name Screening Groups\n"

# Success: ADD thirdParty
#   * def csvRows01 = "FULLUPDATE |"+    thirdPartyId    +"|"+    nowMs   +"|1       |FULLUPDATE - "+ nowMs    +"|CORP        |USD     |5K-10K           |AHI          |PRS              |02/22/1987            |10M    |11/02/2008      |SOE        |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|A3P           |MoneyBank|12 Finance Avenue|12345678   |Reno     |MB Reno Br.|United States|12 Main Ave.|Ontario       |Ottawa|Americas|Z1234          |Canada       |+18001      |www.test1.com|123|test1@test.ph|Desc abc123|                    |Acme Inc. |Local Language Name|France            |Field1            |FULLUPDATE TEXT    \n"
    * def csvRows01 = "ADD        |                        |                |AAA01   |"+nameVarTARGET+"-"+nowMs+"|CORP        |USD     |5K-10K           |AHI          |PRS              |02/22/1987           |10M    |11/02/2008      |SOE        |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|A3P           |MoneyBank|12 Finance Avenue|12345678   |Reno     |MB Reno Br.|United States|12 Main Ave.|Ontario       |Ottawa|Americas|ZIP90210       |Canada       |0018001     |www.test1.com|234|tst@email.com|Test desc. |                    |Acme Corp.|Local Language Name|France            |Field1            |Test CUSTOM FLD VAL|              |                         |           |                |\n"
    * def csvRows02 = "ADD        |                        |                |AAA02   |"+nameVarTARGET+"-"+nowMs+"|            |        |                 |             |                 |                     |       |                |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |               |                |             |                       |                    |              |         |                 |           |         |           |             |            |              |      |        |               |China        |            |             |   |             |           |                    |          |                   |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows03 = "ADD        |                        |                |AAA03   |"+nameVarTARGET+"-"+nowMs+"|            |        |                 |             |                 |                     |       |                |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |               |                |             |                       |                    |              |         |                 |           |         |           |             |            |              |      |        |               |Afghanistan  |            |             |   |             |           |                    |          |                   |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows04 = "ADD        |                        |                |AAA04   |"+nameVarTARGET+"-"+nowMs+"|            |        |                 |             |                 |                     |       |                |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |               |                |             |                       |                    |              |         |                 |           |         |           |             |            |              |      |        |               |Philippines  |            |             |   |             |           |                    |          |                   |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows05 = "ADD        |                        |                |AAA05   |"+nameVarTARGET+"-"+nowMs+"|            |        |                 |             |                 |                     |       |                |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |               |                |             |                       |                    |              |         |                 |           |         |           |             |            |              |      |        |               |United States|            |             |   |             |           |                    |          |                   |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows06 = "ADD        |                        |                |AAA06   |"+nameVarTARGET+"-"+nowMs+"|            |        |                 |             |                 |                     |       |                |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |               |                |             |                       |                    |              |         |                 |           |         |           |             |            |              |      |        |               |France       |            |             |   |             |           |                    |          |                   |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows07 = "ADD        |                        |                |AAA07   |"+nameVarTARGET+"-"+nowMs+"|            |        |                 |             |                 |                     |       |                |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |               |                |             |                       |                    |              |         |                 |           |         |           |             |            |              |      |        |               |Italy        |            |             |   |             |           |                    |          |                   |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows08 = "ADD        |                        |                |AAA08   |"+nameVarTARGET+"-"+nowMs+"|            |        |                 |             |                 |                     |       |                |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |               |                |             |                       |                    |              |         |                 |           |         |           |             |            |              |      |        |               |Brazil       |            |             |   |             |           |                    |          |                   |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows09 = "ADD        |                        |                |AAA09   |"+nameVarTARGET+"-"+nowMs+"|            |        |                 |             |                 |                     |       |                |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |               |                |             |                       |                    |              |         |                 |           |         |           |             |            |              |      |        |               |Argentina    |            |             |   |             |           |                    |          |                   |                  |                  |                   |              |                         |           |                |\n"
    * def csvRows10 = "ADD        |                        |                |AAA10   |"+nameVarTARGET+"-"+nowMs+"|            |        |                 |             |                 |                     |       |                |           |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |              |               |                |             |                       |                    |              |         |                 |           |         |           |             |            |              |      |        |               |Mexico       |            |             |   |             |           |                    |          |                   |                  |                  |                   |              |                         |           |                |\n"

    * def csvRowsT = csvRows00 + csvRows01 + csvRows02 + csvRows03 + csvRows04 + csvRows05 + csvRows06 + csvRows07 + csvRows08 + csvRows09 + csvRows10
#   * def csvRowsA = "Action Type|Third-party ID|Reference Number|Group ID|Third-party Name|Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party|Division|Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact|Commodity Type|Bank Name|Bank Address Line|Account No.|Bank City|Branch Name|Bank Country|Address Line|State/Province|City|Region|Zip/Postal Code|Country|Phone Number|Website|Fax|Email Address|Description|Other Names Old Name|Other Name|Other Name Type|Other Name Country|Custom Fields Name|Custom Fields Value\nFULLUPDATE||qwerty1|1|FULLUPDATE - "+ nowMs +"||||||||||rddcentre.admin.np@refinitiv.com|MyDivision|Default|||||||||||||||||||Philippines|||||||||||"

#   * def writeToFileResult = writeToFile( "./src/test/resources/features/api/public_thirdparty/ThirdPartyBulkUpdate/ThirdParty_Add_Update_Delete_FULLUPDATE.csv", csvRowsT )

# PAUSE to allow for server processing of file attachment
    * pauseExecution( 1000 )


    * def createSelfServiceBulkThirdParty1 = call read( "./call/createSelfServiceBulkThirdParty.feature" )   { "csvRowsT": "#(csvRowsT)", "processType": "THIRD_PARTY_ADD_EDIT_DELETE" }

#    And print 'createSelfServiceBulkThirdParty0 = \n', createSelfServiceBulkThirdParty0
    * def createSelfServiceBulkThirdParty1_response =  createSelfServiceBulkThirdParty1.response
    * def processId1 =                                 createSelfServiceBulkThirdParty1_response.data.processId


    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE: UPLOAD FLAT FILE - THIRD_PARTY_ADD_EDIT_DELETE - ADD'
    And print '******** nowMs          = '+ nowMs
    And print '******** xTenantCode    = '+ xTenantCode
    And print '******** requestorEmail = '+ requestorEmail
    And print '******** PROCESS ID     = '+ processId1
    And print '================================\n'
    And print '\n'


#
# Retrieve PROCESS DETAILS by id
#

    * def retrieveSelfServiceProcess1 =          call read( "./call/retrieveSelfServiceBulkThirdPartyProcessDetailsById.feature" )   { "processId": "#(processId1)" }

    * def retrieveSelfServiceProcess1_response = retrieveSelfServiceProcess1.response
#    And print "retrieveSelfServiceProcess1_response =\n", retrieveSelfServiceProcess1_response
    * def status1 =                              retrieveSelfServiceProcess1_response.data.status

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: UPLOAD CSV FILE - THIRD_PARTY_ADD_EDIT_DELETE - ADD'
    And print '******** nowMs          = '+ nowMs
    And print '******** xTenantCode    = '+ xTenantCode
    And print '******** requestorEmail = '+ requestorEmail
    And print '******** PROCESS ID     = '+ processId1
    And print '******** STATUS         = '+ status1
    And print '================================\n'
    And print '\n'



#
# VALIDATE response body SCHEMA
#
    And match retrieveSelfServiceProcess1_response ==
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

    * def validateSuccess1 = ( retrieveSelfServiceProcess1_response.data.recordProcessed==10 && retrieveSelfServiceProcess1_response.data.recordWithErrors==0 )

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: UPLOAD CSV FILE - THIRD_PARTY_ADD_EDIT_DELETE - PARTUPDATE'
    And print '******** PROCESS ID       = '+ processId1
    And print '******** STATUS           = '+ status1
    And print '******** VALIDATE Success = '+ validateSuccess1
    And print '================================\n'
    And print '\n'

    * match validateSuccess1 == true


#
# RETRIEVE third-party LIST for TODAY
#

    * def retrieveThirdPartyListResult1 = call read( "./call/retrieveThirdPartyListForToday.feature" )   { "pageSize": 400, "start": "#(nowStartISODate4)", "end": "#(nowEndISODate4)" }


#
# FILTER third-parties for TARGET third-party id VALIDATION & DELETION
#

    * def filterByNameStatusFn =
      """
        function( dataElem ) {
          var nameRegExp = new RegExp( "^("+ nameVarTARGET +")([-][0-9]{13})?$" );
          return ( dataElem.status=='NEW' && nameRegExp.test(dataElem.name) );
        }
      """


    * def filterByExactNameFn =
      """
        function( dataElem ) {
          return ( dataElem.status=='NEW' && dataElem.name==(nameVarTARGET +'-'+ nowMs) );
        }
      """

#    And print "retrieveThirdPartyListResult0 = \n", retrieveThirdPartyListResult0

    * def thirdPartyArrTODAYACTIVE =     get retrieveThirdPartyListResult1.response.data[*]
    * def thirdPartyIdsTODAYACTIVE =     get retrieveThirdPartyListResult1.response.data[*].id

    * def thirdPartyArrTODAYNEW =        $retrieveThirdPartyListResult1.response.data[ ?(@.status=='NEW') ]
    * def thirdPartyIdsTODAYNEW =        get thirdPartyArrTODAYNEW[*].id

    * def thirdPartyArrTODAYNAME =       karate.filter( thirdPartyArrTODAYACTIVE, filterByNameStatusFn )
    * def thirdPartyIdsTODAYNAME =       get thirdPartyArrTODAYNAME[*].id

    * def thirdPartyArrTODAYTARGET =     karate.filter( thirdPartyArrTODAYNEW, filterByExactNameFn )
    * def thirdPartyIdsTODAYTARGET =     get thirdPartyArrTODAYTARGET[*].id

    * def thirdPartyIdsTODAYNAMEArr =    call createThirdPartyIdsArrFn thirdPartyIdsTODAYNAME
    * def thirdPartyIdsTODAYTARGETArr =  call createThirdPartyIdsArrFn thirdPartyIdsTODAYTARGET

    And print '\n'
    And print '================================'
    And print '******** RETRIEVE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
    And print '******** thirdPartyArrTODAYACTIVE       = '+ thirdPartyArrTODAYACTIVE.length    +': '+ thirdPartyArrTODAYACTIVE
    And print '******** thirdPartyIdsTODAYACTIVE       = '+ thirdPartyIdsTODAYACTIVE.length    +': '+ thirdPartyIdsTODAYACTIVE
    And print '******** thirdPartyArrTODAYNEW          = '+ thirdPartyArrTODAYNEW.length       +': '+ thirdPartyArrTODAYNEW
    And print '******** thirdPartyIdsTODAYNEW          = '+ thirdPartyIdsTODAYNEW.length       +': '+ thirdPartyIdsTODAYNEW
    And print '******** thirdPartyArrTODAYNAME         = '+ thirdPartyArrTODAYNAME.length      +': '+ thirdPartyArrTODAYNAME
    And print '******** thirdPartyIdsTODAYNAME         = '+ thirdPartyIdsTODAYNAME.length      +': '+ thirdPartyIdsTODAYNAME
    And print '******** thirdPartyArrTODAYTARGET       = '+ thirdPartyArrTODAYTARGET.length    +': '+ thirdPartyArrTODAYTARGET
    And print '******** thirdPartyIdsTODAYTARGET       = '+ thirdPartyIdsTODAYTARGET.length    +': '+ thirdPartyIdsTODAYTARGET
    And print '******** '
    And print '******** thirdPartyIdsTODAYNAMEArr      = '+ thirdPartyIdsTODAYNAMEArr.length   +': '+ thirdPartyIdsTODAYNAMEArr
    And print '******** thirdPartyIdsTODAYTARGETArr    = '+ thirdPartyIdsTODAYTARGETArr.length +': '+ thirdPartyIdsTODAYTARGETArr
    And print '================================\n'
    And print '\n'


#
# VALIDATE: RETRIEVE TARGET third-party by id
#

#    * def retrieveResult =       call read( "./call/retrieveThirdPartyById.feature" )   { "thirdPartyId": "#(thirdPartyIdsTODAYTARGET[0])" }
    * def retrieveThirdPartyByIdResult1 =  call read( "./call/retrieveThirdPartyById.feature" )   thirdPartyIdsTODAYTARGETArr
#    And print 'retrieveThirdPartyByIdResult2 = \n', retrieveThirdPartyByIdResult2

#    * def description1 =        retrieveThirdPartyByIdResult1[0].response.data.description
#
#    * def customField_Field1 = $retrieveThirdPartyByIdResult1[0].response.data.customFields[ ?(@.name=='Field1') ]


#    And print 'retrieveThirdPartyByIdResult0 = \n',          retrieveThirdPartyByIdResult0
#    And print 'retrieveThirdPartyByIdResult0_count = ',      retrieveThirdPartyByIdResult0.length
#    And print 'retrieveThirdPartyByIdResult0_response = \n', retrieveThirdPartyByIdResult0[0].response

#    * def otherNamesCount =      retrieveResult[0].response.data.otherNames.length
#
#    And match otherNamesCount == VALIDATECOUNT

#    And print '\n'
#    And print '======== VALIDATE ================================'
#    And print 'TEST     description :    VALUE ="'+ description2 +'"'
#    And print 'VALIDATE description :    MATCH ='+ ( description2 == 'Desc abc111' )
#    And print ''
#    And print 'TEST     Field1      :    VALUE ="'+ customField_Field1[0].value +'"'
#    And print 'VALIDATE Field1      :    MATCH ='+ ( customField_Field1[0].value == 'PARTUPDATE TEXT' )
#    And print '==================================================\n'
#    And print '\n'
#
#    And match description2 ==                'Desc abc111'
#    And match customField_Field1[0].value == 'PARTUPDATE TEXT'


#
# DELETE: cleanup TARGET third-party by id
#

#    * def deleteResult =           call read( "./call/deleteThirdParty.feature" ) thirdPartyIdsTODAYNEWArr
    * def deleteResult =           call read( "./call/deleteThirdParty.feature" ) thirdPartyIdsTODAYNAMEArr
#    * def deleteThirdPartyResult1 = call read( "./call/deleteThirdParty.feature" ) thirdPartyIdsTODAYTARGETArr



##
## GET CREATED third-party id:
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
#    * def dataArr =             get response.data[*]
#    * def dataArrNEW =          $dataArr[ ?(@.status=='NEW') ]
#    * def thirdPartyIdsNEW =    get dataArrNEW[*].id
#    * def thirdPartyIdsACTIVE = get response.data[*].id
#
#    * def count = response.data.length
#
## Get CREATED third-party id
#    * def thirdPartyIdCREATED = thirdPartyIdsACTIVE[ count - 1 ]
#
#    And print '\n'
#    And print '================================'
#    And print '******** CREATE THIRD-PARTY: DELETE THIRD-PARTY LIST'
#    And print '******** COUNT: data.length  = '+ count
#    And print '******** thirdPartyIdCREATED = '+ thirdPartyIdCREATED
#    And print '******** thirdPartyIdsACTIVE = '+ thirdPartyIdsACTIVE
#    And print '******** thirdPartyIdsNEW    = '+ thirdPartyIdsNEW
#    And print '================================\n'
#    And print '\n'
#
#
##
## DELETE third-party by id
##
#    * def thirdPartyIdsNEWArr = call createThirdPartyIdsArrFn thirdPartyIdsNEW
#
#    And print '\n'
#    And print '================================'
#    And print '******** SELF-SERVICE: DELETE THIRD-PARTY LIST'
#    And print '******** thirdPartyIdsNEWArr    = '+ thirdPartyIdsNEWArr
#    And print '================================\n'
#    And print '\n'
#
#    * def deleteResult = call read( "./call/deleteThirdParty.feature" ) thirdPartyIdsNEWArr
#
#
##    * def thirdPartyIds = get response.data[*].id
##
##    * def count = response.data.length
##
### Get CREATED third-party id
##    * def thirdPartyIdCreated = thirdPartyIds[ count - 1 ]
##
##    And print '\n'
##    And print '================================'
##    And print '******** CREATE THIRD-PARTY: DELETE THIRD-PARTY LIST'
##    And print '******** COUNT: data.length  = '+ count
##    And print '******** thirdPartyIdCreated = '+ thirdPartyIdCreated
##    And print '******** thirdPartyIds       = '+ thirdPartyIds
##    And print '================================\n'
##    And print '\n'
##
##
###
### DELETE third-party by id
###
##
##    Given url deleteUrl = baseTestUrl
##    And path 'thirdparty', thirdPartyIdCreated
##    And header X-Tenant-Code = xTenantCode
##    And header Authorization = 'Bearer '+ accessToken
##    When method DELETE
##    Then status 204
##
##
###
### CHECK: Retrieve third-party BY ID - expected: NOT FOUND
###
##
##    Given url getUrl = baseTestUrl
##    And path 'thirdparty', thirdPartyIdCreated
##    And header X-Tenant-Code = xTenantCode
##    And header Authorization = 'Bearer '+ accessToken
##    When method GET
##    Then status 404
##
##
###
### CHECK: Get third-parties LIST for this day - expected: NOT FOUND
###
##    Given url getUrl = baseTestUrl
##    And path 'thirdparty'
##    And param pageSize =       100
##    And param start =          nowStartISODate4
##    And param end =            nowEndISODate4
##    And header X-Tenant-Code = xTenantCode
##    And header Authorization = 'Bearer '+ accessToken
##    When method GET
##    Then status 200
##
##    * def thirdPartyIds = get response.data[*].id
##    And assert !thirdPartyIds.contains( thirdPartyIdCreated )
##
##    * def count = response.data.length
##
##    And print '\n'
##    And print '================================'
##    And print '******** CREATE THIRD-PARTY: DELETE THIRD-PARTY LIST'
##    And print '******** COUNT: data.length  = '+ count
##    And print '******** thirdPartyIdCreated = '+ thirdPartyIdCreated
##    And print '******** thirdPartyIds       = '+ thirdPartyIds
##    And print '================================\n'
##    And print '\n'


