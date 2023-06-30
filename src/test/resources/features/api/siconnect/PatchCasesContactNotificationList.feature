@api @patchContacts @siconnect_api
Feature: Update Contact's Users List for Notification Contact's

  Background:
    * def patchUrl = baseUrl + version + '/cases/contact/' + staticContactId + '/notificationList'

  Scenario: Check ability to update contact's users list for notification contact's
    * def newPatchContactIdNotification =
        """
        []
        """
    Given url patchUrl
    And header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request newPatchContactIdNotification
    When method PATCH
    Then status 200
        #    TODO add response validation and migrate all tests
