@ui @functional @review_process
Feature: Set Up - Review Process - Add

  As an Internal User with appropriate access rights
  I want to have the ability to create the Review process
  So that I can add new Review process

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Review Process page
    And User clicks 'Add Review Process' button

  @C32926234
  Scenario: C32926234: Set - Up : Add Review Process - Verify that user should be able to select Reviewer Method: Any,All, In Sequence
    When User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Activity owner" data
    And User clicks on Reviewer Process "ANY" Reviewer Method
    Then Reviewer Process "Any" Reviewer Method is selected
    When User clicks on Reviewer Process "ALL" Reviewer Method
    Then Reviewer Process "All" Reviewer Method is selected
    When User clicks on Reviewer Process "IN SEQUENCE" Reviewer Method
    Then Reviewer Process "In Sequence" Reviewer Method is selected

  @C32926235 @C32926293
  Scenario: C32926235, C32926293: Set - Up : Add Review Process - Verify that user should see validation message "This is a required field" for: Reviewer Process Name, Activity Owner (If there is a selected Rule), and Reviewer field
  Set - Up : Add Review Process - Verify that user should see Toast message "Cannot Save! Please complete the required field" for: Reviewer Process Name, Activity Owner (If there is a selected Rule), and Reviewer field
    When User fills in Review Process Add Rule For input "Activity Owner" data
    And User clicks 'Add Review Process' "Save" button
    Then Alert Icon is displayed with text
      | Cannot save. Please complete the required fields. |
    And Error message 'This field is required' is displayed for the next fields on Review Process form
      | Review Process Name |
      | Activity Owner      |
      | Reviewer            |

  @C32926269
  Scenario: C32926269: Review Process- Add/Edit Review Process- Verify that user should be able to see validation and toast message for blank Activity Owner Group field and Reviewer field
    When User fills in Review Process Add Rule For input "Activity Owner Group" data
    And User clicks 'Add Review Process' "Save" button
    Then Error message 'This field is required' is displayed for the next fields on Review Process form
      | Activity Owner Group |

  @C32926259 @C45149994 @C45150001
  Scenario: C32926259, C45149994, C45150001: Set - Up : Add Review Process- Verify that user should see ff fields: Review Process Name,Description,Active,Default Reviewer, Add Process rules For (Activity Owner etc.), Suppliers Country/Region,Reviewer,Reviewer Method
  (Set Up/Review Process) - "Add Review Process" page divided into 3 sections
  (Set Up/"Add Review Process" page) - Verify that 'Reviewer Method' contains 3 radio buttons (Any, All, In Sequence)
    Then Review process modal should have Main block fields
      | Review Process Name | Description | Active |
    And Review process modal should have Default Reviewer block fields
      | Reviewer |
    And Review process modal should have fields for Reviewer block "1"
      | Add Rules For | Rule Value | Reviewer | Reviewer Method |
    And Review Process Reviewer Method options are displayed
      | Any         |
      | All         |
      | In Sequence |
    And Review Process form "Review Process Name" field max length is "64" symbols
    And Review Process form "Description" field max length is "264" symbols
    And Review Process field "Review Process Name" is required
    And Review Process field "Description" is not required
    And Review Process field "Active" is not required
    And Review Process field "Reviewer" is required
    And Review Process field "Add Rules For" is not required
    When User fills in Review Process Add Rule For input "Activity Owner Division" data
    Then Review Process field "Activity Owner Division" is required
    Then Review Process field "Rule Reviewer" is required

  @C32926281 @C45150002
  Scenario: C32926281, C45150002: Review Process- Add/Edit Review Process- Verify that user should be able to Select Active Group for Activity Owner Group field and can Save/Cancel changes
  (Set Up/"Add Review Process" page) - Clicking [Cancel] redirects user to the Review Process Overview page
    When User fills Add Review Process form with "Review Process with Activity Owner Group" data
    And User fills Add Review Process - Review block form with "Review Process with Activity Owner Group" data
    And User clicks 'Add Review Process' "Cancel" button
    Then Review Process overview page is displayed
    When User selects "Max" items per page
    Then User should not see created Review Process by "reviewProcessName" name reference
    When User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity Owner Group" data
    And User fills Add Review Process - Review block form with "Review Process with Activity Owner Group" data
    And User clicks 'Add Review Process' "Save" button
    And User clicks "View" for created Review Process
    Then Review Process form page is displayed with populated data

  @C32926286
  Scenario: C32926286: Set - Up : Add Review Process - Verify that user should be able to select multiple Reviewer
    When User fills in Review Process Add Rule For input "Activity Owner" data
    And User selects in Review Process Reviewer dropdown value "Admin_AT_FN Admin_AT_LN" for rule with number 1
    And User selects in Review Process Reviewer dropdown value "Assignee_AT_FN Assignee_AT_LN" for rule with number 1
    Then Review Process Reviewer dropdown contains values
      | Admin_AT_FN Admin_AT_LN       |
      | Assignee_AT_FN Assignee_AT_LN |

  @C32926299 @C32926258
  Scenario: C32926299, C32926258: Set - Up : Add Review Process - Verify that when there is a Rule selected Next field (Activity owner, etc..) and Reviewer should be required.
  Review Process- Add/Edit Review Process- Verify that user should be able to Select add rules for "Activity Owner Group" and see next field should be Activity Owner Group as Required field
    When User fills in Review Process Add Rule For input "Activity Owner" data
    Then Review Process field "Activity Owner" is required
    When User fills in Review Process Add Rule For input "Activity Owner Group" data
    Then Review Process field "Activity Owner Group" is required
    When User fills in Review Process Add Rule For input "Activity Owner Department" data
    Then Review Process field "Activity Owner Department" is required
    When User fills in Review Process Add Rule For input "Activity Owner Division" data
    Then Review Process field "Activity Owner Division" is required
    When User fills in Review Process Add Rule For input "Third-party Country" data
    Then Review Process field "Third-party Country" is required
    When User fills in Review Process Add Rule For input "Third-party Region" data
    Then Review Process field "Third-party Region" is required

  @C32926301
  Scenario: C32926301: Set - Up : Add Review Process - Verify that user should be able to Remove Reviewer Process if existing rules is more than 1
    When User fills Add Review Process form with "Review Process with Activity Owner Group" data
    And User fills Add Review Process - Review block form with "Review Process with Activity Owner Group" data
    And User clicks Review Process form Add Reviewer button
    Then Rule section on position "2" is displayed
    When User clicks remove icon for rule section on position 2
    Then Rule section on position 2 is disappeared

  @C32926332
  Scenario: C32926332: Set - Up : Add Review Process - Verify that user should see the newly added review process in the overview
    When User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    Then User should see created Review Process on the top of the list

  @C45149991
  Scenario: C45149991: (Set Up/Review Process) - Clicking [Add Review Process] button redirects user to the "Add Review Process" page
    Then Current URL contains "/ui/admin/review-process/add" endpoint

  @C45149992
  Scenario: C45149992: (Set Up/"Add Review Process" page) - Clicking "<Review Process" link redirects user to the "Review Process Overview" page
    Then Review Process breadcrumb "REVIEW PROCESS/ADD REVIEW PROCESS" is displayed
    When User clicks Review Process breadcrumb button
    Then Review Process overview page is displayed

  @C45149995
  Scenario: C45149995: (Set Up/"Add Review Process" page) - Verify that user can add no more that 20 "Reviewer Rule" blocks
    When User fills Add Review Process form with "Review Process with Activity owner" data
    And User adds 20 Review Process rules with data "Review Process with Activity owner"
    Then Review Process form contains 20 numerated rules
    And Add Review button should be invisible
    When User clicks remove icon for rule section on position 20
    Then Add Review button should be enabled

  @C45149996
  Scenario: C45149996: (Set Up/"Add Review Process" page) - Verify that [Add Rule] button is enabled after filling all required fields
    Then Add Review button should be disabled
    When User fills Add Review Process - Review block form with "Review Process with Activity Owner Group" data
    Then Add Review button should be enabled

  @C45149997
  Scenario: C45149997: (Set Up/"Add Review Process" page) - Verify that Rule blocks are re-numerated after deletion one of them
    When User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Activity Owner Group" data
    Then Rule section on position 1 has not remove icon
    When User clicks Review Process form Add Reviewer button
    Then Rule section on position 1 has remove icon
    And Rule section on position 2 has remove icon
    And Review Process form contains 2 numerated rules
    When User fills "Activity Owner Group" in Reviewer details for 2 rule section
    And User clicks Review Process form Add Reviewer button
    Then Rule section on position 1 has remove icon
    And Rule section on position 2 has remove icon
    And Rule section on position 3 has remove icon
    And Review Process form contains 3 numerated rules
    When User clicks remove icon for rule section on position 2
    Then Review Process form contains 2 numerated rules

  @C45149998
  Scenario: C45149998: (Set Up/"Add Review Process" page) - Verify that "Add Rules For" field containіs the corresponding options in dropdown menu
    Then Add Reviewer tab 'Add Rules For' dropdown contains for rule with number 1
      | Activity Owner            |
      | Activity Owner Group      |
      | Activity Owner Department |
      | Activity Owner Division   |
      | Third-party Country       |
      | Third-party Region        |
      | Third-party Industry Type |

  @C45149999 @C32926241 @C32926276 @C32926271 @C32926304 @C32926256 @C32926298
  Scenario: C45149999, C32926241, C32926276, C32926271, C32926304, C32926256, C32926298: (Set Up/"Add Review Process" page) - Verify that "Rule value" field label and dropdown options depends on option selected in "Add Rules For" field
  Set - Up : Add Review Process - Verify that when Add rules for "Activity Owner" is selected next field should be Activity owner and user should be able to select an Internal user
  Set - Up : Add Review Process - Verify that when Add rules for "Activity Owner Group" is selected next field should be Activity Owner Group and user should be able to select from available Group
  Set - Up : Add Review Process - Verify that when Add rules for "Activity Owner Department" is selected next field should be Activity Owner Department and user should be able to select from available Department
  Set - Up : Add Review Process - Verify that when Add rules for "Activity Owner Division" is selected next field should be Activity Owner Division and user should be able to select from available Division
  Set - Up : Add Review Process - Verify that when Add rules for "Suppliers Country" is selected next field should be Suppliers Country and user should be able to select from available Country
  Set - Up : Add Review Process - Verify that when Add rules for "Suppliers Region" is selected next field should be Suppliers Region and user should be able to select from available Region
    When User fills in Review Process Add Rule For input "Activity Owner" data
    Then Review Process "Activity Owner" drop-down contains expected values
    When User selects first option for Review Process from "Activity Owner" drop-down
    Then Review Process selects option is displayed "Activity Owner" drop-down
    When User fills in Review Process Add Rule For input "Activity Owner Group" data
    Then Review Process "Activity Owner Group" drop-down contains expected values
    When User selects first option for Review Process from "Activity Owner Group" drop-down
    Then Review Process selects option is displayed "Activity Owner Group" drop-down
    When User fills in Review Process Add Rule For input "Activity Owner Department" data
    Then Review Process "Activity Owner Department" drop-down contains expected values
    When User selects first option for Review Process from "Activity Owner Department" drop-down
    Then Review Process selects option is displayed "Activity Owner Department" drop-down
    When User fills in Review Process Add Rule For input "Activity Owner Division" data
    Then Review Process "Activity Owner Division" drop-down contains expected values
    When User selects first option for Review Process from "Activity Owner Division" drop-down
    Then Review Process selects option is displayed "Activity Owner Division" drop-down
    When User fills in Review Process Add Rule For input "Third-party Country" data
    Then Review Process "Third-party Country" drop-down contains expected values
    When User selects first option for Review Process from "Third-party Country" drop-down
    Then Review Process selects option is displayed "Third-party Country" drop-down
    When User fills in Review Process Add Rule For input "Third-party Region" data
    Then Review Process "Third-party Region" drop-down contains expected values
    When User selects first option for Review Process from "Third-party Region" drop-down
    Then Review Process selects option is displayed "Third-party Region" drop-down
    When User fills in Review Process Add Rule For input "Third-party Industry Type" data
    Then Review Process "Third-party Industry Type" drop-down contains expected values
    When User selects first option for Review Process from "Third-party Industry Type" drop-down
    Then Review Process selects option is displayed "Third-party Industry Type" drop-down

  @C45150000
  Scenario: C45150000: (Set Up/"Add Review Process" page) - Verify that "Reviewer" field in the Rule Block contains a list of internal active users
    When User fills in Review Process Add Rule For input "Activity Owner" data
    Then Rule Reviewer field contains only Internal Active users in the system

  @C45150003
  Scenario: C45150003: (Set Up/"Add Review Process" page) - Verify validation for required fields after clicking [Save] button
    Then Review Process field "Review Process Name" is required
    And Review Process field "Reviewer" is required
    When User fills in Review Process Add Rule For input "Activity Owner" data
    Then Review Process field "Activity Owner" is required
    And Review Process field "Rule Reviewer" is required
    When User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Activity owner" data
    And User clears Review Process Name required fields
    And User clicks 'Add Review Process' "Save" button
    Then Alert Icon is displayed with text
      | Cannot save. Please complete the required fields. |
    And Error message 'This field is required' is displayed for the next fields on Review Process form
      | Review Process Name |
    When User fills Add Review Process form with "Review Process with Activity Owner Group" data
    And User fills Add Review Process - Review block form with "Review Process with Activity Owner Group" data
    And User clicks 'Add Review Process' "Save" button
    Then Review Process Toast message is displayed with text
      | Success! toBeReplaced has been added. |
    And User should see created Review Process on the top of the list

  @C45150004
  Scenario: C45150004: (Set Up/"Add Review Process" page) - Verify that user can't add Review Process with the same name as already exist
    When User fills in Review Process Name "Auto Review Process"
    And User fills in Review Process Default Reviewer "Admin_AT_FN Admin_AT_LN"
    And User clicks 'Add Review Process' "Save" button
    Then Review Process Toast message is displayed with text
      | Cannot save. Auto Review Process already exists |