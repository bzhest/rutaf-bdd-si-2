@api @getSupplier @siconnect_api
Feature: Get Screening Results for Contact

  Background:
    * def getUrl = baseUrl + version + '/cases/contact/' + staticContactId

  Scenario: Check ability to retrieve screening results for contact
    Given url getUrl
    And header X-Tenant-Code = tenant
    When method GET
    Then status 200
#    TODO add response validation and migrate all tests
