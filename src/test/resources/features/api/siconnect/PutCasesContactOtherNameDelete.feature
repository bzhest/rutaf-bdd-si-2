@api @siconnect_api @putCases
Feature: Delete Contact Other Name

  As a user,
  I want to an ability to delete the other name.
  So that I can delete it.

  Background:
    * def putUrl = baseUrl + version + '/cases/contact/' + staticContactId + '/otherName/delete'
    * def now = function(){ return java.lang.System.currentTimeMillis() }
    * def testOtherName = 'API_TEST_' + now()
    * def wcoResponseUtil = Java.type("com.refinitiv.asts.test.utils.data.wc1.WCOApiResponseExtractor")


  Scenario: Check ability to delete contact other name
    * def addUrl = baseUrl + version + '/cases/contact/' + staticContactId + '/otherName'
    And header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request '{"name": "' + testOtherName + '","nameType": "Also Known As"}'
    And url addUrl
    And method PATCH
    And status 200
    * def searchId = response.searchId
    Given header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request '["'+testOtherName+'"]'
    And url putUrl
    When method PUT
    Then status 200
    And match wcoResponseUtil.getCaseResponseStatusFromWCo(searchId) == 404

  Scenario: Check ability to get error when name is invalid
    * def errorSchema = karate.read('classpath:src/test/resources/testdata/api/schema/error.json')
    Given header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request '["'+testOtherName+'"]'
    And url putUrl
    When method PUT
    Then status 404
    And match response == '#(errorSchema)'

  Scenario: Check ability to get error when contact ID is invalid
    * def errorSchema = karate.read('classpath:src/test/resources/testdata/api/schema/error.json')
    * def putUrlInvalid = baseUrl + version + '/cases/contact/' + invalidSupplierId + '/otherName/delete'
    Given header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request '["'+testOtherName+'"]'
    And url putUrlInvalid
    When method PUT
    Then status 500
#    TODO add response body assertion

  Scenario: Check ability to get error when tenant code is invalid
    * def supplierContactDoesntExistError = karate.read('classpath:src/test/resources/testdata/api/error/supplierContactDoesntExistError.json')
    Given header X-Tenant-Code = invalidTenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request '["'+testOtherName+'"]'
    And url putUrl
    When method PUT
    Then status 404
    And match response == supplierContactDoesntExistError

  Scenario: Check ability to get error when tenant code is empty
    * def emptyTenantError = karate.read('classpath:src/test/resources/testdata/api/error/emptyTenantError.json')
    Given header X-Tenant-Code = ''
    And header Content-Type = 'application/vnd.internal.app+json'
    And request '["'+testOtherName+'"]'
    And url putUrl
    When method PUT
    Then status 500
    And match response == emptyTenantError
