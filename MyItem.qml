import QtQuick 2.11
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

        property alias topLine: id_topLine
        property alias bottomLine: id_bottomLine
        property alias leftLine: id_leftLine
        property alias rightLine: id_rightLine

        Rectangle {
            id: id_topLine
            anchors.top: parent.top
            color: Define.lightGreen
            width: id_sideLines.width
            height: 0
        }
        Rectangle {
            id: id_bottomLine
            anchors.bottom: parent.bottom
            color: Define.lightGreen
            width: id_sideLines.width
            height: 0
        }
        Rectangle {
            id: id_leftLine
            anchors.left: parent.left
            color: Define.lightGreen
            width: 0
            height: id_sideLines.height
        }
        Rectangle {
            id: id_rightLine
            anchors.right: parent.right
            color: Define.lightGreen
            width: 0
            height: id_sideLines.height
        }
    }
}
