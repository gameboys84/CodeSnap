// Test.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <stdlib.h>
#include <iostream>
#include <vector>

using namespace std;

int& foo(int& i) { return i; }
float foo(float& f) { return f; }

template<typename T>
auto foo(T t) -> decltype(foo(t)) { return foo(t); }

int main()
{
	auto a = foo<int>(1);
	auto b = foo<float>(2.0f);
	//vector<vector<int>> lst = {1,{1,2}};
	//double f = { (unsigned long long) - 1 };
	//float f = { 1e40 };

	int ar[10] = {0, 1,3, 4,5};
	for (auto i : ar)
		cout << i << endl;

	system("pause");
    return 0;
}

