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
import QmlAppComponents 0.1
import "./ListComponent/"

/*
-- Scene ----- MediaList --- GridView
I                          I
I                          -- DetailView
*/
Item {
    id: root

    objectName: "mediaListScene"
    DebugBackground {}
    clip: true

// TODO: maybe we need current file location
//    property int currentPlaylistIndex: 0

    property var currentFolder: mainScreenView.currentFolder

    onCurrentFolderChanged: {
//        if(currentFolder !== "") {
            var list = service.mediaIndexer.getFileListOfFolder(currentFolder);
            fileList.updateListModel(list);
//        }
    }

    DelayRequestListcomponent {
        id: fileList
        width: root.width; height: root.height
    }

//    Rectangle {
//        id: loadingScrim
//        color: "#90101010"
//        visible: service.mediaIndexer.isOnUpdating
//        width: parent.width - appStyle.relativeXBasedOnFHD(70);
//        height: parent.height

//        Text {
//            anchors.fill: parent
//            verticalAlignment: Text.AlignVCenter
//            horizontalAlignment: Text.AlignHCenter
//            color: appStyle.colors.mainTextColor
//            font: appStyle.engFont.mainFont42
//            text: stringSheet.mediaList.onLoading + dot

//            property string dot: "."
//            Timer {
//                repeat: true
//                running: loadingScrim.visible
//                interval: 1000
//                onTriggered: {
//                    parent.dot = parent.dot + ".";
//                    if (parent.dot.length > 3)
//                        parent.dot = "."
//                }
//            }
//        }

//        MouseArea {
//            id: consumer
//            anchors.fill: parent
//            onClicked: {}
//            onPressed: {}
//            onReleased: {}
//        }
//    }
}
