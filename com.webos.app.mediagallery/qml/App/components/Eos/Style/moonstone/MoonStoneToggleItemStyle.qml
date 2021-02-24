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

Item {
    id: root

    property color toggleItemTextColor: "#a6a6a6"

    property color toggleItemTextPressedColor: "#a6a6a6"

    property color toggleItemTextFocusedColor: "white"

    property color toggleItemTextDisabledColor: "#4d4d4d"

    property string toggleItemFont: "MuseoSans Bold"
    property real toggleItemFontSize: 36

    property real toggleItemSpacing: -30
    property real toggleItemVerticalPadding: 10
    property real toggleItemHorizontalPadding: 10

    property real toggleItemIndicatorSize: 30
}
