import QtQuick
import QtQuick.Controls

Rectangle {
    id: tile
    width: Math.max(Window.width * 0.07, 50)
    height: width
    radius: width * 0.1
    color: highlighted ? "#555" : (hovered ? "#333" : "#222")
    border.color: highlighted ? "#00adee" : (hovered ? "#fff" : "transparent")
    border.width: 2

    property string appName
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
        onEntered: tile.hovered = true
        onExited: tile.hovered = false
        onClicked: tile.launched("WAYLAND_DISPLAY=wayland-1 QT_WAYLAND_SHELL=ivi QT_IVI_SURFACE_ID=100 /bin/konsole")
    }
}
