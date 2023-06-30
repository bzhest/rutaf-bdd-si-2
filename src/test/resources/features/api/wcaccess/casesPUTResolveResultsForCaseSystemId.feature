@api @putCasesResolveResultsForCaseSystemId @siconnect_api
Feature: Put Resolve Results for Case System Id

  Background:
    * def baseUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com'

  Scenario: Put Resolve Results for Case System Id
    * def putRequestBody =
        """
          {
            "reasonId": "5jb6o99t25101fegoz126wjx6",
            "resolutionRemark": "TEST REMARK",
            "resultIds": [
              "5jb7ekd7c44j1fnxxt4n7ad0l"
            ],
            "riskId": "5jb6o99t25101fegoz126wjxa",
            "statusId": "5jb6o99t25101fegoz126wjxp"
          }
        """
    Given url putUrl = baseUrl +'/cases' +'/5jb726g7vpqk1fnxxt2nol23r' +'/results/resolution'
    And header Authorization = "Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0="
    And header X-Resolution-Ids = '[ "5jb6o99t25101fegoz126wjxb", "5jb7rc2ud9e41fegrmi61458e", "5jb6o99t25101fegoz126wjxg", "5jb7rc2ud9e41fegrmi61458j", "5jb6o99t25101fegoz126wjxm", "5jb7rc2ud9e41fegrmi61458p", "5jb6o99t25101fegoz126wjxp", "5jb7rc2ud9e41fegrmi61458s" ]'
    And header X-Group-Id = '5jb7muaehjz01fh4z5d9wjzw5'
    And request putRequestBody
    When method PUT
    Then status 204
#    TODO add response validation and migrate all tests
