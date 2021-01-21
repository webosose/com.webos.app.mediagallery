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
import Eos.Window 0.1
import Eos.Controls 0.1
import "./services"
import QmlAppComponents 0.1

AppMain {
    id: appRoot

    // global variables.
    property Style appStyle: Style {}
    property StringSheet stringSheet: StringSheet {}
    property url imageDir: "./Images/"
    // It also has appLog, imageDir
    isDesktopMode: false
    debugMode: false// || isDesktopMode
//    property var appRoot: root

    // window settings
    width: appStyle.width
    height: appStyle.height
    windowType: "_WEBOS_WINDOW_TYPE_CARD"
    visible: true
    color: "transparent"

    // application settings
    title: stringSheet.appTitle
    appId: stringSheet.appId

    property var appMode: stringSheet.modeView.mode[0]

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

//    Component.onCompleted: {
//        params = {"desc":"initial"}
//    }

//    onParamRedirectorChanged: {
//        if (paramRedirector == undefined)
//            return;
//        if (paramRedirector.desc == undefined)
//            return;
//        if (paramRedirector.desc == "initial")
//            return;

//        appLog.log("App relaunch Param came", appRoot.appId, "["+JSON.stringify(params)+"]");

//        // Do parse param and what you want to do in app

//        params = {"desc":"initial"};
//    }
}
