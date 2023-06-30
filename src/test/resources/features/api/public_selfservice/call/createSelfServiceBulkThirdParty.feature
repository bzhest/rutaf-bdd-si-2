@ignore
Feature: REUSABLE - Create Self-Service Bulk Third-Party



  Background:
#    * def baseTestUrl =        'https://api.qa-sprint2.supplierintegrity.com'
    * def xTenantCode =        tenant
    * def invalidXTenantCode = 'xxx'
    * def eTag =               ''
    * configure retry =        { count: 40, interval: 3000 }

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in



  Scenario: Create self-service bulk third-party

#    * def thirdPartyIdCREATE = thirdPartyId

    * def csvRowsT =    csvRowsT
    * def processType = processType

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE: CREATE BULK THIRD-PARTY'
    And print '******** baseTestUrl        = '+ baseTestUrl
    And print '******** xTenantCode        = '+ xTenantCode
    And print '******** isSwaggerDirect    = '+ isSwaggerDirect
#    And print '******** csvRowsT           = '+ csvRowsT
    And print '================================\n'
    And print '\n'


    Given url postUrl = baseTestUrl
    And path 'selfservice'
    And param ProcessType =     processType
#   And multipart file file = { read:'./ThirdPartyBulkUpdate/ThirdParty_Add_Update_Delete_FULLUPDATE', filename:'ThirdParty_Add_Update_Delete_FULLUPDATE.csv', contentType: 'application/vnd.ms-excel' }
    And multipart file file =   { value: '#(csvRowsT)', filename:'ThirdParty_Add_Edit_Delete_ADD.csv', contentType: 'application/vnd.ms-excel' }
    And header X-Tenant-Code =  xTenantCode
    And header RequestorEmail = requestorEmail
    And header Authorization =  'Bearer '+ accessToken
    When method POST
    Then status 202

#    Then print response

    * def processId = response.data.processId

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE: CREATE BULK THIRD-PARTY'
    And print '******** PROCESS ID     = '+ processId
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
                               "processId": '##string'
                           }
              }
          """
