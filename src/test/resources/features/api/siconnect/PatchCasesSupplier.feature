@api @patchSuppliers @siconnect_api
Feature: Update Supplier Case

  Background:
    * def patchUrl = baseUrl + version + '/cases/supplier/' + patchSupplierId
    * def now = function(){ return java.lang.System.currentTimeMillis() }
    * def newSearchTerm = 'NEW_SEARCH_TERM_' + now()
    * def newPatchSupplierId =
        """
        {
            "name": "'+ newSearchTerm +'"
        }
        """

  Scenario: Check ability to update supplier's case
    Given url patchUrl
    And header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request newPatchSupplierId
    When method PATCH
    Then status 200
        #    TODO add response validation and migrate all tests