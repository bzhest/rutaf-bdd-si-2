@api @postOgsRetrieveAllOgsUpdatesSpecificCase @siconnect_api
Feature: Post Retrieve All OGS Updates Specific Case

  Background:
    * def baseTestUrl = ogsBaseTestUrl
#    * def baseTestUrl = 'https://worldcheck.qa-sprint2.supplierintegrity.com'
#    * def baseTestUrl = 'https://nightly.iwpro.api.integrawatch.com'
#    * def caseSysemId = '5jb726g7vpqk1fnxxt2nol23r'
#    * def isoDateTime = '2021-07-01T00:00:00.000Z'
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



  Scenario: Post Retrieve All OGS Updates Specific Case

#
# Retrieve all OGS updates after specified datetime
#
    * def requestBody_allOGSUpdates =
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
    Given url postUrl_allOGSUpdates = baseTestUrl +'/cases/ongoingScreeningUpdates'
    And header Authorization = 'Basic '+ basicAuth
    And request requestBody_allOGSUpdates
    When method POST
    Then status 200

#    And print 'RESPONSE: \n', response

# Check that 'totalItems' => 0
    * def totalItems = response.payload.pagination.totalItems
    * def resultsCount = response.payload.results.length
    And assert totalItems >= 0

    And print '\n'
    And print '================================'
    And print '******** RESULTS COUNT: '+ resultsCount +'/'+ totalItems
    And print '================================\n'
    And print '\n'

    * if ( totalItems == 0 ) karate.abort()



#
# Pick a 'caseSystemId'
#

#    * def caseSystemId = response.payload.results[0].caseSystemId
    * def caseSystemId = '5jb6ik383e541fqupy4wzymm2'
    And print '\n'
    And print '================================'
    And print '******** SPECIFIC caseSystemId: '+ caseSystemId
    And print '================================\n'
    And print '\n'



#
# Retrieve all OGS updates for selected 'caseSystemId'
#

    * def requestBody_specificCase =
        """
          {
            "caseSystemId": #( caseSystemId ),
            "updateDate": #( day01OfMonthISODate )
          }
        """

    Given url postUrl_specificCase = baseTestUrl
    And path '/cases/ongoingScreeningUpdates/specific_case'
    And header Authorization = 'Basic '+ basicAuth

  #    'qa-sprint2'
  #    And header X-Group-Id = '5jb7muaehjz01fh4z5d9wjzw5'
  #    'nightly'
    And header X-Group-Id = '5jb8i0yzkrxw1fh3zllu8ityn'

    And header X-Match-Strength = 'WEAK'

  #    And header X-Resolution-Ids = '[ "5jb6o99t25101fegoz126wjxb", "5jb7rc2ud9e41fegrmi61458e", "5jb6o99t25101fegoz126wjxg", "5jb7rc2ud9e41fegrmi61458j", "5jb6o99t25101fegoz126wjxm", "5jb7rc2ud9e41fegrmi61458p", "5jb6o99t25101fegoz126wjxp", "5jb7rc2ud9e41fegrmi61458s" ]'
    And header X-Resolution-Ids = '[ "5jb6o99t25101fegoz126wjxb","5jb7rc2ud9e41fegrmi61458e",  "5jb6o99t25101fegoz126wjxg","5jb7rc2ud9e41fegrmi61458j", "UNRESOLVED",  "5jb6o99t25101fegoz126wjxm","5jb7rc2ud9e41fegrmi61458p",  "5jb6o99t25101fegoz126wjxp","5jb7rc2ud9e41fegrmi61458s" ]'

    And header X-Allowed-Resolution-For-Updates = '[ "POSITIVE","POSSIBLE" ]'
    And request requestBody_specificCase
    When method POST
    Then status 200

    And print 'RESPONSE: \n', response

    * def arrCount = response.payload.screeningUpdates.length
    And assert arrCount >= 0

    And print '\n'
    And print '================================'
    And print '******** SPECIFIC caseSystemId: '+ caseSystemId
    And print '******** COUNT: '+ arrCount
    And print '================================\n'
    And print '\n'
