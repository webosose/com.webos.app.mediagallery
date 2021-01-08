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

    width: 100
    height: 100

    property bool checked: true
    property color backgroundColor: "gray"
    property color foregroundColor: "white"

    Rectangle {
        id: background

        anchors.centerIn: parent
        color: root.backgroundColor
        antialiasing: true

        width: root.width
        height: root.height

        radius: height/2

        Rectangle {
            id: checkMark
            width: background.width / 2
            height: background.height / 2

            color: root.checked ? root.foregroundColor : "transparent"
            antialiasing: true

            radius: width/2

            anchors.centerIn: parent
        }
    }
}

