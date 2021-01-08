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
import "../../../commonComponents"

Item {
    id: root

    Component.onCompleted: {
        updateListModel();
        console.log("MediaListComponent completed");
    }

    Component {
        id: medidaListDelegate

        Item {
            id: base
//            width: appStyle.relativeYBasedOnFHD(120);
//            height: appStyle.relativeYBasedOnFHD(120);
            width: mediaListView.cellWidth
            height: mediaListView.cellHeight

            Item {
                id: contentBase
                anchors.fill: parent
                Image {
                    id: fileImage
                    x: appStyle.relativeXBasedOnFHD(30)
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: appStyle.relativeXBasedOnFHD(150)
                    height: appStyle.relativeYBasedOnFHD(150)
                    source: thumbnail

                    NoImage {
                        width: appStyle.relativeXBasedOnFHD(150)
                        height: appStyle.relativeYBasedOnFHD(150)
                        visible: parent.status != Image.Ready
                    }
                }

                Text{
                    width: appStyle.relativeXBasedOnFHD(100)
                    height: appStyle.relativeXBasedOnFHD(20)

                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    text: number
                    color: "white"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font: appStyle.engFont.getFont(32)
                }
            }
            IconButton {
                anchors.fill:parent
                onClicked: {
                    console.log("Click n = " + number)
                }
            }
        }
    }

    ListModel {
        id: mediaListModel
    }

    function updateListModel(){
        console.log("updateListModel")
        for (var i = 0; i < 1000; i++) {
            var imgUrl = imageDir + "audio_default_300.png"
            mediaListModel.append({number:i, thumbnail: imgUrl});
        }
    }

    GridView {
        id: mediaListView
        anchors.fill: parent
        model: mediaListModel

        cellWidth: appStyle.relativeYBasedOnFHD(250)
        cellHeight: appStyle.relativeYBasedOnFHD(250)
        delegate: medidaListDelegate
        focus: true

//        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
    }
}
