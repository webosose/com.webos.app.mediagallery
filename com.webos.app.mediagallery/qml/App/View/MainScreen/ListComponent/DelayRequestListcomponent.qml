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
    }

    property var clickAction: function(index) {}

    property var componentLayout: "" // qml file name: ex) ThumbnailImage.qml
    property var componentParam: ({}) //{ [asynchronous param name in layout]: [key name in data list], ... }

    property var isScrolling: false

    property var gridViewWidth: 200
    property var gridViewHeight: 200

    property var delayLoadingTime: 300

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
                    if (isScrolling == false) {

                        var param = {};
                        appLog.debug( "param keys :: " + Object.keys(componentParam));
                        Object.keys(componentParam).forEach(function(keyName){
                            appLog.debug("----TEST :: " + keyName + " / " + componentParam[keyName] + " :: " + (gridViewListModel.get(index))[componentParam[keyName]]);
                            param[keyName] = (gridViewListModel.get(index))[componentParam[keyName]]
                        })
                        loader.setSource(componentLayout,param);
//                        loader.setSource("ThumbnailImage.qml",{"thumbnailUrl":thumbnail});
                }
                    else {
                        loader.setSource(componentLayout);
                    }
                }

                property bool thumbnailLoaded: false

                Connections {
                    target: root
                    onIsScrollingChanged: {
                        if(isScrolling == false && contentBase.thumbnailLoaded == false) {
                            appLog.debug("Scrolling stopped / "  + index + " call thumbnail");

                            //TODO : remove repetation
                            var param = {};
                            appLog.debug( "param keys :: " + Object.keys(componentParam));
                            Object.keys(componentParam).forEach(function(keyName){
                                appLog.debug("----TEST :: " + keyName + " / " + componentParam[keyName] + " :: " + (gridViewListModel.get(index))[componentParam[keyName]]);
                                param[keyName] = (gridViewListModel.get(index))[componentParam[keyName]]
                            })
                            loader.setSource(componentLayout,param);
//                            loader.setSource("ThumbnailImage.qml",{"thumbnailUrl":thumbnail});

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
                    clickAction();
                }
            }
        }
    }

    ListModel {
        id: gridViewListModel
    }

    function updateListModel(list){
        appLog.debug("DelayRequestListComponent:: updateListModel :: " + list.length);
        gridViewListModel.clear();
        for (var i = 0 ; i < list.length; i++) {
            gridViewListModel.append(list[i]);
        }
    }

    Timer {
        id: loadImageTimer
        interval: root.delayLoadingTime
        onTriggered: {
            appLog.debug("loadTimer ends");
            isScrolling = false;
        }
    }


    GridView {
        id: thumbnailGridView
        anchors.fill: parent
        model: gridViewListModel

        cellWidth: root.gridViewWidth
        cellHeight: root.gridViewHeight
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
                    appLog.debug("loadTimer starts : waits " + root.delayLoadingTime + "ms");
                }
            }
            prevV = verticalVelocity;

        }
    }
}
