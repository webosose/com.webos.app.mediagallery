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

import QtQuick 2.6
import "./MainScreen"
import "../components/QmlAppComponents"


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

    function setFolderListAsEmpty () {
        folderListScene.setFolderListAsEmpty();
    }

    FolderScene {
        id: folderListScene
        objectName: "folderListScene"
        height: appStyle.relativeYBasedOnFHD(appStyle.folderListHeight)
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        DebugBackground {}
    }

    Rectangle {
        id: spacingRect

        objectName: "spacingRect"

        height: appStyle.relativeYBasedOnFHD(appStyle.paddingInMainScreen)
        anchors.top: folderListScene.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        color: "transparent"
        DebugBackground {}
    }

    MediaListScene {
        id: mediaListScene

        objectName: "mediaListScene"

        height: appStyle.relativeYBasedOnFHD(appStyle.mediaListHeight)

        anchors.top: spacingRect.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.leftMargin: appStyle.relativeXBasedOnFHD(100)
        anchors.rightMargin: appStyle.relativeXBasedOnFHD(100)

        Rectangle {
            color: "white"
        }

        DebugBackground {}
    }
    Rectangle {
        id: loadingScrim
        color: appStyle.appColor.popupBackground
        visible: service.mediaIndexer.isOnUpdating
        width: parent.width
        height: parent.height * 0.12
        anchors.verticalCenter: parent.verticalCenter

        Text {
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: appStyle.appColor.mainTextColor
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
