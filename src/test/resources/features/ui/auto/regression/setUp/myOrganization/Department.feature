@ui @full_regression @my_organisation
Feature: My Organisation - Department

  As a RDDC Administrator
  I want to be able to create user Department within Supplier Integrity
  So that I can create records of the Organisation's Departments within the system

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to My Organisation page
    And User clicks My Organisation "Department" tab

  @C35997505
  @core_regression
  Scenario: C35997505: [My Organisation] Department - Add New Department - Verify that a Department can be created
    When User clicks My organisation Add New button
    Then My Organisation "Add Department" modal is displayed
    And "Department Name" My Organisation blank text field is displayed
    And "Department Name" My Organisation text field required indicator is displayed
    And Country blank drop-down field is displayed
    And Country drop-down field is displayed with expected values
    And Region blank drop-down field is displayed
    And Region drop-down field is displayed with expected values
    And Active checkbox is checked
    And All expected buttons are active and displayed for add modal
    When User populates Department input fields "with complete details"
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Success! The Department has been saved |
    And My Organisation "Add Department" modal is disappeared
    When User selects "Max" items per page
    Then My Organisation with provided "with complete details" details is displayed
    When User clicks My organisation Add New button
    Then My Organisation "Add Department" modal is displayed
    When User populates Department input fields "with required details"
    And User clicks My organisation page "Save and New" button
    Then Alert Icon is displayed with text
      | Success! The Department has been saved |
    And My Organisation "Add Department" modal is displayed
    And "Department Name" My Organisation blank text field is displayed
    And "Department Name" My Organisation text field required indicator is displayed
    And Region blank drop-down field is displayed
    And Region drop-down field is displayed with expected values
    And Country blank drop-down field is displayed
    And Country drop-down field is displayed with expected values
    When User clicks My organisation page "Close" button
    Then My Organisation "Add Department" modal is disappeared
    And User selects "Max" items per page
    Then My Organisation with provided "with complete details" details is displayed
    When User clicks My organisation Add New button
    Then My Organisation "Add Department" modal is displayed
    When User populates Department input fields "with complete details"
    And User clicks My organisation page "Cancel" button
    Then My Organisation "Add Department" modal is disappeared
    And My Organisation with provided "with complete details" details is not displayed

  @C36014554
  Scenario: C36014554: [My Organisation] Department - Add New Department - Validation for required fields and duplicate Name field
    When User clicks My organisation Add New button
    Then My Organisation "Add Department" modal is displayed
    When User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near "Department Name" My Organisation modal field
    When User clicks My organisation page "Save and New" button
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near "Department Name" My Organisation modal field
    When User populates Department input fields "with MyDepartment name"
    When User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Request Error                                                         |
      | Department with same name already exists, duplicates are not allowed! |
    And User clicks My organisation page "Save and New" button
    Then Alert Icon is displayed with text
      | Request Error                                                         |
      | Department with same name already exists, duplicates are not allowed! |

  @C36021953
  Scenario: C36021953: [My Organisation] Department - Edit Department from Department Details Screen
    When User clicks My organisation Add New button
    And User populates Department input fields "with required details"
    And User clicks My organisation page "Save" button
    Then My Organisation "Add Department" modal is disappeared
    And User creates valid email
    And User navigates 'Set Up' block 'User' section
    When User clicks 'Add New User' button
    Then Add User page is loaded
    When User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User selects in "Department" Add User value "oldOrganisationName"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User navigates to My Organisation page
    And User clicks My Organisation "Department" tab
    And User selects "Max" items per page
    And User clicks on created organisation with reference "with required details"
    And User clicks My organisation page "Edit" button
    Then Department modal is displayed with provided "with required details" details
    And All expected buttons are active and displayed for edit modal
    And "Department Name" My Organisation text field required indicator is displayed
    And Region drop-down field is displayed with expected values
    And Country drop-down field is displayed with expected values
    When User clears all Department page fields
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near "Department Name" My Organisation modal field
    When User populates Department input fields "with MyDepartment name"
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Request Error                                                         |
      | Department with same name already exists, duplicates are not allowed! |
    When User populates Department input fields "with required details"
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Success!                      |
      | The Department has been saved |
    When User navigates 'Set Up' block 'User' section
    And User searches user by first name
    And User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | Department          |
      | oldOrganisationName |
    When User creates valid email
    And User navigates 'Set Up' block 'User' section
    And User clicks 'Add New User' button
    Then Add User page is loaded
    When User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User selects in "Department" Add User value "newOrganisationName"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User searches user by first name
    And User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | Department          |
      | newOrganisationName |
    When User navigates to My Organisation page
    And User clicks My Organisation "Department" tab
    When User selects "Max" items per page
    And User clicks edit created organisation with reference "with required details"
    And User clears all Department page fields
    And User populates Department input fields "with details for edit"
    And User clicks My organisation page "Cancel" button
    Then My Organisation "Add Department" modal is disappeared
    And My Organisation with provided "with details for edit" details is not displayed
    And My Organisation with provided "with required details" details is displayed

  @C36021945
  @core_regression
  Scenario: C36021945: [My Organisation] Department - Edit Department from Department List
    When User clicks My organisation Add New button
    And User populates Department input fields "with required details"
    And User clicks My organisation page "Save" button
    Then My Organisation "Add Department" modal is disappeared
    And User creates valid email
    And User navigates 'Set Up' block 'User' section
    When User clicks 'Add New User' button
    Then Add User page is loaded
    When User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User selects in "Department" Add User value "oldOrganisationName"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User searches user by first name
    And User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | Department          |
      | oldOrganisationName |
    When User navigates to My Organisation page
    And User clicks My Organisation "Department" tab
    And User selects "Max" items per page
    And User clicks edit created organisation with reference "with required details"
    Then My Organisation "Edit Department" modal is displayed
    And Department modal is displayed with provided "with required details" details
    And All expected buttons are active and displayed for edit modal
    And "Department Name" My Organisation text field required indicator is displayed
    And Region drop-down field is displayed with expected values
    And Country drop-down field is displayed with expected values
    When User clears all Department page fields
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near "Department Name" My Organisation modal field
    When User populates Department input fields "with MyDepartment name"
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Request Error                                                         |
      | Department with same name already exists, duplicates are not allowed! |
    When User populates Department input fields "with required details"
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Success!                      |
      | The Department has been saved |
    And User navigates 'Set Up' block 'User' section
    When User searches user by first name
    And User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | Department          |
      | oldOrganisationName |
    When User creates valid email
    And User navigates 'Set Up' block 'User' section
    And User clicks 'Add New User' button
    Then Add User page is loaded
    When User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User selects in "Department" Add User value "newOrganisationName"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User searches user by first name
    And User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | Department          |
      | newOrganisationName |
    When User navigates to My Organisation page
    And User clicks My Organisation "Department" tab
    When User selects "Max" items per page
    And User clicks edit created organisation with reference "with required details"
    And User clears all Department page fields
    And User populates Department input fields "with details for edit"
    And User clicks My organisation page "Cancel" button
    Then My Organisation "Add Department" modal is disappeared
    And My Organisation with provided "with details for edit" details is not displayed
    And My Organisation with provided "with required details" details is displayed

  @C36021829
  Scenario: C36021829: [My Organisation] Department - Department List/View Department
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
    And User clicks on created organisation with name "MyDepartment"
    Then All expected buttons are active and displayed for view modal
    And All My Organisation fields are uneditable
      | Department Name |
      | Region          |
      | Country         |
      | Active          |
    When User clicks My organisation page "Back" button
    Then My Organisation "Add Department" modal is disappeared
    And My Organisation table control buttons are displayed for each record

  @C36021882
  Scenario: C36021882: [My Organisation] Department - Department List Filter - Verify that user can use filtering options on the Department tab
    Then Show Drop-Down current option should be "All"
    And Show Drop-Down list is displayed with values
      | All      |
      | Active   |
      | Inactive |
    When User selects "Active" show option
    Then Table displayed with all "Active" items
    When User selects "Inactive" show option
    Then Table displayed with all "Inactive" items

  @C36021887
  Scenario: C36021887: [My Organisation] Department - Department List Pagination
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
    And My Organisation table is sorted by "Date Created" in "DESC" order
    And User selects "Active" show option
    Then Table displayed with all "Active" items
    And Table displayed with up to "10" rows

  @C36022163
  @core_regression
  Scenario: C36022163: [My Organisation] Department - Delete Department
    When User clicks delete created organisation with name "MyDepartment"
    Then Message is displayed on confirmation window
      | This Department is currently in use    |
      | and you will not be able to delete it. |
    When User clicks Proceed button on confirmation window
    Then My Organisation with name "MyDepartment" is displayed
    And User clicks My organisation Add New button
    And User populates Department input fields "with complete details"
    And User clicks My organisation page "Save" button
    When User clicks delete created organisation with reference "with complete details"
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this Department? |
      | This change cannot be undone.                    |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And My Organisation with provided "with complete details" details is displayed
    When User clicks delete created organisation with reference "with complete details"
    And User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! The Department has been deleted |
    And Confirmation window is disappeared
    And My Organisation with provided "with complete details" details is not displayed
