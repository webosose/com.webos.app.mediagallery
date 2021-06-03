/* @@@LICENSE
 *
 * Copyright (c) 2013-2021 LG Electronics, Inc.
 *
 * Confidential computer software. Valid license from LG required for
 * possession, use or copying. Consistent with FAR 12.211 and 12.212,
 * Commercial Computer Software, Computer Software Documentation, and
 * Technical Data for Commercial Items are licensed to the U.S. Government
 * under vendor's standard commercial license.
 *
 * LICENSE@@@ */

import QtQuick 2.4

ShaderEffect {
    property real elideStart
    property real elideEnd
    property real elideLeftStart
    property real elideLeftEnd

    property real _unitsPerPixel: width > 0 ? 1 / width : 0

    property real _start: elideStart * _unitsPerPixel
    property real _end: elideEnd * _unitsPerPixel
    property real _leftStart: elideLeftStart * _unitsPerPixel
    property real _leftEnd: elideLeftEnd * _unitsPerPixel

    fragmentShader: Qt.resolvedUrl("ElideShader.frag")
}
