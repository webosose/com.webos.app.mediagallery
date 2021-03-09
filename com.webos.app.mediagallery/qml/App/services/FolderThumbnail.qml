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
import WebOSServices 1.0
import QmlAppComponents 0.1
import Eos.Controls 0.1
import "../commonComponents"

Item {
    id: folderThumbnail
    property var imageList: []
    width: 100
    height: 100

    Image{
        id: image1
        anchors.top: folderThumbnail.top
        anchors.left: folderThumbnail.left
        width: folderThumbnail.width / 2
        height: folderThumbnail.width / 2
        source: imageList[0]
        sourceSize.width: width
        asynchronous: true

        Rectangle {
            anchors.fill: parent
            color: appStyle.appColor.defaultBackground
            visible: image1.status != Image.Ready
        }
    }
    Image{
        id: image2
        anchors.top: folderThumbnail.top
        anchors.left: image1.right
        width: folderThumbnail.width / 2
        height: folderThumbnail.width / 2
        source: imageList[1]
        sourceSize.width: width
        asynchronous: true

        Rectangle {
            anchors.fill: parent
            color: appStyle.appColor.defaultBackground
            visible: image2.status != Image.Ready
        }
    }
    Image{
        id: image3
        anchors.top: image1.bottom
        anchors.left: folderThumbnail.left
        width: folderThumbnail.width / 2
        height: folderThumbnail.width / 2
        source: imageList[2]
        sourceSize.width: width
        asynchronous: true

        Rectangle {
            anchors.fill: parent
            color: appStyle.appColor.defaultBackground
            visible: image3.status != Image.Ready
        }
    }
    Image{
        id: image4
        anchors.top: image2.bottom
        anchors.left:image3.right
        width: folderThumbnail.width / 2
        height: folderThumbnail.width / 2
        source: imageList[3]
        sourceSize.width: width
        asynchronous: true

        Rectangle {
            anchors.fill: parent
            color: appStyle.appColor.defaultBackground
            visible: image4.status != Image.Ready
        }
    }
}
