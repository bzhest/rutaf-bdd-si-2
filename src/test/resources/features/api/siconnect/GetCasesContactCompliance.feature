@api @getSupplier @siconnect_api
Feature: Get Contact Compliance

  Background:
    * def getUrl = baseUrl + version + '/cases/contact/' + staticContactId + '/compliance'

  Scenario: Check ability to fetch contact's compliance
    Given url getUrl
    And header X-Tenant-Code = tenant
    When method GET
    Then status 200
    #    TODO add response validation and migrate all tests
