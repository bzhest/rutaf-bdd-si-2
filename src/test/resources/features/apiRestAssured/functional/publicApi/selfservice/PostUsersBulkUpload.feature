@api_rest_assured @selfservice
Feature: Self-Service - Post Users Bulk Upload

  As a developer,
  I want to create Internal USER via Self-Service Bulk-Upload API.
  So that new user is created and found in User Management.


  @C38235398
  Scenario: C38235398 (ADD-01) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - User has been added to User management
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadADDUserSuccess.csv" "ADD Users Success CSV" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "ADD Users Success CSV" status code is 202
    And Self-Service USERS endpoint "ADD Users Success CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "ADD Users Success CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema" response schema

  @C38235399
  Scenario: C38235399 (ADD-02) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - Create user with Billing Entity
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadADDUserWBillingEntitySuccess.csv" "ADD Users w Billing Entity Success CSV" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "ADD Users w Billing Entity Success CSV" status code is 202
    And Self-Service USERS endpoint "ADD Users w Billing Entity Success CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "ADD Users w Billing Entity Success CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema" response schema

  @C38235400
  Scenario: C38235400 (ADD-03) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - Account already exists - ADD
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadADDUserErrorDuplicateUser.csv" "ADD Users Error Duplicate Email CSV" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "ADD Users Error Duplicate Email CSV" status code is 202
    And Self-Service USERS endpoint "ADD Users Error Duplicate Email CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "ADD Users Error Duplicate Email CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 1-Suc 1-Err Expected Response Schema" response schema

  @C38235394
  Scenario: C38235394 (ADD-04) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - Incorrect Action Type - ADD
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadADDUserErrorIncorrectActionType.csv" "ADD Users Error Incorrect Action Type CSV" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "ADD Users Error Incorrect Action Type CSV" status code is 202
    And Self-Service USERS endpoint "ADD Users Error Incorrect Action Type CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "ADD Users Error Incorrect Action Type CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema" response schema

  @C38235393
  Scenario: C38235393 (ADD-05) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - Invalid Action Type - ADD
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadADDUserErrorInvalidActionType.csv" "ADD Users Error Invalid Action Type CSV" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "ADD Users Error Invalid Action Type CSV" status code is 202
    And Self-Service USERS endpoint "ADD Users Error Invalid Action Type CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "ADD Users Error Invalid Action Type CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema" response schema

  @C38235395
  Scenario Outline: C38235395 (ADD-06) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - Missing Field - ADD
    When User uploads flat-file "<UploadCSV_Ref>" "ADD Users Error Missing Field CSV" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "ADD Users Error Missing Field CSV" status code is 202
    And Self-Service USERS endpoint "ADD Users Error Missing Field CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "ADD Users Error Missing Field CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema" response schema
    Examples:
      | UploadCSV_Ref                                                                    |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorMissingFieldActionType.csv       |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorMissingFieldGroupId.csv          |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorMissingFieldNameFirst.csv        |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorMissingFieldNameLast.csv         |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorMissingFieldEnableSSO.csv        |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorMissingFieldRole.csv             |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorMissingFieldActive.csv           |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorMissingFieldDivision.csv         |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorMissingFieldEmail.csv            |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorMissingFieldDefBillingEntity.csv |

  @C38235396
  Scenario Outline: C38235396 (ADD-07) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - Maximum length exceed - ADD
    When User uploads flat-file "<UploadCSV_Ref>" "<UploadFile_UseCase_Desc_Resp_CtxRef>" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "<UploadFile_UseCase_Desc_Resp_CtxRef>" status code is 202
    And Self-Service USERS endpoint "<UploadFile_UseCase_Desc_Resp_CtxRef>" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "<GetProcessIdStatus_UseCase_Desc_Resp_CtxRef>" from "<UploadFile_UseCase_Desc_Resp_CtxRef>" by GET request to Self-Service ProcessId endpoint
    Then Response "<GetProcessIdStatus_UseCase_Desc_Resp_CtxRef>" status code is 200
    And Self-Service Process Id Status endpoint "<GetProcessIdStatus_UseCase_Desc_Resp_CtxRef>" response contains expected "<GetProcessIdStatus_RespSchema>" response schema
    Examples:
      | UploadCSV_Ref                                                                     | UploadFile_UseCase_Desc_Resp_CtxRef                      | GetProcessIdStatus_UseCase_Desc_Resp_CtxRef                    | GetProcessIdStatus_RespSchema                                                    |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorMaxLengthExceeded-nameFirst64.csv | ADD Users Success Max. Length Reached  First Name 64 CSV | ADD Users Success First Name 64 Get Response Process Id Status | Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorMaxLengthExceeded-nameFirst65.csv | ADD Users Error   Max. Length Exceeded First Name 65 CSV | ADD Users Error   First Name 65 Get Response Process Id Status | Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorMaxLengthExceeded-nameLast64.csv  | ADD Users Success Max. Length Reached  Last  Name 64 CSV | ADD Users Success Last  Name 64 Get Response Process Id Status | Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorMaxLengthExceeded-nameLast65.csv  | ADD Users Error   Max. Length Exceeded Last  Name 65 CSV | ADD Users Error   Last  Name 65 Get Response Process Id Status | Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorMaxLengthExceeded-position64.csv  | ADD Users Success Max. Length Reached  Position   64 CSV | ADD Users Success Position   64 Get Response Process Id Status | Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorMaxLengthExceeded-position65.csv  | ADD Users Error   Max. Length Exceeded Position   65 CSV | ADD Users Error   Position   65 Get Response Process Id Status | Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorMaxLengthExceeded-email64.csv     | ADD Users Success Max. Length Reached  Email      64 CSV | ADD Users Success Email      64 Get Response Process Id Status | Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorMaxLengthExceeded-email65.csv     | ADD Users Error   Max. Length Exceeded Email      65 CSV | ADD Users Error   Email      65 Get Response Process Id Status | Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema |

  @C38235397
  Scenario Outline: C38235397 (ADD-08) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - Invalid value - ADD
    When User uploads flat-file "<UploadCSV_Ref>" "<UploadFile_UseCase_Desc_Resp_CtxRef>" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "<UploadFile_UseCase_Desc_Resp_CtxRef>" status code is 202
    And Self-Service USERS endpoint "<UploadFile_UseCase_Desc_Resp_CtxRef>" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "<UploadFile_UseCase_Desc_Resp_CtxRef>" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema" response schema
    Examples:
      | UploadCSV_Ref                                                                        | UploadFile_UseCase_Desc_Resp_CtxRef                   |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorInvalidValues-enableSSO.csv          | ADD Users Error Invalid Value Enable SSO CSV          |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorInvalidValues-role.csv               | ADD Users Error Invalid Value Role CSV                |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorInvalidValues-active.csv             | ADD Users Error Invalid Value Active CSV              |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorInvalidValues-group.csv              | ADD Users Error Invalid Value Group CSV               |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorInvalidValues-superior.csv           | ADD Users Error Invalid Value Superior CSV            |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorInvalidValues-division.csv           | ADD Users Error Invalid Value Division CSV            |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorInvalidValues-entity.csv             | ADD Users Error Invalid Value Entity CSV              |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorInvalidValues-entity.csv             | ADD Users Error Invalid Value Ext. Org. CSV           |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorInvalidValues-department.csv         | ADD Users Error Invalid Value Department CSV          |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorInvalidValues-email.csv              | ADD Users Error Invalid Value Email CSV               |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorInvalidValues-billingEntityDef.csv   | ADD Users Error Invalid Value Def. Billing Entity CSV |
      | postPublicSelfServiceUsersBulkUploadADDUserErrorInvalidValues-billingEntityOther.csv | ADD Users Error Invalid Value Oth. Billing Entity CSV |

  @C38235421
  Scenario: C38235421 (FULLUPDATE-01) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - User has been successfully update - FULLUPDATE
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadADDUserSuccess.csv" "ADD Users Success CSV" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "ADD Users Success CSV" status code is 202
    And Self-Service USERS endpoint "ADD Users Success CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "ADD Users Success CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema" response schema
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadADDUserSuccess.csv" "FULLUPDATE Users Success CSV" by POST request to Self-Service Internal Users Add-Update endpoint for User "User Reference"
    Then Response "FULLUPDATE Users Success CSV" status code is 202
    And Self-Service USERS endpoint "FULLUPDATE Users Success CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "FULLUPDATE Users Success CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema" response schema

  @C38235416
  Scenario: C38235416 (FULLUPDATE-02) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - Incorrect Action Type - FULLUPDATE
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadADDUserSuccess.csv" "ADD Users Success CSV" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "ADD Users Success CSV" status code is 202
    And Self-Service USERS endpoint "ADD Users Success CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "ADD Users Success CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema" response schema
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorIncorrectActionType.csv" "FULLUPDATE Users Incorrect Action Type CSV" by POST request to Self-Service Internal Users Add-Update endpoint for User "User Reference"
    Then Response "FULLUPDATE Users Incorrect Action Type CSV" status code is 202
    And Self-Service USERS endpoint "FULLUPDATE Users Incorrect Action Type CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "FULLUPDATE Users Incorrect Action Type CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema" response schema

  @C38235415
  Scenario: C38235415 (FULLUPDATE-03) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - Invalid Action Type - FULLUPDATE
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadADDUserSuccess.csv" "ADD Users Success CSV" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "ADD Users Success CSV" status code is 202
    And Self-Service USERS endpoint "ADD Users Success CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "ADD Users Success CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema" response schema
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorInvalidActionType.csv" "FULLUPDATE Users Invalid Action Type CSV" by POST request to Self-Service Internal Users Add-Update endpoint for User "User Reference"
    Then Response "FULLUPDATE Users Invalid Action Type CSV" status code is 202
    And Self-Service USERS endpoint "FULLUPDATE Users Invalid Action Type CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "FULLUPDATE Users Invalid Action Type CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema" response schema

  @C38235419
  Scenario Outline: C38235419 (FULLUPDATE-04) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - Maximum length exceed - FULLUPDATE
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadADDUserSuccess.csv" "ADD Users Success CSV" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "ADD Users Success CSV" status code is 202
    And Self-Service USERS endpoint "ADD Users Success CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "ADD Users Success CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema" response schema
    When User uploads flat-file "<UploadCSV_Ref>" "<UploadFile_UseCase_Desc_Resp_CtxRef>" by POST request to Self-Service Internal Users Add-Update endpoint for User "User Reference"
    Then Response "<UploadFile_UseCase_Desc_Resp_CtxRef>" status code is 202
    And Self-Service USERS endpoint "<UploadFile_UseCase_Desc_Resp_CtxRef>" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status 2" from "<UploadFile_UseCase_Desc_Resp_CtxRef>" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status 2" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status 2" response contains expected "<GetProcessIdStatus_RespSchema>" response schema
    Examples:
      | UploadCSV_Ref                                                                            | UploadFile_UseCase_Desc_Resp_CtxRef                  | GetProcessIdStatus_RespSchema                                                    |
      | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorMaxLengthExceeded-nameFirst64.csv | FULLUPDATE Users First Name Max. Length Exceeded CSV | Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema |
      | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorMaxLengthExceeded-nameFirst65.csv | FULLUPDATE Users First Name Max. Length Exceeded CSV | Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema |
      | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorMaxLengthExceeded-nameLast64.csv  | FULLUPDATE Users Last Name Max. Length Exceeded CSV  | Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema |
      | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorMaxLengthExceeded-nameLast65.csv  | FULLUPDATE Users Last Name Max. Length Exceeded CSV  | Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema |
      | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorMaxLengthExceeded-position64.csv  | FULLUPDATE Users Position Max. Length Exceeded CSV   | Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema |
      | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorMaxLengthExceeded-position65.csv  | FULLUPDATE Users Position Max. Length Exceeded CSV   | Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema |

  @C38235418
  Scenario Outline: C38235418 (FULLUPDATE-05) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - Missing Field - FULLUPDATE
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadADDUserSuccess.csv" "ADD Users Success CSV" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "ADD Users Success CSV" status code is 202
    And Self-Service USERS endpoint "ADD Users Success CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "ADD Users Success CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema" response schema
    When User uploads flat-file "<UploadCSV_Ref>" "<UploadFile_UseCase_Desc_Resp_CtxRef>" by POST request to Self-Service Internal Users Add-Update endpoint for User "User Reference"
    Then Response "<UploadFile_UseCase_Desc_Resp_CtxRef>" status code is 202
    And Self-Service USERS endpoint "<UploadFile_UseCase_Desc_Resp_CtxRef>" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status 2" from "<UploadFile_UseCase_Desc_Resp_CtxRef>" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status 2" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status 2" response contains expected "Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema" response schema
    Examples:
      | UploadFile_UseCase_Desc_Resp_CtxRef              | UploadCSV_Ref                                                                            |
      | FULLUPDATE Users Missing Action Type CSV         | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorMissingField-actionType.csv       |
      | FULLUPDATE Users Missing Group Id CSV            | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorMissingField-groupId.csv          |
      | FULLUPDATE Users Missing First Name CSV          | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorMissingField-nameFIrst.csv        |
      | FULLUPDATE Users Missing Last Name CSV           | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorMissingField-nameLast.csv         |
      | FULLUPDATE Users Missing Enable SSO CSV          | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorMissingField-enableSSO.csv        |
      | FULLUPDATE Users Missing Division CSV            | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorMissingField-division.csv         |
      | FULLUPDATE Users Missing Email CSV               | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorMissingField-email.csv            |
      | FULLUPDATE Users Missing Def. Billing Entity CSV | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorMissingField-defBillingEntity.csv |

  @C38235420
  Scenario Outline: C38235420 (FULLUPDATE-06) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - Invalid value - FULLUPDATE
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadADDUserSuccess.csv" "ADD Users Success CSV" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "ADD Users Success CSV" status code is 202
    And Self-Service USERS endpoint "ADD Users Success CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "ADD Users Success CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema" response schema
    When User uploads flat-file "<UploadCSV_Ref>" "<UploadFile_UseCase_Desc_Resp_CtxRef>" by POST request to Self-Service Internal Users Add-Update endpoint for User "User Reference"
    Then Response "<UploadFile_UseCase_Desc_Resp_CtxRef>" status code is 202
    And Self-Service USERS endpoint "<UploadFile_UseCase_Desc_Resp_CtxRef>" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "<UploadFile_UseCase_Desc_Resp_CtxRef>" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema" response schema
    Examples:
      | UploadCSV_Ref                                                                            | UploadFile_UseCase_Desc_Resp_CtxRef              |
      | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorInvalidValue-enableSSO.csv        | FULLUPDATE Users Invalid Enable SSO CSV          |
      | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorInvalidValue-role.csv             | FULLUPDATE Users Invalid Role CSV                |
      | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorInvalidValue-active.csv           | FULLUPDATE Users Invalid Active CSV              |
      | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorInvalidValue-group.csv            | FULLUPDATE Users Invalid Group CSV               |
      | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorInvalidValue-superior.csv         | FULLUPDATE Users Invalid Superior CSV            |
      | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorInvalidValue-division.csv         | FULLUPDATE Users Invalid Division CSV            |
      | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorInvalidValue-entity.csv           | FULLUPDATE Users Invalid Entity CSV              |
      | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorInvalidValue-extOrg.csv           | FULLUPDATE Users Invalid Ext. Org. CSV           |
      | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorInvalidValue-department.csv       | FULLUPDATE Users Invalid Department CSV          |
      | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorInvalidValue-email.csv            | FULLUPDATE Users Invalid Email CSV               |
      | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorInvalidValue-billingEntityDef.csv | FULLUPDATE Users Invalid Def. Billing Entity CSV |
      | postPublicSelfServiceUsersBulkUploadFULLUPDATEUserErrorInvalidValue-billingEntityOth.csv | FULLUPDATE Users Invalid Oth. Billing Entity CSV |

  @C38235411
  Scenario: C38235411 (PARTUPDATE-01) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - User has been successfully update - PARTUPDATE
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadADDUserSuccess.csv" "ADD Users Success CSV" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "ADD Users Success CSV" status code is 202
    And Self-Service USERS endpoint "ADD Users Success CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "ADD Users Success CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema" response schema
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadPARTUPDATEUserSuccess.csv" "PARTUPDATE Users Success CSV" by POST request to Self-Service Internal Users Add-Update endpoint for User "User Reference"
    Then Response "PARTUPDATE Users Success CSV" status code is 202
    And Self-Service USERS endpoint "PARTUPDATE Users Success CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status 2" from "PARTUPDATE Users Success CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status 2" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status 2" response contains expected "Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema" response schema

  @C38235406
  Scenario: C38235406 (PARTUPDATE-02) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - Incorrect Action Type - PARTUPDATE
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadADDUserSuccess.csv" "ADD Users Success CSV" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "ADD Users Success CSV" status code is 202
    And Self-Service USERS endpoint "ADD Users Success CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "ADD Users Success CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema" response schema
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorIncorrectActionType.csv" "PARTUPDATE Users Incorrect Action Type CSV" by POST request to Self-Service Internal Users Add-Update endpoint for User "User Reference"
    Then Response "PARTUPDATE Users Incorrect Action Type CSV" status code is 202
    And Self-Service USERS endpoint "PARTUPDATE Users Incorrect Action Type CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status 2" from "PARTUPDATE Users Incorrect Action Type CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status 2" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status 2" response contains expected "Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema" response schema

  @C38235405
  Scenario: C38235405 (PARTUPDATE-03) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - Invalid Action Type - PARTUPDATE
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadADDUserSuccess.csv" "ADD Users Success CSV" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "ADD Users Success CSV" status code is 202
    And Self-Service USERS endpoint "ADD Users Success CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "ADD Users Success CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema" response schema
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorInvalidActionType.csv" "PARTUPDATE Users Invalid Action Type CSV" by POST request to Self-Service Internal Users Add-Update endpoint for User "User Reference"
    Then Response "PARTUPDATE Users Invalid Action Type CSV" status code is 202
    And Self-Service USERS endpoint "PARTUPDATE Users Invalid Action Type CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "PARTUPDATE Users Invalid Action Type CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema" response schema

  @C38235409
  Scenario Outline: C38235409 (PARTUPDATE-04) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - Maximum length exceed - PARTUPDATE
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadADDUserSuccess.csv" "ADD Users Success CSV" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "ADD Users Success CSV" status code is 202
    And Self-Service USERS endpoint "ADD Users Success CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "ADD Users Success CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema" response schema
    When User uploads flat-file "<UploadCSV_Ref>" "<UploadFile_UseCase_Desc_Resp_CtxRef>" by POST request to Self-Service Internal Users Add-Update endpoint for User "User Reference"
    Then Response "<UploadFile_UseCase_Desc_Resp_CtxRef>" status code is 202
    And Self-Service USERS endpoint "<UploadFile_UseCase_Desc_Resp_CtxRef>" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "<UploadFile_UseCase_Desc_Resp_CtxRef>" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "<GetProcessIdStatus_RespSchema2>" response schema
    Examples:
      | UploadCSV_Ref                                                                            | UploadFile_UseCase_Desc_Resp_CtxRef                  | GetProcessIdStatus_RespSchema2                                                   |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorMaxLengthExceeded-nameFirst64.csv | PARTUPDATE Users First Name Max. Length Exceeded CSV | Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorMaxLengthExceeded-nameFirst65.csv | PARTUPDATE Users First Name Max. Length Exceeded CSV | Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorMaxLengthExceeded-nameLast64.csv  | PARTUPDATE Users Last Name Max. Length Exceeded CSV  | Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorMaxLengthExceeded-nameLast65.csv  | PARTUPDATE Users Last Name Max. Length Exceeded CSV  | Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorMaxLengthExceeded-position64.csv  | PARTUPDATE Users Position Max. Length Exceeded CSV   | Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorMaxLengthExceeded-position65.csv  | PARTUPDATE Users Position Max. Length Exceeded CSV   | Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema |

  @C38235408
  Scenario Outline: C38235408 (PARTUPDATE-05) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - Missing Field - PARTUPDATE
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadADDUserSuccess.csv" "ADD Users Success CSV" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "ADD Users Success CSV" status code is 202
    And Self-Service USERS endpoint "ADD Users Success CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "ADD Users Success CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema" response schema
    When User uploads flat-file "<UploadCSV_Ref>" "Retrieve Response Process Status 2" by POST request to Self-Service Internal Users Add-Update endpoint for User "User Reference"
    Then Response "Retrieve Response Process Status 2" status code is 202
    And Self-Service USERS endpoint "Retrieve Response Process Status 2" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status 2" from "Retrieve Response Process Status 2" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status 2" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status 2" response contains expected "Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema" response schema
    Examples:
      | UploadCSV_Ref                                                                      |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorMissingField-actionType.csv |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorMissingField-groupId.csv    |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorMissingField-email.csv      |

  @C38235410
  Scenario Outline: C38235410 (PARTUPDATE-06) Self Service Bulk Processing (Phase 1) - Bulk Process - Flat File : Internal User - Invalid value - PARTUPDATE
    When User uploads flat-file "postPublicSelfServiceUsersBulkUploadADDUserSuccess.csv" "ADD Users Success CSV" by POST request to Self-Service Internal Users Add-Update endpoint
    Then Response "ADD Users Success CSV" status code is 202
    And Self-Service USERS endpoint "ADD Users Success CSV" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "ADD Users Success CSV" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 1-Suc 0-Err Expected Response Schema" response schema
    When User uploads flat-file "<UploadCSV_Ref>" "<UploadFile_UseCase_Desc_Resp_CtxRef> 2" by POST request to Self-Service Internal Users Add-Update endpoint for User "User Reference"
    Then Response "<UploadFile_UseCase_Desc_Resp_CtxRef> 2" status code is 202
    And Self-Service USERS endpoint "<UploadFile_UseCase_Desc_Resp_CtxRef> 2" response contains expected "Self-Service USERS Upload CSV File OK Expected Response Schema" response schema
    When User sends "Retrieve Response Process Status" from "<UploadFile_UseCase_Desc_Resp_CtxRef> 2" by GET request to Self-Service ProcessId endpoint
    Then Response "Retrieve Response Process Status" status code is 200
    And Self-Service Process Id Status endpoint "Retrieve Response Process Status" response contains expected "Self-Service USERS Get Process Id Status OK 0-Suc 1-Err Expected Response Schema" response schema
    Examples:
      | UploadCSV_Ref                                                                            | UploadFile_UseCase_Desc_Resp_CtxRef              |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorInvalidValue-enableSSO.csv        | PARTUPDATE Users Invalid Enable SSO CSV          |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorInvalidValue-role.csv             | PARTUPDATE Users Invalid Role CSV                |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorInvalidValue-active.csv           | PARTUPDATE Users Invalid Active CSV              |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorInvalidValue-group.csv            | PARTUPDATE Users Invalid Group CSV               |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorInvalidValue-superior.csv         | PARTUPDATE Users Invalid Superior CSV            |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorInvalidValue-division.csv         | PARTUPDATE Users Invalid Division CSV            |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorInvalidValue-entity.csv           | PARTUPDATE Users Invalid Entity CSV              |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorInvalidValue-extOrg.csv           | PARTUPDATE Users Invalid Ext. Org. CSV           |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorInvalidValue-department.csv       | PARTUPDATE Users Invalid Department CSV          |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorInvalidValue-email.csv            | PARTUPDATE Users Invalid Email CSV               |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorInvalidValue-billingEntityDef.csv | PARTUPDATE Users Invalid Def. Billing Entity CSV |
      | postPublicSelfServiceUsersBulkUploadPARTUPDATEUserErrorInvalidValue-billingEntityOth.csv | PARTUPDATE Users Invalid Oth. Billing Entity CSV |
 