// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtWayland.Compositor
import QtWayland.Compositor.IviApplication
import QtQuick.Window
import QtWebEngine

import "dynamicUtils.js" as DynamicUtils

import "Component"

WaylandCompositor {
    id: compositor

    socketName: backEnd.getSocketName();

    property var currentSurface: null

    WebEngineProfile {
        id: persistentProfile
        persistentCookiesPolicy: WebEngineProfile.ForcePersistentCookies
        persistentStoragePath: backEnd.getWebDataPath()
        cachePath: backEnd.getWebDataPath() + "cache/"
        httpCacheType: WebEngineProfile.DiskHttpCache
    }

    WaylandOutput {
        sizeFollowsWindow: true

        window: Window {
            id: mainWindow
            width: 1024
            height: 768
            visible: true

            ToolBar{
                id: toolBar
                height: parent.height * 0.1
                z: 1
            }

            HomeScreen{
                id: home
                anchors.fill: parent

                onVisibleChanged: visible ? forceActiveFocus() : null;
            }

            Shortcut{
                sequence: "Ctrl+Q"
                onActivated: {
                    destroySurface();
                }
            }

            Shortcut{
                sequence: "Alt+M"
                onActivated: {
                    toolBar.hide = !toolBar.hide
                }
            }

            function destroySurface(){
                if(compositor.currentSurface && compositor.currentSurface !== home){
                    compositor.currentSurface.destroy();
                }
            }
        }
    }

    Component {
        id: chromeComponent
        ShellSurfaceItem {
            anchors.fill: parent
            onSurfaceDestroyed: {
                destroy()
            }

            Component.onDestruction: home.visible = true

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
                var item = chromeComponent.createObject(mainWindow, { "shellSurface": iviSurface } );
                home.visible = false;
                item.handleResized();
                item.forceActiveFocus();

                compositor.currentSurface = item;
            }
    }

    Connections{
        target: backEnd
        function onCreateBrowserSurface(default_url){
            DynamicUtils.renderBrowser(default_url, mainWindow);
            home.visible = false;
        }
        function onGoHome(){
            mainWindow.destroySurface();
        }
    }
    Connections{
        target: webUtils
        function onViewDestroyed(){
            home.visible = true;
            compositor.currentSurface = home;
        }
    }
}
