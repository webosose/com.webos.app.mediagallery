/* @@@LICENSE
 *
 * Copyright (c) <2020> LG Electronics, Inc.
 *
 * Confidential computer software. Valid license from LG required for
 * possession, use or copying. Consistent with FAR 12.211 and 12.212,
 * Commercial Computer Software, Computer Software Documentation, and
 * Technical Data for Commercial Items are licensed to the U.S. Government
 * under vendor's standard commercial license.
 *
 * LICENSE@@@ */

import QtQuick 2.4
//import QmlAppComponents 0.1
import "../../QmlAppComponents"

QtObject {
    property LocaleServiceWrapper localeService: LocaleServiceWrapper {
        id: _localeService
        appId: appIdForLSService
    }

    //System Textd
    property string appId: "com.webos.app.sample"
    property string appIdForLSService: appId + displayId
    property string displayId: "-1"

    //Localization Texts
    property bool isRTL: localeService.isRTLLocale
    property string rtlCode: isRTL ? "\u200F" : ""
    property string es: localeService.emptyString

    property string appTitle: rtlCode + qsTr("Sample") + es
}
