#include "heaplistmodel.h"

/// @brief 构造函数
/// @param base 
/// @param parent 
HeapListModel::HeapListModel(HeapModel*base, QObject *parent)
    :heap{base},QAbstractListModel{parent}
{
    m_roleNames[ValueRole] = "value";
    m_roleNames[StateRole] = "state";
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
    case ValueRole:
        return elem.value;
    case StateRole:
        return elem.state;
    }
    return QVariant();
}

/// @brief QML系统所需的函数
/// @return 
QHash<int, QByteArray> HeapListModel::roleNames() const
{
    return m_roleNames;
}
