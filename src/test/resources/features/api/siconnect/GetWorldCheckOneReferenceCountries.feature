@api @siconnect_api
Feature: Get World-Check One reference countries

  Background:
    * def getUrl = baseUrl + version + '/worldCheckOne/reference/countries'
    * def countriesTransfer = Java.type("com.refinitiv.asts.test.utils.data.siconnect.CountriesReferenceResponseDataTransfer")
    * def expectedResponse = countriesTransfer.getExpectedCountriesOutput()

  Scenario: Check ability to retrieve World-Check One reference countries
    Given url getUrl
    And header X-Tenant-Code = tenant
    When method GET
    Then status 200
    And match response == expectedResponse

  Scenario: Check ability to get error when tenant code is invalid
    Given url getUrl
    And header X-Tenant-Code = invalidTenant
    When method GET
    Then status 404

  Scenario: Check ability to get error when tenant code is empty
    Given url getUrl
    And header X-Tenant-Code = ''
    When method GET
    Then status 500

