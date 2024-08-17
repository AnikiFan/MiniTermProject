#include "heapmodel.h"
#include "element.h"
/// @brief 构造函数，附带一个简单的样例
/// @param parent 
HeapModel::HeapModel(QObject*parent):Heap<Element>{
                      Vector<Element>({
                           {10,Element::Invalid},
                           {9,Element::Invalid},
                           {8,Element::Invalid},
                           {7,Element::Invalid},
                           {6,Element::Invalid},
                           {5,Element::Invalid},
                           {4,Element::Invalid},
                           {3,Element::Invalid},
                           {2,Element::Invalid},
                           {1,Element::Invalid},
                           {0,Element::Invalid}
          }),
                        [](const Element &x,const Element &y){return x.value<y.value;}
      },QObject(parent)
{

}
/// @brief 析构函数
HeapModel::~HeapModel()
{

}
