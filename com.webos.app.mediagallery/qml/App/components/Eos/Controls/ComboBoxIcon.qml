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
            id: checkMarkRightSide
            width: root.width * 1/6
            height: root.height/2

            color: root.foregroundColor
            antialiasing: true

            radius: width/2

            anchors.horizontalCenterOffset: width

            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: checkMarkLeftSide
            width: root.height/2
            height: root.width * 1/6

            color: root.foregroundColor
            antialiasing: true

            radius: width/2

            anchors.bottom: checkMarkRightSide.bottom
            anchors.right: checkMarkRightSide.right
        }
    }
}
