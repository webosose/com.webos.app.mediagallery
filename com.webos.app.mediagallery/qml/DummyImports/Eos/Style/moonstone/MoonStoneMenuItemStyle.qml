/* @@@LICENSE
 *
 * Copyright (c) <2013-2014> LG Electronics, Inc.
 *
 * Confidential computer software. Valid license from LG required for
 * possession, use or copying. Consistent with FAR 12.211 and 12.212,
 * Commercial Computer Software, Computer Software Documentation, and
 * Technical Data for Commercial Items are licensed to the U.S. Government
 * under vendor's standard commercial license.
 *
 * LICENSE@@@ */

import QtQuick 2.4

Item {
    id: root

    property color menuItemCheckMarkBackgroundColor: "white"
    property color menuItemCheckMarkColor: "#888888"
    property color menuItemTextColor: "white"

    property color menuItemCheckMarkBackgroundPressedColor: "#404040"
    property color menuItemCheckMarkPressedColor: "#a6a6a6"
    property color menuItemTextPressedColor: "#a6a6a6"

    property color menuItemCheckMarkBackgroundFocusedColor: "#cf0652"
    property color menuItemCheckMarkFocusedColor: "white"
    property color menuItemTextFocusedColor: "#a6a6a6"

    property color menuItemCheckMarkBackgroundDisabledColor: "#262626"
    property color menuItemCheckMarkDisabledColor: "#363636"
    property color menuItemTextDisabledColor: "#666666"

    property string menuItemFont: "MuseoSans Bold"
    property real menuItemFontSize: 24

    property real menuItemSpacing: 20
    property real menuItemVerticalPadding: 10
    property real menuItemHorizontalPadding: 10

    property real menuItemIndicatorSize: 25
}
