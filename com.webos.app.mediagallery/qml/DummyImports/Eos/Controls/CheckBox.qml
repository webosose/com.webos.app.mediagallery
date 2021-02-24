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

    style: CheckBoxStyle{}

    /*!
        \qmlproperty var focusedColor

        Provides the focused color of the CheckBox
    */
    property var focusedColor

    textFont: root.style.checkBoxFont
    textFontSize: root.style.checkBoxFontSize

    spacing: root.style.checkBoxSpacing
    horizontalPadding: root.style.checkBoxHorizontalPadding
    verticalPadding: root.style.checkBoxVerticalPadding

    indicator: CheckBoxIcon {
        checked: root.checked

        foregroundColor: root.checkMarkColor
        backgroundColor: checkMarkBackground ? root.checkMarkBackgroundColor : "transparent"

        anchors.fill: parent
    }

    indicatorSize: root.style.checkBoxIndicatorSize

    states: [
        State {
            name: "normal"
            when: enabled && !activeFocus && !down
            PropertyChanges { target: root
                checkMarkColor: style.checkBoxCheckMarkColor
                checkMarkBackgroundColor: style.checkBoxCheckMarkBackgroundColor
                textColor: style.checkBoxTextColor
            }
        },
        State {
            name: "pressed"
            when: enabled && !activeFocus && down
            PropertyChanges { target: root
                checkMarkColor: style.checkBoxCheckMarkPressedColor
                checkMarkBackgroundColor: style.checkBoxCheckMarkBackgroundPressedColor
                textColor: style.checkBoxTextPressedColor
            }
        },
        State {
            name: "focused"
            when: enabled && activeFocus
            PropertyChanges { target: root;
                checkMarkColor: style.checkBoxCheckMarkFocusedColor
                checkMarkBackgroundColor: root.focusedColor ? root.focusedColor : style.checkBoxCheckMarkBackgroundFocusedColor
                textColor: style.checkBoxTextFocusedColor
            }
        },
        State {
            name: "disabled"
            when: !enabled
            PropertyChanges { target: root
                checkMarkColor: style.checkBoxCheckMarkDisabledColor
                checkMarkBackgroundColor: style.checkBoxCheckMarkBackgroundDisabledColor
                textColor: style.checkBoxTextDisabledColor
            }
        }
    ]
}
