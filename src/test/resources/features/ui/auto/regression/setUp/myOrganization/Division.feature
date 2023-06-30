@ui @full_regression @my_organisation
Feature: My Organisation - Division

  As a RDDC Administrator
  I want to be able to create user Division within Supplier Integrity
  So that I can create records of the Organisation's Divisions within the system

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to My Organisation page
    And User clicks My Organisation "Division" tab

  @C35996101
  @core_regression
  Scenario: C35996101: [My Organisation] Division - Add New Division - Verify that a Division can be created
    When User clicks My organisation Add New button
    Then My Organisation "Add Division" modal is displayed
    And "Division Name" My Organisation blank text field is displayed
    And "Division Name" My Organisation text field required indicator is displayed
    And Country blank drop-down field is displayed
    And Country drop-down field is displayed with expected values
    And Region blank drop-down field is displayed
    And Region drop-down field is displayed with expected values
    And All expected buttons are active and displayed for add modal
    When User populates Division input fields "with complete details"
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Success! The Division has been saved |
    And My Organisation "Add Division" modal is disappeared
    When User selects "Max" items per page
    Then My Organisation with provided "with complete details" details is displayed
    When User clicks My organisation Add New button
    Then My Organisation "Add Division" modal is displayed
    When User populates Division input fields "with required details"
    And User clicks My organisation page "Save and New" button
    Then Alert Icon is displayed with text
      | Success! The Division has been saved |
    And My Organisation "Add Division" modal is displayed
    And "Division Name" My Organisation blank text field is displayed
    And "Division Name" My Organisation text field required indicator is displayed
    And Region blank drop-down field is displayed
    And Region drop-down field is displayed with expected values
    And Country blank drop-down field is displayed
    And Country drop-down field is displayed with expected values
    When User clicks My organisation page "Close" button
    Then My Organisation "Add Division" modal is disappeared
    And User selects "Max" items per page
    Then My Organisation with provided "with complete details" details is displayed
    When User clicks My organisation Add New button
    Then My Organisation "Add Division" modal is displayed
    When User populates Division input fields "with complete details"
    And User clicks My organisation page "Cancel" button
    Then My Organisation "Add Division" modal is disappeared
    And My Organisation with provided "with complete details" details is not displayed

  @C35996086
  Scenario: C35996086: [My Organisation] Division - Add New Division - Validation for required fields and duplicate Name field
    When User clicks My organisation Add New button
    Then My Organisation "Add Division" modal is displayed
    When User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near "Division Name" My Organisation modal field
    When User clicks My organisation page "Save and New" button
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near "Division Name" My Organisation modal field
    When User populates Division input fields "with MyDivision name"
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Request Error                                                       |
      | Division with same name already exists, duplicates are not allowed! |
    When User clicks My organisation page "Save and New" button
    Then Alert Icon is displayed with text
      | Request Error                                                       |
      | Division with same name already exists, duplicates are not allowed! |

  @C35997297
  @core_regression
  Scenario: C35997297: [My Organisation] Division - Edit Division from Division List
    When User clicks My organisation Add New button
    And User populates Division input fields "with required details"
    And User clicks My organisation page "Save" button
    Then My Organisation "Add Division" modal is disappeared
    When User selects "Max" items per page
    And User clicks edit created organisation with reference "with required details"
    Then My Organisation "Edit Division" modal is displayed
    And Division modal is displayed with provided "with required details" details
    And All expected buttons are active and displayed for edit modal
    And "Division Name" My Organisation text field required indicator is displayed
    And Country drop-down field is displayed with expected values
    And Region drop-down field is displayed with expected values
    When User clears all Division page fields
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near "Division Name" My Organisation modal field
    When User populates Division input fields "with MyDivision name"
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Request Error                                                       |
      | Division with same name already exists, duplicates are not allowed! |
    When User populates Division input fields "with required details"
    And User clicks My organisation page "Save" button
    And User clicks edit created organisation with reference "with required details"
    And User clears all Division page fields
    And User populates Division input fields "with details for edit"
    And User clicks My organisation page "Cancel" button
    Then My Organisation "Add Division" modal is disappeared
    And My Organisation with provided "with details for edit" details is not displayed
    And My Organisation with provided "with required details" details is displayed

  @C35997299
  Scenario: C35997299: [My Organisation] Division - Edit Division from Division Details Screen
    When User clicks My organisation Add New button
    And User populates Division input fields "with required details"
    And User clicks My organisation page "Save" button
    Then My Organisation "Add Division" modal is disappeared
    And User creates valid email
    And User navigates 'Set Up' block 'User' section
    When User clicks 'Add New User' button
    Then Add User page is loaded
    When User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "oldOrganisationName"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User navigates to My Organisation page
    And User clicks My Organisation "Division" tab
    And User selects "Max" items per page
    And User clicks on created organisation with reference "with required details"
    And User clicks My organisation page "Edit" button
    Then Division modal is displayed with provided "with required details" details
    And All expected buttons are active and displayed for edit modal
    And "Division Name" My Organisation text field required indicator is displayed
    And Region drop-down field is displayed with expected values
    And Country drop-down field is displayed with expected values
    When User clears all Division page fields
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near "Division Name" My Organisation modal field
    When User populates Division input fields "with MyDivision name"
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Request Error                                                       |
      | Division with same name already exists, duplicates are not allowed! |
    When User populates Division input fields "with required details"
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Success!                    |
      | The Division has been saved |
    When User navigates 'Set Up' block 'User' section
    And User creates valid email
    And User clicks 'Add New User' button
    Then Add User page is loaded
    When User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "newOrganisationName"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User searches user by first name
    And User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | Division            |
      | newOrganisationName |
    When User navigates to My Organisation page
    And User clicks My Organisation "Division" tab
    And User selects "Max" items per page
    And User clicks edit created organisation with reference "with required details"
    And User clears all Division page fields
    And User populates Division input fields "with details for edit"
    And User clicks My organisation page "Cancel" button
    Then My Organisation "Add Division" modal is disappeared
    And My Organisation with provided "with details for edit" details is not displayed
    And My Organisation with provided "with required details" details is displayed

  @C35993909
  Scenario: C35993909: [My Organisation] Division - Division List/View Division
    Then My Organisation table displayed with columns
      | NAME         |
      | REGION       |
      | COUNTRY      |
      | DATE CREATED |
      | LAST UPDATE  |
      | STATUS       |
    And Show drop-down is displayed
    And Add New My Organisation button is displayed
    And Items per page drop-down should be displayed
    And Pagination buttons should be visible
      | first page | previous page | next page | last page |
    Then My Organisation table is sorted by "Date Created" in "DESC" order
    When User clicks on "Date Created" My Organisation column
    Then My Organisation table is sorted by "Date Created" in "ASC" order
    When User clicks on "Name" My Organisation column
    Then My Organisation table is sorted by "Name" in "ASC" order
    When User clicks on "Name" My Organisation column
    Then My Organisation table is sorted by "Name" in "DESC" order
    When User clicks on "Region" My Organisation column
    Then My Organisation table is sorted by "Region" in "ASC" order
    When User clicks on "Region" My Organisation column
    Then My Organisation table is sorted by "Region" in "DESC" order
    When User clicks on "Country" My Organisation column
    Then My Organisation table is sorted by "Country" in "ASC" order
    When User clicks on "Country" My Organisation column
    Then My Organisation table is sorted by "Country" in "DESC" order
    When User clicks on "Last Update" My Organisation column
    Then My Organisation table is sorted by "Last Update" in "ASC" order
    When User clicks on "Last Update" My Organisation column
    Then My Organisation table is sorted by "Last Update" in "DESC" order
    When User clicks on "Status" My Organisation column
    Then My Organisation table is sorted by "Status" in "DESC" order
    When User clicks on "Status" My Organisation column
    Then My Organisation table is sorted by "Status" in "ASC" order
    When User selects "Max" items per page
    And User clicks on created organisation with name "MyDivision"
    Then All expected buttons are active and displayed for view modal
    And All My Organisation fields are uneditable
      | Division Name |
      | Region        |
      | Country       |
    When User clicks My organisation page "Back" button
    Then My Organisation "Add Division" modal is disappeared
    And My Organisation table control buttons are displayed for each record

  @C35996156
  Scenario: C35996156: [My Organisation] Division - Division List Filter - Verify that user can use filtering options on the Division tab
    Then Show Drop-Down current option should be "All"
    And Show Drop-Down list is displayed with values
      | All      |
      | Active   |
      | Inactive |
    When User selects "Active" show option
    Then Table displayed with all "Active" items
    And My Organisation No Match Found message is displayed if table is empty
    When User selects "Inactive" show option
    Then Table displayed with all "Inactive" items
    And My Organisation No Match Found message is displayed if table is empty

  @C35996270
  Scenario: C35996270: [My Organisation] Division - Division List Pagination
    Then Pagination option "10" is selected
    When User clicks pagination drop-down
    Then Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    And Pagination elements are disabled if table contains less than 10 rows
    When User selects "25" items per page
    Then Table displayed with up to "25" rows
    When User selects "10" items per page
    Then Table displayed with up to "10" rows
    When User selects "50" items per page
    Then Table displayed with up to "50" rows
    And My Organisation table is sorted by "Date Created" in "DESC" order
    And User selects "Active" show option
    Then Table displayed with all "Active" items
    And Table displayed with up to "Max" rows

  @C35997411
  @core_regression
  Scenario: C35997411: [My Organisation] Division - Delete Division
    When User clicks delete created organisation with name "MyDivision"
    Then Message is displayed on confirmation window
      | This Division is currently in use      |
      | and you will not be able to delete it. |
    When User clicks Proceed button on confirmation window
    Then My Organisation with name "MyDivision" is displayed
    And User clicks My organisation Add New button
    And User populates Division input fields "with complete details"
    And User clicks My organisation page "Save" button
    And User clicks delete created organisation with reference "with complete details"
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this Division? |
      | This change cannot be undone.                  |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And My Organisation with provided "with complete details" details is displayed
    When User clicks delete created organisation with reference "with complete details"
    And User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! The Division has been deleted |
    And Confirmation window is disappeared
    And My Organisation with provided "with complete details" details is not displayed