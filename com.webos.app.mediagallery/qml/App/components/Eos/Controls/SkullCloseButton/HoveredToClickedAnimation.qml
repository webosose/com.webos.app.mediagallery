/* @@@LICENSE
 *
 * Copyright (c) <2013-2015> LG Electronics, Inc.
 *
 * Confidential computer software. Valid license from LG required for
 * possession, use or copying. Consistent with FAR 12.211 and 12.212,
 * Commercial Computer Software, Computer Software Documentation, and
 * Technical Data for Commercial Items are licensed to the U.S. Government
 * under vendor's standard commercial license.
 *
 * LICENSE@@@ */

import QtQuick 2.4

SequentialAnimation {
    signal animCompleted

    // Hide eyes before the animation is played
    PropertyAction {
        target: leftEye;
        property: "visible";
        value: false
    }
    PropertyAction {
        target: rightEye;
        property: "visible";
        value: false
    }
    // Play skull explosion animation
    SkullExplosionAnimation {
        target: skullCircle
        frameDuration: root.frameDuration
    }
    ScriptAction {
        script: animCompleted()
    }
} // end of SequentialAnimation
