import QtQuick 2.0
import "../../../commonComponents"

Item {
    id: thumbnailImage
    property var thumbnailUrl: "thumbnailUrl"
    property var title: "No title"
    width: appStyle.relativeXBasedOnFHD(appStyle.gridViewSize)
    height: appStyle.relativeYBasedOnFHD(appStyle.gridViewSize)

    Image {
        id: fileImage
        anchors.centerIn: parent.center
        width: parent.width * 0.8
        height: parent.height * 0.8
        source: thumbnailUrl
        sourceSize.width: parent.width * 0.8
        asynchronous: true
        NoImage {
            anchors.centerIn: parent.center
            width: parent.width
            height: parent.height
            src: title == "" ? "No title" : title
            visible: fileImage.status != Image.Ready
        }
    }

    Text {
        anchors.top: fileImage.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: appStyle.relativeYBasedOnFHD(5)
        anchors.left: parent.left
        width: fileImage.width
        text: title
        color: appStyle.appColor.mainTextColor
        font: appStyle.engFont.mainFont24
        elide: Text.ElideRight
    }
}
