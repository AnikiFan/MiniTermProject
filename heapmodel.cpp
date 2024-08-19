#include "heapmodel.h"
#include "element.h"
#include<QDebug>
#include<stdexcept>

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
                           {0,Element::Active},
                           {20,Element::Active},
                           {19,Element::Active},
                           {18,Element::Active},
                           {17,Element::Active},
                           {16,Element::Active},
                           {15,Element::Active},
                           {14,Element::Active},
                           {13,Element::Active},
                           {12,Element::Active},
                           {11,Element::Active}
          }),
                        [](const Element &x,const Element &y){return x.value<y.value;}
      },QAbstractItemModel{parent},loop{this}
{
    m_roleNames[ValueRole] = "value";
    m_roleNames[StateRole] = "state";
    connect(this, &HeapModel::Continue,[this](){
        if(this->loop.isRunning()){this->loop.quit();}
    });
    raw = new Element[len];
    if(!raw){throw std::overflow_error("HeapModel::HeapModel");}
    for(long long i{0};i<len;i++){raw[i]=elem[i];}
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

void HeapModel::restart()
{
    qDebug()<<"\n\nrestart";
    //loop.processEvents();
    heapsz = len;
    sorted = false;
    setFinished(false);
    setPauseWhenSwapping(false);
    setpause(true);
    for(long long i{0};i<len;++i){elem[i]=raw[i];}
    m_quit = false;
    emit restarted();
    wait();
    start();
    return;
}

void HeapModel::swap(long long x, long long y)
{
    qDebug()<<"swap:"<<x<<"   "<<y;
    emit swapping();

    elem[x].state = Element::Changing;
    emit elementStateChanged(x);
    elem[y].state = Element::Changing;
    emit elementStateChanged(y);


    qDebug()<<"loop start"<<loop.isRunning();
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

void HeapModel::sort()
{
    qDebug()<<"call sort";
    if(sorted){return;}
    if(m_quit){
        qDebug()<<"sort:quit sort"<<loop.isRunning();
        restart();
        return;
    }
    build();
    while(heapsz){
        if(m_quit){
            qDebug()<<"sort:quit sort"<<loop.isRunning();
            restart();
            return;
        }
        // cout<<"heapsize:"<<heapsz<<endl;
        shrink();
        if(heapsz){maintain(0);};
    }
    sorted=true;
    setFinished(true);
    qDebug()<<"sort complete";
    if(m_quit){
        qDebug()<<"sort:quit sort"<<loop.isRunning();
        restart();
        return;
    }
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
    sort();
    return;
}

void HeapModel::stop()
{
    if(loop.isRunning()){
        qDebug()<<"stop loop";
        emit Continue();
    }
    return;
}

void HeapModel::wait()
{
    qDebug()<<loop.isRunning();
    if(!loop.isRunning()){
        qDebug()<<"start loop"<<loop.isRunning();
        loop.exec();
    }
    return;
}


bool HeapModel::pauseWhenSwapping() const
{
    return m_pauseWhenSwapping;
}

void HeapModel::setPauseWhenSwapping(bool newPauseWhenSwapping)
{
    if (m_pauseWhenSwapping == newPauseWhenSwapping)
        return;
    m_pauseWhenSwapping = newPauseWhenSwapping;
    emit pauseWhenSwappingChanged();
}

bool HeapModel::pause() const
{
    return m_pause;
}

void HeapModel::setpause(bool newPause)
{
    if (m_pause == newPause)
        return;
    m_pause = newPause;
    emit pauseChanged();
}

bool HeapModel::quit() const
{
    return m_quit;
}

void HeapModel::setQuit(bool newQuit)
{
    if (m_quit == newQuit)
        return;
    m_quit = newQuit;
    emit quitChanged();
}

void HeapModel::maintain(long long i)
{
    // cout<<"maintian("<<i<<")"<<endl;
    if(i<0||i>=heapsz){throw std::invalid_argument("Heap::maintian");};
    while(lchild(i)!=null||rchild(i)!=null){
        // cout<<i<<endl;
        // cout<<lchild(i)<<" "<<rchild(i)<<endl;
        if(rchild(i)==null){
            if(cmp(elem[i],elem[lchild(i)])){
                // cout<<"case 1"<<endl;
                this->swap(i,lchild(i));
                if(m_quit){
                    //reload();
                    qDebug()<<"maintain:quit sort";
                    return;
                }
                i = lchild(i);
                continue;
            }
        }else if(lchild(i)==null){
            if(cmp(elem[i],elem[rchild(i)])){
                // cout<<"case 2"<<endl;
                this->swap(i,rchild(i));
                if(m_quit){
                    //reload();
                    qDebug()<<"maintain:quit sort";
                    return;
                }
                i = rchild(i);
                continue;
            }
        }else{
            if(cmp(elem[i],elem[lchild(i)])&&
                cmp(elem[rchild(i)],elem[lchild(i)])){
                // cout<<"case 3"<<endl;
                this->swap(i,lchild(i));
                if(m_quit){
                    //reload();
                    qDebug()<<"maintain:quit sort";
                    return;
                }
                i = lchild(i);
                continue;
            }
            if(cmp(elem[i],elem[rchild(i)])
                &&cmp(elem[lchild(i)],elem[rchild(i)])){
                // cout<<"case 4"<<endl;
                this->swap(i,rchild(i));
                if(m_quit){
                    //reload();
                    qDebug()<<"maintain:quit sort";
                    return;
                }
                i = rchild(i);
                continue;
            }
        }
        break;
    }
    return;
}

void HeapModel::build()
{
    for(long long i = heapsz/2-1;i>=0;--i){
        if(m_quit){
            //reload();
            qDebug()<<"build:quit sort";
            return;
        }
        maintain(i);
    }
    return;
}

bool HeapModel::finished() const
{
    return m_finished;
}

void HeapModel::setFinished(bool newFinished)
{
    if (m_finished == newFinished)
        return;
    m_finished = newFinished;
    emit finishedChanged();
}
