import QtQuick 2.15

Text {
    id: root

    text: backEnd.getDate()

    color: backEnd.palette().textColor

    Connections{
        target: backEnd
        enabled: root.visible

        function onUpdateDate(new_date){
            root.text = new_date
        }
    }
}
