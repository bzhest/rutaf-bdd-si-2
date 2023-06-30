@api @deleteCasesUnassignCaseByCaseSystemId @siconnect_api
Feature: Delete Unassign Case by Case System Id

  Background:
    * def deleteUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com' +'/cases' +'/5jb726g7vpqk1fnxxt2nol23r' +'/assignee'

  Scenario: Delete Unassign Case by Case System Id
    Given url deleteUrl
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    When method DELETE
    Then status 200
#    TODO add response validation and migrate all tests
