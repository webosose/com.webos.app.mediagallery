import QtQuick 2.0
import "../../../commonComponents"

Item {
    id: thumbnailImage
    property var thumbnailUrl: "thumbnailUrl"
    Image {
        id: fileImage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: appStyle.relativeXBasedOnFHD(appStyle.gridViewSize)
        height: appStyle.relativeYBasedOnFHD(appStyle.gridViewSize)
        source: thumbnailUrl
        sourceSize.width: appStyle.gridViewSize
        asynchronous: true

        NoImage {
            width: appStyle.relativeXBasedOnFHD(appStyle.gridViewSize)
            height: appStyle.relativeYBasedOnFHD(appStyle.gridViewSize)
            src: title == "" ? "No title" : title
            visible: parent.status != Image.Ready
        }
    }
}
