@ui @full_regression @my_organisation
Feature: My Organisation - External Organisation

  As a RDDC Administrator
  I want to be able to create user External Organisation within Supplier Integrity
  So that I can create records of the Organisation's External Organisations within the system

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to My Organisation page
    And User clicks My Organisation "External Organisation" tab

  @C36023637
  @core_regression
  Scenario: C36023637: [My Organisation] External Organisation - Add New External Organisation - Verify that an External Organisation can be created
    When User clicks My organisation Add New button
    Then My Organisation "Add External Organisation" modal is displayed
    And "External Organisation Name" My Organisation blank text field is displayed
    And "External Organisation Name" My Organisation text field required indicator is displayed
    And Country blank drop-down field is displayed
    And Country drop-down field is displayed with expected values
    And Region blank drop-down field is displayed
    And Region drop-down field is displayed with expected values
    And All expected buttons are active and displayed for add modal
    When User populates External Organisation input fields "with complete details"
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Success! The External Organisation has been saved |
    And My Organisation "Add External Organisation" modal is disappeared
    When User selects "Max" items per page
    Then My Organisation with provided "with complete details" details is displayed
    When User clicks My organisation Add New button
    Then My Organisation "Add External Organisation" modal is displayed
    When User populates External Organisation input fields "with required details"
    And User clicks My organisation page "Save and New" button
    Then Alert Icon is displayed with text
      | Success! The External Organisation has been saved |
    And My Organisation "Add External Organisation" modal is displayed
    And "External Organisation Name" My Organisation blank text field is displayed
    And "External Organisation Name" My Organisation text field required indicator is displayed
    And Region blank drop-down field is displayed
    And Region drop-down field is displayed with expected values
    And Country blank drop-down field is displayed
    And Country drop-down field is displayed with expected values
    When User clicks My organisation page "Close" button
    Then My Organisation "Add External Organisation" modal is disappeared
    And User selects "Max" items per page
    Then My Organisation with provided "with complete details" details is displayed
    When User clicks My organisation Add New button
    Then My Organisation "Add External Organisation" modal is displayed
    When User populates External Organisation input fields "with complete details"
    And User clicks My organisation page "Cancel" button
    Then My Organisation "Add External Organisation" modal is disappeared
    And My Organisation with provided "with complete details" details is not displayed

  @C36023641
  Scenario: C36023641: [My Organisation] External Organisation - Add New External Organisation - Validation for required fields and duplicate Name field
    When User clicks My organisation Add New button
    Then My Organisation "Add External Organisation" modal is displayed
    When User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near "External Organisation Name" My Organisation modal field
    When User clicks My organisation page "Save and New" button
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near "External Organisation Name" My Organisation modal field
    When User populates External Organisation input fields "with MyOrganisation name"
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Request Error External Organisation with same name already exists, duplicates are not allowed! |
    When User populates External Organisation input fields "with MyOrganisation name"
    And User clicks My organisation page "Save and New" button
    Then Alert Icon is displayed with text
      | Request Error External Organisation with same name already exists, duplicates are not allowed! |

  @C36023683
  @core_regression
  Scenario: C36023683: [My Organisation] External Organisation - Edit External Organisation from External Organisation List
    When User clicks My organisation Add New button
    And User populates External Organisation input fields "with required details"
    And User clicks My organisation page "Save" button
    Then My Organisation "Add External Organisation" modal is disappeared
    When User creates valid email
    And User navigates 'Set Up' block 'User' section
    And User clicks 'Add New User' button
    Then Add User page is loaded
    When User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User selects in "External Organisation" Add User value "oldOrganisationName"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User searches user by first name
    And User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | External Organisation |
      | oldOrganisationName   |
    When User navigates to My Organisation page
    And User clicks My Organisation "External Organisation" tab
    And User selects "Max" items per page
    And User clicks edit created organisation with reference "with required details"
    Then My Organisation "Edit External Organisation" modal is displayed
    Then External Organisation modal is displayed with provided "with required details" details
    And All expected buttons are active and displayed for edit modal
    And "External Organisation Name" My Organisation text field required indicator is displayed
    And Country drop-down field is displayed with expected values
    And Region drop-down field is displayed with expected values
    When User clears all External Organisation page fields
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near "External Organisation Name" My Organisation modal field
    When User populates External Organisation input fields "with MyOrganisation name"
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Request Error External                                                  |
      | Organisation with same name already exists, duplicates are not allowed! |
    When User populates External Organisation input fields "with required details"
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Success!                                 |
      | The External Organisation has been saved |
    And User navigates 'Set Up' block 'User' section
    When User searches user by first name
    And User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | External Organisation |
      | oldOrganisationName   |
    When User creates valid email
    And User navigates 'Set Up' block 'User' section
    And User clicks 'Add New User' button
    Then Add User page is loaded
    When User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User selects in "External Organisation" Add User value "newOrganisationName"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User searches user by first name
    And User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | External Organisation |
      | newOrganisationName   |
    When User navigates to My Organisation page
    And User clicks My Organisation "External Organisation" tab
    And User selects "Max" items per page
    And User clicks edit created organisation with reference "with required details"
    And User clears all External Organisation page fields
    And User populates External Organisation input fields "with details for edit"
    And User clicks My organisation page "Cancel" button
    Then My Organisation "Add External Organisation" modal is disappeared
    And My Organisation with provided "with details for edit" details is not displayed
    And My Organisation with provided "with required details" details is displayed

  @C36048625
  Scenario: C36048625: [My Organisation] External Organisation - Edit External Organisation from External Organisation Details Screen
    When User clicks My organisation Add New button
    And User populates External Organisation input fields "with required details"
    And User clicks My organisation page "Save" button
    Then My Organisation "Add External Organisation" modal is disappeared
    And User creates valid email
    And User navigates 'Set Up' block 'User' section
    When User clicks 'Add New User' button
    Then Add User page is loaded
    When User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User selects in "External Organisation" Add User value "MyOrganisation"
    And User selects in "External Organisation" Add User value "oldOrganisationName"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User navigates to My Organisation page
    And User clicks My Organisation "External Organisation" tab
    And User selects "Max" items per page
    And User clicks on created organisation with reference "with required details"
    And User clicks My organisation page "Edit" button
    Then External Organisation modal is displayed with provided "with required details" details
    And All expected buttons are active and displayed for edit modal
    And "External Organisation Name" My Organisation text field required indicator is displayed
    And Region drop-down field is displayed with expected values
    And Country drop-down field is displayed with expected values
    When User clears all External Organisation page fields
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near "External Organisation Name" My Organisation modal field
    When User populates External Organisation input fields "with MyOrganisation name"
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Request Error External Organisation with same name already exists, duplicates are not allowed! |
    When User populates External Organisation input fields "with required details"
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Success!                                 |
      | The External Organisation has been saved |
    And User navigates 'Set Up' block 'User' section
    When User searches user by first name
    And User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | External Organisation |
      | oldOrganisationName   |
    When User creates valid email
    And User navigates 'Set Up' block 'User' section
    And User clicks 'Add New User' button
    Then Add User page is loaded
    When User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User selects in "External Organisation" Add User value "MyOrganisation"
    And User selects in "External Organisation" Add User value "newOrganisationName"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User searches user by first name
    And User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | External Organisation |
      | newOrganisationName   |
    When User navigates to My Organisation page
    And User clicks My Organisation "External Organisation" tab
    And User selects "Max" items per page
    And User clicks edit created organisation with reference "with required details"
    And User clears all External Organisation page fields
    And User populates External Organisation input fields "with details for edit"
    And User clicks My organisation page "Cancel" button
    Then My Organisation "Add External Organisation" modal is disappeared
    And My Organisation with provided "with details for edit" details is not displayed
    And My Organisation with provided "with required details" details is displayed

  @C36023663
  Scenario: C36023663: [My Organisation] External Organisation - External Organisation List/View External Organisation
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
    And User clicks on created organisation with name "MyOrganisation"
    Then All expected buttons are active and displayed for view modal
    And All My Organisation fields are uneditable
      | External Organisation Name |
      | Region                     |
      | Country                    |
      | Active                     |
    When User clicks My organisation page "Back" button
    Then My Organisation "Add External Organisation" modal is disappeared
    And My Organisation table control buttons are displayed for each record

  @C36023667
  Scenario: C36023667: [My Organisation] External Organisation - External Organisation List Filter - Verify that user can use filtering options on the External Organisation tab
    Then Show Drop-Down current option should be "All"
    And Show Drop-Down list is displayed with values
      | All      |
      | Active   |
      | Inactive |
    When User selects "Active" show option
    Then Table displayed with all "Active" items
    When User selects "Inactive" show option
    Then Table displayed with all "Inactive" items

  @C36023676
  Scenario: C36023676: [My Organisation] External Organisation - External Organisation List Pagination
    Then Pagination option "10" is selected
    When User clicks pagination drop-down
    And Pagination Drop-Down list is displayed with values
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
    When User clicks on "Name" My Organisation column
    And User selects "Active" show option
    Then Table displayed with all "Active" items
    And Table displayed with up to "Max" rows

  @C36048665
  Scenario: C36048665: [My Organisation] External Organisation - Delete External Organisation
    When User selects "Max" items per page
    And User clicks delete created organisation with name "MyOrganisation"
    Then Message is displayed on confirmation window
      | This External Organisation is currently in use |
      | and you will not be able to delete it.         |
    When User clicks Proceed button on confirmation window
    Then My Organisation with name "MyOrganisation" is displayed
    And User clicks My organisation Add New button
    And User populates External Organisation input fields "with complete details"
    And User clicks My organisation page "Save" button
    And User clicks delete created organisation with reference "with complete details"
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this External Organisation? |
      | This change cannot be undone.                               |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And My Organisation with provided "with complete details" details is displayed
    When User clicks delete created organisation with reference "with complete details"
    And User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! The External Organisation has been deleted |
    And Confirmation window is disappeared
    And My Organisation with provided "with complete details" details is not displayed