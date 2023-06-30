@api @public_api @postPublicContactsCreateContact
Feature: Create Contact



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


    * configure logPrettyResponse = true



  Scenario: 1) C36263205 Public API - POST /contacts
               - Verify that contact is successfully created

#
# CREATE PARENT third-party PARENT of new contact
#

    * def requestBody_createThirdParty =
      """
          {
            "referenceNo": null,
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



#
# CHECK: Retrieve PARENT third-party BY ID - expected: FOUND
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
    And print '******** CREATE CONTACT: CREATE & RETRIEVE (PARENT) THIRD-PARTY BY ID'
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'



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

    And match nowISODate ==      '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'



#
# CREATE contact
#
    * def requestBody_createContact =
      """
          {
            "parent": "#(thirdPartyId)",
            "title": "Mr.",
            "firstName": "Johnny",
            "middleName": "Bee",
            "lastName": "Goode",
            "personalDetails": {
              "nationality": "US",
              "placeOfBirth": "US"
            },
            "addresses": [
              {
                "addressLine": "Address Line 1",
                "city": "City 1",
                "country": "US",
                "postalCode": "31080",
                "province": "Province 1",
                "region": "#(region)"
              }
            ],
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
            "description": "This is contact's description",
            "otherNames": [
            ],
            "isActive": false,
            "isPrincipal": false,
            "autoScreen": false
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

    * def createDateResp =    response.data.createTime
    And match createDateResp ==  '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'

    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: CREATE CONTACT'
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
    And print '******** CREATED: contactId         = '+ contactId
    And print '********        : createDateResp    = '+ createDateResp
    And print '================================\n'
    And print '\n'



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
#                              "customFields":           '##[] ^ {
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
#                              "createTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#                              "updateTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#                           }
#              }
#          """



#
# CHECK: Retrieve contact BY ID - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts', contactId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200



    * def contactIdResult = response.data.id
    And match contactId == contactIdResult



    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: RETRIEVE CONTACT BY ID'
    And print '******** contactId       = '+ contactId
    And print '******** contactIdResult = '+ contactIdResult
    And print '******** ETag            = '+ eTag
    And print '================================\n'
    And print '\n'



#
# TODO: Validate response body schema: NO NEED?
#



#
# CHECK: Get contacts LIST for this day - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts'
    And param pageSize =       400
    And param start =          nowStartISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def contactIds = get response.data[*].id
    And assert contactIds.contains( contactId )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: RETRIEVE CONTACTS LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** contactId          = '+ contactId
    And print '******** contactIds         = '+ contactIds
    And print '================================\n'
    And print '\n'



#
# DELETE contact by id
#
    Given url deleteUrl = baseTestUrl
    And path 'contacts', contactIdResult
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204



#
# CHECK: Retrieve contact BY ID - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts', contactIdResult
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 404



#
# CHECK: Get contacts LIST for this day - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts'
    And param pageSize =       400
    And param start =          nowStartISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def contactIds = get response.data[*].id
#    And assert !contactIds.contains( contactId )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: RETRIEVE CONTACTS LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** contactId          = '+ contactId
    And print '******** contactIds         = '+ contactIds
    And print '================================\n'
    And print '\n'



#
# DELETE PARENT third-party by id
#
    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204



#
# CHECK: Retrieve PARENT third-party BY ID - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 404





  Scenario: 2) C36263208 Public API - POST /contacts
               - Verify that contact with 5 contact information is successfully created


#
# CREATE PARENT third-party PARENT of new contact
#

    * def requestBody_createThirdParty =
      """
          {
            "referenceNo": null,
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



#
# CHECK: Retrieve PARENT third-party BY ID - expected: FOUND
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
    And print '******** CREATE CONTACT: CREATE & RETRIEVE (PARENT) THIRD-PARTY BY ID'
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'




#
# CREATE contact: Using MAXIMUM 5 Contact Information items (phone, fax, website)
#
    * def requestBody_createContact =
      """
          {
            "parent": "#(thirdPartyId)",
            "title": "Mr.",
            "firstName": "John",
            "middleName": "Van",
            "lastName": "Smith",
            "personalDetails": {
              "nationality": "US",
              "placeOfBirth": "US"
            },
            "addresses": [
              {
                "addressLine": "Address Line 1",
                "city": "City 1",
                "country": "US",
                "postalCode": "31080",
                "province": "Province 1",
                "region": "#(region)"
              }
            ],
            "contactInformation": {
              "email": [
                "john.smith@company01.com",
                "john.smith@company02.com",
                "john.smith@company03.com",
                "john.smith@company04.com",
                "john.smith@company05.com",
                "john.smith@company06.com",
                "john.smith@company07.com",
                "john.smith@company08.com",
                "john.smith@company09.com",
                "john.smith@company10.com",
                "john.smith@company11.com",
                "john.smith@company12.com",
                "john.smith@company13.com",
                "john.smith@company14.com",
                "john.smith@company15.com",
                "john.smith@company16.com",
                "john.smith@company17.com",
                "john.smith@company18.com",
                "john.smith@company19.com",
                "john.smith@company20.com"
              ],
              "fax": [
                "+91 (123) 456-7891",
                "+91 (123) 456-7892",
                "+91 (123) 456-7893",
                "+91 (123) 456-7894",
                "+91 (123) 456-7895"
              ],
              "phoneNumber": [
                "123-456-7891",
                "123-456-7892",
                "123-456-7893",
                "123-456-7894",
                "123-456-7895"
              ],
              "website": [
                "http://www.company1.com",
                "http://www.company2.com",
                "http://www.company3.com",
                "http://www.company4.com",
                "http://www.company5.com"
              ]
            },
            "description": "This is contact's description",
            "otherNames": [
            ],
            "isActive": false,
            "isPrincipal": false,
            "autoScreen": false
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

    * def createDateResp =    response.data.createTime

    And match nowISODate ==      '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'
    And match createDateResp ==  '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'

    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: CREATE CONTACT'
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
    And print '******** CREATED: contactId         = '+ contactId
    And print '********        : createDateResp    = '+ createDateResp
    And print '================================\n'
    And print '\n'



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
#                              "customFields":           '##[] ^ {
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
#                              "createTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#                              "updateTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#                           }
#              }
#          """



#
# CHECK: Retrieve contact BY ID - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts', contactId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200



    * def contactIdResult = response.data.id
    And match contactId == contactIdResult



    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: RETRIEVE CONTACT BY ID'
    And print '******** contactId       = '+ contactId
    And print '******** contactIdResult = '+ contactIdResult
    And print '******** ETag            = '+ eTag
    And print '================================\n'
    And print '\n'



#
# CHECK: Get contacts LIST for this day - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts'
    And param pageSize =       400
    And param start =          nowStartISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def contactIds = get response.data[*].id
    And assert contactIds.contains( contactId )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: RETRIEVE CONTACTS LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** contactId          = '+ contactId
    And print '******** contactIds         = '+ contactIds
    And print '================================\n'
    And print '\n'



#
# DELETE contact by id
#
    Given url deleteUrl = baseTestUrl
    And path 'contacts', contactIdResult
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204



#
# CHECK: Retrieve contact BY ID - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts', contactIdResult
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 404



#
# CHECK: Get contacts LIST for this day - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts'
    And param pageSize =       400
    And param start =          nowStartISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def contactIds = get response.data[*].id
#    And assert !contactIds.contains( contactId )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: RETRIEVE CONTACTS LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** contactId          = '+ contactId
    And print '******** contactIds         = '+ contactIds
    And print '================================\n'
    And print '\n'


#
# CREATE contact: CONTACT INFORMATION count EXCEEDS maximum 5 items (phone, fax, website)
#
    * def requestBody_createContact =
      """
          {
            "parent": "#(thirdPartyId)",
            "title": "Mr.",
            "firstName": "John",
            "middleName": "Van",
            "lastName": "Smith",
            "personalDetails": {
              "nationality": "US",
              "placeOfBirth": "US"
            },
            "addresses": [
              {
                "addressLine": "Address Line 1",
                "city": "City 1",
                "country": "US",
                "postalCode": "31080",
                "province": "Province 1",
                "region": "#(region)"
              }
            ],
            "contactInformation": {
              "email": [
                "john.smith@company01.com",
                "john.smith@company02.com",
                "john.smith@company03.com",
                "john.smith@company04.com",
                "john.smith@company05.com",
                "john.smith@company06.com",
                "john.smith@company07.com",
                "john.smith@company08.com",
                "john.smith@company09.com",
                "john.smith@company10.com",
                "john.smith@company11.com",
                "john.smith@company12.com",
                "john.smith@company13.com",
                "john.smith@company14.com",
                "john.smith@company15.com",
                "john.smith@company16.com",
                "john.smith@company17.com",
                "john.smith@company18.com",
                "john.smith@company19.com",
                "john.smith@company20.com"
              ],
              "fax": [
                "+91 (123) 456-7891",
                "+91 (123) 456-7892",
                "+91 (123) 456-7893",
                "+91 (123) 456-7894",
                "+91 (123) 456-7895",
                "+91 (123) 456-7896"
              ],
              "phoneNumber": [
                "123-456-7891",
                "123-456-7892",
                "123-456-7893",
                "123-456-7894",
                "123-456-7895",
                "123-456-7896"
              ],
              "website": [
                "http://www.company1.com",
                "http://www.company2.com",
                "http://www.company3.com",
                "http://www.company4.com",
                "http://www.company5.com",
                "http://www.company6.com"
              ]
            },
            "description": "This is contact's description",
            "otherNames": [
            ],
            "isActive": false,
            "isPrincipal": false,
            "autoScreen": false
          }
      """

    Given url postUrl = baseTestUrl
    And path 'contacts'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_createContact
    When method POST
    Then status 400

    * def requestBadFields = [ "contactInformation.phoneNumber", "contactInformation.website", "contactInformation.fax" ]
    * def responseBadFields = get response.errors[*].field

    And match responseBadFields contains only requestBadFields


#
# VALIDATE ERROR response body SCHEMA
#
    And match response ==
          """
              {
                  "errors": '##[] ^^ {
                                         "field":       "#? requestBadFields.contains(_)",
                                         "code":        "SI-ERR-002",
                                         "description": "##regex ^.*[(should not exceed the maximum length!)]$"
                                     }'
              }
          """



#
# DELETE PARENT third-party by id
#
    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204



#
# CHECK: Retrieve PARENT third-party BY ID - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 404









  Scenario: 3) C36263206 Public API - POST /contacts
               - Verify that contact with five ADDRESSES is successfully created
               - Verify that contact with MORE THAN FIVE addresses results in error

#
# CREATE PARENT third-party PARENT of new contact
#

    * def requestBody_createThirdParty =
      """
          {
            "referenceNo": null,
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



#
# CHECK: Retrieve PARENT third-party BY ID - expected: FOUND
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
    And print '******** CREATE CONTACT: CREATE & RETRIEVE (PARENT) THIRD-PARTY BY ID'
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'




#
# CREATE contact: Using MAXIMUM 5 ADDRESS items
#
    * def requestBody_createContact =
      """
          {
            "parent": "#(thirdPartyId)",
            "title": "Mr.",
            "firstName": "John",
            "middleName": "Van",
            "lastName": "Smith",
            "personalDetails": {
              "nationality": "US",
              "placeOfBirth": "US"
            },
            "addresses": [
              {
                "addressLine": "Address Line 1",
                "city": "City 1",
                "country": "US",
                "postalCode": "31080",
                "province": "Province 1",
                "region": "#(region)"
              },
              {
                "addressLine": "Address Line 2",
                "city": "City 2",
                "country": "US",
                "postalCode": "31080",
                "province": "Province 2",
                "region": "#(region)"
              },
              {
                "addressLine": "Address Line 3",
                "city": "City 3",
                "country": "US",
                "postalCode": "31080",
                "province": "Province 3",
                "region": "#(region)"
              },
              {
                "addressLine": "Address Line 4",
                "city": "City 4",
                "country": "US",
                "postalCode": "31080",
                "province": "Province 4",
                "region": "#(region)"
              },
              {
                "addressLine": "Address Line 5",
                "city": "City 5",
                "country": "US",
                "postalCode": "31080",
                "province": "Province 5",
                "region": "#(region)"
              }
            ],
            "contactInformation": {
              "email": [
                "john.smith@company01.com"
              ],
              "fax": [
                "+91 (123) 456-7891"
              ],
              "phoneNumber": [
                "123-456-7891"
              ],
              "website": [
                "http://www.company1.com"
              ]
            },
            "description": "This is contact's description",
            "otherNames": [
            ],
            "isActive": false,
            "isPrincipal": false,
            "autoScreen": false
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
    * def addressesCount = response.data.addresses.length
    And match addressesCount == 5



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

    * def createDateResp =    response.data.createTime

    And match nowISODate ==      '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'
    And match createDateResp ==  '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'

    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: CREATE CONTACT WITH 5 ADDRESSES'
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
    And print '******** CREATED: contactId         = '+ contactId
    And print '********        : createDateResp    = '+ createDateResp
    And print '********        : addressesCount    = '+ addressesCount
    And print '================================\n'
    And print '\n'



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
#                              "customFields":           '##[] ^ {
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
#                              "createTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#                              "updateTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#                           }
#              }
#          """



#
# CHECK: Retrieve contact BY ID - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts', contactId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200



    * def contactIdResult = response.data.id
    * def addressesCount = response.data.addresses.length
    And match contactId == contactIdResult
    And match addressesCount == 5



    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: RETRIEVE CONTACT BY ID'
    And print '******** contactId       = '+ contactId
    And print '******** contactIdResult = '+ contactIdResult
    And print '******** ETag            = '+ eTag
    And print '================================\n'
    And print '\n'



#
# CHECK: Get contacts LIST for this day - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts'
    And param pageSize =       400
    And param start =          nowStartISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def contactIds = get response.data[*].id
    And assert contactIds.contains( contactId )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: RETRIEVE CONTACTS LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** contactId          = '+ contactId
    And print '******** contactIds         = '+ contactIds
    And print '================================\n'
    And print '\n'



#
# DELETE contact by id
#
    Given url deleteUrl = baseTestUrl
    And path 'contacts', contactIdResult
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204



#
# CHECK: Retrieve contact BY ID - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts', contactIdResult
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 404



#
# CHECK: Get contacts LIST for this day - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts'
    And param pageSize =       400
    And param start =          nowStartISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def contactIds = get response.data[*].id

#
# Uncomment the ff. line when fixed:
#
#    And assert !contactIds.contains( contactId )



    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: RETRIEVE CONTACTS LIST, NO DELETED CONTACT'
    And print '******** COUNT: data.length = '+ count
    And print '******** contactId          = '+ contactId
    And print '******** contactIds         = '+ contactIds
    And print '================================\n'
    And print '\n'


#
# CREATE contact: ADDRESS count EXCEEDS maximum 5 items
#
    * def requestBody_createContact =
      """
          {
            "parent": "#(thirdPartyId)",
            "title": "Mr.",
            "firstName": "John",
            "middleName": "Van",
            "lastName": "Smith",
            "personalDetails": {
              "nationality": "US",
              "placeOfBirth": "US"
            },
            "addresses": [
              {
                "addressLine": "Address Line 1",
                "city": "City 1",
                "country": "US",
                "postalCode": "31080",
                "province": "Province 1",
                "region": "#(region)"
              },
              {
                "addressLine": "Address Line 2",
                "city": "City 2",
                "country": "US",
                "postalCode": "31080",
                "province": "Province 2",
                "region": "#(region)"
              },
              {
                "addressLine": "Address Line 3",
                "city": "City 3",
                "country": "US",
                "postalCode": "31080",
                "province": "Province 3",
                "region": "#(region)"
              },
              {
                "addressLine": "Address Line 4",
                "city": "City 4",
                "country": "US",
                "postalCode": "31080",
                "province": "Province 4",
                "region": "#(region)"
              },
              {
                "addressLine": "Address Line 5",
                "city": "City 5",
                "country": "US",
                "postalCode": "31080",
                "province": "Province 5",
                "region": "#(region)"
              },
              {
                "addressLine": "Address Line 6",
                "city": "City 6",
                "country": "US",
                "postalCode": "31080",
                "province": "Province 6",
                "region": "#(region)"
              }
            ],
            "contactInformation": {
              "email": [
                "john.smith@company01.com"
              ],
              "fax": [
                "+91 (123) 456-7891"
              ],
              "phoneNumber": [
                "123-456-7891"
              ],
              "website": [
                "http://www.company1.com"
              ]
            },
            "description": "This is contact's description",
            "otherNames": [
            ],
            "isActive": false,
            "isPrincipal": false,
            "autoScreen": false
          }
      """

    Given url postUrl = baseTestUrl
    And path 'contacts'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_createContact
    When method POST
    Then status 400

    * def requestBadFields = [ "addresses" ]
    * def responseBadFields = get response.errors[*].field

    And match responseBadFields contains only requestBadFields


#
# VALIDATE ERROR response body SCHEMA
#
    And match response ==
          """
              {
                  "errors": '##[] ^^ {
                                         "field":       "#? requestBadFields.contains(_)",
                                         "code":        "SI-ERR-002",
                                         "description": "##regex ^.*[(should not exceed the maximum length!)]$"
                                     }'
              }
          """



#
# DELETE PARENT third-party by id
#
    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204



#
# CHECK: Retrieve PARENT third-party BY ID - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 404



  Scenario: 4) C36385200 Public API - POST /contacts
               - Verify error in response body if fields did not exist/invalid


#
# CREATE PARENT third-party PARENT of new contact
#

    * def requestBody_createThirdParty =
      """
          {
            "referenceNo": null,
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



#
# CHECK: Retrieve PARENT third-party BY ID - expected: FOUND
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
    And print '******** CREATE CONTACT: CREATE & RETRIEVE (PARENT) THIRD-PARTY BY ID'
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'


#
# CREATE contact
#

    * def requestBody_createContact =
      """
          {
            "parent": "#(thirdPartyId)",
            "title": "Mr.",
            "firstName": "John",
            "middleName": "Van",
            "lastName": "Smith",
            "personalDetails": {
              "citizenship": "USX",
              "placeOfBirth": "USX"
            },
            "addresses": [
              {
                "addressLine": "Address Line 1",
                "city": "City 1",
                "country": "USXX",
                "postalCode": "31080",
                "province": "Province 1",
                "region": "#('XX'+ region)"
              }
            ],
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
            "description": "This is contact's description",
            "otherNames": [
              {
                "countryOfRegistration": "US",
                "iwNameType": "Also Known AsX",
                "name": "Local Name"
              }
            ],
            "isActive": false,
            "isPrincipal": false,
            "autoScreen": false
          }
      """

    Given url postUrl = baseTestUrl
    And path 'contacts'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_createContact
    When method POST
    Then status 400

#    * def requestBadFields = [ "addresses[0].country", "addresses[0].region", "personalDetails.placeOfBirth", "personalDetails.nationality", "otherNames[0].iwNameType", "addresses[0].country", ]
    * def requestBadFields = [ "addresses[0].country", "addresses[0].region", "personalDetails.placeOfBirth", "personalDetails.citizenship", "otherNames[0].iwNameType", "addresses[0].country", ]
#    * def requestBadFields = [ "personalDetails.nationality", "personalDetails.placeOfBirth", "otherNames[0].iwNameType", ]
    * def responseBadFields = get response.errors[*].field

    And match responseBadFields contains only requestBadFields



#
# VALIDATE ERROR response body SCHEMA
#
    And match response ==
          """
              {
                  "errors": '##[] ^^ {
                                         "field":       "#? requestBadFields.contains(_)",
                                         "code":        "##regex ^.*[(SI\-ERR\-003)|(SI\-ERR\-006)]$",
                                         "description": "##regex ^.*[(is not valid.)|(did not match!)]$"
                                     }'
              }
          """



#
# DELETE PARENT third-party by id
#
    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204



#
# CHECK: Retrieve PARENT third-party BY ID - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 404



  Scenario: 5) C36263210 Public API - POST /contacts
               - Verify error for active contact with existing email

#
# CREATE PARENT third-party PARENT of new contact
#

    * def requestBody_createThirdParty =
      """
          {
            "referenceNo": null,
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



#
# CHECK: Retrieve PARENT third-party BY ID - expected: FOUND
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
    And print '******** CREATE CONTACT: CREATE & RETRIEVE (PARENT) THIRD-PARTY BY ID'
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'


#
# CREATE contact #1
#

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



    * def requestBody_createContact =
      """
          {
            "parent": "#(thirdPartyId)",
            "title": "Mr.",
            "firstName": "John",
            "middleName": "Van",
            "lastName": "Smith",
            "personalDetails": {
              "nationality": "US",
              "placeOfBirth": "US"
            },
            "addresses": [
              {
                "addressLine": "Address Line 1",
                "city": "City 1",
                "country": "US",
                "postalCode": "31080",
                "province": "Province 1",
                "region": "#(region)"
              }
            ],
            "contactInformation": {
              "email": [
                "#('john.smith_'+ nowMs +'@company1.com')"
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
            "description": "This is contact's description",
            "otherNames": [
            ],
            "isActive": true,
            "isPrincipal": false,
            "autoScreen": false
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

    * def createDateResp =    response.data.createTime
    And match createDateResp ==  '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'

    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: CREATE CONTACT'
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
    And print '******** CREATED: contactId         = '+ contactId
    And print '********        : createDateResp    = '+ createDateResp
    And print '================================\n'
    And print '\n'



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
#                              "customFields":           '##[] ^ {
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
#                              "createTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#                              "updateTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#                           }
#              }
#          """



#
# CHECK: Retrieve contact BY ID - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts', contactId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200



    * def contactIdResult = response.data.id
    And match contactId == contactIdResult



    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: RETRIEVE CONTACT BY ID'
    And print '******** contactId       = '+ contactId
    And print '******** contactIdResult = '+ contactIdResult
    And print '******** ETag            = '+ eTag
    And print '================================\n'
    And print '\n'



#
# TODO: Validate response body schema: NO NEED?
#



#
# CHECK: Get contacts LIST for this day - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts'
    And param pageSize =       400
    And param start =          nowStartISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def contactIds = get response.data[*].id
    And assert contactIds.contains( contactId )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: RETRIEVE CONTACTS LIST, FIND CONTACT'
    And print '******** COUNT: data.length = '+ count
    And print '******** contactId          = '+ contactId
    And print '******** contactIds         = '+ contactIds
    And print '================================\n'
    And print '\n'



#
# CREATE contact #2
#
    * def requestBody_createContact =
      """
          {
            "parent": "#(thirdPartyId)",
            "title": "Mr.",
            "firstName": "John",
            "middleName": "Van",
            "lastName": "Smith",
            "personalDetails": {
              "nationality": "US",
              "placeOfBirth": "US"
            },
            "addresses": [
              {
                "addressLine": "Address Line 1",
                "city": "City 1",
                "country": "US",
                "postalCode": "31080",
                "province": "Province 1",
                "region": "#(region)"
              }
            ],
            "contactInformation": {
              "email": [
                "#('john.smith_'+ nowMs +'@company1.com')"
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
            "description": "This is contact's description",
            "otherNames": [
            ],
            "isActive": true,
            "isPrincipal": false,
            "autoScreen": false
          }
      """

    Given url postUrl = baseTestUrl
    And path 'contacts'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_createContact
    When method POST
    Then status 400

    * def requestBadFields = [ "contactInformation.email" ]
    * def responseBadFields = get response.errors[*].field

    And match responseBadFields contains only requestBadFields



#
# VALIDATE ERROR response body SCHEMA
#
    And match response ==
          """
              {
                  "errors": '##[] ^^ {
                                         "field":       "#? requestBadFields.contains(_)",
                                         "code":        "SI-ERR-003",
                                         "description": "##regex ^.*[(is not valid.)]$"
                                     }'
              }
          """




#
# DELETE contact #1 by id
#
    Given url deleteUrl = baseTestUrl
    And path 'contacts', contactId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204



#
# CHECK: Retrieve contact #1 BY ID - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts', contactId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 404



#
# CHECK: Get contacts LIST for this day - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts'
    And param pageSize =       400
    And param start =          nowStartISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def contactIds = get response.data[*].id
#    And assert !contactIds.contains( contactId )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: RETRIEVE CONTACTS LIST, FIND DELETED CONTACT #1'
    And print '******** COUNT: data.length = '+ count
    And print '******** contactId          = '+ contactId
    And print '******** contactIds         = '+ contactIds
    And print '================================\n'
    And print '\n'



##
## DELETE contact #2 by id
##
#    Given url deleteUrl = baseTestUrl
#    And path 'contacts', contactId2
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method DELETE
#    Then status 204
#
#
#
##
## CHECK: Retrieve contact BY ID - expected: NOT FOUND
##
#    Given url getUrl = baseTestUrl
#    And path 'contacts', contactId2
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method GET
#    Then status 404
#
#
#
##
## CHECK: Get contacts LIST for this day - expected: NOT FOUND
##
#    Given url getUrl = baseTestUrl
#    And path 'contacts'
#    And param pageSize =       400
#    And param start =          nowStartISODate4
#    And param end =            nowEndISODate4
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method GET
#    Then status 200
#
#    * def contactIds = get response.data[*].id
##    And assert !contactIds.contains( contactId2 )
#
#    * def count = response.data.length
#    And print '\n'
#    And print '================================'
#    And print '******** CREATE CONTACT: RETRIEVE CONTACTS LIST, FIND DELETED CONTACT #2'
#    And print '******** COUNT: data.length = '+ count
#    And print '******** contactId2         = '+ contactId2
#    And print '******** contactIds         = '+ contactIds
#    And print '================================\n'
#    And print '\n'



#
# DELETE PARENT third-party by id
#
    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204



#
# CHECK: Retrieve PARENT third-party BY ID - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 404



#  Scenario: 6) C36263211 Public API - POST /contacts
#               - Verify error for invalid format ( email address, phone number, website )
#
##
## CREATE PARENT third-party PARENT of new contact
##
#
#    * def requestBody_createThirdParty =
#      """
#          {
#            "referenceNo": null,
#            "name": "ABC Corp",
#            "currency": "USD",
#            "companyType": "CORP",
#            "industryType": "AHI",
#            "organizationSize": "11-50",
#            "businessType": "PRS",
#            "incorporationDate": "2021-06-18T05:32:07-0800",
#            "revenue": "10M",
#            "responsibleParty": "rddcentre.admin.np@refinitiv.com",
#            "liquidationDate": "2021-06-18T05:32:07-0800",
#            "divisions": [
#              "MyDivision"
#            ],
#            "affiliation": "SOE",
#            "workflowGroupId": "#(workflowGroupId)",
#            "spendCategory": "OTS",
#            "sourcingMethod": "DIST_M_SRC",
#            "productDesignAgreement": "OTS",
#            "sourcingType": "MULTI",
#            "relationshipVisibility": "LITTLE_VIS",
#            "productImpact": "COMMODITIZED_PRODUCT",
#            "commodityType": "A3P",
#            "address": {
#              "addressLine": "Address Line 1",
#              "city": "City 1",
#              "country": "US",
#              "postalCode": "31080",
#              "province": "Province 1",
#              "region": "#(region)"
#            },
#            "contactInformation": {
#              "email": [
#                "john.smith@company1.com"
#              ],
#              "fax": [
#                "+91 (123) 456-7890"
#              ],
#              "phoneNumber": [
#                "123-456-7890"
#              ],
#              "website": [
#                "http://www.company1.com"
#              ]
#            },
#            "description": "This is supplier description",
#            "customFields": [],
#            "bankDetails": [
#              {
#                "accountNo": "111-11111111-1",
#                "addressLine": "Address 1",
#                "branchName": "Branch Name",
#                "city": "City 1",
#                "country": "US",
#                "name": "Bank Name"
#              }
#            ],
#            "otherNames": [
#            ]
#          }
#      """
#
#    Given url postUrl = baseTestUrl
#    And path 'thirdparty'
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    And request requestBody_createThirdParty
#    When method POST
#    Then status 201
#
#    * def thirdPartyId = response.data.id
#
#
#
##
## CHECK: Retrieve PARENT third-party BY ID - expected: FOUND
##
#    Given url getUrl = baseTestUrl
#    And path 'thirdparty', thirdPartyId
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method GET
#    Then status 200
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
#    And print '******** CREATE CONTACT: CREATE & RETRIEVE (PARENT) THIRD-PARTY BY ID'
#    And print '******** thirdPartyId       = '+ thirdPartyId
#    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
#    And print '******** ETag               = '+ eTag
#    And print '================================\n'
#    And print '\n'
#
#
#
##
## CREATE contact
##
#
#    * def nowMs =             call fnGetNowMs
#    * def nowISODate =        call fnGetISODate           nowMs
#    * def nowEpochTimeMs =    call fnGetEpochTimeMs       nowISODate
#
#    * def nowISODateLocTzo =  call fnToISOStringLocTzo    nowMs
#    * def nowISODateLTzoMs =  call fnGetEpochTimeMs       nowISODateLocTzo
#    * def nowISODateLTzoMin = call fnGetTimezoneOffset    nowISODateLocTzo
#
#    * def nowISODateUTCTzo =  call fnToISOStringUTCTzo    nowMs
#    * def nowISODateUTCTzo8 = call fnToISOStringUTCTzo    nowISODateLocTzo
#    * def nowISODateUTzoMs =  call fnGetEpochTimeMs       nowISODateUTCTzo
#    * def nowISODateUTzoMin = call fnGetTimezoneOffset    nowISODateUTCTzo
#
#    * def now000000ISODate =  call fnGetISODateStartOfDay nowMs
#    * def now235959ISODate =  call fnGetISODateEndOfDay   nowMs
#
#    * def nowStartISODate4 =  fnAbbrevISODateTzo( fnConvertISODateTzoToGivenTzo( now000000ISODate, "+0800" ) )
#    * def nowEndISODate4 =    fnAbbrevISODateTzo( fnConvertISODateTzoToGivenTzo( now235959ISODate, "+0800" ) )
#
#    * def nowISODateAsUTC =   call fnCreateDateAsUTC      nowMs
#    * def nowISODateToUTC =   call fnConvertDateToUTC     nowMs
#
#    And match nowISODate ==   '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'
#
#
#    * def requestBody_createContact =
#      """
#          {
#            "parent": "#(thirdPartyId)",
#            "title": "Mr.",
#            "firstName": "John",
#            "middleName": "Van",
#            "lastName": "Smith",
#            "personalDetails": {
#              "nationality": "US",
#              "placeOfBirth": "US"
#            },
#            "addresses": [
#              {
#                "addressLine": "Address Line 1",
#                "city": "City 1",
#                "country": "US",
#                "postalCode": "31080",
#                "province": "Province 1",
#                "region": "#(region)"
#              }
#            ],
#            "contactInformation": {
#              "email": [
#                "john.smith1234#company1.com"
#              ],
#              "fax": [
#                "+91 (123) XYZ-7890"
#              ],
#              "phoneNumber": [
#                "123-XYZ-7890"
#              ],
#              "website": [
#                "http:\\www.company1.com"
#              ]
#            },
#            "description": "This is contact's description",
#            "otherNames": [
#            ],
#            "isActive": false,
#            "isPrincipal": false,
#            "autoScreen": false
#          }
#      """
#
#    Given url postUrl = baseTestUrl
#    And path 'contacts'
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    And request requestBody_createContact
#    When method POST
#    Then status 400
#
#    * def requestBadFields = [ "contactInformation.email" ]
#    * def responseBadFields = get response.errors[*].field
#
#    And match responseBadFields contains only requestBadFields
#
#
#
##
## VALIDATE ERROR response body SCHEMA
##
#    And match response ==
#          """
#              {
#                  "errors": '##[] ^^ {
#                                         "field":       "#? requestBadFields.contains(_)",
#                                         "code":        "SI-ERR-003",
#                                         "description": "##regex ^.*[(is not valid.)]$"
#                                     }'
#              }
#          """
#
#
#
##
## DELETE PARENT third-party by id
##
#    Given url deleteUrl = baseTestUrl
#    And path 'thirdparty', thirdPartyId
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method DELETE
#    Then status 204
#
#
#
##
## CHECK: Retrieve PARENT third-party BY ID - expected: NOT FOUND
##
#    Given url getUrl = baseTestUrl
#    And path 'thirdparty', thirdPartyId
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method GET
#    Then status 404



#  Scenario: 7) C36263212 Public API - POST /contacts
#               - Verify error for invalid values in data parameter
#
##
## CREATE PARENT third-party PARENT of new contact
##
#
#    * def requestBody_createThirdParty =
#      """
#          {
#            "referenceNo": null,
#            "name": "ABC Corp",
#            "currency": "USD",
#            "companyType": "CORP",
#            "industryType": "AHI",
#            "organizationSize": "11-50",
#            "businessType": "PRS",
#            "incorporationDate": "2021-06-18T05:32:07-0800",
#            "revenue": "10M",
#            "responsibleParty": "rddcentre.admin.np@refinitiv.com",
#            "liquidationDate": "2021-06-18T05:32:07-0800",
#            "divisions": [
#              "MyDivision"
#            ],
#            "affiliation": "SOE",
#            "workflowGroupId": "#(workflowGroupId)",
#            "spendCategory": "OTS",
#            "sourcingMethod": "DIST_M_SRC",
#            "productDesignAgreement": "OTS",
#            "sourcingType": "MULTI",
#            "relationshipVisibility": "LITTLE_VIS",
#            "productImpact": "COMMODITIZED_PRODUCT",
#            "commodityType": "A3P",
#            "address": {
#              "addressLine": "Address Line 1",
#              "city": "City 1",
#              "country": "US",
#              "postalCode": "31080",
#              "province": "Province 1",
#              "region": "#(region)"
#            },
#            "contactInformation": {
#              "email": [
#                "john.smith@company1.com"
#              ],
#              "fax": [
#                "+91 (123) 456-7890"
#              ],
#              "phoneNumber": [
#                "123-456-7890"
#              ],
#              "website": [
#                "http://www.company1.com"
#              ]
#            },
#            "description": "This is supplier description",
#            "customFields": [],
#            "bankDetails": [
#              {
#                "accountNo": "111-11111111-1",
#                "addressLine": "Address 1",
#                "branchName": "Branch Name",
#                "city": "City 1",
#                "country": "US",
#                "name": "Bank Name"
#              }
#            ],
#            "otherNames": [
#            ]
#          }
#      """
#
#    Given url postUrl = baseTestUrl
#    And path 'thirdparty'
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    And request requestBody_createThirdParty
#    When method POST
#    Then status 201
#
#    * def thirdPartyId = response.data.id
#
#
#
##
## CHECK: Retrieve PARENT third-party BY ID - expected: FOUND
##
#    Given url getUrl = baseTestUrl
#    And path 'thirdparty', thirdPartyId
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method GET
#    Then status 200
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
#    And print '******** CREATE CONTACT: CREATE & RETRIEVE (PARENT) THIRD-PARTY BY ID'
#    And print '******** thirdPartyId       = '+ thirdPartyId
#    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
#    And print '******** ETag               = '+ eTag
#    And print '================================\n'
#    And print '\n'
#
#
#
##
## CREATE contact
##
#
#    * def nowMs =             call fnGetNowMs
#    * def nowISODate =        call fnGetISODate           nowMs
#    * def nowEpochTimeMs =    call fnGetEpochTimeMs       nowISODate
#
#    * def nowISODateLocTzo =  call fnToISOStringLocTzo    nowMs
#    * def nowISODateLTzoMs =  call fnGetEpochTimeMs       nowISODateLocTzo
#    * def nowISODateLTzoMin = call fnGetTimezoneOffset    nowISODateLocTzo
#
#    * def nowISODateUTCTzo =  call fnToISOStringUTCTzo    nowMs
#    * def nowISODateUTCTzo8 = call fnToISOStringUTCTzo    nowISODateLocTzo
#    * def nowISODateUTzoMs =  call fnGetEpochTimeMs       nowISODateUTCTzo
#    * def nowISODateUTzoMin = call fnGetTimezoneOffset    nowISODateUTCTzo
#
#    * def now000000ISODate =  call fnGetISODateStartOfDay nowMs
#    * def now235959ISODate =  call fnGetISODateEndOfDay   nowMs
#
#    * def nowStartISODate4 =  fnAbbrevISODateTzo( fnConvertISODateTzoToGivenTzo( now000000ISODate, "+0800" ) )
#    * def nowEndISODate4 =    fnAbbrevISODateTzo( fnConvertISODateTzoToGivenTzo( now235959ISODate, "+0800" ) )
#
#    * def nowISODateAsUTC =   call fnCreateDateAsUTC      nowMs
#    * def nowISODateToUTC =   call fnConvertDateToUTC     nowMs
#
#    And match nowISODate ==   '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'
#
#
#    * def requestBody_createContact =
#      """
#          {
#            "parent": "#(thirdPartyId)",
#            "title": "Mrx.",
#            "firstName": "John",
#            "middleName": "Van",
#            "lastName": "Smith",
#            "personalDetails": {
#              "nationality": "USX",
#              "placeOfBirth": "USX"
#            },
#            "addresses": [
#              {
#                "addressLine": "Address Line 1",
#                "city": "City 1",
#                "country": "USXX",
#                "postalCode": "31080",
#                "province": "Province 1",
#                "region": "#('XX'+ regionX)"
#              }
#            ],
#            "contactInformation": {
#              "email": [
#                "john.smith1234#company1.com"
#              ],
#              "fax": [
#                "+91 (123) XYZ-7890"
#              ],
#              "phoneNumber": [
#                "123-XYZ-7890"
#              ],
#              "website": [
#                "http:\\www.company1.com"
#              ]
#            },
#            "description": "This is contact's description",
#            "otherNames": [
#              {
#                "countryOfRegistration": "US",
#                "iwNameType": "Also Known AsX",
#                "name": "Local NameX"
#              }
#            ],
#            "isActive": false,
#            "isPrincipal": false,
#            "autoScreen": false
#          }
#      """
#
#    Given url postUrl = baseTestUrl
#    And path 'contacts'
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    And request requestBody_createContact
#    When method POST
#    Then status 400
#
#    * def requestBadFields = [ "contactInformation.email","personalDetails.placeOfBirth","personalDetails.nationality","otherNames[0].iwNameType","addresses[0].region","addresses[0].country","addresses[0].country" ]
##    * def requestBadFields = [ "contactInformation.email","personalDetails.placeOfBirth", "personalDetails.nationality", "otherNames[0].iwNameType", ]
#    * def responseBadFields = get response.errors[*].field
#
#    And match responseBadFields contains only requestBadFields
#
#
#
##
## VALIDATE ERROR response body SCHEMA
##
#    And match response ==
#          """
#              {
#                  "errors": '##[] ^^ {
#                                         "field":       "#? requestBadFields.contains(_)",
#                                         "code":        "##regex ^.*[(SI\-ERR\-003)|(SI\-ERR\-006)]$",
#                                         "description": "##regex ^.*[(is not valid.)|(did not match!)]$"
#                                     }'
#              }
#          """
#
#
#
##
## DELETE PARENT third-party by id
##
#    Given url deleteUrl = baseTestUrl
#    And path 'thirdparty', thirdPartyId
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method DELETE
#    Then status 204
#
#
#
##
## CHECK: Retrieve PARENT third-party BY ID - expected: NOT FOUND
##
#    Given url getUrl = baseTestUrl
#    And path 'thirdparty', thirdPartyId
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    When method GET
#    Then status 404





  Scenario: 8) C36263213 Public API - POST /contacts
               - Verify error validation for fields with maximum character limitations

#
# CREATE PARENT third-party PARENT of new contact
#

    * def requestBody_createThirdParty =
      """
          {
            "referenceNo": null,
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



#
# CHECK: Retrieve PARENT third-party BY ID - expected: FOUND
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
    And print '******** CREATE CONTACT: CREATE & RETRIEVE (PARENT) THIRD-PARTY BY ID'
    And print '******** thirdPartyId       = '+ thirdPartyId
    And print '******** thirdPartyIdResult = '+ thirdPartyIdResult
    And print '******** ETag               = '+ eTag
    And print '================================\n'
    And print '\n'



#
# CREATE contact #1: MAXIMUM character limitations
#

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

    * def requestBody_createContact =
      """
          {
            "parent": "#(thirdPartyId)",
            "title": "1234567890123456789012345678901234567890123456789012345678901234",
            "firstName": "1234567890123456789012345678901234567890123456789012345678901234",
            "middleName": "1234567890123456789012345678901234567890123456789012345678901234",
            "lastName": "1234567890123456789012345678901234567890123456789012345678901234",
            "personalDetails": {
              "nationality": "US",
              "placeOfBirth": "US"
            },
            "addresses": [
              {
                "addressLine": "1234567890123456789012345678901234567890123456789012345678901234",
                "city": "1234567890123456789012345678901234567890123456789012345678901234",
                "country": "US",
                "postalCode": "1234567890123456789012345678901234567890123456789012345678901234",
                "province": "1234567890123456789012345678901234567890123456789012345678901234",
                "region": "#(region)"
              }
            ],
            "contactInformation": {
              "email": [
                "1234567890@2345678901234567890123456789012345678901234567890.com",
                "john.smith@company1.com"
              ],
              "fax": [
                "1234567890123456789012345678901234567890123456789012345678901234"
              ],
              "phoneNumber": [
                "1234567890123456789012345678901234567890123456789012345678901234"
              ],
              "website": [
                "http://www.2345678901234567890123456789012345678901234567890.com",
                "http://www.company1.com"
              ]
            },
            "description": "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234",
            "otherNames": [
            ],
            "isActive": false,
            "isPrincipal": false,
            "autoScreen": false
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

    * def createDateResp =    response.data.createTime
    And match createDateResp ==  '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'

    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: CREATE CONTACT'
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
    And print '******** CREATED: contactId         = '+ contactId
    And print '********        : createDateResp    = '+ createDateResp
    And print '================================\n'
    And print '\n'



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
#                              "customFields":           '##[] ^ {
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
#                              "createTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#                              "updateTime":             '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$',
#                           }
#              }
#          """



#
# CHECK: Retrieve contact BY ID - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts', contactId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200



    * def contactIdResult = response.data.id
    And match contactId == contactIdResult



    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: RETRIEVE CONTACT BY ID'
    And print '******** contactId       = '+ contactId
    And print '******** contactIdResult = '+ contactIdResult
    And print '******** ETag            = '+ eTag
    And print '================================\n'
    And print '\n'



#
# TODO: Validate response body schema: NO NEED?
#



#
# CHECK: Get contacts LIST for this day - expected: FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts'
    And param pageSize =       400
    And param start =          nowStartISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def contactIds = get response.data[*].id
    And assert contactIds.contains( contactId )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: RETRIEVE CONTACTS LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** contactId          = '+ contactId
    And print '******** contactIds         = '+ contactIds
    And print '================================\n'
    And print '\n'



#
# CREATE contact #2: EXCEEDS MAXIMUM character limitations
#

    * def requestBody_createContact =
      """
          {
            "parent": "#(thirdPartyId)",
            "title": "12345678901234567890123456789012345678901234567890123456789012345",
            "firstName": "12345678901234567890123456789012345678901234567890123456789012345",
            "middleName": "12345678901234567890123456789012345678901234567890123456789012345",
            "lastName": "12345678901234567890123456789012345678901234567890123456789012345",
            "personalDetails": {
              "nationality": "US",
              "placeOfBirth": "US"
            },
            "addresses": [
              {
                "addressLine": "12345678901234567890123456789012345678901234567890123456789012345",
                "city": "12345678901234567890123456789012345678901234567890123456789012345",
                "country": "US",
                "postalCode": "12345678901234567890123456789012345678901234567890123456789012345",
                "province": "12345678901234567890123456789012345678901234567890123456789012345",
                "region": "#(region)"
              }
            ],
            "contactInformation": {
              "email": [
                "1234567890@23456789012345678901234567890123456789012345678901.com",
                "john.smith@company1.com"
              ],
              "fax": [
                "12345678901234567890123456789012345678901234567890123456789012345"
              ],
              "phoneNumber": [
                "12345678901234567890123456789012345678901234567890123456789012345"
              ],
              "website": [
                "http://www.23456789012345678901234567890123456789012345678901.com",
                "http://www.company1.com"
              ]
            },
            "description": "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345",
            "otherNames": [
            ],
            "isActive": false,
            "isPrincipal": false,
            "autoScreen": false
          }
      """

    Given url postUrl = baseTestUrl
    And path 'contacts'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_createContact
    When method POST
    Then status 400

    * def requestBadFields = [ "title", "lastName", "firstName", "middleName", "description", "addresses[0].addressLine", "addresses[0].city", "addresses[0].province", "addresses[0].postalCode", "contactInformation.email[0]", "contactInformation.website[0]", "contactInformation.fax[0]", "contactInformation.phoneNumber[0]"      ]
    * def responseBadFields = get response.errors[*].field

    And match responseBadFields contains only requestBadFields



#
# VALIDATE ERROR response body SCHEMA
#
    And match response ==
          """
                {
                    "errors": '##[] ^^ {
                                         "field":       "#? requestBadFields.contains(_)",
                                         "code":        "SI-ERR-002",
                                         "description": "##regex ^.*[(should not exceed the maximum length!)]$"
                                       }'

                }

          """



#
# DELETE contact #1 by id
#
    Given url deleteUrl = baseTestUrl
    And path 'contacts', contactIdResult
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204



#
# CHECK: Retrieve contact #1 BY ID - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts', contactIdResult
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 404



#
# CHECK: Get contacts LIST for this day - expected: contact #1 NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'contacts'
    And param pageSize =       400
    And param start =          nowStartISODate4
    And param end =            nowEndISODate4
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

    * def contactIds = get response.data[*].id
#    And assert !contactIds.contains( contactId )

    * def count = response.data.length
    And print '\n'
    And print '================================'
    And print '******** CREATE CONTACT: RETRIEVE CONTACTS LIST'
    And print '******** COUNT: data.length = '+ count
    And print '******** contactId          = '+ contactId
    And print '******** contactIds         = '+ contactIds
    And print '================================\n'
    And print '\n'



#
# DELETE PARENT third-party by id
#
    Given url deleteUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204



#
# CHECK: Retrieve PARENT third-party BY ID - expected: NOT FOUND
#
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 404






  Scenario: 9) C36263214 Public API - POST /contacts
               - Verify error if Supplier ID does not exist
#
# CREATE contact
#



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

    And match nowISODate ==      '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'

    * def requestBody_createContact =
      """
          {
            "parent": "#(''+ nowMs)",
            "title": "Mr.",
            "firstName": "John",
            "middleName": "Van",
            "lastName": "Smith",
            "personalDetails": {
              "nationality": "US",
              "placeOfBirth": "US"
            },
            "addresses": [
              {
                "addressLine": "Address Line 1",
                "city": "City 1",
                "country": "US",
                "postalCode": "31080",
                "province": "Province 1",
                "region": "#(region)"
              }
            ],
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
            "description": "This is contact's description",
            "otherNames": [
            ],
            "isActive": false,
            "isPrincipal": false,
            "autoScreen": false
          }
      """

    Given url postUrl = baseTestUrl
    And path 'contacts'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_createContact
    When method POST
    Then status 400

    * def requestBadFields = [ "parent" ]
    * def responseBadFields = get response.errors[*].field

    And match responseBadFields contains only requestBadFields



#
# VALIDATE ERROR response body SCHEMA
#
    And match response ==
          """
                {
                    "errors": '##[] ^^ {
                                         "field":       "#? requestBadFields.contains(_)",
                                         "code":        "SI-ERR-003",
                                         "description": "##regex ^.*[(is not valid.)]$"
                                       }'

                }

          """



