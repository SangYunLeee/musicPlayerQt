import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 1.4
import QtMultimedia 5.8

import "define.js" as Define

//import io.qt.examples.backend 1.0
Window {
    property string path: "" //"file:///home/sori/Desktop/qtProject/musicPlayer/image/"
    id: rootId
    visible: true
    width: 800
    height: 480
    title: qsTr("Hello World")
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2

    //rootRow
    MyRow {
        visible: true
        id: rootRowId
        height: rootId.height
        width: rootId.width

        //Player
        MyColumn {
            id: playerColumnId
            width: rootId.width - listViewId.width
            height: rootId.height
            color: Define.color_1


            //Upper
            MyRow {
                id: upperId
                height: 340
                width: playerColumnId.width
                color: Define.lightGreen
                //Image
                Item {
                    height: parent.height
                    width: parent.width - 200
                    Image {
                        id: imageId
                        anchors.centerIn: parent
                        height: parent.height * 4 / 5
                        width: parent.width * 4 / 5
                    }
                }
                //Imformation about Music
                MyColumn {
                    height: parent.height
                    width: 200
                    color: Define.color_1
                    padding: 110
                    spacing: 50
                    Text{
                        width: 180
                        id: titleId
                        text: "artist"
                        horizontalAlignment: Text.AlignHCenter
                        color: "Tomato"
                        font.pointSize: 15
                        anchors.horizontalCenter: parent.horizontalCenter
                        wrapMode: Text.WordWrap;
                        MouseArea{
                            anchors.fill: parent
                            drag.target: middleId.fiilbar
                        }
                    }
                    Text{
                        id: artistId
                        width: 180
                        text: "title"
                        font.pointSize: 13
                        color: "DarkGreen"
                        anchors.horizontalCenter: parent.horizontalCenter
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode:
                            Text.WordWrap;
                    }
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
                        source: "open.svg"
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
                        source: "back.svg"
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
                            console.log("start Btn");
                            if(start){
                                source = "start.svg";
                                start = false;
                                middleId.running = false
                                playMusic.pause();
                            }
                                else {
                                source = "pause.svg";
                                start = true;
                                middleId.running = true
                                 playMusic.play();
                            }
                        }
                        source:"start.svg"
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

                        }
                        source:"back.svg"
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
        Rectangle{
            color: Define.lightGreen
            height: listViewId.height;
            width: 1;
            opacity: 0.6;
        }

        //PlayerList
        PlayListView {
            id: listViewId
            height: rootRowId.height
            width: 260
            Component.onCompleted:
                listViewId.changee.connect(listItemClicked);
        }
    }
    function listItemClicked( artist, title, url ){
        artistId.text = artist;
        titleId.text = title;
        playMusic.source = "file:///" + url;
        print("clicked Item source :" + playMusic.source );
        playMusic.play();
        startBtnId.source = "pause.svg";
        startBtnId.start = true;
        imageId.source = CppMusicList.setImageFile(url);
    }
    FolderDialog {
        id: folderDialogId
        onAccepted: {
            path =  folderDialogId.folder.toString() + "/"
            CppMusicList.inputMusicList(folderDialogId.folder);
            listItemClicked(listViewId.listId.model[listViewId.listId.currentIndex].author
                            ,listViewId.listId.model[listViewId.listId.currentIndex].titles
                            ,listViewId.listId.model[listViewId.listId.currentIndex].url);
            print(path);


        }
    }
    MediaPlayer {
        id: playMusic
        source: ""
        onDurationChanged: {
            middleId.running=true
            middleId.fiilbar.width = 0;
            middleId.currentTime = 0;
            middleId.lengthOfTime =  playMusic.duration/1000;
        }
        onStatusChanged: {
            print("playMusic.status: " + status);
            if(status == 7 ){  // 7 == "EndOfMedia"
               print("sourc has ended");
               startBtnId. source = "start.svg";
               startBtnId. start = false;
               middleId.running = false
            }
        }

    }
//    Component.onCompleted:{
//        CppMusicList.inputMusicList(path);
//        if(listViewId.listId.count >= 1)
//            listItemClicked(listViewId.listId.model[listViewId.listId.currentIndex].author,listViewId.listId.model[listViewId.listId.currentIndex].titles,listViewId.listId.model[listViewId.listId.currentIndex].url);
//    }

}
