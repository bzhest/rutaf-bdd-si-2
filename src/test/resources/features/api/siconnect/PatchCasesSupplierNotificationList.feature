@api @patchSuppliers @siconnect_api
Feature: Update Supplier's Users List for Notification Supplier's

  Background:
    * def patchUrl = baseUrl + version + '/cases/supplier/' + staticSupplierId + '/notificationList'

  Scenario: Check ability to update supplier's users list for notification supplier's
    * def newPatchSupplierIdNotification =
        """
        []
        """
    Given url patchUrl
    And header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request newPatchSupplierIdNotification
    When method PATCH
    Then status 200
        #    TODO add response validation and migrate all tests
