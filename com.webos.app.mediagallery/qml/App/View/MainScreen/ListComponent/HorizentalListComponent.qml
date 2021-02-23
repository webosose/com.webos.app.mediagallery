import QtQuick 2.0
import QmlAppComponents 0.1
import "../../../commonComponents"

Item {
    id: root

    property var clickAcion: function(index) {}
    property int elementWidth: 200
    property int elementHeight: 200
    property var spacing: 30

    function updateListModel(list) {
        appLog.debug("HorizentalListComponent :: start update List");
        listModel.clear();
        for(var i = 0; i < list.length; i++) {
            var listValue = list[i];
            listModel.append({itemToShow: listValue});
        }
        appLog.debug("HorizentalListComponent :: end update List");
    }

    function setStartIndex(index) {
        horizontalListView.currentIndex = index;
        appLog.debug("HorizentalListComponent :: set start index = " + index);
    }

    Component {
        id: listDelegate

        Item {
            id: base
            width: root.elementWidth
            height: root.elementHeight

            Item {
                id: contenetBase
                anchors.fill: parent
                anchors.verticalCenter: base.verticalCenter
                NoImage {
                    anchors.fill: parent
                    src: itemToShow
                    bgColor: base.ListView.isCurrentItem
                             ? appStyle.appColor.highlightColor
                             : appStyle.appColor.normalMenuBackground
                }
            }
            // indent the item if it is the current item
            states: State {
                name: "Current"
                when:  base.ListView.isCurrentItem
                PropertyChanges {
                    target: contenetBase
                    width: Object.valueOf(contenetBase.width) * 1 + appStyle.relativeYBasedOnFHD(5)
                    height: Object.valueOf(contenetBase.height) * 1 + appStyle.relativeYBasedOnFHD(5)  }
            }
            transitions: Transition {
                NumberAnimation {
                    target: contenetBase
                    properties: "width"; duration: 200 }
                NumberAnimation {
                    target: contenetBase
                    properties: "height"; duration: 200 }
            }

            IconButton {
                anchors.fill:parent
                onClicked: {
                    appLog.debug("FolderList clicked : " + index);
                    horizontalListView.currentIndex = index;
                    clickAcion(index);
                    appLog.warn("currentItem = " + horizontalListView.currentItem  + " / index = " + horizontalListView.currentIndex);
                }
            }
        }
    }

//    Component {
//        id: highlightBar
//        Rectangle {
//            width: 220; height: 200
//            color: "#FFFF88"
//            x: horizontalListView.currentItem.x;
//            z: 2
//            Behavior on x {
//                NumberAnimation {
//                    duration: 500  }
//            }
//        }
//    }

    ListModel {
        id: listModel
    }

    ListView {
        id: horizontalListView
        anchors.fill: parent
        anchors.topMargin: height * 0.1

        orientation: ListView.Horizontal
        spacing: appStyle.relativeXBasedOnFHD(root.spacing)

        delegate: listDelegate
        model: listModel

        focus: true

        populate: Transition {
            NumberAnimation { properties: "x,y"; duration: 1000 }
        }

//        highlight: highlightBar
//        highlight: Rectangle {
//            width: appStyle.gridViewSize
////            anchors.centerIn: base
//            color: "transparent"
//            border.color: "red"
//            border.width: 2
//            z:2
//        }

//        highlightFollowsCurrentItem: false
    }

}
