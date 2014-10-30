import bb.cascades 1.2
import utils.imageLoader 1.0

Container {
    id: container
    property string plataformImage
    property string userImage
    property string avatarUrl
    property string themeColor: _control.themeColor
    signal changeImage()
    onChangeImage: {
        animationStart.play();
        animationEnd.play();
        if (imgUser.visible == true) {
            imgUser.visible = false
            imgTrasition.visible = true;
        } else {
            imgTrasition.visible = false;
            imgUser.visible = true
        }

    }
    Container {
        layout: DockLayout {
        }
        preferredHeight: 150
        preferredWidth: 150
        background: Color.create(themeColor)
        ImageView {
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            imageSource: "asset:///images/TileGradient.png"
            maxWidth: 150
            maxHeight: 150
            preferredHeight: 150
            preferredWidth: 150
        }
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            layout: DockLayout {
            }
            ImageView {
                id: imgTrasition
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                scalingMethod: ScalingMethod.AspectFit
                implicitLayoutAnimationsEnabled: false
                imageSource: plataformImage
                maxWidth: 150
                maxHeight: 150
                preferredHeight: 150
                preferredWidth: 150
                visible: false

            }
            ImageView {
                id: imgUser
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                scalingMethod: ScalingMethod.AspectFit
                preferredHeight: 150
                preferredWidth: 150
                implicitLayoutAnimationsEnabled: false //Only fade in animation is enabled
                imageSource: container.userImage
                attachedObjects: ImageUrlLoader {
                    imageUrl: container.avatarUrl
                    onImageDone: {
                        console.log("image Done")
                    }
                }
            }
        }
    }
    attachedObjects: [
        SequentialAnimation {
            id: animationStart
            animations: [
                ScaleTransition {
                    toY: 0
                    duration: 200
                },
                ScaleTransition {
                    toY: 0
                    duration: 200
                }
            ]

        },
        SequentialAnimation {
            id: animationEnd
            animations: [
                ScaleTransition {
                    toY: 0
                    duration: 200
                },
                ScaleTransition {
                    toY: 1
                    duration: 200
                }

            ]

        }
    ]
}
