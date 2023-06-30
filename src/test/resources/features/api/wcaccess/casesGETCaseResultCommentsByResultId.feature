@api @getCasesCaseResultCommentsByResultId @siconnect_api
Feature: Get Case Result Comments by Result Id

  Background:
    * def getUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com' +'/cases/results' +'/5jb7ekd7c44j1fnxxt4n7ad0h' +'/comments' +'?page=1&size=10'


  Scenario: Get Case Result Comments by Result Id
    Given url getUrl
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    When method GET
    Then status 200
#    TODO add response validation and migrate all tests
