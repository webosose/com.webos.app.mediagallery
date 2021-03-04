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
import WebOSServices 1.0
import "../components/QmlAppComponents"
import Eos.Controls 0.1
import "../commonComponents"

Item {
    id: root
    objectName: "mediaListController"

    property string currentMode: appRoot.appMode // 0:image, 1: video, 2: audio
    property var listType: "imageList"
    signal fileTreeUpdated(var list);

    property var fileTreeDictionary: ({"all":[]})

    function getFileListOfFolder(folderName) {
        if(folderName === "") return [];

        var fileList = fileTreeDictionary[folderName];
        if(fileList == undefined){
            appLog.error("ERROR: Unknown folderName = " + folderName);
            fileList = [];
        }
        return fileList;
    }

    function getFolderFileFromPath(path) {
        var splitArray = path.replace('file:///','').split('/');
        var pathArray = [splitArray[splitArray.length - 2], splitArray[splitArray.length-1]];

        return { folder: pathArray[0],
                 file: pathArray[1]    };
    }

    function getFileNameExceptExtension(file) {
        var splitArray = file.split('.');
        var name = splitArray.slice(0, splitArray.length - 1).join(".");
        return name;
    }

    function makeFolderThumbnail(parentId, folder, thumbnailWidth, thumbnailHeight) {
//        appLog.debug("MediaListController :: makeFolderThumbnail called with :: " + folder);
        var fileList = fileTreeDictionary[folder];
        var imgCount = fileList.length >= 4 ? 4: fileList.length;

        var thumbnailList = []
        for(var index = 0; index < imgCount; index++) {
            thumbnailList.push(fileList[index].thumbnail);
        }

        var thumbnailComponent = Qt.createComponent("FolderThumbnail.qml");

        var thumbnail;
        if(thumbnailComponent.status == Component.Ready) {
            thumbnail = thumbnailComponent.createObject(parentId,
                                                        {"imageList":thumbnailList,
                                                         "width": thumbnailWidth,
                                                         "height": thumbnailHeight});
            if(thumbnail == null) {
                //Error Handling
                appLog.debug("Error creating folder thumbnail for :: " +folder);
            }
        }
        return thumbnail;
    }

//    function finishCreation(component,sourceList) {
//        var sprite;
//        if (component.status == Component.Ready) {
//            sprite = component.createObject(mediaListController, {"imageList":sourceList});
//            if (sprite == null) {
//                // Error Handling
//                console.log("Error creating object");
//            }
//        } else if (component.status == Component.Error) {
//            // Error Handling
//            console.log("Error loading component:", component.errorString());
//        }
//        return sprite;
//    }


    Connections {
        target: mediaIndexerService
        onMediaListChanged: {
            appLog.debug("MeidaListController get mediaList length = " + mediaList.length);
            appLog.debug("MeidaListController isModeChanged = " + isModeChanged);
            if(mediaList.length === 0) {
                fileTreeDictionary = {"all":[]};
                root.fileTreeUpdated([]);
                return;
            }

            //TODO : ********************  ModeChange TTTTTTT
            if(isModeChanged) fileTreeDictionary= {"all":[]}


            for (var i = 0 ; i < mediaList.length; i++) {
                if(mediaList[i].file_path == undefined) {
                    appLog.warn(i + "th data doesn't have file path : " + Utils.listProperty(list[i]));
                    continue;
                }

                var {folder,file} = getFolderFileFromPath(mediaList[i].file_path);
                var fileList = [];

                //mediaList: put default data if value is not exist
                if(mediaList[i].thumbnail == undefined) {
                    if(appRoot.appMode == stringSheet.category.image) {
                        mediaList[i].thumbnail = mediaList[i].file_path
                    } else {
                        mediaList[i].thumbnail = "EmptyThumbnail";
                    }
                }

                if(mediaList[i].title == undefined) {
                        mediaList[i].title = getFileNameExceptExtension(file)
                }

                if(folder in fileTreeDictionary) {
                    fileList = fileTreeDictionary[folder];

                    //TODO: Need to check how to deal when same file data is received

                    //Idea1: Use duplicate check dictionary and folderfilelist seperately

                    var exist = -1;
                    for(var flist = 0 ; flist < fileList.length; flist ++) {
                        if(fileList[flist]["file_path"] == mediaList[i].file_path) exist = flist;
                    }
                    if(exist == -1) fileList.push(mediaList[i]); // push new item
                    else fileList[exist] = mediaList[i]; // modify
                } else {
                    fileList.push(mediaList[i]);
                    fileTreeDictionary[folder] = fileList;
                }

                var allList = fileTreeDictionary["all"];
                allList.push(mediaList[i]);
            }

            var folders = (Object.keys(fileTreeDictionary)).filter(value => value !== "all")
            root.fileTreeUpdated(folders);
        }
    }


}
