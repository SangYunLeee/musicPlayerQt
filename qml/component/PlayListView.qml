import QtQuick 2.11
import "qrc:/../../../"
import "qrc:/basicComponent/define.js" as Define
import "qrc:/basicComponent"
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
        color: Define.ivory

        //Title
        Rectangle {
            id: id_title
            height: 65
            width: parent.width
            color: Define.ivory
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

        //Imformation ListView
        ListView {
            id: listViewId
            signal changeListBar(int contentY);
            clip: true
            width: rootId.width
            height: parent.height - id_title.height - id_searchTextInput.height
            delegate: delegateId
            model: cppMusicList.inputList
            highlight: Rectangle{
                color: "red"
                width: 20
                height: 20
            }

            onChangeListBar: print("onChangeListBar");

            MouseArea {
                anchors.fill: parent
                z: -1
                onClicked: {
                    console.log("listViewId pressed")
                    keyController.focus = true
                }
            }
            onContentYChanged: {
                changeListBar(contentY - originY);
            }
            Component.onCompleted: {
                changeListBar.connect(listscb.changeBarY)
            }
            onCurrentIndexChanged: {
                print("currentIndexChanged!!:", currentIndex);

            }
            onModelChanged: {
                if(cppCurrentMusic.url == "url")
                {
                    cppMusicController.changeCurrentMusicIndex(0);
                    playMusic.play();
                }

                if(currentIndex != 0)
                {
                    print("onModelChanged");
                    currentIndex = 0;
                }
            }
        }
        SearchTextInput{
            id: id_searchTextInput
            height: 30
            width: rootId.width
            onShearchTextChanged: cppMusicController.changedSearchText(text);
        }
    }
    ScrollBarListView {
        id: listscb
        width: 13
        anchors.right: colId.right;
        y: listViewId.y
        targetForScrBar: listViewId
    }

    Component {
        id: delegateId
        Rectangle {
            id: rectId
            color: Define.ivory
            width: listViewId.width
            height: listViewId.height / 13
            border.color: listViewId.currentIndex == index ? Define.YELLOW : "#B9E4C9";
            border.width: 0.6
            property variant myData: model
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
                    rootId.focus = true;
                    listViewId.currentIndexChanged();
                    cppMusicController.changeCurrentMusicIndex(index);
                    playMusic.play();
                    keyController.focus = true;
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
