import QtQuick
import QtWebEngine

Item{
    id: root

    anchors.fill: parent

    required property string url


    Component.onDestruction: webUtils.viewDestroyed()

    Rectangle{
        id: toolBar

        width: root.width
        height: Math.max(root.height * 0.02, 50)
        color: "black"

        Image{
            source: "../../rsc/icons/home-dark.png"
            height: parent.height * 0.7
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: parent.verticalCenter

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.destroy()
            }
        }

    }

    WebEngineView {
        id: webView

        anchors.top: toolBar.bottom
        anchors.left: root.left
        anchors.right: root.right
        anchors.bottom: root.bottom


        url: root.url

        onLoadingChanged: function(loadRequest) {
            if (loadRequest.errorString)
                console.error(loadRequest.errorString);
        }
    }
}

