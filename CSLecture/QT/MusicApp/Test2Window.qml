import QtQuick 2.0
import QtQuick.Controls 2.12


Page {
    property QtObject parentObj

    id:root;
    anchors.fill: parent;
    //边框
//    background: Rectangle{
//        anchors.fill: parent;
//        border{
//            color: borderColor;
//            width: 5*dp
//        }
//    }

    Test2Tile{
        id:test2Tile
        height: 50;
        anchors{
            left: parent.left
            leftMargin: 1
            right: parent.right
            rightMargin: 1
            top:parent.top
            topMargin: 1
        }
    }

    Test2Content{

    }
}
