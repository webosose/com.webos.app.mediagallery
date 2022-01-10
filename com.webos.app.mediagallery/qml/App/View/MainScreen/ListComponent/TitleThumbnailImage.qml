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
        Image{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width * 0.4
            height: parent.height * 0.4
            source: "../../../Images/empty_image.png"
            sourceSize.width: width
            fillMode: Image.PreserveAspectFit
            visible: fileImage.status != Image.Ready

        }
    }

    Rectangle {
        anchors.bottom: fileImage.bottom
        anchors.left: fileImage.left
        width: fileImage.width
        height: fileImage.height * 0.1
        color: appStyle.appColor.normalMenuBackground
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
