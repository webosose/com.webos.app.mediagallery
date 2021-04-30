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

Item {
    id: root

    objectName: "menuList"

    property var menuElements: []
    property bool interactive: listView.childrenRect.height > listView.height
    property alias currentIndex: listView.currentIndex

    ListModel {
        id: menuListModel
    }

    onMenuElementsChanged: {
        applyItem();
    }

    function applyItem() {
        menuListModel.clear();
        for (var i = 0 ; i < menuElements.length; i++)
            menuListModel.append({"name": menuElements[i]})
    }

    function setStartIndex(index) {
        if(listView.currentIndex != index)
            listView.currentIndex = index;
    }

    Component {
        id: listDelegate
        Item {
            id: base

            width: appStyle.relativeXBasedOnFHD(appStyle.menuItemWidth);
            height: appStyle.relativeYBasedOnFHD(appStyle.menuItemHeight + 5);

            Rectangle {
                id: text_background
                width: appStyle.relativeXBasedOnFHD(appStyle.menuItemWidth)
                height: appStyle.relativeYBasedOnFHD(appStyle.menuItemHeight);
                color: base.ListView.isCurrentItem ? appStyle.appColor.selectMenuBackground :
                    appStyle.appColor.normalMenuBackground

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }

                Text {
                    id: menuText
                    anchors.fill:parent
                    text: name
                    color: appStyle.appColor.mainTextColor
                    font: base.ListView.isCurrentItem? appStyle.engFont.mainFont28Bold :
                        appStyle.engFont.mainFont28
                    wrapMode: Text.WordWrap
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    listView.currentIndex = index;
                }
            }
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        model: menuListModel
        delegate: listDelegate
        interactive: root.interactive
        focus: true
    }
}
