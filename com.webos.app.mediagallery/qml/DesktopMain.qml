/* @@@LICENSE
 *
 * Copyright (c) <2019-2020> LG Electronics, Inc.
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

Rectangle {
    id: root
    property var desktopRoot: root

    property real scaler: 0.5
    readonly property url desktopImageUrl: ""

//  AVN
//    width: 2880 * scaler
//    height: 1080 * scaler

//  RSE
    width: 2880 * scaler
    height: 1620 * scaler
    color: "black"

    // application
    Loader {
        id: appLoader
        source: "./App/appMain.qml"
        scale: root.scaler
        transformOrigin: Item.BottomLeft
        //anchors.fill: parent
        anchors.bottom: parent.bottom

        onStatusChanged: {
            if (status === Loader.Ready)
                item.isDesktopMode = true;
        }
    }

    // Debug window. Will not be shipped under release build
    Loader {
        id: debugWindowLoader
        source: "./DebugWindow/DebugWindow.qml"
        x: 0
        y: parent.height * 0.05
        width: parent.width * 0.9
        height: parent.height * 0.9

//        property bool mainServiceReady: (mainService.status == Loader.Ready) && (debugWindowLoader.status == Loader.Ready)

//        onMainServiceReadyChanged: {
//            debugWindowLoader.item.service = Qt.binding( function() {return appLoader.item.service;} );
//        }
    }
}
