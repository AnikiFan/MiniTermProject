#include "heaplistmodel.h"

/// @brief 构造函数
/// @param base 
/// @param parent 
HeapListModel::HeapListModel(HeapModel*base, QObject *parent)
    :heap{base},QAbstractListModel{parent}
{
    QObject::connect(base,&HeapModel::elementSwaped,this,&HeapListModel::onElementSwaped);
}

/// @brief 析构函数
HeapListModel::~HeapListModel()
{

}

/// @brief 返回元素个数
/// @param  
/// @return 
int HeapListModel::rowCount(const QModelIndex &) const
{
    return heap->length();
}

/// @brief 返回指定位置的数据
/// @param index 位置
/// @param role 属性名
/// @return 
QVariant HeapListModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if(row < 0 || row >= heap->length()) {
        return QVariant();
    }
    const Element elem = (*heap)[row];
    switch(role) {
    case HeapModel::ValueRole:
        return elem.value;
    case HeapModel::StateRole:
        return elem.state;
    }
    return QVariant();
}



void HeapListModel::onElementSwaped(long long x, long long y)
{
    emit dataChanged(index(x),index(x));
    emit dataChanged(index(y),index(y));
}

QHash<int, QByteArray> HeapListModel::roleNames() const
{
    return heap->roleNames();
}
