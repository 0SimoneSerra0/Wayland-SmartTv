import QtQuick
import Qt.labs.lottieqt

import "Basics"


ShadowRectangle {
    id: root

    property bool hide: true
    property int animationDuration: 100

    shadowYDisplacement: height * 0.1

    anchors.left: parent.left
    anchors.right: parent.right

    y: hide ? -(height + shadowYDisplacement) : 0

    color: backEnd.palette().secondaryColor

    onHideChanged: function(){
        if(!hide){
            homeAnimation.setCurrentFrame(0);
            homeAnimation.start();
        }
    }

    Behavior on y {
        NumberAnimation {
            duration: root.animationDuration
            easing.type: Easing.InOutQuad
        }
    }

    Rectangle{
        id: homeIconBg

        anchors.verticalCenter: root.verticalCenter
        anchors.horizontalCenter: root.horizontalCenter

        height: root.height * 0.5 * 1.2
        width: height
        radius: width * 0.5

        color: "transparent"

        Behavior on scale {
            NumberAnimation{
                duration: root.animationDuration * 0.5
                easing.type: Easing.InOutQuad
            }
        }

        AnimatedSprite {
            id: homeAnimation
            source: "../../../rsc/sprite-animation/white-home-icon.png"
            loops: 1
            frameCount: 6
            frameWidth: 100
            frameHeight: 100
            frameDuration: 60
            finishBehavior: AnimatedSprite.FinishAtFinalFrame

            anchors.centerIn: parent

            width: parent.width / 1.2
            height: width
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onHoveredChanged: function(){
                if(containsMouse){
                    homeIconBg.color = backEnd.palette().highlightColor;
                    homeIconBg.scale = 1.2;
                }else{
                    homeIconBg.color = "transparent";
                    homeIconBg.scale = 1;
                }
            }

            onClicked: backEnd.goHome();
        }
    }
}
