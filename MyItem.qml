import QtQuick 2.0
import "define.js" as Define

Item {
    id: rootId
    property alias color: backgroundId.color
    property alias background: backgroundId
    property alias sideLines: id_sideLines

    //background
    Rectangle {
        z: -1
        id: backgroundId
        anchors.fill: rootId
        color: "Khaki"
    }
    Item{
        id: id_sideLines
        anchors.fill: parent
        visible: false
        Rectangle {
            id: id_topLine
            anchors.top: parent.top
            color: Define.lightGreen
            width: id_sideLines.width
            height: 1
        }
    }
}
