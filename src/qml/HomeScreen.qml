import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

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

        Text{
            id: timeText
            x: (parent.width - width)/2
            y: height/2
            text: metaData.getTime()

            font.pointSize: parent.width*0.15
            font.family: "Lato"
            color: "white"
        }
    }

    Rectangle{
        id: main
        width: parent.width
        height: parent.height
        color: "#0c1114"


        Rectangle{
            id: front
            color: Qt.lighter(parent.color)
            width: parent.width
            height: 200


            Text{
                id: dateText
                anchors.right: front.right
                anchors.bottom: front.bottom
                text: metaData.getDate()

                font.pointSize: Math.max(Window.width*0.01, 11)
                color: "white"
            }

            Timer{
                interval: 30000
                repeat: true
                running: root.visible
                onTriggered:
                    () => {
                        if(timeText.text !== metaData.getTime())
                            timeText.text = metaData.getTime();
                        if(dateText.text !== metaData.getDate())
                            dateText.text = metaData.getDate();
                    }
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
