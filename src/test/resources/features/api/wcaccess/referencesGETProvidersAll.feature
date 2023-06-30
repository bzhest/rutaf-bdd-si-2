@api @getReferenceProvidersAll @siconnect_api
Feature: Get All Reference Countries

  Background:
    * def getUrl = 'https://nightly.iwpro.api.integrawatch.com/reference/providers'

  Scenario: Retrieve all Reference Countries
    Given url getUrl
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    When method GET
    Then status 200
#    TODO add response validation and migrate all tests
