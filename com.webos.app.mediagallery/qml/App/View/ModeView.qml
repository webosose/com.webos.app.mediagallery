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
import QmlAppComponents 0.1
import "../commonComponents"

/*
    ModeView --- MenuList
*/

Item {
    id: root

    width: appStyle.relativeXBasedOnFHD(380)
    height: appStyle.relativeYBasedOnFHD(510)
    clip: true

    signal notifyModeClicked(int index)

    DebugBackground {}

    function setStartPoint(modeIndex) {
        menuList.setStartIndex(modeIndex);
    }

    MenuList {
        id: menuList
        anchors.fill: parent
        menuElements: stringSheet.modeView.mode

        onCurrentIndexChanged: {
            root.notifyModeClicked(currentIndex);
        }
    }
}
