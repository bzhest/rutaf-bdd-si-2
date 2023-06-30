@ignore
Feature: REUSABLE - Retrieve Users Offset-List



  Background:
#    * def baseTestUrl =        'https://api.qa-sprint2.supplierintegrity.com'
    * def xTenantCode =        tenant
    * def invalidXTenantCode = 'xxx'
    * def eTag =               ''
    * configure retry =        { count: 40, interval: 3000 }

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in



  Scenario: Retrieve users offset-list


    * def search =    search
    * def fetchType = fetchType
    * def page =      page
    * def pageSize =  pageSize


    Given url getUrl = baseTestUrl
    And path 'users', 'offset-list'
    And param search =          search
    And param fetchType =       fetchType
    And param page =            page
    And param pageSize =        pageSize
    And header X-Tenant-Code =  xTenantCode
    And header RequestorEmail = requestorEmail
    When method GET
    Then status 200


    And match response ==
      """
         {
           message: '##string',
           meta:    {
                      pageSize:     '#number',
                      totalRecords: '#number',
                      currentPage:  '#number',
                      totalPages:   '#number'
                    },
           data: '##[] ^^ {
                              id:                      "#string",
                              firstname:               "##string",
                              lastname:                "##string",
                              thirdPartyName:          "##string",
                              username:                "##string",
                              organisation:            "##string",
                              userType:                "#string",
                              role:                    "##string",
                              status:                  "#string",
                              isSingleSignOnEnabled:   "##boolean",
                              thirdPartyId:            "#string",
                              isOutOfOffice:           "##boolean",
                              dateCreated:             "##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}([.][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2}|[+-][0-9]{4})$"
                          }'
         }
      """

