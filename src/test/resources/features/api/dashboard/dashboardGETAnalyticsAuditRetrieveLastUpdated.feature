@api @getRetrieveAnalyticsAuditLastUpdated @siconnect_api
Feature: Get Retrieve Analytics Audit Last Updated

  Background:
    * def baseTestUrl = 'https://dashboardspa.qa-sprint2.supplierintegrity.com'

  Scenario: Get Retrieve Analytics Audit Last Updated
    Given url getUrl = baseTestUrl +'/analyticsAudit/lastUpdated'
    And header X-Tenant-Code = 'qa-sprint2'
    And header X-trace-id = 'x'
    And header requestor = 'annacarissa.valerio@refinitiv.com'
    And header requestorEmail = 'annacarissa.valerio@refinitiv.com'
    When method GET
    Then status 200
#    And print 'RESPONSE: \n', response

#
# Test that lastUpdated is epoch time
#
    * def fnConvertEpochTimeToISODatetime =
      """
        function( epochTime ) {
          var isoDatetime = '';
          try {
            isoDatetime = new Date( parseInt(epochTime) ).toISOString();
          }
          catch( e ) {
            isoDatetime = -1;
            karate.log( '#### Date parse error: ', epochTime );
          }
          return isoDatetime;
        }
      """
    * def lastUpdated = response.payload
    And assert lastUpdated > 0

    * def isoDatetime = call fnConvertEpochTimeToISODatetime lastUpdated
    And print '\n'
    And print '================================'
    And print '******** lastUpdated: '+ lastUpdated
    And print '******** isoDatetime: '+ isoDatetime
    And print '================================\n'

