#include "element.h"

/// @brief 堆中元素
/// @param val 键值
Element::Element(long long val,State st):value{val},state{st}
{

}


Element::Element():value{0},state{Invalid}
{

}

/// @brief 析构函数
Element::~Element()
{

}
