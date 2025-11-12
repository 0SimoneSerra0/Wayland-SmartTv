// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtWayland.Compositor
import QtWayland.Compositor.IviApplication
import QtQuick.Window

WaylandCompositor {
    //! [wayland output]

    socketName: "wayland-1"

    WaylandOutput {
        sizeFollowsWindow: true
        window: Window {
            width: 1024
            height: 768
            visible: true

            Rectangle {
                id: mainArea
                anchors.fill: parent
                HomeScreen{
                    anchors.fill: parent
                }
            }

        }
    }
    //! [wayland output]
    Component {
        id: chromeComponent
        ShellSurfaceItem {
            anchors.fill: parent
            onSurfaceDestroyed: destroy()
            //! [resizing]
            onWidthChanged: handleResized()
            onHeightChanged: handleResized()
            function handleResized() {
                if (width > 0 && height > 0)
                    shellSurface.sendConfigure(Qt.size(width, height));
            }
            //! [resizing]
        }
    }

    //! [connecting]
    IviApplication {
        onIviSurfaceCreated: (iviSurface) =>  {
            var item = chromeComponent.createObject(mainArea, { "shellSurface": iviSurface } );
            item.handleResized();
        }
    }
    //! [connecting]
}
