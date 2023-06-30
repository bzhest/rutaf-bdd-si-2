@api @postDelegateReviewByCaseSystemIdAndResultId @siconnect_api
Feature: Post Delegate Review by Case System Id and Result Id

  Background:
    * def baseUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com'

  Scenario: Post Delegate Review by Case System Id and Result Id
    * def requestBody =
        """
          {
          }
        """
    Given url postUrl = baseUrl +'/cases' +'/5jb726g7vpqk1fnxxt2nol23r' +'/results' +'/5jb7ekd7c44j1fnxxt4n7ad0p'  +'/review/delegate'
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    And request requestBody
    When method POST
    Then status 204
#    TODO add response validation and migrate all tests
