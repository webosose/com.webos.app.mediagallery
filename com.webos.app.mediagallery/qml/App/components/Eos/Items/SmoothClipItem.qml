/* @@@LICENSE
 *
 * Copyright (c) 2013-2021 LG Electronics, Inc.
 *
 * Confidential computer software. Valid license from LG required for
 * possession, use or copying. Consistent with FAR 12.211 and 12.212,
 * Commercial Computer Software, Computer Software Documentation, and
 * Technical Data for Commercial Items are licensed to the U.S. Government
 * under vendor's standard commercial license.
 *
 * LICENSE@@@ */

import QtQuick 2.4

/* This test example illustrates verifies basic capabilities of the parallelogram.
 It also tests the horizontal clipping feature. */

Item {
    id: root

    property Item sourceItem
    property Item maskItem

    ShaderEffect {
        id: effect
        anchors.fill: parent

        property var image: ShaderEffectSource {
            sourceItem: root.sourceItem
            hideSource: true
        }

        property var masked: ShaderEffectSource {
            sourceItem: root.maskItem
            hideSource: true
        }

        fragmentShader: Qt.resolvedUrl("SmoothClipItem.frag")
    }
}
