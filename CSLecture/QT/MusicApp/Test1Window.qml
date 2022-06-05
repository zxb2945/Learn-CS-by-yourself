import QtQuick 2.0

Rectangle {
    id: rectangle
    color: "#ffffff"
    anchors.fill: parent

    Rectangle {
        id: playControl
        anchors.left: songListPanel.right
        width: parent.width - 244
        height: parent.height
        color: "#000000"

        Text {
            id: element12
            anchors.horizontalCenter: parent.horizontalCenter
            y: 306
            color: "#d5d5d5"
            text: qsTr("02 - Show Me What You've Got")
            font.pixelSize: 20
        }

        Text {
            id: element13
            anchors.horizontalCenter: parent.horizontalCenter
            y: 336
            color: "#d5d5d5"
            text: qsTr("安室奈美恵")
            font.pixelSize: 20
        }

        Image {
            id: image
            anchors.horizontalCenter:  parent.horizontalCenter;
            y: 42
            width: 250
            height: 250
            fillMode: Image.PreserveAspectFit
            source: "images/Hero.jpg"
        }

    }

    Component {
        id: contactDelegate
        Rectangle {
            color: "#ffffff"
            width: 180; height: 60
            Image {
                id: image1
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent
                width: 50
                height: 50
                fillMode: Image.PreserveAspectFit
                source: "images/"+imagePath
            }
            Text {
                id: element
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: image1.right
                width: 172
                height: 24
                text: qsTr(title)
                font.pixelSize: 14
            }
            Text {
                id: element1
                anchors.left: image1.right
                anchors.top: element.bottom
                width: 172
                height: 12
                text: qsTr("安室奈美恵")
                verticalAlignment: Text.AlignBottom
                font.pixelSize: 12
            }
//                MediaPlayer{
//                    id:player
//                    source: path
//                }
            MouseArea {
                anchors.fill: parent
//                    onClicked: {
//                        parent.color = 'grey'
//                        player.play()
//                        console.log("hello"+index)
//                    }
                onPressed: {
                    parent.color = 'grey'
                    element.font.pixelSize = 18
                    element1.font.pixelSize = 16
                    image.source = image1.source
                    element12.text = element.text

                }
                onReleased: {
                    parent.color = "#ffffff"
                    element.font.pixelSize = 14
                    element1.font.pixelSize = 12
                }
            }
        }
    }


    ListView {
        id: songListPanel
        x: 0
        y: 0
        width: 244
        height: parent.height
        model: SongList{}
        delegate: contactDelegate

        flickableDirection: Flickable.AutoFlickDirection
//            highlight: Rectangle {
//                color: "grey"
//            }
        spacing: 5
        focus: true
    }
}
