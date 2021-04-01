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

import QtQuick 2.12
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
    property var componentSize: ({})

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

            function getParamForLayout(setSizeParams, setOtherParams) {
                var param = ({});

                if(setSizeParams) {
                    if(componentSize.width == undefined) {
                        param["width"] = gridViewWidth;
                    } else {
                        param["width"] = componentSize.width;
                    }

                    if(componentSize.height == undefined) {
                        param["height"] = gridViewHeight;
                    } else {
                        param["height"] = componentSize.height;
                    }
                }

                if(setOtherParams) {
                    Object.keys(componentParam).forEach(function(keyName){
                        param[keyName] = (gridViewListModel.get(index))[componentParam[keyName]]
                    })
                }

                return param;
            }

            Item {
                id: contentBase
                anchors.fill: parent
                scale: 0.98
                Component.onCompleted: {
                    if (isScrolling == false) {
                        // ex)loader.setSource("ThumbnailImage.qml",{"thumbnailUrl":thumbnail});
                        loader.setSource(componentLayout, getParamForLayout(true, true));
                    }
                    else {
                        loader.setSource(componentLayout, getParamForLayout(true, false));
                    }
                }

                property bool thumbnailLoaded: false

                Connections {
                    target: root
                    onIsScrollingChanged: {
                        if(isScrolling == false && contentBase.thumbnailLoaded == false) {
                            appLog.debug("Scrolling stopped / "  + index + " call thumbnail");
                            loader.setSource(componentLayout, base.getParamForLayout(true, true));
                            contentBase.thumbnailLoaded = true;
                        }
                    }
                }

                Loader {
                    id: loader
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    asynchronous: true
                }
            }
            MouseArea {
                anchors.fill:parent
                onClicked: {
                    if(isScrolling) return;
                    thumbnailGridView.currentIndex = index;
                    var absXY = absolutePosition(index, mouseX, mouseY);
                    clickAction(index,absXY.X,absXY.Y);
                }

                function absolutePosition(index, x, y) {
                    var rowIndex = parseInt(index / thumbnailGridView.itemNumInRow);
                    var colIndex = parseInt(index % thumbnailGridView.itemNumInRow)

                    return {X: thumbnailGridView.cellWidth * colIndex + x,
                            Y:  thumbnailGridView.cellHeight * rowIndex + y}
                }

            }
        }
    }

    ListModel {
        id: gridViewListModel
    }

    function updateListModel(list){
        appLog.debug("DelayRequestListComponent:: updateListModel :: " + list.length);
        initGridView();

        gridViewListModel.clear();
        for (var i = 0 ; i < list.length; i++) {
            gridViewListModel.append(list[i]);
        }
    }

    function initGridView() {
        loadImageTimer.stop();
        isScrolling = false;
        thumbnailGridView.contentY = 0;
    }

    Timer {
        id: loadImageTimer
        interval: root.delayLoadingTime
        repeat: true
        onTriggered: {
            appLog.debug("loadTimer triggered");
            if(Math.abs(thumbnailGridView.verticalVelocity) < 20) {
                repeat = false;
            } else {
                repeat = true;
            }
        }

        onRunningChanged: {
            if(running) isScrolling = true
            else isScrolling = false;
        }
    }

    GridView {
        id: bgGridView
        enabled: false
        anchors.fill: thumbnailGridView
        model: gridViewListModel.count < 20 ? dummyModel : thumbnailGridView.model

        Component.onCompleted: {
            var i;
            for (i = 0 ; i < 20 ; i++) {
                dummyModel.append({"name":"dummy"});
            }
        }

        ListModel {
            id: dummyModel
        }

        cellWidth: thumbnailGridView.cellWidth
        cellHeight: thumbnailGridView.cellHeight
        delegate: bgDelegate
        focus: false

        contentY: thumbnailGridView.contentY
        contentX: thumbnailGridView.contentX

        Component {
            id: bgDelegate
            Item
            {
                id: base
                width: bgGridView.cellWidth
                height: bgGridView.cellHeight

                property string borderColor: "ffffff"
                property real borderLengthRatio: 0.15

                Text {
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: "No data"
                    color: appStyle.appColor.mainTextColor
                    font: appStyle.engFont.mainFont24
                    visible: gridViewListModel.count > 0 ? false : true
                }

                // Left top braket
                Rectangle {
                    anchors.left: parent.left; anchors.top: parent.top
                    width: bgGridView.cellWidth * base.borderLengthRatio
                    height: appStyle.relativeYBasedOnFHD(1)
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#ff" + base.borderColor }
                        GradientStop { position: 1.0; color: "#00" + base.borderColor }
                        orientation: Gradient.Horizontal
                    }
                }
                Rectangle {
                    anchors.left: parent.left; anchors.top: parent.top
                    height: bgGridView.cellHeight * base.borderLengthRatio
                    width: appStyle.relativeXBasedOnFHD(1)
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#ff" + base.borderColor }
                        GradientStop { position: 1.0; color: "#00" + base.borderColor }
                        orientation: Gradient.Vertical
                    }
                }

                // Right top braket
                Rectangle {
                    anchors.right: parent.right; anchors.top: parent.top
                    width: bgGridView.cellWidth * base.borderLengthRatio
                    height: appStyle.relativeYBasedOnFHD(1)
                    gradient: Gradient {
                        GradientStop { position: 1.0; color: "#ff" + base.borderColor }
                        GradientStop { position: 0.0; color: "#00" + base.borderColor }
                        orientation: Gradient.Horizontal
                    }
                }
                Rectangle {
                    anchors.right: parent.right; anchors.top: parent.top
                    height: bgGridView.cellHeight * base.borderLengthRatio
                    width: appStyle.relativeXBasedOnFHD(1)
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#ff" + base.borderColor }
                        GradientStop { position: 1.0; color: "#00" + base.borderColor }
                        orientation: Gradient.Vertical
                    }
                }

                // Left Bottom braket
                Rectangle {
                    anchors.left: parent.left; anchors.bottom: parent.bottom
                    width: bgGridView.cellWidth * base.borderLengthRatio
                    height: appStyle.relativeYBasedOnFHD(1)
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#ff" + base.borderColor }
                        GradientStop { position: 1.0; color: "#00" + base.borderColor }
                        orientation: Gradient.Horizontal
                    }
                }
                Rectangle {
                    anchors.left: parent.left; anchors.bottom: parent.bottom
                    height: bgGridView.cellHeight * base.borderLengthRatio
                    width: appStyle.relativeXBasedOnFHD(1)
                    gradient: Gradient {
                        GradientStop { position: 1.0; color: "#ff" + base.borderColor }
                        GradientStop { position: 0.0; color: "#00" + base.borderColor }
                        orientation: Gradient.Vertical
                    }
                }

                // Right bottom braket
                Rectangle {
                    anchors.right: parent.right; anchors.bottom: parent.bottom
                    width: bgGridView.cellWidth * base.borderLengthRatio
                    height: appStyle.relativeYBasedOnFHD(1)
                    gradient: Gradient {
                        GradientStop { position: 1.0; color: "#ff" + base.borderColor }
                        GradientStop { position: 0.0; color: "#00" + base.borderColor }
                        orientation: Gradient.Horizontal
                    }
                }
                Rectangle {
                    anchors.right: parent.right; anchors.bottom: parent.bottom
                    height: bgGridView.cellHeight * base.borderLengthRatio
                    width: appStyle.relativeXBasedOnFHD(1)
                    gradient: Gradient {
                        GradientStop { position: 1.0; color: "#ff" + base.borderColor }
                        GradientStop { position: 0.0; color: "#00" + base.borderColor }
                        orientation: Gradient.Vertical
                    }
                }
            }
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

        property int itemNumInRow: thumbnailGridView.width / thumbnailGridView.cellWidth
        property int itemNumInCol: thumbnailGridView.height / thumbnailGridView.cellHeight

        onVerticalVelocityChanged: {
            if(!isScrolling) {
                loadImageTimer.restart();
                isScrolling = true;
            }
        }
    }
}
