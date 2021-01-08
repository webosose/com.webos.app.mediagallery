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
        x: appStyle.relativeXBasedOnFHD(180)
        y: appStyle.relativeYBasedOnFHD(100)

        onPageChanged: {
            mainScreenView.modePage = index;
        }
    }

    Rectangle {
        id: borderline

        anchors.left: modeView.right
        anchors.leftMargin: appStyle.relativeXBasedOnFHD(39)
        anchors.bottom: mainScreenView.bottom

        height: appStyle.relativeYBasedOnFHD(510)
        width: appStyle.relativeXBasedOnFHD(2)
        color: appStyle.colors.borderlineColor
        opacity: 0.25
    }


    MainScreenView {
        id: mainScreenView
        x: appStyle.relativeXBasedOnFHD(640)
        y: appStyle.relativeYBasedOnFHD(100)
    }

    state: "NowPlaying"
}
