@api @public_api @postContactBulkCreate
Feature: Post Contacts Bulk

  As a user
  I would like to verify Post Contacts Bulk test script
  So that I can create bulk contacts

  Background:
   * def urlPath = '/contacts/bulk'
   * def xTenantCode = tenant



    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in

    * def newPostRequestBodyBulkContacts =
        """
          [
            {
              "parent": "#(parent)",
              "title": "Mr.",
              "firstName": "Jared",
              "middleName": "Van",
              "lastName": "Smith",
              "personalDetails": {
                "citizenship": "US",
                "placeOfBirth": "US"
              },
              "addresses": [
                {
                  "addressLine": "Address Line 1",
                  "city": "City 1",
                  "country": "US",
                  "postalCode": "31080",
                  "province": "Province 1",
                  "region": "#(region)"
                }
              ],
              "contactInformation": {
                "email": [
                  "john.smith@company1.com"
                ],
                "fax": [
                  "+91 (123) 456-7890"
                ],
                "phoneNumber": [
                  "(123) 456-7890"
                ],
                "website": [
                  "http://www.company1.com"
                ]
              },
              "description": "This is contact's description",
              "otherNames": [],
              "isActive": false,
              "isPrincipal": false,
              "autoScreen": false
            },
            {
              "parent": "#(parent)",
              "title": "Mr.",
              "firstName": "Jane",
              "middleName": "Colar",
              "lastName": "Houston",
              "personalDetails": {
                "nationality": "US",
                "placeOfBirth": "US"
              },
              "addresses": [
                {
                  "addressLine": "Address Line 1",
                  "city": "City 1",
                  "country": "US",
                  "postalCode": "31080",
                  "province": "Province 1",
                  "region": "#(region)"
                }
              ],
              "contactInformation": {
                "email": [
                  "john.smith@company1.com"
                ],
                "fax": [
                  "+91 (123) 456-7890"
                ],
                "phoneNumber": [
                  "(123) 456-7890"
                ],
                "website": [
                  "http://www.company1.com"
                ]
              },
              "description": "This is contact's description",
              "otherNames": [],
              "isActive": false,
              "isPrincipal": false,
              "autoScreen": false
            }
          ]
        """


    * configure logPrettyResponse = true


  Scenario: C36333411 : Public API - POST /contacts/bulk - Verify that contacts are successfully created
    Given url postUrl = baseTestUrl
    And path urlPath
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And request newPostRequestBodyBulkContacts
    When method POST
    Then status 207