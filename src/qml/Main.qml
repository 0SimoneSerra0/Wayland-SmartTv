// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtWayland.Compositor
import QtWayland.Compositor.IviApplication
import QtQuick.Window

import "dynamicUtils.js" as DynamicUtils

WaylandCompositor {
    id: compositor

    socketName: backEnd.getSocketName();

    WaylandOutput {
        sizeFollowsWindow: true
        window: Window {
            id: mainWindow
            width: 1024
            height: 768
            visible: true

            HomeScreen{
                id: home
                anchors.fill: parent

                onVisibleChanged: visible ? forceActiveFocus() : null;
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
        id: iviApp
        onIviSurfaceCreated:
            (iviSurface) =>  {
                var item = chromeComponent.createObject(window, { "shellSurface": iviSurface } );
                home.visible = false;
                item.handleResized();
            }
    }

    Connections{
        target: backEnd
        function onCreateBrowserSurface(default_url){
            DynamicUtils.renderBrowser(default_url, mainWindow);
            home.visible = false;
        }
    }
    Connections{
        target: webUtils
        function onViewDestroyed(){
            home.visible = true;
        }
    }
}
