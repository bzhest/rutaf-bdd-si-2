@api @postOgsRetrieveAllOgsUpdates @siconnect_api
Feature: Post Retrieve All OGS Updates

  Background:
    * def baseTestUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com'
#    * def baseTestUrl = 'https://nightly.iwpro.api.integrawatch.com'
    * def fnGetTodayDateISO =
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

    * def todayISODate = call fnGetTodayDateISO
    * def day01OfMonthISODate = call fnGetISODateOfFirstDayOfMonth todayISODate
#    * def isoDatetime = '2021-07-01T00:00:00.000Z'

  Scenario: Post Retrieve All OGS Updates
    * def postRequestBody =
        """
          {
            "pagination": {
              "currentPage": 1,
              "itemsPerPage": 10
            },
            "query": #( 'updateDate>='+ day01OfMonthISODate ),
            "sort" : [
              {
                "columnName" : "updateDate",
                "order" : "ASCENDING"
              }
            ]
          }
        """
    Given url postUrl = baseTestUrl +'/cases/ongoingScreeningUpdates'
    And header Authorization = 'Basic ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0='
    And request postRequestBody
    When method POST
    Then status 200
#    And print 'RESPONSE: \n', response

#
# Test that there is AT LEAST 1 record
#
    * def arrCount = response.payload.results.length
    * def totalResultCount = response.payload.totalResultCount
    * def itemsPerPage = response.payload.pagination.itemsPerPage
    * def totalItems = response.payload.pagination.totalItems
    * def currentPage = response.payload.pagination.currentPage
    * def totalPages = '(not specified)'
    And assert arrCount >= 0
    And match arrCount == totalResultCount

    And print '\n'
    And print '================================'
    And print '******** NOWDT: '+ todayISODate
    And print '******** DAY01: '+ day01OfMonthISODate
    And print '******** PGLIM: '+ itemsPerPage
    And print '******** COUNT: '+ arrCount +'/'+ totalItems +' (chk TOTAL: '+ totalResultCount +')'
    And print '******** PAGES: '+ currentPage +'/'+ totalPages
    And print '================================\n'
    And print '\n'
