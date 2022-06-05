import QtQuick 2.0

Rectangle {

    MouseArea{
        property real xmouse;
        property real ymouse;
        anchors.fill: parent

        onPressed: {
                    xmouse=mouse.x;
                    ymouse=mouse.y;
                }

        onPositionChanged: {
            parentObj.x=parentObj.x+(mouse.x-xmouse);
            parentObj.y=parentObj.y+(mouse.y-ymouse);
        }
        onDoubleClicked: {
            maxBtn.onClicked();
        }
    }

}
