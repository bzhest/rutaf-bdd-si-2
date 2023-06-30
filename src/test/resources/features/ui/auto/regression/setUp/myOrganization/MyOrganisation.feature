@ui @full_regression @my_organisation
Feature: My Organisation Details

  As RDDC Administrator
  I want to see the details of our organisation
  So that I can use the information and check if there are details that need to be updated

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to My Organisation page

  @C35980481
  @onlySingleThread
  Scenario: C35980481: [My Organisation] Overview - Check that My organisation page has correct content
    Then My Organisation page contains following fields
      | Organisation Name |
      | Local Name        |
      | Phone Number      |
      | Fax               |
      | Description       |
      | Address Line      |
      | Zip/Postal        |
      | State/Province    |
      | City              |
      | Region            |
      | Country           |
    And The Organisation Name is set to "RFG"
    And My Organisation Edit icon is displayed
    And My Organisation tabs are displayed
      | ENTITY                |
      | DIVISION              |
      | DEPARTMENT            |
      | EXTERNAL ORGANISATION |

  @C35980604
  Scenario: C35980604: [My Organisation] - Edit Organisation Details
    When User clicks My Organisation edit icon
    Then My Organisation input fields are displayed
      | Organisation Name |
      | Local Name        |
      | Phone Number      |
      | Fax               |
      | Description       |
      | Address Line      |
      | Zip/Postal        |
      | State/Province    |
      | City              |
      | Region            |
      | Country           |
    And Region drop-down field is displayed with expected values
    And Country drop-down field is displayed with expected values
    And "Organisation Name" My Organisation text field required indicator is displayed
    And All expected buttons are active and displayed for edit modal
    When User clears My Organisation "Organisation Name" field
    And Error message "This field is required" in red color is displayed near "Organisation Name" My Organisation modal field
    When User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near "Organisation Name" My Organisation modal field
    When User deletes all My Organisation Phone Numbers
    And User populates My Organisation input fields "with random data"
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Success! The organisation has been updated |
    And My Organisation is displayed with provided "with random data" details
    When User clicks My Organisation edit icon
    And User populates My Organisation input fields "with required data"
    And User clicks My organisation page "Cancel" button
    Then My Organisation is displayed with provided "with random data" details
    When User navigates 'Set Up' block 'User' section
    And User searches user by "Admin_AT_FN" keyword
    And User clicks on user with First Name "Admin_AT_FN"
    Then User Overview "Organisation" field is displayed with "RFG"
    When User navigates 'Set Up' block 'User' section
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    And Add User page is closed
    And User searches user by first name
    And Users clicks on 1 users table row
    Then User Overview "Organisation" field is displayed with "RFG NEW"

  @C35981775
  Scenario: C35981775: [My Organisation] - Edit Organisation Details: Adding Multiple Phone Numbers
    When User clicks My Organisation edit icon
    Then My Organisation Add icon for Phone Number field is displayed
    When User clears My Organisation Phone Number
    And User clicks My Organisation Add icon for Phone Number
    Then My Organisation Add icon for Phone Number is disabled
    When User fills in My Organisation Phone Number "(+66)123456789"
    Then My Organisation Add icon for Phone Number is enabled
    When User clicks My Organisation Add icon for Phone Number
    Then My Organisation additional Phone Number input is displayed
    When User deletes all My Organisation Phone Numbers
    And User adds 10 My Organisation Phone Number(s)
    Then My Organisation displays 10 Phone Number(s)
    And My Organisation Add icon for Phone Number is disabled
    And My Organisation each Phone Number contains remove icon
    When User deletes all My Organisation Phone Numbers
    Then My Organisation displays 1 Phone Number(s)
    And My Organisation Phone Number input contains ""
    When User fills in My Organisation Phone Number "+66123456789"
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Success!                          |
      | The organisation has been updated |
    And My Organisation Phone Number field contains "+66123456789"
    When User clicks My Organisation edit icon
    When User fills in My Organisation Phone Number "+(66)123456789"
    And User clicks My organisation page "Save" button
    Then Alert Icon is displayed with text
      | Success!                          |
      | The organisation has been updated |
    And My Organisation Phone Number field contains "+(66)123456789"
    When User clicks My Organisation edit icon
    And User fills in My Organisation Phone Number "(+66)123456789"
    And User clicks My organisation page "Cancel" button
    Then All expected buttons are active and displayed for view modal
    And My Organisation Phone Number field contains "+(66)123456789"