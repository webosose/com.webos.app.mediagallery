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

    implicitWidth: onOff.implicitWidth
    implicitHeight: onOff.implicitHeight

    property bool checked: true
    property color backgroundColor: "gray"
    property color foregroundColor: "white"

    property string fontFamily: "Miso"
    property real fontSize: 30

    Rectangle {
        id: background

        anchors.fill: parent
        color: root.backgroundColor
        antialiasing: true

        Text {
            id: onOff
            anchors.centerIn: parent

            color: foregroundColor

            text: root.checked ? "ON" : "OFF"

            font.family: root.fontFamily
            font.pixelSize: root.fontSize
        }
    }
}

