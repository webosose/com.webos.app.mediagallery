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

/*!
    \qmltype ButtonPopup
    \since Eos 0.1
    \brief The ButtonPopup element provides a popup that
    can be opened on top of the button. The contextual popup
    and the tooltip element inherit from this element.
*/
FocusScope {
    id: root

    /*!
        \qmlproperty bool opened

        Determines whether the state of the popup is "opened".
        If the popup is not opened then its state is "closed".
    */
    property bool opened: false

    /*!
        \qmlproperty Item visualParent

        The visual parent is the element that the tooltip is associated with.
        Since the tooltip element is reparented for proper z-value handling
        the visual parent is not the actual parent while the tooltip is shown.
    */
    property Item visualParent: d.originalParent

    /*!
        \qmlproperty real offsetX

        offsetX: x-position of the tooltip relative to the top left
        corner of the visual parent.
    */
    property real offsetX: 0

    /*!
        \qmlproperty real offsetY

        offsetY: y-position of the tooltip relative to the top left
        corner of the visual parent.
    */
    property real offsetY: 0

    /*!
        \qmlproperty variant style

        Points to a button popup style element that describes the styling
        of the button popup. There is no default implementation for this
        property.
    */
    property variant style

    x: (parent != null) ? parent.mapFromItem(visualParent, offsetX, offsetY).x : 0
    y: (parent != null) ? parent.mapFromItem(visualParent, offsetX, offsetY).y : 0

    visible: false
    z: 10000

    /*!
        \qmlmethod open()

        This method changes the state of the button popup to "opened" and
        brings the popup to the front.
    */
    function open() {
        if (opened) return
        d.originalParent = root.parent
        root.parent = d.findRootItem("windowContent")
        root.visible = true
        opened = true
    }

    /*!
        \qmlmethod closed()

        This method changes the state of the button popup to "closed" and
        hides the popup.
    */
    function close() {
        if (!opened) return
        root.visible = false
        root.parent = d.originalParent
        opened = false
    }

    QtObject {
        id: d

        property QtObject originalParent

        function findRootItem(objectName) { // reparents the item to an item with a non-empty objectname or the toplevel root item.
            var next = root;

            while (next && next.parent) {
                next = next.parent;

                if (objectName === next.objectName) {
                    break;
                }
            }
            return next;
        }
    }

    state: "closed"

    states: [
        State {
            name: "opened"
            StateChangeScript {
                script: root.open()
            }
        },
        State {
            name: "closed"
            StateChangeScript {
                name: "closeMethod"
                script: root.close()
            }
        }
    ]
}
