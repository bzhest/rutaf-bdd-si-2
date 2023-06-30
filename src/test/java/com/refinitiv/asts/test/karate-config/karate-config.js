function fn() {
    var env = karate.env; // get system property 'karate.env'
    var utils = {};
    karate.log('karate.env system property was:', env);
    utils.uuid = function () {
        return java.util.UUID.randomUUID() + ''
    }
    var consts = Java.type('com.refinitiv.asts.test.ui.constants.APIConstants')
    var global = Java.type('com.refinitiv.asts.core.framework.constants.GlobalConst')
    var apiUtils = Java.type('com.refinitiv.asts.core.framework.utils.ApiUtils')
    var cliUtils = Java.type('com.refinitiv.asts.core.framework.utils.CliUtils')
    var DBUtils = Java.type('com.refinitiv.asts.core.framework.db.DbUtils')

    utils.randId = function () {
        return parseInt(Math.random() * 9999) + ''
    }
    if (!env) {
        // env = 'qa-sprint2';
        // env = 'qa-regression';
           env = 'internal-qa-regression';
        // env = 'tenant2-qa-regression';
        // env = 'nightly';
        // env = 'qa2-poc';

        // env = 'skoda-ms-staging';
        // env = 'edwards-staging';

        isSwaggerDirect = true;
        // isSwaggerDirect = false;
    }
    var config = {
        env: env,
        myVarName: 'someValue'
    }
    if (env == 'qa-sprint2') {
// TODO add dynamic generation
        config.baseUrl = "https://siconnect.qa-sprint2.supplierintegrity.com"
        config.tenant = "qa-sprint2"

//  config.baseTestUrl    = "https://api.qa-sprint2.supplierintegrity.com"
//  config.baseTestUrl    = "https://wso2apim-gateway-nonprod.supplierintegrity.com/si-public-api/v2"
//  config.accessTokenUrl = "https://wso2apim-gateway-nonprod.supplierintegrity.com"
//        config.baseTestUrl = (isSwaggerDirect ? "https://api.qa-sprint2.supplierintegrity.com" : "https://wso2apim-gateway-nonprod.supplierintegrity.com/si-public-api/v2")
        config.baseTestUrl = (isSwaggerDirect ? "https://api-qa-sprint2.dev.centre.rdd.refinitiv.com" : "https://wso2apim-gateway-nonprod.supplierintegrity.com/si-public-api/v2")
        config.accessTokenUrl = (isSwaggerDirect ? "" : "https://wso2apim-gateway-nonprod.supplierintegrity.com")
        config.headerAuth = "TXpCQlFONEltZkNiRTU2SlZIRzJqQzRmQTJ3YTp0MXZnWEZiYlcyYlJRWmRIUXRjYVh6dU4yN0Fh";
        config.workflowGroupId = "5f0e688c3d8b5596caec9e15"
        config.parent = "611c0368bc132d000122ffc7"
        config.region = "021"
        config.regionX = "142"
        // config.requestorEmail = "austin.rayosdelsol@refinitiv.com"
        config.requestorEmail = "rddcentre.admin.np@refinitiv.com"
        config.isSwaggerDirect = isSwaggerDirect

//    Static contact test data
        config.staticContactId = "6051eb21e4b0a80041f23d21"
        config.staticContactSearchId = "5jb7npv0i4qz1fhu328l1smf9"
        config.contactOtherNameSearchId = "5jb7xd4gbseo1fhuj6zcjdrn0"
        config.contactResultId = "5jb7zm0py3j91fhu32al120m2"

//    Static supplier test data
        config.staticSupplierId = "6051e9afef3b560001e1972a"
        config.staticSupplierSearchId = "5jb6t4vrniiw1fhu2iccu3csb"
        config.supplierOtherNameSearchId = "5jb6tcrw3qfg1fi13wlvzoiq9"
        config.supplierResultId = "5jb72u48laaj1fhu2iectkoq3"

//    Contact test data for update
        config.patchContactId = "6059b61fe4b0a80055380225"

//    Supplier test data for update
        config.patchSupplierId = "6059b5328459b700019760fa"

        config.resultIdWithComment = "5jb7zm0py3j91fif2xzeliz4f"
        config.profileId = "e_tr_wci_897416"

//  Public-Users test data
        config.publicUsersRoleId = "5e99280ae4b0846a31635fd8"
        config.publicUsersGroupId = "5ebe26f23bbe6400019a88d7"
        config.publicUsersSuperiorId = "565ffafdb76024381dbfd681"
        config.publicUsersEntityId = "5f0d7c81e4b0bf91671dfcc5"
        config.publicUsersDepartmentId = "6114c5a6e4b003e3b2bdd208"
        config.publicUsersExternalOrganizationId = "6114c456e4b003e3b2bdd207"
        config.publicUsersBillingEntityId = "6081fff97181f70001a3d078"

        config.billToEntityUrl = "https://siconnect.qa-sprint2.supplierintegrity.com/api/v1/integraCheckOrder/customField"

        config.ogsBaseTestUrl = "https://worldcheck.qa-sprint2.supplierintegrity.com"
        config.ogsBasicAuth = "ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0="

        config.staticSupplierIdForQst = "6234203de9afa50001c44654"

    }
    else
    if (env == 'qa-regression') {
        // customize
        config.baseUrl = "https://siconnect.qa-regression.supplierintegrity.com"
        config.tenant = "qa-regression"

//    config.baseTestUrl    = "https://api.qa-sprint2.supplierintegrity.com"
//    config.baseTestUrl    = "https://wso2apim-gateway-nonprod.supplierintegrity.com/si-public-api/v2"
//    config.baseTestUrl    = 'https://api.qa-regression.supplierintegrity.com'
//    config.accessTokenUrl = "https://wso2apim-gateway-nonprod.supplierintegrity.com"
        config.baseTestUrl = (isSwaggerDirect ? "https://api-qa-regression.qa.centre.rdd.refinitiv.com/" : "https://gateway-nonprod.centre.rdd.refinitiv.com/si-public-api/v2")
        config.accessTokenUrl = (isSwaggerDirect ? "" : "https://gateway-nonprod.centre.rdd.refinitiv.com")
        config.headerAuth = "WEJnQk5jdHBDUlh2MHRWZjNfakVXM2pnV3VRYTpheFlMa1VPOU50dTE2WWt0WkRqbWxaRlNXUUlh";
//      config.workflowGroupId = "60e2bd27bc1fe10001d3c088"
        config.workflowGroupId = "633138151cb56d7052ae4eca"
        config.parent = "6130306e3342c80001e5063b"
        config.region = "021"
        config.regionX = "142"
        config.requestorEmail = "rddcentre.admin.np@refinitiv.com"
        config.isSwaggerDirect = isSwaggerDirect

//    Static contact test data
        config.staticContactId = "6059c184e4b07492d729f729"
        config.staticContactSearchId = "5jb7gz67ndsg1fifaplzqlb7b"
        config.contactOtherNameSearchId = "5jb7fdybdsik1fjbgrrkatjjw"
        config.contactResultId = "5jb7qalgsrq81fifapo1d4pct"

//    Static supplier test data
        config.staticSupplierId = "6059c0bdc68058000130b7ff"
        config.staticSupplierSearchId = "5jb6fhl2luom1fifaex8q5oai"
        config.supplierOtherNameSearchId = "5jb8chozexlb1fjbgnfoutu7e"
        config.supplierResultId = "5jb72u48laaj1fifaezabtsdi"

//    Contact test data for update
        config.patchContactId = "6059c1eee4b07492d729f72b"

//    Supplier test data for update
        config.patchSupplierId = "6059c1ccc68058000130b800"

        config.resultIdWithComment = "5jb8ewicden71fjb9dejhoz1i"
        config.profileId = "e_tr_wco_548035"

//    Public-Users test data
        config.publicUsersRoleId = "5e6b5ba1504fdbb2e58ad503"
        config.publicUsersGroupId = "5e88b5e135353d0001ef8492"
        config.publicUsersSuperiorId = "565ffafdb76024381dbfd681"
        config.publicUsersEntityId = "60c7a2bfe4b0fb425bd3465d"
        config.publicUsersDepartmentId = "5e8454eae4b09a4af641942a"
        config.publicUsersExternalOrganizationId = "5e86f84ee4b0d51c6de905b0"
        config.publicUsersBillingEntityId = "5fb1df8f13f1240001c337eb"

        config.billToEntityUrl = "https://siconnect.qa-regression.supplierintegrity.com/api/v1/integraCheckOrder/customField"

        config.ogsBaseTestUrl = ""

        config.staticSupplierIdForQst = ""
    }
    else
    if (env == 'internal-qa-regression') {
        // customize
        config.baseUrl = "https://siconnect.qa-regression.supplierintegrity.com"
        config.tenant = "qa-regression"

//    config.baseTestUrl    = "https://api.qa-sprint2.supplierintegrity.com"
//    config.baseTestUrl    = "https://wso2apim-gateway-nonprod.supplierintegrity.com/si-public-api/v2"
//    config.baseTestUrl    = 'https://api.qa-regression.supplierintegrity.com'
//    config.accessTokenUrl = "https://wso2apim-gateway-nonprod.supplierintegrity.com"
//        config.baseTestUrl = (isSwaggerDirect ? "https://api-qa-sprint2.dev.centre.rdd.refinitiv.com" : "https://gateway-nonprod.centre.rdd.refinitiv.com/si-public-api/v2")
//        config.baseTestUrl = (isSwaggerDirect ? "https://api-qa-regression.dev.centre.rdd.refinitiv.com" : "https://gateway-nonprod.centre.rdd.refinitiv.com/si-public-api/v2")
        config.baseTestUrl = (isSwaggerDirect ? "https://api-internal-qa-regression.qa.centre.rdd.refinitiv.com" : "https://gateway-nonprod.centre.rdd.refinitiv.com/si-public-api/v2")
        config.accessTokenUrl = (isSwaggerDirect ? "" : "https://gateway-nonprod.centre.rdd.refinitiv.com")
        config.headerAuth = "WEJnQk5jdHBDUlh2MHRWZjNfakVXM2pnV3VRYTpheFlMa1VPOU50dTE2WWt0WkRqbWxaRlNXUUlh";
//        config.workflowGroupId = "60e2bd27bc1fe10001d3c088"
//        config.workflowGroupId = "5f0e688c3d8b5596caec9e15"
        config.workflowGroupId = "633138151cb56d7052ae4eca"
        config.parent = "6130306e3342c80001e5063b"
        config.region = "021"
        config.regionX = "142"
        config.requestorEmail = "rddcentre.admin.np@refinitiv.com"
        config.isSwaggerDirect = isSwaggerDirect

//    Static contact test data
        config.staticContactId = "6059c184e4b07492d729f729"
        config.staticContactSearchId = "5jb7gz67ndsg1fifaplzqlb7b"
        config.contactOtherNameSearchId = "5jb7fdybdsik1fjbgrrkatjjw"
        config.contactResultId = "5jb7qalgsrq81fifapo1d4pct"

//    Static supplier test data
        config.staticSupplierId = "6059c0bdc68058000130b7ff"
        config.staticSupplierSearchId = "5jb6fhl2luom1fifaex8q5oai"
        config.supplierOtherNameSearchId = "5jb8chozexlb1fjbgnfoutu7e"
        config.supplierResultId = "5jb72u48laaj1fifaezabtsdi"

//    Contact test data for update
        config.patchContactId = "6059c1eee4b07492d729f72b"

//    Supplier test data for update
        config.patchSupplierId = "6059c1ccc68058000130b800"

        config.resultIdWithComment = "5jb8ewicden71fjb9dejhoz1i"
        config.profileId = "e_tr_wco_548035"

////    Public-Users test data
//        config.publicUsersRoleId = "5e6b5ba1504fdbb2e58ad503"
//        config.publicUsersGroupId = "5e88b5e135353d0001ef8492"
//        config.publicUsersSuperiorId = "565ffafdb76024381dbfd681"
//        config.publicUsersEntityId = "60c7a2bfe4b0fb425bd3465d"
//        config.publicUsersDepartmentId = "5e8454eae4b09a4af641942a"
//        config.publicUsersExternalOrganizationId = "5e86f84ee4b0d51c6de905b0"
//        config.publicUsersBillingEntityId = "5fb1df8f13f1240001c337eb"

////    Public-Users test data
//        config.publicUsersRoleId = "615d256e39c6b286816ad66e"
//        config.publicUsersGroupId = "615fcc33a41daf0001ab8c3b"
//        config.publicUsersSuperiorId = "565ffafdb76024381dbfd681"
//        config.publicUsersEntityId = "5f0d7c81e4b0bf91671dfcc5"
//        config.publicUsersDepartmentId = "6114c5a6e4b003e3b2bdd208"
//        config.publicUsersExternalOrganizationId = "6114c456e4b003e3b2bdd207"
//        config.publicUsersBillingEntityId = "615d2e062b50030001f0f115"

////    Public-Users test data
//        config.publicUsersRoleId = "5e99280ae4b0846a31635fd8"
//        config.publicUsersGroupId = "5ebe26f23bbe6400019a88d7"
//        config.publicUsersSuperiorId = "565ffafdb76024381dbfd681"
//        config.publicUsersEntityId = "5f0d7c81e4b0bf91671dfcc5"
//        config.publicUsersDepartmentId = "6114c5a6e4b003e3b2bdd208"
//        config.publicUsersExternalOrganizationId = "6114c456e4b003e3b2bdd207"
//        config.publicUsersBillingEntityId = "6081fff97181f70001a3d078"

//    Public-Users test data
        config.publicUsersRoleId = "63313812af231f18b6781881"
        config.publicUsersGroupId = "6344fe0d973fa50001438bd6"
        config.publicUsersSuperiorId = "565ffafdb76024381dbfd681"
        config.publicUsersEntityId = "6331926de4b0546077659c26"
        config.publicUsersDepartmentId = "633aaf1de4b0a17f3fae1d74"
        config.publicUsersExternalOrganizationId = "6331926ce4b02de014c2d65b"
        config.publicUsersBillingEntityId = "6331381e17efc600015e7f19"


        config.billToEntityUrl = "https://qa-regression.centre.rdd.refinitiv.com/siconnect/integraCheckOrder/customField"

        config.ogsBaseTestUrl = ""

        config.staticSupplierIdForQst = ""
    }
    else
    if (env == 'tenant2-qa-sprint2') {
        //  TODO provide test data
    }
    else
    if (env == 'tenant2-qa-regression') {
        //  TODO provide test data
        config.baseUrl = "https://siconnect.qa-regression.supplierintegrity.com"
        config.tenant = "tenant2-qa-regression"

//  config.baseTestUrl    = "https://api.qa-sprint2.supplierintegrity.com"
//  config.baseTestUrl    = "https://wso2apim-gateway-nonprod.supplierintegrity.com/si-public-api/v2"
//  config.accessTokenUrl = "https://wso2apim-gateway-nonprod.supplierintegrity.com"
        config.baseTestUrl = (isSwaggerDirect ? "https://api.qa-regression.supplierintegrity.com" : "https://wso2apim-gateway-nonprod.supplierintegrity.com/si-public-api/v2")
        config.accessTokenUrl = (isSwaggerDirect ? "" : "https://wso2apim-gateway-nonprod.supplierintegrity.com")
        config.headerAuth = "TXpCQlFONEltZkNiRTU2SlZIRzJqQzRmQTJ3YTp0MXZnWEZiYlcyYlJRWmRIUXRjYVh6dU4yN0Fh";
        config.workflowGroupId = "615d25748e1a37d6401510d4"
        config.parent = "61653be5fb27b80001943aac"
        config.region = "021"
        config.regionX = "142"
//  config.requestorEmail = "austin.rayosdelsol@refinitiv.com"
        config.requestorEmail = "rddcentre.admin.np@refinitiv.com"
        config.isSwaggerDirect = isSwaggerDirect

//    Static contact test data
        config.staticContactId = "6051eb21e4b0a80041f23d21"
        config.staticContactSearchId = "5jb7npv0i4qz1fhu328l1smf9"
        config.contactOtherNameSearchId = "5jb7xd4gbseo1fhuj6zcjdrn0"
        config.contactResultId = "5jb7zm0py3j91fhu32al120m2"

//    Static supplier test data
        config.staticSupplierId = "6051e9afef3b560001e1972a"
        config.staticSupplierSearchId = "5jb6t4vrniiw1fhu2iccu3csb"
        config.supplierOtherNameSearchId = "5jb6tcrw3qfg1fi13wlvzoiq9"
        config.supplierResultId = "5jb72u48laaj1fhu2iectkoq3"

//    Contact test data for update
        config.patchContactId = "6059b61fe4b0a80055380225"

//    Supplier test data for update
        config.patchSupplierId = "6059b5328459b700019760fa"

        config.resultIdWithComment = "5jb7zm0py3j91fif2xzeliz4f"
        config.profileId = "e_tr_wci_897416"

//  Public-Users test data
        config.publicUsersRoleId = "615d256e39c6b286816ad66e"
        config.publicUsersGroupId = "615fcc33a41daf0001ab8c3b"
        config.publicUsersSuperiorId = "565ffafdb76024381dbfd681"
        config.publicUsersEntityId = "5f0d7c81e4b0bf91671dfcc5"
        config.publicUsersDepartmentId = "6114c5a6e4b003e3b2bdd208"
        config.publicUsersExternalOrganizationId = "6114c456e4b003e3b2bdd207"
        config.publicUsersBillingEntityId = "615d2e062b50030001f0f115"

        config.billToEntityUrl = "https://siconnect.qa-regression.supplierintegrity.com/api/v1/integraCheckOrder/customField"

        config.ogsBaseTestUrl = "https://worldcheck.qa-sprint2.supplierintegrity.com"
        config.ogsBasicAuth = "ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0="

        config.staticSupplierIdForQst = ""
    }
    else
    if (env == 'skoda-ms-staging') {

        //customize
        config.baseUrl = "https://siconnect.qa-regression.supplierintegrity.com"
        config.tenant = "skoda-ms-staging"

        //config.baseTestUrl    = "https://api.qa-sprint2.supplierintegrity.com"
        config.baseTestUrl = "https://gateway.supplierintegrity.com/si-public-api/v2"
        config.accessTokenUrl = "https://gateway.supplierintegrity.com"
        config.headerAuth = "YUd0cWRmODhZSTc4S2tEcDE4cWpwQmYySkNVYTpFa3RaUGh6QnlyakZOZmc5all1cm4zZlBFTUVh";
        config.workflowGroupId = "6012823b7477f41e5bcda417"
        config.parent = "61357a4cdcba29000172e5dd"
        config.region = "US"
        config.regionX = "LATAM"

    }
    else
    if (env == 'edwards-staging') {

        //customize
        config.baseUrl = "https://siconnect.qa-regression.supplierintegrity.com"
        config.tenant = "skoda-ms-staging"

        //config.baseTestUrl    = "https://api.qa-sprint2.supplierintegrity.com"
        config.baseTestUrl = "https://gateway.supplierintegrity.com/si-public-api/v2"
        config.accessTokenUrl = "https://gateway.supplierintegrity.com"
        config.headerAuth = "THVIdmVYMlowTWtjYnZiZkhvSlM2aF82NDQ0YTpUa210OEt0ODgxZnRhRTRfNU1kZ3JuOVNCbEVh";
        config.workflowGroupId = "6012823b7477f41e5bcda417"
        config.parent = "61357a4cdcba29000172e5dd"
        config.region = "US"
        config.regionX = "LATAM"

    }
    else
    if (env == 'nightly') {

        // config.ogsBaseTestUrl = "https://nightly.iwpro.api.integrawatch.com"
        // config.ogsBasicAuth = "ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0="

// TODO add dynamic generation
    config.baseUrl="https://api-nightly.poc.dev.centre.rdd.refinitiv.com"
    config.tenant="nightly"

//  config.baseTestUrl    = "https://api.qa-sprint2.supplierintegrity.com"
//  config.baseTestUrl    = "https://wso2apim-gateway-nonprod.supplierintegrity.com/si-public-api/v2"
//  config.accessTokenUrl = "https://wso2apim-gateway-nonprod.supplierintegrity.com"
    config.baseTestUrl    = ( isSwaggerDirect? "https://api-nightly.poc.dev.centre.rdd.refinitiv.com" : "https://wso2apim-gateway-nonprod.supplierintegrity.com/si-public-api/v2" )
    config.accessTokenUrl = ( isSwaggerDirect? ""                                                     : "https://wso2apim-gateway-nonprod.supplierintegrity.com" )
    config.headerAuth     = "TXpCQlFONEltZkNiRTU2SlZIRzJqQzRmQTJ3YTp0MXZnWEZiYlcyYlJRWmRIUXRjYVh6dU4yN0Fh";
    config.workflowGroupId= "5f0e688c3d8b5596caec9e15"
    config.parent         = "611c0368bc132d000122ffc7"
    config.region         = "021"
    config.regionX        = "142"
    config.requestorEmail = "austin.rayosdelsol@refinitiv.com"
    config.isSwaggerDirect= isSwaggerDirect

//    Static contact test data
    config.staticContactId="6051eb21e4b0a80041f23d21"
    config.staticContactSearchId="5jb7npv0i4qz1fhu328l1smf9"
    config.contactOtherNameSearchId="5jb7xd4gbseo1fhuj6zcjdrn0"
    config.contactResultId="5jb7zm0py3j91fhu32al120m2"

//    Static supplier test data
    config.staticSupplierId="6051e9afef3b560001e1972a"
    config.staticSupplierSearchId="5jb6t4vrniiw1fhu2iccu3csb"
    config.supplierOtherNameSearchId="5jb6tcrw3qfg1fi13wlvzoiq9"
    config.supplierResultId="5jb72u48laaj1fhu2iectkoq3"

//    Contact test data for update
    config.patchContactId="6059b61fe4b0a80055380225"

//    Supplier test data for update
    config.patchSupplierId="6059b5328459b700019760fa"

    config.resultIdWithComment="5jb7zm0py3j91fif2xzeliz4f"
    config.profileId= "e_tr_wci_897416"

//  Public-Users test data
    config.publicUsersRoleId                 = "5e99280ae4b0846a31635fd8"
    config.publicUsersGroupId                = "5ebe26f23bbe6400019a88d7"
    config.publicUsersSuperiorId             = "565ffafdb76024381dbfd681"
    config.publicUsersEntityId               = "5f0d7c81e4b0bf91671dfcc5"
    config.publicUsersDepartmentId           = "6114c5a6e4b003e3b2bdd208"
    config.publicUsersExternalOrganizationId = "6114c456e4b003e3b2bdd207"
    config.publicUsersBillingEntityId        = "6081fff97181f70001a3d078"

    config.billToEntityUrl = "https://siconnect.qa-sprint2.supplierintegrity.com/api/v1/integraCheckOrder/customField"

    config.ogsBaseTestUrl  = "https://worldcheck.qa-sprint2.supplierintegrity.com"
    config.ogsBasicAuth    = "ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0="

    config.staticSupplierIdForQst="6234203de9afa50001c44654"

    config.wc1Url = "https://nightly.iwpro.api.integrawatch.com";

    }
    else
    if (env == 'qa2-poc') {
// TODO add dynamic generation
    config.baseUrl="https://siconnect.qa-sprint2.supplierintegrity.com"
    config.tenant="qa-sprint2"

//  config.baseTestUrl    = "https://api.qa-sprint2.supplierintegrity.com"
//  config.baseTestUrl    = "https://wso2apim-gateway-nonprod.supplierintegrity.com/si-public-api/v2"
//  config.accessTokenUrl = "https://wso2apim-gateway-nonprod.supplierintegrity.com"
//  config.baseTestUrl    = ( isSwaggerDirect? "https://api.qa-sprint2.supplierintegrity.com"     : "https://wso2apim-gateway-nonprod.supplierintegrity.com/si-public-api/v2" )
    config.baseTestUrl    = ( isSwaggerDirect? "https://api-qa2.poc.dev.centre.rdd.refinitiv.com" : "https://wso2apim-gateway-nonprod.supplierintegrity.com/si-public-api/v2" )
    config.accessTokenUrl = ( isSwaggerDirect? ""                                                 : "https://wso2apim-gateway-nonprod.supplierintegrity.com" )
    config.headerAuth     = "TXpCQlFONEltZkNiRTU2SlZIRzJqQzRmQTJ3YTp0MXZnWEZiYlcyYlJRWmRIUXRjYVh6dU4yN0Fh";
    config.workflowGroupId= "5f0e688c3d8b5596caec9e15"
    config.parent         = "611c0368bc132d000122ffc7"
    config.region         = "021"
    config.regionX        = "142"
    config.requestorEmail = "austin.rayosdelsol@refinitiv.com"
    config.isSwaggerDirect= isSwaggerDirect

//    Static contact test data
    config.staticContactId="6051eb21e4b0a80041f23d21"
    config.staticContactSearchId="5jb7npv0i4qz1fhu328l1smf9"
    config.contactOtherNameSearchId="5jb7xd4gbseo1fhuj6zcjdrn0"
    config.contactResultId="5jb7zm0py3j91fhu32al120m2"

//    Static supplier test data
    config.staticSupplierId="6051e9afef3b560001e1972a"
    config.staticSupplierSearchId="5jb6t4vrniiw1fhu2iccu3csb"
    config.supplierOtherNameSearchId="5jb6tcrw3qfg1fi13wlvzoiq9"
    config.supplierResultId="5jb72u48laaj1fhu2iectkoq3"

//    Contact test data for update
    config.patchContactId="6059b61fe4b0a80055380225"

//    Supplier test data for update
    config.patchSupplierId="6059b5328459b700019760fa"

    config.resultIdWithComment="5jb7zm0py3j91fif2xzeliz4f"
    config.profileId= "e_tr_wci_897416"

//  Public-Users test data
    config.publicUsersRoleId                 = "5e99280ae4b0846a31635fd8"
    config.publicUsersGroupId                = "5ebe26f23bbe6400019a88d7"
    config.publicUsersSuperiorId             = "565ffafdb76024381dbfd681"
    config.publicUsersEntityId               = "5f0d7c81e4b0bf91671dfcc5"
    config.publicUsersDepartmentId           = "6114c5a6e4b003e3b2bdd208"
    config.publicUsersExternalOrganizationId = "6114c456e4b003e3b2bdd207"
    config.publicUsersBillingEntityId        = "6081fff97181f70001a3d078"

    config.billToEntityUrl = "https://siconnect.qa-sprint2.supplierintegrity.com/api/v1/integraCheckOrder/customField"

    config.ogsBaseTestUrl  = "https://worldcheck.qa-sprint2.supplierintegrity.com"
    config.ogsBasicAuth    = "ZWFjMTkyMWMtN2JlMC00MTQzLWIxYjUtMmZlOTY0MWRjOTVmOldqMFZhakRzMFhMdnhRU095c1gvYmF6enNDYm1aS3dHNjVoQXZsR0t1Rm9LU0IvclcvdHNlL0Q3clNmdnZtSmlGMnJTdGJwMzZRdFFMdlcvUzc3YWxnPT0="

    config.staticSupplierIdForQst="6234203de9afa50001c44654"

    config.wc1Url = "https://wc1-qa2.poc.dev.centre.rdd.refinitiv.com";

    }



    karate.log('env =', env);
    karate.log('baseUrl =', config.baseUrl);
    karate.log('tenant =', config.tenant);
    config.version = "/api/v1"
    config.contactOtherName = "James"
    config.supplierOtherName = "PetroChina"
    config.invalidOtherName = "TestInvalidName"
    config.invalidTenant = "invalid-tenant"
    config.invalidContactId = "6051eb21e4b0a80041f23d21_invalid"
    config.invalidSupplierId = "6051e9afef3b560001e1972a_invalid"
    config.utils = karate.toMap(utils);
    config.consts = karate.toMap(consts);
    config.apiUtils = karate.toMap(apiUtils);
    config.cliUtils = karate.toMap(cliUtils);
    config.DBUtils = karate.toMap(DBUtils);
    config.globalConst = karate.toMap(global);

    //Socket timeout & ReadTimeout set to 45 sec
    karate.configure("connectTimeout", 45000);
    karate.configure('readTimeout', 45000);
    //Configure retry HTTP request as well, try 5 times with an interval of 5 sec
    karate.configure('retry', {count: 5, interval: 5000})
    return config;
}

