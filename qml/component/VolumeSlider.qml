import QtQuick 2.11
import "qrc:/../../../"
import "qrc:/basicComponent/define.js" as Define
import "qrc:/basicComponent"

MyItem {
    id: id_soundBar
    width: 30
    height: parent.height

    color: Define.ivory
    sideLines.visible: true

    property real volume : id_slider.gauge

    SliderBarVertical{
        id: id_slider
        width: 15
        height: 80
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 13
    }

    MyButton {
        height: 20
        width: 20
        source: "/music_sound.svg"

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
    }

    Component.onCompleted:{
        sideLines.leftLine.width = 1
    }
}