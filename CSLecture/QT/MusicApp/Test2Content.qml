import QtQuick 2.0
import QtQuick.Controls 2.12

Page{
    id:contentWindow

    Test2ContentNav{
        id:navigation;
        width: 244;
        anchors.left: parent.left;
        anchors.top: parent.top;
        anchors.bottom: parent.bottom;
 //       anchors.bottom: footer_.top;
    }
//    Loader{
//        id:mainPage
//        anchors.left: navBar.right;
//        anchors.top: parent.top;
//        anchors.right: parent.right
//        anchors.bottom: footer_.top;
//        source: "qrc:/ContentWindow/Page/LocaMusicPage.qml";
//        }

//    PlayControlWindow{
//        id:footer_
//        anchors.bottom: parent.bottom
//    }
}
