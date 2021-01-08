/* @@@LICENSE
 *
 * Copyright (c) 2014 LG Electronics, Inc.
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

    property variant style

    property bool running: false

    property Item spinnerItem: DefaultSpinner {}

    property color color: "#404040"

    property string text

    function start() {
        running = true
    }

    function stop() {
        running = false
    }

    implicitWidth: spinnerItem.implicitWidth
    implicitHeight: spinnerItem.implicitHeight

    Component.onCompleted: spinnerContainer.setSpinner()
    onSpinnerItemChanged: spinnerContainer.setSpinner()

    Item {
        id: spinnerContainer
        anchors.fill: parent

        function setSpinner () {
            spinnerItem.parent = spinnerContainer
            spinnerItem.anchors.fill = spinnerContainer
        }
    }
}
