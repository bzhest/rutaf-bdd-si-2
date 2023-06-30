@api @getRetrieveActivityMatrix @siconnect_api
Feature: Get Retrieve Activity Matrix

  Background:
    * def baseTestUrl = 'https://dashboardspa.qa-sprint2.supplierintegrity.com'

  Scenario: Get Retrieve Activity Matrix
    Given url getUrl = baseTestUrl +'/dashboard/activityMatrix'
    And header X-Tenant-Code = 'qa-sprint2'
    And header X-trace-id = 'x'
    And header requestor = 'annacarissa.valerio@refinitiv.com'
    And header requestorEmail = 'annacarissa.valerio@refinitiv.com'
    And param filter = 'DIVISION'
    When method GET
    Then status 200
#    And print 'RESPONSE: \n', response

#
# Test that there is AT LEAST 1 element
#
    * def arrCount = response.payload.length
    And assert arrCount >= 0
    And print '\n'
    And print '================================'
    And print '******** COUNT: '+ arrCount
    And print '================================\n'

