package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.awt.*;

import static io.netty.karate.util.internal.StringUtil.SPACE;
import static java.lang.String.format;

@Getter
@RequiredArgsConstructor
public enum Colors {

    RED("rgba(224, 37, 40, 1)", "#e02528"),
    REACT_RED("rgba(190, 39, 33, 1)", null),
    REACT_RED_PATTERN("rgba\\(1[8,9]\\d, 3\\d, 3\\d, 1\\)", null),
    REACT_RGB_RED("rgb(190, 39, 33)", null),
    RED_RISK_TIER("rgba(180, 0, 0, 1)", null),
    RED_BORDER("rgb(224, 37, 40)", null),
    RED_METER("rgba(180, 0, 0, 1)", null),
    BLUE("rgba(5, 111, 181, 1)", null),
    MEDIA_CHECK_BLUE("rgba(48, 72, 255, 1)", "#3048ff"),
    COUNTRY_CHECKLIST_BLUE("rgba(20, 41, 189, 1)", null),
    DARK_BLUE("rgba(0, 30, 255, 1)", "#001eff"),
    LIGHT_BLUE("rgba(92, 156, 196, 1)", null),
    REACT_BLUE("rgba(0, 30, 255, 1)", null),
    INFO_BLUE("rgba(33, 150, 243, 1)", "#2196f3"),
    WHITE("rgba(255, 255, 255, 1)", "#ffffff"),
    GREEN("rgba(119, 192, 68, 1)", null),
    GREEN_REPORT("rgba(117, 192, 68, 1)", null),
    GREEN_RISK_TIER("rgba(78, 168, 70, 1)", null),
    GREEN_METER("rgba(78, 168, 70, 1)", null),
    LIGHT_GREEN("rgba(0, 195, 137, 1)", null),
    GREY("rgba(243, 243, 243, 1)", null),
    GREY_REPORT("rgba(203, 203, 203, 1)", null),
    LIGHT_GREY("rgba(204, 204, 204, 1)", null),
    DARK_GREY("rgba(0, 0, 0, 0.26)", null),
    CHECK_ICON_DARK_GREY("rgba(0, 0, 0, 0.87)", null),
    BACKGROUND_GREY("rgba(242, 242, 242, 1)", null),
    BLACK("rgba(13, 13, 13, 1)", null),
    MEDIA_CHECK_BLACK("rgba(0, 0, 0, 1)", "#000000"),
    BLACK_REACT("rgba(64, 64, 64, 1)", null),
    DISABLE_GREY("rgba(187, 187, 187, 1)", null),
    WC_DISABLE_GREY("rgba(158, 158, 158, 1)", "#9e9e9e"),
    AMBER_METER("rgba(255, 92, 1, 1)", null),
    AMBER_RISK_TIER("rgba(255, 92, 1, 1)", null),
    YELLOW("rgba(250, 209, 1, 1)", null),
    YELLOW_STAR("rgba(242, 235, 56, 1)", null),
    ORANGE("rgba(255, 200, 0, 1)", null),
    NONE("rgba(0, 0, 0, 0)", null),
    RISK_ORANGE("rgba(255, 80, 0, 1)", "#ff5000"),
    RISK_GREY("rgba(182, 194, 203, 1)", "#b6c2cb"),
    RISK_UNSELECTED("rgba(64, 64, 64, 1)", "#404040"),
    DASHBOARD_GREY("rgba(247, 248, 255, 1)", null),
    DASHBOARD_DISABLED_GREY("rgba(245, 245, 245, 1)", null),
    DASHBOARD_DROP_DOWN_GREY("rgba(0, 0, 0, 0.08)", null),
    HOME_MENU_DROP_DOWN_GREY("rgba(0, 0, 0, 0.04)", null),
    CHECKBOX_DARK_GREY("rgba(0, 0, 0, 0.54)", null),
    CHECKBOX_LIGHT_GREY("rgba(0, 0, 0, 0.26)", null),
    DELETE_EDIT_BUTTON_GREY("rgba(153, 153, 153, 1)", null);

    private final String colorRgba;
    private final String colorHex;

    public static String getColorRgba(String color) {
        return valueOf(color.toUpperCase().replace(SPACE, '_')).getColorRgba();
    }

    public static String getColorRgbaFromHex(String hex) {
        String rgbaFormat = "rgba(%d, %d, %d, 1)";
        Color color = Color.decode(hex);
        return format(rgbaFormat, color.getRed(), color.getGreen(), color.getBlue(), color.getAlpha());
    }

}
