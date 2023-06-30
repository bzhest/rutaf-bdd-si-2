@api @public_api @postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorExceedMaxNumFaxes
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



  Scenario: 01) C37786726 Third-party - PARTUPDATE
                - Verify error for Maximum number of Fax exceeded

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 01) EXCEED MAX NUM FAXES ERROR - PARTUPDATE'
    And print '******** nowMs = '+ nowMs
    And print '================================\n'
    And print '\n'


#
# CREATE: Create third-party
#

    * def nowMs = call fnGetNowMs

    * def nameVarTARGET =       'PUPD-3P-MAXNUMFAXES-ERR'
    * def nameTARGET =          nameVarTARGET +'-'+ nowMs

    * def requestBody_createThirdParty1 =
      """
          {
            "referenceNo": "#(''+ nowMs)",
            "name": "#(nameVarTARGET +'-'+ nowMs)",
            "currency": "USD",
            "companyType": "CORP",
            "industryType": "AHI",
            "organizationSize": "11-50",
            "businessType": "PRS",
            "incorporationDate": "2001-06-18T05:32:07-0800",
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
                "1234567890"
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
                "accountNo": "11223344",
                "addressLine": "Address 1",
                "branchName": "Branch Name",
                "city": "City 1",
                "country": "US",
                "name": "Bank Name"
              }
            ],
            "otherNames": [
              {
                "name":                  "Shellack",
                "iwNameType":            "Local Language Name",
                "countryOfRegistration": "CA"
              }
            ]
          }
      """

    * def createThirdPartyResult1 = call read( "./call/createThirdParty.feature" ) { "requestBody_createThirdParty": '#(requestBody_createThirdParty1)' }
    * def thirdPartyId1 =           createThirdPartyResult1.response.data.id
#    * def thirdPartyIds1 =         get createThirdPartyResult1.response.data.id


    * def thirdPartyIds1Arr =       call createThirdPartyIdsArrFn [ '#(thirdPartyId1)' ]

    And print '\n'
    And print '================================'
    And print '******** thirdPartyId1     = '+ thirdPartyId1
#    And print '******** thirdPartyIds1    = '+ thirdPartyIds1
    And print '******** thirdPartyIds1Arr = '+ thirdPartyIds1Arr
    And print '================================\n'
    And print '\n'


#
# RETRIEVE third-party LIST for TODAY
#

    * def retrieveThirdPartyListResult1 = call read( "./call/retrieveThirdPartyListForToday.feature" )   { "pageSize": 400, "start": "#(nowStartISODate4)", "end": "#(nowEndISODate4)" }


#
# FILTER third-parties for TARGET third-party id VALIDATION & DELETION
#

#    * def nameVarTARGET =       'DUPL REFNO-0'
#    * def nameTARGET =          nameVarTARGET +'-'+ nowMs

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

#    And print 'retrieveThirdPartyByIdResult1 = \n',          retrieveThirdPartyByIdResult1
#    And print 'retrieveThirdPartyByIdResult0_count = ',      retrieveThirdPartyByIdResult0.length
#    And print 'retrieveThirdPartyByIdResult0_response = \n', retrieveThirdPartyByIdResult0[0].response

#    * def otherNamesCount =      retrieveResult[0].response.data.otherNames.length
#
#    And match otherNamesCount == VALIDATECOUNT
#
#    And print '\n'
#    And print '======== VALIDATE ================================'
#    And print 'TEST otherNames:    COUNT =', otherNamesCount
#    And print 'VALIDATE COUNT :    MATCH =', ( otherNamesCount==VALIDATECOUNT )
#    And print '==================================================\n'
#    And print '\n'

    * def fax01 =        retrieveThirdPartyByIdResult1[0].response.data.contactInformation.fax[0]
    * def faxLength1 =   retrieveThirdPartyByIdResult1[0].response.data.contactInformation.fax.length

    * def customField_Field1 = $retrieveThirdPartyByIdResult1[0].response.data.customFields[ ?(@.name=='Field1') ]

    And print '\n'
    And print '======== VALIDATE ================================'
    And print 'VALIDATE MATCH ='+ ( faxLength1 == 1 )            +'  COUNT ="'+ faxLength1 +'"'
    And print 'VALIDATE MATCH ='+ ( fax01      == '1234567890' ) +'  fax01 ="'+ fax01      +'"'
    And print '==================================================\n'
    And print '\n'

#    And match description1 ==                'This is supplier description'
    And match customField_Field1[0].value == null


# ==================================================================================================================
# ======== Case-01) UPDATE MAX NUM FAXES - 5 rows: Success ==========
# ==================================================================================================================
#
# SELF-SERVICE PARTUPDATE third-party: by BULK-UPLOAD
#

#   * def csvRows00 = "Action Type|Third-party ID          |Reference Number|Group ID|Third-party Name           |Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party   |Division  |Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact      |Commodity Type|Bank Name  |Bank Address Line|Account No.|Bank City|Branch Name|Bank Country |Address Line|State/Province|City  |Region       |Zip/Postal Code|Country      |Phone Number|Website       |Fax|Email Address   |Description|Other Names Old Name|Other Name  |Other Name Type    |Other Name Country|Custom Fields Name         |Custom Fields Value     \n"
    * def csvRows00 = "Action Type|Third-party ID          |Reference Number|Group ID|Third-party Name           |Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party   |Division  |Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact      |Commodity Type|Bank Name  |Bank Address Line|Account No.|Bank City|Branch Name|Bank Country |Address Line|State/Province|City  |Region       |Zip/Postal Code|Country      |Phone Number|Website       |Fax|Email Address   |Description|Other Names Old Name|Other Name  |Other Name Type    |Other Name Country|Custom Fields Name         |Custom Fields Value     |Case System ID|Other Name Case System ID|Notify List|Screening Groups|Other Name Screening Groups\n"

# Success: ADD thirdParty
#   * def csvRows01 = "FULLUPDATE |"+    thirdPartyId    +"|"+    nowMs   +"|1       |FULLUPDATE - "+ nowMs +"   |CORP        |USD     |5K-10K           |AHI/ADA      |PRS/PRA          |02/22/1987            |10M    |11/02/2008      |SOE        |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|A3P           |MoneyBank01|11 Finance Avenue|11111111   |Reno     |MB Reno Br.|United States|11 Main Ave.|Ontario       |Ottawa|Americas/Asia|ZIP90210       |Canada/China |+180011111111|www.test01.com|111|test01@test.com |Desc abc123|                    |Acme01 Inc. |Local Language Name|France            |Field1                     |FULLUPDATE TEXT         \n"
    * def csvRows01 = "PARTUPDATE |"+    thirdPartyId1   +"|"+    nowMs   +"|1       |"+nameVarTARGET+"-"+nowMs+"|            |        |                 |             |                 |02/02/1987           |       |02/02/2008      |           |                    |          |              |              |               |                |             |                       |                    |              |           |                 |           |         |           |             |            |              |      |             |               |             |             |              |111|                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows02 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |           |                 |           |         |           |             |            |              |      |             |               |             |             |              |222|                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows03 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |           |                 |           |         |           |             |            |              |      |             |               |             |             |              |333|                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows04 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |           |                 |           |         |           |             |            |              |      |             |               |             |             |              |444|                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows05 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |           |                 |           |         |           |             |            |              |      |             |               |             |             |              |555|                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"

    * def csvRowsT = csvRows00 + csvRows01 + csvRows02 + csvRows03 + csvRows04 + csvRows05
#    * def csvRowsT = csvRows00 + csvRows01 + csvRows02 + csvRows03

#   * def csvRowsA = "Action Type|Third-party ID|Reference Number|Group ID|Third-party Name|Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party|Division|Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact|Commodity Type|Bank Name|Bank Address Line|Account No.|Bank City|Branch Name|Bank Country|Address Line|State/Province|City|Region|Zip/Postal Code|Country|Phone Number|Website|Fax|Email Address|Description|Other Names Old Name|Other Name|Other Name Type|Other Name Country|Custom Fields Name|Custom Fields Value\nFULLUPDATE||qwerty1|1|FULLUPDATE - "+ nowMs +"||||||||||rddcentre.admin.np@refinitiv.com|MyDivision|Default|||||||||||||||||||Philippines|||||||||||"

#   * def writeToFileResult = writeToFile( "./src/test/resources/features/api/public_thirdparty/ThirdPartyBulkUpdate/ThirdParty_Add_Update_Delete_FULLUPDATE.csv", csvRowsT )

# PAUSE to allow for server processing of file attachment
    * pauseExecution( 1000 )


    * def createSelfServiceBulkThirdParty2 = call read( "./call/createSelfServiceBulkThirdParty.feature" )   { "csvRowsT": "#(csvRowsT)", "processType": "THIRD_PARTY_ADD_EDIT_DELETE" }

#    And print 'createSelfServiceBulkThirdParty0 = \n', createSelfServiceBulkThirdParty0
    * def createSelfServiceBulkThirdParty2_response =  createSelfServiceBulkThirdParty2.response
    * def processId2 =                                 createSelfServiceBulkThirdParty2_response.data.processId

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE: UPLOAD FLAT FILE - THIRD_PARTY_ADD_EDIT_DELETE'
    And print '******** PROCESS ID     = '+ processId2
    And print '================================\n'
    And print '\n'


#
# Retrieve PROCESS DETAILS by id
#

    * def retrieveSelfServiceProcess2 =          call read( "./call/retrieveSelfServiceBulkThirdPartyProcessDetailsById.feature" )   { "processId": "#(processId2)" }

    * def retrieveSelfServiceProcess2_response = retrieveSelfServiceProcess2.response
#    And print "retrieveSelfServiceProcess1_response =\n", retrieveSelfServiceProcess1_response
    * def status2 =                              retrieveSelfServiceProcess2_response.data.status

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: UPLOAD CSV FILE - THIRD_PARTY_ADD_EDIT_DELETE - ADD'
    And print '******** nowMs          = '+ nowMs
    And print '******** xTenantCode    = '+ xTenantCode
    And print '******** requestorEmail = '+ requestorEmail
    And print '******** PROCESS ID     = '+ processId2
    And print '******** STATUS         = '+ status2
    And print '================================\n'
    And print '\n'


#
# VALIDATE response body SCHEMA: SUCCESS
#
    And match retrieveSelfServiceProcess2_response ==
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
                             "triggeredBy":         "##string",
                             "processType":         "THIRD_PARTY_ADD_EDIT_DELETE"
                         }
            }
          """

    * def validateSuccess2 = ( retrieveSelfServiceProcess2_response.data.recordProcessed==1 && retrieveSelfServiceProcess2_response.data.recordWithErrors==0 )
#    * def validateError2 =   ( retrieveSelfServiceProcess2_response.data.recordProcessed==0 && retrieveSelfServiceProcess2_response.data.recordWithErrors==1 )

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: UPLOAD CSV FILE - THIRD_PARTY_ADD_EDIT_DELETE - PARTUPDATE'
    And print '******** PROCESS ID       = '+ processId2
    And print '******** STATUS           = '+ status2
    And print '******** VALIDATE Success = '+ validateSuccess2
    And print '================================\n'
    And print '\n'

    * match validateSuccess2 == true
#    * match validateError2 ==   true


#
# VALIDATE: RETRIEVE TARGET third-party by id
#

#    * def retrieveResult =       call read( "./call/retrieveThirdPartyById.feature" )   { "thirdPartyId": "#(thirdPartyIdsTODAYTARGET[0])" }
    * def retrieveThirdPartyByIdResult2 =  call read( "./call/retrieveThirdPartyById.feature" )   thirdPartyIdsTODAYTARGETArr
#    And print 'retrieveThirdPartyByIdResult2 = \n', retrieveThirdPartyByIdResult2

#    * def description2 =        retrieveThirdPartyByIdResult2[0].response.data.description
#
#    * def customField_Field1 = $retrieveThirdPartyByIdResult2[0].response.data.customFields[ ?(@.name=='Field1') ]


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


    * def fax02 =        retrieveThirdPartyByIdResult2[0].response.data.contactInformation.fax[0]
    * def fax12 =        retrieveThirdPartyByIdResult2[0].response.data.contactInformation.fax[1]
    * def fax22 =        retrieveThirdPartyByIdResult2[0].response.data.contactInformation.fax[2]
    * def fax32 =        retrieveThirdPartyByIdResult2[0].response.data.contactInformation.fax[3]
    * def fax42 =        retrieveThirdPartyByIdResult2[0].response.data.contactInformation.fax[4]

    * def faxLength2 =   retrieveThirdPartyByIdResult2[0].response.data.contactInformation.fax.length
#
##    * def customField_Field1 = $retrieveThirdPartyByIdResult1[0].response.data.customFields[ ?(@.name=='Field1') ]

    And print '\n'
    And print '======== VALIDATE ================================'
    And print 'VALIDATE MATCH ='+ ( faxLength2 == 5 ) +'  COUNT ="'+ faxLength2 +'"'
    And print 'VALIDATE MATCH ='+ ( fax02 == '111' )  +'  fax02 ="'+ fax02      +'"'
    And print 'VALIDATE MATCH ='+ ( fax12 == '222' )  +'  fax12 ="'+ fax12      +'"'
    And print 'VALIDATE MATCH ='+ ( fax22 == '333' )  +'  fax22 ="'+ fax22      +'"'
    And print 'VALIDATE MATCH ='+ ( fax32 == '444' )  +'  fax32 ="'+ fax32      +'"'
    And print 'VALIDATE MATCH ='+ ( fax42 == '555' )  +'  fax42 ="'+ fax42      +'"'
    And print '==================================================\n'
    And print '\n'

#    And match description1 ==                'This is supplier description'
#    And match customField_Field1[0].value == null
# ================================================================================
# ================================================================================


# ==================================================================================================================
# ======== Case-02) EXCEED MAX NUM FAXES - 6 rows: Error ==========
# ==================================================================================================================
#
# SELF-SERVICE PARTUPDATE third-party: by BULK-UPLOAD
#

#   * def csvRows00 = "Action Type|Third-party ID          |Reference Number|Group ID|Third-party Name           |Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party   |Division  |Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact      |Commodity Type|Bank Name  |Bank Address Line|Account No.|Bank City|Branch Name|Bank Country |Address Line|State/Province|City  |Region       |Zip/Postal Code|Country      |Phone Number|Website       |Fax|Email Address   |Description|Other Names Old Name|Other Name  |Other Name Type    |Other Name Country|Custom Fields Name         |Custom Fields Value     \n"
    * def csvRows00 = "Action Type|Third-party ID          |Reference Number|Group ID|Third-party Name           |Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party   |Division  |Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact      |Commodity Type|Bank Name  |Bank Address Line|Account No.|Bank City|Branch Name|Bank Country |Address Line|State/Province|City  |Region       |Zip/Postal Code|Country      |Phone Number|Website       |Fax|Email Address   |Description|Other Names Old Name|Other Name  |Other Name Type    |Other Name Country|Custom Fields Name         |Custom Fields Value     |Case System ID|Other Name Case System ID|Notify List|Screening Groups|Other Name Screening Groups\n"

# Success: ADD thirdParty
#   * def csvRows01 = "FULLUPDATE |"+    thirdPartyId    +"|"+    nowMs   +"|1       |FULLUPDATE - "+ nowMs +"   |CORP        |USD     |5K-10K           |AHI/ADA      |PRS/PRA          |02/22/1987            |10M    |11/02/2008      |SOE        |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|A3P           |MoneyBank01|11 Finance Avenue|11111111   |Reno     |MB Reno Br.|United States|11 Main Ave.|Ontario       |Ottawa|Americas/Asia|ZIP90210       |Canada/China |+180011111111|www.test01.com|111|test01@test.com |Desc abc123|                    |Acme01 Inc. |Local Language Name|France            |Field1                     |FULLUPDATE TEXT         \n"
    * def csvRows01 = "PARTUPDATE |"+    thirdPartyId1   +"|"+    nowMs   +"|1       |"+nameVarTARGET+"-"+nowMs+"|            |        |                 |             |                 |02/02/1987           |       |02/02/2008      |           |                    |          |              |              |               |                |             |                       |                    |              |           |                 |           |         |           |             |            |              |      |             |               |             |             |              |111|                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows02 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |           |                 |           |         |           |             |            |              |      |             |               |             |             |              |222|                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows03 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |           |                 |           |         |           |             |            |              |      |             |               |             |             |              |333|                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows04 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |           |                 |           |         |           |             |            |              |      |             |               |             |             |              |444|                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows05 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |           |                 |           |         |           |             |            |              |      |             |               |             |             |              |555|                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows06 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |           |                 |           |         |           |             |            |              |      |             |               |             |             |              |666|                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"

    * def csvRowsT = csvRows00 + csvRows01 + csvRows02 + csvRows03 + csvRows04 + csvRows05 + csvRows06
#    * def csvRowsT = csvRows00 + csvRows01 + csvRows02 + csvRows03

#   * def csvRowsA = "Action Type|Third-party ID|Reference Number|Group ID|Third-party Name|Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party|Division|Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact|Commodity Type|Bank Name|Bank Address Line|Account No.|Bank City|Branch Name|Bank Country|Address Line|State/Province|City|Region|Zip/Postal Code|Country|Phone Number|Website|Fax|Email Address|Description|Other Names Old Name|Other Name|Other Name Type|Other Name Country|Custom Fields Name|Custom Fields Value\nFULLUPDATE||qwerty1|1|FULLUPDATE - "+ nowMs +"||||||||||rddcentre.admin.np@refinitiv.com|MyDivision|Default|||||||||||||||||||Philippines|||||||||||"

#   * def writeToFileResult = writeToFile( "./src/test/resources/features/api/public_thirdparty/ThirdPartyBulkUpdate/ThirdParty_Add_Update_Delete_FULLUPDATE.csv", csvRowsT )

# PAUSE to allow for server processing of file attachment
    * pauseExecution( 1000 )


    * def createSelfServiceBulkThirdParty3 = call read( "./call/createSelfServiceBulkThirdParty.feature" )   { "csvRowsT": "#(csvRowsT)", "processType": "THIRD_PARTY_ADD_EDIT_DELETE" }

#    And print 'createSelfServiceBulkThirdParty0 = \n', createSelfServiceBulkThirdParty0
    * def createSelfServiceBulkThirdParty3_response =  createSelfServiceBulkThirdParty3.response
    * def processId3 =                                 createSelfServiceBulkThirdParty3_response.data.processId

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE: UPLOAD FLAT FILE - THIRD_PARTY_ADD_EDIT_DELETE'
    And print '******** PROCESS ID     = '+ processId3
    And print '================================\n'
    And print '\n'


#
# Retrieve PROCESS DETAILS by id
#

    * def retrieveSelfServiceProcess3 =          call read( "./call/retrieveSelfServiceBulkThirdPartyProcessDetailsById.feature" )   { "processId": "#(processId3)" }

    * def retrieveSelfServiceProcess3_response = retrieveSelfServiceProcess3.response
#    And print "retrieveSelfServiceProcess1_response =\n", retrieveSelfServiceProcess1_response
    * def status3 =                              retrieveSelfServiceProcess3_response.data.status

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: UPLOAD CSV FILE - THIRD_PARTY_ADD_EDIT_DELETE - ADD'
    And print '******** nowMs          = '+ nowMs
    And print '******** xTenantCode    = '+ xTenantCode
    And print '******** requestorEmail = '+ requestorEmail
    And print '******** PROCESS ID     = '+ processId3
    And print '******** STATUS         = '+ status3
    And print '================================\n'
    And print '\n'


#
# VALIDATE response body SCHEMA: SUCCESS
#
    And match retrieveSelfServiceProcess3_response ==
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
                             "successResponseFile": null,
                             "errorResponseFile":   {
                                                        "filename":  "#string",
                                                        "fileSize":  "#number",
                                                        "location":  "#string"
                                                    },
                             "numberOfRecords":     1,
                             "recordProcessed":     0,
                             "recordWithErrors":    1,
                             "entityType":          "##string",
                             "entityId":            "##string",
                             "childReferenceId":    "##string",
                             "triggeredBy":         "##string",
                             "processType":         "THIRD_PARTY_ADD_EDIT_DELETE"
                         }
            }
          """

#    * def validateSuccess3 = ( retrieveSelfServiceProcess2_response.data.recordProcessed==1 && retrieveSelfServiceProcess2_response.data.recordWithErrors==0 )
    * def validateError3 =   ( retrieveSelfServiceProcess3_response.data.recordProcessed==0 && retrieveSelfServiceProcess3_response.data.recordWithErrors==1 )

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: UPLOAD CSV FILE - THIRD_PARTY_ADD_EDIT_DELETE - PARTUPDATE'
    And print '******** PROCESS ID       = '+ processId3
    And print '******** STATUS           = '+ status3
    And print '******** VALIDATE Error   = '+ validateError3
    And print '================================\n'
    And print '\n'

#    * match validateSuccess3 == true
    * match validateError3 ==   true


#
# VALIDATE: RETRIEVE TARGET third-party by id
#

#    * def retrieveResult =       call read( "./call/retrieveThirdPartyById.feature" )   { "thirdPartyId": "#(thirdPartyIdsTODAYTARGET[0])" }
    * def retrieveThirdPartyByIdResult3 =  call read( "./call/retrieveThirdPartyById.feature" )   thirdPartyIdsTODAYTARGETArr
#    And print 'retrieveThirdPartyByIdResult2 = \n', retrieveThirdPartyByIdResult2

##    * def description2 =        retrieveThirdPartyByIdResult2[0].response.data.description
##
##    * def customField_Field1 = $retrieveThirdPartyByIdResult2[0].response.data.customFields[ ?(@.name=='Field1') ]
#
#
##    And print 'retrieveThirdPartyByIdResult0 = \n',          retrieveThirdPartyByIdResult0
##    And print 'retrieveThirdPartyByIdResult0_count = ',      retrieveThirdPartyByIdResult0.length
##    And print 'retrieveThirdPartyByIdResult0_response = \n', retrieveThirdPartyByIdResult0[0].response
#
##    * def otherNamesCount =      retrieveResult[0].response.data.otherNames.length
##
##    And match otherNamesCount == VALIDATECOUNT
#
##    And print '\n'
##    And print '======== VALIDATE ================================'
##    And print 'TEST     description :    VALUE ="'+ description2 +'"'
##    And print 'VALIDATE description :    MATCH ='+ ( description2 == 'Desc abc111' )
##    And print ''
##    And print 'TEST     Field1      :    VALUE ="'+ customField_Field1[0].value +'"'
##    And print 'VALIDATE Field1      :    MATCH ='+ ( customField_Field1[0].value == 'PARTUPDATE TEXT' )
##    And print '==================================================\n'
##    And print '\n'
##
##    And match description2 ==                'Desc abc111'
##    And match customField_Field1[0].value == 'PARTUPDATE TEXT'


    * def fax03 =        retrieveThirdPartyByIdResult3[0].response.data.contactInformation.fax[0]
    * def fax13 =        retrieveThirdPartyByIdResult3[0].response.data.contactInformation.fax[1]
    * def fax23 =        retrieveThirdPartyByIdResult3[0].response.data.contactInformation.fax[2]
    * def fax33 =        retrieveThirdPartyByIdResult3[0].response.data.contactInformation.fax[3]
    * def fax43 =        retrieveThirdPartyByIdResult3[0].response.data.contactInformation.fax[4]

    * def faxLength3 =   retrieveThirdPartyByIdResult3[0].response.data.contactInformation.fax.length
#
##    * def customField_Field1 = $retrieveThirdPartyByIdResult1[0].response.data.customFields[ ?(@.name=='Field1') ]

    And print '\n'
    And print '======== VALIDATE ================================'
    And print 'VALIDATE MATCH ='+ ( faxLength3 == 5 ) +'  COUNT ="'+ faxLength3 +'"'
    And print 'VALIDATE MATCH ='+ ( fax03 == '111' )  +'  fax03 ="'+ fax03      +'"'
    And print 'VALIDATE MATCH ='+ ( fax13 == '222' )  +'  fax13 ="'+ fax13      +'"'
    And print 'VALIDATE MATCH ='+ ( fax23 == '333' )  +'  fax23 ="'+ fax23      +'"'
    And print 'VALIDATE MATCH ='+ ( fax33 == '444' )  +'  fax33 ="'+ fax33      +'"'
    And print 'VALIDATE MATCH ='+ ( fax43 == '555' )  +'  fax43 ="'+ fax43      +'"'
    And print '==================================================\n'
    And print '\n'

##    And match description1 ==                'This is supplier description'
##    And match customField_Field1[0].value == null
# ================================================================================
# ================================================================================


#
# DELETE: cleanup TARGET third-party by id
#

#    * def deleteResult =           call read( "./call/deleteThirdParty.feature" ) thirdPartyIdsTODAYNEWArr
    * def deleteResult =           call read( "./call/deleteThirdParty.feature" ) thirdPartyIdsTODAYNAMEArr
#    * def deleteThirdPartyResult1 = call read( "./call/deleteThirdParty.feature" ) thirdPartyIdsTODAYTARGETArr

