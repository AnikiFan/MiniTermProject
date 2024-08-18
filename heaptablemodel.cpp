#include "heaptablemodel.h"


/// @brief 用于QML中的Table视图
/// @param base 
/// @param parent 
HeapTableModel::HeapTableModel(HeapModel *base, QObject *parent)
    :heap{base},QAbstractTableModel{parent},formatter{base->length()}
{
    m_rowNumber = formatter.rowNum();
    m_colNumber = formatter.colNum();
}

/// @brief 析构函数
HeapTableModel::~HeapTableModel()
{

}

/// @brief 表格的行数
/// @param  
/// @return 
int HeapTableModel::rowCount(const QModelIndex &) const
{
    return formatter.rowNum();
}

/// @brief 表格的列数
/// @param  
/// @return 
int HeapTableModel::columnCount(const QModelIndex &) const
{
    return formatter.colNum();
}

/// @brief 指定坐标中的数据
/// @param index 
/// @param role 
/// @return 
QVariant HeapTableModel::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() >= formatter.rowNum()
        ||index.column()<0||index.column()>=formatter.colNum()) {
        return QVariant();
    }
    const Element elem =  formatter.transform(index.row(),index.column()) == -1?
            Element{0,Element::Invalid}:heap->elem[formatter.transform(index.row(),index.column())];
    switch(role) {
    case HeapModel::ValueRole:
        return QVariant(elem.value);
    case HeapModel::StateRole:
        return elem.state;
    }
    return QVariant();
}
long long HeapTableModel::rowNumber() const
{
    return m_rowNumber;
}

long long HeapTableModel::colNumber() const
{
    return m_colNumber;
}

QHash<int, QByteArray> HeapTableModel::roleNames() const
{
    return heap->roleNames();
}
