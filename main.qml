import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 1.4
import QtMultimedia 5.9

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
                if(listViewId.listId.currentIndex + 1 < listViewId.listId.count)
                    listViewId.listId.currentIndex++;
                else{
                    listViewId.listId.currentIndex = 0;
                }
            }
        }
    }
}
