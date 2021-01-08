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

/* A simple animation of a prerendered set of images.
   This implementation is specific to the skull animation. */

SequentialAnimation {
    property Item target
    property real frameDuration: 40

    PropertyAction {
        target: target
        property: "source"
        value: "./images/skull3.png"
    }
    PauseAnimation {
        duration: frameDuration
    }
    PropertyAction {
        target: target
        property: "source"
        value: "./images/skull4.png"
    }
    PauseAnimation {
        duration: frameDuration
    }
    PropertyAction {
        target: target
        property: "source"
        value: "./images/skull5.png"
    }
    PauseAnimation {
        duration: frameDuration
    }
    PropertyAction {
        target: target
        property: "source"
        value: "./images/skull6.png"
    }
    PauseAnimation {
        duration: frameDuration
    }
    PropertyAction {
        target: target
        property: "source"
        value: "./images/skull7.png"
    }
    PauseAnimation {
        duration: 2 * frameDuration
    }
    PropertyAction {
        target: target
        property: "source"
        value: "./images/skull9.png"
    }
    PauseAnimation {
        duration: 2 * frameDuration
    }
    PropertyAction {
        target: target
        property: "source"
        value: "./images/skull11.png"
    }
    PauseAnimation {
        duration: 2 * frameDuration
    }
    PropertyAction {
        target: target
        property: "source"
        value: "./images/skull13.png"
    }
    PauseAnimation {
        duration: 2 * frameDuration
    }
    PropertyAction {
        target: target
        property: "source"
        value: "./images/skull15.png"
    }
    PauseAnimation {
        duration: 2 * frameDuration
    }
    PropertyAction {
        target: target
        property: "source"
        value: "./images/skull17.png"
    }
    PauseAnimation {
        duration: 2 * frameDuration
    }
    PropertyAction {
        target: target
        property: "source"
        value: "./images/skull19.png"
    }
    PauseAnimation {
        duration: 2 * frameDuration
    }
}
