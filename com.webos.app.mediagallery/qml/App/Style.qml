/* @@@LICENSE
*
*      Copyright (c) 2021 LG Electronics, Inc.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*
* LICENSE@@@ */

import QtQuick 2.6
import QmlAppComponents 0.1

AppStyle {
    id: root

    // Scale
    // Not sure but I hope this readonly may better than just binding formula.
    baseWidth: 1920
    baseHeight: 1080
    width: baseWidth
    height: baseHeight

    property int viewWidth: baseWidth
    property int viewHeight: baseHeight

    property int viewItemSpacing: 20

    property int menuWitdh: 250
    property int menuHeight: baseHeight

    property int menuItemWidth: 250
    property int menuItemHeight: 80

    property int mainScreenWidth: 1250
//    property int mainScreenHeight: 100

    property int paddingInMainScreen: 50

    property int folderListHeight: 200
    property int folderItemWidth: 150

    property int mediaListHeight: 440-paddingInMainScreen
    property int mediaListHPadding:50

    property int gridViewSize: 200

    //Color and background
    property var imgDir: "./Images/"

    property string background: imgDir + "bg_pattern2.png"

    property AppColorTheme appColor : AppColorTheme {}

    property FontStyle engFont: FontStyle {}

}
