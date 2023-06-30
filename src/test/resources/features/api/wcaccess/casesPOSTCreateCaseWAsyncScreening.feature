@api @postCreateCaseWAsyncScreening @siconnect_api
Feature: Post Create Case With Asynchronous Screening

  Background:
    * def postUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com' +'/cases' +'/5jb726g7vpqk1fnxxt2nol23r' +'/screeningRequest'


  Scenario: Post Create Case With Asynchronous Screening
    * def newPostRequestBody =
        """
          {
          }
        """
    Given url postUrl
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    And request newPostRequestBody
    When method POST
    Then status 200
#    TODO add response validation and migrate all tests
