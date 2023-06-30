@api @postCreateCaseWSyncScreening @siconnect_api
Feature: Post Create Case With Synchronous Screening

  Background:
    * def baseUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com'
    * def nowMs = function(){ return java.lang.System.currentTimeMillis() }
    * def caseId = 'case_id_' + nowMs()


  Scenario: Post Create Case With Synchronous Screening
    * def postRequestBody =
        """
          {
            "caseId": '#(caseId)',
            "customFields": [
            ],
            "entityType": "ORGANISATION",
            "fields": [
            ],
            "groupId": "5jb7muaehjz01fh4z5d9wjzw5",
            "matchStrengthThreshold": "WEAK",
            "name": "ExxonMobile",
            "nameTransposition": true,
            "pageSize": 10,
            "providerTypes": [
                "WATCHLIST",
                "CLIENT_WATCHLIST"
            ],
            "secondaryFields": [
            ]
          }
        """
    Given url postUrl = baseUrl +'/cases' +'/screeningRequest'
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    And request postRequestBody
    When method POST
    Then status 200
#    TODO add response validation and migrate all tests
