@api @postCreateMultipleCasesSaveAndScreen @siconnect_api
Feature: Post Create Multiple Cases Save and Screen

  Background:
    * def baseUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com'

  Scenario: Post Create Multiple Cases Save and Screen
  #
  # Create case_0, case_1, case_2,
  #
    * def nowMs_0 = function(){ return java.lang.System.currentTimeMillis() }
    * def caseId_0 = 'caseId_' + nowMs_0()

    * def nowMs_1 = function(){ return java.lang.System.currentTimeMillis() }
    * def caseId_1 = 'caseId_' + nowMs_1()

    * def nowMs_2 = function(){ return java.lang.System.currentTimeMillis() }
    * def caseId_2 = 'caseId_' + nowMs_2()

    * def postRequestBody =
        """
          {
            "caseScreeningState": {
              "WATCHLIST": "INITIAL"
            },
            "cases": [
              {
                "caseId": '#(caseId_0)',
                "customFields": [
                ],
                "entityType": "ORGANISATION",
                "name": "Exxon",
                "secondaryFields": [
                ]
              },
              {
                "caseId": '#(caseId_1)',
                "customFields": [
                ],
                "entityType": "ORGANISATION",
                "name": "Motorola",
                "secondaryFields": [
                ]
              },
              {
                "caseId": '#(caseId_2)',
                "customFields": [
                ],
                "entityType": "ORGANISATION",
                "name": "Nestle",
                "secondaryFields": [
                ]
              }
            ],
            "groupId": "5jb7muaehjz01fh4z5d9wjzw5",
            "nameTransposition": true,
            "providerTypes": [
              "WATCHLIST"
            ]
          }
        """
    Given url postUrl = baseUrl +'/cases/saveAndScreen'
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    And request postRequestBody
    And method POST
    And status 200
    * def caseId_00 = response.payload[0].caseId
    * def caseId_01 = response.payload[1].caseId
    * def caseId_02 = response.payload[2].caseId
    * def caseSystemId_00 = response.payload[0].caseSystemId
    * def caseSystemId_01 = response.payload[1].caseSystemId
    * def caseSystemId_02 = response.payload[2].caseSystemId
    * def name_00 = response.payload[0].name
    * def name_01 = response.payload[1].name
    * def name_02 = response.payload[2].name
    And print '\n'
    And print '================================'
    And print "********     caseId_00 = '"+ caseId_00 +"' | caseSystemId_00 = '"+ caseSystemId_00 +"' | name_00 = '"+ name_00 +"'"
    And print "********     caseId_01 = '"+ caseId_01 +"' | caseSystemId_01 = '"+ caseSystemId_01 +"' | name_01 = '"+ name_01 +"'"
    And print "********     caseId_02 = '"+ caseId_02 +"' | caseSystemId_02 = '"+ caseSystemId_02 +"' | name_02 = '"+ name_02 +"'"
    And print '================================\n'
    And print '\n'
  #
  # Archive case_0
  #
    Given url putArchiveUrl = baseUrl +'/cases'
    And path caseSystemId_00 +'/archive'
    * def putArchiveRequestBody_00 =
        """
          {
          }
        """
    And header Authorization = "Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0="
    And request putArchiveRequestBody_00
    When method PUT
    Then status 204
    And print '\n'
    And print '================================'
    And print '******** caseSystemId_00 = '+ caseSystemId_00
    And print '================================\n'
    And print '\n'
  #
  # Archive case_1
  #
    Given url putArchiveUrl = baseUrl +'/cases'
    And path caseSystemId_01 +'/archive'
    * def putArchiveRequestBody_01 =
        """
          {
          }
        """
    And header Authorization = "Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0="
    And request putArchiveRequestBody_01
    When method PUT
    Then status 204
    And print '\n'
    And print '================================'
    And print '******** caseSystemId_01 = '+ caseSystemId_01
    And print '================================\n'
    And print '\n'
  #
  # Archive case_2
  #
    Given url putArchiveUrl = baseUrl +'/cases'
    And path caseSystemId_02 +'/archive'
    * def putArchiveRequestBody_02 =
        """
          {
          }
        """
    And header Authorization = "Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0="
    And request putArchiveRequestBody_02
    When method PUT
    Then status 204
    And print '\n'
    And print '================================'
    And print '******** caseSystemId_02 = '+ caseSystemId_02
    And print '================================\n'
    And print '\n'
  #
  # Delete case_0
  #
    Given url deleteUrl = baseUrl +'/cases'
    And path caseSystemId_00
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    When method DELETE
    Then status 204
    And print '\n'
    And print '================================'
    And print '******** caseSystemId_00 = '+ caseSystemId_00
    And print '================================\n'
    And print '\n'
  #
  # Delete case_1
  #
    Given url deleteUrl = baseUrl +'/cases'
    And path caseSystemId_01
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    When method DELETE
    Then status 204
    And print '\n'
    And print '================================'
    And print '******** caseSystemId_01 = '+ caseSystemId_01
    And print '================================\n'
    And print '\n'
  #
  # Delete case_2
  #
    Given url deleteUrl = baseUrl +'/cases'
    And path caseSystemId_02
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    When method DELETE
    Then status 204
    And print '\n'
    And print '================================'
    And print '******** caseSystemId_02 = '+ caseSystemId_02
    And print '================================\n'
    And print '\n'