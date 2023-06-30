@api @siconnect_api
Feature: Download Contact Screening Results to CSV

  As a user,
  I want an ability to export contact screening profile to CSV file.
  So that I can export the information to CSV file.

  Background:
    * def downloadUrl = baseUrl + version + '/cases/contact/' + staticContactId + '/download'
    * def screenResultsUrl = baseUrl + version + '/cases/contact/' + staticContactId + '?pageSize=100'
    * def repUtil = Java.type("com.refinitiv.asts.test.utils.ScreeningCSVReportBuilder")

  Scenario: Check ability to download contact screening report with correct screening results
    Given header X-Tenant-Code = tenant
    And url screenResultsUrl
    And method GET
    And status 200
    And def expResp = repUtil.getSupplierContactReport(response)
    And header X-Tenant-Code = tenant
    And url downloadUrl
    When method GET
    Then status 200
    And match response contains expResp
