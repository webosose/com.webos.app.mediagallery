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


Rectangle {
    id: root
    property var style: ScrollDecoratorStyle {}

    anchors { right: parent.right }
    y: parent.visibleArea.yPosition * parent.height

    width: style.width
    height: parent.visibleArea.heightRatio * parent.height
    radius: style.radius

    color: style.backgroundColor
    opacity: 0

    Behavior on opacity {
        NumberAnimation {
        }
    }

    onHeightChanged: {
        if (!parent.moving) {
            opacity = style.activeOpacity
            opacityTimer.interval = 1000
            opacityTimer.restart()
        }
    }

    Timer {
        id: opacityTimer
        onTriggered: {
            root.opacity = style.idleOpacity
        }
    }

    Connections {
        target: root.parent
        onMovingChanged: {
            if (root.parent.moving) {
                opacityTimer.stop()
                root.opacity = style.activeOpacity
            }
            else {
                opacityTimer.interval = 200
                opacityTimer.restart()
            }
        }
    }
}
