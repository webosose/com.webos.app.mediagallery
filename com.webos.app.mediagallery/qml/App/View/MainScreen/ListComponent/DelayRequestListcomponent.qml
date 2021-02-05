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

    property var isScrolling: false

    Component {
        id: listDelegate

        Item {
            id: base
            width: thumbnailGridView.cellWidth
            height: thumbnailGridView.cellHeight

            Component.onCompleted: {
//                appLog.debug("onCompleted :: " + index);
            }

            Component.onDestruction:  {
//                appLog.debug("onDestruction :: " + index);
            }

            Item {
                id: contentBase
                anchors.fill: parent
                Component.onCompleted: {
                    if (isScrolling == false)
                        loader.setSource("ThumbnailImage.qml",{"thumbnailUrl":thumbnail});
                    else {
                        loader.setSource("ThumbnailImage.qml");
                    }
                }

                property bool thumbnailLoaded: false

                Connections {
                    target: root
                    onIsScrollingChanged: {
                        if(isScrolling == false && contentBase.thumbnailLoaded == false) {
                            appLog.debug("Scrolling stopped / "  + index + "call thumbnail");
                            loader.setSource("ThumbnailImage.qml",{"thumbnailUrl":thumbnail});
                            contentBase.thumbnailLoaded = true
                        }
                    }
                }

                Loader {
                    id: loader
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    asynchronous: true
                }

                Rectangle {
                    id: borderLine
                    anchors.fill: parent
                    border.color: "black"
                    border.width: appStyle.relativeXBasedOnFHD(2)
                    color: "transparent"
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

                    console.log("HYEIN  item clicked :" +index);
                }
            }
        }
    }

    ListModel {
        id: mediaListModel
    }

    function getFolderFileFromPath(path) {
        var splitArray = path.replace('file:///','').split('/');
        var pathArray = [splitArray[splitArray.length - 2], splitArray[splitArray.length-1]];

        return pathArray;
    }

    function updateListModel(list){
        appLog.debug("DelayRequestListComponent:: updateListModel :: " + list.length);
        //TODO: based on filepath seperate list

//        var temp = JSON.parse(JSON.stringify(list));

        mediaListModel.clear();
        for (var i = 0 ; i < list.length; i++) {
//            if(list[i].file_path == undefined) {
//                appLog.warn(i + "th data doesn't have file path : " + Utils.listProperty(list[i]))
//                continue;
//            }

//            if(list[i].title == undefined || list[i].title == "") {
//                var folderFile = getFolderFileFromPath(list[i].file_path);
//                list[i].title = folderFile[1];
//            }

//            if(list[i].thumbnail == undefined) {
//                //TODO: check file is image file
//                if(appRoot.appMode == "Image")
//                    list[i].thumbnail = list[i].file_path;
//                else
//                    list[i].thumbnail = "DefaultImage";
//            }
            mediaListModel.append(list[i]);
        }

    }

    Timer {
        id: loadImageTimer
        interval: 600
        onTriggered: {
            appLog.debug("loadTimer ends");
            isScrolling = false;
        }
    }


    GridView {
        id: thumbnailGridView
        anchors.fill: parent
        model: mediaListModel

        cellWidth: appStyle.relativeYBasedOnFHD(appStyle.gridViewSize)
        cellHeight: appStyle.relativeYBasedOnFHD(appStyle.gridViewSize)
        delegate: listDelegate
        focus: true

        property real prevV: 0.0
        onVerticalVelocityChanged: {
            if(!isScrolling) isScrolling = true;
            prevV = Math.abs(prevV);
            var currV = Math.abs(verticalVelocity);
            if(prevV >= currV) {
                var diff = prevV - currV;
                if(diff < 20){
                    loadImageTimer.restart();
                    appLog.debug("loadTimer starts");
                }
            }
            prevV = verticalVelocity;

        }
    }
}
