@api @getSupplier @siconnect_api
Feature: Get Suppliers's Compliance

  Background:
    * def getUrl = baseUrl + version + '/cases/supplier/' + staticSupplierId + '/compliance'

  Scenario: Check ability to fetch suppliers's compliance
    Given url getUrl
    And header X-Tenant-Code = tenant
    When method GET
    Then status 200
    #    TODO add response validation and migrate all tests
