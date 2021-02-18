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
            width: appStyle.relativeXBasedOnFHD(380);
            height: appStyle.relativeYBasedOnFHD(100 + 2);

            //listView.currentIndex = index;

            Rectangle {
                id: focusedDot
                width: appStyle.relativeXBasedOnFHD(10)
                height: appStyle.relativeYBasedOnFHD(10)
                radius: width / 2
                color: appStyle.colors.vsKeyColor
                anchors.verticalCenter: parent.verticalCenter
                x: appStyle.relativeXBasedOnFHD(20)
                visible: listView.currentIndex == index || opacity > 0.05
                opacity: listView.currentIndex == index ? 1.0 : 0.0

                Behavior on opacity {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            Text {
                id: menuText
                x: listView.currentIndex == index ? focusedDot.x + focusedDot.width + appStyle.relativeXBasedOnFHD(20) : focusedDot.width + appStyle.relativeXBasedOnFHD(20)
                width: appStyle.relativeXBasedOnFHD(380) - x
                height: appStyle.relativeYBasedOnFHD(100);
                text: name
                color: appStyle.colors.mainTextColor
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
                width: appStyle.relativeXBasedOnFHD(380);
                height: appStyle.relativeYBasedOnFHD(2);
                color: listView.currentIndex == index ? appStyle.colors.vsKeyColor : appStyle.colors.borderlineColor
                opacity: listView.currentIndex == index ? 1.0 : 0.4
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
