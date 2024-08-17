#include "formatter.h"
#include<cmath>
#include<stdexcept>
/// @brief 构造函数
/// @param sz 一维list中元素的个数
Formatter::Formatter(long long sz)
{
    row = static_cast<long long>(log2(sz))+1;
    col = (1LL<<row)-1;
}


/// @brief 堆用二维数组表示所需的行数
/// @return 行数
long long Formatter::rowNum() const
{
    return row;
}

/// @brief 堆用二维数组表示所需的列数
/// @return 列数
long long Formatter::colNum() const
{
    return col;
}

/// @brief 给定二维数组中的位置，判断其在一维list中对应的位置
/// @param row 
/// @param col 
/// @return 
long long Formatter::transform(long long r, long long c)const
{
    if(r<0||r>=row||c<0||c>=col){throw std::invalid_argument("Formatter::transform");}
    r = row-r;//转化为从左下角开始，并且下标从1开始
    c = c + 1;
    return ((c&-c)|(1LL<<(r-1)))^c ? null : (1<<(row-r))+(c<<1);
    //判断c的第一个非0位是否是第r位
    //c&-c：提取出最低非0位；1LL<<(r-1)第r位为1的数
    //c<<1：所在行中排在第几位，从0开始
    //从上往下在第row-r层，从1开始
}
