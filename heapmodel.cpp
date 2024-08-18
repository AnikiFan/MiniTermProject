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
      },QObject(parent)
{

}

HeapModel::HeapModel(const char * const p, QObject *parent)
    :Heap<Element>{Vector<Element>{0}, [](const Element &x,const Element &y){return x.value<y.value;}},
        QObject{parent }
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
    qDebug()<<x<<"   "<<y<<"\n";
    if(x<0||length()<=x){throw std::out_of_range("Vector::swap");}
    if(y<0||length()<=y){throw std::out_of_range("Vector::swap");}
    if(x==y){return;}
    Element tmp{std::move(elem[x])};
    elem[x] = std::move(elem[y]);
    elem[y] = std::move(tmp);
    return;
}

void HeapModel::start()
{
    sort();
    return;
}
