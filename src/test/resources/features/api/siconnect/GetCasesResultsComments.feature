@api @getSupplier @siconnect_api
Feature: Get Case Result Comments

  Background:
    * def getUrl = baseUrl + version + '/cases/results/' + resultIdWithComment + '/comments'


  Scenario: Check ability to retrieve result's comment
    Given url getUrl
    And header X-Tenant-Code = tenant
    When method GET
    Then status 200
    #    TODO add response validation and add validation tests
