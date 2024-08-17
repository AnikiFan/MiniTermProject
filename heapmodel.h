#ifndef HEAPMODEL_H
#define HEAPMODEL_H

#include <QObject>
#include "Heap.h"
#include "element.h"
class HeapListModel;
class HeapTableModel;
/// @brief 用于存放待可视化的堆，并负责发送相应的signals
class HeapModel:public QObject, Heap<Element>
{
    Q_OBJECT
public:
    explicit HeapModel(QObject*parent = nullptr);
    explicit HeapModel(const char*const,QObject*parent=nullptr);
    ~HeapModel();
    void reload(const char*const);
    friend HeapListModel;
    friend HeapTableModel;
};

#endif // HEAPMODEL_H
