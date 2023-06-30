@ui @full_regression @core_regression @arabica

Feature: Third-party - Media check smart filter

  As an RDDC user
  I want filter panel for media check screening
  So that I can see specific results

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Third-party page

  @C39515433
  Scenario: C39515433: Third Party - Media Check - Filters - Articles - Verify Articles component
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And User should see "Apple" in Media Check Screening Result Table
    When User clicks on Filter icon in Media Check tab
    Then Media check "Articles" accordion in the filter sidebar is expanded by default
    And Media check Articles accordion in the filter sidebar displayed sub-menus
      | Pending Review |
      | Reviewed       |
    And Media check Articles accordion sub-menus articles number in the filter sidebar displayed the correct value
      | Pending Review |
      | Reviewed       |

  @C39515486 @C39515685
  Scenario: C39515486, @C39515685: Third Party - Media Check - Filters - Risk Level - Verify Risk Level component.
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And User should see "Apple" in Media Check Screening Result Table
    And Media check pagination is visible
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks next page
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "MEDIUM"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks next page
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "LOW"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks next page
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "NO_RISK"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks next page
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "UNKNOWN"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media check Smart filter section in the filter sidebar is visible
    And Media check "Risk Level" accordion in the filter sidebar is expanded by default
    And Media Check Risk Level Filter "High" "10" is displayed
    And Media Check Risk Level Filter "Medium" "10" is displayed
    And Media Check Risk Level Filter "Low" "10" is displayed
    And Media Check Risk Level Filter "No Risk" "10" is displayed
    And Media Check Risk Level Filter "Unknown" "10" is displayed
    And Media check "High" Risk Level sub-menu in the filter sidebar is not highlighted
    And Media check "Medium" Risk Level sub-menu in the filter sidebar is not highlighted
    And Media check "Low" Risk Level sub-menu in the filter sidebar is not highlighted
    And Media check "No Risk" Risk Level sub-menu in the filter sidebar is not highlighted
    And Media check "Unknown" Risk Level sub-menu in the filter sidebar is not highlighted
    When User clicks on Risk Level Filter "High" "10"
    And Screening results table is loaded
    Then Media Check Result Table should contain 10 records
    And Media check Smart filter section in the filter sidebar is not visible
    And Media check Risk Level tooltip icon in the filter sidebar is visible with the tooltip message "Filtering is no longer available for records with attached risk level."
    And Media check "High" Risk Level sub-menu in the filter sidebar is highlighted
    And Media check pagination is not visible
    When User clicks on Risk Level Filter "Medium" "10"
    And Screening results table is loaded
    Then Media Check Result Table should contain 10 records
    And Media check Smart filter section in the filter sidebar is not visible
    And Media check Risk Level tooltip icon in the filter sidebar is visible with the tooltip message "Filtering is no longer available for records with attached risk level."
    And Media check "Medium" Risk Level sub-menu in the filter sidebar is highlighted
    And Media check "High" Risk Level sub-menu in the filter sidebar is not highlighted
    And Media check pagination is not visible
    When User clicks on Risk Level Filter "Low" "10"
    And Screening results table is loaded
    Then Media Check Result Table should contain 10 records
    And Media check Smart filter section in the filter sidebar is not visible
    And Media check Risk Level tooltip icon in the filter sidebar is visible with the tooltip message "Filtering is no longer available for records with attached risk level."
    And Media check "Low" Risk Level sub-menu in the filter sidebar is highlighted
    And Media check "Medium" Risk Level sub-menu in the filter sidebar is not highlighted
    And Media check pagination is not visible
    When User clicks on Risk Level Filter "No Risk" "10"
    And Screening results table is loaded
    Then Media Check Result Table should contain 10 records
    And Media check Smart filter section in the filter sidebar is not visible
    And Media check Risk Level tooltip icon in the filter sidebar is visible with the tooltip message "Filtering is no longer available for records with attached risk level."
    And Media check "No Risk" Risk Level sub-menu in the filter sidebar is highlighted
    And Media check "Low" Risk Level sub-menu in the filter sidebar is not highlighted
    And Media check pagination is not visible
    When User clicks on Risk Level Filter "Unknown" "10"
    And Screening results table is loaded
    Then Media Check Result Table should contain 10 records
    And Media check Smart filter section in the filter sidebar is not visible
    And Media check Risk Level tooltip icon in the filter sidebar is visible with the tooltip message "Filtering is no longer available for records with attached risk level."
    And Media check "Unknown" Risk Level sub-menu in the filter sidebar is highlighted
    And Media check "No Risk" Risk Level sub-menu in the filter sidebar is not highlighted
    And Media check pagination is not visible

    @C39783885
    Scenario: C39783885 - Third Party - Media Check - Filters - Risk Level - Verify Articles when some article have been marked "Risk Level"
      When User creates third-party "Apple"
      And User clicks on "MEDIA CHECK" tab
      Then "MEDIA CHECK" tab is displayed
      When User selects Third-party Media Check screening record on position 2
      And User selects risk level as "HIGH"
      And User clicks attach button
      Then Media Check attach modal is displayed
      When User clicks "SAVE" Media Check Attach modal button
      Then Screening results table is loaded
      And Third-party Media Check screening record on position 2 displays High icon
      When User clicks on Filter icon in Media Check tab
      Then Media Check Risk Level Filter "High" "1" is displayed
      When User clicks on Risk Level Filter "High" "1"
      Then Screening results table is loaded
      And Third-party Media Check screening record on position 1 displays High icon
      And Third-party media check article name on position 1 in risk level filter matches with the previous selected article
      And Media Check Result Table should contain 1 records

    @C40112476
    Scenario: C40112476 - Third Party - Media Check - Filters - Risk Level - Verify Risk Level when unselected Risk Level
      When User creates third-party "Apple"
      And User clicks on "MEDIA CHECK" tab
      Then "MEDIA CHECK" tab is displayed
      When User selects Third-party Media Check screening record on position 1
      And User selects risk level as "MEDIUM"
      And User clicks attach button
      Then Media Check attach modal is displayed
      When User clicks "SAVE" Media Check Attach modal button
      Then Screening results table is loaded
      And Third-party Media Check screening record on position 1 displays Medium icon
      When User clicks on Filter icon in Media Check tab
      Then Media Check Risk Level Filter "Medium" "1" is displayed
      When User clicks on Risk Level Filter "Medium" "1"
      Then Screening results table is loaded
      And Media Check Result Table should contain 1 records
      When User clicks on Risk Level Filter "Medium" "1"
      Then Media check "Pending Review" Articles sub-menu in the filter sidebar is highlighted
      And Media check "Medium" Risk Level sub-menu in the filter sidebar is not highlighted