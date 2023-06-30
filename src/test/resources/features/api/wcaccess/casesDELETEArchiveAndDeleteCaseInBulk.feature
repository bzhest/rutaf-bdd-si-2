@api @deleteCasesArchiveAndDeleteCaseInBulk @siconnect_api
Feature: Archive And Delete Case in Bulk

  Background:
    * def baseUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com'

  Scenario: Archive And Delete Case in Bulk
    * def requestBody =
        """
          [
            "xxxxx",
            "xxxxx",
            "xxxxx"
          ]
        """
    Given url deleteUrl = baseUrl +'/cases/bulk/delete'
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    And request requestBody
    When method DELETE
    Then status 200
#    TODO add response validation and migrate all tests
