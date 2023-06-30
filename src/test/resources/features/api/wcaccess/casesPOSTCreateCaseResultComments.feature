@api @postCreateCaseResultComments @siconnect_api
Feature: Post Create Case Result Comments

  Background:
    * def baseUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com'

  Scenario: Post Create Case Result Comments
    * def requestBody =
        """
          {
            "comment": "This is a sample comment",
            "userDisplayName": "Jerome Miguel Tiausas",
            "userId": "5jb7dayxj7p11fegqdo6qz9o1"
          }
        """
    Given url postUrl = baseUrl +'/cases' +'/results' +'/5jb7ekd7c44j1fnxxt4n7ad0h' +'/comments'
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    And request requestBody
    When method POST
    Then status 200
#    TODO add response validation and migrate all tests
