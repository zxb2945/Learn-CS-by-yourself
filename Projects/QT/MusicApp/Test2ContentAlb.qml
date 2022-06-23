import QtQuick 2.0

Rectangle {
    property string songText;
    property string artistText;
    property string imagePathText;

    color: "black"

    Text {
        id: text1
        anchors.horizontalCenter: parent.horizontalCenter
        y: 306
        color: "white"
        text: songText
        font.pixelSize: 20
    }

    Text {
        id: text2
        anchors.horizontalCenter: parent.horizontalCenter
        y: 336
        color: "white"
        text: artistText
        font.pixelSize: 20
    }

    Image {
        id: image
        anchors.horizontalCenter:  parent.horizontalCenter;
        y: 42
        width: 250
        height: 250
        fillMode: Image.PreserveAspectFit
        source: imagePathText
    }

}
