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

    property string title

    property variant style: GroupHeaderStyle{}

    property color titleColor: root.style.groupHeaderTitleColor
    property string titleFontFamily: root.style.groupHeaderTitleFont
    property real titleFontSize: root.style.groupHeaderTitleFontSize
    property bool titleFontItalic: root.style.groupHeaderTitleFontItalic

    property color dividerColor: root.style.groupHeaderDividerColor
    property real dividerHeight: root.style.groupHeaderDividerHeight

    implicitWidth: titleText.paintedWidth
    implicitHeight: titleText.paintedHeight + divider.height

    onHeightChanged: d.checkHeight()

    QtObject {
        id: d

        function checkHeight() {
            if (height < implicitHeight ) {
                height = implicitHeight
            }
        }
    }

    Text {
        id: titleText
        text: root.title

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        color: titleColor

        height: paintedHeight

        font.family: root.titleFontFamily
        font.pixelSize: root.titleFontSize
        font.italic: root.titleFontItalic
    }

    Rectangle {
        id: divider

        anchors.top: titleText.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        height: root.dividerHeight

        color: root.dividerColor
    }
}
