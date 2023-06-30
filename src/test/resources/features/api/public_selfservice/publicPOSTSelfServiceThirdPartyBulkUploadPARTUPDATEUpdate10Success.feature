@api @public_api @postPublicSelfServiceThirdPartyBulkUploadPARTUPDATEUpdate10Success
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



  Scenario: 01) C37786736 Third-party - PARTUPDATE
                - Update 10 third-party

    * def nowMs01 = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 01) UPDATE 10 THIRD-PARTIES SUCCESS - PARTUPDATE'
    And print '******** nowMs01 = '+ nowMs01
    And print '================================\n'
    And print '\n'


#
# CREATE: Create third-party
#

    * def nameVarTARGET =       'PUPD-3P-10-SUCC'
    * def nameTARGET =          nameVarTARGET +'-'+ nowMs01

    * def requestBody_createThirdParty1 =
      """
          {
            "referenceNo": "#(''+ nowMs01)",
            "name": "#(nameVarTARGET +'-'+ nowMs01)",
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

    * def createThirdPartyResult1 = call read( "./call/createThirdParty.feature" ) { "requestBody_createThirdParty": '#(requestBody_createThirdParty1)' }
    * def thirdPartyId01 =           createThirdPartyResult1.response.data.id
#    * def thirdPartyIds1 =         get createThirdPartyResult1.response.data.id


    * def thirdPartyIds1Arr =       call createThirdPartyIdsArrFn [ '#(thirdPartyId01)' ]

    And print '\n'
    And print '================================'
    And print '******** thirdPartyId01     = '+ thirdPartyId01
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
          return ( dataElem.status=='NEW' && dataElem.name==(nameVarTARGET +'-'+ nowMs01) );
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


#    * def description1 =        retrieveThirdPartyByIdResult1[0].response.data.description
#
#    * def customField_Field1 = $retrieveThirdPartyByIdResult1[0].response.data.customFields[ ?(@.name=='Field1') ]
#
#    And print '\n'
#    And print '======== VALIDATE ================================'
#    And print 'TEST     description :    VALUE ="'+ description1 +'"'
#    And print 'VALIDATE description :    MATCH ='+ ( description1 == 'This is supplier description' )
#    And print ''
#    And print 'TEST     Field1      :    VALUE ="'+ customField_Field1[0].value +'"'
#    And print 'VALIDATE Field1      :    MATCH ='+ ( customField_Field1[0].value == null )
#    And print '==================================================\n'
#    And print '\n'
#
#    And match description1 ==                'This is supplier description'
#    And match customField_Field1[0].value == null

################################################################################



    * def nowMs02 = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 01) UPDATE THIRD-PARTY SEGMENTATION SUCCESS - PARTUPDATE'
    And print '******** nowMs02 = '+ nowMs02
    And print '================================\n'
    And print '\n'


#
# CREATE: Create third-party
#

    * def nameVarTARGET =       'PUPD-3P-10-SUCC'
    * def nameTARGET =          nameVarTARGET +'-'+ nowMs02

    * def requestBody_createThirdParty1 =
      """
          {
            "referenceNo": "#(''+ nowMs02)",
            "name": "#(nameVarTARGET +'-'+ nowMs02)",
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
                "1234567890"
              ],
              "phoneNumber": [
                "1234567890"
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

    * def createThirdPartyResult1 = call read( "./call/createThirdParty.feature" ) { "requestBody_createThirdParty": '#(requestBody_createThirdParty1)' }
    * def thirdPartyId02 =           createThirdPartyResult1.response.data.id
#    * def thirdPartyIds1 =         get createThirdPartyResult1.response.data.id


    * def thirdPartyIds1Arr =       call createThirdPartyIdsArrFn [ '#(thirdPartyId02)' ]

    And print '\n'
    And print '================================'
    And print '******** thirdPartyId02     = '+ thirdPartyId02
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
          return ( dataElem.status=='NEW' && dataElem.name==(nameVarTARGET +'-'+ nowMs02) );
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


#    * def description1 =        retrieveThirdPartyByIdResult1[0].response.data.description
#
#    * def customField_Field1 = $retrieveThirdPartyByIdResult1[0].response.data.customFields[ ?(@.name=='Field1') ]
#
#    And print '\n'
#    And print '======== VALIDATE ================================'
#    And print 'TEST     description :    VALUE ="'+ description1 +'"'
#    And print 'VALIDATE description :    MATCH ='+ ( description1 == 'This is supplier description' )
#    And print ''
#    And print 'TEST     Field1      :    VALUE ="'+ customField_Field1[0].value +'"'
#    And print 'VALIDATE Field1      :    MATCH ='+ ( customField_Field1[0].value == null )
#    And print '==================================================\n'
#    And print '\n'
#
#    And match description1 ==                'This is supplier description'
#    And match customField_Field1[0].value == null

################################################################################



    * def nowMs03 = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 01) UPDATE THIRD-PARTY SEGMENTATION SUCCESS - PARTUPDATE'
    And print '******** nowMs03 = '+ nowMs03
    And print '================================\n'
    And print '\n'


#
# CREATE: Create third-party
#

    * def nameVarTARGET =       'PUPD-3P-10-SUCC'
    * def nameTARGET =          nameVarTARGET +'-'+ nowMs03

    * def requestBody_createThirdParty1 =
      """
          {
            "referenceNo": "#(''+ nowMs03)",
            "name": "#(nameVarTARGET +'-'+ nowMs03)",
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
                "1234567890"
              ],
              "phoneNumber": [
                "1234567890"
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

    * def createThirdPartyResult1 = call read( "./call/createThirdParty.feature" ) { "requestBody_createThirdParty": '#(requestBody_createThirdParty1)' }
    * def thirdPartyId03 =           createThirdPartyResult1.response.data.id
#    * def thirdPartyIds1 =         get createThirdPartyResult1.response.data.id


    * def thirdPartyIds1Arr =       call createThirdPartyIdsArrFn [ '#(thirdPartyId03)' ]

    And print '\n'
    And print '================================'
    And print '******** thirdPartyId03     = '+ thirdPartyId03
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
          return ( dataElem.status=='NEW' && dataElem.name==(nameVarTARGET +'-'+ nowMs03) );
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


#    * def description1 =        retrieveThirdPartyByIdResult1[0].response.data.description
#
#    * def customField_Field1 = $retrieveThirdPartyByIdResult1[0].response.data.customFields[ ?(@.name=='Field1') ]
#
#    And print '\n'
#    And print '======== VALIDATE ================================'
#    And print 'TEST     description :    VALUE ="'+ description1 +'"'
#    And print 'VALIDATE description :    MATCH ='+ ( description1 == 'This is supplier description' )
#    And print ''
#    And print 'TEST     Field1      :    VALUE ="'+ customField_Field1[0].value +'"'
#    And print 'VALIDATE Field1      :    MATCH ='+ ( customField_Field1[0].value == null )
#    And print '==================================================\n'
#    And print '\n'
#
#    And match description1 ==                'This is supplier description'
#    And match customField_Field1[0].value == null

################################################################################



    * def nowMs04 = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 01) UPDATE THIRD-PARTY SEGMENTATION SUCCESS - PARTUPDATE'
    And print '******** nowMs04 = '+ nowMs04
    And print '================================\n'
    And print '\n'


#
# CREATE: Create third-party
#

    * def nameVarTARGET =       'PUPD-3P-10-SUCC'
    * def nameTARGET =          nameVarTARGET +'-'+ nowMs04

    * def requestBody_createThirdParty1 =
      """
          {
            "referenceNo": "#(''+ nowMs04)",
            "name": "#(nameVarTARGET +'-'+ nowMs04)",
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
                "1234567890"
              ],
              "phoneNumber": [
                "1234567890"
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

    * def createThirdPartyResult1 = call read( "./call/createThirdParty.feature" ) { "requestBody_createThirdParty": '#(requestBody_createThirdParty1)' }
    * def thirdPartyId04 =           createThirdPartyResult1.response.data.id
#    * def thirdPartyIds1 =         get createThirdPartyResult1.response.data.id


    * def thirdPartyIds1Arr =       call createThirdPartyIdsArrFn [ '#(thirdPartyId04)' ]

    And print '\n'
    And print '================================'
    And print '******** thirdPartyId04     = '+ thirdPartyId04
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
          return ( dataElem.status=='NEW' && dataElem.name==(nameVarTARGET +'-'+ nowMs04) );
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


#    * def description1 =        retrieveThirdPartyByIdResult1[0].response.data.description
#
#    * def customField_Field1 = $retrieveThirdPartyByIdResult1[0].response.data.customFields[ ?(@.name=='Field1') ]
#
#    And print '\n'
#    And print '======== VALIDATE ================================'
#    And print 'TEST     description :    VALUE ="'+ description1 +'"'
#    And print 'VALIDATE description :    MATCH ='+ ( description1 == 'This is supplier description' )
#    And print ''
#    And print 'TEST     Field1      :    VALUE ="'+ customField_Field1[0].value +'"'
#    And print 'VALIDATE Field1      :    MATCH ='+ ( customField_Field1[0].value == null )
#    And print '==================================================\n'
#    And print '\n'
#
#    And match description1 ==                'This is supplier description'
#    And match customField_Field1[0].value == null

################################################################################



    * def nowMs05 = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 01) UPDATE THIRD-PARTY SEGMENTATION SUCCESS - PARTUPDATE'
    And print '******** nowMs05 = '+ nowMs05
    And print '================================\n'
    And print '\n'


#
# CREATE: Create third-party
#

    * def nameVarTARGET =       'PUPD-3P-10-SUCC'
    * def nameTARGET =          nameVarTARGET +'-'+ nowMs05

    * def requestBody_createThirdParty1 =
      """
          {
            "referenceNo": "#(''+ nowMs05)",
            "name": "#(nameVarTARGET +'-'+ nowMs05)",
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
                "1234567890"
              ],
              "phoneNumber": [
                "1234567890"
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

    * def createThirdPartyResult1 = call read( "./call/createThirdParty.feature" ) { "requestBody_createThirdParty": '#(requestBody_createThirdParty1)' }
    * def thirdPartyId05 =           createThirdPartyResult1.response.data.id
#    * def thirdPartyIds1 =         get createThirdPartyResult1.response.data.id


    * def thirdPartyIds1Arr =       call createThirdPartyIdsArrFn [ '#(thirdPartyId05)' ]

    And print '\n'
    And print '================================'
    And print '******** thirdPartyId05     = '+ thirdPartyId05
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
          return ( dataElem.status=='NEW' && dataElem.name==(nameVarTARGET +'-'+ nowMs05) );
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


#    * def description1 =        retrieveThirdPartyByIdResult1[0].response.data.description
#
#    * def customField_Field1 = $retrieveThirdPartyByIdResult1[0].response.data.customFields[ ?(@.name=='Field1') ]
#
#    And print '\n'
#    And print '======== VALIDATE ================================'
#    And print 'TEST     description :    VALUE ="'+ description1 +'"'
#    And print 'VALIDATE description :    MATCH ='+ ( description1 == 'This is supplier description' )
#    And print ''
#    And print 'TEST     Field1      :    VALUE ="'+ customField_Field1[0].value +'"'
#    And print 'VALIDATE Field1      :    MATCH ='+ ( customField_Field1[0].value == null )
#    And print '==================================================\n'
#    And print '\n'
#
#    And match description1 ==                'This is supplier description'
#    And match customField_Field1[0].value == null

################################################################################



    * def nowMs06 = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 01) UPDATE THIRD-PARTY SEGMENTATION SUCCESS - PARTUPDATE'
    And print '******** nowMs06 = '+ nowMs06
    And print '================================\n'
    And print '\n'


#
# CREATE: Create third-party
#

    * def nameVarTARGET =       'PUPD-3P-10-SUCC'
    * def nameTARGET =          nameVarTARGET +'-'+ nowMs06

    * def requestBody_createThirdParty1 =
      """
          {
            "referenceNo": "#(''+ nowMs06)",
            "name": "#(nameVarTARGET +'-'+ nowMs06)",
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
                "1234567890"
              ],
              "phoneNumber": [
                "1234567890"
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

    * def createThirdPartyResult1 = call read( "./call/createThirdParty.feature" ) { "requestBody_createThirdParty": '#(requestBody_createThirdParty1)' }
    * def thirdPartyId06 =           createThirdPartyResult1.response.data.id
#    * def thirdPartyIds1 =         get createThirdPartyResult1.response.data.id


    * def thirdPartyIds1Arr =       call createThirdPartyIdsArrFn [ '#(thirdPartyId06)' ]

    And print '\n'
    And print '================================'
    And print '******** thirdPartyId06     = '+ thirdPartyId06
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
          return ( dataElem.status=='NEW' && dataElem.name==(nameVarTARGET +'-'+ nowMs06) );
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


#    * def description1 =        retrieveThirdPartyByIdResult1[0].response.data.description
#
#    * def customField_Field1 = $retrieveThirdPartyByIdResult1[0].response.data.customFields[ ?(@.name=='Field1') ]
#
#    And print '\n'
#    And print '======== VALIDATE ================================'
#    And print 'TEST     description :    VALUE ="'+ description1 +'"'
#    And print 'VALIDATE description :    MATCH ='+ ( description1 == 'This is supplier description' )
#    And print ''
#    And print 'TEST     Field1      :    VALUE ="'+ customField_Field1[0].value +'"'
#    And print 'VALIDATE Field1      :    MATCH ='+ ( customField_Field1[0].value == null )
#    And print '==================================================\n'
#    And print '\n'
#
#    And match description1 ==                'This is supplier description'
#    And match customField_Field1[0].value == null

################################################################################



    * def nowMs07 = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 01) UPDATE THIRD-PARTY SEGMENTATION SUCCESS - PARTUPDATE'
    And print '******** nowMs07 = '+ nowMs07
    And print '================================\n'
    And print '\n'


#
# CREATE: Create third-party
#

    * def nameVarTARGET =       'PUPD-3P-10-SUCC'
    * def nameTARGET =          nameVarTARGET +'-'+ nowMs07

    * def requestBody_createThirdParty1 =
      """
          {
            "referenceNo": "#(''+ nowMs07)",
            "name": "#(nameVarTARGET +'-'+ nowMs07)",
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
                "1234567890"
              ],
              "phoneNumber": [
                "1234567890"
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

    * def createThirdPartyResult1 = call read( "./call/createThirdParty.feature" ) { "requestBody_createThirdParty": '#(requestBody_createThirdParty1)' }
    * def thirdPartyId07 =           createThirdPartyResult1.response.data.id
#    * def thirdPartyIds1 =         get createThirdPartyResult1.response.data.id


    * def thirdPartyIds1Arr =       call createThirdPartyIdsArrFn [ '#(thirdPartyId07)' ]

    And print '\n'
    And print '================================'
    And print '******** thirdPartyId07     = '+ thirdPartyId07
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
          return ( dataElem.status=='NEW' && dataElem.name==(nameVarTARGET +'-'+ nowMs07) );
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


#    * def description1 =        retrieveThirdPartyByIdResult1[0].response.data.description
#
#    * def customField_Field1 = $retrieveThirdPartyByIdResult1[0].response.data.customFields[ ?(@.name=='Field1') ]
#
#    And print '\n'
#    And print '======== VALIDATE ================================'
#    And print 'TEST     description :    VALUE ="'+ description1 +'"'
#    And print 'VALIDATE description :    MATCH ='+ ( description1 == 'This is supplier description' )
#    And print ''
#    And print 'TEST     Field1      :    VALUE ="'+ customField_Field1[0].value +'"'
#    And print 'VALIDATE Field1      :    MATCH ='+ ( customField_Field1[0].value == null )
#    And print '==================================================\n'
#    And print '\n'
#
#    And match description1 ==                'This is supplier description'
#    And match customField_Field1[0].value == null

################################################################################



    * def nowMs08 = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 01) UPDATE THIRD-PARTY SEGMENTATION SUCCESS - PARTUPDATE'
    And print '******** nowMs08 = '+ nowMs08
    And print '================================\n'
    And print '\n'


#
# CREATE: Create third-party
#

    * def nameVarTARGET =       'PUPD-3P-10-SUCC'
    * def nameTARGET =          nameVarTARGET +'-'+ nowMs08

    * def requestBody_createThirdParty1 =
      """
          {
            "referenceNo": "#(''+ nowMs08)",
            "name": "#(nameVarTARGET +'-'+ nowMs08)",
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
                "1234567890"
              ],
              "phoneNumber": [
                "1234567890"
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

    * def createThirdPartyResult1 = call read( "./call/createThirdParty.feature" ) { "requestBody_createThirdParty": '#(requestBody_createThirdParty1)' }
    * def thirdPartyId08 =           createThirdPartyResult1.response.data.id
#    * def thirdPartyIds1 =         get createThirdPartyResult1.response.data.id


    * def thirdPartyIds1Arr =       call createThirdPartyIdsArrFn [ '#(thirdPartyId08)' ]

    And print '\n'
    And print '================================'
    And print '******** thirdPartyId08     = '+ thirdPartyId08
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
          return ( dataElem.status=='NEW' && dataElem.name==(nameVarTARGET +'-'+ nowMs08) );
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


#    * def description1 =        retrieveThirdPartyByIdResult1[0].response.data.description
#
#    * def customField_Field1 = $retrieveThirdPartyByIdResult1[0].response.data.customFields[ ?(@.name=='Field1') ]
#
#    And print '\n'
#    And print '======== VALIDATE ================================'
#    And print 'TEST     description :    VALUE ="'+ description1 +'"'
#    And print 'VALIDATE description :    MATCH ='+ ( description1 == 'This is supplier description' )
#    And print ''
#    And print 'TEST     Field1      :    VALUE ="'+ customField_Field1[0].value +'"'
#    And print 'VALIDATE Field1      :    MATCH ='+ ( customField_Field1[0].value == null )
#    And print '==================================================\n'
#    And print '\n'
#
#    And match description1 ==                'This is supplier description'
#    And match customField_Field1[0].value == null

################################################################################



    * def nowMs09 = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 01) UPDATE THIRD-PARTY SEGMENTATION SUCCESS - PARTUPDATE'
    And print '******** nowMs09 = '+ nowMs09
    And print '================================\n'
    And print '\n'


#
# CREATE: Create third-party
#

    * def nameVarTARGET =       'PUPD-3P-10-SUCC'
    * def nameTARGET =          nameVarTARGET +'-'+ nowMs09

    * def requestBody_createThirdParty1 =
      """
          {
            "referenceNo": "#(''+ nowMs09)",
            "name": "#(nameVarTARGET +'-'+ nowMs09)",
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
                "1234567890"
              ],
              "phoneNumber": [
                "1234567890"
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

    * def createThirdPartyResult1 = call read( "./call/createThirdParty.feature" ) { "requestBody_createThirdParty": '#(requestBody_createThirdParty1)' }
    * def thirdPartyId09 =           createThirdPartyResult1.response.data.id
#    * def thirdPartyIds1 =         get createThirdPartyResult1.response.data.id


    * def thirdPartyIds1Arr =       call createThirdPartyIdsArrFn [ '#(thirdPartyId09)' ]

    And print '\n'
    And print '================================'
    And print '******** thirdPartyId09     = '+ thirdPartyId09
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
          return ( dataElem.status=='NEW' && dataElem.name==(nameVarTARGET +'-'+ nowMs09) );
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


#    * def description1 =        retrieveThirdPartyByIdResult1[0].response.data.description
#
#    * def customField_Field1 = $retrieveThirdPartyByIdResult1[0].response.data.customFields[ ?(@.name=='Field1') ]
#
#    And print '\n'
#    And print '======== VALIDATE ================================'
#    And print 'TEST     description :    VALUE ="'+ description1 +'"'
#    And print 'VALIDATE description :    MATCH ='+ ( description1 == 'This is supplier description' )
#    And print ''
#    And print 'TEST     Field1      :    VALUE ="'+ customField_Field1[0].value +'"'
#    And print 'VALIDATE Field1      :    MATCH ='+ ( customField_Field1[0].value == null )
#    And print '==================================================\n'
#    And print '\n'
#
#    And match description1 ==                'This is supplier description'
#    And match customField_Field1[0].value == null

################################################################################



    * def nowMs10 = call fnGetNowMs

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: SCENARIO 01) UPDATE THIRD-PARTY SEGMENTATION SUCCESS - PARTUPDATE'
    And print '******** nowMs10 = '+ nowMs10
    And print '================================\n'
    And print '\n'


#
# CREATE: Create third-party
#

    * def nameVarTARGET =       'PUPD-3P-10-SUCC'
    * def nameTARGET =          nameVarTARGET +'-'+ nowMs10

    * def requestBody_createThirdParty1 =
      """
          {
            "referenceNo": "#(''+ nowMs10)",
            "name": "#(nameVarTARGET +'-'+ nowMs10)",
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
                "1234567890"
              ],
              "phoneNumber": [
                "1234567890"
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

    * def createThirdPartyResult1 = call read( "./call/createThirdParty.feature" ) { "requestBody_createThirdParty": '#(requestBody_createThirdParty1)' }
    * def thirdPartyId10 =           createThirdPartyResult1.response.data.id
#    * def thirdPartyIds1 =         get createThirdPartyResult1.response.data.id


    * def thirdPartyIds1Arr =       call createThirdPartyIdsArrFn [ '#(thirdPartyId10)' ]

    And print '\n'
    And print '================================'
    And print '******** thirdPartyId10     = '+ thirdPartyId10
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
          return ( dataElem.status=='NEW' && dataElem.name==(nameVarTARGET +'-'+ nowMs10) );
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


#    * def description1 =        retrieveThirdPartyByIdResult1[0].response.data.description
#
#    * def customField_Field1 = $retrieveThirdPartyByIdResult1[0].response.data.customFields[ ?(@.name=='Field1') ]
#
#    And print '\n'
#    And print '======== VALIDATE ================================'
#    And print 'TEST     description :    VALUE ="'+ description1 +'"'
#    And print 'VALIDATE description :    MATCH ='+ ( description1 == 'This is supplier description' )
#    And print ''
#    And print 'TEST     Field1      :    VALUE ="'+ customField_Field1[0].value +'"'
#    And print 'VALIDATE Field1      :    MATCH ='+ ( customField_Field1[0].value == null )
#    And print '==================================================\n'
#    And print '\n'
#
#    And match description1 ==                'This is supplier description'
#    And match customField_Field1[0].value == null

################################################################################



























# ================================================================================
# ================================================================================
#
# SELF-SERVICE PARTUPDATE third-party: by BULK-UPLOAD
#

#   * def csvRows00 = "Action Type|Third-party ID          |Reference Number|Group ID|Third-party Name           |Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party   |Division  |Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact      |Commodity Type|Bank Name  |Bank Address Line|Account No.|Bank City|Branch Name|Bank Country |Address Line|State/Province|City  |Region  |Zip/Postal Code|Country      |Phone Number|Website       |Fax|Email Address   |Description|Other Names Old Name|Other Name  |Other Name Type    |Other Name Country|Custom Fields Name         |Custom Fields Value     \n"
    * def csvRows00 = "Action Type|Third-party ID          |Reference Number|Group ID|Third-party Name           |Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party               |Division  |Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact      |Commodity Type|Bank Name  |Bank Address Line|Account No.|Bank City|Branch Name|Bank Country |Address Line|State/Province|City  |Region  |Zip/Postal Code|Country      |Phone Number|Website       |Fax|Email Address   |Description|Other Names Old Name|Other Name  |Other Name Type    |Other Name Country|Custom Fields Name         |Custom Fields Value                                 |Case System ID|Other Name Case System ID|Notify List|Screening Groups|Other Name Screening Groups\n"

# Success: ADD thirdParty
#   * def csvRows01 = "FULLUPDATE |"+    thirdPartyId    +"|"+    nowMs   +"|1       |FULLUPDATE - "+ nowMs +"   |CORP        |USD     |5K-10K           |AHI          |PRS              |02/22/1987            |10M    |11/02/2008      |SOE        |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|A3P           |MoneyBank01|11 Finance Avenue|11111111   |Reno     |MB Reno Br.|United States|11 Main Ave.|Ontario       |Ottawa|Americas|ZIP90210       |Canada       |+180011111111|www.test01.com|111|test01@test.com |Desc abc123|                    |Acme Inc.   |Local Language Name|France            |Field1                     |FULLUPDATE TEXT         \n"

    * def csvRows01 = "PARTUPDATE |"+    thirdPartyId01   +"|               |1       |                           |CORP        |AUD     |5K-10K           |AHI          |PRS              |02/22/1987            |10M    |11/02/2008      |SOE        |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|              |MoneyBank01|11 Finance Avenue|11111111   |Reno     |MB Reno Br.|United States|11 Main Ave.|Ontario       |Ottawa|Americas|ZIP90210       |Canada       |180011111111|www.test01.com|111|test01@test.com |Desc abc111|                    |Acme01 Inc. |Local Language Name|                  |Field1                      |PARTUPDATE ========== 'Field1'                    |              |                         |           |                |\n"
    * def csvRows02 = "PARTUPDATE |"+    thirdPartyId02   +"|               |2       |                           |CORP        |AUD     |5K-10K           |AHI          |PRS              |02/22/1987            |10M    |11/02/2008      |SOE        |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|              |MoneyBank02|22 Finance Avenue|11111111   |Reno     |MB Reno Br.|United States|11 Main Ave.|Ontario       |Ottawa|Americas|ZIP90210       |Canada       |180022222222|www.test01.com|222|test02@test.com |Desc abc222|                    |Acme02 Inc. |Local Language Name|                  |Edit custom field           |PARTUPDATE ========== 'Edit custom field'         |              |                         |           |                |\n"
    * def csvRows03 = "PARTUPDATE |"+    thirdPartyId03   +"|               |3       |                           |CORP        |AUD     |5K-10K           |AHI          |PRS              |02/22/1987            |10M    |11/02/2008      |SOE        |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|              |MoneyBank03|33 Finance Avenue|11111111   |Reno     |MB Reno Br.|United States|11 Main Ave.|Ontario       |Ottawa|Americas|ZIP90210       |Canada       |180033333333|www.test01.com|333|test03@test.com |Desc abc333|                    |Acme03 Inc. |Local Language Name|                  |Custom 2                    |PARTUPDATE ========== 'Custom 2'                  |              |                         |           |                |\n"
    * def csvRows04 = "PARTUPDATE |"+    thirdPartyId04   +"|               |4       |                           |CORP        |AUD     |5K-10K           |AHI          |PRS              |02/22/1987            |10M    |11/02/2008      |SOE        |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|              |MoneyBank04|44 Finance Avenue|11111111   |Reno     |MB Reno Br.|United States|11 Main Ave.|Ontario       |Ottawa|Americas|ZIP90210       |Canada       |180044444444|www.test01.com|444|test04@test.com |Desc abc444|                    |Acme04 Inc. |Local Language Name|                  |TESTING                     |PARTUPDATE ========== 'TESTING'                   |              |                         |           |                |\n"
    * def csvRows05 = "PARTUPDATE |"+    thirdPartyId05   +"|               |5       |                           |CORP        |AUD     |5K-10K           |AHI          |PRS              |02/22/1987            |10M    |11/02/2008      |SOE        |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|              |MoneyBank05|55 Finance Avenue|11111111   |Reno     |MB Reno Br.|United States|11 Main Ave.|Ontario       |Ottawa|Americas|ZIP90210       |Canada       |180055555555|www.test01.com|555|test05@test.com |Desc abc555|                    |Acme05 Inc. |Local Language Name|                  |Custom1                     |PARTUPDATE ========== 'Custom1'                   |              |                         |           |                |\n"
    * def csvRows06 = "PARTUPDATE |"+    thirdPartyId06   +"|               |6       |                           |CORP        |AUD     |5K-10K           |AHI          |PRS              |02/22/1987            |10M    |11/02/2008      |SOE        |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|              |           |                 |           |         |           |             |11 Main Ave.|Ontario       |Ottawa|Americas|ZIP90210       |Canada       |            |              |   |                |           |                    |            |                   |                  |Area                        |PARTUPDATE ========== 'Area'                      |              |                         |           |                |\n"
    * def csvRows07 = "PARTUPDATE |"+    thirdPartyId07   +"|               |7       |                           |CORP        |AUD     |5K-10K           |AHI          |PRS              |02/22/1987            |10M    |11/02/2008      |SOE        |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|              |           |                 |           |         |           |             |11 Main Ave.|Ontario       |Ottawa|Americas|ZIP90210       |Canada       |            |              |   |                |           |                    |            |                   |                  |Number field                |369369                                            |              |                         |           |                |\n"
    * def csvRows08 = "PARTUPDATE |"+    thirdPartyId08   +"|               |8       |                           |CORP        |AUD     |5K-10K           |AHI          |PRS              |02/22/1987            |10M    |11/02/2008      |SOE        |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|              |           |                 |           |         |           |             |11 Main Ave.|Ontario       |Ottawa|Americas|ZIP90210       |Canada       |            |              |   |                |           |                    |            |                   |                  |Multiselect                 |PARTUPDATE ========== 'Multiselect'               |              |                         |           |                |\n"
    * def csvRows09 = "PARTUPDATE |"+    thirdPartyId09   +"|               |9       |                           |CORP        |AUD     |5K-10K           |AHI          |PRS              |02/22/1987            |10M    |11/02/2008      |SOE        |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|              |           |                 |           |         |           |             |11 Main Ave.|Ontario       |Ottawa|Americas|ZIP90210       |Canada       |            |              |   |                |           |                    |            |                   |                  |Auto Custom Field updated   |PARTUPDATE ========== 'Auto Custom Field updated' |              |                         |           |                |\n"
    * def csvRows10 = "PARTUPDATE |"+    thirdPartyId10   +"|               |A       |                           |CORP        |AUD     |5K-10K           |AHI          |PRS              |02/22/1987            |10M    |11/02/2008      |SOE        |rddcentre.admin.np@refinitiv.com|MyDivision|Default       |OTS           |DIST_M_SRC     |OTS             |MULTI        |LITTLE_VIS             |COMMODITIZED_PRODUCT|              |           |                 |           |         |           |             |11 Main Ave.|Ontario       |Ottawa|Americas|ZIP90210       |Canada       |            |              |   |                |           |                    |            |                   |                  |Number 1                    |246246                                            |              |                         |           |                |\n"

#    * def csvRowsT = csvRows00 + csvRows01 + csvRows02 + csvRows03 + csvRows04 + csvRows05 + csvRows06 + csvRows07 + csvRows08 + csvRows09 + csvRows10
#    * def csvRowsT = csvRows00 + csvRows01
#    * def csvRowsT = csvRows00 + csvRows01 + csvRows02
#    * def csvRowsT = csvRows00 + csvRows01 + csvRows02 + csvRows03
#    * def csvRowsT = csvRows00 + csvRows01 + csvRows02 + csvRows03 + csvRows04
#    * def csvRowsT = csvRows00 + csvRows01 + csvRows02 + csvRows03 + csvRows04 + csvRows05
#    * def csvRowsT = csvRows00 + csvRows01 + csvRows02 + csvRows03 + csvRows04 + csvRows05 + csvRows06
#    * def csvRowsT = csvRows00 + csvRows01 + csvRows02 + csvRows03 + csvRows04 + csvRows05 + csvRows06 + csvRows07
#    * def csvRowsT = csvRows00 + csvRows01 + csvRows02 + csvRows03 + csvRows04 + csvRows05 + csvRows06 + csvRows07 + csvRows08
#    * def csvRowsT = csvRows00 + csvRows01 + csvRows02 + csvRows03 + csvRows04 + csvRows05 + csvRows06 + csvRows07 + csvRows08 + csvRows09
    * def csvRowsT = csvRows00 + csvRows01 + csvRows02 + csvRows03 + csvRows04 + csvRows05 + csvRows06 + csvRows07 + csvRows08 + csvRows09 + csvRows10

#   * def csvRowsA = "Action Type|Third-party ID|Reference Number|Group ID|Third-party Name|Company Type|Currency|Organization Size|Industry Type|Business Category|Date of Incorporation|Revenue|Liquidation Date|Affiliation|Responsible Party|Division|Workflow Group|Spend Category|Sourcing Method|Design Agreement|Sourcing Type|Relationship Visibility|Product Impact|Commodity Type|Bank Name|Bank Address Line|Account No.|Bank City|Branch Name|Bank Country|Address Line|State/Province|City|Region|Zip/Postal Code|Country|Phone Number|Website|Fax|Email Address|Description|Other Names Old Name|Other Name|Other Name Type|Other Name Country|Custom Fields Name|Custom Fields Value\nFULLUPDATE||qwerty1|1|FULLUPDATE - "+ nowMs +"||||||||||rddcentre.admin.np@refinitiv.com|MyDivision|Default|||||||||||||||||||Philippines|||||||||||"

#   * def writeToFileResult = writeToFile( "./src/test/resources/features/api/public_thirdparty/ThirdPartyBulkUpdate/ThirdParty_Add_Update_Delete_FULLUPDATE.csv", csvRowsT )

# PAUSE to allow for server processing of file attachment
    * pauseExecution( 1000 )


    * def createSelfServiceBulkThirdParty2 = call read( "./call/createSelfServiceBulkThirdParty.feature" )   { "csvRowsT": "#(csvRowsT)", "processType": "THIRD_PARTY_ADD_EDIT_DELETE" }

#    And print 'createSelfServiceBulkThirdParty2 = \n', createSelfServiceBulkThirdParty2

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
                             "numberOfRecords":     10,
                             "recordProcessed":     10,
                             "recordWithErrors":    0,
                             "entityType":          "##string",
                             "entityId":            "##string",
                             "childReferenceId":    "##string",
                             "triggeredBy":         "##string",
                             "processType":         "THIRD_PARTY_ADD_EDIT_DELETE"
                         }
            }
          """

    * def validateSuccess2 = ( retrieveSelfServiceProcess2_response.data.recordProcessed==10 && retrieveSelfServiceProcess2_response.data.recordWithErrors==0 )

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY: UPLOAD CSV FILE - THIRD_PARTY_ADD_EDIT_DELETE - PARTUPDATE'
    And print '******** PROCESS ID       = '+ processId2
    And print '******** STATUS           = '+ status2
    And print '******** VALIDATE Success = '+ validateSuccess2
    And print '================================\n'
    And print '\n'

    * match validateSuccess2 == true


#
# VALIDATE: RETRIEVE TARGET third-party by id
#

#    * def retrieveResult =       call read( "./call/retrieveThirdPartyById.feature" )   { "thirdPartyId": "#(thirdPartyIdsTODAYTARGET[0])" }
    * def retrieveThirdPartyByIdResult20 =  call read( "./call/retrieveThirdPartyById.feature" )   { 'thirdPartyId': '#(thirdPartyId01)' }
#    And print '######## retrieveThirdPartyByIdResult2LENGTH = ',   retrieveThirdPartyByIdResult2.length
#    And print '###################################################################################'
#    And print '######## retrieveThirdPartyByIdResult20       = \n', retrieveThirdPartyByIdResult20
#    And print '###################################################################################'

    * def customFields02Arr =     $retrieveThirdPartyByIdResult20.response.data.customFields[ ?(@.name=='Field1') ]
    * def customFields02 =        customFields02Arr[0]
    * def customFields0name2 =    customFields02.name
    * def customFields0value2 =   customFields02.value

#    And print '\n'
#    And print '=================================================='
#    And print "TEST  thirdPartyId='"+ thirdParty01 +"' :  MATCH ="+ ( customFields0name2=="Field1"                    && customFields0value2=="PARTUPDATE ========== 'Field1'"                    )  +" | customFields0name2='"+ customFields0name2 +"'   customFields0value2='"+ customFields0value2 +"'"
#    And print '==================================================\n'
#    And print '\n'


#
# VALIDATE: RETRIEVE TARGET third-party by id
#
    * def retrieveThirdPartyByIdResult21 =  call read( "./call/retrieveThirdPartyById.feature" )   { 'thirdPartyId': '#(thirdPartyId02)' }

    * def customFields12Arr =     $retrieveThirdPartyByIdResult21.response.data.customFields[ ?(@.name=='Edit custom field') ]
    * def customFields12 =        customFields12Arr[0]
    * def customFields1name2 =    customFields12.name
    * def customFields1value2 =   customFields12.value

#    And print '\n'
#    And print '=================================================='
#    And print "TEST  thirdPartyId='"+ thirdParty02 +"' :  MATCH ="+ ( customFields1name2=="Edit custom field"                    && customFields1value2=="PARTUPDATE ========== 'Edit custom field'"                    )  +" | customFields1name2='"+ customFields1name2 +"'   customFields1value2='"+ customFields1value2 +"'"
#    And print '==================================================\n'
#    And print '\n'



#
# VALIDATE: RETRIEVE TARGET third-party by id
#
    * def retrieveThirdPartyByIdResult22 =  call read( "./call/retrieveThirdPartyById.feature" )   { 'thirdPartyId': '#(thirdPartyId03)' }

    * def customFields22Arr =     $retrieveThirdPartyByIdResult22.response.data.customFields[ ?(@.name=='Custom 2') ]
    * def customFields22 =        customFields22Arr[0]
    * def customFields2name2 =    customFields22.name
    * def customFields2value2 =   customFields22.value

#    And print '\n'
#    And print '=================================================='
#    And print "TEST  thirdPartyId='"+ thirdParty03 +"' :  MATCH ="+ ( customFields2name2=="Custom 2"                    && customFields2value2=="PARTUPDATE ========== 'Custom 2'"                    )  +" | customFields2name2='"+ customFields2name2 +"'   customFields2value2='"+ customFields2value2 +"'"
#    And print '==================================================\n'
#    And print '\n'



#
# VALIDATE: RETRIEVE TARGET third-party by id
#
    * def retrieveThirdPartyByIdResult23 =  call read( "./call/retrieveThirdPartyById.feature" )   { 'thirdPartyId': '#(thirdPartyId04)' }

    * def customFields32Arr =     $retrieveThirdPartyByIdResult23.response.data.customFields[ ?(@.name=='TESTING') ]
    * def customFields32 =        customFields32Arr[0]
    * def customFields3name2 =    customFields32.name
#    * def customFields3value2 =   customFields32.value[0]
    * def customFields3value2 =   customFields32.value

#    And print '\n'
#    And print '=================================================='
#    And print "TEST  thirdPartyId='"+ thirdParty04 +"' :  MATCH ="+ ( customFields3name2=="TESTING"                    && customFields3value2=="PARTUPDATE ========== 'TESTING'"                    )  +" | customFields3name2='"+ customFields3name2 +"'   customFields3value2='"+ customFields3value2 +"'"
#    And print '==================================================\n'
#    And print '\n'

#
# VALIDATE: RETRIEVE TARGET third-party by id
#
    * def retrieveThirdPartyByIdResult24 =  call read( "./call/retrieveThirdPartyById.feature" )   { 'thirdPartyId': '#(thirdPartyId05)' }

    * def customFields42Arr =     $retrieveThirdPartyByIdResult24.response.data.customFields[ ?(@.name=='Custom1') ]
    * def customFields42 =        customFields42Arr[0]
    * def customFields4name2 =    customFields42.name
    * def customFields4value2 =   customFields42.value

#    And print '\n'
#    And print '=================================================='
#    And print "TEST  thirdPartyId='"+ thirdParty05 +"' :  MATCH ="+ ( customFields4name2=="Custom1"                    && customFields4value2=="PARTUPDATE ========== 'Custom1'"                    )  +" | customFields4name2='"+ customFields4name2 +"'   customFields4value2='"+ customFields4value2 +"'"
#    And print '==================================================\n'
#    And print '\n'

#
# VALIDATE: RETRIEVE TARGET third-party by id
#
    * def retrieveThirdPartyByIdResult25 =  call read( "./call/retrieveThirdPartyById.feature" )   { 'thirdPartyId': '#(thirdPartyId06)' }

    * def customFields52Arr =     $retrieveThirdPartyByIdResult25.response.data.customFields[ ?(@.name=='Area') ]
    * def customFields52 =        customFields52Arr[0]
    * def customFields5name2 =    customFields52.name
#    * def customFields5value2 =   customFields52.value[0]
    * def customFields5value2 =   customFields52.value

#    And print '\n'
#    And print '=================================================='
#    And print "TEST  thirdPartyId='"+ thirdParty06 +"' :  MATCH ="+ ( customFields5name2=="Area"                    && customFields5value2=="PARTUPDATE ========== 'Area'"                    )  +" | customFields5name2='"+ customFields5name2 +"'   customFields5value2='"+ customFields5value2 +"'"
#    And print '==================================================\n'
#    And print '\n'

#
# VALIDATE: RETRIEVE TARGET third-party by id
#
    * def retrieveThirdPartyByIdResult26 =  call read( "./call/retrieveThirdPartyById.feature" )   { 'thirdPartyId': '#(thirdPartyId07)' }

    * def customFields62Arr =     $retrieveThirdPartyByIdResult26.response.data.customFields[ ?(@.name=='Number field') ]
    * def customFields62 =        customFields62Arr[0]
    * def customFields6name2 =    customFields62.name
    * def customFields6value2 =   customFields62.value

#    And print '\n'
#    And print '=================================================='
#    And print "TEST  thirdPartyId='"+ thirdParty07 +"' :  MATCH ="+ ( customFields6name2=="Number field"                    && customFields6value2=="369369"                    )  +" | customFields6name2='"+ customFields6name2 +"'   customFields6value2='"+ customFields6value2 +"'"
#    And print '==================================================\n'
#    And print '\n'

#
# VALIDATE: RETRIEVE TARGET third-party by id
#
    * def retrieveThirdPartyByIdResult27 =  call read( "./call/retrieveThirdPartyById.feature" )   { 'thirdPartyId': '#(thirdPartyId08)' }

    * def customFields72Arr =     $retrieveThirdPartyByIdResult27.response.data.customFields[ ?(@.name=='Multiselect') ]
    * def customFields72 =        customFields72Arr[0]
    * def customFields7name2 =    customFields72.name
    * def customFields7value2 =   customFields72.value[0]

#    And print '\n'
#    And print '=================================================='
#    And print "TEST  thirdPartyId='"+ thirdParty08 +"' :  MATCH ="+ ( customFields7name2=="Multiselect"                    && customFields7value2=="PARTUPDATE ========== 'Multiselect'"                    )  +" | customFields7name2='"+ customFields7name2 +"'   customFields7value2='"+ customFields7value2 +"'"
#    And print '==================================================\n'
#    And print '\n'

#
# VALIDATE: RETRIEVE TARGET third-party by id
#
    * def retrieveThirdPartyByIdResult28 =  call read( "./call/retrieveThirdPartyById.feature" )   { 'thirdPartyId': '#(thirdPartyId09)' }

    * def customFields82Arr =     $retrieveThirdPartyByIdResult28.response.data.customFields[ ?(@.name=='Auto Custom Field updated') ]
    * def customFields82 =        customFields82Arr[0]
    * def customFields8name2 =    customFields82.name
    * def customFields8value2 =   customFields82.value

#    And print '\n'
#    And print '=================================================='
#    And print "TEST  thirdPartyId='"+ thirdParty09 +"' :  MATCH ="+ ( customFields8name2=="Auto Custom Field updated"                    && customFields8value2=="PARTUPDATE ========== 'Auto Custom Field updated'"                    )  +" | customFields8name2='"+ customFields8name2 +"'   customFields8value2='"+ customFields8value2 +"'"
#    And print '==================================================\n'
#    And print '\n'

#
# VALIDATE: RETRIEVE TARGET third-party by id
#
    * def retrieveThirdPartyByIdResult29 =  call read( "./call/retrieveThirdPartyById.feature" )   { 'thirdPartyId': '#(thirdPartyId10)' }

    * def customFields92Arr =     $retrieveThirdPartyByIdResult29.response.data.customFields[ ?(@.name=='Number 1') ]
    * def customFields92 =        customFields92Arr[0]
    * def customFields9name2 =    customFields92.name
    * def customFields9value2 =   customFields92.value

#    And print '\n'
#    And print '=================================================='
#    And print "TEST  thirdPartyId='"+ thirdParty10 +"' :  MATCH ="+ ( customFields9name2=="Number 1"                    && customFields9value2=="246246"                    )  +" | customFields9name2='"+ customFields9name2 +"'   customFields9value2='"+ customFields9value2 +"'"
#    And print '==================================================\n'
#    And print '\n'

#    * def customField_Field1 =  $retrieveThirdPartyByIdResult2.response.data.customFields[ ?(@.name=='Field1') ]
#
#
##    And print 'retrieveThirdPartyByIdResult0 = \n',          retrieveThirdPartyByIdResult0
##    And print 'retrieveThirdPartyByIdResult0_count = ',      retrieveThirdPartyByIdResult0.length
##    And print 'retrieveThirdPartyByIdResult0_response = \n', retrieveThirdPartyByIdResult0[0].response
#
##    * def otherNamesCount =      retrieveResult[0].response.data.otherNames.length
##
##    And match otherNamesCount == VALIDATECOUNT

    And print '\n'
    And print '======== VALIDATE ================================'
    And print "TEST  thirdPartyId='"+ thirdPartyId01 +"' :  MATCH="+ ( customFields0name2=="Field1"                    && customFields0value2=="PARTUPDATE ========== 'Field1'"                    )  +" | customFields0name2='"+ customFields0name2 +"'   customFields0value2='"+ customFields0value2 +"'"
    And print "TEST  thirdPartyId='"+ thirdPartyId02 +"' :  MATCH="+ ( customFields1name2=="Edit custom field"         && customFields1value2=="PARTUPDATE ========== 'Edit custom field'"         )  +" | customFields1name2='"+ customFields1name2 +"'   customFields1value2='"+ customFields1value2 +"'"
    And print "TEST  thirdPartyId='"+ thirdPartyId03 +"' :  MATCH="+ ( customFields2name2=="Custom 2"                  && customFields2value2=="PARTUPDATE ========== 'Custom 2'"                  )  +" | customFields2name2='"+ customFields2name2 +"'   customFields2value2='"+ customFields2value2 +"'"
    And print "TEST  thirdPartyId='"+ thirdPartyId04 +"' :  MATCH="+ ( customFields3name2=="TESTING"                   && customFields3value2=="PARTUPDATE ========== 'TESTING'"                   )  +" | customFields3name2='"+ customFields3name2 +"'   customFields3value2='"+ customFields3value2 +"'"
    And print "TEST  thirdPartyId='"+ thirdPartyId05 +"' :  MATCH="+ ( customFields4name2=="Custom1"                   && customFields4value2=="PARTUPDATE ========== 'Custom1'"                   )  +" | customFields4name2='"+ customFields4name2 +"'   customFields4value2='"+ customFields4value2 +"'"
    And print "TEST  thirdPartyId='"+ thirdPartyId06 +"' :  MATCH="+ ( customFields5name2=="Area"                      && customFields5value2=="PARTUPDATE ========== 'Area'"                      )  +" | customFields5name2='"+ customFields5name2 +"'   customFields5value2='"+ customFields5value2 +"'"
    And print "TEST  thirdPartyId='"+ thirdPartyId07 +"' :  MATCH="+ ( customFields6name2=="Number field"              && customFields6value2=="369369"                                            )  +" | customFields6name2='"+ customFields6name2 +"'   customFields6value2='"+ customFields6value2 +"'"
    And print "TEST  thirdPartyId='"+ thirdPartyId08 +"' :  MATCH="+ ( customFields7name2=="Multiselect"               && customFields7value2=="PARTUPDATE ========== 'Multiselect'"               )  +" | customFields7name2='"+ customFields7name2 +"'   customFields7value2='"+ customFields7value2 +"'"
    And print "TEST  thirdPartyId='"+ thirdPartyId09 +"' :  MATCH="+ ( customFields8name2=="Auto Custom Field updated" && customFields8value2=="PARTUPDATE ========== 'Auto Custom Field updated'" )  +" | customFields8name2='"+ customFields8name2 +"'   customFields8value2='"+ customFields8value2 +"'"
    And print "TEST  thirdPartyId='"+ thirdPartyId10 +"' :  MATCH="+ ( customFields9name2=="Number 1"                  && customFields9value2=="246246"                                            )  +" | customFields9name2='"+ customFields9name2 +"'   customFields9value2='"+ customFields9value2 +"'"
    And print '==================================================\n'
    And print '\n'

    * def customFields0Success = ( customFields0name2=="Field1"                       && customFields0value2=="PARTUPDATE ========== 'Field1'"                    )
    * def customFields1Success = ( customFields1name2=="Edit custom field"            && customFields1value2=="PARTUPDATE ========== 'Edit custom field'"         )
    * def customFields2Success = ( customFields2name2=="Custom 2"                     && customFields2value2=="PARTUPDATE ========== 'Custom 2'"                  )
    * def customFields3Success = ( customFields3name2=="TESTING"                      && customFields3value2=="PARTUPDATE ========== 'TESTING'"                   )
    * def customFields4Success = ( customFields4name2=="Custom1"                      && customFields4value2=="PARTUPDATE ========== 'Custom1'"                   )
    * def customFields5Success = ( customFields5name2=="Area"                         && customFields5value2=="PARTUPDATE ========== 'Area'"                      )
    * def customFields6Success = ( customFields6name2=="Number field"                 && customFields6value2=="369369"                                            )
    * def customFields7Success = ( customFields7name2=="Multiselect"                  && customFields7value2=="PARTUPDATE ========== 'Multiselect'"               )
    * def customFields8Success = ( customFields8name2=="Auto Custom Field updated"    && customFields8value2=="PARTUPDATE ========== 'Auto Custom Field updated'" )
    * def customFields9Success = ( customFields9name2=="Number 1"                     && customFields9value2=="246246"                                            )

    And match customFields0Success == true
    And match customFields1Success == true
    And match customFields2Success == true
    And match customFields3Success == true
    And match customFields4Success == true
    And match customFields5Success == true
    And match customFields6Success == true
    And match customFields7Success == true
    And match customFields8Success == true
    And match customFields9Success == true

#    And match description2 ==                'Desc abc111'
#    And match customField_Field1[0].value == 'PARTUPDATE TEXT'
# ================================================================================
# ================================================================================












##
## DELETE: cleanup TARGET third-party by id
##
#
##    * def deleteThirdPartyResult1 = call read( "./call/deleteThirdParty.feature" ) thirdPartyIdsTODAYNEWArr
    * def deleteThirdPartyResult1 = call read( "./call/deleteThirdParty.feature" ) thirdPartyIdsTODAYNAMEArr
##    * def deleteThirdPartyResult1 = cal                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                l read( "./call/deleteThirdParty.feature" ) thirdPartyIdsTODAYTARGETArr



    And print '\n'
    And print '======== VALIDATE ================================'
    And print "TEST  thirdPartyId='"+ thirdPartyId01 +"' :  MATCH="+ ( customFields0name2=="Field1"                    && customFields0value2=="PARTUPDATE ========== 'Field1'"                    )  +" | customFields0name2='"+ customFields0name2 +"'   customFields0value2='"+ customFields0value2 +"'"
    And print "TEST  thirdPartyId='"+ thirdPartyId02 +"' :  MATCH="+ ( customFields1name2=="Edit custom field"         && customFields1value2=="PARTUPDATE ========== 'Edit custom field'"         )  +" | customFields1name2='"+ customFields1name2 +"'   customFields1value2='"+ customFields1value2 +"'"
    And print "TEST  thirdPartyId='"+ thirdPartyId03 +"' :  MATCH="+ ( customFields2name2=="Custom 2"                  && customFields2value2=="PARTUPDATE ========== 'Custom 2'"                  )  +" | customFields2name2='"+ customFields2name2 +"'   customFields2value2='"+ customFields2value2 +"'"
    And print "TEST  thirdPartyId='"+ thirdPartyId04 +"' :  MATCH="+ ( customFields3name2=="TESTING"                   && customFields3value2=="PARTUPDATE ========== 'TESTING'"                   )  +" | customFields3name2='"+ customFields3name2 +"'   customFields3value2='"+ customFields3value2 +"'"
    And print "TEST  thirdPartyId='"+ thirdPartyId05 +"' :  MATCH="+ ( customFields4name2=="Custom1"                   && customFields4value2=="PARTUPDATE ========== 'Custom1'"                   )  +" | customFields4name2='"+ customFields4name2 +"'   customFields4value2='"+ customFields4value2 +"'"
    And print "TEST  thirdPartyId='"+ thirdPartyId06 +"' :  MATCH="+ ( customFields5name2=="Area"                      && customFields5value2=="PARTUPDATE ========== 'Area'"                      )  +" | customFields5name2='"+ customFields5name2 +"'   customFields5value2='"+ customFields5value2 +"'"
    And print "TEST  thirdPartyId='"+ thirdPartyId07 +"' :  MATCH="+ ( customFields6name2=="Number field"              && customFields6value2=="369369"                                            )  +" | customFields6name2='"+ customFields6name2 +"'   customFields6value2='"+ customFields6value2 +"'"
    And print "TEST  thirdPartyId='"+ thirdPartyId08 +"' :  MATCH="+ ( customFields7name2=="Multiselect"               && customFields7value2=="PARTUPDATE ========== 'Multiselect'"               )  +" | customFields7name2='"+ customFields7name2 +"'   customFields7value2='"+ customFields7value2 +"'"
    And print "TEST  thirdPartyId='"+ thirdPartyId09 +"' :  MATCH="+ ( customFields8name2=="Auto Custom Field updated" && customFields8value2=="PARTUPDATE ========== 'Auto Custom Field updated'" )  +" | customFields8name2='"+ customFields8name2 +"'   customFields8value2='"+ customFields8value2 +"'"
    And print "TEST  thirdPartyId='"+ thirdPartyId10 +"' :  MATCH="+ ( customFields9name2=="Number 1"                  && customFields9value2=="246246"                                            )  +" | customFields9name2='"+ customFields9name2 +"'   customFields9value2='"+ customFields9value2 +"'"
    And print '==================================================\n'
    And print '\n'
