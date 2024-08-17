#include "fileobject.h"
#include <QUrl>
#include <QFile>
#include <QTextStream>
#include<QDebug>
FileObject::FileObject(HeapModel*model,QObject *parent)
    :QObject{parent},target{model}
{

}

QString FileObject::read()
{
    QUrl url(m_source);
    QString content;
    QFile file(url.toLocalFile());
    if ( file.open(QIODevice::ReadOnly) ) {
        content = file.readAll();
        file.close();
    }
    return content;
}

bool FileObject::write(const QString &data)
{
    QFile file(m_source);
    if ( file.open(QFile::WriteOnly | QFile::Truncate) ) {
        QTextStream out(&file);
        out<<data;
        file.close();
        qDebug()<<"output successfully\n";
        return true;
    }
    qDebug()<<"output failed\n";
    return false;
}

void FileObject::setSource(const QString &source)
{
    if(m_source==source){return;}
    m_source=source;
    emit sourceChanged();
    return;
}

QString FileObject::source()
{
    return m_source;
}
