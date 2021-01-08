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

    signal listUpdated();
    signal playlistUpdated(int updatedIndex);
    signal playlistRefreshed();

    property bool isOnUpdating: false

    Timer {
        id: updatingTimer
        interval: 8000
        onTriggered: {
            isOnUpdating = false;
        }
    }

    onPlayListChanged: {
        // Playlist refreshed, so UI need to redraw all
        appLog.info("Playlist refreshed.");
        playlistRefreshed();
    }

    readonly property alias audioList: mediaIndexerService.audioList

    property var playList: []
    property var defaultPlayList: []
    property var shuffledPlayList: []
    property int currentMusicIndex: -1
    property bool shuffleMode: false
    property bool loopMode: false

    Component.onCompleted: {
        playList = defaultPlayList;
    }

    function addPlayList(index) {
        // Deep copy
        console.warn(defaultPlayList);
        console.warn(defaultPlayList.length);
        if (defaultPlayList.length == 0) {
            defaultPlayList.push(JSON.parse(JSON.stringify(audioList[index])));
            shuffledPlayList.push(JSON.parse(JSON.stringify(audioList[index])));

            currentMusicIndex = 0;

        } else {
            defaultPlayList.splice(currentMusicIndex + 1, 0, JSON.parse(JSON.stringify(audioList[index])));
            shuffledPlayList.splice(currentMusicIndex + 1, 0, JSON.parse(JSON.stringify(audioList[index])));
            currentMusicIndex = currentMusicIndex + 1;
        }
        playlistUpdated(currentMusicIndex);
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
        property var audioList: []

        onConnected: {

            updateDeviceList();

            if (isDesktopMode)
                updateMediaList();
        }

        function updateMediaList() {
            updateMediaToken = call("luna://" + serviceName, "/getAudioList", JSON.stringify({}));
        }

        function updateDeviceList() {
            updateDeviceToken = call("luna://" + serviceName, "/getDeviceList", JSON.stringify({"subscribe":true}));
        }

        onAudioListChanged: {
//            var i;
//            for (i = 0 ; i < audioList.length; i++) {
//                // Input metadatas if not exists
//                if (audioList[i].title === "") {
//                    var tempTitleList = audioList[i].file_path.split("\/");
//                    if (tempTitleList.length == 0)
//                        audioList[i].title = stringSheet.audioList.noTitle;
//                    else
//                        audioList[i].title = tempTitleList[tempTitleList.length - 1];
//                    audioList[i].title = audioList[i].title.replace(".mp3", "");
//                    audioList[i].title = audioList[i].title.replace(".wav", "");
//                }
//                if (audioList[i].album === "") {
//                    audioList[i].album = stringSheet.audioList.noAlbum;
//                }
//                if (audioList[i].genre === "") {
//                    audioList[i].genre = stringSheet.audioList.noGenre;
//                }
//                if (audioList[i].artist === "") {
//                    audioList[i].artist = stringSheet.audioList.noArtist;
//                }
//                if (audioList[i].thumbnail === 0) {
//                    audioList[i].thumbnail = "";
//                }
//                appLog.info("[" + i + "]", "t:",audioList[i].title,"a:",audioList[i].artist,"g:",audioList[i].genre);
//            }

//            root.listUpdated();
        }

        property Timer reservateListUpdate: Timer {
            interval: 4000
            onTriggered: {
                mediaIndexerService.updateMediaList();
            }
        }

        onResponse: {
//            var response = JSON.parse(payload);
//            var i;

//            switch(token) {
//            case updateDeviceToken:
//                isOnUpdating = true;
//                updatingTimer.restart();
//                reservateListUpdate.restart();
//                break;
//            case updateMediaToken:
//                if (response.audioList === undefined)
//                    break;
//                if (response.audioList.count === undefined)
//                    break;

//                audioList = response.audioList.results;
//                break;
//            }
        }
    }
}
