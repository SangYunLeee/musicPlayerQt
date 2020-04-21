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

    //Upper
    AlbumInfo {
        id: upperId
        height: 340
        width: playerColumnId.width
        color: Define.lightGreen
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

    //Music Controller
    MusicController {
        height: parent.height - upperId.height - middleId.height
        width: parent.width
    }
}
