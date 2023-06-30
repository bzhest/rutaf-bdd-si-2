@ui @smoke @third_party_related_files
Feature: Smoke RDDC testing

  As an user
  I want to be able to add attachments to third party
  So, they are shown in Related Files table

  @C43652459
  Scenario: C43652459: Third-party Information - Add Related Files
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User adds Third-party attachment
      | File Name | Description           |
      | logo.jpg  | Test File Description |
    Then Related Files table displays file details
      | File Name | Description           | Upload Date |
      | logo.jpg  | Test File Description | MM/dd/YYYY  |
    And Related Files table displays column names
      | thirdPartyInformation.relatedFiles.fileName    |
      | thirdPartyInformation.relatedFiles.description |
      | thirdPartyInformation.relatedFiles.uploadDate  |
    And Download icon is displayed for file with name "logo.jpg"
    And Delete icon is displayed for file with name "logo.jpg"
