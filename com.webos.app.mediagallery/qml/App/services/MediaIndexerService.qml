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

    onCurrentModeChanged: {
        appLog.debug("AppModeChanged to :: " + appMode + " :: get new list");
        isModeChanged = true
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
            updateDeviceList();

            if (isDesktopMode)
                updateMediaList();
        }

        function updateMediaList() {
            var command = "get" + currentMode + "List"
            updateMediaToken = call("luna://" + serviceName, "/" + command, JSON.stringify({"subscribe":true}));
            appLog.debug("updateMediaList call " + currentMode + " updateMediaToken = " + updateMediaToken)
        }

        function updateDeviceList() {
            updateDeviceToken = call("luna://" + serviceName, "/getDeviceList", JSON.stringify({"subscribe":true}));
            appLog.debug("call device list updateMediaToken = " + updateDeviceToken)
        }

        property Timer reservateListUpdate: Timer {
            interval: 4000
            onTriggered: {
                appLog.debug( "mediaIndexer reservateListUpdate ends");
                mediaIndexerService.updateMediaList();
            }
        }

        onResponse: {
            var response = JSON.parse(payload)

            switch(token) {
            case updateDeviceToken:
                isOnUpdating = true;
                updatingTimer.restart();
                reservateListUpdate.restart();
                break;
            case updateMediaToken:
                appLog.debug("mediaIndexer updateMediaToken = " + currentMode);

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
