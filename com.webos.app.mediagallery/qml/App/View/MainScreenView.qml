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
import "./MainScreen"
import QmlAppComponents 0.1

/*
-- Scene ------ Loading
I         I
I         ----- MediaList --- GridView
I                          I
I                          -- DetailView
*/

Item {
    id: root

    objectName: "mainScreenView"

    clip: true

    DebugBackground {}

    property var currentFolder: "";
    property var startFolderInfo: ({})
    property var currentMode: viewMain.currentMode

    onCurrentFolderChanged: {
        appLog.debug("MainScreenView currentFolder " + currentFolder);
    }

    onCurrentModeChanged: {
        root.state = "showList"
    }

    Connections {
        target: folderListScene

        onNotifyFolderClicked: {
            appLog.debug("NotifyFolderClick in MainScreenView :" +folderName);
            currentFolder = folderName;

            startFolderInfo[currentMode] = currentFolder;
            appLog.debug("StartFolder for mode = " + currentMode + " = " + currentFolder);
        }
    }

    Connections {
        target: modeViewArea
        onClicked: {
            if(root.state == "preview")
               root.state = "disappearAnimation";
        }
    }

    function setFolderListAsEmpty () {
        folderListScene.setFolderListAsEmpty();
    }

    FolderScene {
        id: folderListScene
        objectName: "folderListScene"
        height: appStyle.relativeYBasedOnFHD(appStyle.folderListHeight)
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        DebugBackground {}
    }

    Rectangle {
        id: spacingRect

        objectName: "spacingRect"

        height: appStyle.relativeYBasedOnFHD(appStyle.paddingInMainScreen)
        anchors.top: folderListScene.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        color: "transparent"
        DebugBackground {}
    }

    MediaListScene {
        id: mediaListScene

        objectName: "mediaListScene"

        anchors.top: spacingRect.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.leftMargin: appStyle.relativeXBasedOnFHD(appStyle.mediaListHPadding)
        anchors.rightMargin: appStyle.relativeXBasedOnFHD(appStyle.mediaListHPadding)
        anchors.bottomMargin: appStyle.relativeYBasedOnFHD(appStyle.paddingInMainScreen)

        DebugBackground {}
    }

    property real clickX: 0
    property real clickY: 0
    property var selectedFileInfo

    function showPreview(filePath, x, y, _selectedFileInfo) {
        clickX = x + mediaListScene.x;
        clickY = y + mediaListScene.y;
        selectedFileInfo = _selectedFileInfo;

        previewImage.setPreviewSource(filePath);
        root.state = "preview";
    }

    state: "showList"

    states: [
        State {
            name: "preview"
            PropertyChanges { target: previewImage; visible: true }
            PropertyChanges { target: photo; x: previewImage.width * 0.1;
                y:previewImage.height * 0.15;
                width: previewImage.width * 0.8;
                height: previewImage.height * 0.8}
        },


        State {
            name: "disappearAnimation"
            PropertyChanges { target: previewImage; visible: true }
            PropertyChanges { target: photo; x:clickX; y:clickY; width: 453; height: 453}
        },
        State {
            name: "showList"
            PropertyChanges {target: previewImage; visible: false }
            PropertyChanges { target: photo; x:clickX; y:clickY;
                width: 453; height: 453}
        }
    ]

    transitions: [
        Transition {
            id: enlargeAnim
            from: "showList"
            to: "preview"
            PropertyAnimation {
                target: photo
                properties: "x, y, width, height"
                duration: 300
                easing.type: Easing.InOutQuad
                running: false
            }
        },
        Transition {
            from: "preview"
            to: "disappearAnimation"
            SequentialAnimation {
                PropertyAnimation {
                    target: photo
                    properties: "x, y, width, height"
                    duration: 300
                    easing.type: Easing.InOutQuad
                }
                ScriptAction {
                    script: { root.state = "showList" }
                }
            }
        }
   ]

    onStateChanged: {
        appLog.debug("MainScreenView state = " + root.state);
    }

    Item {
        id: previewImage
        anchors.fill: parent
        visible: false

        function setPreviewSource(filePath) {
            photo.source = filePath;
        }


        Rectangle {
            anchors.fill:photo
            color:"#80000000"
        }

        Image {
            id:photo
            width: previewImage.width * 0.8
            height: previewImage.height * 0.8
            source: ""
            sourceSize.width: previewImage.width
            fillMode: Image.PreserveAspectFit

            Rectangle {
                anchors.fill:parent
                color:"transparent"
                border.width:3
                border.color:"black";
            }


            Rectangle {
                //TODO: check image size and opacity
                anchors.fill: parent
                visible: photo.status == Image.Error ||  photo.status == Image.Null
                color: "#a0000000"
                Image{
                    id: error_preview
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width * 0.4
                    height: parent.height * 0.4
                    source: appRoot.imageDir + "empty_image.png"

                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    anchors.top: error_preview.bottom
                    anchors.left: error_preview.left
                    anchors.right: error_preview.right
                    anchors.topMargin: appStyle.relativeYBasedOnFHD(15)
                    text: "Cannot load image"
                    color: appStyle.appColor.mainTextColor
                    font: appStyle.engFont.mainFont28Bold
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    opacity: 0.8
                }
            }
        }

        function isPreviewArea(x,y) {
            if(previewImage.visible == false) return false;

            if((x>= photo.x && x <= photo.x + photo.width)
               && (y>= photo.y && y <= photo.y + photo.height)) {
                return true;
            }
            return false;
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: root.state == "preview" ? true : false

        onClicked: {
            //check the clicked area is inside preview
            var isInsidePreview = previewImage.isPreviewArea(mouseX, mouseY);
            if(isInsidePreview === false) {
                root.state = "disappearAnimation"
            } else {
                if (selectedFileInfo === undefined) {
                    service.webOSService.singleCallService.callSimpleToast("Cannot open viewer for unknown reason.");
                } else {
                    appLog.debug("call image viewer from preview");
                    service.webOSService.singleCallService.launchAppWithParam(
                                stringSheet.viewerApps.image, selectedFileInfo);
                }
            }
        }

        onWheel : {
            //consuming wheel event
        }
    }

    Rectangle {
        id: loadingScrim
        width: parent.width * 0.45
        height: parent.height * 0.12
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color:appStyle.appColor.normalMenuBackground
        visible: service.mediaIndexer.isOnUpdating
        opacity: 0.86
        radius: 10

        Text {
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: appStyle.appColor.mainTextColor
            font: appStyle.engFont.getFont(42,700)
            text: stringSheet.mediaList.onLoading + dot

            property string dot: "."
            Timer {
                repeat: true
                running: loadingScrim.visible
                interval: 1000
                onTriggered: {
                    parent.dot = parent.dot + ".";
                    if (parent.dot.length > 3)
                        parent.dot = "."
                }
            }
        }

        MouseArea {
            id: consumer
            anchors.fill: parent
            onClicked: {}
            onPressed: {}
            onReleased: {}
        }
    }
}
