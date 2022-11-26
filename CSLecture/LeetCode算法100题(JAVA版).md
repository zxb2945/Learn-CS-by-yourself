# 编程练习

## 1 Palindrome Number

2022.11.25

> Given an integer `x`, return `true` *if* `x` *is a* ***palindrome****, and* `false` *otherwise*.

```java
class Solution {
    public boolean isPalindrome(int x) {
        String str = String.valueOf(x);
        String str2 = new StringBuffer(str).reverse().toString();  
        if(str.equals(str2)){
            System.out.println(str);
            return true;
        }
        System.out.println(str2);
        return false;
    }
}
```

## 2 Remove Duplicates from Sorted Array

> Given an integer array `nums` sorted in **non-decreasing order**, remove the duplicates in-place such that each unique element appears only **once**. The **relative order** of the elements should be kept the **same**.
>
> Return `k` *after placing the final result in the first* `k` *slots of* `nums`.

```java
class Solution {
    public int removeDuplicates(int[] nums) {

        int count=1;
        for(int i =0 ;i<nums.length-1;i++){
            if(nums[i] != nums[i+1]){
                nums[count] =nums[i+1];
                count++;
            }
        }
        return count;
    
    }
}
```

## 3 Majority Element

> Given an array `nums` of size `n`, return *the majority element*.
>
> The majority element is the element that appears more than `⌊n / 2⌋` times. You may assume that the majority element always exists in the array.

```java
class Solution {
    public int majorityElement(int[] nums) {
        int i;

        Arrays.sort(nums);
        i = nums.length/2;

        return nums[i];       
    }
}
```

## 4 Happy Number

> Write an algorithm to determine if a number `n` is happy.
>
> A **happy number** is a number defined by the following process:
>
> - Starting with any positive integer, replace the number by the sum of the squares of its digits.
> - Repeat the process until the number equals 1 (where it will stay), or it **loops endlessly in a cycle** which does not include 1.
> - Those numbers for which this process **ends in 1** are happy.
>
> Return `true` *if* `n` *is a happy number, and* `false` *if not*.

```java
class Solution {
    int getNext(int n){
        int sum = 0;
        //split the number to digits
        while(n != 0){
            sum += Math.pow(n%10,2);
            n = n/10;
        }
        return sum;
    }
    
    public boolean isHappy(int n) {
        int slow, fast;
        slow = n;
        fast = n;

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
}
```

## 5 Best Time to Buy and Sell Stock

> You are given an array `prices` where `prices[i]` is the price of a given stock on the `ith` day.
>
> You want to maximize your profit by choosing a **single day** to buy one stock and choosing a **different day in the future** to sell that stock.
>
> Return *the maximum profit you can achieve from this transaction*. If you cannot achieve any profit, return `0`.

```java
class Solution {
    public int maxProfit(int[] prices) {
        int minP = prices[0], profit = 0, i;

        for(i = 0; i < prices.length; i++){
            minP = Math.min(prices[i],minP);
            profit = Math.max(profit, (prices[i] - minP));
            //minP = prices[i] > minP ? minP : prices[i];
            //profit = profit > (prices[i] - minP) ? profit : (prices[i] - minP);
        }
        
        return profit;        
    }
}
```

## 6 Reverse Bits

> Reverse bits of a given 32 bits unsigned integer.
>
> **Note:**
>
> - Note that in some languages, such as Java, there is no unsigned integer type. In this case, both input and output will be given as a signed integer type. They should not affect your implementation, as the integer's internal binary representation is the same, whether it is signed or unsigned.
> - In Java, the compiler represents the signed integers using [2's complement notation](https://en.wikipedia.org/wiki/Two's_complement). Therefore, in **Example 2** above, the input represents the signed integer `-3` and the output represents the signed integer `-1073741825`.

```java
public class Solution {
    // you need treat n as an unsigned value
    public int reverseBits(int n) {
        int ans = 0;
        for (int i = 0; i < 32; ++i){
           ans <<= 1;
           ans = ans | (n&1);
           n >>= 1;   
        } 
       return ans;       
/*		想通过转化为string来完成反转，JAVA没有stringstream类就很不方便
        byte[] arr = new byte[4];
        for(int i = 0; i < 4; i++){
            arr[i] = (byte)(n >> (i*8) & 0xFF);
            System.out.println(arr[i]);
        }
        System.out.println(Arrays.toString(arr));
        //StringBuffer str = new StringBuffer(arr);
        String str = new String(arr);
        System.out.println(str);
        String str2 = new StringBuffer(str).reverse().toString();
        System.out.println(str);  
        byte[] arr2 = str.getBytes();
        return 0;
 */      
    }
}
```

## 7 Contains Duplicate

> Given an integer array `nums`, return `true` if any value appears **at least twice** in the array, and return `false` if every element is distinct.

```java
class Solution {
    public boolean containsDuplicate(int[] nums) {
        Arrays.sort(nums);
        for(int i = 1; i < nums.length; i++){
            if(nums[i] == nums[i-1]){
                return true;
            }
        }
        return false;
    }
}
```

## 8 Same Tree

> Given the roots of two binary trees `p` and `q`, write a function to check if they are the same or not.
>
> Two binary trees are considered the same if they are structurally identical, and the nodes have the same value.

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public boolean isSameTree(TreeNode p, TreeNode q) {
        if(p == null && q != null) return false;
        if(p != null && q == null) return false;
        if(p == null && q == null) return true;
        if(p.val != q.val) return false;

        return isSameTree(p.left, q.left) && isSameTree(p.right, q.right);
    }
}
```

## 9 Remove Duplicates from Sorted List

> Given the `head` of a sorted linked list, *delete all duplicates such that each element appears only once*. Return *the linked list **sorted** as well*.

```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public ListNode deleteDuplicates(ListNode head) {
         if(head == null) return head;
        
        ListNode temp = head;
        while(temp != null){
            if(temp.next != null && temp.val == temp.next.val){
                temp.next = temp.next.next;
            }else{
                temp = temp.next;
            }
        }

        return head;       
    }
}
```

## 10 Search Insert Position

> Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.
>
> You must write an algorithm with `O(log n)` runtime complexity.

```java
class Solution {
    public int searchInsert(int[] nums, int target) {
        int i=0, j=nums.length-1;
		while(i<=j){
			int mid=i+(j-i)/2;
			if(nums[mid]==target){return mid;}
			else if(nums[mid]>target){j=mid-1;}
			else{i=mid+1;}
		}
		return i;
        
    }
}
```

## 101 NOTE

### 1.java-数组常用api

1. 获取数组长度：`arrays .length()`

   ```java
   //在Java中要求一个数组的长度也可以直接用length属性来获取
   int []A = {1,2,3}; 
   int len = A.length;
   ```

2. 返回指定数组的元素以字符串的形式：`arrays.toString();` 所以toSrting方法可以直接通过类名Arrays调用，可以提取目标数组所有元素，并按顺序转化为字符串

   ```java
   System.out.println(Arrays.toString(newArr));
   //输出：[1, 2, 4, 5, 6, 6, 5, 4, 7, 6, 7, 5]，带括号
   ```

3. 数组也有对应的增强for语句，语法结构如下：

   ```java
   //需要注意的是，必须新声明一个变量，使用声明过的变量是不可以的
   for(int i : array){
   System.out.println(i) //i依次取数组array每一个元素的值
   }
   ```

4. sort：数组排序

   ```java
   int[] a={10,2,30,45,5};
   Arrays.sort(a);
   ```

























