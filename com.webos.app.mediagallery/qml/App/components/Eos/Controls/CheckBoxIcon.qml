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

    width: 100
    height: 100

    property bool checked: true
    property color backgroundColor: "gray"
    property color foregroundColor: "white"

    Rectangle {
        id: background

        anchors.fill: parent
        color: root.backgroundColor
        antialiasing: true

        rotation: 45

        radius: height/2

        Rectangle {
            id: checkMarkLongSide
            width: root.width * 7/60
            height: root.height / 2

            color: root.checked ? root.foregroundColor : "transparent"
            antialiasing: true

            radius: width/2

            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            anchors.horizontalCenterOffset: width/2
            anchors.verticalCenterOffset: -width/2
        }
        Rectangle {
            id: checkMarkShortSide
            width: checkMarkLongSide.height * 18/30
            height: root.width * 7/60

            color: root.checked ? root.foregroundColor : "transparent"
            antialiasing: true

            radius: width/2

            anchors.bottom: checkMarkLongSide.bottom
            anchors.right: checkMarkLongSide.right
        }
    }
}

