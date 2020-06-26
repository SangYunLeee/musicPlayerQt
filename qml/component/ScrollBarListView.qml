import QtQuick 2.11
import "qrc:/../../../"
import "qrc:/basicComponent/define.js" as Define
import "qrc:/basicComponent"
Item {
    id: scrollBar
    signal changeContentY(var valY)

    width: scroller.width
    height: targetForScrBar ? targetForScrBar.height : 0
    property ListView targetForScrBar

    // ratio more than 1
    property real dragRatio: targetForScrBar ? (targetForScrBar.contentHeight - height) / (height - scrollStick.height) : 0

    function changeBarY(contentY) {
        if (!draggingId.drag.active)
        {
            scrollStick.y = (scroller.height - scrollStick.height)
                    / (targetForScrBar.contentHeight - targetForScrBar.height) * contentY
        }
    }

    Rectangle {
        id: scroller
        color: "blue"
        width: 20
        height: targetForScrBar ?  scrollBar.height : 1
        opacity: 0.1

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("clicked scroller")
            }
        }
    }

    Rectangle {
        id: scrollStick
        width: scroller.width
        height: cppMusicList.size < 1 ? 0 : targetForScrBar.visibleArea.heightRatio * targetForScrBar.height

        visible: cppMusicList.size > 13

        color: Define.prettyGreen
        opacity: 0.8
        radius: 3
        onYChanged: {
            if (draggingId.drag.active)
            {
                var cotentforY = scrollStick.y * dragRatio + listViewId.originY;

                if (cotentforY > listViewId.originY)
                {
                    /*
                    print("contentForY:", cotentforY);
                    print("originY", listViewId.originY);
                    print("listViewId.contentY: ", listViewId.contentY);
                    print("result:", listViewId.contentHeight-listViewId.height);
                    */

                    //over height
                    if(cotentforY>= (listViewId.contentHeight-listViewId.height) + listViewId.originY )
                    {
                        listViewId.positionViewAtEnd();
                    }
                    else
                        listViewId.contentY = cotentforY
                }
                else
                    listViewId.contentY = listViewId.originY
            }
        }

        MouseArea {
            id: draggingId
            anchors.fill: parent
            drag.target: scrollStick
            drag.axis: Drag.YAxis
            drag.minimumY: scroller.y
            drag.maximumY: scroller.height - height
        }
    }
}
