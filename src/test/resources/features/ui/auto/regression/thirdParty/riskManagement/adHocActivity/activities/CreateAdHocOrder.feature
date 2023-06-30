@ui @full_regression @ordering
Feature: Due Diligence Report Ordering - Creating Ad Hoc Due Diligence Report Orders

  As an SI internal user that has access right to create order
  I want to be able to order a Due Diligence report thru adhoc
  So that Client will have the option to order without going through an onboarding process

  @C36023961
  @core_regression
  Scenario: C36023961: Due Diligence Report Ordering - Ad Hoc: Creating Ad Hoc Due Diligence Report Orders – Organisation Order Type - Recommended Scope is not selected
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Create Order under Due Diligence Order section
    Then Create Due Diligence Order page is opened
    And Create Due Diligence Order page should be shown with default values for "Organisation" order type
    When User clicks "Manage Key Principal" button on Due Diligence Order page
    And User fills Key Principle form data "Key Principle all fields"
    And User accepts Key Principle module window
    And User clicks Add to List Key Principle button
    Then Order Key Principal table contains records
      | KEY PRINCIPAL NAME       | EMAIL              | ADDRESS                                        |
      | Test title Key Principle | testEmail@test.com | Test address Gotham Gotham state 90210 Ukraine |
    When User clicks none selected scope
    And User fills in Po No.
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed

  @C36050563
  @core_regression
  Scenario: C36050563: Due Diligence Report Ordering - Ad Hoc: Creating Ad Hoc Due Diligence Report Orders – Individual Order Type - Recommended Scope is not selected
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Create Order under Due Diligence Order section
    Then Create Due Diligence Order page is opened
    When User selects "Individual" Due Diligence Order Type
    And Create Due Diligence Order page should be shown with default values for "Individual" order type
    When User clicks none selected scope
    And User clicks "Manage Key Principal" button on Due Diligence Order page
    And User fills Key Principle form data "Key Principle all fields"
    And User accepts Key Principle module window
    Then Due Diligence Subject Full Name is populated with "Key Principle"
    And Create Order page Address section should be shown with expected values
      | Address Line | City   | Code postal | State/Province | Country |
      | Test address | Gotham | 90210       | Gotham state   | Ukraine |
    And User fills in Po No.
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed

  @C36218016
  @core_regression
  Scenario: C36218016: Due Diligence Report Ordering - Ad Hoc: Create Order Due Diligence Report based on Billing Entity
    Given User logs into RDDC as "Admin"
    When User makes sure that Custom field "Billing Entity" is set as required via API
    And User creates third-party "with random ID name" via API and open it
    And User clicks on Create Order under Due Diligence Order section
    Then Create Due Diligence Order page is opened
    And Create Due Diligence Order page should be shown with default values for "Organisation" order type
    When User clicks none selected scope
    And User fills in Po No.
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed

  @C36266531
  @core_regression
  Scenario: C36266531: Due Diligence Report Ordering - Ad Hoc: Create/Update Order - Place new Order / Save as Draft - Organisation
    Given User logs into RDDC as "Admin"
    When User sets up Due Diligence Order Approval Responsible Party Default Approver via API
    And User creates third-party "with random ID name" via API and open it
    And User makes sure that Custom field "Purchase Order Number" is set as required via API
    And User clicks on Create Order under Due Diligence Order section
    Then Create Due Diligence Order page is opened
    When User gets OrderId from Due Diligence Order page URL
    And User clicks "Save as Draft" button on Due Diligence Order page
    Then Activity Information page is displayed
    And Activity Information Order Details button should contain expected text "ORDER DETAILS: toBeReplaced - SAVED AS DRAFT"
    When User clicks Order Details button
    Then Create Due Diligence Order page is opened
    When User clicks none selected scope
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Alert Icon is displayed with text
      | Cannot Save.                          |
      | Please complete the required field(s) |
    When User waits for progress bar to disappear from page
    And User fills in Po No.
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed
    And Activity Information Order Details button should contain expected text "ORDER DETAILS: toBeReplaced - FOR APPROVAL"
    When User navigates to Home page
    And User clicks 'Pending Orders For Approval' widget
    And User clicks Activity from 'Pending Order for Approval' table
    Then "Approve and Place Order" button on Due Diligence page is displayed

  @C36266531
  @core_regression
  Scenario: C36266531: Due Diligence Report Ordering - Ad Hoc: Create/Update Order - Place new Order / Save as Draft - Individual
    Given User logs into RDDC as "Admin"
    When User sets up Due Diligence Order Approval Responsible Party Default Approver via API
    And User creates third-party "with random ID name" via API and open it
    And User makes sure that Custom field "Purchase Order Number" is set as required via API
    And User clicks on Create Order under Due Diligence Order section
    Then Create Due Diligence Order page is opened
    When User selects "Individual" Due Diligence Order Type
    And User gets OrderId from Due Diligence Order page URL
    And User clicks "Save as Draft" button on Due Diligence Order page
    Then Activity Information page is displayed
    And Activity Information Order Details button should contain expected text "ORDER DETAILS: toBeReplaced - SAVED AS DRAFT"
    When User clicks Order Details button
    Then Create Due Diligence Order page is opened
    When User clicks none selected scope
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Alert Icon for Due Diligence Order page is displayed with text
      | Cannot Save.                          |
      | Please complete the required field(s) |
    When User fills in Po No.
    And User clicks "Manage Key Principal" button on Due Diligence Order page
    And User populates First Name for Key Principal with "Auto"
    And User populates Last Name for Key Principal with "Principal"
    And User selects Country "Albania" for Key Principal
    And User clicks Add Contact Key Principal button
    And User clicks "Proceed" Alert dialog button
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed
    And Activity Information Order Details button should contain expected text "ORDER DETAILS: toBeReplaced - FOR APPROVAL"
    When User navigates to Home page
    And User clicks 'Pending Orders For Approval' widget
    And User clicks Activity from 'Pending Order for Approval' table
    Then "Approve and Place Order" button on Due Diligence page is displayed

  @C36220226
  @onlySingleThread
  Scenario: C36220226: Due Diligence Report Ordering - Ad Hoc: Create Order Due Diligence Report based on Billing Entity
    Given User logs into RDDC as "Approver"
    When User makes sure that Custom field "Billing Entity" is set as required via API
    And User creates third-party "with random ID name" via API and open it
    And User clicks on Create Order under Due Diligence Order section
    Then Alert Icon is displayed with text
      | No available billing entity. Please contact your system administrator. |

  @C36243218
  Scenario: C36243218: DDR Ordering - Ad Hoc: Create /Edit Order DDR - Change Order type
    Given User logs into RDDC as "Admin"
    When User makes sure that Custom field "Billing Entity" is set as not required via API
    And User creates third-party "with random ID name" via API and open it
    And User clicks on Create Order under Due Diligence Order section
    Then Create Due Diligence Order page is opened
    And Create Due Diligence Order page should be shown with default values for "Organisation" order type
    When User selects "Individual" Due Diligence Order Type
    And Create Due Diligence Order page should be shown with default values for "Individual" order type
    And User clicks "Save as Draft" button on Due Diligence Order page
    Then Activity Information page is displayed
    And Activity Information Order Details button should contain expected text "ORDER DETAILS: toBeReplaced - SAVED AS DRAFT"
    When User clicks Order Details button
    Then Create Due Diligence Order page is opened
    When User selects "Organisation" Due Diligence Order Type
    And Create Due Diligence Order page should be shown with default values for "Organisation" order type
    And User clicks "Save as Draft" button on Due Diligence Order page
    Then Activity Information page is displayed
    And Activity Information Order Details button should contain expected text "ORDER DETAILS: toBeReplaced - SAVED AS DRAFT"

  @C36269288
  Scenario: C36269288: DDR Ordering - Ad Hoc: Create/Update Order (Questionnaire, Comment, Attachment)
    Given User logs into RDDC as "Admin"
    When User makes sure that Custom field "Billing Entity" is set as not required via API
    And User creates "Activity Type" "without assessment" via API
    And User creates third-party "with random ID name" via API and open it
    When User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for"
    Then Activity Information page is displayed
    When User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" status should be "Submitted"
    When User clicks Back button to return from Activity modal
    And User clicks on the newly created Ad Hoc Activity with name "Assign Questionnaire"
    And User clicks review questionnaires
    Then Questionnaire details page is displayed
    When User clicks Questionnaire Overall Assessment button "Approve"
    Then Overall Assessment confirmation modal appears
    When User clicks Questionnaire Overall Assessment button "Confirm"
    And User clicks Back button to return from Activity modal
    Then Risk Management page is displayed
    When User clicks on Third-party Information tab
    Then Third-party Information tab is loaded
    When User clicks on Create Order under Due Diligence Order section
    Then Create Due Diligence Order page is opened
    And Create Order Available Questionnaire table contains records
      | Questionnaire Name               | Questionnaire Type | Assignee                | Date Completed | Overall Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Internal           | Admin_AT_FN Admin_AT_LN | MM/dd/YYYY     | 0             |
    When User clicks view questionnaire with name "AUTO_TEST_INTERNAL_QUESTIONNAIRE"
    Then Questionnaire details page is displayed
    When User clicks Questionnaire Overall Assessment button "Export to PDF"
    Then New window should be opened
    When User clicks Questionnaire Overall Assessment button "Cancel"
    Then Create Due Diligence Order page is opened
    When User clicks checkbox for "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Add Questionnaire" button on Due Diligence Order page
    Then Order Selected Questionnaire table contains records
      | Questionnaire Name               | Questionnaire Type | Assignee                | Date Completed | Overall Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Internal           | Admin_AT_FN Admin_AT_LN | MM/dd/YYYY     | 0             |
    When User clicks view questionnaire with name "AUTO_TEST_INTERNAL_QUESTIONNAIRE"
    Then Questionnaire details page is displayed
    When User clicks Questionnaire Overall Assessment button "Export to PDF"
    Then New window should be opened
    When User clicks Questionnaire Overall Assessment button "Cancel"
    Then Create Due Diligence Order page is opened
    When User clicks "Save as Draft" button on Due Diligence Order page
    And User clicks on Third-party Information tab
    Then Third-party Information tab is loaded
    And User clicks on "Third-party Information" tab on Third-party page
    Then Last created order is on the top of DDO list
    When User opens DD order with status "Saved as Draft"
    Then Create Due Diligence Order page is opened
    When User add comment with text "Comment1"
    Then User should see created comment
    When User edits comment "Comment1" with text "4i0bSpD5beCjoFrS7uUn3q1xCv674K1LS6QWelpFPXjgphl11x1ylIYLk8LsabdMRVT2ojQ1sFmAgP2ohnhoD9mT8vSc1oGwcW1ChVSCectOE9GN5SNZkWsS68VSu3iJPbeXIZ2ZpUqWWuE69BO5oOmrdbRdFYQFXj7J3LN2LF3Wac8K6hbocVXsrrXvKTq5LmneGxX2lwxDPl2Qy2d3UZFv0nO8kQPfCsPqzvTGdFQEURCCGUAof0RxmUuzXqWTDPPymlcfoayVo6QRrkejtFqSqLeSe4TW3pz8twesnIh4f8wURSeOQKCtGsYseAWA5YSSBLcHke65TDxDf1BjHyZ6mnXXU3SBqj5IyLi2vAQcFJhkuQeGMi9S1yIQfVJtH1spJzNlzHHSGaKXHKDTqfKT3nb9svP2YZaJV7XLFaSBERYvnZofCuSq4wciZoCzCY92EXqWStAzRqsxVbnwoYdhGlVRNKGl1YOdkzcQfyftm21iPv0NgREvuVafG3rcXC8ouHHFu8vMydnubZWj9IYnEqBMhBkZJTMoAQqTPEM5UN16Z9JYDzSYZ71t014FwegZdbpet6C3qBeiThl8TNRFMMdbMmWZBlzz8FqrVfz7iqH4dUsKCrbUAAzunMH3afvDReZoxHduz0g4idoMVAxgfBJJxEyISVKBoq7Zzr04zINqxYrTYRSUZXteNPsLCatDEI21ZN30n5p7pytasghnfEYWhznkd41yt5Mx6JX7y6MPW6INDhhqBo46Qj7iPFZxo4KRYQkSswhsMNDkERnfPasn05YIOLRwM4bb38LnTHvSjzPSfexcRLaIDYyXrFD1ig139Wb7AmFzrCgSmtSAr0NAO6OFHktdvC4YAvQRagdy3ZBDt3hXUNgsPLNgstBpQmqfOt4ahnLijNKiPN6z4q06GOKZGPAvouRshNfBuUvxtP7H6nCCC0fj0NY6gO8vnUVloRQD1SIJSGcjbkuwSK6WqOSXYFP4Ujr3"
    Then User should see edited comment
    When User clicks 'See More' link
    Then Comment 'See Less' button is displayed
    When User clicks Delete comment
    And User clicks on Delete button on Due Diligence Order page
    Then Comment should be deleted
    When User adds Order attachment
      | Description            | File Name   |
      | Activity description 2 | racoon1.jpg |
    Then Create Order page Attachment table row appears
      | File Name   | Description            | Uploaded by             | Upload Date |
      | racoon1.jpg | Activity description 2 | Admin_AT_FN Admin_AT_LN | TODAY       |
    When User clicks delete icon for attachment "racoon1.jpg"
    And User clicks on Delete button on Due Diligence Order page
    Then Attachment "racoon1.jpg" should be deleted

  @C36220471
  Scenario: C36220471: DDR Ordering - Ad Hoc: Organisation type : Order Due Diligence Report - Manage Key Principal - Inactive contact
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "with key principal"
    And User clicks Associated Party Overview contact button
    And User creates Associated Party "Vladimir LOSEV"
    And User clicks on Third-party Information tab
    Then Create Order button is displayed
    When User clicks Create Order button
    Then Create Due Diligence Order page is opened
    And Order type is "Organisation"
    Then Order Key Principal table contains records
      | KEY PRINCIPAL NAME | EMAIL                | ADDRESS                                               |
      | Volodymyr Z        | testbest@example.com | Address City Odessa State Odessa 65000 Europe Ukraine |
    When User clicks "Manage Key Principal" button on Due Diligence Order page
    Then Manage Key Principal table contains records
      | checked | Title | First Name | Last Name | ADDRESS                                | Country |
      | true    |       | Volodymyr  | Z         | Address City Odessa State Odessa 65000 | Ukraine |
      | false   |       | Vladimir   | LOSEV     |                                        |         |
    When User fills Key Principle form data "Key Principle all fields"
    Then Alert Dialog with text is displayed
      | New Key principal                                                                                       |
      | New Key principal will also be added in Third-party Associated Individual list. Do you want to proceed? |
    When User clicks "Cancel" Alert dialog button
    And User fills Key Principle form data "Key Principle all fields"
    And User clicks "Proceed" Alert dialog button
    Then Manage Key Principal table contains records
      | checked | Title      | First Name | Last Name | ADDRESS                                | Country |
      | true    | Test title | Key        | Principle | Test address Gotham Gotham state 90210 | Ukraine |
      | true    |            | Volodymyr  | Z         | Address City Odessa State Odessa 65000 | Ukraine |
      | false   |            | Vladimir   | LOSEV     |                                        |         |
    When User opens Contacts for previously created Third-party
    Then Associated Party table contains associated party with values
      | Key Principal | Title      | First Name | Last Name | Country | Status   |
      | true          | Test title | Key        | Principle | Ukraine | Inactive |
      | false         |            | Vladimir   | LOSEV     |         | Inactive |
      | true          |            | Volodymyr  | Z         | Ukraine | Inactive |
    When User clicks on Associated Party with name "Key"
    Then Other Name table contains expected values
      | local language   |
      | Locally Known As |
      | MM/dd/YYYY       |
      | MM/dd/YYYY       |
    When User opens Manage Key Principal page for previously created order
    And User clicks edit button for key principal with First Name "Key"
    And User populates First Name for Key Principal with ""
    And User populates Last Name for Key Principal with ""
    And User selects Country " " for Key Principal
    And User clicks "Save" button on Key Principal page
    Then Error message "This field is required" in red color is displayed near Key Principal fields
      | First Name |
      | Last Name  |
      | Country    |
    And Manage Key Principal table contains records
      | checked | Title      | First Name | Last Name | ADDRESS                                | Country |
      | true    | Test title | Key        | Principle | Test address Gotham Gotham state 90210 | Ukraine |
      | true    |            | Volodymyr  | Z         | Address City Odessa State Odessa 65000 | Ukraine |
      | false   |            | Vladimir   | LOSEV     |                                        |         |
    When User clicks edit button for key principal with First Name "Key"
    And User fills Key Principle form data "Key Principle update all fields"
    Then Alert Dialog with text is displayed
      | UPDATE KEY PRINCIPAL                                                                                                  |
      | Changes in the following details will update the Third-party Associated Individual Tab. Do you want to apply changes? |
    When User clicks "Cancel" Alert dialog button
    Then Manage Key Principal table contains records
      | checked | Title      | First Name | Last Name | ADDRESS                                | Country |
      | true    | Test title | Key        | Principle | Test address Gotham Gotham state 90210 | Ukraine |
      | true    |            | Volodymyr  | Z         | Address City Odessa State Odessa 65000 | Ukraine |
      | false   |            | Vladimir   | LOSEV     |                                        |         |
    When User clicks edit button for key principal with First Name "Key"
    And User fills Key Principle form data "Key Principle update all fields"
    And User clicks "Proceed" Alert dialog button
    Then Manage Key Principal table contains records
      | checked | Title             | First Name | Last Name        | ADDRESS                                                     | Country |
      | true    | Test update title | Key update | Principle update | Test update address Gotham update Gotham update state 11111 | China   |
      | true    |                   | Volodymyr  | Z                | Address City Odessa State Odessa 65000                      | Ukraine |
      | false   |                   | Vladimir   | LOSEV            |                                                             |         |
    When User opens Contacts for previously created Third-party
    Then Associated Party table contains associated party with values
      | Key Principal | Title             | First Name | Last Name        | Country | Status   |
      | true          | Test update title | Key update | Principle update | China   | Inactive |
      | false         |                   | Vladimir   | LOSEV            |         | Inactive |
      | true          |                   | Volodymyr  | Z                | Ukraine | Inactive |

  @C36220471
  Scenario: C36220471: DDR Ordering - Ad Hoc: Organisation type : Order Due Diligence Report - Manage Key Principal - Active contact
    Given User creates valid email
    When User logs into RDDC as "Admin"
    And User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "Individual" "with key principal active" via API and open it
    And User clicks on Third-party Information tab
    And User clicks Create Order button
    Then Create Due Diligence Order page is opened
    And Order type is "Organisation"
    And Order Key Principal table contains records
      | KEY PRINCIPAL NAME | EMAIL        | ADDRESS                                        |
      | Volodymyr Z        | toBeReplaced | Address City Odessa State Odessa 65000 Ukraine |
    When User clicks "Manage Key Principal" button on Due Diligence Order page
    Then Manage Key Principal table contains records
      | checked | Title | First Name | Last Name | ADDRESS                                | Country |
      | true    |       | Volodymyr  | Z         | Address City Odessa State Odessa 65000 | Ukraine |
    When User clicks edit button for key principal with First Name "Volodymyr"
    And User fills Key Principle form data "Key Principle update all fields"
    And User clicks "Proceed" Alert dialog button
    Then Manage Key Principal table contains records
      | checked | Title             | First Name | Last Name        | ADDRESS                                                     | Country |
      | true    | Test update title | Key update | Principle update | Test update address Gotham update Gotham update state 11111 | China   |
    When User opens Contacts for previously created Third-party
    Then Associated Party table contains associated party with values
      | Key Principal | Title             | First Name | Last Name        | Country | Status |
      | true          | Test update title | Key update | Principle update | China   | Active |

  @C36220471
  Scenario: C36220471: DDR Ordering - Ad Hoc: Organisation type : Order Due Diligence Report - Manage Key Principal - Inactive contact - without key principal
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "Individual" "Vladimir LOSEV" via API and open it
    And User clicks on Third-party Information tab
    Then Create Order button is displayed
    When User clicks Create Order button
    Then Create Due Diligence Order page is opened
    And Order type is "Organisation"
    And 'No Available data' is displayed in 'Key Principal' section
    When User clicks "Manage Key Principal" button on Due Diligence Order page
    Then Manage Key Principal table contains records
      | checked | Title | First Name | Last Name | ADDRESS | Country |
      | false   |       | Vladimir   | LOSEV     |         |         |

  @C36220471
  Scenario: C36220471: DDR Ordering - Ad Hoc: Organisation type : Order Due Diligence Report - Manage Key Principal - Add to list
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "Individual" "Vladimir LOSEV" via API and open it
    And User clicks on Third-party Information tab
    And User clicks Create Order button
    Then Create Due Diligence Order page is opened
    And Order type is "Organisation"
    And 'No Available data' is displayed in 'Key Principal' section
    When User clicks "Manage Key Principal" button on Due Diligence Order page
    Then Manage Key Principal table contains records
      | checked | Title | First Name | Last Name | ADDRESS | Country |
      | false   |       | Vladimir   | LOSEV     |         |         |
    When User clicks checkbox for key principal with First Name "Vladimir"
    And User clicks Add to List Key Principle button
    Then Order Key Principal table contains records
      | KEY PRINCIPAL NAME | EMAIL            | ADDRESS |
      | Vladimir LOSEV     | test@example.com |         |
    When User clicks "Manage Key Principal" button on Due Diligence Order page
    And User waits for progress bar to disappear from page
    And User clicks checkbox for key principal with First Name "Vladimir"
    And User clicks Add to List Key Principle button
    Then 'No Available data' is displayed in 'Key Principal' section

  @C36220513
  Scenario: C36220513: DDR Ordering - Ad Hoc: Individual type : Order Due Diligence Report - Manage Key Principal
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "Individual" "Vladimir LOSEV" via API and open it
    And User clicks on Third-party Information tab
    And User clicks Create Order button
    Then Create Due Diligence Order page is opened
    And Order type is "Organisation"
    When User selects "Individual" Due Diligence Order Type
    And User clicks "Manage Key Principal" button on Due Diligence Order page
    And User fills Key Principle form data "Key Principle all fields"
    Then Alert Dialog with text is displayed
      | New Key principal                                                                                       |
      | New Key principal will also be added in Third-party Associated Individual list. Do you want to proceed? |
    When User clicks "Cancel" Alert dialog button
    Then Manage Key Principal page Add New Contact section is displayed with the following fields
      | Title               |
      | Local Language Name |
      | Email               |
    And Manage Key Principal page Add New Contact section is displayed with the following required fields
      | First Name |
      | Last Name  |
    And Manage Key Principal page Address section is displayed with the following fields
      | Address line    |
      | City            |
      | State/Province  |
      | Zip/Postal Code |
    And Manage Key Principal page Address section is displayed with the following required fields
      | Country |
    And Manage Key Principal page note "(New associated individual / Changes in associated individual details will be reflected on Third-party Associated Parties Tab)" is displayed
    And Manage Key Principal table is not displayed
    When User fills Key Principle form data "Key Principle all fields"
    And User clicks "Proceed" Alert dialog button
    Then Due Diligence Subject Full Name is populated with "Key Principle"
    When User opens Contacts for previously created Third-party
    Then Associated Party table contains associated party with values
      | Key Principal | Title      | First Name | Last Name | Country | Status   |
      | true          | Test title | Key        | Principle | Ukraine | Inactive |
      | false         |            | Vladimir   | LOSEV     |         | Inactive |

  @C36275301
  Scenario: C36275301: DDR Ordering  - Ad Hoc: Organisation/Individual type : Order Confirmation Page / Preview Order Page
    Given User logs into RDDC as "Admin"
    When User sets up Due Diligence Order Approval Responsible Party Default Approver via API
    And User makes sure that Custom field "Billing Entity" is set as not required via API
    And User creates third-party "with random ID name" via API and open it
    And User clicks on Create Order under Due Diligence Order section
    Then Create Due Diligence Order page is opened
    When User fills in Po No.
    And User clicks none selected scope
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed
    When User navigates to Home page
    And User clicks 'Pending Orders For Approval' widget
    And User clicks Activity from 'Pending Order for Approval' table
    And User clicks "Approve and Place Order" button on Due Diligence Order page
    Then Confirmation block should be displayed
    And "THIS IS TO CONFIRM YOUR ORDER DETAILS. WOULD YOU LIKE TO PROCEED?" message for Due Diligence Order is displayed
    And "proceed" button on Due Diligence page is displayed
    And "cancel" button on Due Diligence page is displayed
    And Order Confirmation 'Order Details' section should be shown with default values for "Organisation" order type
    And Order Confirmation 'Organisation Subject Details' section should be shown with default values
    And Order Confirmation 'Default Due Diligence Scope' section for Organisation type should be shown with default values
    And Order Confirmation 'Additional Add Ons' section should be hidden
    And Order Confirmation 'List Of Key Principals' section for Organisation type should be hidden
    And Order Confirmation 'Attachment' section should be shown with default values
    And Order Confirmation 'Comment' section should be shown with default values
    When User on confirmation block clicks "cancel"
    Then Create Due Diligence Order page is opened
    When User clicks "Place Order" button on Due Diligence Order page
    And User on confirmation block clicks "proceed"
    Then "ORDER SUCCESSFULLY SUBMITTED" message for Due Diligence Order is displayed
    And Order Confirmation 'Order Details' section should be shown with default values for "Organisation" order type
    And Order Confirmation 'Organisation Subject Details' section should be shown with default values
    And Order Confirmation 'Default Due Diligence Scope' section for Organisation type should be shown with default values
    And Order Confirmation 'List Of Key Principals' section for Organisation type should be hidden
    And Order Confirmation 'Attachment' section should be shown with default values
    And Order Confirmation 'Comment' section should be shown with default values
    When User clicks Back button on Due Diligence Order page
    Then Activity Information page is displayed