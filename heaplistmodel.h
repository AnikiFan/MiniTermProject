#ifndef HEAPLISTMODEL_H
#define HEAPLISTMODEL_H

#include <QObject>
#include <QtCore>
#include "heapmodel.h"
/// @brief 用于QML中的list视图
class HeapListModel:public QAbstractListModel
{
    Q_OBJECT
public:
    explicit HeapListModel(HeapModel*base, QObject *parent=nullptr);
    /// @brief 键值、状态
    enum RoleNames{
        ValueRole = Qt::UserRole,
        StateRole = Qt::UserRole+1
    };
    ~HeapListModel();
public:
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
protected:
    // return the roles mapping to be used by QML
    virtual QHash<int, QByteArray> roleNames() const override;
private:
    /// @brief QML系统所需
    QHash<int, QByteArray> m_roleNames;
    /// @brief 指向所要可视化的堆
    HeapModel * heap;
};

#endif // HEAPLISTMODEL_H
