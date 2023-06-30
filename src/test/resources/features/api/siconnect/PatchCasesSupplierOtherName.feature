@api @siconnect_api
Feature: Patch Supplier Other Name

  As a user,
  I want to a screen to display the supplier's other name WC1 results.
  So that I will see the results.

  Background:
    * def patchUrl = baseUrl + version + '/cases/supplier/' + staticSupplierId + '/otherName'
    * def now = function(){ return java.lang.System.currentTimeMillis() }
    * def testOtherName = 'API_TEST_' + now()
    * def errorSchema = karate.read('classpath:src/test/resources/testdata/api/schema/error.json')

  Scenario: Check ability to create supplier's other name
    * def complianceSchema = karate.read('classpath:src/test/resources/testdata/api/schema/complianceSchema.json')
    Given header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request '{"name": "' + testOtherName + '","nameType": "Other Name"}'
    And url patchUrl
    When method PATCH
    Then status 200
    And match response == '#(complianceSchema)'
    And match response.searchTerm == testOtherName

  Scenario: Check ability to edit supplier's other name
    * def complianceSchema = karate.read('classpath:src/test/resources/testdata/api/schema/complianceSchema.json')
    And header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request '{"name": "' + testOtherName + '","nameType": "Other Name"}'
    And url patchUrl
    And method PATCH
    And status 200
    Given header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request '{"name": "NEW_' + testOtherName + '","nameType": "Other Name","oldName": "' + testOtherName + '"}'
    And url patchUrl
    When method PATCH
    Then status 200
    And match response == '#(complianceSchema)'
    And match response.searchTerm == 'NEW_' + testOtherName

  Scenario Outline: Check ability to get error when name is not specified
    * def nameIsRequiredError = karate.read('classpath:src/test/resources/testdata/api/error/nameIsRequiredError.json')
    Given header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request <request>
    And url patchUrl
    When method PATCH
    Then status 400
    And match response == nameIsRequiredError
    Examples:
      | request                                                               |
      | '{"nameType": "Other Name"}'                                          |
      | '{"nameType": "Other Name", "oldName" : "' + supplierOtherName + '"}' |

  Scenario Outline: Check ability to get error when name type is not specified
    * def supplierNameTypeIsRequiredError = karate.read('classpath:src/test/resources/testdata/api/error/supplierNameTypeIsRequiredError.json')
    Given header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request <request>
    And url patchUrl
    When method PATCH
    Then status 400
    And match response == supplierNameTypeIsRequiredError
    Examples:
      | request                                                                      |
      | '{"name": "' + testOtherName + '"}'                                          |
      | '{"name": "' + testOtherName + '", "oldName" : "' + supplierOtherName + '"}' |

  Scenario: Check ability to get error when other name duplicate
    * def supplierDuplicateNameError = karate.read('classpath:src/test/resources/testdata/api/error/supplierDuplicateNameError.json')
    And header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request '{"name": "' + testOtherName + '","nameType": "Other Name"}'
    And url patchUrl
    And method PATCH
    And status 200
    Given header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request '{"name": "' + testOtherName + '","nameType": "Other Name"}'
    And url patchUrl
    When method PATCH
    Then status 400
    And match response == supplierDuplicateNameError

  Scenario: Check ability to get error when edited other name duplicate
    * def supplierDuplicateNameError = karate.read('classpath:src/test/resources/testdata/api/error/supplierDuplicateNameError.json')
    And header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request '{"name": "FIRST_' + testOtherName + '","nameType": "Other Name"}'
    And url patchUrl
    And method PATCH
    And status 200
    Given header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request '{"name": "SECOND_' + testOtherName + '","nameType": "Other Name"}'
    And url patchUrl
    And method PATCH
    And status 200
    Given header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request '{"name": "FIRST_' + testOtherName + '","nameType": "Other Name","oldName": "SECOND_' + testOtherName + '"}'
    And url patchUrl
    When method PATCH
    Then status 400
    And match response == supplierDuplicateNameError

  Scenario: Check ability to get error when supplier's ID is invalid
    * def patchUrlInvalid = baseUrl + version + '/cases/supplier/' + invalidSupplierId + '/otherName'
    Given header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request '{"name": "' + testOtherName + '","nameType": "Other Name"}'
    And url patchUrlInvalid
    When method PATCH
    Then status 400
    And match response == '#(errorSchema)'

  Scenario: Check ability to get error when tenant code is invalid
    Given header X-Tenant-Code = invalidTenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request '{"name": "' + testOtherName + '","nameType": "Other Name"}'
    And url patchUrl
    When method PATCH
    Then status 404
    And match response == '#(errorSchema)'

  Scenario: Check ability to get error when tenant code is empty
    Given header X-Tenant-Code = ''
    And header Content-Type = 'application/vnd.internal.app+json'
    And request '{"name": "' + testOtherName + '","nameType": "Other Name"}'
    And url patchUrl
    When method PATCH
    Then status 500
    And match response == '#(errorSchema)'
