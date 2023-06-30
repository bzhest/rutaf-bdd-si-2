@api @siconnect_api
Feature: Resolving case results for supplier's other name

  Background:
    * def putUrl = baseUrl + version + '/cases/supplier/' + staticSupplierId + '/otherNames/' + supplierOtherName + '/results/resolution'
   #    Retrieve resultIds for other name screening results
    * def getScreeningResults = baseUrl + version + '/cases/supplier/' + staticSupplierId + '/' + supplierOtherName + '/otherName'
    Given header X-Tenant-Code = tenant
    And url getScreeningResults
    And method GET
    And status 200
    * def resultIds = karate.jsonPath(response, "$..resultId")
#    Retrieve resolution toolkit to build put request
    * def postResolutionToolkit = baseUrl + version + '/groups/resolutionToolkit'
    Given header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And url postResolutionToolkit
    And request ''
    And method POST
    And status 200
    * def resolutionToolkit = response
    * def requestBody =
    """
    {
      comment: 'Test Comment',
      statusId: 'string',
      riskId: 'string',
      reasonId: 'string',
      resultIds: 'array'
    }
    """

  Scenario Outline: Check ability to resolve results for supplier's other name
    * def statusId = karate.jsonPath(resolutionToolkit, "$..statuses[?(@.type==\'<statusType>\')].id")
    * def riskId = karate.jsonPath(resolutionToolkit, "$..resolutionRules." + statusId + ".risks[0]")
    * def reasonId = karate.jsonPath(resolutionToolkit, "$..resolutionRules." + statusId + ".reasons[0]")
    And set requestBody.statusId = statusId[0]
    And set requestBody.riskId = riskId[0]
    And set requestBody.resultIds = resultIds
    And set requestBody.reasonId = reasonId[0]
    Given header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And url putUrl
    And request requestBody
    When method PUT
    Then status 200
    * def resultResolutionSchema = karate.read('classpath:src/test/resources/testdata/api/schema/resultResolutionSchema.json')
    * def responseSchema =
     """
     {
        message : '#string',
        payload : '##[] resultResolutionSchema',
     }
     """
    And match response == responseSchema

#    Retrieve case results and validate that resolved profiles contain expected resolution response
#    And supplier's screening status updated
    Given header X-Tenant-Code = tenant
    And url getScreeningResults
    And method GET
    And status 200
    And print response.profiles
    And match each response.profiles[*].resolution.statusId == requestBody.statusId
    And match each response.profiles[*].resolution.reasonId == requestBody.reasonId
    And match each response.profiles[*].resolution.riskId == requestBody.riskId
    Examples:
      | statusType  |
      | POSITIVE    |
      | POSSIBLE    |
      | FALSE       |
      | UNSPECIFIED |

  Scenario: Check ability to get error when tenant code is invalid
    * def supplierInformationDoesntExist = karate.read('classpath:src/test/resources/testdata/api/error/supplierInformationDoesntExist.json')
    * def statusId = karate.jsonPath(resolutionToolkit, "$..statuses[?(@.type==\'POSITIVE\')].id")
    * def riskId = karate.jsonPath(resolutionToolkit, "$..resolutionRules." + statusId + ".risks[0]")
    * def reasonId = karate.jsonPath(resolutionToolkit, "$..resolutionRules." + statusId + ".reasons[0]")
    And set requestBody.statusId = statusId[0]
    And set requestBody.riskId = riskId[0]
    And set requestBody.resultIds = resultIds
    And set requestBody.reasonId = reasonId[0]
    Given header X-Tenant-Code = invalidTenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And url putUrl
    And request requestBody
    When method PUT
    Then status 404
    And match response == supplierInformationDoesntExist

  Scenario: Check ability to get error when tenant code is empty
    * def emptyTenantError = karate.read('classpath:src/test/resources/testdata/api/error/emptyTenantError.json')
    * def statusId = karate.jsonPath(resolutionToolkit, "$..statuses[?(@.type==\'POSITIVE\')].id")
    * def riskId = karate.jsonPath(resolutionToolkit, "$..resolutionRules." + statusId + ".risks[0]")
    * def reasonId = karate.jsonPath(resolutionToolkit, "$..resolutionRules." + statusId + ".reasons[0]")
    And set requestBody.statusId = statusId[0]
    And set requestBody.riskId = riskId[0]
    And set requestBody.resultIds = resultIds
    And set requestBody.reasonId = reasonId[0]
    Given header X-Tenant-Code = ''
    And header Content-Type = 'application/vnd.internal.app+json'
    And url putUrl
    And request requestBody
    When method PUT
    Then status 500
    And match response == emptyTenantError

  Scenario: Check ability to get error when supplier ID is invalid
    * def idDoesntExist = karate.read('classpath:src/test/resources/testdata/api/error/idDoesntExist.json')
    * def invalidSupplierIdUrl = baseUrl + version + '/cases/supplier/' + invalidSupplierId + '/otherNames/' + supplierOtherName + '/results/resolution'
    * def statusId = karate.jsonPath(resolutionToolkit, "$..statuses[?(@.type==\'POSITIVE\')].id")
    * def riskId = karate.jsonPath(resolutionToolkit, "$..resolutionRules." + statusId + ".risks[0]")
    * def reasonId = karate.jsonPath(resolutionToolkit, "$..resolutionRules." + statusId + ".reasons[0]")
    And set requestBody.statusId = statusId[0]
    And set requestBody.riskId = riskId[0]
    And set requestBody.resultIds = resultIds
    And set requestBody.reasonId = reasonId[0]
    Given header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And url invalidSupplierIdUrl
    And request requestBody
    When method PUT
    Then status 400
    And match response == idDoesntExist

  Scenario: Check ability to get error when other name is invalid
    * def errorResolve = karate.read('classpath:src/test/resources/testdata/api/error/supplierOtherNameResolveFailed.json')
    * def invalidSupplierIdUrl = baseUrl + version + '/cases/supplier/' + staticSupplierId + '/otherNames/' + supplierOtherName + '_invalid/results/resolution'
    * def statusId = karate.jsonPath(resolutionToolkit, "$..statuses[?(@.type==\'POSITIVE\')].id")
    * def riskId = karate.jsonPath(resolutionToolkit, "$..resolutionRules." + statusId + ".risks[0]")
    * def reasonId = karate.jsonPath(resolutionToolkit, "$..resolutionRules." + statusId + ".reasons[0]")
    And set requestBody.statusId = statusId[0]
    And set requestBody.riskId = riskId[0]
    And set requestBody.resultIds = resultIds
    And set requestBody.reasonId = reasonId[0]
    Given header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And url invalidSupplierIdUrl
    And request requestBody
    When method PUT
    Then status 500
    And match response == errorResolve

  Scenario: Check ability to get error when status ID is invalid
    * def errorResolve = karate.read('classpath:src/test/resources/testdata/api/error/supplierOtherNameResolveFailed.json')
    * def statusId = karate.jsonPath(resolutionToolkit, "$..statuses[?(@.type==\'POSITIVE\')].id")
    * def riskId = karate.jsonPath(resolutionToolkit, "$..resolutionRules." + statusId + ".risks[0]")
    * def reasonId = karate.jsonPath(resolutionToolkit, "$..resolutionRules." + statusId + ".reasons[0]")
    And set requestBody.statusId = statusId[0]+'_invalid'
    And set requestBody.riskId = riskId[0]
    And set requestBody.resultIds = resultIds
    And set requestBody.reasonId = reasonId[0]
    Given header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And url putUrl
    And request requestBody
    When method PUT
    Then status 500
    And match response == errorResolve

  Scenario: Check ability to get error when risk ID is invalid
    * def errorResolve = karate.read('classpath:src/test/resources/testdata/api/error/supplierOtherNameResolveFailed.json')
    * def statusId = karate.jsonPath(resolutionToolkit, "$..statuses[?(@.type==\'POSITIVE\')].id")
    * def riskId = karate.jsonPath(resolutionToolkit, "$..resolutionRules." + statusId + ".risks[0]")
    * def reasonId = karate.jsonPath(resolutionToolkit, "$..resolutionRules." + statusId + ".reasons[0]")
    And set requestBody.statusId = statusId[0]
    And set requestBody.riskId = riskId[0]+'_invalid'
    And set requestBody.resultIds = resultIds
    And set requestBody.reasonId = reasonId[0]
    Given header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And url putUrl
    And request requestBody
    When method PUT
    Then status 500
    And match response == errorResolve

  Scenario: Check ability to get error when reason ID is invalid
    * def errorResolve = karate.read('classpath:src/test/resources/testdata/api/error/supplierOtherNameResolveFailed.json')
    * def statusId = karate.jsonPath(resolutionToolkit, "$..statuses[?(@.type==\'POSITIVE\')].id")
    * def riskId = karate.jsonPath(resolutionToolkit, "$..resolutionRules." + statusId + ".risks[0]")
    * def reasonId = karate.jsonPath(resolutionToolkit, "$..resolutionRules." + statusId + ".reasons[0]")
    And set requestBody.statusId = statusId[0]
    And set requestBody.riskId = riskId[0]
    And set requestBody.resultIds = resultIds
    And set requestBody.reasonId = reasonId[0]+'_invalid'
    Given header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And url putUrl
    And request requestBody
    When method PUT
    Then status 500
    And match response == errorResolve

  Scenario: Check ability to get error when result ID is invalid
    * def errorResolve = karate.read('classpath:src/test/resources/testdata/api/error/supplierOtherNameResolveFailed.json')
    * def statusId = karate.jsonPath(resolutionToolkit, "$..statuses[?(@.type==\'POSITIVE\')].id")
    * def riskId = karate.jsonPath(resolutionToolkit, "$..resolutionRules." + statusId + ".risks[0]")
    * def reasonId = karate.jsonPath(resolutionToolkit, "$..resolutionRules." + statusId + ".reasons[0]")
    And set requestBody.statusId = statusId[0]
    And set requestBody.riskId = riskId[0]
    And set requestBody.resultIds = ['invalid']
    And set requestBody.reasonId = reasonId[0]
    Given header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And url putUrl
    And request requestBody
    When method PUT
    Then status 500
    And match response == errorResolve
