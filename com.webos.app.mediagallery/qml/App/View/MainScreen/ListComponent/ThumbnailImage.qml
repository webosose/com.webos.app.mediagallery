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

import QtQuick 2.6
import "../../../commonComponents"

Item {
    id: thumbnailImage
    property var thumbnailUrl: "thumbnailUrl"
    width: appStyle.relativeXBasedOnFHD(appStyle.gridViewSize)
    height: appStyle.relativeYBasedOnFHD(appStyle.gridViewSize)

    Image {
        id: fileImage
        anchors.fill: parent
        source: thumbnailUrl
        sourceSize.width: width
        asynchronous: true
    }

    NoImage {
        anchors.fill: parent
        src: title == "" ? "No title" : title
        visible: fileImage.status != Image.Ready
        bgColor: appStyle.appColor.defaultBackground
    }
}
