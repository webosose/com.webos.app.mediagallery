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
import "../components/QmlAppComponents"
import Eos.Controls 0.1

Item {
    id: root
    objectName: "webosService"

    property BasicLunaService singleCallService: BasicLunaService {
        appId: stringSheet.appIdForLSService

        function launchAppWithParam (appId, param) {
            call("luna://com.webos.applicationManager/",
                 "launch",
                 JSON.stringify({"id":appId, "params":param}));
        }
    }
}
