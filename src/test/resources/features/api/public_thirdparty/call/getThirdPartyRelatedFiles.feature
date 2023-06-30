@ignore
Feature: REUSABLE - Retrieve Third-Party Related Files



  Background:
#    * def baseTestUrl =        'https://api.qa-sprint2.supplierintegrity.com'
    * def xTenantCode =        tenant
    * def invalidXTenantCode = 'xxx'
    * def eTag =               ''
    * configure retry =        { count: 40, interval: 3000 }

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in



  Scenario: Retrieve third-party related files


    * def thirdPartyId = thirdPartyId


    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId, 'related-files'
    And header X-Tenant-Code =  xTenantCode
    And header RequestorEmail = requestorEmail
    When method GET
    Then status 200


    And match response ==
      """
         {
           message: '##string',
           data: {
               id:           '#string',
               relatedFiles: '##[] ^^ {
                                          processId:      "##string",
                                          filename:       "#string",
                                          description:    "##string",
                                          location:       "#string",
                                          status:         "##string",
                                          dateUploaded:   "#regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}[.][0-9]{3}(Z|[+-][0-9]{2}:[0-9]{2})$"
                                      }'
           }
         }
      """

