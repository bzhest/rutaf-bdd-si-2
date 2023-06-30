@api @postMonitorUserActivity @siconnect_api
Feature: Post Monitor User Activity

  Background:
    * def baseUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com'

  Scenario: Post Monitor User Activity
    * def requestBody =
        """
          {
            "cursorOptions": {
              "itemsPerPage": 2
            },
            "query": ""
          }
        """
    Given url postUrl = baseUrl +'/cases' +'/summaries'
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    And request requestBody
    When method POST
    Then status 200
#    TODO add response validation and migrate all tests
