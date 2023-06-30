@api @patchSuppliers @siconnect_api
Feature: Update Screening Status of a Supplier

  Background:
    * def patchUrl = baseUrl + version + '/cases/supplier/' + staticSupplierId + '/screeningStatus'

  Scenario Outline: Check ability to update screening status of a supplier
    Given url patchUrl
    And header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request ''
    And param status = '<status>'
    When method PATCH
    Then status 200
        #    TODO add response validation and migrate all tests
    Examples:
      | status     |
      | No Results |
      | Unresolved |
