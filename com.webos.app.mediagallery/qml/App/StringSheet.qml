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
import "components/QmlAppComponents"

AppStringSheet {
    id: root

    appTitle: rtlCode + qsTr("MediaGallery") + es
    appId: "com.webos.app.mediagallery"
    //appIdForLSService exists.
    displayId: "-1"

    property QtObject category: QtObject {
        property string image: "Image"
        property string video: "Video"
        property string audio: "Audio"
    }

    property QtObject viewerApps: QtObject {
        property string image: "com.webos.app.avn.photoViewer" //TBD
        property string video: "com.webos.app.avn.videoPlayer" //TBD
        property string audio: "com.webos.app.avn.music"
    }

    property QtObject modeView: QtObject {
        property var mode: [
            qsTr(category.image) + es,
            qsTr(category.video) + es,
            qsTr(category.audio) + es
        ]
    }

    property QtObject common: QtObject {
        property string noImage: qsTr("No Image") + es
        property string noImageSmall: qsTr("X") + es
    }

    property QtObject mediaList: QtObject {
        property string onLoading: qsTr("Loading") + es
    }
}
