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
import Eos.Style 0.1

Item{
    id: root

    property real value
    property real minimumValue: 0
    property real maximumValue: 100

    Item {
        id: grooveContainer
        anchors.fill: parent

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            height: 5
            color: "gray"
            radius: height/2
            antialiasing: true
        }
    }

    Item {
        id: barContainer
        anchors.fill: parent

        Rectangle {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width / (root.maximumValue - root.minimumValue) * root.value
            height: 5
            color: "white"
            radius: height/2
            antialiasing: true
        }
    }
}
