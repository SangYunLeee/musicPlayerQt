import QtQuick 2.11
import "define.js" as Define
Item {
    id: rootId
    width: 100
    height: 100
    property alias model: listViewId.model
    property alias listId: listViewId
    signal changee(var name, var titlee,var url)


    //Column
    MyColumn {
        id: colId;

        width: parent.width
        height: parent.height
        color: "#FFFBE6"

        //Title
        Rectangle {
            id: titleId
            height: 65
            width: parent.width
            color: "#FFFBE6"
            border.color: Define.prettyGreen
            border.width: 0.5
            Text {
                anchors.centerIn: parent
                text: "Music List"
                font.family: "Montserrat";
                color: "#FD5523"//Qt.darker("DimGray", 2)
                font.pointSize: 22
                z: 5
            }
        }

        //Imformation LIstView
        ListView {
            signal changeListBar(int contentY);
            clip: true
            id: listViewId
            width: rootId.width
            height: parent.height - titleId.height
            delegate: delegateId
            model: CppMusicList.inputList
            highlight: Rectangle{
                color: "red"
                width: 20
                height: 20
            }
            //slot for ScrollBar
            function moveUpDown(cotentforY) {
                if (cotentforY < 0)
                    contentY = -cotentforY
                else
                    contentY = 0
            }
            onContentYChanged: {
                changeListBar(contentY);
            }
            Component.onCompleted: {
                changeListBar.connect(listscb.changeBarY)
            }
            onModelChanged: {
                listscb.setup();
            }

        }

    }
    ScrollBarListView {
        id: listscb
        width: 8
        anchors.right: colId.right;
        y: listViewId.y
        targetForScrBar: listViewId
        Component.onCompleted: {
            changeContentY.connect(listViewId.moveUpDown);
        }
    }

    Component {
        id: delegateId
        Rectangle {
            id: rectId
            color: "#FFFBE6"
            width: listViewId.width
            height: listViewId.height / 13
            border.color: listViewId.currentIndex == index ? Define.YELLOW : "#B9E4C9";
            border.width: 0.6
            Text {
                id: textId
                anchors.centerIn: parent
                font.pixelSize: 15
                text: modelData.titles
                color: "#356859"
                z:2
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    listViewId.currentIndex = index;
                    changee(modelData.author, modelData.titles, modelData.url);


            }
            Rectangle{
                visible: listViewId.currentIndex == index ? true : false;
                anchors.fill: parent
                color: Define.YELLOW
                opacity: 0.3
                z:1

            }

            }
            Component.onCompleted: {
                if(textId.implicitWidth > listViewId.width ) {
                    textId.font.pixelSize = 11
                }
            }
        }
    }
}
