@api @public_api @postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEErrorExceedMaxNumBankDtls
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



  Scenario: 01) C37786723 Third-party - PARTUPDATE
                - Verify error for Maximum number of Bank Details exceeded

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 01) EXCEED MAX NUM BANK DETAILS ERROR - PARTUPDATE'
    And print '******** nowMs = '+ nowMs
    And print '================================\n'
    And print '\n'


#
# CREATE: Create third-party
#

    * def nowMs = call fnGetNowMs

    * def nameVarTARGET =       'PUPD-3P-MAXNUMBANKDTLS-ERR'
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


    * def bank0Name =        retrieveThirdPartyByIdResult1[0].response.data.bankDetails[0].name
    * def bank0AccountNo =   retrieveThirdPartyByIdResult1[0].response.data.bankDetails[0].accountNo

    * def bankLength =       retrieveThirdPartyByIdResult1[0].response.data.bankDetails.length

    * def customField_Field1 = $retrieveThirdPartyByIdResult1[0].response.data.customFields[ ?(@.name=='Field1') ]

    And print '\n'
    And print '======== VALIDATE ================================'
    And print 'VALIDATE MATCH ='+ ( bankLength == 1 )                                           +'  COUNT     ="'+ bankLength +'"'
    And print 'VALIDATE MATCH ='+ ( bank0Name  == 'Bank Name' && bank0AccountNo == '11223344' ) +'  bank0Name ="'+ bank0Name  +'"  bank0AccountNo ="'+ bank0AccountNo +'"'
    And print '==================================================\n'
    And print '\n'

#    And match description1 ==                'This is supplier description'
    And match customField_Field1[0].value == null


# ==================================================================================================================
# ======== Case-01) UPDATE BANK DETAILS - 10 rows: Success ==========
# ==================================================================================================================
#
# SELF-SERVICE PARTUPDATE third-party: by BULK-UPLOAD
#

#   * def csvRows00 = "Action Type|Third-party ID          |Reference Number|Group ID|Third-party Name           |Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party   |Division  |Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact      |Commodity Type|Bank Name  |Bank Address Line|Account No.|Bank City|Branch Name|Bank Country |Address Line|State/Province|City  |Region       |Zip/Postal Code|Country      |Phone Number|Website       |Fax|Email Address   |Description|Other Names Old Name|Other Name  |Other Name Type    |Other Name Country|Custom Fields Name         |Custom Fields Value     \n"
    * def csvRows00 = "Action Type|Third-party ID          |Reference Number|Group ID|Third-party Name           |Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party   |Division  |Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact      |Commodity Type|Bank Name  |Bank Address Line|Account No.|Bank City|Branch Name|Bank Country |Address Line|State/Province|City  |Region       |Zip/Postal Code|Country      |Phone Number|Website       |Fax|Email Address   |Description|Other Names Old Name|Other Name  |Other Name Type    |Other Name Country|Custom Fields Name         |Custom Fields Value     |Case System ID|Other Name Case System ID|Notify List|Screening Groups|Other Name Screening Groups\n"

# Success: ADD thirdParty
#   * def csvRows01 = "FULLUPDATE |"+    thirdPartyId    +"|"+    nowMs   +"|1       |FULLUPDATE - "+ nowMs +"   |CORP        |USD     |5K-10K           |AHI/ADA      |PRS/PRA          |02/22/1987            |10M    |11/02/2008      |SOE        |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|A3P           |MoneyBank01|11 Finance Avenue|11111111   |Reno     |MB Reno Br.|United States|11 Main Ave.|Ontario       |Ottawa|Americas/Asia|ZIP90210       |Canada/China |+180011111111|www.test01.com|111|test01@test.com |Desc abc123|                    |Acme01 Inc. |Local Language Name|France            |Field1                     |FULLUPDATE TEXT         \n"
    * def csvRows01 = "PARTUPDATE |"+    thirdPartyId1   +"|"+    nowMs   +"|1       |"+nameVarTARGET+"-"+nowMs+"|            |        |                 |             |                 |02/02/1987           |       |02/02/2008      |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank01|11 Finance Avenue|11111111   |Reno     |MB Reno Br.|United States|            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows02 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank02|22 Finance Avenue|22222222   |Reno     |MB Reno Br.|Australia    |            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows03 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank03|33 Finance Avenue|33333333   |Reno     |MB Reno Br.|Germany      |            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows04 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank04|44 Finance Avenue|44444444   |Reno     |MB Reno Br.|France       |            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows05 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank05|55 Finance Avenue|55555555   |Reno     |MB Reno Br.|Italy        |            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows06 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank06|66 Finance Avenue|66666666   |Reno     |MB Reno Br.|Austria      |            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows07 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank07|77 Finance Avenue|77777777   |Reno     |MB Reno Br.|China        |            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows08 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank08|88 Finance Avenue|88888888   |Reno     |MB Reno Br.|Malaysia     |            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows09 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank09|99 Finance Avenue|99999999   |Reno     |MB Reno Br.|Argentina    |            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows10 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank10|00 Finance Avenue|10101010   |Reno     |MB Reno Br.|Philippines  |            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"

    * def csvRowsT = csvRows00 + csvRows01 + csvRows02 + csvRows03 + csvRows04 + csvRows05 + csvRows06 + csvRows07 + csvRows08 + csvRows09 + csvRows10
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



    * def bank0Name2 =        retrieveThirdPartyByIdResult2[0].response.data.bankDetails[0].name
    * def bank1Name2 =        retrieveThirdPartyByIdResult2[0].response.data.bankDetails[1].name
    * def bank2Name2 =        retrieveThirdPartyByIdResult2[0].response.data.bankDetails[2].name
    * def bank3Name2 =        retrieveThirdPartyByIdResult2[0].response.data.bankDetails[3].name
    * def bank4Name2 =        retrieveThirdPartyByIdResult2[0].response.data.bankDetails[4].name
    * def bank5Name2 =        retrieveThirdPartyByIdResult2[0].response.data.bankDetails[5].name
    * def bank6Name2 =        retrieveThirdPartyByIdResult2[0].response.data.bankDetails[6].name
    * def bank7Name2 =        retrieveThirdPartyByIdResult2[0].response.data.bankDetails[7].name
    * def bank8Name2 =        retrieveThirdPartyByIdResult2[0].response.data.bankDetails[8].name
    * def bank9Name2 =        retrieveThirdPartyByIdResult2[0].response.data.bankDetails[9].name

    * def bank0AccountNo2 =   retrieveThirdPartyByIdResult2[0].response.data.bankDetails[0].accountNo
    * def bank1AccountNo2 =   retrieveThirdPartyByIdResult2[0].response.data.bankDetails[1].accountNo
    * def bank2AccountNo2 =   retrieveThirdPartyByIdResult2[0].response.data.bankDetails[2].accountNo
    * def bank3AccountNo2 =   retrieveThirdPartyByIdResult2[0].response.data.bankDetails[3].accountNo
    * def bank4AccountNo2 =   retrieveThirdPartyByIdResult2[0].response.data.bankDetails[4].accountNo
    * def bank5AccountNo2 =   retrieveThirdPartyByIdResult2[0].response.data.bankDetails[5].accountNo
    * def bank6AccountNo2 =   retrieveThirdPartyByIdResult2[0].response.data.bankDetails[6].accountNo
    * def bank7AccountNo2 =   retrieveThirdPartyByIdResult2[0].response.data.bankDetails[7].accountNo
    * def bank8AccountNo2 =   retrieveThirdPartyByIdResult2[0].response.data.bankDetails[8].accountNo
    * def bank9AccountNo2 =   retrieveThirdPartyByIdResult2[0].response.data.bankDetails[9].accountNo

    * def bankLength2 =        retrieveThirdPartyByIdResult2[0].response.data.bankDetails.length

#    * def customField_Field1 = $retrieveThirdPartyByIdResult1[0].response.data.customFields[ ?(@.name=='Field1') ]

    And print '\n'
    And print '======== VALIDATE ================================'
    And print 'VALIDATE MATCH ='+ ( bankLength2 == 10)            +'  COUNT     ="'+ bankLength2 +'"'
    And print 'VALIDATE MATCH ='+ ( bank0Name2 == 'MoneyBank01' && bank0AccountNo2 == '11111111' ) +'  bank0Name ="'+ bank0Name2 +'"  bank0AccountNo ="'+ bank0AccountNo2 +'"'
    And print 'VALIDATE MATCH ='+ ( bank1Name2 == 'MoneyBank02' && bank1AccountNo2 == '22222222' ) +'  bank1Name ="'+ bank1Name2 +'"  bank1AccountNo ="'+ bank1AccountNo2 +'"'
    And print 'VALIDATE MATCH ='+ ( bank2Name2 == 'MoneyBank03' && bank2AccountNo2 == '33333333' ) +'  bank2Name ="'+ bank2Name2 +'"  bank2AccountNo ="'+ bank2AccountNo2 +'"'
    And print 'VALIDATE MATCH ='+ ( bank3Name2 == 'MoneyBank04' && bank3AccountNo2 == '44444444' ) +'  bank3Name ="'+ bank3Name2 +'"  bank3AccountNo ="'+ bank3AccountNo2 +'"'
    And print 'VALIDATE MATCH ='+ ( bank4Name2 == 'MoneyBank05' && bank4AccountNo2 == '55555555' ) +'  bank4Name ="'+ bank4Name2 +'"  bank4AccountNo ="'+ bank4AccountNo2 +'"'
    And print 'VALIDATE MATCH ='+ ( bank5Name2 == 'MoneyBank06' && bank5AccountNo2 == '66666666' ) +'  bank5Name ="'+ bank5Name2 +'"  bank5AccountNo ="'+ bank5AccountNo2 +'"'
    And print 'VALIDATE MATCH ='+ ( bank6Name2 == 'MoneyBank07' && bank6AccountNo2 == '77777777' ) +'  bank6Name ="'+ bank6Name2 +'"  bank6AccountNo ="'+ bank6AccountNo2 +'"'
    And print 'VALIDATE MATCH ='+ ( bank7Name2 == 'MoneyBank08' && bank7AccountNo2 == '88888888' ) +'  bank7Name ="'+ bank7Name2 +'"  bank7AccountNo ="'+ bank7AccountNo2 +'"'
    And print 'VALIDATE MATCH ='+ ( bank8Name2 == 'MoneyBank09' && bank8AccountNo2 == '99999999' ) +'  bank8Name ="'+ bank8Name2 +'"  bank8AccountNo ="'+ bank8AccountNo2 +'"'
    And print 'VALIDATE MATCH ='+ ( bank9Name2 == 'MoneyBank10' && bank9AccountNo2 == '10101010' ) +'  bank9Name ="'+ bank9Name2 +'"  bank9AccountNo ="'+ bank9AccountNo2 +'"'
    And print '==================================================\n'
    And print '\n'

#    And match description1 ==                'This is supplier description'
#    And match customField_Field1[0].value == null
# ================================================================================
# ================================================================================



# ==================================================================================================================
# ======== Case-02) EXCEED MAX NUM BANK DETAILS - 11 rows: Error ==========
# ==================================================================================================================
#
# SELF-SERVICE PARTUPDATE third-party: by BULK-UPLOAD
#

#   * def csvRows00 = "Action Type|Third-party ID          |Reference Number|Group ID|Third-party Name           |Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party   |Division  |Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact      |Commodity Type|Bank Name  |Bank Address Line|Account No.|Bank City|Branch Name|Bank Country |Address Line|State/Province|City  |Region       |Zip/Postal Code|Country      |Phone Number|Website       |Fax|Email Address   |Description|Other Names Old Name|Other Name  |Other Name Type    |Other Name Country|Custom Fields Name         |Custom Fields Value     \n"
    * def csvRows00 = "Action Type|Third-party ID          |Reference Number|Group ID|Third-party Name           |Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party   |Division  |Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact      |Commodity Type|Bank Name  |Bank Address Line|Account No.|Bank City|Branch Name|Bank Country |Address Line|State/Province|City  |Region       |Zip/Postal Code|Country      |Phone Number|Website       |Fax|Email Address   |Description|Other Names Old Name|Other Name  |Other Name Type    |Other Name Country|Custom Fields Name         |Custom Fields Value     |Case System ID|Other Name Case System ID|Notify List|Screening Groups|Other Name Screening Groups\n"

# Success: ADD thirdParty
#   * def csvRows01 = "FULLUPDATE |"+    thirdPartyId    +"|"+    nowMs   +"|1       |FULLUPDATE - "+ nowMs +"   |CORP        |USD     |5K-10K           |AHI/ADA      |PRS/PRA          |02/22/1987            |10M    |11/02/2008      |SOE        |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|A3P           |MoneyBank01|11 Finance Avenue|11111111   |Reno     |MB Reno Br.|United States|11 Main Ave.|Ontario       |Ottawa|Americas/Asia|ZIP90210       |Canada/China |+180011111111|www.test01.com|111|test01@test.com |Desc abc123|                    |Acme01 Inc. |Local Language Name|France            |Field1                     |FULLUPDATE TEXT         \n"
    * def csvRows01 = "PARTUPDATE |"+    thirdPartyId1   +"|"+    nowMs   +"|1       |"+nameVarTARGET+"-"+nowMs+"|            |        |                 |             |                 |02/02/1987           |       |02/02/2008      |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank01|11 Finance Avenue|11111111   |Reno     |MB Reno Br.|United States|            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows02 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank02|22 Finance Avenue|22222222   |Reno     |MB Reno Br.|Australia    |            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows03 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank03|33 Finance Avenue|33333333   |Reno     |MB Reno Br.|Germany      |            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows04 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank04|44 Finance Avenue|44444444   |Reno     |MB Reno Br.|France       |            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows05 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank05|55 Finance Avenue|55555555   |Reno     |MB Reno Br.|Italy        |            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows06 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank06|66 Finance Avenue|66666666   |Reno     |MB Reno Br.|Austria      |            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows07 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank07|77 Finance Avenue|77777777   |Reno     |MB Reno Br.|China        |            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows08 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank08|88 Finance Avenue|88888888   |Reno     |MB Reno Br.|Malaysia     |            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows09 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank09|99 Finance Avenue|99999999   |Reno     |MB Reno Br.|Argentina    |            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows10 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank10|A0 Finance Avenue|10101010   |Reno     |MB Reno Br.|Philippines  |            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"
    * def csvRows11 = "           |                        |                |1       |                           |            |        |                 |             |                 |                     |       |                |           |                    |          |              |              |               |                |             |                       |                    |              |MoneyBank11|B1 Finance Avenue|10101011   |Reno     |MB Reno Br.|Indonesia    |            |              |      |             |               |             |             |              |   |                |           |                    |            |                   |                  |                           |                        |              |                         |           |                |\n"

#    * def csvRowsT = csvRows00 + csvRows01 + csvRows02 + csvRows03 + csvRows04 + csvRows05 + csvRows06 + csvRows07 + csvRows08 + csvRows09 + csvRows10
    * def csvRowsT = csvRows00 + csvRows01 + csvRows02 + csvRows03 + csvRows04 + csvRows05 + csvRows06 + csvRows07 + csvRows08 + csvRows09 + csvRows10 + csvRows11
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


##
## VALIDATE: RETRIEVE TARGET third-party by id
##

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


    * def bank0Name3 =        retrieveThirdPartyByIdResult3[0].response.data.bankDetails[0].name
    * def bank1Name3 =        retrieveThirdPartyByIdResult3[0].response.data.bankDetails[1].name
    * def bank2Name3 =        retrieveThirdPartyByIdResult3[0].response.data.bankDetails[2].name
    * def bank3Name3 =        retrieveThirdPartyByIdResult3[0].response.data.bankDetails[3].name
    * def bank4Name3 =        retrieveThirdPartyByIdResult3[0].response.data.bankDetails[4].name
    * def bank5Name3 =        retrieveThirdPartyByIdResult3[0].response.data.bankDetails[5].name
    * def bank6Name3 =        retrieveThirdPartyByIdResult3[0].response.data.bankDetails[6].name
    * def bank7Name3 =        retrieveThirdPartyByIdResult3[0].response.data.bankDetails[7].name
    * def bank8Name3 =        retrieveThirdPartyByIdResult3[0].response.data.bankDetails[8].name
    * def bank9Name3 =        retrieveThirdPartyByIdResult3[0].response.data.bankDetails[9].name

    * def bank0AccountNo3 =   retrieveThirdPartyByIdResult3[0].response.data.bankDetails[0].accountNo
    * def bank1AccountNo3 =   retrieveThirdPartyByIdResult3[0].response.data.bankDetails[1].accountNo
    * def bank2AccountNo3 =   retrieveThirdPartyByIdResult3[0].response.data.bankDetails[2].accountNo
    * def bank3AccountNo3 =   retrieveThirdPartyByIdResult3[0].response.data.bankDetails[3].accountNo
    * def bank4AccountNo3 =   retrieveThirdPartyByIdResult3[0].response.data.bankDetails[4].accountNo
    * def bank5AccountNo3 =   retrieveThirdPartyByIdResult3[0].response.data.bankDetails[5].accountNo
    * def bank6AccountNo3 =   retrieveThirdPartyByIdResult3[0].response.data.bankDetails[6].accountNo
    * def bank7AccountNo3 =   retrieveThirdPartyByIdResult3[0].response.data.bankDetails[7].accountNo
    * def bank8AccountNo3 =   retrieveThirdPartyByIdResult3[0].response.data.bankDetails[8].accountNo
    * def bank9AccountNo3 =   retrieveThirdPartyByIdResult3[0].response.data.bankDetails[9].accountNo

    * def bankLength3 =        retrieveThirdPartyByIdResult3[0].response.data.bankDetails.length

#    * def customField_Field1 = $retrieveThirdPartyByIdResult1[0].response.data.customFields[ ?(@.name=='Field1') ]

    And print '\n'
    And print '======== VALIDATE ================================'
    And print 'VALIDATE MATCH ='+ ( bankLength3 == 10 )                                            +'  COUNT      ="'+ bankLength3 +'"'
    And print 'VALIDATE MATCH ='+ ( bank0Name3 == 'MoneyBank01' && bank0AccountNo3 == '11111111' ) +'  bank0Name3 ="'+ bank0Name2  +'"  bank0AccountNo3 ="'+ bank0AccountNo3 +'"'
    And print 'VALIDATE MATCH ='+ ( bank1Name3 == 'MoneyBank02' && bank1AccountNo3 == '22222222' ) +'  bank1Name3 ="'+ bank1Name2  +'"  bank1AccountNo3 ="'+ bank1AccountNo3 +'"'
    And print 'VALIDATE MATCH ='+ ( bank2Name3 == 'MoneyBank03' && bank2AccountNo3 == '33333333' ) +'  bank2Name3 ="'+ bank2Name2  +'"  bank2AccountNo3 ="'+ bank2AccountNo3 +'"'
    And print 'VALIDATE MATCH ='+ ( bank3Name3 == 'MoneyBank04' && bank3AccountNo3 == '44444444' ) +'  bank3Name3 ="'+ bank3Name2  +'"  bank3AccountNo3 ="'+ bank3AccountNo3 +'"'
    And print 'VALIDATE MATCH ='+ ( bank4Name3 == 'MoneyBank05' && bank4AccountNo3 == '55555555' ) +'  bank4Name3 ="'+ bank4Name2  +'"  bank4AccountNo3 ="'+ bank4AccountNo3 +'"'
    And print 'VALIDATE MATCH ='+ ( bank5Name3 == 'MoneyBank06' && bank5AccountNo3 == '66666666' ) +'  bank5Name3 ="'+ bank5Name2  +'"  bank5AccountNo3 ="'+ bank5AccountNo3 +'"'
    And print 'VALIDATE MATCH ='+ ( bank6Name3 == 'MoneyBank07' && bank6AccountNo3 == '77777777' ) +'  bank6Name3 ="'+ bank6Name2  +'"  bank6AccountNo3 ="'+ bank6AccountNo3 +'"'
    And print 'VALIDATE MATCH ='+ ( bank7Name3 == 'MoneyBank08' && bank7AccountNo3 == '88888888' ) +'  bank7Name3 ="'+ bank7Name2  +'"  bank7AccountNo3 ="'+ bank7AccountNo3 +'"'
    And print 'VALIDATE MATCH ='+ ( bank8Name3 == 'MoneyBank09' && bank8AccountNo3 == '99999999' ) +'  bank8Name3 ="'+ bank8Name2  +'"  bank8AccountNo3 ="'+ bank8AccountNo3 +'"'
    And print 'VALIDATE MATCH ='+ ( bank9Name3 == 'MoneyBank10' && bank9AccountNo3 == '10101010' ) +'  bank9Name3 ="'+ bank9Name2  +'"  bank9AccountNo3 ="'+ bank9AccountNo3 +'"'
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

