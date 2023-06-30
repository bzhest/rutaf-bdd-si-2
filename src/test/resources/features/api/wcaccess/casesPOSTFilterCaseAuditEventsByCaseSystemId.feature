@api @postFilterCaseAuditEventsByCaseSystemId @siconnect_api
Feature: Post Filter Case Audit Events by Case System Id

  Background:
    * def baseUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com'

  Scenario: Post Filter Case Audit Events by Case System Id
    * def requestBody =
        """
          {
            "pagination": {
              "currentPage": 1,
              "itemsPerPage": 2
            },
            "query": ""
          }
        """
    Given url postUrl = baseUrl +'/cases' +'/5jb726g7vpqk1fnxxt2nol23r' +'/auditEvents'
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    And request requestBody
    When method POST
    Then status 200
#    TODO add response validation and migrate all tests
