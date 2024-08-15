

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.7
import QtQuick.Controls 6.7
import MiniTermProject
import QtQuick.Studio.DesignEffects
import QtQuick.Layouts
import QtQuick.Studio.Components

Rectangle {
    id: mainWindow
    width: Constants.width
    height: Constants.height
    visible: true
    color: "#e6e6e6"
    state: "home"
    Keys.forwardTo: [menu,questionPage,returnButton,questionButton,heapShower]
    // Keys.forwardTo:{
    //     if(mainWindow.state==='home')return[menu]
    //     else if(controlPanel.questionOpen)return[questionPage]
    //     else return[controlPanel,heap]
    // }
    Image {
        id: backgroundImage
        visible: mainWindow.state === "home" ? true : false
        anchors.fill: parent
        source: "qrc:/qtquickplugin/images/template_image.png"
        layer.enabled: false
        fillMode: Image.Stretch
    }
    Rectangle {
        id: menu
        x: 745
        y: 198
        width: 740
        height: 580
        visible: mainWindow.state === "home" ? true : false
        color: "#e6e6e6"
        radius: 20
        border.width: 0
        anchors.verticalCenter: parent.verticalCenter
        clip: true
        focus: mainWindow.state === "home" ? true : false
        opacity: 0.6
        layer.smooth: true
        property bool appScene: false
        property bool algoScene: false
        antialiasing: false
        anchors.horizontalCenter: parent.horizontalCenter
        Keys.onPressed: (event) => {if(event.key===Qt.Key_Q||event.key===Qt.Key_Escape){
                                Qt.quit();
                                event.accepted = true;
                            }
                            else event.accepted = false;
                        }
        DesignEffect {
            id: menuDesignEffect
            layerBlurRadius: 3
            // backgroundBlurRadius: 100
            // backgroundLayer: backgroundImage
            effects: [
                DesignDropShadow {
                    offsetY: 0.025 * menu.height
                    offsetX: 0.025 * menu.width
                }
            ]
            layerBlurVisible: true
        }
    }

    ColumnLayout {
        id: menuLayout
        width: menu.width
        height: menu.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        visible: mainWindow.state === "home" ? true : false
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.topMargin: 20
        spacing: 5
        ColumnLayout {
            id: infoLayout
            width: 100
            height: 100
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 0

            Text {
                id: headerline
                text: qsTr("《数据结构与算法设计》")
                font.pixelSize: 70
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.NoWrap
                font.family: "Microsoft YaHei"
                Layout.fillWidth: true
                font.styleName: "Bold"
                font.weight: Font.Black
                Layout.fillHeight: true
                font.bold: true
            }

            Text {
                id: subtitle
                text: qsTr("课程设计")
                font.pixelSize: 50
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.NoWrap
                font.family: "Microsoft YaHei"
                Layout.fillWidth: true
                font.styleName: "Bold"
                font.weight: Font.Black
                Layout.fillHeight: true
                font.bold: true
            }

            Text {
                id: authorName
                text: qsTr("范潇")
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.NoWrap
                font.family: "Microsoft YaHei"
                Layout.fillWidth: true
                font.styleName: "Bold"
                font.weight: Font.Black
                Layout.fillHeight: true
                font.bold: true
            }

            Text {
                id: studentNumber
                text: qsTr("2254298")
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.NoWrap
                font.family: "Microsoft YaHei"
                Layout.fillWidth: true
                font.styleName: "Bold"
                font.weight: Font.Black
                Layout.fillHeight: true
                font.bold: true
            }
        }

        ColumnLayout {
            id: menuBottonLayout
            Layout.rightMargin: 20
            Layout.leftMargin: 20
            Layout.bottomMargin: 20
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 20

            palette.button: '#cdcdcd'

            RoundButton {
                id: algoScreenButton
                radius: 20
                text: qsTr("算法实现：堆的建立和筛选")
                font.family: "Microsoft YaHei"
                font.pixelSize: 55
                font.bold: true
                font.weight: Font.Black
                display: AbstractButton.TextOnly
                Layout.fillWidth: true
                Layout.fillHeight: true
                DesignEffect {
                    effects: [
                        DesignDropShadow {
                            offsetY: 6
                            offsetX: 10
                        }
                    ]
                }

                Connections {
                    target: algoScreenButton
                    onClicked: menu.algoScene = true
                }
            }

            RoundButton {
                id: appScreenButton
                radius: 20
                text: "综合应用：社会关系网络"
                font.family: "Microsoft YaHei"
                font.pixelSize: 55
                font.bold: true
                font.weight: Font.Black
                display: AbstractButton.TextOnly
                DesignEffect {
                    effects: [
                        DesignDropShadow {
                            offsetY: 6
                            offsetX: 10
                        }
                    ]
                }

                Connections {
                    target: appScreenButton
                    onClicked: menu.appScene = true
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            RoundButton {
                id: quitBotton
                radius: 20
                text: "退出"
                font.family: "Microsoft YaHei"
                font.pixelSize: 55
                font.bold: true
                font.weight: Font.Black
                display: AbstractButton.TextOnly
                DesignEffect {
                    effects: [
                        DesignDropShadow {
                            offsetY: 6
                            offsetX: 10
                        }
                    ]
                }

                Connections {
                    target: quitBotton
                    onClicked: Qt.quit()
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }

    Item {
        id:heapShower
        height: 100
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: controlPanel.top
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        visible: parent.state === 'algo'?true:false
        focus:parent.state === 'algo'?true:false
        Keys.onLeftPressed: scrollBar.decrease()
        Keys.onRightPressed: scrollBar.increase()
            ListView {
                id:heap
                anchors.fill: parent
                anchors.margins: 10
                spacing: 4
                clip: true
                model: 100
                orientation: ListView.Horizontal
                delegate: Rectangle {
                    required property int index
                    width: 80
                    height: 80
                    color:"red"
                    opacity:index/100
                    Text{
                        anchors.centerIn: parent
                        text:index
                    }
                }
                ScrollBar.horizontal: ScrollBar { id: scrollBar }
            }
    }
    Rectangle {
        id: controlPanel
        y: 903
        height: 100
        visible:  mainWindow.state === "home" ? false : true
        color: "#cdcdcd"
        border.width: 0
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        Keys.forwardTo: [returnButton,questionButton]
        property bool questionOpen: false
        RoundButton {
            id: returnButton
            width: returnButton.height
            radius: 10
            palette.button: '#e54a4a'
            text: "返回"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            font.family: "Microsoft YaHei"
            activeFocusOnTab: false
            font.pixelSize: 30
            font.bold: true
            font.weight: Font.Black
            Connections {
                target: returnButton
                onClicked: {
                    menu.algoScene = false
                    menu.appScene = false
                }
            }
            focus: mainWindow.state === "home" || controlPanel.questionOpen? false : true
            Keys.onPressed: (event) =>{
                                if(event.key===Qt.Key_Q||event.key===Qt.Key_Escape){
                                    menu.algoScene = false
                                    menu.appScene = false
                                    event.accepted = true
                                }
                                else event.accepted = false
                            }
        }

        RoundButton {
            id: questionButton
            width: returnButton.width
            radius: 10
            text: "?"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: returnButton.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            font.family: "Microsoft YaHei"
            font.italic: false
            palette.button: "#348562"
            font.pixelSize: 70
            font.bold: true
            font.weight: Font.Black
            Connections {
                target: questionButton
                onClicked: {
                    controlPanel.questionOpen = true
                }
            }
            Keys.onPressed: (event) =>{
                                if(event.key===Qt.Key_Question){
                                    controlPanel.questionOpen = true
                                }
                            }
            focus: mainWindow.state === "home" || controlPanel.questionOpen? false : true
            activeFocusOnTab: false
        }

        RoundButton {
            id: importButton
            width: 200
            radius: 10
            text: "导入"
            anchors.right: parent.horizontalCenter
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            font.pixelSize: 30
            palette.button: "#68abd0"
            font.weight: Font.Black
            font.family: "Microsoft YaHei"
            font.bold: true
        }

        RoundButton {
            id: exportButton
            width: 200
            radius: 10
            text: "导出"
            anchors.left: parent.horizontalCenter
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            font.pixelSize: 30
            palette.button: "#68abd0"
            font.weight: Font.Black
            font.family: "Microsoft YaHei"
            font.bold: true
        }


    }

    Rectangle {
        id: questionBackground
        visible: controlPanel.questionOpen
        color: "#ffffff"
        border.width: 0
        anchors.fill: parent
        opacity: 0.698

        Page {
            id: questionPage
            focus: controlPanel.questionOpen
            Keys.onPressed: (event) =>{
                                if(event.key===Qt.Key_Q||event.key===Qt.Key_Escape){
                                    controlPanel.questionOpen = false
                                    event.accepted = true
                                }
                                else event.accepted = false
                            }
            Keys.onLeftPressed:(event) =>{
                                   if(view.currentIndex > 0) view.currentIndex -=1 ;
                               }
            Keys.onRightPressed:(event) =>{
                                   if(view.currentIndex<view.count-1) view.currentIndex +=1 ;
                               }
            width: 400
            height: 400
            palette.window: "#cdcdcd"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            header: Label {
                text: view.currentItem.title
                anchors.top: parent.top
                anchors.topMargin: 10
                horizontalAlignment: Text.AlignHCenter
                   verticalAlignment: Text.AlignVCenter
                   font.pointSize: 20
                   font.bold: true
                   anchors.horizontalCenterOffset: 0
                   anchors.horizontalCenter: parent.horizontalCenter
            }
            Rectangle{
            anchors.fill: parent
            color:'white'
            SwipeView {
                id: view
                currentIndex: 1
                anchors.fill: parent
                   clip: true
                   palette.window: '#dfdfdf'
                   // component HelpPage :Page{
                   //     id: helpPage
                   //     property  string title: "title"
                   //     property alias  text   :helpPageText.text
                   //     Text{
                   //         id: helpPageText
                   //         text: "text"
                   //         anchors.fill: parent
                   //         horizontalAlignment: Text.AlignHCenter
                   //         verticalAlignment: Text.AlignTop
                   //     }
                   // }
                   // HelpPage{
                   //     id: page11
                   //     title: "Page1"
                   //     text: "test"
                   // }
                   // HelpPage{
                   //     id: page21
                   //     title: "Page2"
                   //     text: "test"
                   // }
                   // HelpPage{
                   //     id: page31
                   //     title: "Page3"
                   //     text: "test"
                   // }
                   Page {
                       title: qsTr("Home")

                       Text{
                           id: text3
                           text:"test"
                           anchors.fill: parent
                           horizontalAlignment: Text.AlignHCenter
                           verticalAlignment: Text.AlignTop
                       }
                   }
                   Page {
                       title: qsTr("Discover")
                       Text{
                           id: text1
                           text:"test1"
                           anchors.fill: parent
                           horizontalAlignment: Text.AlignHCenter
                           verticalAlignment: Text.AlignVCenter
                       }
                   }
                   Page {
                       title: qsTr("Activity")
                       Text{
                           id: text2
                           text:"test2"
                           anchors.fill: parent
                           horizontalAlignment: Text.AlignHCenter
                           verticalAlignment: Text.AlignVCenter
                       }
                   }
               }
        }
            PageIndicator {
                id: indicator
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                count: view.count
                currentIndex: view.currentIndex

            }
        }
    }

    states: [
        State {
            name: "home"
            when: !menu.algoScene && !menu.appScene
            PropertyChanges {
                target: backgroundImage
                source: "images/home_background.svg"
            }
        },
        State {
            name: "algo"
            when: menu.algoScene && !menu.appScene
        },
        State {
            name: "app"
            when: !menu.algoScene && menu.appScene
        }
    ]
}

/*##^##
Designer {
    D{i:0}D{i:44;invisible:true}
}
##^##*/

