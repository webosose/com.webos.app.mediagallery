/* @@@LICENSE
 *
 * Copyright (c) 2021 LG Electronics, Inc.
 *
 * Confidential computer software. Valid license from LG required for
 * possession, use or copying. Consistent with FAR 12.211 and 12.212,
 * Commercial Computer Software, Computer Software Documentation, and
 * Technical Data for Commercial Items are licensed to the U.S. Government
 * under vendor's standard commercial license.
 *
 * LICENSE@@@ */

import QtQuick 2.4
import QmlAppComponents 0.1

AppStyle {
    id: root

    // Scale
    // Not sure but I hope this readonly may better than just binding formula.
    baseWidth: 1920
    baseHeight: 1080 //avn:720
    width: baseWidth * 1.5
    height: baseHeight * 1.5

    property int viewWidth: baseWidth
    property int viewHeight: baseHeight

    property int menuWitdh: 250
    property int menuHeight: baseHeight

    property int menuItemWidth: 250
    property int menuItemHeight: 100

    property int mainScreenWidth: 1250
//    property int mainScreenHeight: 100

    property int paddingInMainScreen: 30

    property int folderListHeight: 200
    property int folderItemWidth: 150

    property int mediaListHeight: 440-30

    property int gridViewSize: 200


    //Color and background
    property var imgDir: "./Images/"

    property string background: imgDir + "bg_pattern2.png"

    property AppColorTheme appColor : AppColorTheme {}

    property FontStyle engFont: FontStyle {}

}
