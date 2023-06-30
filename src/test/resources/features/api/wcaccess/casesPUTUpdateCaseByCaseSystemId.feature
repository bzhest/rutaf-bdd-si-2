@api @putCasesUpdateCaseByCaseSystemId @siconnect_api
Feature: Put Update Case by Case System Id

  Background:
    * def putUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com' +'/cases' +'/5jb726g7vpqk1fnxxt2nol23r'

  Scenario: Put Update Case by Case System Id
    * def newPutRequestBody =
        """
          {
            "caseId": "5nzbfkdrgika1fbqw1my25ex5",
            "customFields": [],
            "entityType": "ORGANISATION",
            "groupId": "5jb7muaehjz01fh4z5d9wjzw5",
            "name": "ExxonMobil",
            "nameTransposition": true,
            "providerTypes": [
                "WATCHLIST",
                "CLIENT_WATCHLIST"
            ],
            "secondaryFields": []
          }
        """
    Given url putUrl
    And header Authorization = "Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0="
    And request newPutRequestBody
    When method PUT
    Then status 200
#    TODO add response validation and migrate all tests
