#include "heapmodel.h"
#include "element.h"
#include<QDebug>

/// @brief 构造函数，附带一个简单的样例
/// @param parent 
HeapModel::HeapModel(QObject*parent):Heap<Element>{
                      Vector<Element>({
                           {10,Element::Active},
                           {9,Element::Active},
                           {8,Element::Active},
                           {7,Element::Active},
                           {6,Element::Active},
                           {5,Element::Active},
                           {4,Element::Active},
                           {3,Element::Active},
                           {2,Element::Active},
                           {1,Element::Active},
                           {0,Element::Active}
          }),
                        [](const Element &x,const Element &y){return x.value<y.value;}
      },QAbstractItemModel{parent}
{
    m_roleNames[ValueRole] = "value";
    m_roleNames[StateRole] = "state";
    connect(this, &HeapModel::Continue, &loop, &QEventLoop::quit);
}
/// @brief QML系统所需的函数
/// @return
QHash<int, QByteArray> HeapModel::roleNames() const
{
    return m_roleNames;
}
HeapModel::HeapModel(const char * const p, QObject *parent)
    :Heap<Element>{Vector<Element>{0}, [](const Element &x,const Element &y){return x.value<y.value;}},
        QAbstractItemModel{parent}
{
    long long i{0};
    bool negative{false},isNumber{false};
    long long number{0};
    while(p[i++]){
        if(p[i]=='-'){negative=true;}
        else if(p[i]>='0'||p[i]<='9'){
            isNumber=true;
            number *= 10;
            number += p[i]-'0';
        }else if(isNumber){
            push_back(negative?-number:number);
            number = 0;
            isNumber = false;
        }else{negative = false;}
    }
}
/// @brief 析构函数
HeapModel::~HeapModel()
{

}

void HeapModel::reload(const char * const p)
{
    empty();
    long long i{0};
    bool negative{false},isNumber{false};
    long long number{0};
    while(p[i++]){
        if(p[i]=='-'){negative=true;}
        else if(p[i]>='0'||p[i]<='9'){
            isNumber=true;
            number *= 10;
            number += p[i]-'0';
        }else if(isNumber){
            push_back(negative?-number:number);
            number = 0;
            isNumber = false;
        }else{negative = false;}
    }
    return;
}

void HeapModel::swap(long long x, long long y)
{
    //qDebug()<<x<<"   "<<y<<"\n";
    emit swapping();

    elem[x].state = Element::Changing;
    emit elementStateChanged(x);
    elem[y].state = Element::Changing;
    emit elementStateChanged(y);


   // qDebug()<<"loop start\n";
    loop.exec();
   // qDebug()<<"loop end\n";
    Vector<Element>::swap(x,y);
    emit elementValueChanged(x,y);

    elem[x].state = Element::Active;
    emit elementStateChanged(x);
    elem[y].state = Element::Active;
    emit elementStateChanged(y);

    return;
}

void HeapModel::shrink()
{
    Heap<Element>::shrink();
    elem[heapsz].state=Element::Inactive;
    emit elementStateChanged(heapsz);
    return;
}

QModelIndex HeapModel::index(int row, int column, const QModelIndex &parent) const
{
    return index(0,0);
}

QModelIndex HeapModel::parent(const QModelIndex &child) const
{
    return index(0,0);
}

int HeapModel::rowCount(const QModelIndex &parent) const
{
    return 0;
}

int HeapModel::columnCount(const QModelIndex &parent) const
{
    return 0;
}

QVariant HeapModel::data(const QModelIndex &index, int role) const
{
    return QVariant();
}

void HeapModel::start()
{
    Heap<Element>::sort();
    return;
}

void HeapModel::stop()
{
    emit Continue();
}
