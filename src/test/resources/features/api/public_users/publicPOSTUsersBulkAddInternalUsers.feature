@api @public_api @postPublicUsersBulkAddInternalUsers
Feature: Bulk Add Internal Users



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


    * configure logPrettyResponse = true



  Scenario: 1) C36509266 Public API - POST/users/bulk
               - Verify that users are created

    * def nowMs = call fnGetNowMs


#
# BULK-CREATE internal users
#

    * def requestBody_bulkCreateInternalUsers =
      """
        [
          {
            "firstName":              "John 'TEST BULK ADD USERS'",
            "lastName":               "Smith",
            "email":                  "#('john.smith-'+ nowMs +'@refinitiv.com')",
            "isActive":               true,
            "enabledSso":             true,
            "position":               "Operation Manager",
            "roleId":                 "#(publicUsersRoleId)",
            "groupId":                "#(publicUsersGroupId)",
            "superiorId":             "#(publicUsersSuperiorId)",
            "divisions":              [
                                        "MyDivision"
                                      ],
            "entityId":               "#(publicUsersEntityId)",
            "departmentId":           "#(publicUsersDepartmentId)",
            "externalOrganizationId": "#(publicUsersExternalOrganizationId)",
            "billingEntityId":        "#(publicUsersBillingEntityId)"
          }
        ]
      """

    Given url postUrl = baseTestUrl
    And path 'users/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_bulkCreateInternalUsers
    When method POST
    Then status 207


#
# VALIDATE response body SCHEMA
#

    And match response ==
          """
            {
              "data": '##[]  ^  {
                                  "index":      "#number",
                                  "message":    "User Created.",
                                  "resource": {
                                                  "id":       "#string",
                                                  "username": "#(\'john.smith-\'+ nowMs +\'@refinitiv.com\')"
                                  },
                                  "errors":     null,
                                  "status":     201
                                }'
            }
          """

    And print '\n'
    And print '================================'
    And print '******** BULK CREATE INTERNAL USERS'
    And print '******** 1) USER CREATED SUCCESSFULLY'
    And print '================================\n'
    And print '\n'



  Scenario: 2) C36509267 Public API - POST/users/bulk
               - Verify SSO status of created users

    * def nowMs = call fnGetNowMs

#
# BULK-CREATE internal users
#

    * def requestBody_bulkCreateInternalUsers =
      """
        [
          {
            "firstName":              "John 'TEST BULK ADD USERS'",
            "lastName":               "Smith",
            "email":                  "#('john.smith-'+ nowMs +'@refinitiv.com')",
            "isActive":               true,
            "enabledSso":             true,
            "position":               "Operation Manager",
            "roleId":                 "#(publicUsersRoleId)",
            "groupId":                "#(publicUsersGroupId)",
            "superiorId":             "#(publicUsersSuperiorId)",
            "divisions":              [
                                        "MyDivision"
                                      ],
            "entityId":               "#(publicUsersEntityId)",
            "departmentId":           "#(publicUsersDepartmentId)",
            "externalOrganizationId": "#(publicUsersExternalOrganizationId)",
            "billingEntityId":        "#(publicUsersBillingEntityId)"
          }
        ]
      """

    Given url postUrl = baseTestUrl
    And path 'users/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_bulkCreateInternalUsers
    When method POST
    Then status 207


#
# VALIDATE response body SCHEMA
#

    And match response ==
          """
            {
              "data": '##[]  ^  {
                                  "index":      "#number",
                                  "message":    "User Created.",
                                  "resource": {
                                                  "id":       "#string",
                                                  "username": "#(\'john.smith-\'+ nowMs +\'@refinitiv.com\')"
                                  },
                                  "errors":     null,
                                  "status":     201
                                }'
            }
          """


    * def nowMs = call fnGetNowMs

#
# BULK-CREATE internal users
#

    * def requestBody_bulkCreateInternalUsers =
      """
        [
          {
            "firstName":              "John 'TEST BULK ADD USERS'",
            "lastName":               "Smith",
            "email":                  "#('john.smith-'+ nowMs +'@refinitiv.com')",
            "isActive":               true,
            "enabledSso":             false,
            "position":               "Operation Manager",
            "roleId":                 "#(publicUsersRoleId)",
            "groupId":                "#(publicUsersGroupId)",
            "superiorId":             "#(publicUsersSuperiorId)",
            "divisions":              [
                                        "MyDivision"
                                      ],
            "entityId":               "#(publicUsersEntityId)",
            "departmentId":           "#(publicUsersDepartmentId)",
            "externalOrganizationId": "#(publicUsersExternalOrganizationId)",
            "billingEntityId":        "#(publicUsersBillingEntityId)"
          }
        ]
      """

    Given url postUrl = baseTestUrl
    And path 'users/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_bulkCreateInternalUsers
    When method POST
    Then status 207


#
# VALIDATE response body SCHEMA
#

    And match response ==
          """
            {
              "data": '##[]  ^  {
                                  "index":      "#number",
                                  "message":    "User Created.",
                                  "resource": {
                                                  "id":       "#string",
                                                  "username": "#(\'john.smith-\'+ nowMs +\'@refinitiv.com\')"
                                  },
                                  "errors":     null,
                                  "status":     201
                                }'
            }
          """

    And print '\n'
    And print '================================'
    And print '******** BULK CREATE INTERNAL USERS'
    And print '******** 2) ENABLEDSSO TRUE/FALSE'
    And print '================================\n'
    And print '\n'



  Scenario: 3) C36509268 Public API - POST/users/bulk
               - Verify users with or without User Group

    * def nowMs = call fnGetNowMs


#
# BULK-CREATE internal users
#

    * def requestBody_bulkCreateInternalUsers =
      """
        [
          {
            "firstName":              "John 'TEST BULK ADD USERS'",
            "lastName":               "Smith",
            "email":                  "#('john.smith-'+ nowMs +'@refinitiv.com')",
            "isActive":               true,
            "enabledSso":             true,
            "position":               "Operation Manager",
            "roleId":                 "#(publicUsersRoleId)",
            "groupId":                null,
            "superiorId":             "#(publicUsersSuperiorId)",
            "divisions":              [
                                        "MyDivision"
                                      ],
            "entityId":               "#(publicUsersEntityId)",
            "departmentId":           "#(publicUsersDepartmentId)",
            "externalOrganizationId": "#(publicUsersExternalOrganizationId)",
            "billingEntityId":        "#(publicUsersBillingEntityId)"
          }
        ]
      """

    Given url postUrl = baseTestUrl
    And path 'users/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_bulkCreateInternalUsers
    When method POST
    Then status 207


#
# VALIDATE response body SCHEMA
#

    And match response ==
          """
            {
              "data": '##[]  ^  {
                                  "index":      "#number",
                                  "message":    "User Created.",
                                  "resource": {
                                                  "id":       "#string",
                                                  "username": "#(\'john.smith-\'+ nowMs +\'@refinitiv.com\')"
                                  },
                                  "errors":     null,
                                  "status":     201
                                }'
            }
          """

    And print '\n'
    And print '================================'
    And print '******** BULK CREATE INTERNAL USERS'
    And print '******** 3) USER WITHOUT USER GROUP'
    And print '================================\n'
    And print '\n'



  Scenario: 4) C36509269 Public API - POST/users/bulk
               - Create users with billing entity

    * def nowMs = call fnGetNowMs


#
# BULK-CREATE internal users
#

    * def requestBody_bulkCreateInternalUsers =
      """
        [
          {
            "firstName":              "John 'TEST BULK ADD USERS'",
            "lastName":               "Smith",
            "email":                  "#('john.smith-'+ nowMs +'@refinitiv.com')",
            "isActive":               true,
            "enabledSso":             true,
            "position":               "Operation Manager",
            "roleId":                 "#(publicUsersRoleId)",
            "groupId":                "#(publicUsersGroupId)",
            "superiorId":             "#(publicUsersSuperiorId)",
            "divisions":              [
                                        "MyDivision"
                                      ],
            "entityId":               "#(publicUsersEntityId)",
            "departmentId":           "#(publicUsersDepartmentId)",
            "externalOrganizationId": "#(publicUsersExternalOrganizationId)",
            "billingEntityId":        "#(publicUsersBillingEntityId)"
          }
        ]
      """

    Given url postUrl = baseTestUrl
    And path 'users/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_bulkCreateInternalUsers
    When method POST
    Then status 207


#
# VALIDATE response body SCHEMA
#

    And match response ==
          """
            {
              "data": '##[]  ^  {
                                  "index":      "#number",
                                  "message":    "User Created.",
                                  "resource": {
                                                  "id":       "#string",
                                                  "username": "#(\'john.smith-\'+ nowMs +\'@refinitiv.com\')"
                                  },
                                  "errors":     null,
                                  "status":     201
                                }'
            }
          """

    And print '\n'
    And print '================================'
    And print '******** BULK CREATE INTERNAL USERS'
    And print '******** 4) WITH BILLING ENTITY'
    And print '================================\n'
    And print '\n'



  Scenario: 5) C36509270 Public API - POST/users/bulk
               - Create users without billing entity

    * def nowMs = call fnGetNowMs


    * configure ssl = true


#
# Get INITIAL value of 'billToEntity', 'purchaseOrderNumber'
#

    Given url getUrl =        billToEntityUrl
#    Given url getUrl =        'https://siconnect.qa-sprint2.supplierintegrity.com/api/v1/integraCheckOrder/customField'
#    Given url getUrl =        'https://siconnect.qa-regression.supplierintegrity.com/api/v1/integraCheckOrder/customField'
    And header x-tenant-code =  xTenantCode
    And header X-Tenant-Code =  xTenantCode
    And header Authorization =  'Bearer '+ accessToken
    And header requestor =      'rddcentre.admin.np@refinitiv.com'
    And header requestorEmail = 'rddcentre.admin.np@refinitiv.com'
    And header accept =         'application/json'
    And header Content-Type =   'application/vnd.internal.app+json'
    When method GET
    Then status 200

#    Then print response

    * def billToEntity =        response.billToEntity
    * def purchaseOrderNumber = response.purchaseOrderNumber

    And print '\n'
    And print '================================'
    And print '******** BULK CREATE INTERNAL USERS'
    And print '******** INITIAL: billToEntity        = '+ billToEntity
    And print '********          purchaseOrderNumber = '+ purchaseOrderNumber
    And print '================================\n'
    And print '\n'


#
# Set 'billToEntity' to TRUE
#

    * def billingEntity_requestBody =
      """
        {
            'billToEntity'        : true,
            'purchaseOrderNumber' : '#(purchaseOrderNumber)'
        }
      """

    Given url postUrl =        billToEntityUrl
#    Given url postUrl =        'https://siconnect.qa-sprint2.supplierintegrity.com/api/v1/integraCheckOrder/customField'
#    Given url postUrl =        'https://siconnect.qa-regression.supplierintegrity.com/api/v1/integraCheckOrder/customField'
    And header x-tenant-code = xTenantCode
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header requestor =          'rddcentre.admin.np@refinitiv.com'
    And header requestorEmail =     'rddcentre.admin.np@refinitiv.com'
    And header accept =             'application/json'
    And header Content-Type =       'application/vnd.internal.app+json'
    And request billingEntity_requestBody
    When method POST
    Then status 200

#    Then print response


#
# BULK-CREATE internal users
#

    * def requestBody_bulkCreateInternalUsers =
      """
        [
          {
            "firstName":              "John 'TEST BULK ADD USERS'",
            "lastName":               "Smith",
            "email":                  "#('john.smith-'+ nowMs +'@refinitiv.com')",
            "isActive":               true,
            "enabledSso":             true,
            "position":               "Operation Manager",
            "roleId":                 "#(publicUsersRoleId)",
            "groupId":                "#(publicUsersGroupId)",
            "superiorId":             "#(publicUsersSuperiorId)",
            "divisions":              [
                                        "MyDivision"
                                      ],
            "entityId":               "#(publicUsersEntityId)",
            "departmentId":           "#(publicUsersDepartmentId)",
            "externalOrganizationId": "#(publicUsersExternalOrganizationId)",
            "billingEntityId":        null
          }
        ]
      """

    Given url postUrl = baseTestUrl
    And path 'users/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_bulkCreateInternalUsers
    When method POST
    Then status 207

#    Then print response


#
# VALIDATE response body SCHEMA
#

    And match response ==
          """
            {
              "data": '##[]  ^  {
                                  "index":      "#number",
                                  "message":    "Bad Request.",
                                  "resource":   null,
                                  "errors":     [
                                                  {
                                                    "field":        "billingEntityId",
                                                    "code":         "SI-ERR-005",
                                                    "description":  "billingEntityId is a required field"
                                                  }
                                                ],
                                  "status":     400
                                }'
            }
          """

#    And match response ==
#          """
#            {
#              "data": '##[]  ^  {
#                                  "index":      "#number",
#                                  "message":    "##string",
#                                  "resource":   "##object",
#                                  "errors":     "##[] #object",
#                                  "status":     "#number"
#                                }'
#            }
#          """


#
# Set 'billToEntity' to FALSE
#

    * def billingEntity_requestBody =
      """
        {
            'billToEntity'        : false,
            'purchaseOrderNumber' : '#(purchaseOrderNumber)'
        }
      """

    Given url postUrl =        billToEntityUrl
#    Given url postUrl =        'https://siconnect.qa-sprint2.supplierintegrity.com/api/v1/integraCheckOrder/customField'
#    Given url postUrl =        'https://siconnect.qa-regression.supplierintegrity.com/api/v1/integraCheckOrder/customField'
    And header x-tenant-code = xTenantCode
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header requestor =          'rddcentre.admin.np@refinitiv.com'
    And header requestorEmail =     'rddcentre.admin.np@refinitiv.com'
    And header accept =             'application/json'
    And header Content-Type =       'application/vnd.internal.app+json'
    And request billingEntity_requestBody
    When method POST
    Then status 200

#    Then print response


#
# BULK-CREATE internal users
#

    * def requestBody_bulkCreateInternalUsers =
      """
        [
          {
            "firstName":              "John 'TEST BULK ADD USERS'",
            "lastName":               "Smith",
            "email":                  "#('john.smith-'+ nowMs +'@refinitiv.com')",
            "isActive":               true,
            "enabledSso":             true,
            "position":               "Operation Manager",
            "roleId":                 "#(publicUsersRoleId)",
            "groupId":                "#(publicUsersGroupId)",
            "superiorId":             "#(publicUsersSuperiorId)",
            "divisions":              [
                                        "MyDivision"
                                      ],
            "entityId":               "#(publicUsersEntityId)",
            "departmentId":           "#(publicUsersDepartmentId)",
            "externalOrganizationId": "#(publicUsersExternalOrganizationId)",
            "billingEntityId":        null
          }
        ]
      """

    Given url postUrl = baseTestUrl
    And path 'users/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_bulkCreateInternalUsers
    When method POST
    Then status 207

#    Then print response


#
# VALIDATE response body SCHEMA
#

    And match response ==
          """
            {
              "data": '##[]  ^  {
                                  "index":      "#number",
                                  "message":    "User Created.",
                                  "resource":   {
                                                  "id":       "##string",
                                                  "username": "#(\'john.smith-\'+ nowMs +\'@refinitiv.com\')"
                                                },
                                  "errors":     null,
                                  "status":     201
                                }'
            }
          """

# "username": "##regex ^(john.smith-)[0-9]+(@refinitiv.com)$"

#
# Revert 'billToEntity' to INITIAL value
#

    * def billingEntity_requestBody =
      """
        {
            'billToEntity'        : '#(billToEntity)',
            'purchaseOrderNumber' : '#(purchaseOrderNumber)'
        }
      """

    Given url postUrl =        billToEntityUrl
#    Given url postUrl =        'https://siconnect.qa-sprint2.supplierintegrity.com/api/v1/integraCheckOrder/customField'
#    Given url postUrl =        'https://siconnect.qa-regression.supplierintegrity.com/api/v1/integraCheckOrder/customField'
    And header x-tenant-code = xTenantCode
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header requestor =          'rddcentre.admin.np@refinitiv.com'
    And header requestorEmail =     'rddcentre.admin.np@refinitiv.com'
    And header accept =             'application/json'
    And header Content-Type =       'application/vnd.internal.app+json'
    And request billingEntity_requestBody
    When method POST
    Then status 200

#    Then print response


    And print '\n'
    And print '================================'
    And print '******** BULK CREATE INTERNAL USERS'
    And print '******** 5) WITHOUT BILLING ENTITY'
    And print '================================\n'
    And print '\n'



  Scenario: 6) C36509271 Public API - POST/users/bulk - Billing Entity required
               - Verify error when adding users without billing entity

    * def nowMs = call fnGetNowMs


    * configure ssl = true


#
# Get INITIAL value of 'billToEntity', 'purchaseOrderNumber'
#

    Given url getUrl =        billToEntityUrl
#    Given url getUrl =        'https://siconnect.qa-sprint2.supplierintegrity.com/api/v1/integraCheckOrder/customField'
#    Given url getUrl =        'https://siconnect.qa-regression.supplierintegrity.com/api/v1/integraCheckOrder/customField'
    And header x-tenant-code =  xTenantCode
    And header X-Tenant-Code =  xTenantCode
    And header Authorization =  'Bearer '+ accessToken
    And header requestor =      'rddcentre.admin.np@refinitiv.com'
    And header requestorEmail = 'rddcentre.admin.np@refinitiv.com'
    And header accept =         'application/json'
    And header Content-Type =   'application/vnd.internal.app+json'
    When method GET
    Then status 200

#    Then print response

    * def billToEntity =        response.billToEntity
    * def purchaseOrderNumber = response.purchaseOrderNumber

    And print '\n'
    And print '================================'
    And print '******** BULK CREATE INTERNAL USERS'
    And print '******** INITIAL: billToEntity        = '+ billToEntity
    And print '********          purchaseOrderNumber = '+ purchaseOrderNumber
    And print '================================\n'
    And print '\n'


#
# Set 'billToEntity' to TRUE
#

    * def billingEntity_requestBody =
      """
        {
            'billToEntity'        : true,
            'purchaseOrderNumber' : '#(purchaseOrderNumber)'
        }
      """

    Given url postUrl =        billToEntityUrl
#    Given url postUrl =        'https://siconnect.qa-sprint2.supplierintegrity.com/api/v1/integraCheckOrder/customField'
#    Given url postUrl =        'https://siconnect.qa-regression.supplierintegrity.com/api/v1/integraCheckOrder/customField'
    And header x-tenant-code = xTenantCode
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header requestor =          'rddcentre.admin.np@refinitiv.com'
    And header requestorEmail =     'rddcentre.admin.np@refinitiv.com'
    And header accept =             'application/json'
    And header Content-Type =       'application/vnd.internal.app+json'
    And request billingEntity_requestBody
    When method POST
    Then status 200

#    Then print response


#
# BULK-CREATE internal users
#

    * def requestBody_bulkCreateInternalUsers =
      """
        [
          {
            "firstName":              "John 'TEST BULK ADD USERS'",
            "lastName":               "Smith",
            "email":                  "#('john.smith-'+ nowMs +'@refinitiv.com')",
            "isActive":               true,
            "enabledSso":             true,
            "position":               "Operation Manager",
            "roleId":                 "#(publicUsersRoleId)",
            "groupId":                "#(publicUsersGroupId)",
            "superiorId":             "#(publicUsersSuperiorId)",
            "divisions":              [
                                        "MyDivision"
                                      ],
            "entityId":               "#(publicUsersEntityId)",
            "departmentId":           "#(publicUsersDepartmentId)",
            "externalOrganizationId": "#(publicUsersExternalOrganizationId)",
            "billingEntityId":        null
          }
        ]
      """

    Given url postUrl = baseTestUrl
    And path 'users/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_bulkCreateInternalUsers
    When method POST
    Then status 207

#    Then print response


#
# VALIDATE response body SCHEMA
#

    And match response ==
          """
            {
              "data": '##[]  ^  {
                                  "index":      "#number",
                                  "message":    "Bad Request.",
                                  "resource":   null,
                                  "errors":     [
                                                  {
                                                    "field":        "billingEntityId",
                                                    "code":         "SI-ERR-005",
                                                    "description":  "billingEntityId is a required field"
                                                  }
                                                ],
                                  "status":     400
                                }'
            }
          """

#    And match response ==
#          """
#            {
#              "data": '##[]  ^  {
#                                  "index":      "#number",
#                                  "message":    "##string",
#                                  "resource":   "##object",
#                                  "errors":     "##[] #object",
#                                  "status":     "#number"
#                                }'
#            }
#          """


#
# Set 'billToEntity' to FALSE
#

    * def billingEntity_requestBody =
      """
        {
            'billToEntity'        : false,
            'purchaseOrderNumber' : '#(purchaseOrderNumber)'
        }
      """

    Given url postUrl =        billToEntityUrl
#    Given url postUrl =        'https://siconnect.qa-sprint2.supplierintegrity.com/api/v1/integraCheckOrder/customField'
#    Given url postUrl =        'https://siconnect.qa-regression.supplierintegrity.com/api/v1/integraCheckOrder/customField'
    And header x-tenant-code = xTenantCode
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header requestor =          'rddcentre.admin.np@refinitiv.com'
    And header requestorEmail =     'rddcentre.admin.np@refinitiv.com'
    And header accept =             'application/json'
    And header Content-Type =       'application/vnd.internal.app+json'
    And request billingEntity_requestBody
    When method POST
    Then status 200

#    Then print response


#
# BULK-CREATE internal users
#

    * def requestBody_bulkCreateInternalUsers =
      """
        [
          {
            "firstName":              "John 'TEST BULK ADD USERS'",
            "lastName":               "Smith",
            "email":                  "#('john.smith-'+ nowMs +'@refinitiv.com')",
            "isActive":               true,
            "enabledSso":             true,
            "position":               "Operation Manager",
            "roleId":                 "#(publicUsersRoleId)",
            "groupId":                "#(publicUsersGroupId)",
            "superiorId":             "#(publicUsersSuperiorId)",
            "divisions":              [
                                        "MyDivision"
                                      ],
            "entityId":               "#(publicUsersEntityId)",
            "departmentId":           "#(publicUsersDepartmentId)",
            "externalOrganizationId": "#(publicUsersExternalOrganizationId)",
            "billingEntityId":        null
          }
        ]
      """

    Given url postUrl = baseTestUrl
    And path 'users/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_bulkCreateInternalUsers
    When method POST
    Then status 207

#    Then print response


#
# VALIDATE response body SCHEMA
#

    And match response ==
          """
            {
              "data": '##[]  ^  {
                                  "index":      "#number",
                                  "message":    "User Created.",
                                  "resource":   {
                                                  "id":       "##string",
                                                  "username": "#(\'john.smith-\'+ nowMs +\'@refinitiv.com\')"
                                                },
                                  "errors":     null,
                                  "status":     201
                                }'
            }
          """

#
# Revert 'billToEntity' to INITIAL value
#

    * def billingEntity_requestBody =
      """
        {
            'billToEntity'        : '#(billToEntity)',
            'purchaseOrderNumber' : '#(purchaseOrderNumber)'
        }
      """

    Given url postUrl =        billToEntityUrl
#    Given url postUrl =        'https://siconnect.qa-sprint2.supplierintegrity.com/api/v1/integraCheckOrder/customField'
#    Given url postUrl =        'https://siconnect.qa-regression.supplierintegrity.com/api/v1/integraCheckOrder/customField'
    And header x-tenant-code = xTenantCode
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header requestor =          'rddcentre.admin.np@refinitiv.com'
    And header requestorEmail =     'rddcentre.admin.np@refinitiv.com'
    And header accept =             'application/json'
    And header Content-Type =       'application/vnd.internal.app+json'
    And request billingEntity_requestBody
    When method POST
    Then status 200

#    Then print response

    And print '\n'
    And print '================================'
    And print '******** BULK CREATE INTERNAL USERS'
    And print '******** 6) ERROR: WITHOUT BILLING ENTITY'
    And print '================================\n'
    And print '\n'


#    * def nowMs = call fnGetNowMs
#
#
##    * print '================================'
##    * print '******** accessTokenUrl  = '+ accessTokenUrl
##    * print '================================'
##
##    Given url getUrl = accessTokenUrl
##    And path 'token'
##    And header Authorization =  'Basic ' + headerAuth
##    And header Content-Type =   'application/x-www-form-urlencoded'
##    And form field grant_type = 'client_credentials'
##    When method POST
##    Then status 200
#
#
#    * configure ssl = true
#
#    * def billingEntity_requestBody =
#      """
#        {
#            'billToEntity'        : false,
#            'purchaseOrderNumber' : false
#        }
#      """
#
##    Given url postUrl =        'https://siconnect.qa-regression.supplierintegrity.com/api/v1/integraCheckOrder/customField'
#    Given url postUrl =        'https://siconnect.qa-sprint2.supplierintegrity.com/api/v1/integraCheckOrder/customField'
#
##    Given url postUrl =        'https://qa-sprint2.centre.rdd.refinitiv.com/siconnect/integraCheckOrder/custdomField'
#    And header x-tenant-code = 'qa-sprint2'
#    And header X-Tenant-Code = 'qa-sprint2'
##    And header Authorization = 'Bearer '+ accessToken
#    And header requestor =          'si_admin@yopmail.com'
#    And header requestorEmail =     'si_admin@yopmail.com'
#    And header accept =             'application/json'
#    And header Content-Type =       'application/vnd.internal.app+json'
#
##    And header :authority =         'qa-sprint2.centre.rdd.refinitiv.com'
##    And header :path =              '/siconnect/integraCheckOrder/customField'
##    And header :method =            'POST'
##    And header :scheme =            'https'
##    And header accept =             'application/json'
##    And header accept-encoding =    'gzip, deflate, br'
##    And header accept-language =    'en-US,en;q=0.9,ja;q=0.8,zh;q=0.7,zh-CN;q=0.6,zh-TW;q=0.5'
##    And header content-type =       'application/json'
##    And header Cookie =                      'mbox=session#e71b6b44f4414d6a9928d807c0c7f901#1617185256|PC#e71b6b44f4414d6a9928d807c0c7f901.37_0#1680428196; adcloud={"_les_v":"y,refinitiv.com,1617185196"}; _ga=GA1.2.488171722.1616071648; invoca_session={"ttl":"2021-04-30T09:36:38.853Z","session":{"calling_page":"www.refinitiv.com/en/policies/privacy-statement","calling_page_digitalData":"privacy-statement:legal-notices:financial-risk:global:en","full_calling_page":"https://www.refinitiv.com/en/policies/privacy-statement","adobe_id":"30748759834158530040455795664687869876","utm_medium":"direct","utm_source":"direct","invoca_id":"i-589c9cde-f00e-4c6d-a87e-1c417d0d3beb","g_cid":"488171722.1616071648"},"config":{"ce":true,"fv":false,"rn":false}}; __qca=P0-764625303-1617183405185; _ga_PVBWSDTKTC=GS1.1.1617183395.1.1.1617183702.0; _gcl_au=1.1.1751038494.1630423568; AMCV_3E1F57795B977DEB0A495EEA@AdobeOrg=359503849|MCMID|30748759834158530040455795664687869876|MCAAMLH-1631028368|3|MCAAMB-1631028368|RKhpRz8krg2tLO6pguXWp5olkAcUniQYPHaMWWgdJ3xzPWQmdj0y|MCOPTOUT-1630430768s|NONE|vVersion|5.0.1|MCIDTS|18718; OptanonConsent=isIABGlobal=false&datestamp=Tue+Aug+31+2021+23:48:36+GMT+0800+(Singapore+Standard+Time)&version=6.16.0&hosts=&consentId=a936b99c-dcb0-4977-82c4-e7a30c9982c3&interactionCount=1&landingPath=https://www.refinitiv.com/en/locations/location-detail.html/taguigs-upper-mckinley-road&groups=C0001:1,C0002:1,C0003:1,C0004:1; _gid=GA1.2.363345967.1635299622; W2=j:{"access_token":"75b4e93c-19ce-3969-b428-367a1e131b20","refresh_token":"d1be3dd6-01b6-38fe-a6a9-0b564b8d170f","scope":"openid","id_token":"eyJ4NXQiOiJNMlF6TVRWbU1HRm1NbVl5WkRJMFl6TTNZMkZqWmpnM09XSmpaVFprTm1ZNU9UVTNaakZrWkEiLCJraWQiOiJNMlF6TVRWbU1HRm1NbVl5WkRJMFl6TTNZMkZqWmpnM09XSmpaVFprTm1ZNU9UVTNaakZrWkFfUlMyNTYiLCJhbGciOiJSUzI1NiJ9.eyJhdF9oYXNoIjoieG5QbDBheFJETVVPQjdNdlZwcmk3dyIsImF1ZCI6Imh6N0twVExUZ0VWeTBqOURVTlBjTTQ4N2U1d2EiLCJjX2hhc2giOiI3MkNvVzZKWkY2aXJRY0xvNUswaUxRIiwic3ViIjoic2lfYWRtaW5AeW9wbWFpbC5jb20iLCJuYmYiOjE2MzUzMTg2MjQsImF6cCI6Imh6N0twVExUZ0VWeTBqOURVTlBjTTQ4N2U1d2EiLCJhbXIiOlsiQmFzaWNBdXRoZW50aWNhdG9yIiwicGFzc3dvcmQtcmVzZXQtZW5mb3JjZXIiXSwiaXNzIjoiaHR0cHM6XC9cL3dzbzJpcy1ub25wcm9kLnN1cHBsaWVyaW50ZWdyaXR5LmNvbTo0NDNcL29hdXRoMlwvdG9rZW4iLCJleHAiOjE2MzUzNDc0MjQsImlhdCI6MTYzNTMxODYyNCwic2lkIjoiY2RlMjA2YmUtMmU4My00NTdkLThkZDYtMzAxMWZkZTRiNTkzIn0.XbrIELfqQm-HLWy2wmInoaq_DHe10VeMKNyDGjMwxCzurnflrNpwxYcZcn9ATzEDnzUiW90ggATQUsk6WruAKCEDHHUIzxy32chJWfR-FYDgTeDeKeMIqETm21bFSE7FBaCSLNSym62lYkBouQ6qdzjtfugz4USMYDfNV3l-u6MOvouDCGvnD1nZQgrFB6ASHNEwyMZEA3Z1A1yiCfQbFR4s-twZntpAcXpFVpfzXYpQfyfjwbT-6-FGcGzajwyQq6elCIETz2Euucc9daE7v2h6Q-ScxeIyHjeqJsNcdSwxudVgY8gU4VWuQG39yUOcAW0cMw68IhEUCJ0Ewa3_zg","token_type":"Bearer","expires_in":9707}'
#
##    And cookie mbox =                                   'session#e71b6b44f4414d6a9928d807c0c7f901#1617185256|PC#e71b6b44f4414d6a9928d807c0c7f901.37_0#1680428196'
##    And cookie adcloud =                                '{"_les_v":"y,refinitiv.com,1617185196"}'
##    And cookie _ga =                                    'GA1.2.488171722.1616071648'
##    And cookie invoca_session =                         '{"ttl":"2021-04-30T09:36:38.853Z","session":{"calling_page":"www.refinitiv.com/en/policies/privacy-statement","calling_page_digitalData":"privacy-statement:legal-notices:financial-risk:global:en","full_calling_page":"https://www.refinitiv.com/en/policies/privacy-statement","adobe_id":"30748759834158530040455795664687869876","utm_medium":"direct","utm_source":"direct","invoca_id":"i-589c9cde-f00e-4c6d-a87e-1c417d0d3beb","g_cid":"488171722.1616071648"},"config":{"ce":true,"fv":false,"rn":false}}'
##    And cookie __qca =                                  'P0-764625303-1617183405185'
##    And cookie _ga_PVBWSDTKTC =                         'GS1.1.1617183395.1.1.1617183702.0'
##    And cookie _gcl_au =                                '1.1.1751038494.1630423568'
##    And cookie AMCV_3E1F57795B977DEB0A495EEA@AdobeOrg = '359503849|MCMID|30748759834158530040455795664687869876|MCAAMLH-1631028368|3|MCAAMB-1631028368|RKhpRz8krg2tLO6pguXWp5olkAcUniQYPHaMWWgdJ3xzPWQmdj0y|MCOPTOUT-1630430768s|NONE|vVersion|5.0.1|MCIDTS|18718'
##    And cookie OptanonConsent =                         'isIABGlobal=false&datestamp=Tue+Aug+31+2021+23:48:36+GMT+0800+(Singapore+Standard+Time)&version=6.16.0&hosts=&consentId=a936b99c-dcb0-4977-82c4-e7a30c9982c3&interactionCount=1&landingPath=https://www.refinitiv.com/en/locations/location-detail.html/taguigs-upper-mckinley-road&groups=C0001:1,C0002:1,C0003:1,C0004:1'
##    And cookie W2 =                                     'j:{"access_token":"75b4e93c-19ce-3969-b428-367a1e131b20","refresh_token":"d1be3dd6-01b6-38fe-a6a9-0b564b8d170f","scope":"openid","id_token":"eyJ4NXQiOiJNMlF6TVRWbU1HRm1NbVl5WkRJMFl6TTNZMkZqWmpnM09XSmpaVFprTm1ZNU9UVTNaakZrWkEiLCJraWQiOiJNMlF6TVRWbU1HRm1NbVl5WkRJMFl6TTNZMkZqWmpnM09XSmpaVFprTm1ZNU9UVTNaakZrWkFfUlMyNTYiLCJhbGciOiJSUzI1NiJ9.eyJhdF9oYXNoIjoieG5QbDBheFJETVVPQjdNdlZwcmk3dyIsImF1ZCI6Imh6N0twVExUZ0VWeTBqOURVTlBjTTQ4N2U1d2EiLCJjX2hhc2giOiI4QzhIM29zV1pNM1ZVbV9PVksySEZnIiwic3ViIjoic2lfYWRtaW5AeW9wbWFpbC5jb20iLCJuYmYiOjE2MzUyOTk2MDIsImF6cCI6Imh6N0twVExUZ0VWeTBqOURVTlBjTTQ4N2U1d2EiLCJhbXIiOlsiQmFzaWNBdXRoZW50aWNhdG9yIiwicGFzc3dvcmQtcmVzZXQtZW5mb3JjZXIiXSwiaXNzIjoiaHR0cHM6XC9cL3dzbzJpcy1ub25wcm9kLnN1cHBsaWVyaW50ZWdyaXR5LmNvbTo0NDNcL29hdXRoMlwvdG9rZW4iLCJleHAiOjE2MzUzMjg0MDIsImlhdCI6MTYzNTI5OTYwMiwic2lkIjoiMjMxMmY0MWItNjM0ZS00MWFhLWI4ODctZGFhYTFlYjA1NDNhIn0.R6eM6wfx_zBgn1lMUkRcAQ5OapKRYT5OFQl6VyQr2mkY4UZmaqb9fN-nMyNfQJEfUjA1YKkLNPu845ZUKM63v3JVAH2YyXaOSjjkOXOd6kmbUlrN2OtF1snvnZd_Lc3htQ0ugRNNH8r8OgECBuNM_MsuabS_ZG_US-bpsWXDALBmKJfnvvkDq_wIO1TS6zl0Q1EeB826N5fASRM6-rlySJoYDX1ewk-N3E2uTuqEhqYBBdxSQ02LzUsZIjZdaVRxwclwoyI6OzY8nm8JIXzDryD1cSKyGJ7a7Ja-ozS6fhH1JpwB8f2QLkQi3SjVOqGf1hh0-zM4P_xh8UoLRx-2Jw","token_type":"Bearer","expires_in":28729}'
##    And cookie _gid =                                   'GA1.2.363345967.1635299622'
##    And cookie JSESSIONID =                             '0705EFC3F0C2F5CEE34DA418E279A1B63E2B185C269F60F1824D681BB6D8A851DDC3F7906EA05A3B26587151125DE6C72F783F0DB2B8BA18E27DBAB1D6E356DE2867675F2757CDEC2AA182238DF47A95BE1FA0B829249756E829157DDD3171C781BF50F4EFB51A960C6AE2C2266A6269086096FE431786150E468089FA915768'
##    And cookie route =                                  '1635299573.531.9849.70792'
##    And cookie commonAuthId =                           '0eb6c764-41e8-46d1-acc9-e6c349b42181'
##    And cookie opbs =                                   'c73919b9-cd50-4d96-9b0d-67b3056e2f0a'
#
##    And header origin =             'https://qa-sprint2.centre.rdd.refinitiv.com'
##    And header referer =            'https://qa-sprint2.centre.rdd.refinitiv.com/admin/icordering/no-referrer'
##    And header sec-ch-ua =          '"Google Chrome";v="95", "Chromium";v="95", ";Not A Brand";v="99"'
##    And header sec-ch-ua-mobile =   '?0'
##    And header sec-ch-ua-platform = '"Windows"'
##    And header sec-fetch-dest =     'empty'
##    And header sec-fetch-mode =     'cors'
##    And header sec-fetch-site =     'same-origin'
##    And header user-agent =         'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36'
#
#    And request billingEntity_requestBody
#    When method POST
#    Then status 200
#
#    Then print response
#
#
##
## BULK-CREATE internal users
##
#
#    * def requestBody_bulkCreateInternalUsers =
#      """
#        [
#          {
#            "firstName":              "John 'TEST BULK ADD USERS'",
#            "lastName":               "Smith",
#            "email":                  "siadmin@refinitiv.com",
#            "isActive":               true,
#            "enabledSso":             true,
#            "position":               "Operation Manager",
#            "roleId":                 "#(publicUsersRoleId)",
#            "groupId":                "#(publicUsersGroupId)",
#            "superiorId":             "#(publicUsersSuperiorId)",
#            "divisions":              [
#                                        "MyDivision"
#                                      ],
#            "entityId":               "#(publicUsersEntityId)",
#            "departmentId":           "#(publicUsersDepartmentId)",
#            "externalOrganizationId": "#(publicUsersExternalOrganizationId)",
#            "billingEntityId":        null
#          }
#        ]
#      """
#
#    Given url postUrl = baseTestUrl
#    And path 'users/bulk'
#    And header X-Tenant-Code = xTenantCode
#    And header Authorization = 'Bearer '+ accessToken
#    And request requestBody_bulkCreateInternalUsers
#    When method POST
#    Then status 207
#
#
##
## VALIDATE response body SCHEMA
##
#
#    And match response ==
#          """
#            {
#              "data": '##[]  ^  {
#                                  "index":      "#number",
#                                  "message":    "Bad Request.",
#                                  "resource":   null,
#                                  "errors":     [
#                                                  {
#                                                    "field":        "billingEntityId",
#                                                    "code":         "SI-ERR-005",
#                                                    "description":  "billingEntityId is a required field"
#                                                  }
#                                                ],
#                                  "status":     400
#                                }'
#            }
#          """
#
#    And print '\n'
#    And print '================================'
#    And print '******** BULK CREATE INTERNAL USERS'
#    And print '******** 6) ERROR: WITHOUT BILLING ENTITY'
#    And print '================================\n'
#    And print '\n'



  Scenario: 7) C36509272 Public API - POST/users/bulk
               - Verify error for invalid email format

    * def nowMs = call fnGetNowMs


#
# BULK-CREATE internal users
#

    * def requestBody_bulkCreateInternalUsers =
      """
        [
          {
            "firstName":              "John 'TEST BULK ADD USERS'",
            "lastName":               "Smith",
            "email":                  "#('john.smith-'+ nowMs +'#supplierintegrity.com')",
            "isActive":               true,
            "enabledSso":             true,
            "position":               "Operation Manager",
            "roleId":                 "#(publicUsersRoleId)",
            "groupId":                "#(publicUsersGroupId)",
            "superiorId":             "#(publicUsersSuperiorId)",
            "divisions":              [
                                        "MyDivision"
                                      ],
            "entityId":               "#(publicUsersEntityId)",
            "departmentId":           "#(publicUsersDepartmentId)",
            "externalOrganizationId": "#(publicUsersExternalOrganizationId)",
            "billingEntityId":        "#(publicUsersBillingEntityId)"
          }
        ]
      """

    Given url postUrl = baseTestUrl
    And path 'users/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_bulkCreateInternalUsers
    When method POST
    Then status 207


#
# VALIDATE response body SCHEMA
#

    And match response ==
          """
            {
              "data": '##[]  ^  {
                                  "index":      "#number",
                                  "message":    "Bad Request.",
                                  "resource":   null,
                                  "errors":     [
                                                  {
                                                    "field":        "email",
                                                    "code":         "SI-ERR-003",
                                                    "description":  "email is not valid."
                                                  }
                                                ],
                                  "status":     400
                                }'
            }
          """

    And print '\n'
    And print '================================'
    And print '******** BULK CREATE INTERNAL USERS'
    And print '******** 7) ERROR: INVALID EMAIL'
    And print '================================\n'
    And print '\n'



  Scenario: 8) C36519786 Public API - POST/users/bulk
               - Verify error when adding users with existing email

    * def nowMs = call fnGetNowMs


#
# BULK-CREATE internal users
#

    * def requestBody_bulkCreateInternalUsers =
      """
        [
          {
            "firstName":              "John 'TEST BULK ADD USERS'",
            "lastName":               "Smith",
            "email":                  "#('john.smith-'+ nowMs +'@refinitiv.com')",
            "isActive":               true,
            "enabledSso":             true,
            "position":               "Operation Manager",
            "roleId":                 "#(publicUsersRoleId)",
            "groupId":                "#(publicUsersGroupId)",
            "superiorId":             "#(publicUsersSuperiorId)",
            "divisions":              [
                                        "MyDivision"
                                      ],
            "entityId":               "#(publicUsersEntityId)",
            "departmentId":           "#(publicUsersDepartmentId)",
            "externalOrganizationId": "#(publicUsersExternalOrganizationId)",
            "billingEntityId":        "#(publicUsersBillingEntityId)"
          }
        ]
      """

    Given url postUrl = baseTestUrl
    And path 'users/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_bulkCreateInternalUsers
    When method POST
    Then status 207


#
# VALIDATE response body SCHEMA
#

    And match response ==
          """
            {
              "data": '##[]  ^  {
                                  "index":      "#number",
                                  "message":    "User Created.",
                                  "resource": {
                                                  "id":       "#string",
                                                  "username": "#(\'john.smith-\'+ nowMs +\'@refinitiv.com\')"
                                  },
                                  "errors":     null,
                                  "status":     201
                                }'
            }
          """


#
# BULK-CREATE internal users
#

    * def requestBody_bulkCreateInternalUsers =
      """
        [
          {
            "firstName":              "John 'TEST BULK ADD USERS'",
            "lastName":               "Smith",
            "email":                  "#('john.smith-'+ nowMs +'@refinitiv.com')",
            "isActive":               true,
            "enabledSso":             true,
            "position":               "Operation Manager",
            "roleId":                 "#(publicUsersRoleId)",
            "groupId":                "#(publicUsersGroupId)",
            "superiorId":             "#(publicUsersSuperiorId)",
            "divisions":              [
                                        "MyDivision"
                                      ],
            "entityId":               "#(publicUsersEntityId)",
            "departmentId":           "#(publicUsersDepartmentId)",
            "externalOrganizationId": "#(publicUsersExternalOrganizationId)",
            "billingEntityId":        "#(publicUsersBillingEntityId)"
          }
        ]
      """

    Given url postUrl = baseTestUrl
    And path 'users/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_bulkCreateInternalUsers
    When method POST
    Then status 207


#
# VALIDATE response body SCHEMA
#

    And match response ==
          """
            {
              "data": '##[]  ^  {
                                  "index":      "#number",
                                  "message":    "Bad Request.",
                                  "resource":   null,
                                  "errors":     [
                                                  {
                                                    "field":        "username",
                                                    "code":         "SI-ERR-003",
                                                    "description":  "##regex ^[john.smith-].*[@refinitiv.com].*[(is not valid.)]$"
                                                  }
                                                ],
                                  "status":     400
                                }'
            }
          """

    And print '\n'
    And print '================================'
    And print '******** BULK CREATE INTERNAL USERS'
    And print '******** 8) ERROR: DUPLICATE EMAIL'
    And print '================================\n'
    And print '\n'



  Scenario: 9) C36509273 Public API - POST/users/bulk
               - Verify error for invalid field values

    * def nowMs = call fnGetNowMs


#
# BULK-CREATE internal users
#

    * def requestBody_bulkCreateInternalUsers =
      """
        [
          {
            "firstName":              "John 'TEST BULK ADD USERS'",
            "lastName":               "Smith",
            "email":                  "#('john.smith-'+ nowMs +'@refinitiv.com')",
            "isActive":               true,
            "enabledSso":             true,
            "position":               "Operation Manager",
            "roleId":                 "aaaaaaa",
            "groupId":                "bbbbbbb",
            "superiorId":             "ccccccc",
            "divisions":              [
                                        "MyDivision"
                                      ],
            "entityId":               "ddddddd",
            "departmentId":           "eeeeeee",
            "externalOrganizationId": "fffffff",
            "billingEntityId":        "ggggggg"
          }
        ]
      """

    Given url postUrl = baseTestUrl
    And path 'users/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_bulkCreateInternalUsers
    When method POST
    Then status 207


#
# VALIDATE response body SCHEMA
#

    And match response ==
          """
            {
              "data": '##[]  ^  {
                                  "index":      "#number",
                                  "message":    "Bad Request.",
                                  "resource":   null,
                                  "errors":     \'##[] ^ {
                                                          "field":        "##regex ^.*[(groupId)|(roleId)|(superiorId)|(entityId)|(departmentId)|(externalOrganizationId)|(billingEntityId)]$",
                                                          "code":         "SI-ERR-003",
                                                          "description":  "##regex ^[(groupId)|(roleId)|(superiorId)|(entityId)|(departmentId)|(externalOrganizationId)|(billingEntityId)].*[(is not valid.)]$"
                                                        }\',
                                  "status":     400
                                }'
            }
          """

    And print '\n'
    And print '================================'
    And print '******** BULK CREATE INTERNAL USERS'
    And print '******** 9) ERROR: INVALID VALUES'
    And print '================================\n'
    And print '\n'



  Scenario: 10) C36509274 Public API - POST/users/bulk
                - Verify error for incomplete required fields

    * def nowMs = call fnGetNowMs


#
# BULK-CREATE internal users
#

    * def requestBody_bulkCreateInternalUsers =
      """
        [
          {
            "firstName":              null,
            "lastName":               null,
            "email":                  null,
            "isActive":               true,
            "enabledSso":             true,
            "position":               "Operation Manager",
            "roleId":                 null,
            "groupId":                "#(publicUsersGroupId)",
            "superiorId":             "#(publicUsersSuperiorId)",
            "divisions":              [

                                      ],
            "entityId":               "#(publicUsersEntityId)",
            "departmentId":           "#(publicUsersDepartmentId)",
            "externalOrganizationId": "#(publicUsersExternalOrganizationId)",
            "billingEntityId":        "#(publicUsersBillingEntityId)"
          }
        ]
      """

    Given url postUrl = baseTestUrl
    And path 'users/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_bulkCreateInternalUsers
    When method POST
    Then status 207


#
# VALIDATE response body SCHEMA
#

    And match response ==
          """
            {
              "data": '##[]  ^  {
                                  "index":      "#number",
                                  "message":    "Bad Request.",
                                  "resource":   null,
                                  "errors":     \'##[] ^ {
                                                          "field":        "##regex ^.*[(divisions)|(lastName)|(firstName)|(email)|(roleId)]$",
                                                          "code":         "SI-ERR-005",
                                                          "description":  "##regex ^[(divisions)|(lastName)|(firstName)|(email)|(roleId)].*[(is a required field)]$"
                                                        }\',
                                  "status":     400
                                }'
            }
          """

    And print '\n'
    And print '================================'
    And print '******** BULK CREATE INTERNAL USERS'
    And print '******** 10) TEST REQUIRED FIELDS'
    And print '================================\n'
    And print '\n'



  Scenario: 11) C36509275 Public API - POST/users/bulk
                - Verify fields with maximum character limitations

    * def nowMs = call fnGetNowMs


#
# BULK-CREATE internal users
#

    * def requestBody_bulkCreateInternalUsers =
      """
        [
          {
            "firstName":              "12-John-9012-TEST-9012-BULK-9012-ADD-89012-USERS-012345678901234",
            "lastName":               "12-Smith-012-TEST-9012-BULK-9012-ADD-89012-USERS-012345678901234",
            "email":                  "#('john.smith-'+ nowMs +'-67890123456789012@refinitiv.com')",
            "isActive":               true,
            "enabledSso":             true,
            "position":               "12-Ops-89012-Manager-2345678901234567890123456789012345678901234",
            "roleId":                 "#(publicUsersRoleId)",
            "groupId":                "#(publicUsersGroupId)",
            "superiorId":             "#(publicUsersSuperiorId)",
            "divisions":              [
                                        "MyDivision"
                                      ],
            "entityId":               "#(publicUsersEntityId)",
            "departmentId":           "#(publicUsersDepartmentId)",
            "externalOrganizationId": "#(publicUsersExternalOrganizationId)",
            "billingEntityId":        "#(publicUsersBillingEntityId)"
          }
        ]
      """

    Given url postUrl = baseTestUrl
    And path 'users/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_bulkCreateInternalUsers
    When method POST
    Then status 207


#
# VALIDATE response body SCHEMA
#

    And match response ==
          """
            {
              "data": '##[]  ^  {
                                  "index":      "#number",
                                  "message":    "User Created.",
                                  "resource": {
                                                  "id":       "#string",
                                                  "username": "#(\'john.smith-\'+ nowMs +\'-67890123456789012@refinitiv.com\')"
                                  },
                                  "errors":     null,
                                  "status":     201
                                }'
            }
          """


    * def nowMs = call fnGetNowMs

#
# BULK-CREATE internal users
#

    * def requestBody_bulkCreateInternalUsers =
      """
        [
          {
            "firstName":              "12-John-9012-TEST-9012-BULK-9012-ADD-89012-USERS-0123456789012345",
            "lastName":               "12-Smith-012-TEST-9012-BULK-9012-ADD-89012-USERS-0123456789012345",
            "email":                  "#('john.smith-'+ nowMs +'-678901234567890123@refinitiv.com')",
            "isActive":               true,
            "enabledSso":             true,
            "position":               "12-Ops-89012-Manager-23456789012345678901234567890123456789012345",
            "roleId":                 "#(publicUsersRoleId)",
            "groupId":                "#(publicUsersGroupId)",
            "superiorId":             "#(publicUsersSuperiorId)",
            "divisions":              [
                                        "MyDivision"
                                      ],
            "entityId":               "#(publicUsersEntityId)",
            "departmentId":           "#(publicUsersDepartmentId)",
            "externalOrganizationId": "#(publicUsersExternalOrganizationId)",
            "billingEntityId":        "#(publicUsersBillingEntityId)"
          }
        ]
      """

    Given url postUrl = baseTestUrl
    And path 'users/bulk'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request requestBody_bulkCreateInternalUsers
    When method POST
    Then status 207


#
# VALIDATE response body SCHEMA
#

    And match response ==
          """
            {
              "data": '##[]  ^  {
                                  "index":      "#number",
                                  "message":    "Bad Request.",
                                  "resource":   null,
                                  "errors":     \'##[] ^ {
                                                          "field":        "##regex ^.*[(lastName)|(firstName)|(position)|(email)]$",
                                                          "code":         "SI-ERR-002",
                                                          "description":  "##regex ^[(lastName)|(firstName)|(position)|(email)].*[(should not exceed the maximum length!)]$"
                                                        }\',
                                  "status":     400
                                }'
            }
          """

    And print '\n'
    And print '================================'
    And print '******** BULK CREATE INTERNAL USERS'
    And print '******** 11) TEST MAX. CHARACTER COUNT'
    And print '================================\n'
    And print '\n'





