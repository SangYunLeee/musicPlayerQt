import QtQuick 2.0
import "qrc:/define.js" as Define
import "qrc:/"

MyColumn {
    id: playerColumnId
    width: rootId.width - listViewId.width
    height: rootId.height
    color: Define.color_1

    property alias alias_middleId: middleId
    property alias alias_startBtnId: startBtnId
    property alias alias_imageId: imageId



    //Upper
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
                width: height //parent.width * 4 / 5
            }
        }
        //Imformation about Music
        AlbumImformation {
            height: parent.height
            width: 200
            color: Define.color_1
            padding: 110
            spacing: 50
            Text {
                text: qsTr("text")
            }
        }
    }

    //Middle PrograssBar
    TimerPrograssBar {
        id: middleId
        running: startBtnId.start ? true : false
        height: 20
        width: parent.width
        Component.onCompleted: {
            passingCurrnetTime.connect(playMusic.seek);
        }
    }

    Item {
        height: parent.height - upperId.height - middleId.height
        width: parent.width

        MyRow {
            id: bottomButtonsId
            height: buttonId.height
            width: buttonId.width * buttonNum + spacing * (buttonNum - 1)
            color: "transparent"
            spacing: 30
            anchors.centerIn: parent
            property int buttonNum: 4

            MyButton {
                id: buttonId
                height: 40
                onClicked: folderDialogId.open()
                source: "/open.svg"
            }
            MyButton {
                id: backId
                height: 42
                onClicked:{
                    if(listViewId.listId.currentIndex>=1){
                    listViewId.listId.currentIndex--;
                    listItemClicked(listViewId.listId.model[listViewId.listId.currentIndex].author,listViewId.listId.model[listViewId.listId.currentIndex].titles,listViewId.listId.model[listViewId.listId.currentIndex].url)
                    }
                }
                source: "/back.svg"
                states: State {
                    name: "moved"; when: backId.mouseArea.pressed
                    PropertyChanges { target: backId.imageId; x: backId.x-90; }
                }
                transitions: Transition {
                    NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad }
                }
           }

            MyButton {
                id: startBtnId
                property bool start: false
                height:  37
                onClicked:{
                    if(start){
                        start = false;
                    }
                        else {
                        start = true;
                    }
                }
                source: start? "/pause.svg" : "/start.svg"

                onStartChanged: {
                    if(start){
                        middleId.running = true
                         playMusic.play();
                    }
                    else{
                        middleId.running = false
                        playMusic.pause();
                    }
                }
            }

            MyButton {
                id:fowardId
                height: 42
                rotation: 0
                onClicked:{
                    print("back Btn");
                    listViewId.listId.currentIndex++;
                    print(listViewId.listId.model[listViewId.listId.currentIndex].url);
                    listItemClicked(listViewId.listId.model[listViewId.listId.currentIndex].author,listViewId.listId.model[listViewId.listId.currentIndex].titles,listViewId.listId.model[listViewId.listId.currentIndex].url)
                    fire();

                }
                source:"/back.svg"
                imageId.mirror : true
                states: State {
                    name: "moved"; when: fowardId.mouseArea.pressed
                    PropertyChanges { target: fowardId; x: 230; }
                }
                transitions: Transition {
                    NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad }
                }
            }
        }
    }
}
