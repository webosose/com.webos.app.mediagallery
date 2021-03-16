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

    property var clickAcion: function(index) {}
    property int elementWidth: 200
    property int elementHeight: 200
    property var spacing: 30

    function updateListModel(list) {
        appLog.debug("HorizentalListComponent :: start update List");
        listModel.clear();
        for(var i = 0; i < list.length; i++) {
            var listValue = list[i];
            listModel.append({itemToShow: listValue});
        }
        appLog.debug("HorizentalListComponent :: end update List");
    }

    function setStartIndex(index) {
        horizontalListView.currentIndex = index;
        appLog.debug("HorizentalListComponent :: set start index = " + index);
    }

    property bool isHighlightLast:
        horizontalListView.currentIndex === listModel.count - 1
    property bool isHighlightFirst:
        horizontalListView.currentIndex === 0

    readonly property string forward: "foward";
    readonly property string backward: "backward";

    property var moveIndexDirection: forward;

    Timer {
        id: fastfowardTimer
        interval: 100; repeat: true; triggeredOnStart: true
        onTriggered: {
            var prevIndex = horizontalListView.currentIndex;
            if(moveIndexDirection == forward) moveIndexFoward();
            else moveIndexBackward();
            if(prevIndex === horizontalListView.currentIndex) {
                running = false;
            }
        }
        onRunningChanged: {
            if(running == false) {
                clickAcion(horizontalListView.currentIndex);
            }
        }
    }

    function moveFast(direction) {
        moveIndexDirection = direction;
        fastfowardTimer.start();
    }

    function moveStop() {
        if(fastfowardTimer.running == true)
            fastfowardTimer.stop();
    }

    function moveIndex(direction) {
        if(direction === forward) {
            moveIndexFoward();
        } else {
            moveIndexBackward();
        }

        clickAcion(horizontalListView.currentIndex);
    }

    function moveIndexFoward() {
        if(horizontalListView.currentIndex < listModel.count -1) {
            horizontalListView.currentIndex += 1;
        }
    }

    function moveIndexBackward() {
        if(horizontalListView.currentIndex > 0){
            horizontalListView.currentIndex -= 1;
        }
    }

    function movePage(direction){
        var current = horizontalListView.currentIndex;
        if(direction === forward) {
            current += horizontalListView.numItemInRow;
            if(current >= listModel.count) current = listModel.count - 1;
        } else {
            current -= horizontalListView.numItemInRow;
            if(current < 0) current = 0;
        }
        horizontalListView.currentIndex = current;
        clickAcion(horizontalListView.currentIndex);
    }

    Component {
        id: listDelegate

        Item {
            id: base
            width: root.elementWidth
            height: root.elementHeight

            Item {
                id: contenetBase
                anchors.fill: parent
                anchors.verticalCenter: base.verticalCenter
                Item {
                    id: previewBackground
                    anchors.fill: parent
                    opacity: 0.2
                    Component.onCompleted: {
                        service.mediaIndexer.getFolderThumbnail(previewBackground, itemToShow,
                                                                width, height);
                    }
                }
                Text {
                    id: title
                    anchors.fill: parent
                    property var fontSize: 15
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: itemToShow
                    font: appStyle.engFont.getFont(fontSize)
                    color: "white"
                    wrapMode: Text.WordWrap
                }
            }
            // indent the item if it is the current item
            states: State {
                name: "Current"
                when:  base.ListView.isCurrentItem
                PropertyChanges {
                    target: contenetBase
                    width: Object.valueOf(contenetBase.width) * 1 + appStyle.relativeYBasedOnFHD(5)
                    height: Object.valueOf(contenetBase.height) * 1 + appStyle.relativeYBasedOnFHD(5)
                }
                PropertyChanges {
                    target: previewBackground
                    opacity: 0.6
                }
                PropertyChanges {
                    target: title
                    fontSize: 17
                }
            }
            transitions: Transition {
                ParallelAnimation {
                    NumberAnimation {
                        target: contenetBase
                        properties: "width"; duration: 300 }
                    NumberAnimation {
                        target: contenetBase
                        properties: "height"; duration: 300 }
                    NumberAnimation {
                        target: previewBackground
                        properties: "opacity"; duration: 300 }
                }
            }

            MouseArea {
                anchors.fill:parent
                onClicked: {
                    appLog.debug("FolderList clicked : " + index);
                    horizontalListView.currentIndex = index;
                    clickAcion(index);
                }
            }
        }
    }

    ListModel {
        id: listModel
    }


    ListView {
        id: bgListView
        enabled: false
        //anchors.fill: horizontalListView
        width: horizontalListView.width
        height: horizontalListView.height
        x: horizontalListView.x - horizontalListView.spacing * 0.5
        y: horizontalListView.y - horizontalListView.spacing * 0.5
        model: listModel.count < 1 ? dummyModel : horizontalListView.model

        Component.onCompleted: {
            var i;
            for (i = 0 ; i < 1 ; i++) {
                dummyModel.append({"name":"dummy"});
            }
        }

        ListModel {
            id: dummyModel
        }

        orientation: horizontalListView.orientation

        delegate: bgDelegate
        focus: false

        contentY: horizontalListView.contentY
        contentX: horizontalListView.contentX

        Component {
            id: bgDelegate
            Item
            {
                id: base
                width: root.elementWidth + horizontalListView.spacing
                height: root.elementHeight + horizontalListView.spacing

                property string borderColor: "ffffff"
                property real borderLengthRatio: 0.15

                Text {
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: "No data"
                    color: appStyle.appColor.mainTextColor
                    font: appStyle.engFont.mainFont24

                    visible: name == "dummy" ? true : false
                }

                // Left top braket
                Rectangle {
                    anchors.left: parent.left; anchors.top: parent.top
                    width: base.width * base.borderLengthRatio
                    height: appStyle.relativeYBasedOnFHD(1)
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#ff" + base.borderColor }
                        GradientStop { position: 1.0; color: "#00" + base.borderColor }
                        orientation: Gradient.Horizontal
                    }
                }
                Rectangle {
                    anchors.left: parent.left; anchors.top: parent.top
                    height: base.height * base.borderLengthRatio
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
                    width: base.width * base.borderLengthRatio
                    height: appStyle.relativeYBasedOnFHD(1)
                    gradient: Gradient {
                        GradientStop { position: 1.0; color: "#ff" + base.borderColor }
                        GradientStop { position: 0.0; color: "#00" + base.borderColor }
                        orientation: Gradient.Horizontal
                    }
                }
                Rectangle {
                    anchors.right: parent.right; anchors.top: parent.top
                    height: base.height * base.borderLengthRatio
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
                    width: base.width * base.borderLengthRatio
                    height: appStyle.relativeYBasedOnFHD(1)
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#ff" + base.borderColor }
                        GradientStop { position: 1.0; color: "#00" + base.borderColor }
                        orientation: Gradient.Horizontal
                    }
                }
                Rectangle {
                    anchors.left: parent.left; anchors.bottom: parent.bottom
                    height: base.height * base.borderLengthRatio
                    width: appStyle.relativeXBasedOnFHD(1)
                    gradient: Gradient {
                        GradientStop { position: 1.0; color: "#ff" + base.borderColor }
                        GradientStop { position: 0.0; color: "#00" + base.borderColor }
                        orientation: Gradient.Vertical
                    }
                }

                // Right top braket
                Rectangle {
                    anchors.right: parent.right; anchors.bottom: parent.bottom
                    width: base.width * base.borderLengthRatio
                    height: appStyle.relativeYBasedOnFHD(1)
                    gradient: Gradient {
                        GradientStop { position: 1.0; color: "#ff" + base.borderColor }
                        GradientStop { position: 0.0; color: "#00" + base.borderColor }
                        orientation: Gradient.Horizontal
                    }
                }
                Rectangle {
                    anchors.right: parent.right; anchors.bottom: parent.bottom
                    height: base.height * base.borderLengthRatio
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

    ListView {
        id: horizontalListView
        anchors.fill: parent
        anchors.topMargin: parent.height * 0.1

        orientation: ListView.Horizontal
        spacing: appStyle.relativeXBasedOnFHD(root.spacing)

        delegate: listDelegate
        model: listModel

        highlightFollowsCurrentItem: true
        highlightMoveDuration: 300
        snapMode: ListView.SnapOneItem

        property var numItemInRow: parseInt((horizontalListView.width - elementWidth) / (elementWidth + spacing)) + 1
    }
}
