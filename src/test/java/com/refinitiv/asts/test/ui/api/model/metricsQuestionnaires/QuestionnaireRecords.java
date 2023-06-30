package com.refinitiv.asts.test.ui.api.model.metricsQuestionnaires;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class QuestionnaireRecords{

	private String responderName;
	private String supplierCountry;
	private Long dueDate;
	private String responsibleParty;
	private String supplierIntegrityID;
	private String assignorName;
	private String questionnaireType;
	private List<String> division;
	private Double completionTime;
	private String lastUpdatedByemail;
	private String reviewerName;
	private Object revisionRequestedby;
	private String responsiblePartyEmail;
	private String reviewerEmail;
	private String assignorEmail;
	private String responderEmail;
	private List<String> reviewerGroup;
	private Double riskScore;
	private String revisionRequestedByEmail;
	private String supplierName;
	private String lastUpdatedBy;
	private String questionnaireID;
	private String riskTier;
	private String questionnaireSource;
	private String supplierStatus;
	private List<String> reviewerDivision;
	private Long dateAssigned;
	private String questionnaireName;
	private String status;
	private Long revisionDate;
	private String score;
	private Long submissionDate;
	private Long lastUpdate;
}