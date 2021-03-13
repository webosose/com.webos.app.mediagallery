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
import QmlAppComponents 0.1
import "./ListComponent/"

Item {
    id: root

    objectName: "folderListScene"
    DebugBackground {}
    clip: true

    signal notifyFolderClicked(var folderName);

    property var folderList: []

    Connections {
        target: service.mediaIndexer
        onListUpdated: {
            appLog.debug("FolderScene :: connection with media indexer :: onListUpdated");
            folderList = list;

            if(folderList.length == 0) {
                appLog.debug("FolderList is empty. Clean current folder info and files");
                currentFolder = "";
            }

            //Set default currentFolder value if mode is changed
            if(service.mediaIndexer.isOnUpdating) {
                appLog.debug("----- Waiting media list update ends");
            }

            folderListComponent.updateListModel(folderList);

//            if(!checkStartPointValid() &&
//                    isModeChanged &&
//                    folderList.length > 0) currentFolder = folderList[0];
//                    isModeChanged &&
            if(!checkStartPointValid() &&
                    folderList.length > 0) {
                appLog.debug("Set first folder as start point");
                currentFolder = folderList[0];
                startFolderInfo[currentMode] = currentFolder;
            }
        }
    }

    function setFolderListAsEmpty() {
        folderList = [];
        folderListComponent.updateListModel(folderList);
    }

    function checkStartPointValid(){
        if(startFolderInfo[currentMode] == "") {
            appLog.debug("StartFolder currentMode " + currentMode + " null ");
            return false;
        }

        const found = folderList.findIndex(element => element === startFolderInfo[currentMode]);

        appLog.debug("CheckStartPointValid() called :: found = " + found);

        if(found === -1) {
            appLog.debug("Start folder cannot be found : folder name = " + startFolderInfo[currentMode]);
            return false;
        }
        currentFolder = startFolderInfo[currentMode];
        folderListComponent.setStartIndex(found);

        return true;
    }

    Item {
        id: navBackwardBtn
        width: parent.width * 0.04
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        Canvas {
            id: leftArrow
            width: parent.width
            height: parent.height
            opacity: 0.4
            onPaint: {
                var ctx = getContext("2d");

                ctx.lineWidth = 1;
                ctx.strokeStyle = appStyle.appColor.borderlineColor

                ctx.fillStyle = appStyle.appColor.borderlineColor
                ctx.beginPath();
                ctx.moveTo(leftArrow.width / 5 * 4, leftArrow.height * 0.35);
                ctx.lineTo(leftArrow.width / 5, leftArrow.height * 0.5);
                ctx.lineTo(leftArrow.width / 5 * 4, leftArrow.height * 0.65);
                ctx.lineTo(leftArrow.width / 5 * 4, leftArrow.height * 0.6);
                ctx.lineTo(leftArrow.width / 5 * 2, leftArrow.height * 0.5);
                ctx.lineTo(leftArrow.width / 5 * 4, leftArrow.height * 0.4);
                ctx.closePath();
                ctx.fill();
                ctx.stroke();

            }
        }

        MouseArea {
            id: navBackwardBtnArea
            anchors.fill: parent
            state: "released"
            onPressed: {
                navBackwardBtnArea.state = "pressed";
            }
            onClicked: {
                folderListComponent.moveIndex(folderListComponent.backward);
            }
            onPressAndHold: {
                folderListComponent.moveFast(folderListComponent.backward);
            }

            onReleased: {
                navBackwardBtnArea.state = "released";
                folderListComponent.moveStop();
            }

            states: [
                State {
                    name: "pressed";
                    PropertyChanges {target: leftArrow; opacity: 1.0}
                },
                State {
                    name: "released";
                    PropertyChanges {target: leftArrow; opacity: 0.4}
                }
            ]

            transitions: [
                Transition {
                    NumberAnimation {
                        target: leftArrow; property: "opacity"
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            ]
        }
    }

    HorizentalListComponent {
        id: folderListComponent
        anchors.left: navBackwardBtn.right
        anchors.right: navForwardBtn.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: parent.width * 0.03
        anchors.rightMargin: parent.width * 0.03

        elementWidth: height * 0.8
        elementHeight: height * 0.8

        spacing: 30

        objectName:  "HorizentalListComponent"
        DebugBackground {}

        clickAcion: function(index){
            root.notifyFolderClicked(folderList[index]);
        }
    }

    Item {
        id: navForwardBtn
        width: parent.width * 0.04
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        Canvas {
            id: rightArrow
            width: parent.width
            height: parent.height
            opacity: 0.4
            onPaint: {
                var ctx = getContext("2d");

                ctx.lineWidth = 1;
                ctx.strokeStyle = appStyle.appColor.borderlineColor

                ctx.fillStyle = appStyle.appColor.borderlineColor
                ctx.beginPath();
                ctx.moveTo(rightArrow.width / 5, rightArrow.height * 0.35);
                ctx.lineTo(rightArrow.width / 5 * 4, rightArrow.height * 0.5);
                ctx.lineTo(rightArrow.width / 5, rightArrow.height * 0.65);
                ctx.lineTo(rightArrow.width / 5, rightArrow.height * 0.6);
                ctx.lineTo(rightArrow.width / 5 * 3, rightArrow.height * 0.5);
                ctx.lineTo(rightArrow.width / 5, rightArrow.height * 0.4);
                ctx.closePath();
                ctx.fill();
                ctx.stroke();

            }
        }

        MouseArea {
            id: navForwardBtnArea
            anchors.fill: parent
            state: "released"
            onPressed: {
                navForwardBtnArea.state = "pressed";
            }
            onClicked: {
                folderListComponent.moveIndex(folderListComponent.forward);
            }
            onPressAndHold: {
                folderListComponent.moveFast(folderListComponent.forward);
            }

            onReleased: {
                navForwardBtnArea.state = "released";
                folderListComponent.moveStop();
            }

            states: [
                State {
                    name: "pressed";
                    PropertyChanges {target: rightArrow; opacity: 1.0}
                },
                State {
                    name: "released";
                    PropertyChanges {target: rightArrow; opacity: 0.4}
                }
            ]

            transitions: [
                Transition {
                    NumberAnimation {
                        target: rightArrow; property: "opacity"
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            ]
        }
    }


}
