import bb.cascades 1.2
import my.timer 1.0

NavigationPane {
    id: navPane
    backButtonsVisible: false
    Page {
        id: mPage
        titleBar: TitleBar {
            kind: TitleBarKind.FreeForm
            kindProperties: CustomFreeFormTitleBar {
                title: qsTr("Buddies")
                closeButtonActive: false
            }
        }
        Container {
            topPadding: 20
            leftPadding: 20
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            CustomItemBuddy {
                userName: _control.buddyName + qsTr(" (You)")
                system: "at " + _control.getHostName()
                userImage: _control.buddyAvatar
                avatarUrl: ""
                plataformImage: "asset:///images/BlackberryLogo.png"
                onCreationCompleted: {
                    timer.timeout.connect(timeout);
                }
            }
            Container {
                topPadding: 30
                leftPadding: 100
                rightPadding: 100
                Container {
                    background: _control.themeColor
                    Divider {
                    }
                }
            }
            Container {
                layout: DockLayout {
                }
                Container {
                    topPadding: 100
                    visible: ! _control.countBuddy
                    Label {
                        text: qsTr("Sorry, no buddies found...")
                        textStyle.fontSize: FontSize.XXLarge
                        multiline: true
                    }
                }
                Container {
                    visible: _control.countBuddy
                    Container {
                        //topPadding: 30
                        ListView {
                            property variant themeColorToList: _control.themeColor
                            signal timerToList()
                            onCreationCompleted: {
                                timer.timeout.connect(timerToList);
                            }

                            id: listview
                            rootIndexPath: [ 0 ]
                            dataModel: _control.buddyModel
                            listItemComponents: [
                                ListItemComponent {
                                    type: "item"
                                    Container {
                                        id: mlistItem
                                        layout: DockLayout {
                                        }
                                        topPadding: 30
                                        CustomItemBuddy {
                                            userName: ListItemData.username
                                            system: ListItemData.system
                                            avatarUrl: ListItemData.avatar
                                            plataformImage: ListItemData.oslogo
                                            themeColor: mlistItem.ListItem.view.themeColorToList
                                            onCreationCompleted: {
                                                mlistItem.ListItem.view.timerToList.connect(timeout)
                                                //                                            console.log("testes", mlistItem.ListItem.view.toString())
                                            }
                                        }
                                    }
                                }
                            ]
                            onTriggered: {
                                var item = dataModel.data(indexPath);
                                var sendData = sendDataPane.createObject();

                                sendData.userName = item.username
                                sendData.system = item.system
                                sendData.avatarUrl = item.avatar
                                console.log("AvatarUrl", sendData.avatarUrl, item.avatar)
                                sendData.plataformImage = item.oslogo
                                sendData.index = dataModel.data(indexPath)

                                navPane.push(sendData)
                            }
                        }
                    }
                }
            }
        }
    }
    attachedObjects: [
        ComponentDefinition {
            id: sendDataPane
            source: "asset:///SendData.qml"
        },
        QTimer {
            id: timer
            interval: 5000
        }
    ]
    onCreationCompleted: {
        timer.start()
    }
}
