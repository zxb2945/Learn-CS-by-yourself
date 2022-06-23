import QtQuick 2.7
import QtQuick.Controls 2.2

Button{
    property color hoveredColor: "grey"
    property color clickedColor: "green"
    property color normalColor: "white"
    property bool currentItem : false
    property string songText
    property string artistText
    property string imagePathText

    id:navBtn;
    signal btnClicked(string name);

    width: parent.width;
    height: 60;
    ButtonGroup.group: navBtngroup

    function navBtnClicked(name)
    {
        var len = navBtngroup.buttons.length;
        for(var i=0;i<navBtngroup.buttons.length;i++)
        {
            if(name!==navBtngroup.buttons[i].songText)
                navBtngroup.buttons[i].setCurrentItemState(false);
            else
                navBtngroup.buttons[i].setCurrentItemState(true);
        }
    }


    background: Rectangle{
        id:backgroundRect;
        color: currentItem ? clickedColor:(hovered?hoveredColor:normalColor)
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
            btnClicked(songText);
            root.currentSongName = songText
            root.currentArtistName = artistText
            root.currentAlbulmPath = imagePathText
        }
    }

    function setCurrentItemState(ok){
        currentItem = ok;
    }

    Component.onCompleted: {
        navBtn.btnClicked.connect(navBtnClicked);
        console.log("test1")
    }

}
