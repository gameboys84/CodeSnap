#include "stdafx.h"
#include <stdlib.h>
#include <iostream>

#include <vector>
#include <functional>
#include <algorithm>

#pragma warning(disable:4244)

using namespace std;

class A
{
public:
	// �����������£�using��typedef�����Ե�Чʹ��
	//using fun = void (*)(int);
	typedef void (*fun)(int);

	static void print(int i) { cout << " " << i << endl; }
	// �Զ��������
	operator fun() { return print; }
};

class B
{
public:
	void print(int i) { cout << " " << i << endl; }
	int _bi;
};


int main()
{
	{
		// ��̬��Ա����
		A a;
		a(1);
	}


	{
		// ��ͨ��Ա����
		B b;
		using fn = void (B::*)(int);
		//typedef void (B::*fn)(int);
		fn fun = &B::print;

		// ���������ȼ�
		//void (B::*fun)(int);
		//fun = &B::print;

		int(B::*_i);
		_i = &B::_bi;

		(b.*_i) = 2;
		(b.*fun)(b.*_i);
	}


	// bind
	{
		B b;
		auto fun = std::bind(&B::print, &b, placeholders::_1);
		fun(3);
	}

	// function
	std::function<void(int)> fun = A::print;
	fun(4);


	cout << endl;

	// bind1st, bind2nd, bind
	vector<int> lst = { 1,2,3,4,5,6,7,8,9,10 };
	fun(count_if(lst.begin(), lst.end(), bind2nd(less<int>(), 3))); // ͳ�� x < 3 ������:2
	fun(count_if(lst.begin(), lst.end(), bind1st(less<int>(), 3))); // ͳ�� 3 < x ������:7
	fun(count_if(lst.begin(), lst.end(), bind2nd(greater<int>(), 3))); // ͳ�� x > 3 ������:7
	fun(count_if(lst.begin(), lst.end(), not1(bind2nd(greater<int>(), 3)))); // ͳ�� not(x>3) -> x <= 3 ������:3
	fun(count_if(lst.begin(), lst.end(), bind(greater<int>(), placeholders::_1, 3))); // ͳ�� x > 3 ������:7
	fun(count_if(lst.begin(), lst.end(), bind(greater<int>(), 3, placeholders::_1))); // ͳ�� x < 3 ������:2

	cout << endl;

	// bind, lambda
	fun(count_if(lst.begin(), lst.end(), bind(logical_and<bool>(), bind(greater<int>(), placeholders::_1, 3), bind(less<int>(), placeholders::_1, 8) ) )); // ͳ�� x > 3 && x < 8 ������:4
	fun(count_if(lst.begin(), lst.end(), [](int x) {return (3 < x && x < 8);} )); // ͳ�� x > 3 && x < 8 ������:4

	

	for (auto i : lst)
	{
		//if (bind(less<int>(), i, 5))
		//	fun(i);
	}

	cout << endl;

	system("pause");
	return 0;
}