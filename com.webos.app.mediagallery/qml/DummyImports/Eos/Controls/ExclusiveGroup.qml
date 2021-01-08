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
import "ExclusiveGroup.js" as Script

Item {
    id: root

    property Item contentItem
    property Item current
    property string title

    function bindCheckable(object) {
        Script.addItem(object);
        object.toggled.connect (adjustCheckableItemStates );
    }

    function unbindCheckable(object) {
// TBD
    }

    function adjustCheckableItemStates(checked,sender) {
        root.current = sender;
        var list = Script.getItemList();
        for (var i = 0; i < list.length; ++i) {
            if (list[i] !== root.current) {
                list[i].checked = false;
            }
        }
    }
}
