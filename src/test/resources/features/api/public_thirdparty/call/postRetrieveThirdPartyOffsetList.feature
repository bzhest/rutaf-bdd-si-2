@ignore
Feature: REUSABLE - POST Retrieve Third-Party Offset-List



  Background:
#    * def baseTestUrl =        'https://api.qa-sprint2.supplierintegrity.com'
    * def xTenantCode =        tenant
    * def invalidXTenantCode = 'xxx'
    * def eTag =               ''
    * configure retry =        { count: 40, interval: 3000 }

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in



  Scenario: POST Retrieve third-party offset-list


#    * def name =      name
#    * def fetchType = fetchType
#    * def page =      page
#    * def pageSize =  pageSize
#    * def fields =    fields
#    * def orderBy =   orderBy

    * def defaultOperator =   'AND'

    * def field =              field
    * def pvalue =             pvalue
    * def svalue =             svalue
    * def func =               func
    * def isCustomField =      isCustomField
    * def autoConvertValue =   autoConvertValue
    * def criteriaGroupName =  criteriaGroupName
    * def name =               name
    * def operator =           operator

    * def fetchType =          fetchType
    * def page =               page
    * def pageSize =           pageSize
    * def fields =             fields
    * def orderBy =            orderBy



#    * def paramsJsonObj = {}
#    * if ( ! paramsJsonObj.name      && name      != null ) { paramsJsonObj.name      = name      }
#    * if ( ! paramsJsonObj.fetchType && fetchType != null ) { paramsJsonObj.fetchType = fetchType }
#    * if ( ! paramsJsonObj.page      && page      != null ) { paramsJsonObj.page      = page      }
#    * if ( ! paramsJsonObj.pageSize  && pageSize  != null ) { paramsJsonObj.pageSize  = pageSize  }
#    * if ( ! paramsJsonObj.fields    && fields    != null ) { paramsJsonObj.fields    = fields    }
#    * if ( ! paramsJsonObj.orderBy   && orderBy   != null ) { paramsJsonObj.orderBy   = orderBy   }

    * def reqBodyJsonObj = {}
    * if ( ! reqBodyJsonObj.defaultOperator    && defaultOperator   != null ) { reqBodyJsonObj.defaultOperator    = defaultOperator   }

    * def criteriaJsonArr = []
    * def criteriaJsonObj = {}
    * if ( ! criteriaJsonObj.field             && field             != null ) { criteriaJsonObj.field             = field             }
    * if ( ! criteriaJsonObj.pvalue            && pvalue            != null ) { criteriaJsonObj.pvalue            = pvalue            }
    * if ( ! criteriaJsonObj.svalue            && svalue            != null ) { criteriaJsonObj.svalue            = svalue            }
    * if ( ! criteriaJsonObj.func              && func              != null ) { criteriaJsonObj.func              = func              }
    * if ( ! criteriaJsonObj.isCustomField     && isCustomField     != null ) { criteriaJsonObj.isCustomField     = isCustomField     }
    * if ( ! criteriaJsonObj.autoConvertValue  && autoConvertValue  != null ) { criteriaJsonObj.autoConvertValue  = autoConvertValue  }
    * if ( ! criteriaJsonObj.criteriaGroupName && criteriaGroupName != null ) { criteriaJsonObj.criteriaGroupName = criteriaGroupName }
    * criteriaJsonArr.add( criteriaJsonObj )
    * reqBodyJsonObj.criteria = criteriaJsonArr

    * def groupOperatorsJsonArr = []
    * def groupOperatorsJsonObj = {}
    * if ( ! groupOperatorsJsonObj.name        && name              != null ) { groupOperatorsJsonObj.name        = name              }
    * if ( ! groupOperatorsJsonObj.operator    && operator          != null ) { groupOperatorsJsonObj.operator    = operator          }
    * groupOperatorsJsonArr.add( groupOperatorsJsonObj )
    * reqBodyJsonObj.groupOperators = groupOperatorsJsonArr



    * def qryParamsJsonObj = {}
    * if ( ! qryParamsJsonObj.fetchType        && fetchType         != null ) { qryParamsJsonObj.fetchType        = fetchType         }
    * if ( ! qryParamsJsonObj.page             && page              != null ) { qryParamsJsonObj.page             = page              }
    * if ( ! qryParamsJsonObj.pageSize         && pageSize          != null ) { qryParamsJsonObj.pageSize         = pageSize          }
    * if ( ! qryParamsJsonObj.fields           && fields            != null ) { qryParamsJsonObj.fields           = fields            }
    * if ( ! qryParamsJsonObj.orderBy          && orderBy           != null ) { qryParamsJsonObj.orderBy          = orderBy           }




#    Given url getUrl = baseTestUrl
#    And path 'thirdparty', 'offset-list'
##    And param name =            name
##    And param fetchType =       fetchType
##    And param page =            page
##    And param pageSize =        pageSize
##    And param fields =          fields
##    And param orderBy =         orderBy
#    And params                  paramsJsonObj
#    And header X-Tenant-Code =  xTenantCode
#    And header RequestorEmail = requestorEmail
#    When method GET
#    Then status 200


    Given url getUrl = baseTestUrl
    And path 'thirdparty', 'offset-list'
    And params                  qryParamsJsonObj
    And header X-Tenant-Code =  xTenantCode
    And header RequestorEmail = requestorEmail
    And request                 reqBodyJsonObj
    When method POST
    Then status 200




#    * def metaSchema =
#      """
#          { pageSize:     '#number',
#            totalRecords: '#number',
#            currentPage:  '#number',
#            totalPages:   '#number'
#          }
#      """
#
#    And match response ==
#      """
#         {
#           message: '##string',
#           meta:    '##( \"##(metaSchema)\" )',
#           data:    '##[] ^^ {
#                                 id:                "#string",
#                                 referenceNo:       "##string",
#                                 name:              "##string",
#                                 country:           "##string",
#                                 status:            "##string",
#                                 industryType:      "##string",
#                                 overallRiskScore:  "##number",
#                                 riskTier:          "##string",
#                                 createTime:        "##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}[.][0-9]{3}(Z|[+-][0-9]{2}:[0-9]{2})$",
#                                 updateTime:        "##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}[.][0-9]{3}(Z|[+-][0-9]{2}:[0-9]{2})$",
#                                 overallStatus:     "##string",
#                                 responsibleParty:  "##string",
#                                 divisions:         "##[] #string"
#                             }'
#         }
#      """


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
#                              id:                "#string",
#                              referenceNo:       "##string",
#                              name:              "##string",
#                              country:           "##string",
#                              status:            "##string",
#                              industryType:      "##string",
#                              overallRiskScore:  "##number",
#                              riskTier:          "##string",
#                              createTime:        "##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}[.][0-9]{3}(Z|[+-][0-9]{2}:[0-9]{2})$",
#                              updateTime:        "##regex ^[0-9]{4}-[0-9]{2}-[0-9]{2}[T][0-9]{2}:[0-9]{2}:[0-9]{2}[.][0-9]{3}(Z|[+-][0-9]{2}:[0-9]{2})$",
#                              overallStatus:     "##string",
#                              responsibleParty:  "##string",
#                              divisions:         "##[] #string"
#                          }'
#         }
#      """

