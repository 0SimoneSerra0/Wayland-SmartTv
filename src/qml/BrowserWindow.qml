import QtQuick
import QtWebEngine

Item{
    id: root

    anchors.fill: parent

    required property string url


    Component.onDestruction: webUtils.viewDestroyed()

    WebEngineView {
        id: webView

        anchors.fill: parent


        url: root.url

        profile: persistentProfile

        onLoadingChanged: function(loadRequest) {
            if (loadRequest.errorString)
                console.error(loadRequest.errorString);
        }
    }
}

