@api @getSupplier @siconnect_api
Feature: Get Screening Results for Supplier

  Background:
    * def getUrl = baseUrl + version + '/cases/supplier/' + staticSupplierId

  Scenario: Check ability to retrieve screening results for supplier
    Given url getUrl
    And header X-Tenant-Code = tenant
    When method GET
    Then status 200
    #    TODO add response validation and migrate all tests
