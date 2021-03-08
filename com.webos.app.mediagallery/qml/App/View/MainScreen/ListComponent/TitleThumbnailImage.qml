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
        anchors.top: thumbnailImage.top
        anchors.left: thumbnailImage.left
        width: thumbnailImage.width
        height: thumbnailImage.height
        source: thumbnailUrl
        sourceSize.width: width
        asynchronous: true
        NoImage {
            anchors.centerIn: parent.center
            width: parent.width
            height: parent.height
//                src: title == "" ? "No title" : title
            src: " "
            visible: fileImage.status != Image.Ready
            bgColor: appStyle.appColor.defaultBackground
        }
    }

    Rectangle {
        anchors.bottom: fileImage.bottom
        anchors.left: fileImage.left
        width: fileImage.width
        height: fileImage.height * 0.1
        color: "black"
        opacity: 0.8

        Text {
            anchors.fill: parent
            text: title
            horizontalAlignment: Text.AlignHCenter
            color: appStyle.appColor.mainTextColor
            font: appStyle.engFont.mainFont24
            elide: Text.ElideRight
        }
    }
}
