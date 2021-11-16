//
//  Algorithms.swift
//  ArrayAlgorithms
//
//  Created by J.A. Ramirez on 11/13/21.
//

import Foundation

// MARK: - Find the Union of 2 Sorted Arrays
// Listen: The union should only have 1 element of every occurence. 
// Example: A = [2, 4, 6, 8, 12] and B = [3, 5, 4, 43, 100, 8]
// Brute: Loop through A and check if that value exists in B. If it does, then add it to the
//         new list only if that list does not already contain it. Return that list.
// Optimize (BUD), Walkthrough, Implement, Test
// Time: O(a * b + u) Space: O(u)
func findUnionOfArrays(a: [Int], b: [Int]) -> [Int]  {
    var union = [Int]()
    // O(a)
    for val in a {
        // O(b) and O(u)
        if b.contains(val) && !union.contains(val) {
            union.append(val)
        }
    }
    return union
}

// MARK: - Find the Factorials of a Given N
// Time: O(n); Space: O(1)
func findFactorial(of n: Int) -> Int {
    if n == 0 { return 1 }
    
    var ans = 1
    for i in 1...n  {
        ans *= i
    }
    return ans
}


// MARK: - Find the Maximum Index
/* Given an array A[] of N positive integers. The task is to find the maximum of j - i subjected to the constraint of A[i] < A[j] and i < j.
 */
// Listen, Example: [1, 3, 0, 8, 10]
// Brute: Use 2 pointers. The first pointer starts at the begining and the second pointer starts at the 2nd value. We compare A[i] < A[j] and if it's true and if it's greater than the stored result, store it and store the difference i - j. Whe have to have an inner loop to incremement j to allow every comparison between each index. When i has reached the last value in the array, we are done.
// Optimize (BUD): 
// Walkthrough: i = 0, 1; j = 1; diff = 0, 1; 1 < 3? 1 - 0 > 0? ;; 1 < 0? 1 < 8? 1 < 10? ;; 
// Implement, Test
// Time: O(a * j)?; Space: O(1)
func findMaximumIndex(in a: [Int]) -> Int {
    var indexDiff = 0
    
    for i in 0..<(a.count - 1) { // O(a)
        // If the list size is 5...
        // If i = 0; j = 1, 2, 3, 4; 4 times
        // If i = 1; j = 2, 3, 4; 3 times
        // If i = 2; j = 3, 4; 2 times
        // If i = 3; j = 4; 1 time
        for j in (i + 1)..<a.count { // O(j)
            if a[i] <= a[j] && j - i >= indexDiff {
                indexDiff = j - i
            }
        }
    }
    return indexDiff
}

// MARK: - Two Numbers That Sum to a Given Value
// Find 2 numbers that sum up to a given value from the list, if any.
// Listen; Example: 18, [4, 3, 32, 1, 5, 8, 15, 0]
// Brute: Loop through the list and add each one with each other and check if it
//         is equal to the sum and return those numbers.
// Optimize(BUD): Making several comparisons is slow. Can we use memoization?
// We can loop through the list and get the difference from the sum and that value.
// Save the difference in a dictionary and put the given value for that key.
// We have to check if the difference already exists, and if it does, then that means
// there is already a number stored that makes that and return those values.
// Walkthrough: num = 4, 3, 32, 1, 5, 8, 15, 
//                diff = 14, 15, -14, 17, 13, 10, 3
//                dict = [14: 4, 15: 3, -14: 32, 17: 1, 13; 5, 10: 8, ]
// Implement, Test
// Time: O(n), Space: O(n)
func findNumbersThatSum(to sum: Int, from list: [Int]) -> [Int] {
    var dict: [Int: Int] = [:]
    for num in list {
        let diff = sum - num
        if let value = dict[num] {
            return [value, num]
        } else {
            dict[diff] = num
        }
    }
    return []
}

// MARK: - Implement the Binary Search Algorithm
func binarySearch(val: Int, on list: [Int]) -> Int {
    guard !list.isEmpty else { return -1 }
    return binarySearchList(val: val, start: 0, end: list.count - 1, list: list)
}

func binarySearchList(val: Int, start: Int, end: Int, list: [Int]) -> Int {
    let middle = (end + start) / 2
    if val == list[middle] {
        return middle
    } else if start == end {
        return -1
    } else if val < list[middle] {
        return binarySearchList(val: val, start: start, end: middle - 1, list: list)
    } else {
        return binarySearchList(val: val, start: middle + 1, end: end, list: list)
    }
}

// MARK: - Implement the Bubble Sort Algorithm
// A bubble sort "bubbles" large values to the end of the list. It makes adjacent comparisons
// until there is nothing more to be compared.
// Listen, Example: [4, 5, 1, 10, 2, 21, 6, 9, 7]
// Brute, Optimize (BUD), Walkthrough, Implement, Test
func bubbleSort(_ list: [Int]) -> [Int] {
    guard list.count > 1 else { return list }
    
    var mList = list
    for end in (1..<list.count).reversed() {
        for i in 0..<end {
            if mList[i] > mList[i + 1] {
                mList.swapAt(i, i + 1)
            }
        }
    }
    return mList
}

// MARK: - Implement the Selection Sort Algorithm
func selectionSort(_ list: [Int]) -> [Int] {
    guard list.count > 1 else { return list }
    
    var mList = list
    for a in 0..<mList.count {
        var smallest = mList[a]
        var smallestIndex = a
        for b in (a + 1)..<mList.count {
            if mList[b] < smallest {
                smallest = mList[b]
                smallestIndex = b
            }
        }
        mList.swapAt(a, smallestIndex)
    }
    return mList
}

// MARK: - Implement the Insertion Sort Algorithm
func insertionSort(_ list: [Int]) -> [Int] {
    guard list.count > 1 else { return list }
    
    var mList = list
    for a in 1..<mList.count {
        var b = a
        while b > 0 && mList[b] < mList[b - 1] {
            mList.swapAt(b, b - 1)
            b -= 1
        }
    }
    return mList
}
