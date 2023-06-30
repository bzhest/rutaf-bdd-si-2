@api @postCases @siconnect_api
Feature: Post Screening profile

  Background:
    * def postUrl = baseUrl + version + '/profiles/' + profileId

  Scenario: Check ability to retrieve screening profile with filter
    * def newPostProfilesReferenceId =
        """
          {
            "fields": [
              "associates"
            ]
          }
        """
    Given url postUrl
    And header X-Tenant-Code = tenant
    And header Content-Type = 'application/vnd.internal.app+json'
    And request newPostProfilesReferenceId
    When method POST
    Then status 200