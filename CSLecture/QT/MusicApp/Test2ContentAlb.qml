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
        color: "black"
        text: songText
        font.pixelSize: 20
    }

    Text {
        id: text2
        anchors.horizontalCenter: parent.horizontalCenter
        y: 336
        color: "black"
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

//    function setCurrentItemState(){
//        console.log("test")
//    }


//    Connections{
//        target:songListPanel
//        function onBtnClicked(){
//        console.log("test")
//        }
//    }

//    onBtnClicked: function setCurrentItemState(){
//        console.log("test")
//    }
//    Component.onCompleted: {
//        navBtn.btnClicked.connect(setCurrentItemState);
//    }
}
