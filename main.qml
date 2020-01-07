import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 1.4
import QtMultimedia 5.8

import "define.js" as Define
import "qrc:/component/qml/component"

//import io.qt.examples.backend 1.0
Window {
    property string path: "" //"file:///home/sori/Desktop/qtProject/musicPlayer/image/"

    id: rootId
    objectName: "rootId"
    visible: true
    width: 800
    height: 480
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2

    signal fire;

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
            color: Define.color_1

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
            Component.onCompleted:
                listViewId.changee.connect(listItemClicked);
        }
    }

    FolderDialog {
        id: folderDialogId
        onAccepted: {
            path =  folderDialogId.folder.toString() + "/"
            cppMusicController.loadedFolderRoute(folder);
            print(path);
        }
    }

    MediaPlayer {
        id: playMusic
        source: ""
        onDurationChanged: {
            playerColumnId.alias_middleId.running=true
            playerColumnId.alias_middleId.fiilbar.width = 0;
            playerColumnId.alias_middleId.currentTime = 0;
            playerColumnId.alias_middleId.lengthOfTime =  playMusic.duration/1000;
        }
        onStatusChanged: {
            print("playMusic.status: " + status);
            if(status == 7 ){  // 7 == "EndOfMedia"
               print("sourc has ended");
               playerColumnId.alias_startBtnId. start = false;
               playerColumnId.alias_middleId.running = false
            }
        }

    }

    function listItemClicked( artist, title, url ){
        playMusic.source = "file:///" + url;
        print("clicked Item source :" + playMusic.source );
        playMusic.play();
        playerColumnId.alias_startBtnId.start = true;
//        playerColumnId.alias_imageId.source = cppMusicList.setImageFile(url);
    }

}
