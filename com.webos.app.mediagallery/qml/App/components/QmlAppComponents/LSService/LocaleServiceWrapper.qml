import QtQuick 2.4
import WebOSServices 1.0

LocaleService {
    id: root

    l10nDirName: "/usr/share/qml/locales/" + root.appId
    l10nFileNameBase: root.appId

    property string defaultLocaleFont: ""
    property bool isRTLLocale: false

    onError: {
        appLog.debug("localeService.onError:errorText=" + errorText);
    }

    onL10nLoadSucceeded: {
        appLog.debug("localeService.onL10nLoadSucceeded");
    }

    onL10nLoadFailed: {
        appLog.debug("localeService.onL10nLoadFailed");
    }

    onL10nInstallSucceeded: {
        appLog.debug("localeService.onL10nInstallSucceeded");
    }

    onL10nInstallFailed: {
        appLog.debug("localeService.onL10nInstallFailed");
    }

    onCurrentLocaleChanged: {
        appLog.debug("localeService.onCurrentLocaleChanged: "+currentLocale);
        if(currentLocale && (currentLocale.indexOf("he-") > -1 || currentLocale.indexOf("ar-") > -1 || currentLocale.indexOf("ur-") > -1 ||
                             currentLocale.indexOf("ku-") > -1 || currentLocale.indexOf("fa-") > -1))
            isRTLLocale = true;
        else
            isRTLLocale = false;
    }
}
