import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

import "Component"

Item {
    id: root
    focus: true

    property int selectedIndex: 0
    readonly property int columns: 4
    readonly property int totalApps: 8

    KeyNavigation.down: appList

    SideBar{
        id: sidebar
        z: 100

        Clock{
            id: timeText
            anchors.horizontalCenter: parent.horizontalCenter
            y: height/2
            font.pointSize: Math.max(parent.width*0.18, 11)
        }
    }

    Rectangle{
        id: main
        width: parent.width
        height: parent.height
        color: backEnd.palette().mainColor


        Rectangle{
            id: front
            color: Qt.lighter(parent.color)
            width: parent.width
            height: root.height * 0.4


            Date{
                id: dateText
                anchors.right: front.right
                anchors.bottom: front.bottom

                font.pointSize: Math.max(Window.width*0.01, 11)
            }
        }

        AppList{
            id: appList
            x: parent.width * 0.05
            y: front.height + parent.height * 0.05

            width: parent.width * 0.9
            height: parent.height * 0.3
        }
    }
}
