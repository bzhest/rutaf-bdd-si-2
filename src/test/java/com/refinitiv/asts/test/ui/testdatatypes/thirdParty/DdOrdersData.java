package com.refinitiv.asts.test.ui.testdatatypes.thirdParty;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static java.util.Objects.nonNull;

@Data
@NoArgsConstructor
@Accessors(chain = true)
public class DdOrdersData {

    private Integer total;
    private List<DdOrderDashboard> objects;
    @JsonIgnore
    private List<DdOrder> orders = new ArrayList<>();

    @Data
    @Accessors(chain = true)
    public static class DdOrder {

        private String orderId;
        private String orderType;
        private String subjectName;
        private String scope;
        private String status;
        private String dueDate;
        private String riskRating;

    }

    @Data
    @Accessors(chain = true)
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class DdOrderDashboard {

        private String orderId;
        private String orderStatus;
        @JsonProperty("productName")
        private String scope;
        private String requesterName;
        private String approverName;
        private String orderDate;
        private String dueDate;

        @JsonProperty("requester")
        private void setRequester(Map<Object, Object> requester) {
            this.requesterName = (String) requester.get("name");
        }

        @JsonProperty("approver")
        private void setApprover(Map<Object, Object> approver) {
            this.approverName = (String) approver.get("name");
        }

        @JsonProperty("orderPlaceTime")
        private void setOrderPlaceTime(Map<Object, Long> orderPlaceTime) {
            this.orderDate =
                    nonNull(orderPlaceTime) ? getDateFromEpochSecond(orderPlaceTime.get("epochSecond"), REACT_FORMAT) :
                            null;
        }

        @JsonProperty("dueDate")
        private void setOrderDueDate(Map<Object, Long> dueDate) {
            this.dueDate = nonNull(dueDate) ? getDateFromEpochSecond(dueDate.get("epochSecond"), REACT_FORMAT) : null;
        }

    }

}
