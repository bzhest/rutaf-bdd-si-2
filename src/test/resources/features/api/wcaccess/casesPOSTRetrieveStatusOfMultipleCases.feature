@api @postRetrieveStatusOfMultipleCases @siconnect_api
Feature: Post Retrieve Status of Multiple Cases

  Background:
    * def baseUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com'

  Scenario: Post Retrieve Status of Multiple Cases
    * def requestBody =
        """
          {
            "screeningStatusRequests": [
              {
                "caseSystemId": "5jb726g7vpqk1fnxxt2nol23r",
                "dateFrom": "2011-05-18T08:45:25.610+0000"
              }
            ]
          }
        """
    Given url postUrl = baseUrl +'/cases' +'/screeningStatus'
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    And request requestBody
    When method POST
    Then status 200
#    TODO add response validation and migrate all tests
