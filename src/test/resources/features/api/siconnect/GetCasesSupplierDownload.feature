@api @siconnect_api
Feature: Download Supplier Screening Results to CSV

  As a user,
  I want an ability to export supplier screening profile to CSV file.
  So that I can export the information to CSV file.

  Background:
    * def downloadUrl = baseUrl + version + '/cases/supplier/' + staticSupplierId + '/download'
    * def screenResultsUrl = baseUrl + version + '/cases/supplier/' + staticSupplierId + '?pageSize=100'
    * def repUtil = Java.type("com.refinitiv.asts.test.utils.ScreeningCSVReportBuilder")

  Scenario: Check ability to download supplier screening report with correct screening results
    Given header X-Tenant-Code = tenant
    And url screenResultsUrl
    And method GET
    And status 200
    And def expResp = repUtil.getSupplierReport(response)
    And header X-Tenant-Code = tenant
    And url downloadUrl
    When method GET
    Then status 200
    And match response contains expResp