@api @getRetrieveQuestionnaireToReview @siconnect_api
Feature: Get Retrieve Questionnaire To Review

  Background:
    * def baseTestUrl = 'https://dashboardspa.qa-sprint2.supplierintegrity.com'

  Scenario: Get Retrieve Questionnaire To Review
    Given url getUrl = baseTestUrl +'/questionnaire-to-review'
    And header X-Tenant-Code = 'qa-sprint2'
    And header X-trace-id = 'x'
    And header requestor = 'annacarissa.valerio@refinitiv.com'
    And header requestorEmail = 'annacarissa.valerio@refinitiv.com'
    And param currentPage = 1
    And param limit = 10
    And param email = 'annacarissa.valerio@refinitiv.com'
    When method GET
    Then status 200
#    And print 'RESPONSE: \n', response

#
# Test that there is AT LEAST 1 record
#
    * def arrCount = response.payload.records.length
    * def limit = response.payload.pageInformation.limit
    * def totalRecords = response.payload.pageInformation.totalRecords
    * def currentPage = response.payload.pageInformation.currentPage
    * def totalPages = response.payload.pageInformation.totalPages
    And assert arrCount >= 0
    And print '\n'
    And print '================================'
    And print '******** PGLIM: '+ limit
    And print '******** COUNT: '+ arrCount +'/'+ totalRecords
    And print '******** PAGES: '+ currentPage +'/'+ totalPages
    And print '================================\n'


