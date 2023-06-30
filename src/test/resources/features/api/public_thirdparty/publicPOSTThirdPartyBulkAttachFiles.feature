@api @public_api @postPublicThirdPartyBulkAttachFiles
Feature: Bulk Attach Files to Third Party



  Background:
#    * def baseTestUrl =        'https://api.qa-sprint2.supplierintegrity.com'
    * def xTenantCode =        tenant
    * def invalidXTenantCode = 'xxx'
    * def eTag =               ''
    * configure retry =        { count: 80, interval: 3000 }



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



#    * def iterateOverAndCollectBySpecifiedValue =
#      """
#        function( iteratingArrayElem, collectingArray, targetValue ) {
#            if ( iteratingArrayElem.status == targetValue ) {
#                karate.append( collectingArray, iteratingArrayElem.filename );
#            }
#        }
#      """


    * configure logPrettyResponse = true




  Scenario: 1) C36570697 Public API - SIConnect Public API V2 - Bulk Upload Supplier Related Files
               - Upload valid file name with valid file size

#
# CREATE third-party
#
    * def requestBody_createThirdParty =
      """
          {
            "referenceNo": null,
            "name": "#('ABC-BULKATTACH '+ nowMs +' Corp')",
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
                              "countryAlerts":          '##[] ##string',
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



#
# Create ZIP FILE: archive 'meta.json' along with zip entry files
#

#    * def jsonContent =
#      """
#        [
#          {
#            'supplierId': '#(thirdPartyId)',
#            'attachments': [
#                'TEST_BMP.bmp',
#                'TEST_CSV.csv',
#                'TEST_DOC.doc',
#                'TEST_DOCX.docx',
#                'TEST_JPEG.jpeg',
#                'TEST_JPG.jpg',
#                'TEST_MSG.msg',
#                'TEST_PDF.pdf',
#                'TEST_PNG.png',
#                'TEST_PPT.ppt',
#                'TEST_PPTX.pptx',
#                'TEST_PSD.psd',
#                'TEST_TIF.tif',
#                'TEST_TIFF.tiff',
#                'TEST_TXT.txt',
#                'TEST_VSD.vsd',
#                'TEST_VSDX.vsdx',
#                'TEST_XLS.xls',
#                'TEST_XLSX.xlsx'
#            ]
#          }
#        ]
#      """
#
#    * def writeToFileResult = writeToFile( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/meta.json", jsonContent )

    * def metaJsonContentArr = null
    * json metaJsonContentArr = ( metaJsonContentArr || [] )

    * def metaJsonContentElem = { 'supplierId' : '#(thirdPartyId)' }
    * json attachments = []
    * if ( ! metaJsonContentElem.attachments ) metaJsonContentElem.attachments = attachments



#    * def archiveToZipFileResult = archiveToZipFile( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_BMP.bmp" )

    * def attachmentsArrElem = 'TEST_BMP.bmp'
    * def archiveToZipFileResult = archiveToZipFile( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

    And print '\n'
    And print '================================'
    And print '******** BULK-ATTACH FILES TO THIRD-PARTY: VALID FILES IN ZIP ARCHIVE'
    And print '******** ZIP FILENAME = '+ archiveToZipFileResult
    And print '================================\n'
    And print '\n'



#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_CSV.csv" )

    * def attachmentsArrElem = 'TEST_CSV.csv'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_DOC.doc" )

    * def attachmentsArrElem = 'TEST_DOC.doc'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_DOCX.docx" )

    * def attachmentsArrElem = 'TEST_DOCX.docx'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_JPEG.jpeg" )

    * def attachmentsArrElem = 'TEST_JPEG.jpeg'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_JPG.jpg" )

    * def attachmentsArrElem = 'TEST_JPG.jpg'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_MSG.msg" )

    * def attachmentsArrElem = 'TEST_MSG.msg'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PDF.pdf" )

    * def attachmentsArrElem = 'TEST_PDF.pdf'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PNG.png" )

    * def attachmentsArrElem = 'TEST_PNG.png'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PPT.ppt" )

    * def attachmentsArrElem = 'TEST_PPT.ppt'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PPTX.pptx" )

    * def attachmentsArrElem = 'TEST_PPTX.pptx'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PSD.psd" )

    * def attachmentsArrElem = 'TEST_PSD.psd'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_TIF.tif" )

    * def attachmentsArrElem = 'TEST_TIF.tif'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_TIFF.tiff" )

    * def attachmentsArrElem = 'TEST_TIFF.tiff'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_TXT.txt" )

    * def attachmentsArrElem = 'TEST_TXT.txt'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_VSD.vsd" )

    * def attachmentsArrElem = 'TEST_VSD.vsd'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_VSDX.vsdx" )

    * def attachmentsArrElem = 'TEST_VSDX.vsdx'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_XLS.xls" )

    * def attachmentsArrElem = 'TEST_XLS.xls'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_XLSX.xlsx" )

    * def attachmentsArrElem = 'TEST_XLSX.xlsx'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )



# Write meta information to 'meta.json' FILE
    * def void = ( metaJsonContentArr.add(metaJsonContentElem) )
    * def writeToFileResult = writeToFile( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/meta.json", metaJsonContentArr )



# Add 'meta.json' file to ZIP FILE
    * def attachmentsArrElem = 'meta.json'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )



#
# ATTACH ZIP FILE to newly-created ThirdParty
#

    Given url postUrl = baseTestUrl
    And path 'thirdparty/bulk-attachments'
#    And multipart file file = { read:'', filename:'file:/c/Users/U0182583/Desktop/_MyFiles/SI/REPO/GITLAB/rutaf-bdd-si/src/test/resources/features/api/public_thirdparty/RMS-126_ForJARMIEL.zip', contentType:'application/zip' }
    And multipart file file = { read:'./ZipArchiveFiles/TEST_ZIP_19files.zip', filename:'TEST_ZIP_19files.zip', contentType: 'application/zip' }
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method POST
    Then status 202

    Then print response

    * def processId = response.data.processId

    And print '\n'
    And print '================================'
    And print '******** BULK-ATTACH FILES TO THIRD-PARTY: VALID FILES IN ZIP ARCHIVE'
    And print '******** PROCESS ID = '+ processId
    And print '================================\n'
    And print '\n'

    And match response ==
      """
        {
          "message": '#string',
          "data": {
            "processId": '#string'
          }
        }
      """



# PAUSE 1 minute to allow for server processing of file attachment

    * pauseExecution( 60000 )


#
# Retrieve PROCESS ID details
#

    Given url postUrl = baseTestUrl
    And path 'thirdparty/bulk-attachments', processId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken

    And retry until response.data.status == 'COMPLETED'
    When method GET
    Then status 200

#   Then print response
#
#   * pauseExecution( 10000 )

#    * def relatedFilesStatusArr-meta_schema = { filename: '#string',  fileSize: '#number' }

#    And match response ==
#      """
#        {
#          "message":              '200(OK) The request was successful.',
#          "data": {
#            "processId":              #(processId),
#            "filename":               '#string',
#            "meta": {
#              "filename":                 '#(archiveToZipFileResult)',
#              "fileSize":                 '#number',
#              "location":                 '##string'
#            },
#            "uploadTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#            "uploadDate":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}$',
#            "status":                 'COMPLETED',
#            "relatedFilesStatus":     '#[] ^ {
#                                                 supplierId: "#(thirdPartyId)",
#                                                 filename:   "#string",
#                                                 meta:       "##object",
#                                                 error:      null,
#                                                 status:     "UPLOADED"
#                                             }',
#            "errors":                 null,
#            "successResponseFile": null,
#            "errorResponseFile":   null,
#            "numberOfRecords":     '##number',
#            "recordProcessed":     '##number',
#            "recordWithErrors":    '##number',
#            "entityType":          '##string',
#            "entityId":            '##string',
#            "childReferenceId":    '##string',
#            "triggeredBy":         '##string',
#            "processType":         '##string'
#          }
#        }
#      """

    And match response ==
      """
        {
          "message":              '200(OK) The request was successful.',
          "data": {
            "processId":              #(processId),
            "filename":               '#string',
            "meta": {
              "filename":                 '#(archiveToZipFileResult)',
              "fileSize":                 '#number',
              "location":                 '##string'
            },
            "uploadTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
            "uploadDate":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}$',
            "status":                 'COMPLETED',
            "relatedFilesStatus":     '#[] ^ {
                                                 entityId:         "#(thirdPartyId)",
                                                 childReferenceId: "##string",
                                                 filename:         "#string",
                                                 meta:             "##object",
                                                 error:            null,
                                                 status:           "UPLOADED"
                                             }',
            "errors":                 null,
            "successResponseFile": null,
            "errorResponseFile":   null,
            "numberOfRecords":     '##number',
            "recordProcessed":     '##number',
            "recordWithErrors":    '##number',
            "entityType":          '##string',
            "entityId":            '##string',
            "childReferenceId":    '##string',
            "triggeredBy":         '##string',
            "processType":         '##string'
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



#
#  Scenario Outline: X)
#
#    Given url postUrl = baseTestUrl
#    And path 'thirdparty/bulk-attachments'
#    And multipart file file = { read:'<fileName>', filename:'<fileName>', contentType: 'application/zip' }
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method POST
#    Then status <statusCode>
#
#    Examples:
#      | fileName       | statusCode |
#      | TEST_BMP.bmp   | 400        |
#      | TEST_CSV.csv   | 400        |
#      | TEST_DOC.doc   | 400        |
#      | TEST_DOCX.docx |     202    |
#      | TEST_JPEG.jpeg | 400        |
#      | TEST_JPG.jpg   | 400        |
#      | TEST_MSG.msg   | 400        |
#      | TEST_PDF.pdf   | 400        |
#      | TEST_PNG.png   | 400        |
#      | TEST_PPT.ppt   | 400        |
#      | TEST_PPTX.pptx |     202    |
#      | TEST_PSD.psd   | 400        |
#      | TEST_TIF.tif   | 400        |
#      | TEST_TIFF.tiff | 400        |
#      | TEST_TXT.txt   | 400        |
#      | TEST_VSD.vsd   | 400        |
#      | TEST_VSDX.vsdx |     202    |
#      | TEST_XLS.xls   | 400        |
#      | TEST_XLSX.xlsx |     202    |
#      | TEST_ZIP.zip   |     202    |
#      | TEST_ZIP_2.zip |     202    |



  Scenario: 2) C36570701 Public API - SIConnect Public API V2 - Bulk Upload Supplier Related Files
               - verify if supplier ID/Supplier ref no. is required

#
# CREATE third-party
#
    * def requestBody_createThirdParty =
      """
          {
            "referenceNo": null,
            "name": "ABC-BULKATTACH Corp",
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
                              "countryAlerts":          '##[] ##string',
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



#
# Create ZIP FILE: archive 'meta.json' along with other zip entry files
#

#    * def jsonContent =
#      """
#        [
#          {
#            'supplierId': '#(thirdPartyId)',
#            'attachments': [
#                'TEST_BMP.bmp',
#                'TEST_CSV.csv',
#                'TEST_DOC.doc',
#                'TEST_DOCX.docx',
#                'TEST_JPEG.jpeg',
#                'TEST_JPG.jpg',
#                'TEST_MSG.msg',
#                'TEST_PDF.pdf',
#                'TEST_PNG.png',
#                'TEST_PPT.ppt',
#                'TEST_PPTX.pptx',
#                'TEST_PSD.psd',
#                'TEST_TIF.tif',
#                'TEST_TIFF.tiff',
#                'TEST_TXT.txt',
#                'TEST_VSD.vsd',
#                'TEST_VSDX.vsdx',
#                'TEST_XLS.xls',
#                'TEST_XLSX.xlsx'
#            ]
#          }
#        ]
#      """
#
#    * def writeToFileResult = writeToFile( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/meta.json", jsonContent )

    * def metaJsonContentArr = null
    * json metaJsonContentArr = ( metaJsonContentArr || [] )

    * def metaJsonContentElem = { 'supplierId' : '' }
    * json attachments = []
    * if ( ! metaJsonContentElem.attachments ) metaJsonContentElem.attachments = attachments



#    * def archiveToZipFileResult = archiveToZipFile( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )

    * def attachmentsArrElem = 'TEST_BMP.bmp'
    * def archiveToZipFileResult = archiveToZipFile( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

    And print '\n'
    And print '================================'
    And print '******** BULK-ATTACH FILES TO THIRD-PARTY'
    And print '******** ZIP FILENAME = '+ archiveToZipFileResult
    And print '================================\n'
    And print '\n'



#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_CSV.csv" )

    * def attachmentsArrElem = 'TEST_CSV.csv'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_DOC.doc" )

    * def attachmentsArrElem = 'TEST_DOC.doc'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_DOCX.docx" )

    * def attachmentsArrElem = 'TEST_DOCX.docx'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_JPEG.jpeg" )
#
#    * def attachmentsArrElem = 'TEST_JPEG.jpeg'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
#    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_JPG.jpg" )
#
#    * def attachmentsArrElem = 'TEST_JPG.jpg'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
#    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_MSG.msg" )
#
#    * def attachmentsArrElem = 'TEST_MSG.msg'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
#    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PDF.pdf" )
#
#    * def attachmentsArrElem = 'TEST_PDF.pdf'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
#    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PNG.png" )
#
#    * def attachmentsArrElem = 'TEST_PNG.png'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
#    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PPT.ppt" )
#
#    * def attachmentsArrElem = 'TEST_PPT.ppt'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
#    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PPTX.pptx" )
#
#    * def attachmentsArrElem = 'TEST_PPTX.pptx'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
#    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PSD.psd" )
#
#    * def attachmentsArrElem = 'TEST_PSD.psd'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
#    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_TIF.tif" )
#
#    * def attachmentsArrElem = 'TEST_TIF.tif'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
#    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_TIFF.tiff" )
#
#    * def attachmentsArrElem = 'TEST_TIFF.tiff'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
#    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_TXT.txt" )
#
#    * def attachmentsArrElem = 'TEST_TXT.txt'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
#    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_VSD.vsd" )
#
#    * def attachmentsArrElem = 'TEST_VSD.vsd'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
#    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_VSDX.vsdx" )
#
#    * def attachmentsArrElem = 'TEST_VSDX.vsdx'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
#    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_XLS.xls" )
#
#    * def attachmentsArrElem = 'TEST_XLS.xls'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
#    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_XLSX.xlsx" )
#
#    * def attachmentsArrElem = 'TEST_XLSX.xlsx'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
#    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )



# Write meta information to 'meta.json' FILE
    * def void = ( metaJsonContentArr.add(metaJsonContentElem) )
    * def writeToFileResult = writeToFile( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/meta.json", metaJsonContentArr )



# Add 'meta.json' file to ZIP FILE
    * def attachmentsArrElem = 'meta.json'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )



#
# ATTACH ZIP FILE to newly-created ThirdParty
#

    Given url postUrl = baseTestUrl
    And path 'thirdparty/bulk-attachments'
#    And multipart file file = { read:'', filename:'file:/c/Users/U0182583/Desktop/_MyFiles/SI/REPO/GITLAB/rutaf-bdd-si/src/test/resources/features/api/public_thirdparty/RMS-126_ForJARMIEL.zip', contentType:'application/zip' }
    And multipart file file = { read:'./ZipArchiveFiles/TEST_ZIP_19files_NoSupplier.zip', filename:'TEST_ZIP_19files_NoSupplier.zip', contentType: 'application/zip' }
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method POST
    Then status 202

    Then print response

    * def processId = response.data.processId

    And print '\n'
    And print '================================'
    And print '******** BULK-ATTACH FILES TO THIRD-PARTY: NO SUPPLIER IN meta.json'
    And print '******** PROCESS ID = '+ processId
    And print '================================\n'
    And print '\n'

    And match response ==
      """
        {
          "message": '#string',
          "data": {
            "processId": '#string'
          }
        }
      """



# PAUSE 1 minute to allow for server processing of file attachment

    * pauseExecution( 60000 )



# Retrieve PROCESS ID details

    Given url postUrl = baseTestUrl
    And path 'thirdparty/bulk-attachments', processId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken

    And retry until response.data.status == 'COMPLETED'
    When method GET
    Then status 200

#   Then print response
#
#   * pauseExecution( 10000 )

    And match response ==
      """
        {
          "message":              '#string',
          "data": {
            "processId":              #(processId),
            "filename":               '#string',
            "meta": {
              "filename":                 '#(archiveToZipFileResult)',
              "fileSize":                 '#number',
              "location":                 '##string'
            },
            "uploadTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
            "uploadDate":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}$',
            "status":                 'COMPLETED',
            "relatedFilesStatus":     '#[] ^ {
                                                 entityId:         "##string",
                                                 childReferenceId: "##string",
                                                 filename:         "##string",
                                                 meta:             "##object",
                                                 error:            "Supplier not found. Supplier related files will not be processed.",
                                                 status:           "NOT_UPLOADED"
                                             }',
            "errors":                 '##string',
            "successResponseFile":    null,
            "errorResponseFile":      null,
            "numberOfRecords":        '##number',
            "recordProcessed":        '##number',
            "recordWithErrors":       '##number',
            "entityType":             '##string',
            "entityId":               '##string',
            "childReferenceId":       '##string',
            "triggeredBy":            '##string',
            "processType":            '##string'

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




  Scenario: 3) C36570704 Public API - SIConnect Public API V2 - Bulk Upload Supplier Related Files
               - Verify maximum size of file

#
# CREATE third-party
#
    * def requestBody_createThirdParty =
      """
          {
            "referenceNo": null,
            "name": "ABC-BULKATTACH Corp",
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
                              "countryAlerts":          '##[] ##string',
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



#
# Create ZIP FILE: archive 'meta.json' along with other zip entry files
#

#    * def jsonContent =
#      """
#        [
#          {
#            'supplierId': '#(thirdPartyId)',
#            'attachments': [
#                'TEST_BMP.bmp',
#                'TEST_CSV.csv',
#                'TEST_DOC.doc',
#                'TEST_DOCX.docx',
#                'TEST_JPEG.jpeg',
#                'TEST_JPG.jpg',
#                'TEST_MSG.msg',
#                'TEST_PDF.pdf',
#                'TEST_PNG.png',
#                'TEST_PPT.ppt',
#                'TEST_PPTX.pptx',
#                'TEST_PSD.psd',
#                'TEST_TIF.tif',
#                'TEST_TIFF.tiff',
#                'TEST_TXT.txt',
#                'TEST_VSD.vsd',
#                'TEST_VSDX.vsdx',
#                'TEST_XLS.xls',
#                'TEST_XLSX.xlsx'
#            ]
#          }
#        ]
#      """
#
#    * def writeToFileResult = writeToFile( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/meta.json", jsonContent )

    * def metaJsonContentArr = null
    * json metaJsonContentArr = ( metaJsonContentArr || [] )

    * def metaJsonContentElem = { 'supplierId' : '#(thirdPartyId)' }
    * json attachments = []
    * if ( ! metaJsonContentElem.attachments ) metaJsonContentElem.attachments = attachments



#    * def archiveToZipFileResult = archiveToZipFile( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )

    * def attachmentsArrElem = 'TEST_TIF_40MB.tif'
    * def archiveToZipFileResult = archiveToZipFile( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )


    And print '\n'
    And print '================================'
    And print '******** BULK-ATTACH FILES TO THIRD-PARTY'
    And print '******** ZIP FILENAME = '+ archiveToZipFileResult
    And print '================================\n'
    And print '\n'



##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_CSV.csv" )
#
#    * def attachmentsArrElem = 'TEST_CSV.csv'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def void = ( metaJsonContentElem.attachments.add(attachmentsArrElem) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_DOC.doc" )
#
#    * def attachmentsArrElem = 'TEST_DOC.doc'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def void = ( metaJsonContentElem.attachments.add(attachmentsArrElem) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_DOCX.docx" )
#
#    * def attachmentsArrElem = 'TEST_DOCX.docx'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def void = ( metaJsonContentElem.attachments.add(attachmentsArrElem) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_JPEG.jpeg" )
#
#    * def attachmentsArrElem = 'TEST_JPEG.jpeg'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def void = ( metaJsonContentElem.attachments.add(attachmentsArrElem) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_JPG.jpg" )
#
#    * def attachmentsArrElem = 'TEST_JPG.jpg'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def void = ( metaJsonContentElem.attachments.add(attachmentsArrElem) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_MSG.msg" )
#
#    * def attachmentsArrElem = 'TEST_MSG.msg'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def void = ( metaJsonContentElem.attachments.add(attachmentsArrElem) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PDF.pdf" )
#
#    * def attachmentsArrElem = 'TEST_PDF.pdf'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def void = ( metaJsonContentElem.attachments.add(attachmentsArrElem) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PNG.png" )
#
#    * def attachmentsArrElem = 'TEST_PNG.png'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def void = ( metaJsonContentElem.attachments.add(attachmentsArrElem) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PPT.ppt" )
#
#    * def attachmentsArrElem = 'TEST_PPT.ppt'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def void = ( metaJsonContentElem.attachments.add(attachmentsArrElem) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PPTX.pptx" )
#
#    * def attachmentsArrElem = 'TEST_PPTX.pptx'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def void = ( metaJsonContentElem.attachments.add(attachmentsArrElem) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PSD.psd" )
#
#    * def attachmentsArrElem = 'TEST_PSD.psd'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def void = ( metaJsonContentElem.attachments.add(attachmentsArrElem) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_TIF.tif" )
#
#    * def attachmentsArrElem = 'TEST_TIF.tif'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def void = ( metaJsonContentElem.attachments.add(attachmentsArrElem) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_TIFF.tiff" )
#
#    * def attachmentsArrElem = 'TEST_TIFF.tiff'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def void = ( metaJsonContentElem.attachments.add(attachmentsArrElem) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_TXT.txt" )
#
#    * def attachmentsArrElem = 'TEST_TXT.txt'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def void = ( metaJsonContentElem.attachments.add(attachmentsArrElem) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_VSD.vsd" )
#
#    * def attachmentsArrElem = 'TEST_VSD.vsd'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def void = ( metaJsonContentElem.attachments.add(attachmentsArrElem) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_VSDX.vsdx" )
#
#    * def attachmentsArrElem = 'TEST_VSDX.vsdx'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def void = ( metaJsonContentElem.attachments.add(attachmentsArrElem) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_XLS.xls" )
#
#    * def attachmentsArrElem = 'TEST_XLS.xls'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def void = ( metaJsonContentElem.attachments.add(attachmentsArrElem) )
#
##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_XLSX.xlsx" )
#
#    * def attachmentsArrElem = 'TEST_XLSX.xlsx'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def void = ( metaJsonContentElem.attachments.add(attachmentsArrElem) )



# Write meta information to 'meta.json' FILE
    * def void = ( metaJsonContentArr.add(metaJsonContentElem) )
    * def writeToFileResult = writeToFile( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/meta.json", metaJsonContentArr )



# Add 'meta.json' file to ZIP FILE
    * def attachmentsArrElem = 'meta.json'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )



#
# ATTACH ZIP FILE to newly-created ThirdParty
#

    Given url postUrl = baseTestUrl
    And path 'thirdparty/bulk-attachments'
#    And multipart file file = { read:'', filename:'file:/c/Users/U0182583/Desktop/_MyFiles/SI/REPO/GITLAB/rutaf-bdd-si/src/test/resources/features/api/public_thirdparty/RMS-126_ForJARMIEL.zip', contentType:'application/zip' }
    And multipart file file = { read:'./ZipArchiveFiles/TEST_ZIP_40MBInclFile.zip', filename:'TEST_ZIP_40MBInclFile.zip', contentType: 'application/zip' }
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method POST
    Then status 202

#    Then print response

    * def processId = response.data.processId

    And print '\n'
    And print '================================'
    And print '******** BULK-ATTACH FILES TO THIRD-PARTY: EXCEEDS MAX. INCLUDED FILESIZE'
    And print '******** PROCESS ID = '+ processId
    And print '================================\n'
    And print '\n'

    And match response ==
      """
        {
          "message": '#string',
          "data": {
            "processId": '#string'
          }
        }
      """



# PAUSE 1 minute to allow for server processing of file attachment

    * pauseExecution( 90000 )



# Retrieve PROCESS ID details

    Given url postUrl = baseTestUrl
    And path 'thirdparty/bulk-attachments', processId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken

    And retry until response.data.status == 'COMPLETED'
    When method GET
    Then status 200

#   Then print response
#
#    * pauseExecution( 10000 )

#    And match response ==
#      """
#        {
#          "message":              '#string',
#          "data": {
#            "processId":              #(processId),
#            "filename":               '#string',
#            "meta": {
#              "filename":                 '#string',
#              "fileSize":                 '#number',
#              "location":                 '##string'
#            },
#            "uploadTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#            "uploadDate":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}$',
#            "status":                 "COMPLETED",
#            "relatedFilesStatus":     '#[] ^ {
#                                                 entityId:         "#(thirdPartyId)",
#                                                 childReferenceId: "##string",
#                                                 filename:         "#string",
#                                                 meta:             "##object",
#                                                 error:            "File format not allowed | File size exceed allowed size limit",
#                                                 status:           "NOT_UPLOADED"
#                                             }',
#            "errors":                 '##string',
#            "successResponseFile":    null,
#            "errorResponseFile":      null,
#            "numberOfRecords":        '##number',
#            "recordProcessed":        '##number',
#            "recordWithErrors":       '##number',
#            "entityType":             '##string',
#            "entityId":               '##string',
#            "childReferenceId":       '##string',
#            "triggeredBy":            '##string',
#            "processType":            '##string'
#          }
#        }
#      """



# Maximum file size limit changed in the server from 25MB to 100MB

    And match response ==
      """
        {
          "message":              '#string',
          "data": {
            "processId":              #(processId),
            "filename":               '#string',
            "meta": {
              "filename":                 '#string',
              "fileSize":                 '#number',
              "location":                 '##string'
            },
            "uploadTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
            "uploadDate":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}$',
            "status":                 "COMPLETED",
            "relatedFilesStatus":     '#[] ^ {
                                                 entityId:         "#(thirdPartyId)",
                                                 childReferenceId: "##string",
                                                 filename:         "#string",
                                                 meta:             "##object",
                                                 error:            "##string",
                                                 status:           "UPLOADED"
                                             }',
            "errors":                 '##string',
            "successResponseFile":    null,
            "errorResponseFile":      null,
            "numberOfRecords":        '##number',
            "recordProcessed":        '##number',
            "recordWithErrors":       '##number',
            "entityType":             '##string',
            "entityId":               '##string',
            "childReferenceId":       '##string',
            "triggeredBy":            '##string',
            "processType":            '##string'
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



  Scenario: 4) C36570705 Public API - SIConnect Public API V2 - Bulk Upload Supplier Related Files
               - Verify maximum number of files to be uploaded (more than 30 valid files)

#
# CREATE third-party
#
    * def requestBody_createThirdParty =
      """
          {
            "referenceNo": null,
            "name": "ABC-BULKATTACH Corp",
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
                              "countryAlerts":          '##[] ##string',
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



#
# Create ZIP FILE: archive 'meta.json' along with zip entry files
#

#    * def jsonContent =
#      """
#        [
#          {
#            'supplierId': '#(thirdPartyId)',
#            'attachments': [
#                'TEST_BMP.bmp',
#                'TEST_CSV.csv',
#                'TEST_DOC.doc',
#                'TEST_DOCX.docx',
#                'TEST_JPEG.jpeg',
#                'TEST_JPG.jpg',
#                'TEST_MSG.msg',
#                'TEST_PDF.pdf',
#                'TEST_PNG.png',
#                'TEST_PPT.ppt',
#                'TEST_PPTX.pptx',
#                'TEST_PSD.psd',
#                'TEST_TIF.tif',
#                'TEST_TIFF.tiff',
#                'TEST_TXT.txt',
#                'TEST_VSD.vsd',
#                'TEST_VSDX.vsdx',
#                'TEST_XLS.xls',
#                'TEST_XLSX.xlsx'
#            ]
#          }
#        ]
#      """
#
#    * def writeToFileResult = writeToFile( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/meta.json", jsonContent )

    * def metaJsonContentArr = null
    * json metaJsonContentArr = ( metaJsonContentArr || [] )

    * def metaJsonContentElem = { 'supplierId' : '#(thirdPartyId)' }
    * json attachments = []
    * if ( ! metaJsonContentElem.attachments ) metaJsonContentElem.attachments = attachments



#    * def archiveToZipFileResult = archiveToZipFile( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )

    * def attachmentsArrElem = 'TEST_BMP.bmp'
    * def archiveToZipFileResult = archiveToZipFile( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

    And print '\n'
    And print '================================'
    And print '******** BULK-ATTACH FILES TO THIRD-PARTY'
    And print '******** ZIP FILENAME = '+ archiveToZipFileResult
    And print '================================\n'
    And print '\n'



#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_CSV.csv" )

    * def attachmentsArrElem = 'TEST_BMP_2.bmp'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_CSV.csv" )

    * def attachmentsArrElem = 'TEST_CSV.csv'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_CSV.csv" )

    * def attachmentsArrElem = 'TEST_CSV_2.csv'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_DOC.doc" )

    * def attachmentsArrElem = 'TEST_DOC.doc'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_DOC.doc" )

    * def attachmentsArrElem = 'TEST_DOC_2.doc'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_DOCX.docx" )

    * def attachmentsArrElem = 'TEST_DOCX.docx'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_DOCX.docx" )

    * def attachmentsArrElem = 'TEST_DOCX_2.docx'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_JPEG.jpeg" )

    * def attachmentsArrElem = 'TEST_JPEG.jpeg'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_JPEG.jpeg" )

    * def attachmentsArrElem = 'TEST_JPEG_2.jpeg'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_JPG.jpg" )

    * def attachmentsArrElem = 'TEST_JPG.jpg'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_JPG.jpg" )

    * def attachmentsArrElem = 'TEST_JPG_2.jpg'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_MSG.msg" )

    * def attachmentsArrElem = 'TEST_MSG.msg'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_MSG.msg" )

    * def attachmentsArrElem = 'TEST_MSG_2.msg'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PDF.pdf" )

    * def attachmentsArrElem = 'TEST_PDF.pdf'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PDF.pdf" )

    * def attachmentsArrElem = 'TEST_PDF_2.pdf'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PNG.png" )

    * def attachmentsArrElem = 'TEST_PNG.png'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PNG.png" )

    * def attachmentsArrElem = 'TEST_PNG_2.png'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PPT.ppt" )

    * def attachmentsArrElem = 'TEST_PPT.ppt'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PPT.ppt" )

    * def attachmentsArrElem = 'TEST_PPT_2.ppt'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PPTX.pptx" )

    * def attachmentsArrElem = 'TEST_PPTX.pptx'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PPTX.pptx" )

    * def attachmentsArrElem = 'TEST_PPTX_2.pptx'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PSD.psd" )

    * def attachmentsArrElem = 'TEST_PSD.psd'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

##    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_PSD.psd" )

    * def attachmentsArrElem = 'TEST_PSD_2.psd'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_TIF.tif" )

    * def attachmentsArrElem = 'TEST_TIF.tif'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_TIF.tif" )

    * def attachmentsArrElem = 'TEST_TIF_2.tif'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_TIFF.tiff" )

    * def attachmentsArrElem = 'TEST_TIFF.tiff'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_TIFF.tiff" )

    * def attachmentsArrElem = 'TEST_TIFF_2.tiff'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_TXT.txt" )

    * def attachmentsArrElem = 'TEST_TXT.txt'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_TXT.txt" )

    * def attachmentsArrElem = 'TEST_TXT_2.txt'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_VSD.vsd" )

    * def attachmentsArrElem = 'TEST_VSD.vsd'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_VSD.vsd" )

#    * def attachmentsArrElem = 'TEST_VSD_2.vsd'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
#    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_VSDX.vsdx" )

    * def attachmentsArrElem = 'TEST_VSDX.vsdx'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_VSDX.vsdx" )

#    * def attachmentsArrElem = 'TEST_VSDX_2.vsdx'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
#    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_XLS.xls" )

    * def attachmentsArrElem = 'TEST_XLS.xls'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_XLS.xls" )

#    * def attachmentsArrElem = 'TEST_XLS_2.xls'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
#    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_XLSX.xlsx" )

    * def attachmentsArrElem = 'TEST_XLSX.xlsx'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/sampleZipArchive.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_XLSX.xlsx" )

#    * def attachmentsArrElem = 'TEST_XLSX_2.xlsx'
#    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )
#    * def attachmentArrElemJsonObj = { 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
#    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )



# Write meta information to 'meta.json' FILE
    * def void = ( metaJsonContentArr.add(metaJsonContentElem) )
    * def writeToFileResult = writeToFile( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/meta.json", metaJsonContentArr )



# Add 'meta.json' file to ZIP FILE
    * def attachmentsArrElem = 'meta.json'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/TEST_ZIP_34files.zip", "./src/test/resources/features/api/public_thirdparty/ZipArchiveFiles/"+ attachmentsArrElem )



#
# ATTACH ZIP FILE to newly-created ThirdParty
#

    Given url postUrl = baseTestUrl
    And path 'thirdparty/bulk-attachments'
#    And multipart file file = { read:'', filename:'file:/c/Users/U0182583/Desktop/_MyFiles/SI/REPO/GITLAB/rutaf-bdd-si/src/test/resources/features/api/public_thirdparty/RMS-126_ForJARMIEL.zip', contentType:'application/zip' }
    And multipart file file = { read:'./ZipArchiveFiles/TEST_ZIP_34files.zip', filename:'TEST_ZIP_34files.zip', contentType: 'application/zip' }
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method POST
    Then status 202

    Then print response

    * def processId = response.data.processId

    And print '\n'
    And print '================================'
    And print '******** BULK-ATTACH FILES TO THIRD-PARTY: EXCEEDS MAX. INCLUDED FILE COUNT'
    And print '******** PROCESS ID = '+ processId
    And print '================================\n'
    And print '\n'

    And match response ==
      """
        {
          "message": '#string',
          "data": {
            "processId": '#string'
          }
        }
      """



# PAUSE 1 minute to allow for server processing of file attachment

#    * pauseExecution( 90000 )



# Retrieve PROCESS ID details

    Given url postUrl = baseTestUrl
    And path 'thirdparty/bulk-attachments', processId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken

    And retry until response.data.status == 'COMPLETED'
    When method GET
    Then status 200

#    Then print response
#
#    * pauseExecution( 10000 )

#    * def metaSchema =
#      """
#        {
#          filename: '#string',
#          fileSize: '#number'
#        }
#      """

#    * def isErrorValid =
#      """
#        function( elem ) {
#            var errorVal = elem.error;
#            var statusVal = elem.status;
#            return (errorVal==null && statusVal=="UPLOADED") || (errorVal=="File exceeds the total number allowed attachment file quantity limit" && statusVal=="NOT_UPLOADED");
#        }
#      """

    And match response ==
      """
        {
          "message":              '200(OK) The request was successful.',
          "data": {
            "processId":              #(processId),
            "filename":               '#string',
            "meta": {
              "filename":                 '#(archiveToZipFileResult)',
              "fileSize":                 '#number',
              "location":                 '##string'
            },
            "uploadTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
            "uploadDate":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}$',
            "status":                 'COMPLETED',
            "relatedFilesStatus":     '#[] ^ {
                                                 entityId:         "#(thirdPartyId)",
                                                 childReferenceId: "##string",
                                                 filename:         "#string",
                                                 meta:             "##object",
                                                 error:            "##string",
                                                 status:           "##regex ^.*[(UPLOADED)|(NOT_UPLOADED)]$"
                                             }',
            "errors":                 null,
            "successResponseFile":    null,
            "errorResponseFile":      null,
            "numberOfRecords":        '##number',
            "recordProcessed":        '##number',
            "recordWithErrors":       '##number',
            "entityType":             '##string',
            "entityId":               '##string',
            "childReferenceId":       '##string',
            "triggeredBy":            '##string',
            "processType":            '##string'

          }
        }
      """



    * def targetValueUPLOADED = 'UPLOADED'
    * def uploadedFiles = []

    * karate.forEach( response.data.relatedFilesStatus, function(responseDataRelatedFilesStatusElem) { if (responseDataRelatedFilesStatusElem.status == targetValueUPLOADED) {uploadedFiles.add(responseDataRelatedFilesStatusElem.filename);} } )
    * def uploadedFilesCount = uploadedFiles.length

    * def targetValueNOTUPLOADED = 'NOT_UPLOADED'
    * def notUploadedFiles = []

    * karate.forEach( response.data.relatedFilesStatus, function(responseDataRelatedFilesStatusElem) { if (responseDataRelatedFilesStatusElem.status == targetValueNOTUPLOADED) {notUploadedFiles.add(responseDataRelatedFilesStatusElem.filename);} } )
    * def notUploadedFilesCount = notUploadedFiles.length

    And print '\n'
    And print '================================'
    And print '******** BULK-ATTACH FILES TO THIRD-PARTY: EXCEEDS MAX. INCLUDED FILE COUNT'
    And print '********     UPLOADED FILES COUNT = '+ uploadedFilesCount
    And print '********     UPLOADED FILES       = '+ uploadedFiles
    And print '******** NOT UPLOADED FILES COUNT = '+ notUploadedFilesCount
    And print '******** NOT UPLOADED FILES       = '+ notUploadedFiles
    And print '================================\n'
    And print '\n'

    * assert uploadedFilesCount ==    30
    * assert notUploadedFilesCount ==  4


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
    And print '============\n'
    And print '\n'
