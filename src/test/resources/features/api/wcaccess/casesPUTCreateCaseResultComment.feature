@api @putCasesCreateCaseResultComment @siconnect_api
Feature: Put Create Case Result Comment

  Background:
    * def baseUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com'

  Scenario: Put Create Case Result Comment
    * def requestBody =
        """
          {
            "comment": "Comment modified"
          }
        """
    Given url putUrl = baseUrl +'/cases/results' +'/5jb876beo0zi1fpf64h0ijnp2' +'/comments' +'/60b9ad39c1e48f5f59d9be46'
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    And request requestBody
    When method PUT
    Then status 200
#    TODO add response validation and migrate all tests
