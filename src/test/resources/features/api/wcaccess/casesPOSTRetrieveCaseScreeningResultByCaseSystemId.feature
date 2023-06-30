@api @postCaseRetrieveCaseScreeningResultByCaseSystemId @siconnect_api
Feature: Post Case Retrieve Case Screening Result by Case System Id

  Background:
    * def postUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com' +'/cases' +'/5jb726g7vpqk1fnxxt2nol23r' +'/results'

  Scenario: Post Case Retrieve Case Screening Result by Case System Id
    * def newPostRequestBody =
        """
          {
            "conStatusIds": [],
            "fetchType": "ALL",
            "fields": [],
            "matchStrengthThreshold": "WEAK",
            "pagination": {
              "currentPage": 0,
              "itemsPerPage": 10
            },
            "submittedTerm": "Exxon"
          }
        """
    Given url postUrl
    And param refresh = false
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    And header X-Resolution-Ids = '[ "5jb6o99t25101fegoz126wjxb", "5jb7rc2ud9e41fegrmi61458e", "5jb6o99t25101fegoz126wjxg", "5jb7rc2ud9e41fegrmi61458j", "5jb6o99t25101fegoz126wjxm", "5jb7rc2ud9e41fegrmi61458p", "5jb6o99t25101fegoz126wjxp", "5jb7rc2ud9e41fegrmi61458s" ]'
    And request newPostRequestBody
    When method POST
    Then status 200
#    TODO add response validation and migrate all tests
