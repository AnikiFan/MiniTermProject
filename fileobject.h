#ifndef FILEOBJECT_H
#define FILEOBJECT_H

#include <QObject>
class HeapModel;
class FileObject:public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged FINAL)
public:
    explicit FileObject(HeapModel*,QObject*parent=0);
    Q_INVOKABLE QString read();
    Q_INVOKABLE bool write(const QString& data);
    void setSource(const QString&source);
    QString source();
signals:
    void sourceChanged();
private:
    QString m_source;
    HeapModel* target;
};

#endif // FILEOBJECT_H
