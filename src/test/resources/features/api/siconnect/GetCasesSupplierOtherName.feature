@api @siconnect_api
Feature: Get Supplier Screening Result from WC1 for Other Name

  As a user,
  I want to see the supplier's other name results from WC1.
  So that I can process the supplier's other name information.

  Background:
    * def getUrl = baseUrl + version + '/cases/supplier/' + staticSupplierId + '/' + supplierOtherName + '/otherName'
    * def supplierNotFoundError = karate.read('classpath:src/test/resources/testdata/api/error/supplierNotFoundError.json')
    * def screeningResultsTransfer = Java.type("com.refinitiv.asts.test.utils.data.siconnect.SIScreeningResponseDataTransfer")

  Scenario: Check ability to get supplier's other name screening results with correct screening results
    Given header X-Tenant-Code = tenant
    And url getUrl
    And method GET
    And status 200
    * def expectedResponse = screeningResultsTransfer.getExpectedScreeningOutput(0, 10, supplierOtherNameSearchId)
    And match response.pageInformation == expectedResponse.pageInformation
    And match response.profiles == expectedResponse.profiles
    And match response.lastScreeningDate == '#number'

  Scenario: Check ability to get supplier's other name screening results with specified page number
    Given header X-Tenant-Code = tenant
    And param pageNo = '1'
    And url getUrl
    And method GET
    And status 200
    * def expectedResponse = screeningResultsTransfer.getExpectedScreeningOutput(1, 10, supplierOtherNameSearchId)
    And match response.pageInformation == expectedResponse.pageInformation
    And match response.profiles == expectedResponse.profiles
    And match response.lastScreeningDate == '#number'

  Scenario: Check ability to get supplier's other name screening results with specified page number and page size
    Given header X-Tenant-Code = tenant
    And param pageNo = '1'
    And param pageSize = '2'
    And url getUrl
    And method GET
    And status 200
    * def expectedResponse = screeningResultsTransfer.getExpectedScreeningOutput(1, 2, supplierOtherNameSearchId)
    And match response.pageInformation == expectedResponse.pageInformation
    And match response.profiles == expectedResponse.profiles
    And match response.lastScreeningDate == '#number'

  Scenario: Check ability to get supplier's other name screening results with specified page size
    Given header X-Tenant-Code = tenant
    And param pageSize = '2'
    And url getUrl
    And method GET
    And status 200
    * def expectedResponse = screeningResultsTransfer.getExpectedScreeningOutput(0, 2, supplierOtherNameSearchId)
    And match response.pageInformation == expectedResponse.pageInformation
    And match response.profiles == expectedResponse.profiles
    And match response.lastScreeningDate == '#number'


  Scenario: Check ability to get error when supplier's ID is invalid
    * def invalidSupplierIdUrl = baseUrl + version + '/cases/supplier/' + invalidSupplierId + '/' + supplierOtherName + '/otherName'
    Given header X-Tenant-Code = tenant
    And url invalidSupplierIdUrl
    And method GET
    And status 404
    And match response == supplierNotFoundError

  Scenario: Check ability to get error when tenant code is invalid
    Given header X-Tenant-Code = invalidTenant
    And url getUrl
    And method GET
    And status 404
    And match response == supplierNotFoundError

  Scenario: Check ability to get error when other name is invalid
    * def invalidOtherNameUrl = baseUrl + version + '/cases/supplier/' + staticSupplierId + '/' + invalidOtherName + '/otherName'
    Given header X-Tenant-Code = tenant
    And url invalidOtherNameUrl
    And method GET
    And status 404
    And match response == supplierNotFoundError

  Scenario: Check ability to get error when page size is zero
    * def errorSchema = karate.read('classpath:src/test/resources/testdata/api/schema/error.json')
    Given header X-Tenant-Code = tenant
    And param pageSize = '0'
    And url getUrl
    And method GET
    And status 500
    And match response == '#(errorSchema)'

  Scenario: Check ability to get error when tenant code is empty
    * def emptyTenantError = karate.read('classpath:src/test/resources/testdata/api/error/emptyTenantError.json')
    Given header X-Tenant-Code = ''
    And url getUrl
    And method GET
    And status 500
    And match response == emptyTenantError