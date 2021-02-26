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
import "../../../commonComponents"

Item {
    id: thumbnailImage
    property var thumbnailUrl: "thumbnailUrl"
    property var title: "No title"
    width: appStyle.relativeXBasedOnFHD(appStyle.gridViewSize)
    height: appStyle.relativeYBasedOnFHD(appStyle.gridViewSize)

    Image {
        id: fileImage
        anchors.centerIn: parent.center
        width: parent.width * 0.8
        height: parent.height * 0.8
        source: thumbnailUrl
        sourceSize.width: parent.width * 0.8
        asynchronous: true
        NoImage {
            anchors.centerIn: parent.center
            width: parent.width
            height: parent.height
            src: title == "" ? "No title" : title
            visible: fileImage.status != Image.Ready
        }
    }

    Text {
        anchors.top: fileImage.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: appStyle.relativeYBasedOnFHD(5)
        anchors.left: parent.left
        width: fileImage.width
        text: title
        color: appStyle.appColor.mainTextColor
        font: appStyle.engFont.mainFont24
        elide: Text.ElideRight
    }
}
