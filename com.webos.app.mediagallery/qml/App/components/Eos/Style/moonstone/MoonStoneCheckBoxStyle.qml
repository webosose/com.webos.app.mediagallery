/* @@@LICENSE
 *
 * Copyright (c) 2015 LG Electronics, Inc.
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

    property color checkBoxCheckMarkBackgroundColor: "#404040"
    property color checkBoxCheckMarkColor: "#a6a6a6"
    property color checkBoxTextColor: "#a6a6a6"

    property color checkBoxCheckMarkBackgroundPressedColor: "#404040"
    property color checkBoxCheckMarkPressedColor: "#a6a6a6"
    property color checkBoxTextPressedColor: "#a6a6a6"

    property color checkBoxCheckMarkBackgroundFocusedColor: "#cf0652"
    property color checkBoxCheckMarkFocusedColor: "white"
    property color checkBoxTextFocusedColor: "white"

    property color checkBoxCheckMarkBackgroundDisabledColor: "#262626"
    property color checkBoxCheckMarkDisabledColor: "#4d4d4d"
    property color checkBoxTextDisabledColor: "#4d4d4d"

    property string checkBoxFont: "MuseoSans Bold"
    property real checkBoxFontSize: 36

    property real checkBoxSpacing: 20
    property real checkBoxVerticalPadding: 10
    property real checkBoxHorizontalPadding: 10

    property real checkBoxIndicatorSize: 62
}
