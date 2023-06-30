@api @public_api @postPublicThirdPartyCreateThirdPartyTestEmptyStringToDBNull
Feature: Create Third Party



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




    * configure logPrettyResponse = true



  Scenario: 11) RMS-16861
               "Empty String, Empty List and Empty Objects are NOT Set
                to Null When Creating and Updating Third-Party and Contact"

                https://jira.refinitiv.com/browse/RMS-16861

                Expected Result:
                    The empty fields shoudl be saved in DB as NULL
                Actual Result:
                    The empty fields are saved in DB as empty strings


#
# CREATE third-party
#
    * def requestBody_createThirdParty =
      """
          {
            "referenceNo": "",
            "name": "ABC ThirdParty Incorporated",
            "currency": "",
            "companyType": "",
            "industryType": "",
            "organizationSize": "",
            "businessType": "",
            "incorporationDate": "",
            "revenue": "",
            "responsibleParty": "rddcentre.admin.np@refinitiv.com",
            "liquidationDate": "",
            "divisions": [
              "MyDivision"
            ],
            "affiliation": "",
            "workflowGroupId": "",
            "spendCategory": "",
            "sourcingMethod": "",
            "productDesignAgreement": "",
            "sourcingType": "",
            "relationshipVisibility": "",
            "productImpact": "",
            "commodityType": "",
            "address": {
              "addressLine": "",
              "city": "",
              "country": "US",
              "postalCode": "",
              "province": "",
              "region": ""
            },
            "contactInformation": {
              "email": [
              ],
              "fax": [
              ],
              "phoneNumber": [
              ],
              "website": [
              ]
            },
            "description": "",
            "customFields": [],
            "bankDetails": [
            ],
            "otherNames": [
              {
                "iwNameType": "Local Language Name",
                "name": "ABC LLC",
                "countryOfRegistration": "US"
              }
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


#    * def incDateReq =        requestBody_createThirdParty.incorporationDate
#    * def incDateResp =       response.data.incorporationDate
#
#    And match incDateReq ==   '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'
#    And match incDateResp ==  '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'
#
#    And print '\n'
#    And print '================================'
#    And print '******** CREATE THIRD-PARTY'
#    And print '******** TEST   : nowMs             = '+ nowMs
#    And print '********        : nowISODate        = '+ nowISODate
#    And print '********        : nowEpochTimeMs    = '+ nowEpochTimeMs
#    And print '********        :'
#    And print '********        : nowISODateLocTzo  = '+ nowISODateLocTzo
#    And print '********        : nowISODateLTzoMs  = '+ nowISODateLTzoMs
#    And print '********        : nowISODateLTzoMin = '+ nowISODateLTzoMin
#    And print '********        :'
#    And print '********        : nowISODateUTCTzo  = '+ nowISODateUTCTzo
#    And print '********        : nowISODateUTCTzo8 = '+ nowISODateUTCTzo8
#    And print '********        : nowISODateUTzoMs  = '+ nowISODateUTzoMs
#    And print '********        : nowISODateUTzoMin = '+ nowISODateUTzoMin
#    And print '********        :'
#    And print '********        : now000000ISODate  = '+ now000000ISODate
#    And print '********        : now235959ISODate  = '+ now235959ISODate
#    And print '********        : nowStartISODate4  = '+ nowStartISODate4
#    And print '********        : nowEndISODate4    = '+ nowEndISODate4
#    And print '********        :'
#    And print '********        : nowISODateAsUTC   = '+ nowISODateAsUTC
#    And print '********        : nowISODateToUTC   = '+ nowISODateToUTC
#    And print '********        :'
#    And print '******** CREATED: thirdPartyId      = '+ thirdPartyId
#    And print '********        : incDateReq        = '+ incDateReq
#    And print '********        : incDateResp       = '+ incDateResp
#    And print '================================\n'
#    And print '\n'
#
#
#
##
## VALIDATE response body SCHEMA
##
#    And match response ==
#          """
#              {
#                "message": '##string',
#                "data":    {
#                              "id":                     '##string',
#                              "referenceNo":            '##string',
#                              "name":                   '##string',
#                              "currency":               '##string',
#                              "companyType":            '##string',
#                              "industryType":           '##string',
#                              "organizationSize":       '##string',
#                              "businessType":           '##string',
#                              "incorporationDate":      '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#                              "revenue":                '##string',
#                              "responsibleParty":       '##string',
#                              "liquidationDate":        '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#                              "divisions":              '##[] #string',
#                              "affiliation":            '##string',
#                              "workflowGroupId":        '##string',
#                              "assessmentDetail":       '##string',
#                              "address":                {
#                                                          "addressLine": '##string',
#                                                          "city":        '##string',
#                                                          "province":    '##string',
#                                                          "postalCode":  '##string',
#                                                          "region":      '##string',
#                                                          "country":     '##string',
#                                                        },
#                              "spendCategory":          '##string',
#                              "sourcingMethod":         '##string',
#                              "productDesignAgreement": '##string',
#                              "sourcingType":           '##string',
#                              "relationshipVisibility": '##string',
#                              "productImpact":          '##string',
#                              "commodityType":          '##string',
#                              "customFields":           '##[] ^^ {
#                                                                  active:              "##boolean",
#                                                                  createTime:          "##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$",
#                                                                  description:         "##string",
#                                                                  id:                  "##string",
#                                                                  name:                "##string",
#                                                                  options:             "##[] ^ {
#                                                                                                 option:  ##string,
#                                                                                                 redFlag: ##boolean,
#                                                                                               }",
#                                                                  orderNumber:         "##number",
#                                                                  status:              "##string",
#                                                                  type:                "##string",
#                                                                  updateTime:          "##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$",
#                                                                  usePredefinedValues: "##boolean",
#                                                                  value:               "##string",
#                                                                }',
#                              "bankDetails":            '##[] ^ {
#                                                                  name:                "##string",
#                                                                  accountNo:           "##string",
#                                                                  branchName:          "##string",
#                                                                  addressLine:         "##string",
#                                                                  city:                "##string",
#                                                                  country:             "##string",
#                                                                }',
#                              "contactInformation":     {
#                                                          "phoneNumber": '##[] #string',
#                                                          "fax":         '##[] #string',
#                                                          "website":     '##[] #string',
#                                                          "email":       '##[] #string',
#                                                        },
#                              "status":                 '##string',
#                              "overallRiskScore":       '##number',
#                              "riskTier":               '##string',
#                              "overallStatus":          '##string',
#                              "screeningStatus":        '##string',
#                              "otherNames":             '##[] ^ {
#                                                                  name:                  "##string",
#                                                                  iwNameType:            "##string",
#                                                                  countryOfRegistration: "##string",
#                                                                }',
#                              "countryAlerts":          '##string',
#                              "description":            '##string',
#                              "createTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#                              "updateTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#                           }
#              }
#          """
#
#
#
##
## CHECK: Retrieve third-party BY ID - expected: FOUND
##
#    Given url getUrl = baseTestUrl
#    And path 'thirdparty', thirdPartyId
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method GET
#    Then status 200
#
#
#
#    * def thirdPartyIdResult = response.data.id
#    And match thirdPartyId == thirdPartyIdResult
#
#
#
#    * def eTag = responseHeaders['ETag'][0].split('"')[1]
#    And print '\n'
#    And print '================================'
#    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY BY ID'
#    And print '******** thirdPartyId       = '+ thirdPartyId
#    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
#    And print '******** ETag               = '+ eTag
#    And print '================================\n'
#    And print '\n'
#
#
#
##
## TODO: Validate response body schema: NO NEED?
##
#
#
#
##
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
#    * def thirdPartyIds = get response.data[*].id
#    And assert thirdPartyIds.contains( thirdPartyIdResult )
#
#    * def count = response.data.length
#    And print '\n'
#    And print '================================'
#    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
#    And print '******** COUNT: data.length = '+ count
#    And print '******** thirdPartyId       = '+ thirdPartyId
#    And print '******** thirdPartyIds      = '+ thirdPartyIds
#    And print '================================\n'
#    And print '\n'
#
#
#
##
## DELETE third-party by id
##
#    Given url deleteUrl = baseTestUrl
#    And path 'thirdparty', thirdPartyIdResult
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method DELETE
#    Then status 204
#
#
#
##
## CHECK: Retrieve third-party BY ID - expected: NOT FOUND
##
#    Given url getUrl = baseTestUrl
#    And path 'thirdparty', thirdPartyIdResult
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method GET
#    Then status 404
#
#
#
##
## CHECK: Get third-parties LIST for this day - expected: NOT FOUND
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
#    * def thirdPartyIds = get response.data[*].id
#    And assert !thirdPartyIds.contains( thirdPartyIdResult )
#
#    * def count = response.data.length
#    And print '\n'
#    And print '================================'
#    And print '******** CREATE THIRD-PARTY: RETRIEVE THIRD-PARTY LIST'
#    And print '******** COUNT: data.length = '+ count
#    And print '******** thirdPartyId       = '+ thirdPartyId
#    And print '******** thirdPartyIds      = '+ thirdPartyIds
#    And print '================================\n'
#    And print '\n'







  #
# CREATE contact
#
    * def requestBody_createContact =
      """
          {
            "parent": "#(thirdPartyId)",
            "title": "",
            "firstName": "John",
            "middleName": "",
            "lastName": "Good",
            "personalDetails": {
              "nationality": "",
              "placeOfBirth": ""
            },
            "addresses": [
              {
                "addressLine": "",
                "city": "",
                "country": "US",
                "postalCode": "",
                "province": "",
                "region": "021"
              }
            ],
            "contactInformation": {
              "email": [
              ],
              "fax": [
              ],
              "phoneNumber": [
              ],
              "website": [
              ]
            },
            "description": "",
            "otherNames": [
              {
                 "name": "John Smythe",
                 "iwNameType": "Locally Known As",
                 "countryOfBirth":"US",
                 "countryOfLocation":"US",
                 "nationality":"US"
              }
            ],
            "isActive": true,
            "isPrincipal": true,
            "autoScreen": true
          }
      """

    Given url postUrl = baseTestUrl
    And path 'contacts'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_createContact
    When method POST
    Then status 201

    * def contactId = response.data.id



