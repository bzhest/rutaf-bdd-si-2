@api @putOgsEnableOgsForACase @siconnect_api
Feature: Put Enable OGS For A Case

  Background:
    * def baseTestUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com'
#    * def baseTestUrl = 'https://nightly.iwpro.api.integrawatch.com'
#    * def caseSystemId = '5jb726g7vpqk1fnxxt2nol23r'
    * def nowMs = function(){ return java.lang.System.currentTimeMillis() }
    * def caseId = 'caseId_' + nowMs()

    * def fnGetTodayDateISO =
      """
        function() {
          var todayDate = new Date();
          return todayDate.toISOString();
        }
      """
    * def fnGetISODateOfFirstDayOfDateMonth =
      """
        function( givenDateISO ) {
          var givenDate = new Date( givenDateISO );
          var day01Date = new Date( givenDate.getFullYear(), givenDate.getMonth(), 1 );
          day01Date.setHours( day01Date.getHours() - day01Date.getTimezoneOffset()/60 );
          var day01OfMonthISO = day01Date.toISOString();
          return day01OfMonthISO;
        }
      """

    * def todayDateISO = call fnGetTodayDateISO
    * def day01OfMonthISO = call fnGetISODateOfFirstDayOfDateMonth todayDateISO



  Scenario: Put Enable OGS For A Case



#
# Create case
#
    * def requestBody_createCase =
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
    Given url postUrl = baseTestUrl
    And path '/cases'
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    And request requestBody_createCase
    And method POST
    And status 200
    And match response.payload.caseId == caseId
    * def caseSystemId = response.payload.caseSystemId
    And print '\n'
    And print '================================'
    And print '******** CREATED: caseSystemId = '+ caseSystemId
    And print '================================\n'
    And print '\n'



#
# Enable OGS screening for created case
#
    * def requestBody_enableOGSScreening =
        """
          {
          }
        """
    Given url putEnableOGSUrl = baseTestUrl
    And path 'cases', caseSystemId, 'ongoingScreening'
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    And request requestBody_enableOGSScreening
    When method PUT
    Then status 204
    And print '\n'
    And print '================================'
    And print '******** ENABLED OGS: caseSystemId = '+ caseSystemId
    And print '================================\n'
    And print '\n'



#
# Verify that OGS is enabled: 'ONGOING'
#
    Given url getCaseUrl = baseTestUrl
    And path 'cases', caseSystemId
    And param aggregatedSummary = true
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    When method GET
    Then status 200
    And def screeningStatus = response.payload.caseScreeningState.WATCHLIST

    And match screeningStatus == 'ONGOING'
    And print '\n'
    And print '================================'
    And print '******** VERIFIED OGS ON: screeningStatus = '+ screeningStatus
    And print '================================\n'
    And print '\n'



#
# Delete OGS screening of selected 'caseSystemId'
#
    * def requestBody_disableOGSScreening =
        """
          {
          }
        """
    Given url deleteDisableUrl = baseTestUrl
    And path '/cases', caseSystemId, 'ongoingScreening'
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    And request requestBody_disableOGSScreening
    When method DELETE
    Then status 204
    And print '\n'
    And print '================================'
    And print '******** DISABLED OGS: caseSystemId = '+ caseSystemId
    And print '================================\n'
    And print '\n'



#
# Verify that OGS is disabled: 'INITIAL'
#
    Given url getCaseUrl = baseTestUrl
    And path 'cases', caseSystemId
    And param aggregatedSummary = true
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    When method GET
    Then status 200
    And def screeningStatus = response.payload.caseScreeningState.WATCHLIST

    And match screeningStatus == 'INITIAL'
    And print '\n'
    And print '================================'
    And print '******** VERIFIED OGS OFF: screeningStatus = '+ screeningStatus
    And print '================================\n'
    And print '\n'


#
# Archive case
#
    Given url putArchiveAgainUrl = baseTestUrl +'/cases'
    And path caseSystemId, '/archive'
    * def requestBody_archiveCase =
        """
          {
          }
        """
    And header Authorization = "Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0="
    And request requestBody_archiveCase
    When method PUT
    Then status 204
    And print '\n'
    And print '================================'
    And print '******** ARCHIVED: caseSystemId = '+ caseSystemId
    And print '================================\n'
    And print '\n'



#
# Delete case
#
    Given url deleteUrl = baseTestUrl +'/cases'
    And path caseSystemId
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    When method DELETE
    Then status 204
    And print '\n'
    And print '================================'
    And print '******** DELETED: caseSystemId = '+ caseSystemId
    And print '================================\n'
    And print '\n'



#
#  Verify that previously deleted 'caseSystemId' is deleted
#
    Given url getCaseUrl = baseTestUrl
    And path 'cases', caseSystemId
    And header Authorization = "Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0="
    And param aggregatedSummary = true
    When method GET
    Then status 500
    And print '\n'
    And print '================================'
    And print '******** VERIFIED DELETED: caseSystemId = '+ caseSystemId
    And print '================================\n'
    And print '\n'