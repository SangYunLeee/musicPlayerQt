import QtQuick 2.11
import QtGraphicalEffects 1.0
import "define.js" as Define
Item {
    id: rootId
    width: height
    height: 50
    signal clicked
    property alias color: backgroundId.color
    property alias source: imageId.source
    property alias mirror: imageId.mirror
    property alias imageId: imageId
    property alias mouseArea: mouseAreaId
    property alias rotation: overlayId.rotation

    anchors.verticalCenter: parent.verticalCenter


    //background
    Rectangle {
        LayoutMirroring.enabled: true
        z: -1
        id: backgroundId
        anchors.fill: rootId
        color: "transparent"
        Image {
            id: imageId
            z: 2
            height: rootId.height
            width: rootId.width
            antialiasing: true
            visible: false
        }
        ColorOverlay{
            id: overlayId
            anchors.fill: imageId
            source:imageId
            color:Define.YELLOW
            antialiasing: true
        }
    }
    MouseArea {
        id:mouseAreaId
        anchors.fill: parent
        onClicked: rootId.clicked()
    }
}
