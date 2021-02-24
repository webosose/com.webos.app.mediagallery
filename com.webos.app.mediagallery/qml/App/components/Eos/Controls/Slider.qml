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

Item {
    id: root

    property int minValue: 0
    property int maxValue: 100
    property int value: 50

    signal currentValueChanged(int value)

    property variant style: SliderStyle{}

    /*!
        \qmlproperty var focusedColor

        Provides the focused color of the button
    */
    property var focusedColor

    width: 200
    height: 60

    QtObject {
        id: internal

        property int currentValue: (handleWrapper.x / root.width) * (Math.abs(root.maxValue) - Math.abs(root.minValue))
    }

    Rectangle {
        id: sliderGroove

        anchors.left: root.left
        anchors.leftMargin: root.height / 2
        anchors.right: root.right
        anchors.rightMargin: root.height / 2
        anchors.verticalCenter: root.verticalCenter
        height: root.height / 8
        radius: height / 2
        color: root.style.sliderGrooveColor
        antialiasing: true;

        Item {
            id: handleWrapper

            x: sliderGroove.width * (root.value / (Math.abs(root.maxValue) - Math.abs(root.minValue)))
            anchors.verticalCenter: parent.verticalCenter
            width: 1

            Rectangle {
                id: sliderHandle

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                height: root.height
                width: height
                radius: height / 2
                color: root.focusedColor ? root.focusedColor : root.style.sliderHandleColor
                antialiasing: true;

                MouseArea {
                    enabled: root.enabled
                    anchors.fill: parent

                    drag.axis: Drag.XAxis
                    drag.target: handleWrapper
                    drag.minimumX: 0
                    drag.maximumX: sliderGroove.width

                    onPositionChanged: root.currentValueChanged(internal.currentValue);
                }
            }
        }
    }
}
