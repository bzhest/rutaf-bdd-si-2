@ignore
Feature: REUSABLE - Retrieve Self-Service Process Details by Id



  Background:
#    * def baseTestUrl =        'https://api.qa-sprint2.supplierintegrity.com'
    * def xTenantCode =        tenant
    * def invalidXTenantCode = 'xxx'
    * def eTag =               ''
    * configure retry =        { count: 40, interval: 3000 }

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in



  Scenario: Retrieve self-service process details by id

#
# Retrieve PROCESS DETAILS by id
#

    * def processId = processId

    Given url postUrl = baseTestUrl
    And path 'selfservice', processId
    And header X-Tenant-Code =  xTenantCode
    And header RequestorEmail = requestorEmail
    And header Authorization =  'Bearer '+ accessToken

    And retry until response.data.status == 'COMPLETED'
    When method GET
    Then status 200

#    Then print response
#    Then print "RESPONSE = \n"+ response

    * def status = response.data.status

    And print '\n'
    And print '================================'
    And print '******** SELF-SERVICE THIRD-PARTY UPLOAD: RETRIEVE PROCESS DETAILS BY ID'
    And print '******** xTenantCode    = '+ xTenantCode
    And print '******** requestorEmail = '+ requestorEmail
    And print '******** PROCESS ID     = '+ processId
    And print '******** STATUS         = '+ status
    And print '================================\n'
    And print '\n'


#
# VALIDATE response body SCHEMA
#

    * def successResponseFile_schema =
        """
          {
              "filename":  "#string",
              "fileSize":  "#number",
              "location":  "#string"
          }
        """

    * def errorResponseFile_schema =
        """
          {
              "filename":  "#string",
              "fileSize":  "#number",
              "location":  "#string"
          }
        """

    And match response ==
          """
            {
              "message": "##string",
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
                             "successResponseFile": "#( '##( successResponseFile_schema )' )",
                             "errorResponseFile":   "#( '##( errorResponseFile_schema   )' )",
                             "numberOfRecords":     "##number",
                             "recordProcessed":     "##number",
                             "recordWithErrors":    "##number",
                             "entityType":          "##string",
                             "entityId":            "##string",
                             "childReferenceId":    "##string",
                             "triggeredBy":         "##string",
                             "processType":         "##string"
                         }
            }
          """
