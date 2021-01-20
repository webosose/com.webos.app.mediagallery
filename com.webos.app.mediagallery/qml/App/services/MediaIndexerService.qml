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

    //TODO: connect currentMode with ModeView
    property int currentMode: 0 // 0:photo, 1: video, 2: music
    property var listType: "imageList"
    signal listUpdated(var list);
//    signal playlistUpdated(int updatedIndex);
//    signal playlistRefreshed();

    property bool isOnUpdating: false

    Timer {
        id: updatingTimer
        interval: 8000
        onTriggered: {
            appLog.debug("mediaIndexer updatingTimer ends");
            isOnUpdating = false;
        }
    }

    readonly property alias mediaList: mediaIndexerService.mediaList

//    Component.onCompleted: {
//        playList = defaultPlayList;
//    }

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
        property var mediaList: []

        onConnected: {
            appLog.debug("MediaInexer connect");
            updateDeviceList();

            if (isDesktopMode)
                updateMediaList();
        }

        function updateMediaList() {
            switch(currentMode) {
            case 0:
                listType = "imageList";
                break;
            case 1:
                listType = "videoList";
                break;
            case 2:
                listType = "audioList";
                break;
            }

            var command = "get" + listType.charAt(0).toUpperCase() + listType.slice(1);
            updateMediaToken = call("luna://" + serviceName, "/" + command, JSON.stringify({}));
            appLog.debug("updateMediaList call " + currentMode + " updateMediaToken = " + updateMediaToken)
        }

        function updateDeviceList() {
            updateDeviceToken = call("luna://" + serviceName, "/getDeviceList", JSON.stringify({"subscribe":true}));
            appLog.debug("call device list updateMediaToken = " + updateDeviceToken)
        }

        onMediaListChanged: {
            appLog.info("mediaIndexer medialistChanged");
            root.listUpdated(mediaList);

        }

        property Timer reservateListUpdate: Timer {
            interval: 4000
            onTriggered: {
                appLog.debug("mediaIndexer reservateListUpdate ends");
                mediaIndexerService.updateMediaList();
            }
        }

        function listProperty(item)
        {
            for (var p in item)
                appLog.debug(p + ": " + item[p]);
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
                appLog.debug("mediaIndexer mediaList response :: " + JSON.stringify(payload));
                listProperty(response);
                var responseMediaList = response.imageList;
                if(currentMode == 1) {
                    responseMediaList = response.videoList;
                }
                else if(currentMode == 2) {
                    responseMediaList = response.audioList;
                }
                if (responseMediaList == undefined) {
                    break;
                }
                if (responseMediaList.count == undefined) {
                    break;
                }
                mediaList = responseMediaList.results;
                appLog.debug("Get MediaList = " + mediaList);
                break;
            default:
                appLog.debug("Received unknown token = " + token);
            }
        }
    }
}
