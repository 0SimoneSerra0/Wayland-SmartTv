import QtQuick 2.15
import QtQuick.Effects


Item {
    id: root

    property int shadowYDisplacement: 0
    property int shadowXDisplacement: 0
    property color color

    Rectangle{
        id: rectangle
        anchors.fill: parent
        color: root.color
    }
    MultiEffect {
        source: rectangle
        anchors.fill: rectangle
        autoPaddingEnabled: false
        paddingRect: Qt.rect(0, 0, rectangle.width, rectangle.height)
        shadowBlur: 1.0
        shadowColor: 'black'
        shadowEnabled: true
        shadowVerticalOffset: root.shadowYDisplacement
        shadowHorizontalOffset: root.shadowXDisplacement
    }
}
