import QtQuick 2.0
import QtQuick.Controls 2.15

Rectangle {
    property QtObject parentObj

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
        source: "/images/Hero.jpg";
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
        width: 65
        height: parent.height-15
        anchors.verticalCenter: parent.verticalCenter
        background: Rectangle{
            radius: 10
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
            anchors.centerIn : closeBtn
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
