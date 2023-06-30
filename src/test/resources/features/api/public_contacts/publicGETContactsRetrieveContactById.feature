@api @public_api @getPublicContactsRetrieveSupplierContactById
Feature: Get Supplier Contact By Id



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

    And match nowISODate ==      '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'


#    * def createDateResp =       response.data.createTime
#    And match createDateResp ==  '#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$'



    * configure logPrettyResponse = true




  Scenario: 1) C36263215 Public API - GET/contacts/{id}
               - Verify that user can retrieve Contact details by ID

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
    And print '******** RETRIEVE CONTACT BY ID: CREATE & RETRIEVE (PARENT) THIRD-PARTY BY ID'
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

    And print '\n'
    And print '================================'
    And print '******** RETRIEVE CONTACT BY ID: CREATE CONTACT'
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
#    And print '********        : createDateResp    = '+ createDateResp
    And print '================================\n'
    And print '\n'



#
# Get Supplier Contact
#



#
# Retrieve Contact by id
#
    Given url getUrl = baseTestUrl
    And path 'contacts', contactId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200



    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** RETRIEVE SUPPLIER CONTACT BY ID'
    And print '******** contactId = '+ contactId
    And print '******** ETag      = '+ eTag
    And print '================================\n'
    And print '\n'



#
# VALIDATE RESPONSE body json SCHEMA
#
    And match response ==
          """
            {
              message:  '##string',
              data:     {
                            parent:             '##string',
                            id:                 '##string',
                            title:              '##string',
                            firstName:          '##string',
                            middleName:         '##string',
                            lastName:           '##string',
                            personalDetails:    '##object',
                            addresses:          '##[]',
                            description:        '##string',
                            otherNames:         '##[] ^^ {
                                                           nationality:           "##string",
                                                           countryOfBirth:        "##string",
                                                           countryOfLocation:     "##string",
                                                           countryOfRegistration: "##string",
                                                           iwNameType:            "##string",
                                                           name:                  "##string",
                                                         }',
                            contactInformation: {
                                                  email:       '##[] #string',
                                                  fax:         '##[] #string',
                                                  phoneNumber: '##[] #string',
                                                  website:     '##[] #string',
                                                },
                            isActive:           '##boolean',
                            isPrincipal:        '##boolean',
                            autoScreen:         '##boolean',
                            position:           '##string',
                            screeningStatus:    '##string',
                            relationshipInfo:   '##string',
                            createTime:         '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}[.][0-9]{3}(Z|[+-][0-9]{2}:[0-9]{2})$',
                            updateTime:         '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}[.][0-9]{3}(Z|[+-][0-9]{2}:[0-9]{2})$',
                          }
            }
          """



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
    And path 'contacts', contactId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204



#
# CHECK: Retrieve contact BY ID - expected: NOT FOUND
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
# Uncomment the ff. line when fixed:
#
#    And assert !contactIds.contains( contactId )



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






  Scenario: 2) C36263216 Public API - GET/contacts/{id}
               - Populate etag in If-None-Match Parameter
               - Verify Response Code 304 if not modified


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
    And print '******** RETRIEVE CONTACT BY ID: CREATE & RETRIEVE (PARENT) THIRD-PARTY BY ID'
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

    And print '\n'
    And print '================================'
    And print '******** RETRIEVE CONTACT BY ID: CREATE CONTACT'
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
#    And print '********        : createDateResp    = '+ createDateResp
    And print '================================\n'
    And print '\n'



#
# Get Supplier Contact
#



#
# Retrieve Contact by id
#
    Given url getUrl = baseTestUrl
    And path 'contacts', contactId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200



    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** RETRIEVE SUPPLIER CONTACT BY ID'
    And print '******** contactId = '+ contactId
    And print '******** ETag      = '+ eTag
    And print '================================\n'
    And print '\n'



#
# VALIDATE RESPONSE body json SCHEMA
#
    And match response ==
          """
            {
              message:  '##string',
              data:     {
                            parent:             '##string',
                            id:                 '##string',
                            title:              '##string',
                            firstName:          '##string',
                            middleName:         '##string',
                            lastName:           '##string',
                            personalDetails:    '##object',
                            addresses:          '##[]',
                            description:        '##string',
                            otherNames:         '##[] ^^ {
                                                           nationality:           "##string",
                                                           countryOfBirth:        "##string",
                                                           countryOfLocation:     "##string",
                                                           countryOfRegistration: "##string",
                                                           iwNameType:            "##string",
                                                           name:                  "##string",
                                                         }',
                            contactInformation: {
                                                  email:       '##[] #string',
                                                  fax:         '##[] #string',
                                                  phoneNumber: '##[] #string',
                                                  website:     '##[] #string',
                                                },
                            isActive:           '##boolean',
                            isPrincipal:        '##boolean',
                            autoScreen:         '##boolean',
                            position:           '##string',
                            screeningStatus:    '##string',
                            relationshipInfo:   '##string',
                            createTime:         '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}[.][0-9]{3}(Z|[+-][0-9]{2}:[0-9]{2})$',
                            updateTime:         '##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}[.][0-9]{3}(Z|[+-][0-9]{2}:[0-9]{2})$',
                          }
            }
          """



#
# Retrieve Contact by id: with 'ETag'
#

    Given url getUrl = baseTestUrl
    And path 'contacts', contactId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header If-None-Match = eTag
    When method GET
    Then status 304



    And print '\n'
    And print '================================'
    And print '******** RETRIEVE SUPPLIER CONTACT BY ID: ETAG'
    And print '******** contactId = '+ contactId
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
    And path 'contacts', contactId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204



#
# CHECK: Retrieve contact BY ID - expected: NOT FOUND
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
# Uncomment the ff. line when fixed:
#
#    And assert !contactIds.contains( contactId )



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











  Scenario: 3) C36263218 Public API - GET/contacts/{id}
               - Verify that Response Code is 404 if invalid contact id is populated in id parameter

#
# Retrieve Contact by id: INVALID contact id
#
    * def nowMs = call fnGetNowMs

    Given url getUrl = baseTestUrl
    And path 'contacts', nowMs
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 404



#
# VALIDATE RESPONSE body json SCHEMA
#
    And match response ==
          """
            {
              message:  'Contact doesn’t exist.'
            }
          """




  Scenario: 4) C36263217 Public API - GET/contacts/{id}
               - Verify that specific fields are displayed when 'field' parameter is populated

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
    And print '******** RETRIEVE CONTACT BY ID: CREATE & RETRIEVE (PARENT) THIRD-PARTY BY ID'
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

    And print '\n'
    And print '================================'
    And print '******** RETRIEVE CONTACT BY ID: CREATE CONTACT'
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
#    And print '********        : createDateResp    = '+ createDateResp
    And print '================================\n'
    And print '\n'



#
# Get Supplier Contact
#



#
# Retrieve Contact by id
#
    Given url getUrl = baseTestUrl
    And path 'contacts', contactId
    And param fields = 'data.firstName, data.lastName, data.addresses'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200



    * def eTag = responseHeaders['ETag'][0].split('"')[1]
    And print '\n'
    And print '================================'
    And print '******** RETRIEVE SUPPLIER CONTACT BY ID: FIELDS'
    And print '******** contactId = '+ contactId
    And print '******** ETag      = '+ eTag
    And print '================================\n'
    And print '\n'



#
# VALIDATE RESPONSE body json SCHEMA
#
    And match response ==
          """
            {
              data:     {
                            firstName:          '#string',
                            lastName:           '#string',
                            addresses:          '#[] #object',
                        }
            }
          """



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
    And path 'contacts', contactId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method DELETE
    Then status 204



#
# CHECK: Retrieve contact BY ID - expected: NOT FOUND
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
# Uncomment the ff. line when fixed:
#
#    And assert !contactIds.contains( contactId )



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



