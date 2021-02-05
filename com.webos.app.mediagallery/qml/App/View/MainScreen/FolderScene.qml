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
            folderListComponent.updateListModel(list);
        }
    }

    HorizentalListComponent {
        id: folderListComponent
        width: root.width
        height: appStyle.relativeYBasedOnFHD(150)
        clickAcion: function(index){
            appLog.debug("folderIndex:::::::::: index = " + index);
            root.notifyFolderClicked(folderList[index]);
        }
    }


}
