/* @@@LICENSE
 *
 * Copyright (c) <2020> LG Electronics, Inc.
 *
 * Confidential computer software. Valid license from LG required for
 * possession, use or copying. Consistent with FAR 12.211 and 12.212,
 * Commercial Computer Software, Computer Software Documentation, and
 * Technical Data for Commercial Items are licensed to the U.S. Government
 * under vendor's standard commercial license.
 *
 * LICENSE@@@ */

import QtQuick 2.4
import Eos.Controls 0.1

Rectangle {
    id: root
    color: "transparent"

    property var service: findObjectByObjectName(desktopRoot, "serviceRoot")

    state: "closed"
    states: [
        State {
            name: "opened"
            PropertyChanges { target: root; x: 0 }
        },
        State {
            name: "closed"
            PropertyChanges { target: root; x: -1 * root.width }
        }
    ]

    function toggle() {
        if (state == "opened") {
            state = "closed";
        } else {
            state = "opened";
        }
    }

    transitions: [
        Transition {
            from: "opened"
            to: "closed"
            reversible: true
            NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 300 }
        }
    ]

    // open button
    Button {
        id: dbgWindowToggleButton
        text: root.state === "opened" ? "<" : ">"
        width : 50
        height: 50
        anchors.left: parent.right
        style: DebugButtonStyle {}
        onClicked: {
            root.toggle();
        }
    }

    // debug buttons

    Flow {
        spacing: 10
        anchors.fill: parent
        Button {
            id: sampleDbgButton
            text: "state : musicplay"
            width : 150
            height: 50
            style: DebugButtonStyle {}

            onClicked: {
                var obj = findObjectByObjectName(desktopRoot,"viewMain");
                obj.state = "NowPlaying"
            }
        }

        Button {
            id: sampleDbgButton2
            text: "state : musicList"
            width : 150
            height: 50
            style: DebugButtonStyle {}

            onClicked: {
                var obj = findObjectByObjectName(desktopRoot,"viewMain");
                obj.state = "MusicList"
            }
        }
    }

    function findObjectByObjectName(root,targetName) {
        for (var i = 0 ; i < root.children.length; i++ ) {
            if (root.children[i].objectName === "ignore")
                continue;
            if (root.children[i].objectName === targetName) {
                console.info("Found Correct Object",root.children[i],targetName);
                return root.children[i];
            }
            else {
                var branch = findObjectByObjectName(root.children[i],targetName);
                if (branch !== 0)
                    return branch;
            }
        }
        return 0;
    }
}
