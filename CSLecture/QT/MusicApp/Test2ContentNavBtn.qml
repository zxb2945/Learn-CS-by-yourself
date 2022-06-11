import QtQuick 2.0
import QtQuick.Controls 2.2

Button{
    property color hoveredColor: "grey"
    property color clickedColor: "black"
    property color normalColor: "white"
    property bool currentItem : false
    property string songText
    property string artistText
    property string imagePathText

    id:navBtn;
//    signal btnClicked();

    width: parent.width;
    height: 60;

    background: Rectangle{
        id:backgroundRect;
        color: hovered?hoveredColor:normalColor
    }


    Image {
        id: image1
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        width: 50
        height: 50
        fillMode: Image.PreserveAspectFit
        source:imagePathText
    }
    Label {
        id: element
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: image1.right
        width: 172
        height: 24
        text: songText
        font.pixelSize: 14
    }
    Label {
        id: element1
        anchors.left: image1.right
        anchors.top: element.bottom
        width: 172
        height: 12
        text: artistText
        verticalAlignment: Text.AlignBottom
        font.pixelSize: 12
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
//            btnClicked();
            root.currentSongName = songText
            root.currentArtistName = artistText
            root.currentAlbulmPath = imagePathText
        }
    }

}
