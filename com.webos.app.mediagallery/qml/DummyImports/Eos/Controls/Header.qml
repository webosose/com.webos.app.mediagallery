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

    property variant style: HeaderStyle{}

    property string headerText
    property color headerColor: root.style.headerColor
    property string headerFont: root.style.headerFont
    property real headerFontSize: root.style.headerFontSize


    property string subHeaderText
    property color subHeaderColor: root.style.subHeaderColor
    property string subHeaderFont: root.style.subHeaderFont
    property real subHeaderFontSize: root.style.subHeaderFontSize

    property real margin: root.style.headerMargin
    property real spacing: root.style.headerSpacing

    property real verticalPadding: root.style.headerVerticalPadding
    property real horizontalPadding: root.style.headerHorizontalPadding

    property Item backgroundItem: Item {
        Rectangle {
            color: root.headerColor
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 2
        }
        Rectangle {
            color: root.headerColor
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 4
        }
    }

    Component.onCompleted: backgroundContainer.setBackground()
    onBackgroundItemChanged: backgroundContainer.setBackground()

    implicitHeight: header.implicitHeight + subHeader.implicitHeight + 2 * root.margin + d.effectiveSpacing + 2 * verticalPadding
    implicitWidth: Math.max( header.implicitWidth, subHeader.implicitWidth) + 2 * horizontalPadding

    Item {
        id: backgroundContainer
        anchors.fill: parent

        function setBackground () {
            backgroundItem.parent = backgroundContainer
            backgroundItem.anchors.fill = backgroundContainer
        }
    }

    QtObject {
        id: d
        property real effectiveSpacing: (root.subHeaderText == "") ? 0 : root.spacing
    }

    Text {
        id: header

        text: root.headerText

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.topMargin: root.margin + root.verticalPadding
        anchors.leftMargin: root.margin + root.horizontalPadding
        anchors.rightMargin: root.margin + root.horizontalPadding
        anchors.bottomMargin: subHeaderText != "" ? 0 : root.margin


        color: root.headerColor
        font.family: root.headerFont
        font.pixelSize: root.headerFontSize
        font.capitalization : Font.AllUppercase
    }

    Text {
        id: subHeader

        text: root.subHeaderText

        visible: root.subHeaderText != ""

        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.topMargin: root.margin
        anchors.leftMargin: root.margin + root.horizontalPadding
        anchors.rightMargin: root.margin + root.horizontalPadding
        anchors.bottomMargin: root.margin + root.verticalPadding

        color: root.subHeaderColor
        font.family: root.subHeaderFont
        font.pixelSize: root.subHeaderFontSize
        font.bold: true
    }


}
