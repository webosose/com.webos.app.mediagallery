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

    property var itemInRow : 5

    onCurrentFolderChanged: {
        var list = service.mediaIndexer.getFileListOfFolder(currentFolder);
        fileListForCurrentFolder = list;
        fileList.updateListModel(fileListForCurrentFolder);
    }

    DelayRequestListcomponent {
        id: fileList
        anchors.fill: parent

        gridViewWidth: parseInt(width / itemInRow)
        gridViewHeight: parseInt(width / itemInRow)

        delayLoadingTime: 600
        componentLayout: currentMode == stringSheet.category.image
                         ? "ThumbnailImage.qml"
                         : "TitleThumbnailImage.qml"
        componentParam: currentMode == stringSheet.category.image
                        ? {"thumbnailUrl":"thumbnail","explain":"title"}
                        : {"thumbnailUrl":"thumbnail","title":"title"}
        componentSize: {"width": gridViewWidth, "height": gridViewHeight}

        clickAction: function(index, x, y) {
            appLog.debug("file index clicked : " + fileListForCurrentFolder[index].file_path);
            var filePath = fileListForCurrentFolder[index].file_path;
            switch(appMode) {
            case stringSheet.category.image:
                appLog.debug("call image viewer");
                //Note: Currently show preview. Later, it will call image viewer app
                //      in that case, preview can be used for long click action
                var imageUri = fileListForCurrentFolder[index].uri;
                var deviceUri = "";
                var pluginList = service.mediaIndexer.devicePluginList;
                var i,j;
                var searchResult = false;

                var params = {
                    "imageList": {
                        "result": []
                    },
                    "device_uri": "",
                    "images_uri": "",
                    "count":0
                };

                params.images_uri = fileListForCurrentFolder[index].uri;
                for (i = 0 ; i < pluginList.length; i++) {
                    var deviceList = pluginList[i].deviceList;
                    for (j = 0 ; j < deviceList.length ; j++) {
                        // Check app uris for find device from file uri
                        if (imageUri.includes(deviceList[j].uri)) {
                            searchResult = true;
                            params.device_uri = deviceList[j].uri;
                        }
                    }
                }

                var fileListForSelectedDevice = []
                for (i = 0 ; i < service.mediaIndexer.rawFileList.length; i++) {

                    if (service.mediaIndexer.rawFileList[i].uri.includes(params.images_uri)) {
                        fileListForSelectedDevice.unshift(service.mediaIndexer.rawFileList[i]);
                    } else if (service.mediaIndexer.rawFileList[i].uri.includes(params.device_uri)) {
                        fileListForSelectedDevice.push(service.mediaIndexer.rawFileList[i]);
                    }
                }

                params.count = fileListForSelectedDevice.length;

                if (searchResult && params.count > 0) {
                    params.imageList.results = fileListForSelectedDevice;
                    mainScreenView.showPreview(filePath, x, y, params);
                } else {
                    mainScreenView.showPreview(filePath, x, y);
                }
                break;
            case stringSheet.category.video:
                appLog.debug("call video viewer");
                var selectedFileInfo = {"file_path":filePath,"uri":fileListForCurrentFolder[index].uri};
                var videoList = {"videoList":{"results":[selectedFileInfo],"count":1}}
                service.webOSService.singleCallService.launchAppWithParam(stringSheet.viewerApps.video,videoList);
                break;
            case stringSheet.category.audio:
                appLog.debug("call audio player");
                service.webOSService.singleCallService.callSimpleToast("Music player is not supported for current device");

                break;
            }
        }
    }



}
