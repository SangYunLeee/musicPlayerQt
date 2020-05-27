import QtQuick 2.11
import "qrc:/../../../"
import "qrc:/basicComponent/define.js" as Define
import "qrc:/basicComponent"

Item {
    id: prograssBar
    width: 30
    height: 150
    property alias fiilbar: fillBar

    //gauge
    property real gauge: 0.5

    //main stick
    Rectangle {
        id: id_background
        color: "blue"
        width: parent.width
        height: parent.height
        opacity: 0.1

        MouseArea {
            id: mouseAreaId
            anchors.fill: parent
            onPressed: {
                updateGauge();
            }
            onReleased:{
                updateGauge();
            }
            onMouseXChanged: {
                updateGauge();
            }
            function setGauge(gauge_){
                if(gauge_ < 0){
                    gauge_= 0;
                    return;
                }
                if(gauge_ > 1){
                    gauge = 1;
                    return;
                }
                gauge = gauge_;
            }
            function updateGauge(){
                setGauge(( id_background.height  - mouseY )/id_background.height);
                print("gauge:", gauge);
            }
        }
    }

    //filling block
    Rectangle {
        anchors.bottom: parent.bottom
        id: fillBar
        width:  prograssBar.width
        height: gauge * prograssBar.height
        color: Define.prettyGreen
    }

    //present progress
    Text {
        visible: false
        id: sliderValue
        text: playMusic.position
        anchors.right: id_background.right
        anchors.leftMargin: 3
    }
}
