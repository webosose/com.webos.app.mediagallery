import QtQuick 2.4

QtObject {
    property string appId
    property string context
    function info() {}
    function traceBefore(str) { appLog.log(str) }
}
