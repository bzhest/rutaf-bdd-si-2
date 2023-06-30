@api @postProfileByProfileIdPEP @siconnect_api
Feature: Post Profile by Profile Id PEP

  Background:
    * def baseTestUrl_nightly = 'https://nightly.iwpro.api.integrawatch.com'
    * def baseTestUrl_siconnect = 'https://siconnect.qa-sprint2.supplierintegrity.com'
    * def baseTestUrl_worldcheck = 'https://worldcheck.qa-sprint2.supplierintegrity.com'

    * def referenceId =  'e_tr_wci_6131570'



  Scenario: Post Profile by Profile Id PEP - ENV: 'nightly'
    * def requestBody =
        """
          {
          }
        """
    Given url postUrl = baseTestUrl_nightly
    And path 'reference/profile', referenceId, 'pep'
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    And request requestBody
    When method POST
    Then status 200
    And print 'RESPONSE: \n', response



  Scenario: Post Profile by Profile Id PEP - ENV: 'siconnect'
    * def requestBody =
        """
          {
          }
        """
    Given url postUrl = baseTestUrl_siconnect
    And path 'api/v1/profiles', referenceId, 'pep'
    And header X-Tenant-Code = 'qa-sprint2'
    And header X-trace-id = 'x'
    And header requestor = 'annacarissa.valerio@refinitiv.com'
    And header requestorEmail = 'annacarissa.valerio@refinitiv.com'
    And header Content-Type = 'application/vnd.internal.app+json'
#   And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    And request requestBody
    When method POST
    Then status 200
    And print 'RESPONSE: \n', response



  Scenario: Post Profile by Profile Id PEP - ENV: 'worldcheck'
    * def requestBody =
        """
          {
          }
        """
    Given url postUrl = baseTestUrl_worldcheck
    And path 'reference/profile', referenceId, 'pep'
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    And request requestBody
    When method POST
    Then status 200
    And print 'RESPONSE: \n', response