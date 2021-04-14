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
import Eos.Controls 0.1
import Eos.Style 0.1
import QmlAppComponents 0.1

Item {
    id: root

    property bool isOnModeChanging: false;
    property string currentMode: appRoot.appMode

    function setStartPoint(mode, folder, fileIndex, fileUrl){
        const found = stringSheet.modeView.mode.findIndex(element => element === mode);
        if(found !== -1) {
            appRoot.appMode = mode;
            modeView.setStartPoint(found);
//            mainScreenView.startFolder = folder;
            mainScreenView.startFolderInfo[mode] = folder;
        } else {
            appRoot.appMode = stringSheet.modeView.mode[0];
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
        mainScreenView.setFolderListAsEmpty();

        //TODO: maybe better way to set focuse mode
        const found = stringSheet.modeView.mode.findIndex(element => element === currentMode);
        if(found !== 1)
            modeView.setStartPoint(found);
    }

    objectName: "viewMain"


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
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: appStyle.relativeXBasedOnFHD(appStyle.menuWitdh)

        MouseArea {
            id: modeViewArea
            anchors.fill: parent
            propagateComposedEvents: true
            onClicked: {
                mouse.accepted = false;
            }
        }

        objectName: "modeView"
        DebugBackground {}

    }

    MainScreenView {
        id: mainScreenView
        anchors.left: modeView.right
        anchors.leftMargin: appStyle.relativeXBasedOnFHD(appStyle.viewItemSpacing)
        anchors.right: parent.right
        anchors.rightMargin: appStyle.relativeXBasedOnFHD(appStyle.viewItemSpacing)
        anchors.top: modeView.top
        anchors.bottom: parent.bottom
    }
}
