import QtQuick 2.11
import "qrc:/../../../"
import "qrc:/basicComponent"

MyColumn {
    height: parent.height
    width: 200
    color: Define.ivory
    padding: 110
    spacing: 50

    Text{   //
        id: titleId
        width: 195

        text: cppCurrentMusic.titles;
        color: "Tomato"
        font.pointSize: 15
        wrapMode: Text.WordWrap;

        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter

        onTextChanged: {
            font.pointSize = 15;
            while(implicitWidth > width)
            {
                print(implicitWidth, " ", width);
                font.pointSize--;
            }
        }
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
