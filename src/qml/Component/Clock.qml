import QtQuick 2.15

Text {
    id: root

    text: backEnd.getTime()

    font.pointSize: root.fontSize
    font.family: "Lato"
    color: backEnd.palette().textColor

    Connections{
        target: backEnd
        enabled: root.visible

        function onUpdateTime(new_time){
            root.text = new_time
        }
    }
}
