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
    height: appStyle.relativeYBasedOnFHD(440 + 150)
    clip: true

    //TODO : maybe we will show and hide folder view
//    states: [
//        State {
//            name: "Folders"
//        },
//        State {
//            name: "Files"
//        }
//    ]

//    state: "Folders"

//    onStateChanged: {
//    }

    DebugBackground {}

    property var currentFolder: "";
    property var startFolder: ""

    onCurrentFolderChanged: {
        appLog.debug("MainScreenView currentFolder " + currentFolder);
    }

    Connections {
        target: folderListScene

        onNotifyFolderClicked: {
            appLog.debug("NotifyFolderClick in MainScreenView :" +folderName);
            currentFolder = folderName;
        }

    }

    FolderScene {
        id: folderListScene
        objectName: "folderListScene"
        height: appStyle.relativeYBasedOnFHD(150)
        anchors.top:parent
        anchors.bottom:mediaListScene.top
        anchors.left: parent.left
        anchors.right: parent.right
    }

    MediaListScene {
        id: mediaListScene

        objectName: "mediaListScene"

        height: appStyle.relativeYBasedOnFHD(440)

        anchors.top:folderListScene.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        DebugBackground {}
    }
    Rectangle {
        id: loadingScrim
        color: "#90101010"
        visible: service.mediaIndexer.isOnUpdating
        width: parent.width - appStyle.relativeXBasedOnFHD(70);
        height: parent.height

        Text {
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: appStyle.colors.mainTextColor
            font: appStyle.engFont.mainFont42
            text: stringSheet.mediaList.onLoading + dot

            property string dot: "."
            Timer {
                repeat: true
                running: loadingScrim.visible
                interval: 1000
                onTriggered: {
                    parent.dot = parent.dot + ".";
                    if (parent.dot.length > 3)
                        parent.dot = "."
                }
            }
        }

        MouseArea {
            id: consumer
            anchors.fill: parent
            onClicked: {}
            onPressed: {}
            onReleased: {}
        }
    }
}
