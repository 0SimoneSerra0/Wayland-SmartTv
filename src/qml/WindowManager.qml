import QtQuick
import QtWayland.Compositor

Item {
    id: wm
    anchors.fill: parent

    function addSurface(iviSurface) {
        var view = surfaceComponent.createObject(wm, {
            "surface": iviSurface.surface
        })
        view.anchors.fill = wm // fullscreen for now
    }

    Component {
        id: surfaceComponent
        WaylandQuickItem {
            id: surfaceView
            focusOnClick: true
        }
    }
}
