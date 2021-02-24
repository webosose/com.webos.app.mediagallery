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

    style: RadioButtonStyle{}

    /*!
        \qmlproperty var focusedColor

        Provides the focused color of the button
    */
    property var focusedColor

    textFont: root.style.radioButtonFont
    textFontSize: root.style.radioButtonFontSize

    spacing: root.style.radioButtonSpacing
    horizontalPadding: root.style.radioButtonHorizontalPadding
    verticalPadding: root.style.radioButtonVerticalPadding

    indicator: RadioButtonIcon {
        checked: root.checked

        foregroundColor: root.checkMarkColor
        backgroundColor: root.checkMarkBackgroundColor

        anchors.fill: parent
    }

    indicatorSize: root.style.radioButtonIndicatorSize

    states: [
        State {
            name: "normal"
            when: enabled && !activeFocus && !down
            PropertyChanges { target: root
                checkMarkColor: style.radioButtonCheckMarkColor
                checkMarkBackgroundColor: style.radioButtonCheckMarkBackgroundColor
                textColor: style.radioButtonTextColor
            }
        },
        State {
            name: "pressed"
            when: enabled && !activeFocus && down
            PropertyChanges { target: root
                checkMarkColor: style.radioButtonCheckMarkPressedColor
                checkMarkBackgroundColor: style.radioButtonCheckMarkBackgroundPressedColor
                textColor: style.radioButtonTextPressedColor
            }
        },
        State {
            name: "focused"
            when: enabled && activeFocus
            PropertyChanges { target: root;
                checkMarkColor: style.radioButtonCheckMarkFocusedColor
                checkMarkBackgroundColor: root.focusedColor ? root.focusedColor : style.radioButtonCheckMarkBackgroundFocusedColor
                textColor: style.radioButtonTextFocusedColor
            }
        },
        State {
            name: "disabled"
            when: !enabled
            PropertyChanges { target: root
                checkMarkColor: style.radioButtonCheckMarkDisabledColor
                checkMarkBackgroundColor: style.radioButtonCheckMarkBackgroundDisabledColor
                textColor: style.radioButtonTextDisabledColor
            }
        }
    ]
}
