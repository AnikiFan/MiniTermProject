// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.7
import MiniTermProject

Window {
    width: mainScreen.width
    height: mainScreen.height

    visible: true
    visibility: Window.Maximized
    title: "MiniTermProject"

    Screen01 {
        id: mainScreen
        anchors.fill:parent
    }

}

