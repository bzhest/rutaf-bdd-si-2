@api @patchReplaceUpdatedUpdateIndicatorOfCaseResult @siconnect_api
Feature: Patch Replace UPDATED Update Indicator of Case Result

  Background:
    * def baseUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com'

  Scenario: Patch Replace UPDATED Update Indicator of Case Result
    * def requestBody =
        """
          {
          }
        """
    Given url patchUrl = baseUrl +'/cases_screenings' +'/5jb726g7vpqk1fnxxt2nol23r' +'/results' +'/5jb7ekd7c44j1fnxxt4n7ad0d'
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
#   And request requestBody
    When method PATCH
    Then status 200
#    TODO add response validation and migrate all tests
