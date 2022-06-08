import QtQuick 2.0
//import QtQuick.Window 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    id:mainwindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Music Player")
    flags:Qt.FramelessWindowHint | Qt.Window;
//    flags:Qt.FramelessWindowHint


//    Test1Window{}
    Test2Window{
        parentObj: mainwindow
    }

}
