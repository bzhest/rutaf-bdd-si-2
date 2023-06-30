@api @getRetrieveRenewalVolume @siconnect_api
Feature: Get Retrieve Renewal Volume

  Background:
    * def baseTestUrl = 'https://dashboardspa.qa-sprint2.supplierintegrity.com'

  Scenario: Get Retrieve Renewal Volume
    Given url getUrl = baseTestUrl +'/dashboard/renewalVolume'
    And header X-Tenant-Code = 'qa-sprint2'
    And header X-trace-id = 'x'
    And header requestor = 'annacarissa.valerio@refinitiv.com'
    And header requestorEmail = 'annacarissa.valerio@refinitiv.com'
    And param filter = 'DIVISION'
    When method GET
    Then status 200
#    And print 'RESPONSE: \n', response

#
# Test that there is AT LEAST 1 record
#
    * def arrCount = response.payload.length
    And assert arrCount > 0
    And print '\n'
    And print '================================'
    And print '******** COUNT: '+ arrCount
    And print '================================\n'

#
# Test when filter = 'USER'
#
    * param filter = 'USER'
    And header X-Tenant-Code = 'qa-sprint2'
    And header X-trace-id = 'x'
    And header requestor = 'annacarissa.valerio@refinitiv.com'
    And header requestorEmail = 'annacarissa.valerio@refinitiv.com'
    When method GET
    Then status 200
#    And print 'RESPONSE: \n', response

#
# Test that there is AT LEAST 1 record
#
    * def arrCount = response.payload.length
    And assert arrCount > 0
    And print '\n'
    And print '================================'
    And print '******** COUNT: '+ arrCount
    And print '================================\n'


