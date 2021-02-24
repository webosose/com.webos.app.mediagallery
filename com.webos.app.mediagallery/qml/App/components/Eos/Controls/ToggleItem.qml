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

    style: ToggleItemStyle{}

    textFont: root.style.toggleItemFont
    textFontSize: root.style.toggleItemFontSize

    spacing: root.style.toggleItemSpacing
    horizontalPadding: root.style.toggleItemHorizontalPadding
    verticalPadding: root.style.toggleItemVerticalPadding

    indicator: ToggleItemIcon {
        checked: root.checked

        foregroundColor: root.textColor
        backgroundColor: "transparent"

        fontFamily: root.textFont
        fontSize: root.textFontSize

        anchors.fill: parent
    }

    indicatorSize: root.style.toggleItemIndicatorSize

    states: [
        State {
            name: "normal"
            when: enabled && !activeFocus && !down
            PropertyChanges { target: root
                textColor: style.toggleItemTextColor
            }
        },
        State {
            name: "pressed"
            when: enabled && !activeFocus && down
            PropertyChanges { target: root
                textColor: style.toggleItemTextPressedColor
            }
        },
        State {
            name: "focused"
            when: enabled && activeFocus
            PropertyChanges { target: root;
                textColor: style.toggleItemTextFocusedColor
            }
        },
        State {
            name: "disabled"
            when: !enabled
            PropertyChanges { target: root
                textColor: style.toggleItemTextDisabledColor
            }
        }
    ]
}
