import QtQuick 2.0

Rectangle {
    property color backGroundColour: "#f3f3f5";  //边框颜色
    color: backGroundColour

//    ButtonGroup{
//        id:narBarBtngroup
//
//    }

//    ListView {
//         width: 240; height: 320
//         model: SongList {}

//         delegate: Rectangle {
//             width: 100; height: 30
//             border.width: 1
//             color: "lightsteelblue"
//             Text {
//                 anchors.centerIn: parent
//                 text: name
//             }
//         }

//         add: Transition {
//             NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
//             NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
//         }

//         displaced: Transition {
//             NumberAnimation { properties: "x,y"; duration: 1; easing.type: Easing.OutBounce }
//         }

//         clip:true
//         focus: true
//         Keys.onSpacePressed: model.insert(0, { "name": "Item " + model.count })
//     }



    ListView {
        id: songListPanel
        width: parent.width
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        model: SongList{}
        delegate: Test2ContentNavBtn { songText: title; artistText: "安室奈美恵"; imagePathText: "images/"+imagePath; }

        flickableDirection: Flickable.AutoFlickDirection
        clip:true
        spacing: 5
        focus: true
    }

//    ListView {
//            id: navbarListView
//            width: parent.width
//            anchors.top: parent.top
//            anchors.bottom: parent.bottom
//            model: navbarListmodel
//            delegate: NavBarBtn { symbolText: symbolText_; itemText: itemText_;fontfamily:fontfamily_;}
//
//            section.property: "type"
//            section.criteria: ViewSection.FullString
//            section.delegate: sectionHeading
//
//            ScrollBar.vertical: ScrollBar{
//
//            }
//
//        }




//    function navBarBtnClicked(name)
//    {
//        var aaa = narBarBtngroup.buttons.length;
//        for(var i=0;i<narBarBtngroup.buttons.length;++i)
//        {
//            if(name!==narBarBtngroup.buttons[i].itemText)
//                narBarBtngroup.buttons[i].setCurrentItemState(false);
//            else
//                narBarBtngroup.buttons[i].setCurrentItemState(true);
//        }
//    }
//
//    Component{
//        id:sectionHeading
//        Rectangle{
//            width: navbarListView.width
//            height: 30*dp
//            color: backGroundColour
//            Label {
//                anchors.left: parent.left
//                anchors.leftMargin: 10
//                anchors.top: parent.top
//                anchors.topMargin: 3*dp
//                anchors.bottom: parent.bottom
//                text: section == "top" ? "":section
//                font{family:"Microsoft YaHei"; pixelSize: 11*dp}
//                verticalAlignment:Label.AlignVCenter;
//                color: "#999999"
//            }
//
//        }
//    }
}
