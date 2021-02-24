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

Item {
    id: root

    property bool smallMode: width < appStyle.relativeXBasedOnFHD(20)
    property var src : ""
    property string bgColor: "#909090"

    Rectangle {
        anchors.fill: parent
        color: bgColor
    }

    Text {
        font: src == ""
                  ? (smallMode ? appStyle.engFont.getFont(parent.width * 0.7 / appStyle.scale)
                               : appStyle.engFont.getFont(parent.width / 4 / appStyle.scale))
                  : appStyle.engFont.getFont(15)
//        font: smallMode ? appStyle.engFont.getFont(parent.width * 0.7 / appStyle.scale)
//                        : appStyle.engFont.getFont(parent.width / 4 / appStyle.scale)
//        text: smallMode ? stringSheet.common.noImageSmall : stringSheet.common.noImage
        text: src == ""
                  ? (smallMode ? stringSheet.common.noImageSmall : stringSheet.common.noImage)
                  : src
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "white"
        wrapMode: src == "" ? Text.WordWrap : Text.WrapAnywhere
    }
}
