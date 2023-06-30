@api @postProfileByProfileId @siconnect_api
Feature: Post Profile by Profile Id

  Background:
#   * def postUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com' +'/reference/profile' +'/e_tr_wco_1423149'
    * def postUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com' +'/reference/profile' +'/e_tr_wci_6131570'

  Scenario: Post Profile by Profile Id
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



