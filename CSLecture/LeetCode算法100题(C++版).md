# 编程练习

## demo task

2022.11.10

This is a demo task.

Write a function:

> ```
> int solution(int A[], int N);
> ```

that, given an array A of N integers, returns the smallest positive integer (greater than 0) that does not occur in A.

For example, given A = [1, 3, 6, 4, 1, 2], the function should return 5.

Given A = [1, 2, 3], the function should return 4.

Given A = [−1, −3], the function should return 1.

Write an ***\*efficient\**** algorithm for the following assumptions:

> - N is an integer within the range [1..100,000];
> - each element of array A is an integer within the range [−1,000,000..1,000,000].

**Solution：**

```
int solution(int A[], int N) {
    // write your code in C99 (gcc 6.2.0)

   int i,j,t;
   int ans=1;

    for(i=0;i<N-1;i++)//n个数的数列总共扫描n-1次
    {
        for(j=0;j<N-i-1;j++)//每一趟扫描到a[n-i-2]与a[n-i-1]比较为止结束
        {
            if(A[j]>A[j+1])//后一位数比前一位数小的话，就交换两个数的位置（升序）
            {
               t=A[j+1];
               A[j+1]=A[j];
               A[j]=t;
            }
        }
    }

    for(i=0;i<N;i++)
    {
        if(A[i]<1 || (i>0 && A[i]==A[i-1])){
            continue;
        }
        
        if(A[i]>ans){
            return ans;
        }else{
            ans++;
           // printf("A[i]: %d\n", A[i]);
           // printf("Answer: %d\n", ans);
        }
    }

    return ans;
}

```



```C++
vector<int> merge(vector<int> a, vector<int> b) {
	vector<int> res;
	size_t ai = 0, bi = 0;
	while (ai < a.size() && bi < b.size()) {
		if (a[ai] <= b[bi])
			res.push_back(a[ai++]);
		else
			res.push_back(b[bi++]);
	}
	if (ai == a.size())
		res.insert(res.end(), b.begin() + bi, b.end());
	else if (bi == b.size())
		res.insert(res.end(), a.begin() + ai, a.end());
	return res;
}

vector<int> mergeSort(vector<int>& arr) {
	if (arr.size() < 2) return arr;
	const size_t mid = arr.size() / 2;
	vector<int> left(arr.begin(), arr.begin() + mid);
	vector<int> right(arr.begin() + mid, arr.end());
	return merge(mergeSort(left), mergeSort(right));
}

int solution(vector<int> &A) {
    // write your code in C++14 (g++ 6.2.0)

	A = mergeSort(A);
	
	for (const int& a : A)
		cout << a << ' ';
	cout << endl;

    int i,j,ans=1;
    for(i=0;i<A.size();i++)
    {
        if(A[i]<1 || (i>0 && A[i]==A[i-1])){
            continue;
        }
        
        if(A[i]>ans){
            return ans;
        }else{
            ans++;
           // printf("A[i]: %d\n", A[i]);
           // printf("Answer: %d\n", ans);
        }
    }
    return ans;
}


```



## 1 Palindrome Number

2022.11.15

> Given an integer `x`, return `true` *if* `x` *is a* ***palindrome****, and* `false` *otherwise*.

```c++
#include <sstream> //stringstream
#include <string> //string
#include <iostream> 
#include <algorithm> //reverse


class Solution {
public:
    bool isPalindrome(int x) {
        stringstream ss;
        string str, str2;

        if(x < 0){
            return false;
        }

        ss << x;
        ss >> str; // convert intger to string through stringstream
        str2 = str;
        cout << str2 << endl; //endl=>end line
        reverse(str.begin(), str.end());

        if(str == str2){
            return true;
        }else{
            return false;
        }
    }
};
```

## 2 Remove Duplicates from Sorted Array

2022.11.16

> Given an integer array `nums` sorted in **non-decreasing order**, remove the duplicates in-place such that each unique element appears only **once**. The **relative order** of the elements should be kept the **same**.
>
> Return `k` *after placing the final result in the first* `k` *slots of* `nums`.

```C++
/*
c++中vector和string的erase用法区别:
vector中的erase的参数是迭代器，可以从vector中删除某个位置的元素，或者是范围内的元素：
*/
iterator erase (const_iterator position);
iterator erase (const_iterator first, const_iterator last);
/*
而sring的erase方法与vector不同的是，还支持整型参数，pos为删除的首个位置，n为删除的字符串长度。
*/
basic_string & erase(size_type pos=0, size_type n=npos);
iterator erase(const_iterator position)
iterator erase(const_iterator first, const_iterator last)
/*
而vector是不支持整型参数的。
注意用迭代器作为参数时，所返回的迭代器是删除的最后一个元素的下个位置的迭代器：
因此逐个删除vector内的元素时，应该：
*/
for(vector<int>::iterator it=v.begin();it!=v.end();){
	v.erase(it);
}
```



```C++
class Solution {
public:
    int removeDuplicates(vector<int>& nums) {
    #if 0        
        int i;
        for(i = 0; i < nums.size(); i++){
            if(nums[i+1] == nums[i]){
                nums.erase(i+1); //compiler error，can not convert int to iterator
            }
        }
        return i;
    #endif 
/*
unique（C++）函数的功能是元素去重。即”删除”序列中所有相邻的重复元素(只保留一个)。
此处的删除，并不是真的删除，就是把重复元素的位置让不重复元素使用。
由于它”删除”的是相邻的重复元素，所以在使用unique函数之前，一般都会将目标序列进行排序。
*/        
    #if 0
        nums.erase(unique(begin(nums), end(nums)), end(nums));
        return size(nums);        
    #else
        nums.erase(unique(nums.begin(), nums.end()), nums.end());
        return nums.size();           
    #endif
    }
};
```



## 3 Majority Element

2022.11.17

> Given an array `nums` of size `n`, return *the majority element*.
>
> The majority element is the element that appears more than `⌊n / 2⌋` times. You may assume that the majority element always exists in the array.

```C++
//二分法排序
vector<int> merge(vector<int> a, vector<int> b) {
	vector<int> res;
	size_t ai = 0, bi = 0;
	while (ai < a.size() && bi < b.size()) {
		if (a[ai] <= b[bi])
			res.push_back(a[ai++]);
		else
			res.push_back(b[bi++]);
	}
	if (ai == a.size())
		res.insert(res.end(), b.begin() + bi, b.end());
	else if (bi == b.size())
		res.insert(res.end(), a.begin() + ai, a.end());
	return res;
}

vector<int> mergeSort(vector<int>& arr) {
	if (arr.size() < 2) return arr;
	const size_t mid = arr.size() / 2;
	vector<int> left(arr.begin(), arr.begin() + mid);
	vector<int> right(arr.begin() + mid, arr.end());
	return merge(mergeSort(left), mergeSort(right));
}

class Solution {
public:
    int majorityElement(vector<int>& nums) {
        int i;
		#if 1
        nums = mergeSort(nums);
        #else
/*
C++ STL 标准库中的 sort()  函数，本质就是一个模板函数
只对 array、vector、deque 这 3 个容器提供支持
sort默认为升序排列
必须要有的：#include<algorithm>
*/
        sort(nums.begin(),nums.end()); 
        #endif
        i = nums.size()/2;

        return nums[i];
    }
};
```



## 4 Happy Number

2022.11.18

> Write an algorithm to determine if a number `n` is happy.
>
> A **happy number** is a number defined by the following process:
>
> - Starting with any positive integer, replace the number by the sum of the squares of its digits.
> - Repeat the process until the number equals 1 (where it will stay), or it **loops endlessly in a cycle** which does not include 1.
> - Those numbers for which this process **ends in 1** are happy.
>
> Return `true` *if* `n` *is a happy number, and* `false` *if not*.

```C++
class Solution {
public:
    int getNext(int n){
        int sum = 0;
        //split the number to digits without transfering to string.
        while(n/10 != 0){
            sum += pow(n%10,2);
            n = n/10;
        }
        sum += pow(n%10,2);
        return sum;
    }

    bool isHappy(int n) {
        int slow, fast;
        slow = n;
        fast = n;
		//快慢指针法判断链表或数组是否循环的问题
        while(true){
            slow = getNext(slow);
            fast = getNext(getNext(fast));
            if(slow == 1 || fast == 1){
                return true;
            }
            if(slow == fast){
                return false;
            }
        }
    }
};
```

## 5 Best Time to Buy and Sell Stock

> You are given an array `prices` where `prices[i]` is the price of a given stock on the `ith` day.
>
> You want to maximize your profit by choosing a **single day** to buy one stock and choosing a **different day in the future** to sell that stock.
>
> Return *the maximum profit you can achieve from this transaction*. If you cannot achieve any profit, return `0`.

```C++
class Solution {
public:
    int maxProfit(vector<int>& prices) {
        #if 1
        int minP = prices[0], profit = 0, i;

        for(i = 0; i < prices.size(); i++){
            minP = min(prices[i],minP);
            profit = max(profit, (prices[i] - minP));
        }
        
        return profit;
        #else //下面一段有逻辑漏洞，无法解决 Input: prices = [7,1,9,3,0,1]
        auto minPosition = min_element(prices.begin(), prices.end());
        auto maxPosition = max_element(minPosition, prices.end());
        //留意数组最大值最小值查询以及值和位置输出方式
        cout << "minPostion:" << minPosition - prices.begin() << " minValue:" << *minPosition  << endl; 
        return *maxPosition - *minPosition;
        #endif
    }
};
```

## 6 Reverse Bits

> Reverse bits of a given 32 bits unsigned integer.
>
> **Note:**
>
> - Note that in some languages, such as Java, there is no unsigned integer type. In this case, both input and output will be given as a signed integer type. They should not affect your implementation, as the integer's internal binary representation is the same, whether it is signed or unsigned.
> - In Java, the compiler represents the signed integers using [2's complement notation](https://en.wikipedia.org/wiki/Two's_complement). Therefore, in **Example 2** above, the input represents the signed integer `-3` and the output represents the signed integer `-1073741825`.

```C++
class Solution {
public:
    uint32_t reverseBits(uint32_t n) {
        stringstream ss, ss2;
        string str;
		//留意bitset的使用方法
        bitset<32> bitvec = n;
        ss << bitvec;
        ss >> str;
        cout << str << endl;
        reverse(str.begin(), str.end());
        cout << str << endl;
        ss2 << str;
        ss2 >> bitvec;

        n = bitvec.to_ulong(); 

        return n;

    }
};
```

## 7 Contains Duplicate

2022.11.24

> Given an integer array `nums`, return `true` if any value appears **at least twice** in the array, and return `false` if every element is distinct.

```C++
class Solution {
public:
    bool containsDuplicate(vector<int>& nums) {
        sort(nums.begin(),nums.end());
        //unique返回值是迭代器
        int length = unique(nums.begin(),nums.end()) - nums.begin();
        if(length < nums.size()){
            return true;
        }
        return false;
    }
};
```



## 101 NOTE

### 1.namespace

```C++
using namespace std;
//You can use cout rather than std::cout in the context.
```

> 所谓namespace，是指标识符的各种可见范围。
> C＋＋标准程序库中的所有标识符都被定义于一个名为std的namespace中。
> <iostream>和<iostream.h>是不一样，前者没有后缀，实际上，在你的编译器include文件夹里面可以看到，二者是两个文件，打开文件就会发现，里面的代码是不一样的。
> 后缀为.h的头文件c++标准已经明确提出不支持了，早些的实现将标准库功能定义在全局空间里，声明在带.h后缀的头文件里，c++标准为了和C区别开，也为了正确使用命名空间，规定头文件不使用后缀.h。
> 因此，当使用<iostream.h>时，相当于在c中调用库函数，使用的是全局命名空间，也就是早期的c++实现；当使用<iostream>的时候，该头文件没有定义全局命名空间，必须使用namespace std；这样才能正确使用cout。

> <string.h>是旧的C头文件，对应的是基于char*的字符串处理函数；
> <string>是包装了std的C++头文件，对应的是新的strng类；

### 2.标准模板库：STL

> STL:Standard Template Library，是一套功能强大的 C++ 模板类，提供了通用的模板类和函数。这些模板类和函数可以实现多种流行和常用的算法和数据结构，如向量、链表、队列、栈。
>
> STL 中常用的一些模板类 ：vector, list, queue, stack, set, map...
>
> STL 中常用的一些算法函数：<algorithm>中的sort, unique...

### 3.迭代器：iterator

**迭代器的原理**:

> 为了提高C++编程的效率，STL中提供了许多容器，包括vector、list、map等。为了统一访问方式，STL为每种容器在实现的时候设计了一个内嵌的iterator类，不同的容器有自己专属的迭代器，使用迭代器来访问容器中的数据。迭代器对一些基本操作如*、–、++、==、!=进行了重载，使其具有了遍历复杂数据结构的能力，其遍历机制取决于所遍历的容器，迭代器的使用和指针的使用非常相似。通过begin，end函数获取容器的头部和尾部迭代器，当begin和end返回的迭代器相同时表示容器为空。简单来说，迭代器就是一个遍历的过程，像使用指针一样使用迭代器就可以访问这个容器。

=>可以想象链表容器list与数组容器vector迭代器实现的原理不同，最后呈现的性质也会有区别。

**迭代器的实现（以vector为例）**:

```C++
template<typename T> 
class Vector  
{
private:
	T* parr; //数组的指针
	int cursize;//当前元素个数 ：也可以当做当前容器中最后一个元素的后一个元素下标，用于插入操作
	int totalsize;//当前vector总大小  
 
public:
	typedef Iterator<T> iterator;
	Vector()
	{
		parr = new T[2]();//new动态分配模板类型的数组的语法格式
/*
new动态分配数组：
1.为了让new分配一个数组对象，我们需要在类型名之后跟一对方括号，在其中指明要分配的对象的数目=> int *p = new int[INT_NUM];方括号中的数必须是整型，但不必是常量
2.new T()动态分配一个数组，会得到一个元素类型（T*）的指针。
*/
		cursize = 0;
		totalsize = 2;
	}
	iterator begin()
	{
		return iterator(this, 0);
	}
	iterator end()
	{
		return iterator(this, cursize);
	}
    /* 省略 push_back(),insert() */
	~Vector()
	{
		delete[] parr; // 释放动态数组的语法格式
/*
如果在delete一个指向数组的指针时忽略了方括号（或在delete一个指向单一对象的指针时使用了方括号），其行为是未定义的。
*/
		parr = NULL;
	}
	/* 省略resize(),Show() */
	T& operator[](int index) //T&为引用格式中的类型声明
        					//要把“operator[]”看成函数名
	{
		return parr[index];
	}
 
};
```

```C++
template<typename T>
class Vector;
template<typename T>
class Iterator
{
private:
	Vector<T>* pvec; //迭代器的一种说法：对象的指针，即vector对象的指针
	int index;   //因为遍历vector用下标就可以  
public:
    //这里构造一个迭代器，用一个对vector象的指针，和 vector对象的下标，下标可以确定要具体的那个
	Iterator(Vector<T>* pv, int idx) :
		pvec(pv), index(idx)
	{}    
    //重载!= ++ -- *等等，因为迭代器的使用中要使用大量的运算符 
	bool operator!=(const Iterator left)
	{
		return index != left.index;
	}
	const Iterator operator++(int)
	{
		const Iterator tmp(*this);
		index++;
		return tmp;
	}
	/*省略余下运算符重载*/
};
```

### 4.模板：template

**模板的声明**

```C++
template <typename T>  int compare (T t1, T t2);//模板函数声明
template <typename T> class compare;//模板类声明
```

> 1.因为T是一个模版实例化时才知道的类型，所以编译器更对T不知所云，为了通知编译器T是一个合法的类型，使用typename语句可以避免编译器报错。 
> 2.template < typename var_name > class class_name; 表示var_name是一个类型， 在模版实例化时可以替换任意类型，不仅包括内置类型（int等），也包括自定义类型class。

**在模板类中使用模板类**

```C++

template <typename T>
class A
{
private:
    vector<T> vec;//<T>表示vector这个类中有未实例化的类型
};
```

也可以这样定义

```c++
template <typename T>
class B
{
private:
    vector<int> vec;//<int>就向编译器说明把模板实例化int类型
};
```

### 5.C++中&的用途

> 第一种用途：位运算中的“与”（AND）;
> 第二种用途：取地址。这个功能在C中比较常见;
> 第三种用途：引用。这个功能是C++的补充，常用在函数传参（C中一般用指针）、临时变量引用等。

C++的**引用**：

> 概念：
>
> 引用是为已存在的变量取了一个别名，引用和引用的变量共用同一块内存空间
>
> 格式：
>
> **类型& 引用变量名**(对象名) = **引用实体**；   `int& ra = a;`  ra为a的引用
>
> 特点：
>
> 引用实体和引用类型必须为同种类型
> 引用在定义时必须初始化
> 一个实体可以有多个引用，但一个引用只能引用一个实体

### 6.C++子类的构造函数后面加:冒号的作用

> 在C++类的构造函数中经常会看到如下格式的写法：

```c++
Iterator(Vector<T>* pv, int idx) : pvec(pv), index(idx)
```

> 上述语句中单冒号(:)的作用是表示后面是初始化列表，一般有三种使用场景。
>
> 1、对父类进行初始化
>
> 调用格式为子类构造函数 : 父类构造函数”，如下，其中QMainWindow是MyWindow的父类：

```C++
MyWindow::MyWindow(QWidget* parent , Qt::WindowFlags flag) : QMainWindow(parent,flag)
```

> 2、对类成员进行初始化
>
> 调用格式为“构造函数 : A(初始值),B(初始值),C(初始值)……”，如下，其中pvec、index分别是类的成员变量：

```C++
Iterator(Vector<T>* pv, int idx) : pvec(pv), index(idx)
```

> 3、对类的const成员变量进行初始化
>
> 由于const成员变量的值无法在构造函数内部初始化，因此只能在变量定义时赋值或使用初始化列表赋值。
>
> 对于2、3中的应用场景，有以下两点说明：
>
> 1、构造函数列表初始化执行顺序与成员变量在类中声明顺序相同，与初始化列表中语句书写先后无关。
>
> 2、相对于在构造函数中赋值，初始化列表执行效率更高。

(2022.11.24)
