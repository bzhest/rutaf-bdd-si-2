@api @postOgsRetrieveAllOgsUpdatesSummary @siconnect_api
Feature: Post Retrieve All OGS Updates Summary

  Background:
    * def baseTestUrl = ogsBaseTestUrl
#    * def baseTestUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com'
#    * def baseTestUrl = 'https://nightly.iwpro.api.integrawatch.com'
    * def basicAuth = ogsBasicAuth



    * def fnGetTodayISODate =
      """
        function() {
          var todayDate = new Date();
          return todayDate.toISOString();
        }
      """
    * def fnGetISODateOfFirstDayOfMonth =
      """
        function( givenDateISO ) {
          var givenDate = new Date( givenDateISO );
          var day01Date = new Date( givenDate.getFullYear(), givenDate.getMonth(), 1 );
          day01Date.setHours( day01Date.getHours() - day01Date.getTimezoneOffset()/60 );
          var day01OfMonthISO = day01Date.toISOString();
          return day01OfMonthISO;
        }
      """

    * def todayISODate = call fnGetTodayISODate
    * def day01OfMonthISODate = call fnGetISODateOfFirstDayOfMonth todayISODate
#    * def isoDateTime = '2021-07-01T00:00:00.000Z'

  Scenario: Post Retrieve All OGS Updates Summary

#    * def postRequestBody =
#        """
#          {
#            "updateDate": '#( day01OfMonthISODate )'
#          }
#        """

    * def postRequestBody =
        """
          {
            "updateDate": '2021-12-20T00:00:00.000Z'
          }
        """

    Given url postUrl = baseTestUrl +'/cases/ongoingScreeningUpdates/summarized'
    And header Authorization = 'Basic '+ basicAuth
    And request postRequestBody
    When method POST
    Then status 200

#    And print 'RESPONSE: \n', response

    * def arrCount = response.payload.length
    And print '\n'
    And print '================================'
    And print '******** SUMMARY COUNT: '+ arrCount
    And print '******** updateDate:    '+ day01OfMonthISODate
    And print '================================\n'
    And print '\n'
