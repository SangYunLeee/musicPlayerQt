import QtQuick 2.11
import Qt.labs.platform 1.0


    FolderDialog{
        id: fileDialogId
        title: "Please choose a file"

        onAccepted: {
            console.log("You chose: " + fileDialogId.folder)
        }
        onRejected: {
            console.log("Canceled")
        }

    }
