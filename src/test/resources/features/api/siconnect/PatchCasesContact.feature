@api @patchContacts @siconnect_api
Feature: Update Contact Case

  Background:
    * def patchUrl = baseUrl + version + '/cases/contact/' + patchContactId
    * def now = function(){ return java.lang.System.currentTimeMillis() }
    * def newSearchTerm = 'NEW_SEARCH_TERM_' + now()
    * def newPatchContactId =
        """
        {
            "name": "'+ newSearchTerm +'"
        }
        """

  Scenario: Check ability to update contact's case
    Given url patchUrl
    And header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request newPatchContactId
    When method PATCH
    Then status 200
        #    TODO add response validation and migrate all tests