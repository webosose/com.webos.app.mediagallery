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

/*!
    \qmltype ContextualPopup
    \since Eos 0.1
    \brief The ContextualPopup element provides a styled popup that
    appear on clicking the button.
*/
ButtonPopup {
    id: root

    offsetX: (visualParent !== null ) ? visualParent.width * 2/5 : 0
    offsetY: (visualParent !== null ) ? visualParent.height + 10 : 0

    implicitWidth: label.implicitWidth + 2 * horizontalPadding
    implicitHeight: label.implicitHeight + 2 * verticalPadding

    /*!
        \qmlproperty real horizontalPadding

        This property holds the value for the horizontal
        padding inside a contextual popup.
    */
    property real horizontalPadding: style.tooltipHorizontalPadding

    /*!
        \qmlproperty real verticalPadding

        This property holds the value for the vertical
        padding inside a contextual popup.
    */
    property real verticalPadding: style.tooltipVerticalPadding

    style: TooltipStyle{}

    Rectangle {
        id: background

        color: style.tooltipBackgroundColor
        radius: height/2

        anchors.fill: parent

        visible: label.text != ""

        Rectangle {
            anchors.top: parent.top
            anchors.left: parent.left
            color: parent.color
            height: parent.height/2
            width: parent.height/2
        }

        Text {
            id: label

            text: "Context"
            color: root.style.tooltipTextColor

            font.family: root.style.tooltipFont
            font.pixelSize: root.style.tooltipFontSize
            font.capitalization: Font.AllUppercase

            anchors.centerIn: parent
        }
    }

    transitions: [
        Transition {
            from: "closed" ;to: "opened"
            PropertyAnimation { target: root
                                properties: "opacity";
                                from: "0.0";
                                to: "1.0"
                                duration: 200 }
        },
        Transition {
            from: "opened" ;to: "closed"
            SequentialAnimation {
                PropertyAnimation { target: root
                                    properties: "opacity";
                                    from: "1.0";
                                    to: "0.0"
                                    duration: 200 }
                ScriptAction { scriptName: "closeMethod" }
            }
        }

    ]
}
