import QtQuick 2.11
import "define.js" as Define
Item {
    id: prograssBar
    width: 150
    height: 30


    //value
    property real val: 100 / (mainRect.width)

    //main stick
    Rectangle {
        id: mainRect
        color: "blue"
        width: parent.width
        height: parent.height
        opacity: 0.1

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("clicked mainRect")
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
                sliderValue.text = (val * width).toFixed(0)

                width++
            } else {
                timer.running = false
            }
        }
    }

    Timer {
        id: timer
        interval: 10
        running: true
        repeat: true
        onTriggered: fillBar.fillOut()
    }

    //present  progress text
    Text {
        id: sliderValue
        text: "0"
        anchors.horizontalCenter: mainRect.horizontalCenter
        anchors.left: mainRect.right
        anchors.leftMargin: 3
    }
}
