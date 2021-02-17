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
    property var fileListForCurrentFolder: []

    onCurrentFolderChanged: {
//        if(currentFolder !== "") {
            var list = service.mediaIndexer.getFileListOfFolder(currentFolder);
            fileListForCurrentFolder = list;
            fileList.updateListModel(fileListForCurrentFolder);
//        }
    }

    DelayRequestListcomponent {
        id: fileList
        width: root.width
        height: root.height
        gridViewWidth: appStyle.relativeYBasedOnFHD(appStyle.gridViewSize)
        gridViewHeight: appStyle.relativeYBasedOnFHD(appStyle.gridViewSize)
        delayLoadingTime: 600
        componentLayout: "ThumbnailImage.qml"
        componentParam: {"thumbnailUrl":"thumbnail"}
    }
}
