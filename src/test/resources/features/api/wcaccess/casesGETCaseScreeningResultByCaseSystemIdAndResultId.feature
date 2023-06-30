@api @getCasesCaseScreeningResultByCaseSystemIdAndResultId @siconnect_api
Feature: Get Case Screening Result by Case System Id and Result Id

  Background:
    * def getUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com' +'/cases' +'/5jb726g7vpqk1fnxxt2nol23r' +'/results' +'/5jb7ekd7c44j1fnxxt4n7ad0h'


  Scenario: Case Screening Result by Case System Id and Result Id
    Given url getUrl
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    When method GET
    Then status 200
#    TODO add response validation and migrate all tests
