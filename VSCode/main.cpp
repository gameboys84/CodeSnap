#include <stdlib.h>
#include <iostream>
#include <map>
#include <vector>

using namespace std;

template <typename T>
struct MapString
{
    map<string, T> mapString;
};

int main()
{
    cout << "hello world!" << endl;

    // 操蛋的g++，非常不方便调试STL的代码呀。。。
    vector<int> lst = {1,2,3,4,5};
    for (auto it = lst.begin(); it != lst.end(); ++it)
        cout << *it << endl;

    //map<string, string> mapValue;
    //mapValue.insert(make_pair<string,string>("123", "abc"));

    MapString<string> mapValue;
    mapValue.mapString.insert(make_pair<string, string>("123", "abc"));

    cout << mapValue.mapString.begin()->first << ", " << mapValue.mapString.begin()->second << endl;

    system("pause");
    return 0;
}