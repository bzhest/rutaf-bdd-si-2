@api @getCasesCaseByCaseSystemId @siconnect_api
Feature: Get Case Details by Case System Id

  Background:
    * def getUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com' +'/cases' +'/5jb7i8k5wgod1fna25awdu0og'

  Scenario: Retrieve case details by case system id
    Given url getUrl
    And header Authorization = "Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0="
    And param aggregatedSummary = true
    When method GET
    Then status 200
#    TODO add response validation and migrate all tests
