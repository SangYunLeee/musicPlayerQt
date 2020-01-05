import QtQuick 2.0
import "qrc:/"

MyColumn {
    height: parent.height
    width: 200
    color: Define.color_1
    padding: 110
    spacing: 50
    Text{   //
        id: titleId
        width: 180

        text: cppCurrentMusic.titles;
        color: "Tomato"
        font.pointSize: 15
        wrapMode: Text.WordWrap;

        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter

    }
    Text{
        id: artistId
        width: 180

        text: cppCurrentMusic.author
        font.pointSize: 13
        color: "DarkGreen"
        wrapMode: Text.WordWrap;

        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
