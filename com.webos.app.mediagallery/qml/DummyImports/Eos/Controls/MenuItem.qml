/* @@@LICENSE
 *
 * Copyright (c) <2013-2014> LG Electronics, Inc.
 *
 * Confidential computer software. Valid license from LG required for
 * possession, use or copying. Consistent with FAR 12.211 and 12.212,
 * Commercial Computer Software, Computer Software Documentation, and
 * Technical Data for Commercial Items are licensed to the U.S. Government
 * under vendor's standard commercial license.
 *
 * LICENSE@@@ */

import QtQuick 2.4
import Eos.Style 0.1

CheckableItem {
    id: root

    style: MenuItemStyle{}

    signal triggered()

    /*!
        \qmlproperty var focusedColor

        Provides the focused color of the button
    */
    property var focusedColor

    width: parent.width

    textFont: root.style.menuItemFont
    textFontSize: root.style.menuItemFontSize

    spacing: root.style.menuItemSpacing
    horizontalPadding: root.style.menuItemHorizontalPadding
    verticalPadding: root.style.menuItemVerticalPadding

    onClicked: triggered()

    function trigger() {
        root.checked = true;
        triggered()
    }

    backgroundItem: Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1

        color: checked ? "#226b9a" : ( (root.state == "focused") ? "#2a4f67" : "#333333" )
    }

    states: [
        State {
            name: "normal"
            when: enabled && !activeFocus && !down
            PropertyChanges { target: root
                checkMarkColor: style.menuItemCheckMarkColor
                checkMarkBackgroundColor: style.menuItemCheckMarkBackgroundColor
                textColor: style.menuItemTextColor
            }
        },
        State {
            name: "pressed"
            when: enabled && !activeFocus && down
            PropertyChanges { target: root
                checkMarkColor: style.menuItemCheckMarkPressedColor
                checkMarkBackgroundColor: style.menuItemCheckMarkBackgroundPressedColor
                textColor: style.menuItemTextPressedColor
            }
        },
        State {
            name: "focused"
            when: enabled && activeFocus
            PropertyChanges { target: root;
                checkMarkColor: style.menuItemCheckMarkFocusedColor
                checkMarkBackgroundColor: root.focusedColor ? root.focusedColor : style.menuItemCheckMarkBackgroundFocusedColor
                textColor: style.menuItemTextFocusedColor
            }
        },
        State {
            name: "disabled"
            when: !enabled
            PropertyChanges { target: root
                checkMarkColor: style.menuItemCheckMarkDisabledColor
                checkMarkBackgroundColor: style.menuItemCheckMarkBackgroundDisabledColor
                textColor: style.menuItemTextDisabledColor
            }
        }
    ]
}
