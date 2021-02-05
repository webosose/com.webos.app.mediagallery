import QtQuick 2.0
import QmlAppComponents 0.1
import "../../../commonComponents"

Item {
    id: root

//    property var getData: function(list) {
//        updateListModel(list);
//    }

    property var clickAcion: function(index) {}

    function updateListModel(list) {
        listModel.clear();
        for(var i = 0; i < list.length; i++) {
            var listValue = list[i];
            listModel.append({itemToShow: listValue});
        }
    }

    Component {
        id: listDelegate

        Item {
            id: base
            width: appStyle.gridViewSize
            height: appStyle.relativeYBasedOnFHD(150)

            Item {
                id: contenetBase
                anchors.fill: parent
                NoImage {
                    anchors.fill: parent
//                    width: appStyle.gridViewSize
//                    height: appStyle.relativeYBasedOnFHD(150)
                    src: itemToShow
                }
            }

            IconButton {
                anchors.fill:parent
                onClicked: {
                    appLog.debug("FolderList clicked : " + index);
                    clickAcion(index);
                }
            }
        }
    }

    ListModel {
        id: listModel
    }

    ListView {
        id: horizontalListView
        anchors.fill: parent
        orientation: ListView.Horizontal
        spacing: appStyle.relativeXBasedOnFHD(10)

        delegate: listDelegate
        model: listModel
    }

}
