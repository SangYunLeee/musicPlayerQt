import QtQuick 2.0
import "qrc:/define.js" as Define
import "qrc:/"
import QtMultimedia 5.8
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
                width: height
                source: cppCurrentMusic.imageUrl
            }
            Text {
                visible: imageId.status == Image.Null
                anchors.centerIn: parent
                text: qsTr("이미지가 읍서용")
                color: Define.YELLOW
                font.pixelSize: 20
            }
        }
        //Imformation about Music
        AlbumImformation {
            height: parent.height
            width: 200
            color: Define.color_1
            padding: 110
            spacing: 50
        }
    }

    //Middle PrograssBar
    TimerPrograssBar {
        id: middleId
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
                    }
                    else{
                        listViewId.listId.currentIndex = listViewId.listId.count-1
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
                readonly property bool start: playMusic.playbackState === MediaPlayer.PlayingState ? true : false
                height:  37
                source: start? "/pause.svg" : "/start.svg"
                onClicked:{
                    if(start){
                        playMusic.pause();
                    }
                    else {
                        playMusic.play();
                    }
                }
            }

            MyButton {
                id:fowardId
                height: 42
                rotation: 0
                onClicked:{
                    print("back Btn");
                    if(listViewId.listId.currentIndex + 1 < listViewId.listId.count)
                        listViewId.listId.currentIndex++;
                    else{
                        listViewId.listId.currentIndex = 0;
                    }
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
