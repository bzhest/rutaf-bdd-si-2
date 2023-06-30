@api @postCreateCase @siconnect_api
Feature: Post Create Case

  Background:
    * def baseUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com'
#    * def baseUrl = 'https://wc1-qa2.poc.dev.centre.rdd.refinitiv.com'
    * def nowMs = function(){ return java.lang.System.currentTimeMillis() }
    * def caseId = 'caseId_' + nowMs()



  Scenario: Post Create Case



  #
  # Create case
  #
    * def postRequestBody =
        """
          {
            "caseId": #(caseId),
            "customFields": [
            ],
            "entityType": "ORGANISATION",
            "groupId": "5jb7muaehjz01fh4z5d9wjzw5",
            "name": "ExxonMobile",
            "nameTransposition": true,
            "providerTypes": [
                "WATCHLIST",
                "CLIENT_WATCHLIST"
            ],
            "secondaryFields": [
            ]
          }
        """
    Given url postUrl = baseUrl +'/cases'
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    And request postRequestBody
    And method POST
    And status 200
    And match response.payload.caseId == caseId
    * def caseSystemId = response.payload.caseSystemId
    And print '\n'
    And print '================================'
    And print '******** caseSystemId = '+ caseSystemId
    And print '================================\n'
    And print '\n'
  #
  # Archive case
  #
    Given url putArchiveUrl = baseUrl +'/cases'
    And path caseSystemId +'/archive'
    * def putArchiveRequestBody =
        """
          {
          }
        """
    And header Authorization = "Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0="
    And request putArchiveRequestBody
    When method PUT
    Then status 204
    And print '\n'
    And print '================================'
    And print '******** caseSystemId = '+ caseSystemId
    And print '================================\n'
    And print '\n'
  #
  # Unarchive case
  #
    Given url deleteUnarchiveUrl = baseUrl +'/cases'
    And path caseSystemId +'/archive'
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    When method DELETE
    Then status 204
    And print '\n'
    And print '================================'
    And print '******** caseSystemId = '+ caseSystemId
    And print '================================\n'
    And print '\n'
  #
  # Archive case (again, prior to delete case)
  #
    Given url putArchiveAgainUrl = baseUrl +'/cases'
    And path caseSystemId +'/archive'
    * def putArchiveAgainRequestBody =
        """
          {
          }
        """
    And header Authorization = "Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0="
    And request putArchiveAgainRequestBody
    When method PUT
    Then status 204
    And print '\n'
    And print '================================'
    And print '******** caseSystemId = '+ caseSystemId
    And print '================================\n'
    And print '\n'
  #
  # Delete case
  #
    Given url deleteUrl = baseUrl +'/cases'
    And path caseSystemId
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    When method DELETE
    Then status 204
    And print '\n'
    And print '================================'
    And print '******** caseSystemId = '+ caseSystemId
    And print '================================\n'
    And print '\n'
