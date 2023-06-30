@ignore
Feature: REUSABLE - Create Self-Service Bulk Third-Party Contacts - CSV Headers



  Background:
#    * def baseTestUrl =        'https://api.qa-sprint2.supplierintegrity.com'
    * def xTenantCode =        tenant
    * def invalidXTenantCode = 'xxx'
    * def eTag =               ''
    * configure retry =        { count: 40, interval: 3000 }

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in



  Scenario: Create self-service bulk third-party contacts - CSV headers

    * def contactsTemplateHeaders = "Action Type|Third-party ID|Reference Number|Group ID|Contact First Name|Contact Middle Name|Contact Last name|Title|Key Principal|Enable Account|Address Line|City|State/province|Country|Region|Zip/postal Code|Nationality|Place of Birth|Phone Number|Fax|Website|Email Address|Description|Other Name Old Name|Other Name|Other Name Type|Country of Location|Other Name Nationality|Other Name Place of Birth|Auto Screen|NEWCOLUMN|Case System ID|Other Name Case System ID|Notify List"

    * def returnContactsTemplateHeaders =
        """
          function() {
              return 'Action Type|Third-party ID|Reference Number|Group ID|Contact First Name|Contact Middle Name|Contact Last name|Title|Key Principal|Enable Account|Address Line|City|State/province|Country|Region|Zip/postal Code|Nationality|Place of Birth|Phone Number|Fax|Website|Email Address|Description|Other Name Old Name|Other Name|Other Name Type|Country of Location|Other Name Nationality|Other Name Place of Birth|Auto Screen|Case System ID|Other Name Case System ID|Notify List';
          }
        """

#    And print '================================'
#    And print '******** myHeaders1 = '+ myHeaders1
#    And print '================================'




##    * def thirdPartyIdCREATE = thirdPartyId
#
#    * def csvRowsT =    csvRowsT
#    * def processType = processType
#
#    And print '\n'
#    And print '================================'
#    And print '******** SELF-SERVICE: CREATE BULK THIRD-PARTY'
#    And print '******** baseTestUrl        = '+ baseTestUrl
#    And print '******** xTenantCode        = '+ xTenantCode
#    And print '******** isSwaggerDirect    = '+ isSwaggerDirect
##    And print '******** csvRowsT           = '+ csvRowsT
#    And print '================================\n'
#    And print '\n'
#
#
#    Given url postUrl = baseTestUrl
#    And path 'selfservice'
#    And param ProcessType =     processType
##   And multipart file file = { read:'./ThirdPartyBulkUpdate/ThirdParty_Add_Update_Delete_FULLUPDATE', filename:'ThirdParty_Add_Update_Delete_FULLUPDATE.csv', contentType: 'application/vnd.ms-excel' }
#    And multipart file file =   { value: '#(csvRowsT)', filename:'ThirdParty_Add_Edit_Delete_ADD.csv', contentType: 'application/vnd.ms-excel' }
#    And header X-Tenant-Code =  xTenantCode
#    And header RequestorEmail = requestorEmail
#    And header Authorization =  'Bearer '+ accessToken
#    When method POST
#    Then status 202
#
##    Then print response
#
#    * def processId = response.data.processId
#
#    And print '\n'
#    And print '================================'
#    And print '******** SELF-SERVICE: CREATE BULK THIRD-PARTY'
#    And print '******** PROCESS ID     = '+ processId
#    And print '================================\n'
#    And print '\n'
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
#                               "processId": '##string'
#                           }
#              }
#          """
