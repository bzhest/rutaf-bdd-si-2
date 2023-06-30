package com.refinitiv.asts.test.ui.api.model.user;

import com.refinitiv.asts.test.ui.api.model.organisation.allOrganisationData.OrganizationPayload;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.List;

@Data
public class UserAppApiPayload {

    private UserPayload payload;
    private String message;
    private String status;

    @Data
    @Accessors(chain = true)
    public static class UserPayload implements Serializable {

        private String _id;
        private String clientId;
        private long dateCreated;
        private String dateUpdated;
        private boolean isDeleted;
        private String supplierId;
        private Object contactInformationId;
        private String firstName;
        private String lastName;
        private String email;
        private String username;
        private boolean isAdminEmailNotifiable;
        private UserType userType;
        private Role role;
        private Object accesibilities;
        private Object group;
        private UserPayload superior;
        private Organization organization;
        private Entity entity;
        private List<String> divisionIds;
        private List<OrganizationPayload.ObjectsItem> divisions;
        private Entity department;
        private Entity externalOrganization;
        private Object avatar;
        private boolean isEmailNotifiable;
        private boolean isOutOfOffice;
        private boolean isSingleSignOnEnabled;
        private Object dateFormat;
        private BillingEntity defaultBillingEntity;
        private List<BillingEntity> otherBillingEntities;
        private LanguagePreference languagePreference;
        private String name;
        private boolean active;
        private String id;
        private Object position;

        @Data
        public static class UserType implements Serializable {

            private String name;

        }

        @Data
        public static class LanguagePreference implements Serializable {

            private String languageId;

        }

        @Data
        @NoArgsConstructor
        @AllArgsConstructor
        @Accessors(chain = true)
        public static class Role implements Serializable {

            private Long updateDate;
            private Object clientId;
            private String description;
            private Boolean active;
            private String entitlement;
            private Object tenantCode;
            private Object title;
            private List<String> categoryIds;
            private Boolean deleted;
            private Boolean defaultSchema;
            private String name;
            private Object permissionsId;
            private String _id;
            private Object categories;
            private Long createDate;

        }

        @Data
        public static class Organization implements Serializable {

            private Region country;
            private Object clientId;
            private Object city;
            private MapRefObject mapRefObject;
            private Object postalCode;
            private Object phones;
            private Object description;
            private Object addressLine;
            private Object dateUpdated;
            private Object localName;
            private Object dateCreated;
            private boolean isDeleted;
            private Object name;
            private String id;
            private Object state;
            private Object fax;
            private Region region;

        }

        @Data
        public static class MapRefObject implements Serializable {

            private String refCountry;
            private String refRegion;

        }

        @Data
        public static class Region implements Serializable {

            private String id;
            private Object object;

        }

        @Data
        public static class BillingEntity implements Serializable {

            private String clientCode;
            private String name;
            private List<Object> errors;
            private String status;

        }

        @Data
        public static class Entity implements Serializable {

            private Region country;
            private String clientId;
            private long dateCreated;
            private boolean isDeleted;
            private MapRefObject mapRefObject;
            private Organization organization;
            private String name;
            private boolean active;
            private String id;
            private Region region;
            private Object dateUpdated;

        }

    }

}