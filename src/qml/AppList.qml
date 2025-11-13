import QtQuick

ListView {
    id: root

    spacing: Math.max(Window.width * 0.07, 50) * 0.2

    orientation: ListView.Horizontal

    keyNavigationEnabled: true

    highlightMoveDuration: 100

    preferredHighlightBegin: width * 0.3
    preferredHighlightEnd: width * 0.7
    highlightRangeMode: ListView.StrictlyEnforceRange

    property var oldCurrentItem: null

    onFocusChanged: function() {
        if(focus){
            customHighLight.opacity = 1;
            currentItem.scale = 1.1
            currentItem.y -= currentItem.height * 0.1;
        }else{
            customHighLight.opacity = 0;
            currentItem.scale = 1
            currentItem.y =0;
        }
    }


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

        x: root.currentItem.x - root.contentX
        width: root.currentItem.width
        height: 8
        y: root.currentItem ? root.currentItem.height * 1.1 : 0
        color: "white"
        radius: height / 2

        Behavior on x{
            NumberAnimation {
                property: "x"
                duration: root.highlightMoveDuration
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on opacity {
            NumberAnimation {
                property: "opacity"
                duration: root.highlightMoveDuration
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                targets: [object]
                properties: "name"
                duration: 200
            }
        }
    }




    function changeCurrentIndex(variation){
        if(root.currentIndex + variation >= 0 && root.currentIndex + variation < root.count){
            root.currentIndex += variation
        }
    }

    Keys.onLeftPressed: changeCurrentIndex(-1)
    Keys.onRightPressed: changeCurrentIndex(1)
    Keys.onTabPressed: changeCurrentIndex(1)

    WheelHandler {
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad

        onWheel: (event) => {
                     // Orizzontale:
                     if(root.contentX - event.angleDelta.y > 0)
                     if(root.contentX - event.angleDelta.y < root.contentWidth)
                     root.contentX -= event.angleDelta.y;
                     else
                     root.contentX = root.contentWidth;
                     else
                     root.contentX = 0

                     if(root.contentX - event.angleDelta.x > 0)
                     if(root.contentX - event.angleDelta.x < root.contentWidth)
                     root.contentX -= event.angleDelta.x;
                     else
                     root.contentX = root.contentWidth;
                     else
                     root.contentX = 0

                     event.accepted = true
                 }
    }

    model: appModel

    delegate: FocusScope {
        width: tile.width
        height: tile.height
        focus: index === root.currentIndex

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
            appProcess: process
            iconSource: icon
        }
    }

    ListModel{
        id: appModel
        ListElement{
            name: "konsole"
            process: "/bin/konsole"
            icon: ""
        }
        ListElement{
            name: "konsole"
            process: "/bin/konsole"
            icon: ""
        }
        ListElement{
            name: "konsole"
            process: "/bin/konsole"
            icon: ""
        }

        ListElement{
            name: "konsole"
            process: "/bin/konsole"
            icon: ""
        }
        ListElement{
            name: "konsole"
            process: "/bin/konsole"
            icon: ""
        }
        ListElement{
            name: "konsole"
            process: "/bin/konsole"
            icon: ""
        }
        ListElement{
            name: "konsole"
            process: "/bin/konsole"
            icon: ""
        }
        ListElement{
            name: "konsole"
            process: "/bin/konsole"
            icon: ""
        }
        ListElement{
            name: "konsole"
            process: "/bin/konsole"
            icon: ""
        }
        ListElement{
            name: "konsole"
            process: "/bin/konsole"
            icon: ""
        }
        ListElement{
            name: "konsole"
            process: "/bin/konsole"
            icon: ""
        }
        ListElement{
            name: "konsole"
            process: "/bin/konsole"
            icon: ""
        }
    }
}
