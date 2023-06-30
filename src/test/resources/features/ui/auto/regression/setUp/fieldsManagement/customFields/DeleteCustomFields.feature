@ui @full_regression @custom_fields
Feature: Custom Fields - Deleting Custom Fields

  As an Admin user,
  I want to delete custom fields,
  So then use them in Supplier Onboarding

  @C36051917
  Scenario Outline: C36051917: [Custom Field Setup] Deleting - Delete a Custom Field
    Given User logs into RDDC as "Admin"
    When User creates Custom Field "<customField>" via API
    And User navigates to Custom Fields page
    And User clicks Delete button for Custom Field
    Then Message is displayed on confirmation window
      | Deleting this custom field will remove the corresponding third party data. |
      | Are you sure you want to delete this field?                                |
      | This change cannot be undone.                                              |
    When User clicks Cancel button on confirmation window
    Then Created Custom Field is displayed with values
      | Name               | Field Type | Status   | Date Created | Description           |
      | customFieldNameAPI | Text       | <status> | MM/dd/YYYY   | Auto Test description |
    When User clicks Delete button for Custom Field
    And User clicks Delete button on confirmation window
    Then Custom field with name "customFieldNameAPI" does not exist
    Examples:
      | customField                             | status         |
      | active with random name and Text type   | Active         |
      | inactive with description and Text type | Inactive       |
      | draft with description and Text type    | Saved As Draft |