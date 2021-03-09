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
import QmlAppComponents 0.1
import "./ListComponent/"
/*
-- Scene ----- MediaList --- GridView
I                          I
I                          -- DetailView (TODO)
*/
Item {
    id: root

    objectName: "mediaListScene"
    DebugBackground {}
    clip: true

    property var currentFolder: mainScreenView.currentFolder
    property var fileListForCurrentFolder: []

    onCurrentFolderChanged: {
        var list = service.mediaIndexer.getFileListOfFolder(currentFolder);
        fileListForCurrentFolder = list;
        fileList.updateListModel(fileListForCurrentFolder);
    }

    DelayRequestListcomponent {
        id: fileList
        anchors.fill: parent

        gridViewWidth: width / 4
        gridViewHeight: width / 4
        delayLoadingTime: 600
        componentLayout: currentMode == stringSheet.category.image
                         ? "ThumbnailImage.qml"
                         : "TitleThumbnailImage.qml"
        componentParam: currentMode == stringSheet.category.image
                        ? {"thumbnailUrl":"thumbnail"}
                        : {"thumbnailUrl":"thumbnail","title":"title"}
        componentSize: {"width": gridViewWidth, "height": gridViewHeight}

        clickAction: function(index) {
            appLog.debug("file index clicked : " + fileListForCurrentFolder[index].file_path);
            var filePath = fileListForCurrentFolder[index].file_path;
            switch(appMode) {
            case stringSheet.category.image:
                appLog.debug("call image viewer");
                service.webOSService.singleCallService.callSimpleToast("Need to call image viewer with " + filePath);
                break;
            case stringSheet.category.video:
                appLog.debug("call video viewer");
                service.webOSService.singleCallService.callSimpleToast("Need to call video player with " + filePath);
                break;
            case stringSheet.category.audio:
                appLog.debug("call audio player");
                service.webOSService.singleCallService.callSimpleToast("Need to call audio player with " + filePath);
                service.webOSService.singleCallService.launchAppWithParam(
                            stringSheet.viewerApps.audio,
                            {"appMode":stringSheet.category.audio,
                             "folder": currentFolder,
                             "fileIndex": index,
                             "fileUrl":filePath})
                break;
            }
        }
    }

}
