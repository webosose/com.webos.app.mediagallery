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
        appLog.debug("MediaListComponent completed");
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
                    sourceSize.width: 150
                    asynchronous: true

                    NoImage {
                        width: appStyle.relativeXBasedOnFHD(150)
                        height: appStyle.relativeYBasedOnFHD(150)
                        src: title == "" ? "No title" : title
                        visible: parent.status != Image.Ready
                    }
                }

                Text {
                    width: appStyle.relativeXBasedOnFHD(150)
                    height: appStyle.relativeXBasedOnFHD(20)

                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    text: title
                    color: "white"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font: appStyle.engFont.getFont(20)
                    wrapMode: Text.WordWrap
                    elide: Text.ElideRight
                }
            }
            IconButton {
                anchors.fill:parent
                onClicked: {
                    var folderFile = getFolderFileFromPath(file_path);
                    appLog.debug("path = \n" + file_path +
                                "\n folder = " + folderFile[0] +
                                "\n file = " + folderFile[1]);
                    service.webOSService.singleCallService.callSimpleToast("folder = " + folderFile[0] +
                                                                           " / file = " + folderFile[1]);
                }
            }
        }
    }

    ListModel {
        id: mediaListModel
    }

//    function getFolderFileFromPath(path) {
//        var splitArray = path.replace('file:///','').split('/');
//        var pathArray = [splitArray[splitArray.length - 2], splitArray[splitArray.length-1]];

//        return pathArray;
//    }

    function updateListModel(list){
        appLog.debug("updateListModel :: " + list.length);
        //TODO: based on filepath seperate list

        var temp = JSON.parse(JSON.stringify(list));

        mediaListModel.clear();
        for (var i = 0 ; i < list.length; i++) {
            if(list[i].file_path == undefined) {
                appLog.warn(i + "th data doesn't have file path : " + listProperty(list[i]))
                continue;
            }

            if(list[i].thumbnail == undefined) {
                //TODO: check file is image file
                if(appRoot.appMode == "Image")
                    list[i].thumbnail = list[i].file_path;
                else
                    list[i].thumbnail = "DefaultImage";
            }
            mediaListModel.append(list[i]);
        }

    }

    function listProperty(item)
    {
        for (var p in item) {
            appLog.debug(p + ": " + item[p] + " " + typeof(item[p]));
            for(var q in item[p]) {
                    appLog.debug(q + ": " + item[p][q] + " " + typeof(item[p][q]));
            }
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
