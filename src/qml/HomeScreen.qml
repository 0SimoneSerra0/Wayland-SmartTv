import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

Item {
    id: home
    focus: true

    property int selectedIndex: 0
    readonly property int columns: 4
    readonly property int totalApps: 8

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
                running: true
                onTriggered:
                    () => {
                        if(timeText.text !== metaData.getTime())
                            timeText.text = metaData.getTime();
                        if(dateText.text !== metaData.getDate())
                            dateText.text = metaData.getDate();
                    }
            }
        }

        ListView {
            id: appList
            x: parent.width * 0.05
            y: front.height + parent.height * 0.05

            width: parent.width * 0.9
            height: parent.height * 0.3   // una porzione dello schermo

            spacing: Math.max(Window.width * 0.07, 50) * 0.2

            orientation: ListView.Horizontal

            keyNavigationEnabled: true

            Component.onCompleted: appList.forceActiveFocus()

            highlightMoveDuration: 100

            preferredHighlightBegin: width * 0.3
            preferredHighlightEnd: width * 0.7
            highlightRangeMode: ListView.StrictlyEnforceRange

            property var oldCurrentItem: null


            onCurrentItemChanged: function(){
                if(oldCurrentItem){
                    oldCurrentItem.scale = 1
                    oldCurrentItem.y = 0;
                }

                currentItem.scale= 1.1
                currentItem.y -= currentItem.height * 0.1;
                oldCurrentItem = currentItem
            }



            Rectangle {
                id: customHighLight

                x: appList.currentItem.x - appList.contentX
                width: appList.currentItem.width
                height: 8
                y: appList.currentItem ? appList.currentItem.height * 1.1 : 0
                color: "white"
                radius: height / 2

                opacity: appList.currentItem.focus ? 1 : 0

                Behavior on x{
                    NumberAnimation {
                        property: "x"
                        duration: appList.highlightMoveDuration
                        easing.type: Easing.InOutQuad
                    }
                }
            }




            function changeCurrentIndex(variation){
                if(appList.currentIndex + variation >= 0 && appList.currentIndex + variation < appList.count){
                    appList.currentIndex += variation
                }
            }

            Keys.onLeftPressed: changeCurrentIndex(-1)
            Keys.onRightPressed: changeCurrentIndex(1)
            Keys.onTabPressed: changeCurrentIndex(1)

            WheelHandler {
                acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad

                onWheel: (event) => {
                             // Orizzontale:
                             if(appList.contentX - event.angleDelta.y > 0)
                             if(appList.contentX - event.angleDelta.y < appList.contentWidth)
                             appList.contentX -= event.angleDelta.y;
                             else
                             appList.contentX = appList.contentWidth;
                             else
                             appList.contentX = 0

                             if(appList.contentX - event.angleDelta.x > 0)
                             if(appList.contentX - event.angleDelta.x < appList.contentWidth)
                             appList.contentX -= event.angleDelta.x;
                             else
                             appList.contentX = appList.contentWidth;
                             else
                             appList.contentX = 0

                             event.accepted = true
                         }
            }

            model: appModel

            delegate: FocusScope {
                width: tile.width
                height: tile.height
                focus: index === appList.currentIndex

                Behavior on y{
                    NumberAnimation {
                        property: "y"
                        duration: 300
                        easing.type: Easing.InOutQuad
                    }
                }

                Rectangle{
                    width: tile.width
                    height: tile.height
                    color: Qt.rgba(0,0,0,0.3)
                    radius: width/10
                    y: -parent.y
                }

                AppTile{
                    id: tile
                    appName: name
                    iconSource: icon
                }
            }
        }


        ListModel{
            id: appModel
            ListElement{
                name: "konsole"
                icon: ""
            }
            ListElement{
                name: "konsole"
                icon: ""
            }
            ListElement{
                name: "konsole"
                icon: ""
            }

            ListElement{
                name: "konsole"
                icon: ""
            }
            ListElement{
                name: "konsole"
                icon: ""
            }
            ListElement{
                name: "konsole"
                icon: ""
            }
            ListElement{
                name: "konsole"
                icon: ""
            }
            ListElement{
                name: "konsole"
                icon: ""
            }
            ListElement{
                name: "konsole"
                icon: ""
            }
            ListElement{
                name: "konsole"
                icon: ""
            }
            ListElement{
                name: "konsole"
                icon: ""
            }
            ListElement{
                name: "konsole"
                icon: ""
            }
        }
    }




    function launchApp(name) {
        console.log("Launching:", name)
        // apri un'app reale, ad esempio Firefox
        if (name === "App 1") {
            Qt.openUrlExternally("firefox") // lancia Firefox
        }
    }
}
