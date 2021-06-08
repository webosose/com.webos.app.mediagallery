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
    width: appStyle.relativeXBasedOnFHD(appStyle.gridViewSize)
    height: appStyle.relativeYBasedOnFHD(appStyle.gridViewSize)
    property string explain: ""

    Rectangle {
        anchors.fill: parent
        color: "black"
        visible: fileImage.status === Image.Ready
    }

    Image {
        id: fileImage
        anchors.fill: parent
        source: thumbnailUrl
        sourceSize.width: width
        asynchronous: true
        fillMode: Image.PreserveAspectFit
    }
    Image{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width * 0.4
        height: parent.height * 0.4
        source: "../../../Images/empty_image.png"
        sourceSize.width: width
        fillMode: Image.PreserveAspectFit
        visible: fileImage.status !== Image.Ready
    }
    Text {
        anchors.bottom: parent.bottom
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        color: appStyle.appColor.mainTextColor
        font: appStyle.engFont.mainFont24
        text: explain
        visible: fileImage.status != Image.Ready
        elide: Text.ElideRight
    }
}
