@ignore @getAccessToken
Feature: Get Access Token



  Background:

  Scenario: Get Access Token

    * print '================================'
    * print '******** accessTokenUrl  = '+ accessTokenUrl
    * print '================================'

    Given url getUrl = accessTokenUrl
    And path 'token'
    And header Authorization =  'Basic ' + headerAuth
    And header Content-Type =   'application/x-www-form-urlencoded'
    And header Accept =         '*/*'
    And form field grant_type = 'client_credentials'
    When method POST
    Then status 200
