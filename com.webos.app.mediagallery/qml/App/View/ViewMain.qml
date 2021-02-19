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
import Eos.Controls 0.1
import Eos.Style 0.1
import QmlAppComponents 0.1

Item {
    id: root

    property bool isOnModeChanging: false;
    property string currentMode: appRoot.appMode

    function setStartPoint(mode, folder, fileIndex, fileUrl){
        //TODO : check mode is valid
        const found = stringSheet.modeView.mode.findIndex(element => element == mode);
        if(found != -1) {
            appRoot.appMode = mode;
            modeView.setStartPoint(found);
            mainScreenView.startFolder = folder;
        }
    }

    Connections {
        target: modeView
        onNotifyModeClicked : {
            appLog.debug("Mode Changed to " + stringSheet.modeView.mode[index]);
            appRoot.appMode = stringSheet.modeView.mode[index];

            //TODO : Search different way to notice mode changing to set currentfolder
            isOnModeChanging = true;
        }
    }

    onCurrentModeChanged: {
        appLog.debug("Detect Mode Change. set the current folder as empty");
        mainScreenView.currentFolder = "";
    }

    property var sceneController: {
        "goNowPlaying": function() {root.state = "NowPlaying"},
        "goMusicList": function() {root.state = "MusicList"}
    }

    objectName: "viewMain"

    states: [
        State {
            // Mean "Ordinary" playing scene
            name: "NowPlaying"
        },
        State {
            // Mean list & file search, detail radio preset, etc...
            name: "MusicList"
        }
    ]

    /*
      App Scene Structure.

      App ...... View .....   Scene?

      MediaGallery --- ModeView --- MenuList
                    I            I
                    I            -- MusicListCategory
                    I
                     -- Scene ------ Loading
                    I         I
                    I         ----- MediaList --- GridView
                    I                          I
                    I                          -- DetailView
      */

    ModeView {
        id: modeView
//        x: appStyle.relativeXBasedOnFHD(180)
//        y: appStyle.relativeYBasedOnFHD(100)
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: appStyle.relativeXBasedOnFHD(appStyle.menuWitdh)
//        height: appStyle.relativeYBasedOnFHD(appStyle.menuHeight)
    }

    Rectangle {
        id: borderline

        anchors.left: modeView.right
        anchors.leftMargin: appStyle.relativeXBasedOnFHD(39)
        anchors.top: modeView.top

        height: appStyle.relativeYBasedOnFHD(appStyle.viewHeight * 0.9)
        width: appStyle.relativeXBasedOnFHD(2)
        color: appStyle.appColor.borderlineColor
        opacity: 0.25
    }


    MainScreenView {
        id: mainScreenView
//        x: appStyle.relativeXBasedOnFHD(640)
        anchors.left: borderline.right
        anchors.leftMargin: appStyle.relativeXBasedOnFHD(39)

        anchors.right: parent.right
        anchors.rightMargin: appStyle.relativeXBasedOnFHD(10)

        anchors.top: modeView.top
        anchors.bottom: parent.bottom

//        y: appStyle.relativeYBasedOnFHD(100)
    }

    state: "NowPlaying"
}
