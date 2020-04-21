import QtQuick 2.11
import "qrc:/../../../"
import "qrc:/basicComponent/define.js" as Define
import "qrc:/basicComponent"

Item {
    id: prograssBar
    width: 150
    height: 30
    property alias fiilbar: fillBar
    signal passingCurrnetTime(var currentTime)
    //length of time
    property real lengthOfTime : 30
    property real currentTime: 0

    //ratio
    property real ratio: playMusic.position / playMusic.duration

    //main stick
    Rectangle {
        id: mainRect
        color: "blue"
        width: parent.width
        height: parent.height
        opacity: 0.1

        MouseArea {
            id: mouseAreaId
            anchors.fill: parent
            drag.target: unvisibleId
            onPressed: {
                prograssBar.currentTime = ( mouseAreaId.mouseX -mainRect.x)/mainRect.width * lengthOfTime;
            }
            onReleased:
                passingCurrnetTime(prograssBar.currentTime*1000);
        }
        Item{
            id: unvisibleId
            visible: false
            onXChanged:{
                if(mouseAreaId.mouseX > mainRect.x
                        &&
                        mouseAreaId.mouseX < mainRect.x + mainRect.width)
                {
                        prograssBar.currentTime = ( mouseAreaId.mouseX -mainRect.x)/mainRect.width * lengthOfTime;
                }
                passingCurrnetTime(prograssBar.currentTime*1000);
            }
        }
    }

    //filling block
    Rectangle {
        id: fillBar
        width: ratio * prograssBar.width
        height: mainRect.height
        color: Define.prettyGreen
    }

    //present progress
    Text {
        visible: false
        id: sliderValue
        text: playMusic.position
        anchors.right: mainRect.right
        anchors.leftMargin: 3
    }
}
