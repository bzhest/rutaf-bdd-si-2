package com.refinitiv.asts.test.ui.utils;

import hirondelle.date4j.DateTime;
import lombok.SneakyThrows;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.format.ResolverStyle;
import java.util.Date;
import java.util.Objects;
import java.util.TimeZone;

import static java.time.Instant.ofEpochMilli;
import static java.time.Instant.ofEpochSecond;
import static java.time.ZoneId.systemDefault;
import static java.time.format.DateTimeFormatter.ofPattern;
import static org.apache.commons.lang.StringUtils.EMPTY;

public class DateUtil {

    public static final String SI_UI_DATE_FORMAT = "M/d/YYYY";
    public static final String REACT_FORMAT = "MM/dd/YYYY";
    public static final String SORTING_FORMAT = "M/d/yyyy";
    public static final String SI_UI_LOCAL_DATE_FORMAT = "M/d/uuuu";
    public static final String SI_MAIN_SCREENING_DATE_FORMAT = "d MMMM YYYY";
    public static final String SI_PROFILE_DATE_FORMAT = "dd MMM YYYY";
    public static final String SI_QUESTIONNAIRE_DATE_FORMAT = "MM-dd-YYYY";
    public static final String SI_SIMILAR_ARTICLE_DATE = "dd-MMM-YYYY";
    public static final String SI_EXPORT_FILE_FORMAT = "dd/MM/uuuu";
    public static final String EXPORT_FILE_NAME_FORMAT = "MMddYYYY";
    public static final String MY_EXPORT_DATE_FORMAT = "MM_dd_YYYY_HH_mm";
    public static final String WC1_DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss'Z'";
    public static final String API_DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    public static final String SI_CONNECT_DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSS+0000";
    public static final String PUBLIC_API_DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSS+00:00";
    public static final String ORDER_COMMENT_DATE_FORMAT = "MMMMM d, yyyy 'at' h:mm aaa";
    public static final String ACTIVITY_METRICS_FORMAT = "MM/dd/uuuu 'at' HH:mm";
    public static final String ACTIVITY_COMMENT_DATE_FORMAT = "MMMM d, yyyy 'at' h:mm a";
    public static final String ACTIVITY_COMMENT_DATE_FORMAT_PDF = "MM/dd/yyyy 'at' h:mm a";
    public static final String DATE_OF_INCORPORATION_FORMAT = "MM/dd/yyyy";
    public static final String EXPORT_DATE_FORMAT = "MM/dd/yyyy HH:mm";
    public static final String DATE_TIME_FORMAT = "dd/MM/yyyy - h:mm a";
    public static final String OOO_DATE_FORMAT = "dd/MM/yyyy";
    public static final String TODAY = "TODAY+";
    public static final String TODAY_LABEL = "TODAY";
    public static final String TODAY_MINUS = "TODAY-";
    public static final String PM = "pm";
    public static final String P_M_ = "p.m.";
    public static final String AM = "am";
    public static final String A_M_ = "a.m.";
    public static final String GMT = "GMT";
    public static final String UTC_ZERO = "+00:00";
    public static final String Z = "Z";
    public static final int MINUTE = 60;

    public static String getTodayDate(String format) {
        return new SimpleDateFormat(format).format(new Date());
    }

    public static LocalDate getLocalDateFromEpochMillis(Long timeInMillis) {
        return LocalDate.ofInstant(Instant.ofEpochMilli(timeInMillis), ZoneId.systemDefault());
    }

    @SneakyThrows
    public static Date getDateFromStringDate(String date, String format) {
        return new SimpleDateFormat(format).parse(date);
    }

    public static String getDateAfterTodayDate(String format, int daysAfterToday) {
        return getDateTimeAfterTodayDate(daysAfterToday).format(ofPattern(format));
    }

    public static LocalDate getDateTimeAfterTodayDate(int daysAfterToday) {
        return LocalDate.now().plusDays(daysAfterToday);
    }

    public static String getDateTimeBeforeToday(String format, int daysAfterToday) {
        return getDateTimeBeforeTodayDate(daysAfterToday).format(ofPattern(format));
    }

    public static LocalDate getDateTimeBeforeTodayDate(int daysBeforeToday) {
        return LocalDate.now().minusDays(daysBeforeToday);
    }

    public static String getDateTimeBeforeYear(String format, int yearsBeforeToday) {
        return LocalDateTime.now().minusYears(yearsBeforeToday).format(ofPattern(format));
    }

    public static String updateDateFormat(String oldFormat, String newFormat, String date) {
        if (Objects.nonNull(date)) {
            try {
                SimpleDateFormat currentDateFormat = new SimpleDateFormat(oldFormat);
                currentDateFormat.setTimeZone(TimeZone.getTimeZone(GMT));
                SimpleDateFormat newDateFormat = new SimpleDateFormat(newFormat);
                return newDateFormat.format(currentDateFormat.parse(date));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public static String convertDateFormat(String oldFormat, String newFormat, String date) {
        if (Objects.nonNull(date)) {
            try {
                SimpleDateFormat currentDateFormat = new SimpleDateFormat(oldFormat);
                SimpleDateFormat newDateFormat = new SimpleDateFormat(newFormat);
                return newDateFormat.format(currentDateFormat.parse(date));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public static String formatDate(String oldFormat, String newFormat, String date) {
        return LocalDate.parse(date, ofPattern(oldFormat)
                        .withResolverStyle(ResolverStyle.STRICT))
                .format(DateTimeFormatter.ofPattern(newFormat));
    }

    public static String getDateFromEpochMilli(Long epochTime, String format) {
        if (epochTime == null) {
            return EMPTY;
        } else {
            LocalDate localDate = ofEpochMilli(epochTime).atZone(systemDefault()).toLocalDate();
            return localDate.format(ofPattern(format));
        }
    }

    public static String getDateFromEpochSecond(Long epochTime, String format) {
        if (epochTime == null) {
            return EMPTY;
        } else {
            LocalDate localDate = ofEpochSecond(epochTime).atZone(systemDefault()).toLocalDate();
            return localDate.format(ofPattern(format));
        }
    }

    public static Long getCurrentDateInEpoch() {
        return LocalDate.now()
                .atStartOfDay(ZoneId.of(GMT))
                .toInstant()
                .toEpochMilli();
    }

    public static Long getDateBeforeInEpoch(int daysBefore) {
        return LocalDate.now()
                .minusDays(daysBefore)
                .atStartOfDay(ZoneId.of(GMT))
                .toInstant()
                .toEpochMilli();
    }

    public static Long getDateAfterInEpoch(int daysAfter) {
        return LocalDate.now()
                .plusDays(daysAfter)
                .atStartOfDay(ZoneId.of(GMT))
                .toInstant()
                .toEpochMilli();
    }

    public static int getDaysDifferenceWithCurrentDate(Long dateEpochTime) {
        return DateTime.now(TimeZone.getDefault())
                .numDaysFrom(DateTime.forInstant(dateEpochTime, TimeZone.getDefault()));
    }

    public static long getSecondsDifferenceWithCurrentDate(Long dateEpochTime) {
        return DateTime.now(TimeZone.getDefault())
                .numSecondsFrom(DateTime.forInstant(dateEpochTime, TimeZone.getDefault()));
    }

    @SneakyThrows
    public static boolean isDateBeforeOtherDate(String date1, String date2, String dateFormat) {
        SimpleDateFormat currentDateFormat = new SimpleDateFormat(dateFormat);
        Date firstDate = currentDateFormat.parse(date1);
        Date secondDate = currentDateFormat.parse(date2);
        return firstDate.before(secondDate);
    }

    public static Long getCurrentMillis() {
        return System.currentTimeMillis();
    }

    public static String updateDayFormatForFillInForm(String date) {
        if (date.split("/")[0].length() == 1) {
            date = "0" + date;
        }
        return date;
    }

    public static boolean isDateMatchedWithFormat(String date, String format) {
        try {
            LocalDate.parse(date, ofPattern(format).withResolverStyle(ResolverStyle.SMART));
            return true;
        } catch (DateTimeParseException e) {
            return false;
        }
    }

    public static String getCurrentCommentDateTime(String format) {
        return getTodayDate(format)
                .replace(AM.toUpperCase(), AM)
                .replace(PM.toUpperCase(), PM);
    }

    public static Long getLongFromDateString(String dateString, String datePattern) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat(datePattern);
        dateFormat.setTimeZone(TimeZone.getTimeZone(GMT));
        Date date = dateFormat.parse(dateString);
        return date.getTime();
    }

    @SneakyThrows
    public static Long getLongFromMailDateString(String dateString) {
        try {
            return getLongFromDateString(dateString, API_DATE_FORMAT);
        } catch (ParseException e) {
            return getLongFromDateString(dateString, WC1_DATE_FORMAT);
        }
    }

}
