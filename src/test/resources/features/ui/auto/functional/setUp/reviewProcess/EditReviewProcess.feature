@ui @functional @review_process
Feature: Set Up - Review Process - Edit

  As an Internal User with appropriate access rights
  I want to have the ability to edit the review process
  So that I can change already created review process

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Review Process page

  @C32926252
  Scenario: C32926252: Set - Up : EDIT Review Process - Verify that when there is a Rule selected Next field (Activity owner, etc..) and Reviewer should be required.
    When User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User clicks "Edit" for created Review Process
    And User fills in Review Process Add Rule For input "Activity Owner" data
    Then Review Process field "Activity Owner" is required
    And Review Process field "Rule Reviewer" is required
    When User fills in Review Process Add Rule For input "Activity Owner Group" data
    Then Review Process field "Activity Owner Group" is required
    And Review Process field "Rule Reviewer" is required
    When User fills in Review Process Add Rule For input "Activity Owner Department" data
    Then Review Process field "Activity Owner Department" is required
    And Review Process field "Rule Reviewer" is required
    When User fills in Review Process Add Rule For input "Activity Owner Division" data
    Then Review Process field "Activity Owner Division" is required
    And Review Process field "Rule Reviewer" is required
    When User fills in Review Process Add Rule For input "Third-party Country" data
    Then Review Process field "Third-party Country" is required
    And Review Process field "Rule Reviewer" is required
    When User fills in Review Process Add Rule For input "Third-party Region" data
    Then Review Process field "Third-party Region" is required
    And Review Process field "Rule Reviewer" is required
    When User fills in Review Process Add Rule For input "Third-party Industry Type" data
    Then Review Process field "Third-party Industry Type" is required
    And Review Process field "Rule Reviewer" is required

  @C32926267
  Scenario: C32926267: Set - Up : EDIT Review Process - Verify that user should be able to select Reviewer Method: Any,All, In Sequence
    When User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User clicks "Edit" for created Review Process
    And User clicks on Reviewer Process "ANY" Reviewer Method
    Then Reviewer Process "Any" Reviewer Method is selected
    When User clicks on Reviewer Process "ALL" Reviewer Method
    Then Reviewer Process "All" Reviewer Method is selected
    When User clicks on Reviewer Process "IN SEQUENCE" Reviewer Method
    Then Reviewer Process "In Sequence" Reviewer Method is selected

  @C32926274
  Scenario: C32926274: Set - Up : EDIT Review Process - Verify that user should see the newly added review process in the overview
    When User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User clicks "Edit" for created Review Process
    And User fills Add Review Process form with "Review Process with Activity Owner Group" data
    And User fills Add Review Process - Review block form with "Review Process with Activity Owner Group" data
    And User clicks 'Add Review Process' "Save" button
    Then Review Process overview page is displayed

  @C32926289 @C32926337
  Scenario: C32926289, C32926337: Set - Up : EDIT Review Process - Verify that user should see validation message "This is a required field" for: Reviewer Process Name, Activity Owner (If there is a selected Rule), and Reviewer field
  Set - Up : EDIT Review Process - Verify that user should see Toast message "Cannot Save! Please complete the required field" for: Reviewer Process Name, Activity Owner (If there is a selected Rule), and Reviewer field
    When User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User clicks "Edit" for created Review Process
    And User clears Review Process required fields
    And User fills in Review Process Add Rule For input "Activity Owner" data
    And User clicks 'Add Review Process' "Save" button
    Then Alert Icon is displayed with text
      | Cannot save. Please complete the required fields. |
    And Error message 'This field is required' is displayed for the next fields on Review Process form
      | Review Process Name |
      | Activity Owner      |
      | Reviewer            |

  @C32926295
  Scenario: C32926295: Set - Up : EDIT Review Process - Verify that user should be able to Remove Reviewer Process if existing rules is more than 1
    When User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User clicks "Edit" for created Review Process
    And User fills Add Review Process - Review block form with "Review Process with Activity Owner Group" data
    And User clicks Review Process form Add Reviewer button
    Then Rule section on position "2" is displayed
    When User clicks remove icon for rule section on position 2
    Then Rule section on position 2 is disappeared

  @C32926316
  Scenario: C32926316: Set - Up : EDIT Review Process - Verify that user should be able to select multiple Reviewer
    When User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User clicks "Edit" for created Review Process
    And User fills in Review Process Add Rule For input "Activity Owner" data
    And User selects in Review Process Reviewer dropdown value "Admin_AT_FN Admin_AT_LN" for rule with number 1
    And User selects in Review Process Reviewer dropdown value "Assignee_AT_FN Assignee_AT_LN" for rule with number 1
    Then Review Process Reviewer dropdown contains values
      | Admin_AT_FN Admin_AT_LN       |
      | Assignee_AT_FN Assignee_AT_LN |

  @C32926321
  Scenario: C32926321: Set - Up : EDIT Review Process- verify that user should see ff fields: Review Process Name,Description,Active,Default Reviewer, Add Process rules For (Activity Owner etc.), Suppliers Country/Region,Reviewer,Reviewer Method
    When User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User clicks "Edit" for created Review Process
    Then Edit Review Process page is displayed
    And Review process modal should have Main block fields
      | Review Process Name | Description | Active |
    And Review process modal should have Default Reviewer block fields
      | Reviewer |
    And Review process modal should have fields for Reviewer block "1"
      | Add Rules For | Rule Value | Reviewer | Reviewer Method |
    And Review Process Reviewer Method options are displayed
      | Any         |
      | All         |
      | In Sequence |

  @C45150018
  Scenario: C45150018: (Set Up/Review Process) - Clicking "Edit" button redirects user to the "Edit Review process" page
    When User hovers "Edit" button for first Review Process
    Then First Review Process "Edit" button color is expected
    When User clicks "Edit" for first Review Process
    Then Edit Review Process page is displayed
    And Current URL matches ".+\/ui\/admin\/review-process\/(\w+)\/edit" endpoint regex

  @C45150019
  Scenario: C45150019: (Set Up/"Edit Review Process" page) - Clicking "<Review Process" link redirects user to the "Review Process Overview" page
    When User clicks "Edit" for first Review Process
    Then Review Process breadcrumb "REVIEW PROCESS/EDIT" is displayed
    When User clicks Review Process breadcrumb button
    Then Review Process overview page is displayed

  @C45150020
  Scenario: C45150020: (Set Up/"Edit Review Process" page) - "Edit Review Process" page divided into 3 sections
    When User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User clicks "Edit" for created Review Process
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
    And Review Process field "Rule Reviewer" is required

  @C45150021
  Scenario: C45150021: (Set Up/"Edit Review Process" page) - Verify that user can add no more that 20 "Reviewer Rule" blocks
    When User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User clicks "Edit" for created Review Process
    And User adds 20 Review Process rules with data "Review Process with Activity owner"
    Then Review Process form contains 20 numerated rules
    And Add Review button should be invisible
    When User clicks remove icon for rule section on position 20
    Then Add Review button should be enabled

  @C45150022
  Scenario: C45150022: (Set Up/"Edit Review Process" page) - Verify that [Add Rule] button is enabled after filling all required fields
    When User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User clicks "Edit" for created Review Process
    Then Add Review button should be disabled
    When User fills Add Review Process - Review block form with "Review Process with Activity Owner Group" data
    Then Add Review button should be enabled

  @C45150023
  Scenario: C45150023: (Set Up/"Edit Review Process" page) - Verify that Rule blocks are re-numerated after deletion one of them
    When User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User clicks "Edit" for created Review Process
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

  @C45150024
  Scenario: C45150024: (Set Up/"Edit Review Process" page) - Verify that "Add Rules For" field containіs the corresponding options in dropdown menu
    When User clicks "Edit" for first Review Process
    Then Add Reviewer tab 'Add Rules For' dropdown contains for rule with number 1
      | Activity Owner            |
      | Activity Owner Group      |
      | Activity Owner Department |
      | Activity Owner Division   |
      | Third-party Country       |
      | Third-party Region        |
      | Third-party Industry Type |

  @C45150025 @C32926239 @C32926257 @C32926330 @C32926262 @C32926266 @C32926319
  Scenario: C45150025, C32926239, C32926257, C32926330, C32926262, C32926266, C32926319: (Set Up/"Edit Review Process" page) - Verify that "Rule value" field label and dropdown options depends on option selected in "Add Rules For" field
  Set - Up : EDIT Review Process - Verify that when Add rules for "Suppliers Region" is selected next field should be Suppliers Region and user should be able to select from available Region
  Set - Up : EDIT Review Process - Verify that when Add rules for "Activity Owner" is selected next field should be Activity owner and user should be able to select an Internal user
  Set - Up : EDIT Review Process - Verify that when Add rules for "Activity Owner Division" is selected next field should be Activity Owner Division and user should be able to select from available Division
  Set - Up : EDIT Review Process - Verify that when Add rules for "Suppliers Country" is selected next field should be Suppliers Country and user should be able to select from available Country
  Set - Up : EDIT Review Process - Verify that when Add rules for "Activity Owner Department" is selected next field should be Activity Owner Department and user should be able to select from available Department
  Set - Up : EDIT Review Process - Verify that when Add rules for "Activity Owner Group" is selected next field should be Activity Owner Group and user should be able to select from available Group
    When User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User clicks "Edit" for created Review Process
    And User fills in Review Process Add Rule For input "Activity Owner" data
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

  @C45150026
  Scenario: C45150026: (Set Up/"Edit Review Process" page) - Verify that "Reviewer" field in the Rule Block contains a list of internal active users
    When User clicks "Edit" for first Review Process
    And User fills in Review Process Add Rule For input "Activity Owner" data
    Then Rule Reviewer field contains only Internal Active users in the system

  @C45150027
  Scenario: C45150027: (Set Up/"Edit Review Process" page) - Verify that 'Reviewer Method' contains 3 radio buttons (Any, All, In Sequence)
    When User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User clicks "Edit" for created Review Process
    And User clicks on Reviewer Process "ANY" Reviewer Method
    Then Reviewer Process "Any" Reviewer Method is selected
    When User clicks 'Add Review Process' "Save" button
    Then Review Process Toast message is displayed with text
      | Success! toBeReplaced has been updated. |

  @C45150028
  Scenario: C45150028: (Set Up/"Edit Review Process" page) - Clicking [Cancel] redirects user to the Review Process Overview page
    When User clicks "Edit" for first Review Process
    And User clicks 'Add Review Process' "Cancel" button
    Then Review Process overview page is displayed

  @C45150029
  Scenario: C45150029: (Set Up/"Edit Review Process" page) - Verify validation for required fields after clicking [Save] button
    When User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User clicks "Edit" for created Review Process
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
      | Success! toBeReplaced has been updated. |
    And User should see created Review Process on the top of the list

  @C45150030
  Scenario: C45150030: (Set Up/"Edit Review Process" page) - Verify that user can't add Review Process with the same name as already exist
    When User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User clicks "Edit" for created Review Process
    And User fills in Review Process Name "Auto Review Process"
    And User fills in Review Process Default Reviewer "Admin_AT_FN Admin_AT_LN"
    And User clicks 'Add Review Process' "Save" button
    Then Review Process Toast message is displayed with text
      | Cannot save. Auto Review Process already exists |