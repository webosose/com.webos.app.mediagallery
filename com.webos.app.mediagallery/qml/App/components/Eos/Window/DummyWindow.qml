import QtQuick 2.4

Rectangle {
    signal windowCloseRequested
    signal windowStateChanged

    property string title
    property string appId
    property string windowType
    property int locationHint
    property var params
}
