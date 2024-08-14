

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

    color: Constants.backgroundColor
    state: "home"

    Image {
        id: backgroundImage
        visible: !(menu.algoScene || menu.appScene)
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
        visible: backgroundImage.visible
        color: "#e6e6e6"
        radius: 20
        border.width: 0
        anchors.verticalCenter: parent.verticalCenter
        focus: menu.visible
        property bool appScene: false
        property bool algoScene: false
        antialiasing: false
        anchors.horizontalCenter: parent.horizontalCenter

        Keys.onPressed: (event) => {if(event.key===Qt.Key_Q||event.key===Qt.Key_Escape)Qt.quit();}
        DesignEffect {
            id: designEffect
            layerBlurRadius: 5
            backgroundBlurRadius: 0
            backgroundLayer: backgroundImage
            effects: [
                DesignDropShadow {
                    offsetY: 0.025 * menu.height
                    offsetX: 0.025 * menu.width
                }
            ]
        }
    }

    ColumnLayout {
        id: columnLayout
        width: menu.width
        height: menu.height
        visible: menu.visible
        anchors.verticalCenter: parent.verticalCenter
        spacing: 5
        anchors.horizontalCenter: parent.horizontalCenter

        ColumnLayout {
            id: columnLayout1
            width: 100
            height: 100
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 0

            Text {
                id: text1
                text: qsTr("《数据结构与算法设计》")
                font.pixelSize: 70
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.NoWrap
                Layout.fillWidth: true
                font.styleName: "Bold"
                font.weight: Font.Black
                font.bold: true
            }

            Text {
                id: text2
                text: qsTr("课程设计")
                font.pixelSize: 50
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                Layout.fillWidth: true
                font.bold: true
            }

            Text {
                id: text8
                text: qsTr("范潇")
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                Layout.fillWidth: true
            }

            Text {
                id: text4
                text: qsTr("2254298")
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                Layout.fillWidth: true
            }
        }

        ColumnLayout {
            id: columnLayout2
            width: 100
            height: 100
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
                text: "算法实现：堆的建立和筛选"
                font.pointSize: 40
                font.bold: true
                display: AbstractButton.TextOnly
                Layout.fillWidth: true
                Layout.fillHeight: true
                icon.color: "#cdcdcd"

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
                icon.color: "#cdcdcd"
                font.pointSize: 40
                font.bold: true
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
                icon.color: "#cdcdcd"
                font.pointSize: 40
                font.bold: true
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

    Rectangle {
        id: controlPanel
        y: 903
        height: 100
        visible: !menu.visible
        color: "#cdcdcd"
        border.width: 0
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        focus: controlPanel.visible
        Keys.onPressed: (event) =>{
                            if(event.key===Qt.Key_Q||event.key===Qt.Key_Escape){
                                menu.algoScene = false
                                menu.appScene = false
                            }
                        }
        RoundButton {
            id: returnButton
            width: returnButton.height
            visible: controlPanel.visible
            radius: 10
            palette.button: '#e54a4a'
            text: "返回"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            activeFocusOnTab: false
            font.pointSize: 25
            font.bold: true
            Connections {
                target: returnButton
                onClicked: {
                    menu.algoScene = false
                    menu.appScene = false
                }
            }
        }

        RoundButton {
            id: questionButton
            width: returnButton.width
            visible: controlPanel.visible
            radius: 10
            text: "?"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: returnButton.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            icon.color: "#348562"
            font.italic: false
            icon.width: 30
            palette.button: "#348562"
            font.pointSize: 40
            font.bold: true
            Connections {
                target: questionButton
                onClicked: {
                            menu.algoScene = false
                            menu.appScene = false
                        }
            }
            activeFocusOnTab: false
        }
    }

    states: [
        State {
            name: "home"
            when: !menu.algoScene && !menu.appScene

            PropertyChanges {
                target: backgroundImage
                visible: !(menu.algoScene || menu.appScene)
                source: "images/home_background.svg"
            }

            PropertyChanges {
                target: columnLayout
                visible: menu.visible
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                anchors.topMargin: 20
                anchors.bottomMargin: 20
                spacing: 20
            }

            PropertyChanges {
                target: designEffect
                backgroundLayer: backgroundImage
                backgroundBlurRadius: 32
                layerBlurVisible: false
            }

            PropertyChanges {
                id: propertyChanges
                target: menu
                opacity: 0.597
                focus: true
                layer.smooth: false
            }

            PropertyChanges {
                target: controlPanel
                color: "#cdcdcd"
                focus: false
            }

            PropertyChanges {
                target: mainWindow
                visible: true
            }
        },
        State {
            name: "algo"
            when: menu.algoScene && !menu.appScene

            PropertyChanges {
                target: returnButton
                icon.color: "#e54a4a"
            }

            PropertyChanges {
                target: controlPanel
                focus: controlPanel.visible
            }

            PropertyChanges {
                target: questionButton
                visible: controlPanel.visible
            }
        },
        State {
            name: "app"
            when: !menu.algoScene && menu.appScene

            PropertyChanges {
                target: controlPanel
                focus: controlPanel.visible
            }

            PropertyChanges {
                target: questionButton
                visible: controlPanel.visible
                text: "?"
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0}D{i:1;invisible:true}D{i:2;invisible:true}D{i:5;invisible:true}
}
##^##*/

