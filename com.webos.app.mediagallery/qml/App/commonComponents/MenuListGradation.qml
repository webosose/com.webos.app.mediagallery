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
        listView.currentIndex = index;
    }

    Component {
        id: listDelegate
        Item {
            id: base

            width: appStyle.relativeXBasedOnFHD(appStyle.menuItemWidth);
            height: appStyle.relativeYBasedOnFHD(appStyle.menuItemHeight + 2);

            //listView.currentIndex = index;
            Rectangle {
                id: gradationBackground
                visible: base.ListView.isCurrentItem
                width: parent.height
                height: parent.width
                anchors.centerIn: parent
//                gradient: Gradient.DeepBlue
                rotation: -90
                gradient: Gradient {
                    GradientStop { position:0.0; color: "transparent"}
                    GradientStop { position:0.2; color: appStyle.appColor.highlightColor}
                    GradientStop { position:0.4; color: appStyle.appColor.highlightColor}
                    GradientStop { position:0.75; color: "transparent"}
                }

            }

            Text {
                id: menuText
//                x: listView.currentIndex == index ? focusedDot.x + focusedDot.width + appStyle.relativeXBasedOnFHD(20) : focusedDot.width + appStyle.relativeXBasedOnFHD(20)
                x: base.ListView.isCurrentItem ? appStyle.relativeXBasedOnFHD(25) : appStyle.relativeXBasedOnFHD(20)
                width: appStyle.relativeXBasedOnFHD(appStyle.menuItemWidth) - x
                height: appStyle.relativeYBasedOnFHD(appStyle.menuItemHeight);
                text: name
                color: appStyle.appColor.mainTextColor
                font: appStyle.engFont.mainFont32
                wrapMode: Text.WordWrap
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter

                Behavior on x {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                }
            }

            Rectangle {
                anchors.top: menuText.bottom
                width: appStyle.relativeXBasedOnFHD(appStyle.menuItemWidth);
                height: appStyle.relativeYBasedOnFHD(2);
                color: base.ListView.isCurrentItem ? appStyle.appColor.highlightColor : appStyle.appColor.borderlineColor
                opacity: base.ListView.isCurrentItem ? 1.0 : 0.4
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
