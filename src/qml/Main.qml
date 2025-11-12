// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtWayland.Compositor
import QtWayland.Compositor.IviApplication
import QtQuick.Window

WaylandCompositor {

    socketName: metaData.getSocketName();

    WaylandOutput {
        sizeFollowsWindow: true
        window: Window {
            id: window
            width: 1024
            height: 768
            visible: true

            HomeScreen{
                id: home
                anchors.fill: parent

            }

        }
    }

    Component {
        id: chromeComponent
        ShellSurfaceItem {
            anchors.fill: parent
            onSurfaceDestroyed:
                () => {
                    destroy()
                    home.visible = true;
                }

            onWidthChanged: handleResized()
            onHeightChanged: handleResized()
            function handleResized() {
                if (width > 0 && height > 0)
                    shellSurface.sendConfigure(Qt.size(width, height));
            }
        }
    }


    IviApplication {
        onIviSurfaceCreated:
            (iviSurface) =>  {
                var item = chromeComponent.createObject(window, { "shellSurface": iviSurface } );
                home.visible = false;
                item.handleResized();
            }
    }
}
