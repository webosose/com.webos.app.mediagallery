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

    // Not sure but I hope this readonly may better than just binding formula.
    baseWidth: 1920
    baseHeight: 720
    width: baseWidth * 1.5
    height: baseHeight * 1.5
}
