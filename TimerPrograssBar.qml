import QtQuick 2.11
import "define.js" as Define
Item {
    id: prograssBar
    width: 150
    height: 30
    property alias running: timer.running
    property alias fiilbar: fillBar
    signal passingCurrnetTime(var currentTime)
    //length of time
    property real lengthOfTime : 30
    property real currentTime: 0

    //ratio
    property real ratio: currentTime / lengthOfTime

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
                fillBar. width = ratio * prograssBar.width;
            }
            onReleased:
                passingCurrnetTime(prograssBar.currentTime*1000);



        }
        Item{
            id: unvisibleId
            visible: false
            onXChanged:
                if(mouseAreaId.mouseX > mainRect.x
                        &&
                        mouseAreaId.mouseX < mainRect.x + mainRect.width)
                {
                        prograssBar.currentTime = ( mouseAreaId.mouseX -mainRect.x)/mainRect.width * lengthOfTime;
                    if(!timer.running)
                        fillBar. width = ratio * prograssBar.width
                }



        }
    }

    //filling block
    Rectangle {
        id: fillBar
        width: 0
        height: mainRect.height
        color: Define.prettyGreen

        //fill out until over mainbar
        function fillOut() {
            if (width < prograssBar.width + 1) {
                //print((ratio*100).toFixed(0))
                currentTime += 0.01
                width = ratio * prograssBar.width
            } else {
                timer.running = false
            }
        }
    }

    Timer {
        id: timer
        interval: 10
        running: false
        repeat: true
        onTriggered: fillBar.fillOut()

    }

    //present progress
    Text {
        id: sliderValue
        text: "0"
        anchors.horizontalCenter: mainRect.horizontalCenter
        anchors.left: mainRect.right
        anchors.leftMargin: 3
    }
}
