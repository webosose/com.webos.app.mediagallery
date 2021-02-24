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

Item {
    id: root

    property real   comboWidth: 351
    property real   comboItemHeight: 100
    property string comboFocusColor: "#CF0652"
    property string comboBgColor: "#323232"

    property real comboVerticalMargin: 40
    property real comboHorizontalMargin: 35

    property real comboCornerRadius: 25

    property int    comboHeaderFontSize : 32
    property string comboHeaderFontFamiliy : "Museo Sans"
    property color  comboHeaderColor : "white"
    property real   comboHeaderHeight: 80

    property int    comboItemFontSize : 38
    property string comboItemFontFamiliy : "Museo Sans"
    property color  comboItemColor : "white"

    property int comboAnimationTime: 250
}
