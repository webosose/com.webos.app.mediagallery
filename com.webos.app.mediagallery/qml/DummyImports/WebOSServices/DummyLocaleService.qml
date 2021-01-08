/* @@@LICENSE
 *
 * Copyright (c) <2013-2014> LG Electronics, Inc.
 *
 * Confidential computer software. Valid license from LG required for
 * possession, use or copying. Consistent with FAR 12.211 and 12.212,
 * Commercial Computer Software, Computer Software Documentation, and
 * Technical Data for Commercial Items are licensed to the U.S. Government
 * under vendor's standard commercial license.
 *
 * LICENSE@@@ */

import QtQuick 2.4

QtObject {
    property string appId
    function subscribeForLocaleChange() {
        appLog.debug("DUMMY subscribeForLocaleChange");
    }
    signal error
    signal l10nLoadSucceeded
    signal l10nLoadFailed
    signal l10nInstallSucceeded
    signal l10nInstallFailed
    property string l10nFileNameBase
    property string l10nDirName
    property string defaultLocaleFont
    property string currentLocale
    property string emptyString
}
