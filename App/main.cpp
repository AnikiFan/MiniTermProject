// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "autogen/environment.h"
#include"heapmodel.h"
#include"heaplistmodel.h"
#include"heaptablemodel.h"
#include"element.h"
int main(int argc, char *argv[])
{
    set_qt_environment();
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(mainQmlFile);

    HeapModel *heapModel = new HeapModel(&app);
    qmlRegisterSingletonInstance("HeapModel",1,0,"HeapModel",heapModel);
    HeapListModel *heapListModel = new HeapListModel(heapModel,heapModel);
    qmlRegisterSingletonInstance("HeapListModel",1,0,"HeapListModel",heapListModel);
    HeapTableModel *heapTableModel = new HeapTableModel(heapModel,heapModel);
    qmlRegisterSingletonInstance("HeapTableModel",1,0,"HeapTableModel",heapTableModel);
    qmlRegisterUncreatableType<Element>("Element", 1, 0, "Element", "Not creatable as it is an enum type");
    QObject::connect(
                &engine, &QQmlApplicationEngine::objectCreated, &app,
                [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");
    engine.addImportPath(":/");
    engine.load(url);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
