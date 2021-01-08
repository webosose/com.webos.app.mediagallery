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

FocusScope {
    id: root

    onChildrenChanged: {
        for (var i = 0; i < root.children.length; ++i) {
            if (root.children[i].objectName !== "__internalLayout") {
                if (root.children[i].text !== undefined) {
                    root.children[i].parent =  internalLayout
                }
            }
        }
    }
    Flickable {
        objectName: "__internalLayout"
        anchors.fill: parent
        contentHeight: internalLayout.childrenRect.height

        Column {
            anchors.fill: parent
            id: internalLayout
        }
    }
}
