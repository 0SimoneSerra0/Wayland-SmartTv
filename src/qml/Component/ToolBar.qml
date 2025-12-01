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

    AnimatedSprite {
        id: homeAnimation
        source: "../../../rsc/sprite-animation/white-home-icon.png"
        loops: 1
        frameCount: 6
        frameWidth: 100
        frameHeight: 100
        frameDuration: 60
        finishBehavior: AnimatedSprite.FinishAtFinalFrame

        anchors.verticalCenter: root.verticalCenter

        height: root.height * 0.7
        width: height
    }
}
