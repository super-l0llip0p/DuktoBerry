import bb.cascades 1.2
import bb.cascades.pickers 1.0

Sheet {
    id: settingsSheet
    Page {
        titleBar: TitleBar {
            kind: TitleBarKind.FreeForm
            kindProperties: CustomFreeFormTitleBar {
                title: qsTr("Settings")
                closeButtonActive: true
                onBackButtonClicked: {
                    _control.buddyName = userName.text
                    settingsSheet.close()
                }
            }
        }
        ScrollView {
            Container {
                topPadding: 20
                leftPadding: 20
                rightPadding: 20
                horizontalAlignment: HorizontalAlignment.Fill
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    Container {
                        background: Color.create(_control.themeColor)
                        ImageView {
                            property string buddyAvatar: _control.buddyAvatar
                            onBuddyAvatarChanged: {
                                imageSource = buddyAvatar
                            }
                            id: imgAvatar
                            imageSource: buddyAvatar
                            preferredHeight: 150
                            preferredWidth: 150
                            leftPadding: 40
                        }
                    }
                    Container {
                        leftPadding: 20
                        verticalAlignment: VerticalAlignment.Center
                        CustomButton {
                            preferredWidth: 400
                            text: qsTr("Change Avatar")
                            onClicked: {
                                newAvatar.open()
                            }
                        }
                    }
                }
                Container {
                    topPadding: 30
                    Label {
                        text: qsTr("User name:")
                    }
                    CustomTextField {
                        id: userName
                        text: _control.buddyName
                    }
                }
                Container {
                    topPadding: 30
                    Label {
                        text: qsTr("Save received file in:")
                    }
                    CustomTextField {
                        text: "/donwloads"
                        txtenabled: false
                    }
                    Container {
                        topPadding: 20
                        horizontalAlignment: HorizontalAlignment.Right
                        CustomButton {
                            preferredWidth: 400
                            actived: false
                            text: qsTr("Change folder")
                        }
                    }
                }
                Container {
                    topPadding: 30
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    Label {
                        text: qsTr("Theme Color:")
                    }
                    Container {
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        Container {
                            preferredHeight: 200
                            preferredWidth: 200
                            background: Color.create(_control.themeColor)
                        }
                        Container {
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Center
                            leftPadding: 40
                            Container {
                                layout: StackLayout {
                                    orientation: LayoutOrientation.LeftToRight
                                }
                                ThemeColors {
                                    color: "#30910e"
                                }
                                ThemeColors {
                                    color: "#b01717"
                                }
                                ThemeColors {
                                    color: "#5782c6"
                                }
                                ThemeColors {
                                    color: "#42484a"
                                }
                            }
                            Container {
                                topPadding: 20
                                horizontalAlignment: HorizontalAlignment.Fill
                                layout: StackLayout {
                                    orientation: LayoutOrientation.LeftToRight
                                }
                                ThemeColors {
                                    color: "#c08aa1"
                                }
                                ThemeColors {
                                    color: "#4f546c"
                                }
                                ThemeColors {
                                    color: "#fc982b"
                                }
                                ThemeColors {
                                    color: "#914994"
                                }
                            }
                        }

                    }
                }

            }
        }
        attachedObjects: [
            FilePicker {
                id: newAvatar
                type: FileType.Picture
                title: qsTr("Select Picture")
                imageCropEnabled: true
                directories: [ "/accounts/1000/" ]
                onFileSelected: {
                    _control.buddyAvatar = "file://" + selectedFiles
//                    console.log("FileSelected signal received : " + selectedFiles);

                }
            }
        ]

    }
}