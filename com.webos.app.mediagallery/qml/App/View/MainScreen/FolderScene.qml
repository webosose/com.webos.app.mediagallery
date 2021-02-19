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
import "./ListComponent/"

/*
-- Scene ----- MediaList --- GridView
I                          I
I                          -- DetailView
*/
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

            //Set default currentFolder value if mode is changed
            if(service.mediaIndexer.isOnUpdating) {
                appLog.debug("----- Waiting media list update ends");
//                return;
            }

            folderListComponent.updateListModel(folderList);

//            if(!checkStartPointValid() &&
//                    isModeChanged &&
//                    folderList.length > 0) currentFolder = folderList[0];
//                    isModeChanged &&
            if(!checkStartPointValid() &&
                    folderList.length > 0) currentFolder = folderList[0];
        }
    }

    function checkStartPointValid(){
        if(startFolder == "") { return false; }

        const found = folderList.findIndex(element => element == startFolder);

        appLog.debug("checkStartPointValid() called :: found = " + found);

        if(found == -1) {
            appLog.debug("Start folder cannot be found : folder name = " + startFolder
                         + "\n Set first folder as start point");
            startFolder = "";
            return false;
        }

        currentFolder = startFolder;
        folderListComponent.setStartIndex(found);
        startFolder = "";

        return true;
    }

    Rectangle {
        anchors.fill:parent
        color: "black"
        opacity: 0.3
    }

    HorizentalListComponent {
        id: folderListComponent
//        width: root.width
//        height: root.height
        anchors.fill: parent
        anchors.leftMargin: appStyle.relativeXBasedOnFHD(30)
//        anchors.verticalCenter: parent.verticalCenter

        elementWidth: height * 0.8
        elementHeight: height * 0.8

        spacing: 30

        objectName:  "HorizentalListComponent"
        DebugBackground {}

//        elementWidth: appStyle.relativeYBasedOnFHD(appStyle.folderItemWidth)
//        elementHeight: appStyle.relativeYBasedOnFHD(appStyle.folderItemWidth)

        clickAcion: function(index){
            appLog.debug("folderIndex:::::::::: index = " + index);
            root.notifyFolderClicked(folderList[index]);
        }
    }


}
