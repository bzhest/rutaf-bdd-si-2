@api @putCasesAssignCaseToUserId @siconnect_api
Feature: Put Assign Case to User Id

  Background:
    * def putUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com' +'/cases' +'/5jb726g7vpqk1fnxxt2nol23r' +'/assignee'

  Scenario: Put Assign Case to User Id
    * def newPutRequestBody =
        """
          {
            "userId": "5jb71et83b1u1fegq9w1m7gr9"
          }
        """
    Given url putUrl
    And header Authorization = "Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0="
    And request newPutRequestBody
    When method PUT
    Then status 200
#    TODO add response validation and migrate all tests
