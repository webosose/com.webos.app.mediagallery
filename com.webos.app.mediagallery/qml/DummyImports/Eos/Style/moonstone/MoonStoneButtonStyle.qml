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

    property real buttonBorderWidth: 5

    property color buttonBackgroundColor: "#404040"
    property color buttonForegroundColor: "#a6a6a6"
    property color buttonBorderColor: "#404040"

    property color buttonBackgroundPressedColor: "#404040"
    property color buttonForegroundPressedColor: "#a6a6a6"
    property color buttonBorderPressedColor: "#cf0652"

    property color buttonBackgroundFocusedColor: "#cf0652"
    property color buttonForegroundFocusedColor: "white"
    property color buttonBorderFocusedColor: "#cf0652"

    property color buttonBackgroundDisabledColor: "#262626"
    property color buttonForegroundDisabledColor: "#4d4d4d"
    property color buttonBorderDisabledColor: "#262626"

    property string buttonFont: "Miso"
    property real buttonFontSize: 40

    property real buttonSpacing: 10
    property real buttonHorizontalPadding: 20
    property real buttonVerticalPadding: 20

    property Item backgroundItem: Rectangle {
        property Item controlRoot: (parent && parent.parent) ? parent.parent : null

        color: controlRoot != null ? controlRoot.color : "transparent"
        border.width: controlRoot != null ? controlRoot.border.width : 0
        border.color: controlRoot != null ? controlRoot.border.color : "transparent"

        anchors.fill: parent
        antialiasing: true

        radius: height / 2
    }
}
