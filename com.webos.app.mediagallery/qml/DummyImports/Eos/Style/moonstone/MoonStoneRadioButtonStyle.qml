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

    property color radioButtonCheckMarkBackgroundColor: "white"
    property color radioButtonCheckMarkColor: "#888888"
    property color radioButtonTextColor: "#a6a6a6"

    property color radioButtonCheckMarkBackgroundPressedColor: "#404040"
    property color radioButtonCheckMarkPressedColor: "#a6a6a6"
    property color radioButtonTextPressedColor: "#a6a6a6"

    property color radioButtonCheckMarkBackgroundFocusedColor: "#cf0652"
    property color radioButtonCheckMarkFocusedColor: "white"
    property color radioButtonTextFocusedColor: "white"

    property color radioButtonCheckMarkBackgroundDisabledColor: "#262626"
    property color radioButtonCheckMarkDisabledColor: "#363636"
    property color radioButtonTextDisabledColor: "#666666"

    property string radioButtonFont: "MuseoSans Bold"
    property real radioButtonFontSize: 36

    property real radioButtonSpacing: 20
    property real radioButtonVerticalPadding: 10
    property real radioButtonHorizontalPadding: 10

    property real radioButtonIndicatorSize: 25
}
