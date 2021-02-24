import QtQuick 2.4

QtObject {
    property Item enterItem
    property Item exitItem
    property Item pageStack

    property Component popTransition: PageStackTransition {
            NumberAnimation {
                target: exitItem;
                property: "x"
                from: 0
                to: exitItem ? exitItem.width : 0
                duration: 200;
            }
        }

    property Component pushTransition: PageStackTransition {
        NumberAnimation {
            target: enterItem;
            property: "x"
            from: enterItem ? enterItem.width : 0
            to: 0
            duration: (pageStack && pageStack.length > 1) ? 200 : 0
        }
    }

    property Component replaceTransition
}
