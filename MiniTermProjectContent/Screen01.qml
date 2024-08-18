

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
import QtQuick.Dialogs
import Qt.labs.platform
import HeapListModel
import HeapTableModel
import HeapModel
import Element
import FileObject

Rectangle {
    id: mainWindow
    width: Constants.width
    height: Constants.height
    visible: true
    color: "#e6e6e6"
    state: "home"
    Keys.forwardTo: [menu,bluredBackground,heapShower,controlPanel,heapTable]
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
        property bool appScene: false
        property bool algoScene: false
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
        property bool importOpen: false
        property bool exportOpen: false
        RoundButton {
            id: returnButton
            width: returnButton.height
            radius: 10
            palette.button: '#e54a4a'
            text: "↩"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            font.family: "Microsoft YaHei"
            activeFocusOnTab: false
            font.pixelSize: 100
            font.bold: true
            font.weight: Font.Black
            Connections {
                target: returnButton
                onClicked: {
                    menu.algoScene = false
                    menu.appScene = false
                }
            }
            focus: mainWindow.state === "home" || bluredBackground.visible? false : true
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
            width: questionButton.height
            radius: 10
            text: "?"
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
                                    event.accepted = true
                                }else event.accepted = false
                            }
            focus: mainWindow.state === "home" || bluredBackground.visible? false : true
            activeFocusOnTab: false
        }

        RoundButton {
            id: importButton
            width: importButton.height
            radius: 10
            text: "导入"
            anchors.right: exportButton.left
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
            Connections {
                target: importButton
                onClicked: {
                    controlPanel.importOpen=true
                }
            }
        }

        RoundButton {
            id: exportButton
            width: exportButton.height
            radius: 10
            text: "导出"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            palette.button: "#68abd0"
            font.pixelSize: 30
            font.weight: Font.Black
            font.family: "Microsoft YaHei"
            font.bold: true
            Connections {
                target: exportButton
                onClicked: {
                    controlPanel.exportOpen=true
                }
            }
        }

        RoundButton {
            id: startButton
            width: 240
            radius: 10
            text: "▶"
            visible:mainWindow.state==="algo"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            font.pixelSize: 125
            palette.button: "#d69545"
            font.weight: Font.Black
            font.italic: false
            font.family: "Microsoft YaHei"
            font.bold: true
            onClicked: {
                console.log('startButton clicked')
                HeapModel.start()
            }
        }

        Slider {
            id: speedSlider
            width: 120
            visible:mainWindow.state==="algo"
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: startButton.right
            anchors.leftMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            background: Rectangle {
                    x: speedSlider.leftPadding
                    y: speedSlider.topPadding + speedSlider.availableHeight / 2 - height / 2
                    implicitWidth: 200
                    implicitHeight: 4
                    width: speedSlider.availableWidth
                    height: implicitHeight
                    radius: 2
                    color: "#e6e6e6"

                    Rectangle {
                        width: speedSlider.visualPosition * parent.width
                        height: parent.height
                        color: "#5f694e"
                        radius: 2
                    }
                }
        }

        RoundButton {
            id: restartButton
            width: 120
            radius: 10
            text: "↻"
            visible:mainWindow.state==="algo"
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            font.pixelSize: 100
            palette.button: "#bdcf9a"
            font.weight: Font.Black
            font.italic: false
            font.family: "Microsoft YaHei"
            font.bold: true
            anchors.right:startButton.left
        }
    }
    Rectangle {
        id: bluredBackground
        visible: controlPanel.questionOpen || controlPanel.importOpen || controlPanel.exportOpen
        color: "#ffffff"
        border.width: 0
        anchors.fill: parent
        opacity: 0.698

        Page {
            id: questionPage
            focus: controlPanel.questionOpen
            visible: controlPanel.questionOpen
            Keys.onPressed: (event) =>{
                                if(event.key===Qt.Key_Q||event.key===Qt.Key_Escape){
                                    controlPanel.questionOpen = false
                                    event.accepted = true
                                }
                                else event.accepted = false
                            }
            Keys.onLeftPressed:(event) =>{
                                   if(view.currentIndex > 0){
                                       event.accepted = true
                                       view.currentIndex -=1 ;
                                   }else event.accepted = false
                               }
            Keys.onRightPressed:(event) =>{
                                    if(view.currentIndex<view.count-1){
                                        event.accepted = true
                                        view.currentIndex +=1 ;
                                    }else event.accepted = false
                                }
            width: 400
            height: 400
            palette.window: "#cdcdcd"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            header: Label {
                text: view.currentItem.title
                anchors.top: parent.top
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 20
                font.bold: true
                anchors.right: parent.right
                anchors.left: parent.left
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

        Rectangle {
            id: importPage
            Keys.onPressed: (event) =>{
                                if(event.key===Qt.Key_Q||event.key===Qt.Key_Escape){
                                    controlPanel.importOpen = false
                                    event.accepted = true
                                }
                                else event.accepted = false
                            }
            FileDialog {
                id: readFileDialog
                folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                onAccepted: {
                    FileObject.source = readFileDialog.file
                    FileObject.read()
                }
                nameFilters: ["Text files (*.txt)"]
            }
            FileDialog {
                id: writeFileDialog
                folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                onAccepted: {
                    FileObject.source = writeFileDialog.file
                    FileObject.write(outputBox.text)
                }
                nameFilters: ["Text files (*.txt)"]
            }
            width: 400
            height: 650
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color:"#dfdfdf"
            visible: controlPanel.importOpen
            focus: controlPanel.importOpen
            ColumnLayout{
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                anchors.bottomMargin: 10
                Rectangle{
                    id:inputBoxBackground
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    height:500
                    ScrollView {
                        id: inputBoxView
                        anchors.fill: parent
                        TextArea {
                            id:inputBox
                            wrapMode: Text.Wrap
                            anchors.fill:inputBoxView
                            placeholderText: "请输入整数，用空格或回车分隔"
                        }
                    }
                }
                RoundButton{
                    id:textImportButton
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    palette.button: '#cdcdcd'
                    text:"从文件中导入"
                    font.pixelSize: 30
                    font.weight: Font.Black
                    font.family: "Microsoft YaHei"
                    font.bold: true
                    Connections {
                        target: textImportButton
                        onClicked: {
                            readFileDialog.open()
                        }
                    }
                }
                RowLayout{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    RoundButton{
                        id:importCancelButton
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        palette.button: '#e54a4a'
                        text:"取消"
                        font.pixelSize: 30
                        font.weight: Font.Black
                        font.family: "Microsoft YaHei"
                        font.bold: true
                        Connections {
                            target: importCancelButton
                            onClicked: {
                                controlPanel.importOpen=false
                            }
                        }
                    }
                    RoundButton{
                        id:importCheckButton
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        palette.button: "#348562"
                        text:"确认"
                        font.pixelSize: 30
                        font.weight: Font.Black
                        font.family: "Microsoft YaHei"
                        font.bold: true
                        Connections {
                            target: importCheckButton
                            onClicked: {
                                controlPanel.importOpen=false
                            }
                        }
                    }
                }
            }
        }
        Rectangle {
            id: exportPage
            Keys.onPressed: (event) =>{
                                if(event.key===Qt.Key_Q||event.key===Qt.Key_Escape){
                                    controlPanel.exportOpen = false
                                    event.accepted = true
                                }
                                else event.accepted = false
                            }
            width: 400
            height: 400
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color:"#dfdfdf"
            visible: controlPanel.exportOpen
            focus: controlPanel.exportOpen
            ColumnLayout{
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                anchors.bottomMargin: 10
                Rectangle{
                    id:outputBoxBackground
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    height:500
                    ScrollView {
                        id: outputBoxView
                        anchors.fill: parent
                        TextArea {
                            id:outputBox
                            wrapMode: TextInput.Wrap
                            anchors.fill: parent
                            readOnly: true
                            text:"testttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt"
                        }
                    }
                }
                RowLayout{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    RoundButton{
                        id:textExportButton
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        palette.button: '#e54a4a'
                        text:"保存至文件"
                        font.pixelSize: 30
                        font.weight: Font.Black
                        font.family: "Microsoft YaHei"
                        font.bold: true
                        Connections {
                            target: textExportButton
                            onClicked: {
                                writeFileDialog.open()
                            }
                        }
                    }
                    RoundButton{
                        id:copyButton
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        palette.button: "#348562"
                        text:"复制"
                        font.pixelSize: 30
                        font.weight: Font.Black
                        font.family: "Microsoft YaHei"
                        font.bold: true
                        Connections {
                            target: copyButton
                            onClicked: {
                                outputBox.selectAll()
                                outputBox.copy()
                                outputBox.deselect()
                            }
                        }
                    }
                }
                RoundButton{
                    id:textExportQuitButton
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    palette.button: '#cdcdcd'
                    text:"返回"
                    font.pixelSize: 30
                    font.weight: Font.Black
                    font.family: "Microsoft YaHei"
                    font.bold: true
                    Connections {
                        target: textExportQuitButton
                        onClicked: {
                            controlPanel.exportOpen=false
                        }
                    }
                }
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
        focus:parent.state === 'algo'&&!bluredBackground.visible?true:false
        Keys.onPressed: (event) =>{
                            if(event.key===Qt.Key_Plus||event.key===Qt.Key_Equal){
                                heapScrollBar.increase()
                                event.accepted = true
                            }
                            else if(event.key===Qt.Key_Minus||event.key===Qt.Key_Underscore){
                                heapScrollBar.decrease()
                                event.accepted = true
                            }
                            else event.accepted = false
                        }
            ListView {
                id:heapListView
                anchors.fill: parent
                anchors.margins: 10
                spacing: 4
                clip: true
                orientation: ListView.Horizontal
                model:HeapListModel
                delegate: Rectangle {
                    border.width: 5
                    border.color: 'black'
                    width: 80
                    height: 80
                    color:{
                        if(model.state===Element.Active){return '#8ab8b6'}
                        if(model.state===Element.Inactive){return '#d5b29c'}
                        if(model.state===Element.Invalid){return 'black'}
                    }
                    visible: model.state===Element.Invalid?false:true
                    Text{
                        anchors.centerIn: parent
                        text:(model.value*100000).toString()
                        anchors.fill: parent
                        wrapMode: Text.WrapAnywhere
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.margins: parent.border.width
                    }
                }
                Component.onCompleted: {console.log(HeapListModel)}
                ScrollBar.horizontal: ScrollBar { id: heapScrollBar }
            }
    }
    TableView {
        id:heapTable
        visible:parent.state==="algo"&&!bluredBackground.visible
        anchors.left: parent.left
        anchors.bottom: heapShower.top
        anchors.top: parent.top
        anchors.right:parent.right
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        columnSpacing: 0
        rowSpacing: 0
        clip: true
        rowHeightProvider: (row)=>{return height/HeapTableModel.rowNumber}
        columnWidthProvider: (column)=>{return width/HeapTableModel.colNumber}
        model:HeapTableModel
        Component.onCompleted: {console.log(height,width,HeapTableModel.rowNumber,HeapTableModel.colNumber)}
        delegate: Rectangle {

            color:"white"
            Rectangle{
                visible: model.state===Element.Invalid?false:true
                width: parent.width>parent.height?parent.height:parent.width
                height:width
                radius:width/2
                color:{
                    if(model.state===Element.Active){return '#8ab8b6'}
                    if(model.state===Element.Inactive){return '#d5b29c'}
                    if(model.state===Element.Invalid){return 'black'}
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                anchors.centerIn: parent
                text:model.value
                }

            }
        }
        ScrollBar.vertical: ScrollBar {
            id:vbar
            visible:false
        }
        ScrollBar.horizontal: ScrollBar {
            id:hbar
            visible:false
        }
        focus:parent.state==='algo'&&!bluredBackground.visible
        Keys.onLeftPressed: hbar.decrease()
        Keys.onRightPressed: hbar.increase()
        Keys.onUpPressed: vbar.decrease()
        Keys.onDownPressed: vbar.increase()
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
    D{i:0}D{i:52;invisible:true}
}
##^##*/

