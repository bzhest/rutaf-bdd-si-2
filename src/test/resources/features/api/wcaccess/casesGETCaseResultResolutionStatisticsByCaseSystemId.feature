@api @getCasesCaseResultResolutionStatistics @siconnect_api
Feature: Get Case Details by Case System Id

  Background:
    * def getUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com' +'/cases' +'/5jb726g7vpqk1fnxxt2nol23r' +'/results/resolution/statistics'

  Scenario: Retrieve case details by case system id
    Given url getUrl
    And header Authorization = "Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0="
    And header X-Group-Id = "5jb7muaehjz01fh4z5d9wjzw5"
    And header X-Resolution-Ids = '[ "5jb6o99t25101fegoz126wjxb", "5jb7rc2ud9e41fegrmi61458e", "5jb6o99t25101fegoz126wjxg", "5jb7rc2ud9e41fegrmi61458j", "5jb6o99t25101fegoz126wjxm", "5jb7rc2ud9e41fegrmi61458p", "5jb6o99t25101fegoz126wjxp", "5jb7rc2ud9e41fegrmi61458s" ]'
    And header X-Match-Strength = "MEDIUM"
    When method GET
    Then status 200
#    TODO add response validation and migrate all tests
