# 编程练习

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

## 8 Same Tree

> Given the roots of two binary trees `p` and `q`, write a function to check if they are the same or not.
>
> Two binary trees are considered the same if they are structurally identical, and the nodes have the same value.

```C++
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode() : val(0), left(nullptr), right(nullptr) {}
 *     TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
 *     TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
 * };
 */
class Solution {
public:
    bool isSameTree(TreeNode* p, TreeNode* q) {
        //先分析终止条件
        if(p == NULL && q != NULL) return false;
        if(p != NULL && q == NULL) return false;
        if(p == NULL && q == NULL) return true;
        if(p->val != q->val) return false;
		//这里递归的应用真的是浑然天成！
        return isSameTree(p->left, q->left) && isSameTree(p->right, q->right);
    }
};
```

## 9 Remove Duplicates from Sorted List

> Given the `head` of a sorted linked list, *delete all duplicates such that each element appears only once*. Return *the linked list **sorted** as well*.

```C++
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode() : val(0), next(nullptr) {}
 *     ListNode(int x) : val(x), next(nullptr) {}
 *     ListNode(int x, ListNode *next) : val(x), next(next) {}
 * };
 */
class Solution {
public:
    ListNode* deleteDuplicates(ListNode* head) {     
        if(head == NULL) return head;
        
        ListNode* temp = head;
        while(temp){
            //注意temp->next != NULL的先决条件，否则temp->next->val处报compile error：member access within null pointer
            if(temp->next != NULL && temp->val == temp->next->val){
                temp->next = temp->next->next;
            }else{
                temp = temp->next;
            }
        }

        return head;
    }
};
```

## 10.Search Insert Position

> Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.
>
> You must write an algorithm with `O(log n)` runtime complexity.

```c++
class Solution {
public:
    int searchInsert(vector<int>& nums, int target) {
        #if 0 //第一次尝试二分法，特制了长度尺len，到二分终点因为奇偶性不稳定无法得到正确答案
        int i, len, pos;
        pos = size(nums)/2;
        len = pos;
        while(len != 0){
            if(target < nums[pos]){
                len = len/2;
                pos -= len;
                cout << "min:" << pos << endl;
            }else if(target > nums[pos]){
                len = len/2;
                pos += len;
                cout << "max:" <<pos << endl;
            }else{
                return pos;
                cout << "bingo:" <<pos << endl;
            }
        }

        if(target < nums[pos - 1]){
            return pos;
        }else{
            return pos+1;
        }
        #else //正确的方法，用截取思想，简便达成
        int i=0, j=nums.size()-1;
		while(i<=j){
			int mid=i+(j-i)/2;
			if(nums[mid]==target){return mid;}
			else if(nums[mid]>target){j=mid-1;}
			else{i=mid+1;}
		}
		return i;
        #endif
    }
};
```

## 11 Ugly Number

2023.1.31

> An **ugly number** is a positive integer whose prime factors are limited to `2`, `3`, and `5`.
>
> Given an integer `n`, return `true` *if* `n` *is an **ugly number***.

```C++
static int my_count=0;
class Solution {
private:
    //非const的静态值初始化必须在类外
    //static int count=0;
public:
    bool isUgly(int n) {
        my_count++;
        if(n == 0) return false;
        if(n == 1){
            return true;
        }        
        else if(n%2 == 0){
            n/=2; 
            return isUgly(n);
        } 
        else if(n%3 == 0){
            n/=3;
            return isUgly(n); 
        } 
        else if(n%5 == 0){
            n/=5;
            return isUgly(n); 
        } 

        return false;        
    }
};
```

## 12 Fizz Buzz

> Given an integer `n`, return *a string array* `answer` *(**1-indexed**) where*:
>
> - `answer[i] == "FizzBuzz"` if `i` is divisible by `3` and `5`.
> - `answer[i] == "Fizz"` if `i` is divisible by `3`.
> - `answer[i] == "Buzz"` if `i` is divisible by `5`.
> - `answer[i] == i` (as a string) if none of the above conditions are true.

```C++
class Solution {
public:
    vector<string> fizzBuzz(int n) {
        vector<string> answer; //相较于Java需要去heap中new比如ArrayList，C++的vector直接开辟在栈中
        for(int i = 1; i <= n; i++){
           if(i%15 == 0){   
                answer.push_back("FizzBuzz");
            }else if(i%3 == 0){
                answer.push_back("Fizz");
            }else if(i%5 == 0){
                answer.push_back("Buzz");
            }else{
                //answer.push_back(i + "");=>类型转换int=>String时，Java可用这种形式：num + ""
                answer.push_back(to_string(i));
            }
        }
        return answer;
        
    }
};
```

## 13 Power of Four

> Given an integer `n`, return *`true` if it is a power of four. Otherwise, return `false`*.
>
> An integer `n` is a power of four, if there exists an integer `x` such that `n == 4x`.

```C++
class Solution {
public:
    bool isPowerOfFour(int n) { //Java 用 boolean
        if(n == 1){
            return true;
        }
        if(n%4 == 0 && n != 0){
            return isPowerOfFour(n/4);
        }
        return false;        
    }
};
```

## 14 Is Subsequence

> Given two strings `s` and `t`, return `true` *if* `s` *is a **subsequence** of* `t`*, or* `false` *otherwise*.
>
> A **subsequence** of a string is a new string that is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (i.e., `"ace"` is a subsequence of `"abcde"` while `"aec"` is not).

```java
class Solution {
public:
    bool isSubsequence(string s, string t) {
        char* cs = s.data();
        char* ts = t.data();
        int j = 0;
        bool bingo = false;
        for(int i = 0; i < s.size(); i++){ 
            for(; j < t.size(); j++){
                if(cs[i] == ts[j]){
                    bingo = true;
                    break;                          
                }
            }
            if(bingo == true){
                bingo = false;
                j++; 
            }else{
                return false;
            }
        }

        return true;
    }
};
```

## 15 Find All Numbers Disappeared in an Array

> Given an array `nums` of `n` integers where `nums[i]` is in the range `[1, n]`, return *an array of all the integers in the range* `[1, n]` *that do not appear in* `nums`.

```C++
class Solution {
public:
    vector<int> findDisappearedNumbers(vector<int>& nums) {
        int temp[nums.size()+1];
        for(int i=0;i<=nums.size();i++)//C++数组不会在栈上自动初始化为0，要手动初始化
        {
            temp[i]=0;
        }

        for(int i=0;i<nums.size();i++)
        {
            temp[nums[i]]=1;//vector数组下标似乎不能用变量，大概是vector容器重载了数组的访问形式。
        }

        vector<int> list;        
        for(int i=1;i<=nums.size();i++)
        {
            if(temp[i]==0){
                list.push_back(i);
            }
        }
        return list;        
    }
};
```

## 16 Island Perimeter

2023.2.2

> You are given `row x col` `grid` representing a map where `grid[i][j] = 1` represents land and `grid[i][j] = 0` represents water.
>
> Grid cells are connected **horizontally/vertically** (not diagonally). The `grid` is completely surrounded by water, and there is exactly one island (i.e., one or more connected land cells).
>
> The island doesn't have "lakes", meaning the water inside isn't connected to the water around the island. One cell is a square with side length 1. The grid is rectangular, width and height don't exceed 100. Determine the perimeter of the island.

```C++
class Solution {
public:
    int islandPerimeter(vector<vector<int>>& grid) {
        int ans = 0;
        for(int i = 0; i < grid.size(); i++){
            for(int j = 0; j < grid[i].size(); j++){
                if(grid[i][j] == 1){//vector版二维数组
                    ans += 4;
                    if(i != 0 && grid[i-1][j] == 1) ans -= 2;
                    if(j != 0 && grid[i][j-1] == 1) ans -= 2;
                }
            }
        }
        return ans;        
    }
};
```

## 17 Ransom Note

> Given two strings `ransomNote` and `magazine`, return `true` *if* `ransomNote` *can be constructed by using the letters from* `magazine` *and* `false` *otherwise*.
>
> Each letter in `magazine` can only be used once in `ransomNote`.

```C++
class Solution {
public:
    bool canConstruct(string ransomNote, string magazine) {
        int ascii[26];
        for(int i = 0; i < 26; i++){//相较Java，CPP数组必须初始化
            ascii[i] = 0;
        }
        for(int i = 0; i < ransomNote.size(); i++){
            ascii[ransomNote[i] - 97]--;//相较JAVA，CPP的string可以直接当字符数组用
        }
        for (int i = 0; i < magazine.size(); i++) {
            ascii[magazine[i] - 97]++;
        }
        for(int i = 0; i < 26; i++){
            if(ascii[i] < 0){
                return false;
            }
        }
        return true;        
    }
};
```

## 18 Number of Good Pairs

> Given an array of integers `nums`, return *the number of **good pairs***.
>
> A pair `(i, j)` is called *good* if `nums[i] == nums[j]` and `i` < `j`.

```C++
class Solution {
public:
    int numIdenticalPairs(vector<int>& nums) {
        map<int,int> mmap;
        for(int i = 0; i < nums.size(); ++i){
            if(mmap.count(nums[i])){
                ++mmap[nums[i]];
            }else{
                mmap[nums[i]] = 1;
            }           
        }

        int ans = 0;
        map<int, int>::iterator iter; //注意总结map的遍历方式
        for (iter = mmap.begin(); iter != mmap.end(); iter++){ 	        
            int count = iter->second;
            ans = ans + count*(count - 1)/2;
        }

        return ans;        
    }
};
```

## 19 First Bad Version

> You are a product manager and currently leading a team to develop a new product. Unfortunately, the latest version of your product fails the quality check. Since each version is developed based on the previous version, all the versions after a bad version are also bad.
>
> Suppose you have `n` versions `[1, 2, ..., n]` and you want to find out the first bad one, which causes all the following ones to be bad.
>
> You are given an API `bool isBadVersion(version)` which returns whether `version` is bad. Implement a function to find the first bad version. You should minimize the number of calls to the API.

```C++
// The API isBadVersion is defined for you.
// bool isBadVersion(int version);

class Solution {
public:
    int firstBadVersion(int n) {
        for(int i = 1; n > 2; ){
            int mid = i + ( n - i)/2;
            if(isBadVersion(mid) && !isBadVersion(mid - 1)){
                return mid;
            }else if(isBadVersion(mid)){
                n = mid - 1;
            }else{
                i = mid + 1;
            }
        }
        if(isBadVersion(1)){
            return 1;
        }else{
            return 2;
        }
    }        
};
```

## 20 Add Strings

2023.2.5

> Given two non-negative integers, `num1` and `num2` represented as string, return *the sum of* `num1` *and* `num2` *as a string*.
>
> You must solve the problem without using any built-in library for handling large integers (such as `BigInteger`). You must also not convert the inputs to integers directly.

```C++
class Solution {
public:
    string addStrings(string num1, string num2) {
        string longer = num1.size() > num2.size() ? num1 : num2;
        string shorter = num1.size() > num2.size() ? num2 : num1;
        string ans = "";//string性质几乎处处模仿char数组，只是毕竟是对象，用作一些C函数参数时还需要转化
        int ascii1, ascii2, extra = 0;
        for(int i = 1; i <= longer.size(); ++i){
            ascii1 = longer[longer.size() - i] - '0';
            if(i > shorter.size()){
                ascii2 = 0;
            }else{
                ascii2 = shorter[shorter.size() - i] - '0';
            }
            int add = ascii1 + ascii2 + extra;
            cout << add <<endl;
            ans.append(to_string(add%10));
            extra = add/10;
        }

        if(extra > 0){
            ans.append(to_string(extra));
        }
        reverse(ans.begin(), ans.end()); 
        return ans;        
    }
};
```

## 21 Construct String from Binary Tree

> Given the `root` of a binary tree, construct a string consisting of parenthesis and integers from a binary tree with the preorder traversal way, and return it.
>
> Omit all the empty parenthesis pairs that do not affect the one-to-one mapping relationship between the string and the original binary tree.

```c++
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode() : val(0), left(nullptr), right(nullptr) {}
 *     TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
 *     TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
 * };
 */
enum KIND{
    ROOT,LEFT,RIGHT
};

class Solution {
private:
    string ans;
    int preorder(TreeNode* tree, KIND num){
        if(tree == NULL){
            return 0;
        }
        ans.append("(");
        ans.append(to_string(tree->val));
        if(tree->left == NULL && tree->right != NULL){
            ans.append("()");
        }
        preorder(tree->left, LEFT);
        preorder(tree->right, RIGHT);
        ans.append(")");

        return 0;
    }    
public:
    string tree2str(TreeNode* root) {
        preorder(root, ROOT);
        ans.erase(0,1);
        ans.erase(ans.size()-1,1);
        return ans;        
    }
};
```

## 22 Flood Fill

> An image is represented by an `m x n` integer grid `image` where `image[i][j]` represents the pixel value of the image.
>
> You are also given three integers `sr`, `sc`, and `color`. You should perform a **flood fill** on the image starting from the pixel `image[sr][sc]`.
>
> To perform a **flood fill**, consider the starting pixel, plus any pixels connected **4-directionally** to the starting pixel of the same color as the starting pixel, plus any pixels connected **4-directionally** to those pixels (also with the same color), and so on. Replace the color of all of the aforementioned pixels with `color`.
>
> Return *the modified image after performing the flood fill*.

```C++
class Solution {
public:
    vector<vector<int>> floodFill(vector<vector<int>>& image, int sr, int sc, int color) {
        int oldcolor = image[sr][sc];
        image[sr][sc] = color;

        if((sr - 1 >= 0) && image[sr-1][sc] == oldcolor && image[sr-1][sc] != color){
            int tem = sr - 1;
            floodFill(image, tem, sc, color);
        }
        if((sr + 1 < image.size()) && image[sr+1][sc] == oldcolor && image[sr+1][sc] != color){
            int tem = sr + 1;
            floodFill(image, tem, sc, color);
        }
        if((sc - 1 >= 0) && image[sr][sc-1] == oldcolor && image[sr][sc-1] != color){
            int tem = sc - 1;
            floodFill(image, sr, tem, color);
        }
        if((sc + 1 < image[0].size()) && image[sr][sc+1] == oldcolor && image[sr][sc+1] != color){
            int tem = sc + 1;
            floodFill(image, sr, tem, color);
        }

        return image;        
    }
};
```

## 23 Set Mismatch

> You have a set of integers `s`, which originally contains all the numbers from `1` to `n`. Unfortunately, due to some error, one of the numbers in `s` got duplicated to another number in the set, which results in **repetition of one** number and **loss of another** number.
>
> You are given an integer array `nums` representing the data status of this set after the error.
>
> Find the number that occurs twice and the number that is missing and return *them in the form of an array*.

```C++
class Solution {
public:
    vector<int> findErrorNums(vector<int>& nums) {
        #if 0
        int res[2];
		int count[nums.size() + 1];
        for (int i = 0; i < nums.size() + 1; i++) count[i] = 0;
		for (int i = 0; i < nums.size(); i++) count[nums[i]]++;
		for (int i = 1; i < (nums.size() + 1); i++) {
		if (count[i] == 2)  res[0] = i;
		if (count[i] == 0)  res[1] = i;
		}
        vector<int> ress(res,res+2);//通过数组地址赋值vector
		return ress;
        #else
        vector<int> res; //初始化一个size为0的vector
		int count[nums.size() + 1];
        for (int i = 0; i < nums.size() + 1; i++) count[i] = 0;
		for (int i = 0; i < nums.size(); i++) count[nums[i]]++;
		for (int i = 1; i < (nums.size() + 1); i++) {
		//if (count[i] == 2)  res[0] = i; 注意不能像数组那样直接对vector赋值！
        if (count[i] == 2)  res.insert(res.begin(),i);//要通过方法
		//if (count[i] == 0)  res[1] = i;
        if (count[i] == 0)  res.insert(res.end(),i);
		}
        return res;        
        #endif
    }
};
```

## 24 Baseball Game

(2023.2.5)

> You are keeping the scores for a baseball game with strange rules. At the beginning of the game, you start with an empty record.
>
> You are given a list of strings `operations`, where `operations[i]` is the `ith` operation you must apply to the record and is one of the following:
>
> - An integer
>
>   ```
>   x
>   ```
>
>   - Record a new score of `x`.
>
> - ```
>   '+'
>   ```
>
>   - Record a new score that is the sum of the previous two scores.
>
> - ```
>   'D'
>   ```
>
>   - Record a new score that is the double of the previous score.
>
> - ```
>   'C'
>   ```
>
>   - Invalidate the previous score, removing it from the record.
>
> Return *the sum of all the scores on the record after applying all the operations*.
>
> The test cases are generated such that the answer and all intermediate calculations fit in a **32-bit** integer and that all operations are valid.

```C++
class Solution {
public:
    int calPoints(vector<string>& operations) {
        vector<int> ans;
        vector<string>::iterator it = operations.begin();
        for(;it != operations.end(); ++it){//利用迭代器遍历vector
            if(((*it)[0] > 47 && (*it)[0] < 58) 
            || (*it)[0] == 45){
                ans.push_back(stoi(*it));
            } 
            if((*it)[0] == 43 && ans.size() >= 2){
                int tem = ans[ans.size()-1] + ans[ans.size()-2];
                ans.push_back(tem);
            }
            if((*it)[0] == 68){
                ans.push_back(ans[ans.size()-1]*2);
            }
            if((*it)[0] == 67){
                ans.erase(ans.end()-1);//删除数组末位元素要用ans.end()-1
            }
        }

        int res = 0;
        vector<int>::iterator it2 = ans.begin();
        for(;it2 != ans.end(); ++it2){
            res += *it2;
        } 

        return res;        
    }
};
```

## 25 Valid Parentheses

> Given a string `s` containing just the characters `'('`, `')'`, `'{'`, `'}'`, `'['` and `']'`, determine if the input string is valid.
>
> An input string is valid if:
>
> 1. Open brackets must be closed by the same type of brackets.
> 2. Open brackets must be closed in the correct order.
> 3. Every close bracket has a corresponding open bracket of the same type.

```C++
class Solution {
public:
    bool isValid(string s) {
        stack<char> sta;
        map<char,char> mmap;
        mmap.insert(pair<char, char>('(',')'));
        mmap.insert(pair<char, char>('{','}'));
        mmap.insert(pair<char, char>('[',']'));
        for(int i = 0; i < s.size(); ++i){
            if(!sta.empty()
            && !mmap.count(s[i])
            && s[i] == mmap[sta.top()]){
                sta.pop();
            }else if(!mmap.count(s[i])){
                return false;
            }
            else{
                sta.push(s[i]);
            }
        }
        return sta.empty();//C++与Java于stack容器接口几乎相同        
    }
};
```

## 26 Maximum Product of Two Elements in an Array

> Given the array of integers `nums`, you will choose two different indices `i` and `j` of that array. *Return the maximum value of* `(nums[i]-1)*(nums[j]-1)`.

```C++
class Solution {
public:
    int maxProduct(vector<int>& nums) {
        sort(nums.begin(), nums.end());//vector排序
        //vector元素取值两种方式：1.数组下标 2.*迭代器
        //int ans = (nums[nums.size()-1]-1)*(nums[nums.size()-2]-1);
        int ans = (*(nums.end()-1)-1)*(*(nums.end()-2)-1);
        return ans;         
    }
};
```

## 27 Find Center of Star Graph

> There is an undirected **star** graph consisting of `n` nodes labeled from `1` to `n`. A star graph is a graph where there is one **center** node and **exactly** `n - 1` edges that connect the center node with every other node.
>
> You are given a 2D integer array `edges` where each `edges[i] = [ui, vi]` indicates that there is an edge between the nodes `ui` and `vi`. Return the center of the given star graph.

```c++
class Solution {
public:
    int findCenter(vector<vector<int>>& edges) {
        if(edges[0][0] == edges[1][0] || edges[0][0] == edges[1][1]) return edges[0][0];
        return edges[0][1];        
    }
};
```

## 28 Search in a Binary Search Tree

> You are given the `root` of a binary search tree (BST) and an integer `val`.
>
> Find the node in the BST that the node's value equals `val` and return the subtree rooted with that node. If such a node does not exist, return `null`.

```c++
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode() : val(0), left(nullptr), right(nullptr) {}
 *     TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
 *     TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
 * };
 */
class Solution {
private:
    TreeNode* ans;
    void preorder(TreeNode* root, int val) {
        if(root->val == val){
            ans = root;
            return;
        } 
        if(root->left != NULL) preorder(root->left, val);
        if(root->right != NULL) preorder(root->right, val);       
    }

public:
    TreeNode* searchBST(TreeNode* root, int val) {
        if(root->val == val){
            return root;
        }
        preorder(root, val);
        return ans;        
    }
};
```

## 29 Degree of an Array

> Given a non-empty array of non-negative integers `nums`, the **degree** of this array is defined as the maximum frequency of any one of its elements.
>
> Your task is to find the smallest possible length of a (contiguous) subarray of `nums`, that has the same degree as `nums`.

```C++
class Solution {
public:
    int findShortestSubArray(vector<int>& nums) {
        map<int,int> left, right, count;

        for(int i = 0; i < nums.size(); ++i){
            if(!left.count(nums[i])){
                left[nums[i]] = i;
                //cout<<nums[i] << " : " << left[nums[i]]<<endl;
            } 
            right[nums[i]] = i;
            if(count.count(nums[i])){
                count[nums[i]]++;    
            }else{
                count[nums[i]] = 1;
            }
        }
        //for(auto it = left.begin(); it != left.end(); ++it) cout<<it->first << " : " << it->second<<endl;
        //for(auto it = right.begin(); it != right.end(); ++it) cout<<it->first << " : " << it->second<<endl;
        //for(auto it = count.begin(); it != count.end(); ++it) cout<<it->first << " : " << it->second<<endl;
        int val = 0, len = 0;
        map<int, int>::iterator iter;
        iter = count.begin();
        while(iter != count.end()) {
            if(iter->second == val){
                int temlen;
                temlen = right[iter->first] - left[iter->first] + 1;
                if(temlen < len){
                    len = temlen;
                    val = iter->second;
                }
            }else if(iter->second > val){
                len = right[iter->first]  - left[iter->first]  + 1;
                val = iter->second;              
            }            
            iter++;
        }
       
        return len;        
    }
};
```

## 30 To Lower Case

> Given a string `s`, return *the string after replacing every uppercase letter with the same lowercase letter*.

```C++
class Solution {
public:
    string toLowerCase(string s) {
        transform(s.begin(),s.end(),s.begin(),::tolower);//transform是STL中的一个函数
        return s;
    }
};
```

## 31 Longest Harmonious Subsequence

2023.1.30

> We define a harmonious array as an array where the difference between its maximum value and its minimum value is **exactly** `1`.
>
> Given an integer array `nums`, return *the length of its longest harmonious subsequence among all its possible subsequences*.
>
> A **subsequence** of array is a sequence that can be derived from the array by deleting some or no elements without changing the order of the remaining elements.

```C++
class Solution {
public:
    int findLHS(vector<int>& nums) {
        map<int,int> my_map;
        for(int i = 0; i < nums.size(); ++i){
            if(my_map.count(nums[i]) > 0){//判断是否已存在key
                my_map[nums[i]]++;
                //my_map.insert(pair<int,int>(nums[i], my_map[nums[i]] + 1));  没法用insert修改value
            }else{
                //用insert时要用pair作为参数
                my_map.insert(pair<int,int>(nums[i], 1));
            }
        }
        #if 0 //打印map的方式
        for (auto it = my_map.begin(); it != my_map.end(); ++it) {
            cout << "{" << (*it).first << ": " << (*it).second << "}\n";
        }
        #endif
        sort(nums.begin(), nums.end());
        #if 0 //打印vector的方式
        for (auto i = nums.begin(); i != nums.end(); i++) {
            cout << *i << ' ';
        }
        #endif
        int len = 0;
        for(int i = 1; i < nums.size(); ++i){
            if(nums[i] == nums[i-1] + 1){
                if(len < (my_map[nums[i]] + my_map[nums[i-1]])){
                    len = my_map[nums[i]] + my_map[nums[i-1]];
                }
            }
        }
        return len;
        
    }
};
```

## 32 Word Pattern

> Given a `pattern` and a string `s`, find if `s` follows the same pattern.
>
> Here **follow** means a full match, such that there is a bijection between a letter in `pattern` and a **non-empty** word in `s`.

```C++
class Solution {
public:
    bool wordPattern(string pattern, string s) {
 
        vector<string> arr;
        //C++没有split函数，分割字符串要利用C的strtok()
        //当使用C和C++的混合编程，在某些情况下，需要将C++的string，转换成char* 的字符串。
        char *s2 = s.data();//string=>char*  
	    char *p = strtok(s2, " ");
        for(int i = 0; i < pattern.size(); ++i){
            if(p == NULL){
                return false;
            }
            //char*转string，直接赋值即可。
            string s3 = p;
            arr.push_back(s3);
            p = strtok(NULL, " ");
        }  
        if(p != NULL){
            return false;
        }

        map<char, string> mmap;
        for(int i = 0; i < pattern.size(); ++i){
            if(mmap.count(pattern[i]) == 0){
                //To check if a value exists in a C++ map, you have to iterate over all pairs.
                map<char, string>::iterator iter;
                for (iter = mmap.begin(); iter != mmap.end(); iter++) 				  {
                    if(iter->second == arr[i]){
                        return false;
                    }
                }             

                mmap.insert(pair<char, string>(pattern[i], arr[i]));
                continue; 
            }

            if(!(mmap[pattern[i]] == arr[i])){ //C++比较字符串相等可以直接用==，大概是重载运算符了
                return false;
            }          
        }

        return true;       
    }
};//C++的STL感觉没有Java.util包好用...
```

## 33 Invert Binary Tree

> Given the `root` of a binary tree, invert the tree, and return *its root*.

```C++
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode() : val(0), left(nullptr), right(nullptr) {}
 *     TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
 *     TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
 * };
 */
class Solution {
private: //C++和Java类的写法略有不同
    void invert(TreeNode* root){ 
        if(root == NULL || (root->left == NULL)&&(root->right == NULL)){ //C++用NULL，Java用null
            return;
        }
        TreeNode* tem;
        tem = root->left; //C++结构体，此处必须用->
        root->left = root->right;
        root->right = tem;
        invert(root->left);
        invert(root->right);
    }     
public:
    TreeNode* invertTree(TreeNode* root) { //C++显性用*标明地址
        if(root == NULL){
            return root;
        }
        invert(root);
        return root;        
    }
};//C++这边有冒号
```

## 41 Sort Characters By Frequency

2023.2.8

> Given a string `s`, sort it in **decreasing order** based on the **frequency** of the characters. The **frequency** of a character is the number of times it appears in the string.
>
> Return *the sorted string*. If there are multiple answers, return *any of them*.

```C++
class Solution {
public:
    string frequencySort(string s) {
        //要求前K个高频元素，用优先队列+map=>频率就可以排序了
        map<char,int> mmap;
        priority_queue<pair<char,int>, vector<pair<char,int>>, myComp> mqueue;

        //模式1：遍历数组，放入map
        for(int i = 0; i < s.size(); ++i){
            if(mmap.count(s[i])){
                ++mmap[s[i]];
            }else{
                mmap[s[i]] = 1;
            }           
        }
        //模式2：遍历map，放入queue
        map<char, int>::iterator iter; 
        for (iter = mmap.begin(); iter != mmap.end(); iter++){ 	        
            char pKey = iter->first;
            int pValue = iter->second;
            //利用初始化列表，初始化pair
            pair<char,int> mpair(pKey, pValue);
            mqueue.push(mpair);            
        }
        
		//模式3：遍历queue，放入字符串
        string str = ""; 
        while(!mqueue.empty()){
            pair<char,int> mpair = mqueue.top();
            mqueue.pop();
            int count = mpair.second;
            while(count > 0){
               str.push_back(mpair.first);
               count--; 
            }
        }

        return str;        
    }

private:
    struct myComp {
        bool operator()(pair<char,int> const& a, pair<char,int> const& b) const 
        {
            return a.second < b.second;
        }
    };
};
```

## 42 Exam Room

(2022.12.19)

> There is an exam room with `n` seats in a single row labeled from `0` to `n - 1`.
>
> When a student enters the room, they must sit in the seat that maximizes the distance to the closest person. If there are multiple such seats, they sit in the seat with the lowest number. If no one is in the room, then the student sits at seat number `0`.
>
> Design a class that simulates the mentioned exam room.
>
> Implement the `ExamRoom` class:
>
> - `ExamRoom(int n)` Initializes the object of the exam room with the number of the seats `n`.
> - `int seat()` Returns the label of the seat at which the next student will set.
> - `void leave(int p)` Indicates that the student sitting at seat `p` will leave the room. It is guaranteed that there will be a student sitting at seat `p`.

```java
class ExamRoom {
    private int n;
    //为什么用Set？用于需要存储的value作为索引值的情况
    //为什么用TreeSet？Tree即代表有序
    private TreeSet<Integer> set;

    public ExamRoom(int n) {
        this.n = n;
        set = new TreeSet<>();
    }
    
    public int seat() {
        if(set.isEmpty()){
            set.add(0);
            return 0;
        }
        if(set.size() == 1){
            if(set.first() < n/2){
                set.add(n-1);
                return n-1;                
            }
            set.add(0);
            return 0;
        }
        int pos = -1;
        int distance = -1;
        int pre = -1;

        if(set.first() != 0){
            pos = 0;
            distance = set.first();
        }
        //Java遍历set，没法像C++灵活用指针，只能用迭代器
        //所以需要额外变量来进行元素相互比较
        for(int seat : set){
            if(pre == -1){
                pre = seat;
                continue; 
            }
            if(distance < (seat - pre)/2){
                distance = (seat - pre)/2;
                pos = pre + distance;
            }
            pre = seat;
        }
        if(set.last() != n -1){
            if(distance < (n-1-set.last())){
                pos = n - 1;
            }
        }
        set.add(pos);
        return pos;        
    }
    
    public void leave(int p) {
        set.remove(p);
    }
}

/**
 * Your ExamRoom object will be instantiated and called as such:
 * ExamRoom obj = new ExamRoom(n);
 * int param_1 = obj.seat();
 * obj.leave(p);
 */
```

## 43 Keys and Rooms

(2022.12.20)

> There are `n` rooms labeled from `0` to `n - 1` and all the rooms are locked except for room `0`. Your goal is to visit all the rooms. However, you cannot enter a locked room without having its key.
>
> When you visit a room, you may find a set of **distinct keys** in it. Each key has a number on it, denoting which room it unlocks, and you can take all of them with you to unlock the other rooms.
>
> Given an array `rooms` where `rooms[i]` is the set of keys that you can obtain if you visited room `i`, return `true` *if you can visit **all** the rooms, or* `false` *otherwise*.

```java
class Solution {
    private TreeSet<Integer> set;
    private TreeMap<Integer, List<Integer>> map;

    private void Visit(int room){
        set.add(room);
        for(Integer i : map.get(room)){
            if(!set.contains(i)){
                Visit(i);
            }
        }
    }

    public boolean canVisitAllRooms(List<List<Integer>> rooms) {
        map = new TreeMap();
        int key = 0;
        for(List<Integer> i : rooms){
            map.put(key, i);
            key++;
        }
        //Map好像是据key查value，没有据value查key的说法
        List<Integer> x = map.get(0);
        set = new TreeSet();
        Visit(0);
		//return visited.size() == rooms.size();不更简洁？
        if(set.size() == rooms.size()){
            return true;
        }
        return false;
    }
}
//上记解法可以说非常慢...下记利用queue就漂亮多了,就是迭代之于递归的效率优势
/*
class Solution {
    public boolean canVisitAllRooms(List<List<Integer>> rooms) {
    	//在插入、查找方面，HashSet 通常优于TreeSet. hashSet查询和删除和增加元素的效率都非常高.
        Set<Integer> visited = new HashSet<>();
        //LinkedList既实现List接口，也实现了Queue接口
        //既可以采用声明接口，new对象的方式单独使用接口方法
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(0);
        visited.add(0);
        while (!queue.isEmpty()) {
            int i = queue.poll();
            for (int k : rooms.get(i)) {
                if (!visited.contains(k)) {
                    queue.offer(k);
                    visited.add(k);
                }
            }
        }
        return visited.size() == rooms.size();
    }
}
*/
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

### 7.C++中 :: 的三种意思

> `"::"`在C++中表示作用域和所属关系。`"::"`是运算符中等级最高的，它分为三种

#### 7.1 作用域符号

作用域符号”::“的前面一般是类名称，后面一般是该类的成员名称，C++为例避免不同的类有名称相同的成员而采用作用域的方式进行区分。

```C++
class A{
int member;
};
class B{
int member;
};
A::member;//表示类A中的成员member
B::member;//表示类B中的成员member
```

#### 7.2 全局作用域符号

当全局变量在局部函数中与其中某个变量重名，那么就可以用 :: 来区分，例如：

```C++
int a; // 全局变量
void test ()
{
	int a = ::a;//用全局变量，给本地变量a赋值
}
```

#### 7.3 作用域分解运算符

比如声明了一个类A，类A里声明了一个成员函数voidf()，但没有在类的声明里给出f的定义，那么在类外定义f时，就要写成voidA::f()，表示这个f()函数是类A的成员函数。例如：

```C++
class A
{
public:
	int test();
}
int A::test()//表示test是属于A的
{
	return 0;
}
```

(2023.2.7)

### 8.map

> map是STL的一个关联容器，以键值对存储的数据，其类型可以自己定义，每个关键字在map中只能出现一次，关键字不能修改，值可以修改；内部数据结构是红黑树；map内部有序（自动排序，单词时按照字母序排序），查找时间复杂度为O(logn)。

基本方法：

| **函数名**        | **功能**                                                     |
| ----------------- | ------------------------------------------------------------ |
| my_map.insert()   | 插入（也可以像数组那样取下标直接赋值）                       |
| my_map.begin()    | 返回指向map头部的迭代器                                      |
| my_map.end()      | 返回指向map末尾的迭代器                                      |
| my_map.count(key) | 由于map不包含重复的key，因此m.count(key)取值为0，或者1，表示是否包含。 |
| ...               | ...                                                          |

map与unordered_map区别及使用：

> map内部实现了一个红黑树，红黑树具有自动排序的功能，因此map内部的所有元素都是有序的，红黑树的每一个节点都代表着map的一个元素。因此，对于map进行的查找，删除，添加等一系列的操作都相当于是对红黑树进行的操作。
> unordered_map内部实现了一个哈希表，查找的时间复杂度可达到O(1)，其在海量数据处理中有着广泛应用。其元素的排列顺序是无序的。对于查找问题，unordered_map会更加高效一些。

> unordered_map的用法和map是一样的，提供了 insert，size，count等操作，并且里面的元素也是以pair类型来存贮的。其底层实现是完全不同的，上方已经解释了，但是就外部使用来说却是一致的。

### 9.stack

> **栈(Stack)是一种线性存储结构，它具有如下特点：**
>
> （1）栈中的数据元素遵守“先进后出"(First In Last Out)的原则，简称FILO结构。
>
> （2）限定只能在栈顶进行插入和删除操作

```C++
#include< stack >
stack< int > s;
s.empty();         //如果栈为空则返回true, 否则返回false;
s.size();          //返回栈中元素的个数
s.top();           //返回栈顶元素, 但不删除该元素
s.pop();           //弹出栈顶元素, 但不返回其值
s.push();          //将元素压入栈顶
```



### 10.priority_queue

### 11.UML

UML规定函数成员的语法为：
[访问控制属性] 名称 [（参数表）] [：返回类型] [约束特性]

访问控制属性：

- public： +
- private： -
- protected： #

1.泛化（Generalization）: 

**【泛化关系】**：是一种继承关系，表示一般与特殊的关系，它指定了子类如何特化父类的所有特征和行为。例如：老虎是动物的一种，即有老虎的特性也有动物的共性。
**【箭头指向】**：带三角箭头的实线，箭头指向父类

5.组合(Composition)

**【组合关系】**：是整体与部分的关系，但部分不能离开整体而单独存在。如公司和部门是整体和部分的关系，没有公司就不存在部门。组合关系是关联关系的一种，是比聚合关系还要强的关系，它要求普通的聚合关系中代表整体的对象负责代表部分的对象的生命周期。

**【代码体现】**：成员变量

**【箭头及指向】**：带实心菱形的实线，菱形指向整体

### 12 关键词

throw

**我们知道C++ 异常处理的流程**，具体为：抛出（Throw）--> 检测（Try） --> 捕获（Catch）

在 C++ 中，我们使用 throw 关键字来显式地抛出异常，它的用法为：

```C++
throw exceptionData;
//exceptionData 是“异常数据”的意思，它可以包含任意的信息，完全有程序员决定。exceptionData 可以是 int、float、bool 等基本类型，也可以是指针、数组、字符串、结构体、类等聚合类型
```

```C++
//自定义的异常类型
class OutOfRange{
	//...
};

int Array::pop(){
    if(m_len == 0){
         throw OutOfRange();  //抛出异常（创建一个匿名对象）
    }

    m_len--;
    return *(m_p + m_len);
}

int main(){
    Array nums;
	//...
    try{
        for(int i=0; i<20; i++){
            nums.pop();
        }
    }catch(OutOfRange &e){
		//...
    }
	//...
}

```

