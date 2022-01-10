/* @@@LICENSE
*
*      Copyright (c) 2021 LG Electronics, Inc.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*
* LICENSE@@@ */

import QtQuick 2.6
import Eos.Window 0.1
import Eos.Controls 0.1
import "./services"
import QmlAppComponents 0.1

AppMain {
    id: appRoot

    // global variables.
    property Style appStyle: Style {}
    property StringSheet stringSheet: StringSheet {}
    property url imageDir: Qt.resolvedUrl("./Images/")
    // It also has appLog, imageDir
    isDesktopMode: false
    debugMode: false// || isDesktopMode

    // window settings
    width: appStyle.width
    height: appStyle.height
    windowType: "_WEBOS_WINDOW_TYPE_CARD"
    visible: true
    color: "transparent"

    // application settings
    title: stringSheet.appTitle
    appId: stringSheet.appId

    property var appMode: ""

    // Service
    property ServiceRoot service: _service
    ServiceRoot {
        id: _service
    }

    // Application
    UIRoot {
        id: uiRoot
        anchors.fill: parent
    }

    onParamRedirectorChanged: {
        var defaultMode = stringSheet.modeView.mode[0];
        if (paramRedirector == undefined) {
            appLog.log("App param is empty. Start app with default mode : ", defaultMode);
            appMode = defaultMode
            return;
        }

        appLog.log("App relaunch Param came", appRoot.appId, "["+JSON.stringify(params)+"]");

        if (paramRedirector.appMode == undefined){
            appLog.log("Param doesn't have enough information. Start app without parameters." +
                       " default mode : " + defaultMode);
            appMode = defaultMode;
            return;
        }
        //initialize
        appLog.log("From Param: Set appMode as " + paramRedirector.appMode);

        uiRoot.viewMain.setStartPoint(paramRedirector.appMode,paramRedirector.folder);
    }
}
