#include "heapmodel.h"
#include "element.h"
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
/// @brief 析构函数
HeapModel::~HeapModel()
{

}
