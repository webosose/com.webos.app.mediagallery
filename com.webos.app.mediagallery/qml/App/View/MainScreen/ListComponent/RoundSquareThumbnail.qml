/* @@@LICENSE
*
*      Copyright (c) 2021 LG Electronics, Inc.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
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
