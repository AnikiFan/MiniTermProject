#ifndef HEAPMODEL_H
#define HEAPMODEL_H

#include <QObject>
#include <QtCore>
#include "Heap.h"
#include "element.h"
class HeapListModel;
class HeapTableModel;
/// @brief 用于存放待可视化的堆，并负责发送相应的signals
class HeapModel:public QAbstractItemModel, Heap<Element>
{
    Q_OBJECT
public:
    explicit HeapModel(QObject*parent = nullptr);
    explicit HeapModel(const char*const,QObject*parent=nullptr);
    ~HeapModel();
    void reload(const char*const);
    void swap(long long x,long long y) override;
    friend HeapListModel;
    friend HeapTableModel;
    virtual QModelIndex index(int row, int column,
                                          const QModelIndex &parent = QModelIndex()) const override;
    virtual QModelIndex parent(const QModelIndex &child) const override;
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    virtual int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
protected:
    enum RoleNames{
        ValueRole = Qt::UserRole,
        StateRole = Qt::UserRole+1
    };
    /// @brief QML系统所需
    QHash<int, QByteArray> m_roleNames;
    virtual QHash<int, QByteArray> roleNames() const override;
public slots:
    void start();
signals:
    void elementSwaped(long long x,long long y);
};

#endif // HEAPMODEL_H
