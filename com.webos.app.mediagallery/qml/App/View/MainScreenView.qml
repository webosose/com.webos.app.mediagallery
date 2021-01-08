/* @@@LICENSE
 *
 * Copyright (c) 2021 LG Electronics, Inc.
 *
 * Confidential computer software. Valid license from LG required for
 * possession, use or copying. Consistent with FAR 12.211 and 12.212,
 * Commercial Computer Software, Computer Software Documentation, and
 * Technical Data for Commercial Items are licensed to the U.S. Government
 * under vendor's standard commercial license.
 *
 * LICENSE@@@ */

import QtQuick 2.4
import "./MainScreen"
import QmlAppComponents 0.1

/*
-- Scene ------ Loading
I         I
I         ----- MediaList --- GridView
I                          I
I                          -- DetailView
*/

Item {
    id: root

    objectName: "mainScreenView"

    width: appStyle.relativeXBasedOnFHD(1250)
    height: appStyle.relativeYBasedOnFHD(510 + 80)
    clip: true
    
    property int modePage: 0

    states: [
        State {
            name: "Folders"
        },
        State {
            name: "Files"
        }
    ]

    state: "Folders"

    onStateChanged: {
    }

    DebugBackground {}

    MediaListScene {
        id: mediaListScene

        objectName: "mediaListScene"
        anchors.fill: parent

        anchors.right: parent.right
        anchors.left: parent.left
//        height: appStyle.relativeYBasedOnFHD(510)
//        height: parent.hight
        anchors.bottom: parent.bottom

        DebugBackground {}
    }

}
