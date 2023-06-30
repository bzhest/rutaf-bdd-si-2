@api @public_api @postPublicQSTReceiveBulkQuestionnaireResponseAttachmentThirdPartyNotExist
Feature: Receive Bulk Questionnaire Response Attachment Third Party Not Exist

  Background:
    * def xTenantCode = tenant
    * def nextPageToken = ''

    * def fileA = call read('publicPOSTThirdPartyCreateThirdPartySingle.feature')
    * def thirdPartyId = fileA.response.data.id
    * print thirdPartyId

    * def getAccessToken = isSwaggerDirect==true? {}   : karate.callonce( "../callonce/getAccessToken.feature" )
    * def accessToken =    isSwaggerDirect?       ''   : $getAccessToken.response.access_token
    * def accessTokenExp = isSwaggerDirect?       ''   : $getAccessToken.response.expires_in

    * def writeToFileObject =
      """
        function( fqFilename, text ) {
            var TextFileWriter = Java.type( 'com.refinitiv.asts.test.ui.utils.TextFileWriter' );
            var tfw = new TextFileWriter();
            tfw.writeToFileObject( fqFilename, text );
        }
      """

    * def archiveToZipFile =
      """
        function( fqZipArchiveFilename, fqZipEntryFilename ) {
            var ZipFileArchiver = Java.type( 'com.refinitiv.asts.test.ui.utils.ZipFileArchiver' );
            var zfa = new ZipFileArchiver();
            return zfa.archiveToZipFile( fqZipArchiveFilename, fqZipEntryFilename );
        }
      """

    * def addOrReplaceEntry =
      """
        function( fqZipArchiveFilename, fqZipEntryFilename ) {
            var ZipFileArchiver = Java.type( 'com.refinitiv.asts.test.ui.utils.ZipFileArchiver' );
            var zfa = new ZipFileArchiver();
            return zfa.addOrReplaceEntry( fqZipArchiveFilename, fqZipEntryFilename );
        }
      """

    * def newPostAssignQST =
        """
          {
         "assignee": "rddcentre.admin.np@refinitiv.com",
         "dueDate": "2022-10-30",
         "overallReviewer": "rddcentre.admin.np@refinitiv.com",
         "questionnaireNames": ["SAMPLE AUTO QUESTIONNAIRE"],
         "questionnaireType": "INTERNAL",
         "initiatedBy": "rddcentre.admin.np@refinitiv.com"
          }
        """

    * configure logPrettyResponse = true

  Scenario:
    # Assign Questionnaire
    Given url postUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId, 'assign-questionnaire'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And header RequestorEmail = requestorEmail
    And request newPostAssignQST
    When method POST
    Then status 200

    # Retrieve Questionnaire Assignment List by Third-party ID
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId, 'questionnaires'
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method GET
    Then status 200

  * def assignmentId = get response.data.questionnaires[0].assignmentId
  * def language = get response.data.questionnaires[0].languages[0]
    And match thirdPartyId == get response.data.id

    And print '******** assignmentId         = '+ assignmentId
    And print '******** language         = '+ language

    # Retrieve Questionnaire Details by Questionnaire Assignment ID
    Given url getUrl = baseTestUrl
    And path 'thirdparty', thirdPartyId, 'questionnaires', assignmentId
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    And param language = language
    When method GET
    Then status 200

    * def tabId = get response.data.tabs[0].tabId
    * def questionId = get response.data.tabs[0].questions[0].questionId
    * def optionId = get response.data.tabs[0].questions[0].options[0].optionId
    And match assignmentId == get response.data.assignmentId

    And print '******** tabId         = '+ tabId
    And print '******** questionId         = '+ questionId
    And print '******** optionId         = '+ optionId

    # Preparing meta.json
    * def metaJsonContentArr = null
    * json metaJsonContentArr = ( metaJsonContentArr || [] )

    * def metaJsonContentElem = { 'questionnaireId' : '#(assignmentId)' }
    * json attachments = []
    * if ( ! metaJsonContentElem.attachments ) metaJsonContentElem.attachments = attachments
#
#    # Add attachment file to ZIP file
    * def attachmentsArrElem = 'TEST_JPG.jpg'
    * def archiveToZipFileResult = archiveToZipFile( "./src/test/resources/features/api/public_questionnaires/ZipArchiveFiles/TEST_ZIP_file.zip", "./src/test/resources/features/api/public_questionnaires/ZipArchiveFiles/"+ attachmentsArrElem )
    * def attachmentArrElemJsonObj = {'questionId': '#(questionId)', 'description': 'This is sample description', 'filename': '#(attachmentsArrElem)' }
    * def void = ( metaJsonContentElem.attachments.add(attachmentArrElemJsonObj) )

    And print '\n'
    And print '================================'
    And print '******** BULK-ATTACH FILES TO QUESTIONNAIRE: VALID FILES IN ZIP ARCHIVE'
    And print '******** ZIP FILENAME = '+ archiveToZipFileResult
    And print '================================\n'
    And print '\n'

    # Write meta information to 'meta.json' FILE
    * def void = ( metaJsonContentArr.add(metaJsonContentElem) )
    * def writeToFileResult = writeToFileObject( "./src/test/resources/features/api/public_questionnaires/ZipArchiveFiles/meta.json", metaJsonContentArr )

    # Add 'meta.json' file to ZIP FILE
    * def attachmentsArrElem = 'meta.json'
    * def addOrReplaceEntryResult = addOrReplaceEntry( "./src/test/resources/features/api/public_questionnaires/ZipArchiveFiles/TEST_ZIP_file.zip", "./src/test/resources/features/api/public_questionnaires/ZipArchiveFiles/"+ attachmentsArrElem )

    Given url postUrl = baseTestUrl
    And path 'thirdparty', 'invalid', 'questionnaires', 'bulk-attachments'
    And multipart file file = { read:'./ZipArchiveFiles/TEST_ZIP_file.zip', filename:'TEST_ZIP_file.zip', contentType: 'application/zip' }
    And header X-Tenant-Code = xTenantCode
    And header Authorization = 'Bearer '+ accessToken
    When method POST
    Then status 400

