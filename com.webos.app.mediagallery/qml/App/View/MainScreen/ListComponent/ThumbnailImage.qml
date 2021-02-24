import QtQuick 2.0
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
    }
}
