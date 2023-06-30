@ignore
Feature: REUSABLE - Retrieve Third-Party Offset-List



  Background:
#    * def baseTestUrl =        'https://api.qa-sprint2.supplierintegrity.com'
    * def xTenantCode =        tenant
    * def invalidXTenantCode = 'xxx'
    * def eTag =               ''
    * configure retry =        { count: 40, interval: 3000 }

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in



  Scenario: Retrieve contacts offset-list


    * def thirdPartyId = thirdPartyId
    * def name =         name
    * def fetchType =    fetchType
    * def page =         page
    * def pageSize =     pageSize
    * def fields =       fields
    * def orderBy =      orderBy


    * def paramsJsonObj = {}
    * if ( ! paramsJsonObj.name      && name      != null ) { paramsJsonObj.name      = name      }
    * if ( ! paramsJsonObj.fetchType && fetchType != null ) { paramsJsonObj.fetchType = fetchType }
    * if ( ! paramsJsonObj.page      && page      != null ) { paramsJsonObj.page      = page      }
    * if ( ! paramsJsonObj.pageSize  && pageSize  != null ) { paramsJsonObj.pageSize  = pageSize  }
    * if ( ! paramsJsonObj.fields    && fields    != null ) { paramsJsonObj.fields    = fields    }
    * if ( ! paramsJsonObj.orderBy   && orderBy   != null ) { paramsJsonObj.orderBy   = orderBy    }


    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId, 'contacts', 'offset-list'
#    And param name =            name
#    And param fetchType =       fetchType
#    And param page =            page
#    And param pageSize =        pageSize
#    And param fields =          fields
#    And param orderBy =         orderBy
    And params                  paramsJsonObj
    And header X-Tenant-Code =  xTenantCode
    And header RequestorEmail = requestorEmail
    When method GET
    Then status 200



    * def metaSchema =
      """
          { pageSize:     '#number',
            totalRecords: '#number',
            currentPage:  '#number',
            totalPages:   '#number'
          }
      """

    And match response ==
      """
         {
           message: '##string',
           meta:    '##( \"##(metaSchema)\" )',
           data:    '##[] ^^ {
                                 id:                "#string",
                                 title:             "##string",
                                 firstName:         "##string",
                                 lastName:          "##string",
                                 country:           "##string",
                                 isActive:          "##boolean",
                                 isPrincipal:       "##boolean",
                                 status:            "##string",
                                 position:          "##string",
                                 relationshipInfo:  "##string"
                             }'
         }
      """

#    And match response ==
#      """
#         {
#           message: '##string',
#           meta:    {
#                      pageSize:     '#number',
#                      totalRecords: '#number',
#                      currentPage:  '#number',
#                      totalPages:   '#number'
#                    },
#           data: '##[] ^^ {
#                              parent:            "##string",
#                              id:                "#string",
#                              title:             "##string",
#                              firstName:         "##string",
#                              lastName:          "##string",
#                              country:           "##string",
#                              isActive:          "##boolean",
#                              isPrincipal:       "##boolean",
#                              status:            "##string"
#                          }'
#         }
#      """

