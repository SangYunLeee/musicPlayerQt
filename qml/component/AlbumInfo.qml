import QtQuick 2.11
import QtMultimedia 5.8
import CppEnums 1.0
import "qrc:/../../../"

import "qrc:/basicComponent/define.js" as Define
import "qrc:/basicComponent"

MyRow {
    id: upperId
    height: 340
    width: playerColumnId.width
    color: Define.lightGreen
    //Music Album Image
    Item {
        id: id_musicImage
        height: parent.height
        width: parent.width - 200
        Image {
            id: imageId
            anchors.centerIn: parent
            height: parent.height * 4 / 5
            width: height
            source: cppCurrentMusic.imageUrl
        }
        Text {
            visible: imageId.source == ""
            anchors.centerIn: parent
            text: qsTr("이미지 없당")
            color: Define.YELLOW
            font.pixelSize: 20
        }
    }
    //Imformation about Music
    AlbumImformationDetail {
        height: parent.height
        width: 200
        color: Define.ivory
        padding: 110
        spacing: 50
    }
}
