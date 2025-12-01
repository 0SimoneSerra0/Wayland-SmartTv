import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    width: Math.max(Window.width * 0.07, 50)
    height: width
    radius: width * 0.1
    color: highlighted ? "#555" : (hovered ? "#333" : "#222")
    border.color: highlighted ? "#00adee" : (hovered ? "#fff" : "transparent")
    border.width: 2

    required property string appName
    required property string appProcess
    property string iconSource
    property bool hovered: false
    property bool highlighted: false
    signal launched(string appName)

    Image {
        anchors.centerIn: parent
        source: iconSource
        width: 96
        height: 96
    }

    Text {
        text: appName
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: root.hovered = true
        onExited: root.hovered = false
        onClicked: launchApp()
    }

    function launchApp() {
        if(appProcess.indexOf("browser") === 0){
            backEnd.createBrowserSurface(appProcess.substring(7));
        } else
            backEnd.launchProcess(backEnd.getSocketName(), appProcess);
    }
}
