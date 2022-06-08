import QtQuick 2.0
import QtQuick.Controls 2.12


Page {
    property QtObject parentObj
//    property color borderColor: "black";
//    property color titleColor:"green";

    id:mainwindow;
    anchors.fill: parent;
    background: Rectangle{
        anchors.fill: parent;
        border{
            color: "black";
            width: 5
        }
    }

    Test2Tile{
        id:test2Tile
        color: "green";
        height: 50;
        anchors{
            left: parent.left
            leftMargin: 2
            right: parent.right
            rightMargin: 2
            top:parent.top
            topMargin: 2
        }
    }

    Test2Content{
        id:test2Content
        anchors{
            top:test2Tile.bottom
            left: parent.left
            leftMargin: 2
            right: parent.right
            rightMargin: 2
            bottom: parent.bottom
            bottomMargin: 2
        }
    }
}
