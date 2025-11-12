import QtQuick


Rectangle{
    id: root

    property real widthScaling: 1

    width: Window.width * 0.07 * widthScaling
    height: Window.height

    color: "#11171b"


    HoverHandler{
        onHoveredChanged:
            () => {
                if(hovered)
                    root.widthScaling = 1.5;
                else
                    root.widthScaling = 1;
            }
    }

    Behavior on width{
        NumberAnimation {
            property: "width"
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }
}

