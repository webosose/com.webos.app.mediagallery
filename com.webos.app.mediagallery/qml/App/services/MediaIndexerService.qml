/* @@@LICENSE
*
*      Copyright (c) 2021 LG Electronics, Inc.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*
* LICENSE@@@ */

import QtQuick 2.6
import WebOSServices 1.0
import QmlAppComponents 0.1
import Eos.Controls 0.1

Item {
    id: root
    objectName: "mediaIndexerService"

    property string currentMode: appRoot.appMode // 0:image, 1: video, 2: audio
    property var listType: "imageList"
    signal listUpdated(var list, bool isModeChanged);

    property bool isOnUpdating: false
    property bool isModeChanged: false
    property var devicePluginList: []
    property var rawFileList: []

    onCurrentModeChanged: {
        appLog.debug("AppModeChanged to :: " + appMode + " :: get new list");
        isModeChanged = true
        mediaIndexerService.cancel();
        mediaIndexerService.updateDeviceList();
    }

    Timer {
        id: updatingTimer
        interval: 8000
        onTriggered: {
            appLog.debug("mediaIndexer updatingTimer ends");
            isOnUpdating = false;
        }
    }

    property var getFileListOfFolder: function(folderName) {
        return mediaListController.getFileListOfFolder(folderName);
    }

    property var getFolderThumbnail: function(folderName) {
        return mediaListController.makeFolderThumbnail(folderName);
    }

    ServiceStateNotifier {
        appId: stringSheet.appIdForLSService

        targets: [mediaIndexerService]
    }

    LunaService {
        id: mediaIndexerService
        appId: stringSheet.appIdForLSService
        serviceName: "com.webos.service.mediaindexer"

        property int updateMediaToken: -1
        property int updateDeviceToken: -1

        signal mediaListChanged(bool isModeChange, var mediaList);

        onConnected: {
            appLog.debug("MediaInexer connect");
//            updateDeviceList();

//            appLog.debug("IsDesktopMode? " + isDesktopMode);

//            if (isDesktopMode)
//                updateMediaList();
        }

        function updateMediaList() {
            var command = "get" + currentMode + "List";
            updateMediaToken = call("luna://" + serviceName, "/" + command, JSON.stringify({"subscribe":true}));
            appLog.debug("updateMediaList call " + currentMode + " updateMediaToken = " + updateMediaToken);
        }

        function updateDeviceList() {
            updateDeviceToken = call("luna://" + serviceName, "/getDeviceList", JSON.stringify({"subscribe":true}));
            appLog.debug("call device list updateDeviceToken = " + updateDeviceToken);

            if (isDesktopMode)
                updateMediaList();
        }

        property Timer reservateListUpdate: Timer {
            interval: 4000
            onTriggered: {
                appLog.debug("mediaIndexer reservateListUpdate ends");
                mediaIndexerService.updateMediaList();
            }
        }

        function checkDeviceAvailable(data) {
            var pluginList = data.pluginList;
            var available = false;
            for(var i = 0; i < pluginList.length; i ++) {
                if(pluginList[i].uri == "msc") {
                    var deviceList = pluginList[i].deviceList;
                    deviceList.forEach(function(device) {
                        if(device.available){
                            available = device.available;
                            appLog.debug("device "+ device.name + " " + available)
                        }
                    });
                }
            }

            return available;
        }

        onResponse: {
            var response = JSON.parse(payload)

            switch(token) {
            case updateDeviceToken:
                appLog.debug("mediaIndexer updateDeviceToken = " + updateMediaToken + " / mode = " + currentMode);
                if(!checkDeviceAvailable(response)) {
                    appLog.debug("Media device is not available");
                    mediaIndexerService.mediaListChanged(isModeChanged, []);
                    return;
                }

                devicePluginList = response.pluginList;
                isOnUpdating = true;
                updatingTimer.restart();
                reservateListUpdate.restart();
                break;
            case updateMediaToken:
                appLog.debug("mediaIndexer updateMediaToken = " + updateMediaToken + " / mode = " + currentMode);

                var responseMediaList;
                if(currentMode == "Video") {
                    responseMediaList = response.videoList;
                } else if (currentMode == "Audio") {
                    responseMediaList = response.audioList;
                } else {
                    responseMediaList = response.imageList;
                }

                if (responseMediaList == undefined) {
                    break;
                }
                if (responseMediaList.count == undefined) {
                    break;
                }
                appLog.debug("Get MediaList = " + responseMediaList.results.length);

                rawFileList = responseMediaList.results;

                mediaIndexerService.mediaListChanged(isModeChanged, responseMediaList.results);

                break;
            default:
                appLog.debug("Received unknown token = " + token);
            }
        }
    }

    MediaListController {
        id: mediaListController
        onFileTreeUpdated: {
            root.listUpdated(list, isModeChanged);

            if(isModeChanged) isModeChanged = false
        }
    }
}
