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

ListView {
    id: root

    property Item scrollDecorator: ScrollDecorator {}

    onScrollDecoratorChanged: {
        scrollDecorator.parent = root
    }

    Component.onCompleted: {
        scrollDecorator.parent = root
    }
}