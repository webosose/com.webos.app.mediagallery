/* @@@LICENSE
 *
 * Copyright (c) 2014 LG Electronics, Inc.
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

    property color listItemCheckMarkBackgroundColor: "white"
    property color listItemCheckMarkColor: "#888888"
    property color listItemTextColor: "white"

    property color listItemCheckMarkBackgroundPressedColor: "#404040"
    property color listItemCheckMarkPressedColor: "#a6a6a6"
    property color listItemTextPressedColor: "#a6a6a6"

    property color listItemCheckMarkBackgroundFocusedColor: "#cf0652"
    property color listItemCheckMarkFocusedColor: "white"
    property color listItemTextFocusedColor: "#a6a6a6"

    property color listItemCheckMarkBackgroundDisabledColor: "#262626"
    property color listItemCheckMarkDisabledColor: "#363636"
    property color listItemTextDisabledColor: "#666666"

    property string listItemFont: "MuseoSans Bold"
    property real listItemFontSize: 24

    property real listItemSpacing: 20
    property real listItemVerticalPadding: 10
    property real listItemHorizontalPadding: 10

    property real listItemIndicatorSize: 25
}
