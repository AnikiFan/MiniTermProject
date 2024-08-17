#ifndef HEAPTABLEMODEL_H
#define HEAPTABLEMODEL_H

#include <QObject>
#include <QtCore>
#include"heapmodel.h"
#include"formatter.h"
/// @brief 用于堆的二维可视化，利用Table视图实现
class HeapTableModel:public QAbstractTableModel
{
    Q_OBJECT
public:
    explicit HeapTableModel(HeapModel*base,QObject*parent=nullptr);
    /// @brief 属性名
    enum RoleNames{
        ValueRole = Qt::UserRole,
        StateRole = Qt::UserRole+1
    };
    ~HeapTableModel();
    Q_PROPERTY(long long rowNumber READ rowNumber NOTIFY rowNumberChanged FINAL)
    Q_PROPERTY(long long  colNumber READ colNumber NOTIFY colNumberChanged FINAL)
public:
    virtual int rowCount(const QModelIndex & = QModelIndex()) const override;
    virtual int columnCount(const QModelIndex & = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
protected:
    virtual QHash<int, QByteArray> roleNames() const override;
private:
    /// @brief QML系统所需
    QHash<int, QByteArray> m_roleNames;
    /// @brief 指向所需可视化的堆
    HeapModel * heap;
    Formatter formatter;
    long long m_rowNumber;
    long long rowNumber()const;
    long long m_colNumber;
    long long colNumber()const;
signals:
    void rowNumberChanged();
    void colNumberChanged();
};

#endif // HEAPTABLEMODEL_H
