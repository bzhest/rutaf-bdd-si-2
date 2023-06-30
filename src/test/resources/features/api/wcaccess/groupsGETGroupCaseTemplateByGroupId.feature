@api @getGroupCaseTemplateByGroupId @siconnect_api
Feature: Get Group Case Template by Group Id

  Background:
    * def getUrl = 'https://nightly.iwpro.api.integrawatch.com/groups' +'/5jb6818vag7o1fi12uwekwd2y' +'/caseTemplate'

  Scenario: Retrieve all Groups
    Given url getUrl
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    When method GET
    Then status 200
#    TODO add response validation and migrate all tests
