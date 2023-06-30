@api @patchSupplier @siconnect_api
Feature: Replace Case Results Update Indicator With Blank

  Background:
    * def patchUrl = baseUrl + version + '/cases/supplier/' + staticSupplierId + '/results/' + supplierResultId

  Scenario: Check ability to replace case results update indicator with blank
    Given url patchUrl
    And header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request ''
    When method PATCH
    Then status 200
        #    TODO add response validation and migrate all tests