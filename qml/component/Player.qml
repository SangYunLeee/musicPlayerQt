import QtQuick 2.11
import QtMultimedia 5.8
import CppEnums 1.0
import "qrc:/../../../"
import "qrc:/basicComponent/define.js" as Define
import "qrc:/basicComponent"

MyColumn {
    id: playerColumnId
    width: rootId.width - listViewId.width
    height: rootId.height
    color: Define.ivory

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
                visible: imageId.source == ""
                anchors.centerIn: parent
                text: qsTr("이미지 없당")
                color: Define.YELLOW
                font.pixelSize: 20
            }
        }
        //Imformation about Music
        AlbumImformation {
            height: parent.height
            width: 200
            color: Define.ivory
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


        MyRow{
            anchors.fill: parent
//            Text{
//                id: openBtnPreviewId
//                text: qsTr("폴더를 선택하시면 돼요~")
//                color: "DarkGreen"
//                anchors.bottom: bottomButtonsId.top
//                x: bottomButtonsId.x + buttonId.x - openBtnPreviewId.implicitWidth / 2 + buttonId.width / 2
//                visible: buttonId.mouseArea.containsMouse
//            }
            Item {
                width: parent.width - id_extraSide.width - id_soundBar.width
                height: parent.height
                MyRow{
                    id: bottomButtonsId
                    height: buttonId.height
                    width: buttonId.width * buttonNum + spacing * (buttonNum - 1)
                    color: "transparent"
                    spacing: 30
                    anchors.centerIn: parent
                    property int buttonNum: 5

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
                            playMusic.previousPlay();
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
                        rotation: 180
                        onClicked:{
                            print("back Btn");
                            playMusic.nextPlay();
                        }
                        source:"/back.svg"

                        states: State {
                            name: "moved"; when: fowardId.mouseArea.pressed
                            PropertyChanges { target: fowardId; x: 230; }
                        }
                        transitions: Transition {
                            NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad }
                        }
                    }

                    MyButton {
                        id: id_repeat
                        height: 42
                        onClicked:{
                            print("repeat Button Clicked");
                            print("cppMusicController.repeatType: ",cppMusicController.repeatType);
                            print("sss:", Enums.REPEATE_ALL);
                            switch(cppMusicController.repeatType)
                            {
                                case Enums.REPEATE_ALL:
                                    cppMusicController.repeatType = Enums.REPEATE_NO;
                                    print(1111);
                                    break;
                                case Enums.REPEATE_NO:
                                    print(2222);
                                    cppMusicController.repeatType = Enums.REPEATE_ONE;
                                    break;
                                case Enums.REPEATE_ONE:
                                    print(3333);
                                    cppMusicController.repeatType = Enums.REPEATE_ALL;
                                    break;
                            }
                        }
                        source:
                            switch(cppMusicController.repeatType)
                            {
                                case Enums.REPEATE_ALL:
                                    return "/repeat_all.svg";
                                case Enums.REPEATE_NO:
                                    return "/repeat_no_1.svg";
                                case Enums.REPEATE_ONE:
                                    return "/repeat_one_1.svg";
                                default:
                                    return "/repeat_one_1.svg";
                            }
                    }
                }

            }
            MyItem {
                id: id_extraSide
                width: 0
                height: parent.height

                color: Define.lightGreen
                sideLines.visible: true

                Component.onCompleted:{
                    sideLines.leftLine.width = 1
                }
            }
            MyItem {
                id: id_soundBar
                width: 0
                height: parent.height

                color: Define.ivory
                sideLines.visible: true

                Component.onCompleted:{
                    sideLines.leftLine.width = 1
                }
            }
        }

        }

}
