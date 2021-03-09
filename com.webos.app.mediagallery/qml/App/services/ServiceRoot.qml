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
import WebOSServices 1.0
import QmlAppComponents 0.1

Item {
    id: root
    objectName: "serviceRoot"

    property WebOSService webOSService: _webOSService
    WebOSService {
        id: _webOSService
    }

    property MediaIndexerService mediaIndexer: _mediaIndexer
    MediaIndexerService {
        id: _mediaIndexer
        currentMode: appRoot.appMode
    }

    //Note: Implemented for structure purpose only. currently, not save any information in SettingsService
    property SettingsServiceWrapper mediaGalleryControllerService: _musicControllerService
    SettingsServiceWrapper {
        id: _musicControllerService
        appId: stringSheet.appIdForLSService
        category: "com.webos.app.mediagallery.controller"
        defaultValue: DefaultSettingsValue {
            property string mode: "photo" //photo,video,music
            property string lastActiveFolder: ""
            property string lastActiveFile: ""
        }

        onAppDataUpdated: {
        }
    }
}
