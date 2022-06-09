import QtQuick 2.0
//import QtQuick.Window 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    id:startwindow
    visible: true
    width: 640
    height: 580
    title: qsTr("Music Player")
//    flags:Qt.FramelessWindowHint | Qt.Window;
    flags:Qt.FramelessWindowHint


//    Test1Window{}
    Test2Window{
        parentObj:startwindow  //for moving the whole window
    }

}
