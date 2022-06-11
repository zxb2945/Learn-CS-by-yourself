import QtQuick 2.0
import QtQuick.Controls 2.2

Rectangle{
    width: parent.width
    height: 55
    color: "white"

    Rectangle{
        id:border__
        anchors.top: parent.top
        width: parent.width
        height: 1
        color: "black"
    }

    Button{
        id:playBtn;
        anchors{
            left: parent.left
            leftMargin: 20
            verticalCenter: parent.verticalCenter
        }
        width: 50
        height:width

        background: Rectangle{
            radius: width/2
            color: {
                if(playBtn.pressed || playBtn.hovered)
                    return "green"
                else
                    return "grey"
            }
        }

        contentItem: Label{
            text: "Play"
            font{
                family: "Microsoft YaHei"
                pixelSize: 20
            }
            color: "black"
        }


// maybe we could use libZPlay libary to complete this model
// like click to invoke a play function
//        onClicked: {
//
//        }
    }

    Slider {
        id: sliderControl;
        anchors{
            left: playBtn.right
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        from: 0
        value: 00
        to: 100

        //use signal and slot connected by C++ playing soucrce to update position
    }

// add volume control

}
