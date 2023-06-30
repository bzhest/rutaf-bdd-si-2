@api @getCasesCaseReferenceByCaseId @siconnect_api
Feature: Get Case Reference by Case Id

  Background:
    * def getUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com' +'/caseReferences' +'?caseId=5jb7i8k5wgod1fna25awdu0of'

  Scenario: Retrieve case reference by case id
    Given url getUrl
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    When method GET
    Then status 200
#    TODO add response validation and migrate all tests
