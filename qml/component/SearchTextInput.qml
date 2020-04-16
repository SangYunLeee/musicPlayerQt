import QtQuick 2.11
import QtQuick.Controls 2.5
import "qrc:/"
import "qrc:/define.js" as Define

MyItem {
    color : Define.lightGreen
    background.opacity: 0.1
    sideLines.visible: true

    signal shearchTextChanged(string text);

    TextField{
        id: id_textField
        height: parent.height
        width: parent.width
        verticalAlignment: TextInput.AlignVCenter
        color: Define.prettyGreen
        leftPadding: 10
        onTextChanged: shearchTextChanged(text);
        font.pointSize: 12
        placeholderText: focus? "" : qsTr("터치하여 리스트 검색")
        placeholderTextColor: "Red";
        background: Rectangle {
                        opacity: 0.2
                        color: id_textField.focus ? Define.YELLOW : "transparent"
                    }
    }
}
