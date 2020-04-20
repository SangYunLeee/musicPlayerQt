import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 1.4
import QtMultimedia 5.12
import CppEnums 1.0


import "define.js" as Define
import "qrc:/component/qml/component"

//import io.qt.examples.backend 1.0
Window {
    property string path: "" //"file:///home/sori/Desktop/qtProject/musicPlayer/image/"
    property string pathPrefix: "file:///"

    maximumHeight: height
    minimumHeight: height
    maximumWidth:  width
    minimumWidth: width

    MouseArea {
        anchors.fill: parent

        onClicked: {
            console.log("base mouse area pressed")
            focus = true
        }
    }

    id: rootId
    objectName: "rootId"
    visible: true
    width: 800
    height: 480
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2

    //rootRow
    MyRow {

        visible: true
        id: rootRowId
        height: rootId.height
        width: rootId.width

        //Player
        Player {
            id: playerColumnId
            width: rootId.width - listViewId.width
            height: rootId.height
            color: Define.ivory
        }
        //Line
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
        }
    }

    FolderDialog {
        id: folderDialogId
        onAccepted: {
            path =  folderDialogId.folder.toString() + "/"
            cppMusicController.loadedFolderRoute(folder);
            print("QML:FolderDialog onAccepted: ",path);
        }
    }

    MediaPlayer {
        id: playMusic
        source: pathPrefix + cppCurrentMusic.url
        notifyInterval: 100
        onDurationChanged: {
            playerColumnId.alias_middleId.currentTime = 0;
            playerColumnId.alias_middleId.lengthOfTime =  playMusic.duration/1000;
        }
        onStatusChanged: {
            print("playMusic.status: " + status);
            if(status == 7 ){  // 7 == "EndOfMedia"
                print("sourc has ended");
                switch(cppMusicController.repeatType)
                {
                    case Enums.REPEATE_ALL:
                        nextPlay();
                        break;
                    case Enums.REPEATE_NO:
                        break;
                    case Enums.REPEATE_ONE:
                        play();
                        break;
                }
            }
        }
        function nextPlay(){
            if(listViewId.listId.currentIndex + 1 < listViewId.listId.count)
            {
                listViewId.listId.incrementCurrentIndex();
                playCurrentIndex();
            }
            else{
                listViewId.listId.currentIndex = 0;
                playCurrentIndex();
            }
        }
        function previousPlay(){
            if(listViewId.listId.currentIndex>=1){
                listViewId.listId.decrementCurrentIndex();
                playCurrentIndex();
            }
            else{
                listViewId.listId.currentIndex = listViewId.listId.count-1
                playCurrentIndex();
            }
        }
        function playByIndex(index){
            cppMusicController.changeCurrentMusicIndex(index);
            play();
        }
        function playCurrentIndex(){
            cppMusicController.changeCurrentMusicIndex(listViewId.listId.currentIndex);
            play();
        }
    }
}
