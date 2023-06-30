package com.refinitiv.asts.test.ui.utils.wc1;

import com.refinitiv.asts.test.ui.enums.MatchStrength;
import com.refinitiv.asts.test.ui.enums.Resolution;
import com.refinitiv.asts.test.ui.utils.wc1.model.CaseResponseDTO;
import com.refinitiv.asts.test.ui.utils.wc1.model.ResultsResponseDTO;

import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

import static com.refinitiv.asts.test.ui.utils.ScreeningCSVReportBuilder.getResolutionStatus;
import static com.refinitiv.asts.test.ui.utils.wc1.ScreeningResultExpectedDataBuilder.*;

public class ScreeningResultsComparator implements Comparator<ResultsResponseDTO> {

    private static CaseResponseDTO caseResponse;
    private final List<Comparator<ResultsResponseDTO>> listComparators;

    public ScreeningResultsComparator(CaseResponseDTO caseResponse) {
        ScreeningResultsComparator.caseResponse = caseResponse;
        this.listComparators = Arrays.asList(new UpdatesComparator(),
                                             new ResolutionComparator(),
                                             new MatchStrengthComparator(),
                                             new ReferenceIdComparator());
    }

    @Override
    public int compare(ResultsResponseDTO result1, ResultsResponseDTO result2) {
        for (Comparator<ResultsResponseDTO> comparator : listComparators) {
            int result = comparator.compare(result1, result2);
            if (result != 0) {
                return result;
            }
        }
        return 0;
    }

    private static class MatchStrengthComparator implements Comparator<ResultsResponseDTO> {

        @Override
        public int compare(ResultsResponseDTO r1, ResultsResponseDTO r2) {
            return Integer.compare(MatchStrength.valueOf(r1.getMatchStrength()).getPriority(),
                                   MatchStrength.valueOf(r2.getMatchStrength()).getPriority());
        }

    }

    private static class ResolutionComparator implements Comparator<ResultsResponseDTO> {

        @Override
        public int compare(ResultsResponseDTO r1, ResultsResponseDTO r2) {
            return Integer.compare(
                    Resolution.valueOf(getResolutionStatus(r1.getResolution(), r1.getProviderType())).getPriority(),
                    Resolution.valueOf(getResolutionStatus(r2.getResolution(), r1.getProviderType())).getPriority());
        }

    }

    private static class ReferenceIdComparator implements Comparator<ResultsResponseDTO> {

        @Override
        public int compare(ResultsResponseDTO r1, ResultsResponseDTO r2) {
            return r1.getReferenceId().compareTo(r2.getReferenceId());
        }

    }

    private static class UpdatesComparator implements Comparator<ResultsResponseDTO> {

        @Override
        public int compare(ResultsResponseDTO r1, ResultsResponseDTO r2) {
            return Integer.compare(getUpdatesPosition(r1), getUpdatesPosition(r2));
        }

        private int getUpdatesPosition(ResultsResponseDTO result) {
            if (isResultNewMatch(result, caseResponse)) {
                return 0;
            } else if (isResultUpdated(result, caseResponse)) {
                return 2;
            } else if (isResultNew(result, caseResponse)) {
                return 1;
            } else {
                return 3;
            }
        }

    }

}