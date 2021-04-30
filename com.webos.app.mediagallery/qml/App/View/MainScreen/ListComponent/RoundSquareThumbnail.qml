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
import QtGraphicalEffects 1.0

Item {
    id: root
    width: 200 // default
    height: 200 // default
    readonly property string emptyImageUrl: appRoot.imageDir + "empty_image.png"
    property string src: emptyImageUrl
    Image{
        id: main_image
        anchors.verticalCenter: root.verticalCenter
        anchors.horizontalCenter: root.horizontalCenter
        width: root.width
        height: root.height
        source: src
        sourceSize.width: width
        asynchronous: true
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Rectangle{
                anchors.centerIn: main_image.Center
                width: main_image.width
                height: main_image.height
                radius: Math.min(width,height) * 0.2
            }
        }
        property var emptyImageScale: 0.8
        Image {
            id: empty_image
            anchors.verticalCenter: main_image.verticalCenter
            anchors.horizontalCenter: main_image.horizontalCenter
            width: main_image.width * main_image.emptyImageScale
            height: main_image.height * main_image.emptyImageScale
            sourceSize.width: width
            visible: main_image.status != Image.Ready
            source: emptyImageUrl
            fillMode: Image.PreserveAspectFit

            ColorOverlay {
                anchors.fill: empty_image
                source: empty_image
                color: appStyle.appColor.emptyImageColor
            }
        }

    }
}
