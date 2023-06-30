package com.refinitiv.asts.test.ui.constants;

import com.refinitiv.asts.test.ui.enums.Languages;

public class TestConstants {

    public static final String AUTO_TEST_NAME_PREFIX = "AUTO_TEST_";
    public static final String AUTO_REMAINED_NAME_PREFIX = "AUTOTEST_";
    public static final String THIRD_PARTY_NAME_SIMILAR = "thirdPartyNameSimilar";
    public static final String DEFAULT_LANGUAGE = Languages.EN.getCode();
    public static final String HTTP = "http";
    public static final String HTTPS = "https";
    public static final String VALUE_TO_REPLACE = "toBeReplaced";
    public static final String VALUE_TO_UPDATE = "toBeUpdated";
    public static final String COUNTRY_CHECKLIST_ID = "countryChecklistId";
    public static final String CUSTOM_FIELD_ID = "customFieldId";
    public static final String CUSTOM_FIELD_NAME = "Custom Field name";
    public static final String APPLICABLE = "applicable";
    public static final String NOT_APPLICABLE = "not applicable";
    public static final String NOT_EXISTING = "notExisting";
    public static final String KEY_NOT_EXIST = "The key %s does not exists!";
    public static final String NOT_EXIST = "not exists";
    public static final String EXISTING = "existing";
    public static final String SHOULD = "should";
    public static final String BLANK = "blank";
    public static final String DROPDOWN_PLACEHOLDER = "Refine your keywords to show relevant results";
    public static final String REQUIRED_INDICATOR = "*";
    public static final String OPENED_PARENTHESIS = "(";
    public static final String CLOSED_PARENTHESIS = ")";
    public static final String UNDERSCORE = "_";
    public static final String LESS = "<";
    public static final String MORE = ">";
    public static final String HASH = "#";
    public static final String OPENED_SQUARE_BRACKET = "[";
    public static final String CLOSED_SQUARE_BRACKET = "]";
    public static final String DOLLAR_SIGN = "$";
    public static final String NBSP_CODE = "\\u00a0";
    public static final String SCROLL_LEFT_SCRIPT = "arguments[0].scrollLeft += 250";
    public static final String SCROLL_CENTER_SCRIPT =
            "arguments[0].scrollIntoView(true); window.scrollBy(0, -window.innerHeight / 4);";
    public static final String SCROLL_BOTTOM_SCRIPT = "arguments[0].scrollIntoView(true);";
    public static final String SCROLL_TO_ELEMENT_BOTTOM_SCRIPT = "arguments[0].scrollTo(0, arguments[0].scrollHeight);";
    public static final String DEVICE_PIXEL_RATIO = "return window.devicePixelRatio;";
    public static final String CANVAS_INTO_STRING = "return arguments[0].toDataURL('image/png').substring(22);";
    public static final String IMAGE_INTO_STRING = "var canvas = document.createElement(\"canvas\");\n" +
            "  canvas.width = arguments[0].width;\n" +
            "  canvas.height = arguments[0].height;\n" +
            "  var ctx = canvas.getContext(\"2d\");\n" +
            "  ctx.drawImage(arguments[0], 0, 0, arguments[0].naturalWidth, arguments[0].naturalHeight);\n" +
            "  var dataURL = canvas.toDataURL('image/png').substring(22);\n" +
            "  return dataURL;";
    public static final String SCROLL_TOP_SCRIPT = "arguments[0].scrollTop = arguments[1];";
    public static final String CLICK_SCRIPT = "arguments[0].click();";
    public static final String ANGULAR_CALLBACKS_SCRIPT =
            "return angular.element(document).injector().get('$http').pendingRequests.length === 0";
    public static final String GET_CSS_VALUE_SCRIPT =
            "return window.getComputedStyle(document.querySelector('%s'),'%s').getPropertyValue('%s')";
    public static final String DOUBLE_SPACE = "  ";
    public static final String MULTI_SPACE_REGEX = "\\s+";
    public static final String CLOSED_PARENTHESIS_REGEX = ("\\)");
    public static final String SCROLL_TO_TOP_SCRIPT = "window.scrollTo(0, 0);";
    public static final String SCROLL_TO_TOP_BOTTOM = "window.scrollTo(0,document.body.scrollHeight);";
    public static final String SCROLL_ELEMENT_CENTER_SCRIPT = "arguments[0].scrollIntoView({inline:\"center\"});";
    public static final String RETURN_DOCUMENT_READY_STATE_SCRIPT = "return document.readyState";
    public static final String COMPLETE = "complete";
    public static final String WINDOW_OPEN_SCRIPT = "window.open()";
    public static final String COM = ".com";
    public static final String REFERENCE = "Reference";
    public static final String PENDING = "Pending";
    public static final String PENDING_REVIEW = "Pending Review";
    public static final int MAX_VISIBLE_LENGTH = 38;
    public static final int PAGINATION = 10;
    public static final String LAST_ELEMENT = "last()";
    public static final String CURRENCY = "Currency";

    //    Attributes
    public static final String ACTIVE = "active";
    public static final String INACTIVE = "inactive";
    public static final String ALL = "all";
    public static final String ARIA_INVALID = "aria-invalid";
    public static final String ARIA_DISABLED = "aria-disabled";
    public static final String ARIA_SELECTED = "aria-selected";
    public static final String ARIA_CURRENT = "aria-current";
    public static final String ARIA_EXPANDED = "aria-expanded";
    public static final String DISABLED = "disabled";
    public static final String ENABLED = "enabled";
    public static final String ACTIVATED = "activated";
    public static final String INACTIVATED = "inactivated";
    public static final String GREEN = "green";
    public static final String GREY = "grey";
    public static final String VALUE = "value";
    public static final String REQUIRED = "required";
    public static final String COLOR = "color";
    public static final String BACKGROUND_COLOR = "background-color";
    public static final String BORDER_COLOR = "border-color";
    public static final String OPACITY = "opacity";
    public static final String BACKGROUND_POSITION = "background-position";
    public static final String POINTER_EVENTS = "pointer-events";
    public static final String ANGULAR_CHECKBOX_CHECKED = "0px -14px";
    public static final String ANGULAR_CHECKBOX_UNCHEKED = "0px 0px";
    public static final String CLASS = "class";
    public static final String SRC = "src";
    public static final String CONTENT = "content";
    public static final String AFTER = ":after";
    public static final String COLOR_PRIMARY = "colorPrimary";
    public static final String CHECKED = "checked";
    public static final String VALIDATION_MESSAGE = "validationMessage";
    public static final String DATA_NG_IF = "data-ng-if";
    public static final String DATA_NG_CLASS = "data-ng-class";
    public static final String DATA_VALUE = "data-value";
    public static final String NG_VALID_PARSE_CLASS = "ng-valid-parse";
    public static final String SELECTED = "selected";
    public static final String UNSELECTED = "unselected";
    public static final String SELECT = "select";
    public static final String UNSELECT = "unselect";
    public static final String ERROR = "error";
    public static final String TYPE = "type";
    public static final String VM_IS_VALID_RULES = "!vm.isValidRules";
    public static final String READONLY = "readonly";
    public static final String READ_ONLY = "read-only";
    public static final String VISIBILITY = "visibility";
    public static final String VISIBLE = "visible";
    public static final String INVISIBLE = "invisible";
    public static final String HIDDEN = "hidden";
    public static final String ID = "id";
    public static final String STYLE = "style";
    public static final String LABEL_CHECK = "label-check";
    public static final String MUI_DISABLED = "Mui-disabled";
    public static final String MUI_CHECKED = "Mui-checked";
    public static final String MUI_SELECTED = "Mui-selected";
    public static final String MUI_EXPANDED = "Mui-expanded";
    public static final String MUI_BUTTON_BASE = "MuiButtonBase";
    public static final String MUI_BUTTON_CONTAINED = "MuiButton-contained";
    public static final String MUI_BUTTON_OUTLINEDPRIMARY = "MuiButton-outlinedPrimary";
    public static final String MUI_BUTTON_CONTAINEDPRIMARY = "MuiButton-containedPrimary";
    public static final String MUI_BUTTON_OUTLINEDSECONDARY = "MuiButton-outlinedSecondary";
    public static final String TITLE_ATR = "title";
    public static final String EXPAND = "expand";
    public static final String TEXT = "Text";
    public static final String INNER_TEXT = "innerText";
    public static final String HEADER_PROFILE = "Header-Profile";
    public static final String CONTAINS = "contains";
    public static final String IS = "is";
    public static final String INVALID = "invalid";
    public static final String OUTLINED_PRIMARY = "outlinedPrimary";
    public static final String NONE = "none";
    public static final String CURSOR = "cursor";
    public static final String POINTER = "pointer";
    public static final String MAX_LENGTH = "maxlength";
    public static final String WITH_OTHER_NAME = "with Other Name";
    public static final String CLICKABLE = "clickable";
    public static final String DATA_RBD_DRAG_HANDLE_DRAGGABLE_ID = "data-rbd-drag-handle-draggable-id";
    public static final String ZERO = "0";

    //    Date formats
    public static final String ID_REGEX = "e_tr_wc(o|i)_";
    public static final String NOT_UPPER_CASE_REGEX = "[^A-Z]";
    public static final String NON_EMPTY_TEXT_REGEX = "\\w+.+";
    public static final String COMMA = ",";
    public static final String COMMA_SPACE = ", ";
    public static final String DOUBLE_QUOTES = "\"";
    public static final String EQUALS_SIGN = "=";
    public static final String THREE_D = "=3D";
    public static final String ROW_DELIMITER = "\n";
    public static final String CARRIAGE_RETURN = "\r";
    public static final String COLON_ROW_DELIMITER = ":\n";
    public static final String ZERO_OR_MORE_SPACES = "\\s*";
    public static final String USER_VALUE_FORMAT = "%s (%s)";
    public static final String USER_FIRST_LAST_USERNAME = "%s %s (%s)";
    public static final String USER_FIRST_LAST_USERNAME_WITH_NEW_LINE = "%s %s\n%s";
    public static final String USER_FORMAT = "%s %s";
    public static final String USER_FORMAT_WITH_EMAIL = "%s %s %s";
    public static final String DASH = "-";
    public static final String RETURNED_RESULTS = "1 TO 10 OF ";
    public static final String VERTICAL_BAR = "|";
    public static final String UTF_VERTICAL_BAR = "%7C";
    public static final char CHAR_VERTICAL_BAR = '|';

    // Test statuses
    public static final String FAILED_DUE_TO_THE_BUG = "Failed due to the bug";
    public static final String BLOCKED_DUE_TO_THE_ISSUE = "Blocked due to the issue";
    public static final String NOT_APPLICABLE_STATUS = "Automated test run is not applicable due to";

}
