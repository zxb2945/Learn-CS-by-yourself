import QtQuick 2.0
import QtQuick.Controls 2.15

Rectangle {

    MouseArea{
        property real xmouse
        property real ymouse
        anchors.fill: parent

        onPressed: {
                    xmouse=mouse.x
                    ymouse=mouse.y
                }

        onPositionChanged: {
            parentObj.x=parentObj.x+(mouse.x-xmouse)
            parentObj.y=parentObj.y+(mouse.y-ymouse)
        }
    }

    Image {
        id: titleIcon
        source: "qrc:/images/Hero.jpg";
        width: parent.height-15
        height: parent.height-15
        anchors{
            left: parent.left
            leftMargin: 5
            verticalCenter: parent.verticalCenter
        }
    }

    Label{
        id:titleLabel
        anchors{
            left: titleIcon.right
            leftMargin: 5
            verticalCenter: parent.verticalCenter
        }
        text: "Music Player"
        color: "black"
        font{
            family: "Microsoft YaHei"
            pixelSize: 20
        }
    }

    Button{
        id:closeBtn;
        anchors{
            right: parent.right
        }
        anchors.verticalCenter: parent.verticalCenter
        background: Rectangle{
            color: {
                if(closeBtn.pressed && closeBtn.hovered)
                    return "black"
                if(closeBtn.hovered)
                    return "white"
                else
                    return "grey"
            }
        }

        contentItem: Label{
            text: "QUIT"
            font{
                family: "Microsoft YaHei"
                pixelSize: 20
            }
            color: "black"
        }

        onClicked: {
            Qt.quit()
        }
    }

}
