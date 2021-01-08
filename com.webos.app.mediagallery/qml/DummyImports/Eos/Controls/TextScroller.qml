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

    property Text scrolledText
    property bool canAccessScrolledText: scrolledText && scrolledText.contentWidth && root.width
    property real textMargin: 0
    property bool scrolling: false
    property real scrollingSpeed: 0.03
    property bool alignLeft: false
    property real elideWidth: 30
    property bool exceedsWidth: canAccessScrolledText && scrolledText.contentWidth > (root.width - textMargin)
    property bool isRTL: false

    Component.onCompleted: alignText();
    Connections {
        target: scrolledText
        onTextChanged: alignText()
    }

    function alignTextToCenter() {
        scrolledText.x = (root.width - scrolledText.width) / 2;
    }

    function alignTextToLeft() {
        scrolledText.x = textMargin;
    }

/*
 *                    +--------+
 *                    |        |
 *                    |        |
 *         +----------+---+    |
 *         |~~text~~~~~~~~|    |
 *         +----------+---+    |
 *         \          |        |
 *          \          --------+
 *           \            |<-->|
 *            \             textMargin
 *             \
 *              \
 *            x=-(scrolledText.contentWidth - (root.with-textMargin)
 */
    function alignTextToRight() {
        scrolledText.x = -(scrolledText.contentWidth - (root.width - textMargin));
    }

    function alignText() {
        if (exceedsWidth && isRTL)
            alignTextToRight();
        else if (exceedsWidth || alignLeft)
            alignTextToLeft();
        else
            alignTextToCenter();
    }

    onCanAccessScrolledTextChanged: {
        scrolledText.parent = root;
        // align to center by default
        alignTextToCenter();
    }

    onIsRTLChanged: {
        alignText();
    }

    onExceedsWidthChanged: {
        alignText();
    }

    height: scrolledText.height

    layer.enabled: exceedsWidth

    layer.effect: ElideShader {
        elideStart: isRTL ? root.width : root.width - elideWidth
        elideEnd: root.width
        elideLeftStart: 0
        elideLeftEnd: isRTL ? elideWidth : 0
    }

    onScrollingChanged: {
        // Reset position when scrolling stops
        if (!scrolling && ( exceedsWidth && isRTL))
            alignTextToRight();
        else if (!scrolling && (exceedsWidth || alignLeft))
            alignTextToLeft();
    }

    SequentialAnimation {
        id: scrollAnimationNormal
        running: exceedsWidth && scrolling && !isRTL
        loops: Animation.Infinite

        PropertyAnimation {
            target: scrolledText
            properties: "x"
            from: scrolledText.x
            to: -scrolledText.contentWidth
            duration: (scrolledText.contentWidth + scrolledText.x) > 0 ?
                      (scrolledText.contentWidth + scrolledText.x) / scrollingSpeed : 0
        }
        PropertyAnimation  {
            target: scrolledText
            properties: "x"
            from: root.width
            to: scrolledText.x
            duration: (root.width - scrolledText.x) > 0 ?
                      (root.width - scrolledText.x) / scrollingSpeed : 0
        }
    }

    SequentialAnimation {
        id: scrollAnimationRTL
        running: exceedsWidth && scrolling && isRTL
        loops: Animation.Infinite

        PropertyAnimation {
            target: scrolledText
            properties: "x"
            from: scrolledText.x
            to: root.width
            duration: root.width - scrolledText.x > 0 ?
                     (root.width - scrolledText.x) / scrollingSpeed : 0
        }
        PropertyAnimation  {
            target: scrolledText
            properties: "x"
            from: -scrolledText.contentWidth
            to: scrolledText.x
            duration: (scrolledText.x + scrolledText.contentWidth) > 0 ?
                      (scrolledText.x + scrolledText.contentWidth) / scrollingSpeed : 0
        }
    }
}
