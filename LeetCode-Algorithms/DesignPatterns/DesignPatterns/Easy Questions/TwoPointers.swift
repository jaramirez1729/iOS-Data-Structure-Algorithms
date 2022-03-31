//
//  TwoPointersAlgorithms.swift
//  DesignPatterns
//
//  Created by J.A. Ramirez on 2/27/22.
//

import Foundation

/*
 These questions come from LeetCode that are filtered by the two pointers topic.
 These are specifically questions that use two pointers but NOT questions that use the slow and fast pointer approach.
 */

// MARK: - Remove Duplicates from Sorted Array (Easy)
/*
 Given an integer array nums sorted in non-decreasing order, remove the duplicates in-place such that each unique element appears only once. The relative order of the elements should be kept the same.

 Since it is impossible to change the length of the array in some languages, you must instead have the result be placed in the first part of the array nums. More formally, if there are k elements after removing the duplicates, then the first k elements of nums should hold the final result. It does not matter what you leave beyond the first k elements.

 Return k after placing the final result in the first k slots of nums.

 Do not allocate extra space for another array. You must do this by modifying the input array in-place with O(1) extra memory.
 */
// We can use the 2 pointers approach. The first pointer will contain the index of the duplicate number in order to replace it later. The 2nd pointer will go down the list as normal to check each number. The algorithm will keep moving non-duplicate numbers to the right order. This is essentially replacing the duplicate number. When it's done, the duplicateIndex contains the position of the last valid number moved.
// Time O(N), Space O(1)
// ~30 min
func removeDuplicates(_ nums: inout [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }
    var duplicateIndex = 1 // The first pointer.
    for i in 1..<nums.endIndex { // The second pointer.
        // The (duplicateIndex - 1) position is the last valid number in the sequence. If the ith number is not a copy, then we will move the ith number right after it, at the duplicateIndex position. Then we move the first pointer ahead.
        if nums[duplicateIndex - 1] != nums[i] {
            nums[duplicateIndex] = nums[i] // Move the valid ith number to the right spot.
            duplicateIndex += 1
        }
    }
    return duplicateIndex
}

// MARK: - Remove Element (Easy)
/*
 Given an integer array nums and an integer val, remove all occurrences of val in nums in-place. The relative order of the elements may be changed.

 Since it is impossible to change the length of the array in some languages, you must instead have the result be placed in the first part of the array nums. More formally, if there are k elements after removing the duplicates, then the first k elements of nums should hold the final result. It does not matter what you leave beyond the first k elements.

 Return k after placing the final result in the first k slots of nums.

 Do not allocate extra space for another array. You must do this by modifying the input array in-place with O(1) extra memory.
 */
// Similiar to Remove Duplicates from Sorted Array, but the only difference is that it's replacing the value that we are looking for. The first pointer will keep a reference to the value we want to remove. The second pointer will traverse the list, and when we find a value that is not the value we want to remove, we will move it to the first pointer position and so forth.
// Time O(N), Space O(1)
// ~30 min
func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
    guard !nums.isEmpty else { return 0 }
    var removeIndex = 0 // The first pointer.
    for i in 0..<nums.endIndex { // The second pointer.
        // By checking it's not the value, the first pointer will remain at the value we want to remove. So when we encouter a value that is not the one we are removing, we will replace that first pointer value with the current value, and move the pointer ahead.
        if nums[i] != val {
            nums[removeIndex] = nums[i]
            removeIndex += 1
        }
    }
    return removeIndex
}

// MARK: - Implement strStr() (Easy)
/*
 Implement strStr().

 Return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.
 
 What should we return when needle is an empty string? This is a great question to ask during an interview.

 For the purpose of this problem, we will return 0 when needle is an empty string. This is consistent to C's strstr() and Java's indexOf().
 */
// Create a window of the same size as the needle. The window uses 2 pointers, but behaves more like a window here than a 2 pointer design pattern. Using a loop, we will check if the current window is equal to the needle. If it's not, we will move the window ahead  by 1. if it does, we will return the first index of where the needle appeared. 
// Time O(N), Space O(1)
// ~20 min
func strStr(_ haystack: String, _ needle: String) -> Int {
    if needle.isEmpty { return 0 }
    if needle.count > haystack.count { return -1 }
    
    // Creates a window that is the same size as the needle to check against each substring of the same size.
    var startIndex = haystack.index(haystack.startIndex, offsetBy: 0)
    var endIndex = haystack.index(haystack.startIndex, offsetBy: needle.count - 1)
    
    while endIndex < haystack.endIndex {
        // If the substring (window) is equal to the needle, then we found the first occurence.
        if haystack[startIndex...endIndex] == needle {
            return startIndex.utf16Offset(in: haystack)
        }
        // Advance both pointers ahead by 1. This moves the entire window ahead, instead of growing/shrinking as is typical with the window approach.
        startIndex = haystack.index(after: startIndex)
        endIndex = haystack.index(after: endIndex)
    }
    return -1
}

// MARK: - Merge Sorted Array (Easy)
/*
 You are given two integer arrays nums1 and nums2, sorted in non-decreasing order, and two integers m and n, representing the number of elements in nums1 and nums2 respectively.

 Merge nums1 and nums2 into a single array sorted in non-decreasing order.

 The final sorted array should not be returned by the function, but instead be stored inside the array nums1. To accommodate this, nums1 has a length of m + n, where the first m elements denote the elements that should be merged, and the last n elements are set to 0 and should be ignored. nums2 has a length of n.
 */
// Uses 2 pointers in nums1, and another pointer to traverse nums2. It compares the values in each position from the end, and inserts the greatest value at the next available spot in nums1. Depending on which one was inserted, that pointer will go down for that list.
// Time O(N), Space O(1)
// ~30 min
func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    if m == 0 { 
        nums1 = nums2
        return
    }
    // We'll insert going from the end to the start.
    var insertIndex = nums1.endIndex - 1
    var nums1Pointer = m - 1 // First pointer for nums1 (use m since it has trailing zeros).
    var nums2Pointer = nums2.endIndex - 1 // Second pointer for nums2.
    // It's inserting the largest number from the end of the list.
    while nums1Pointer >= 0 && nums2Pointer >= 0 {
        if nums1[nums1Pointer] <= nums2[nums2Pointer] {
            nums1[insertIndex] = nums2[nums2Pointer]
            nums2Pointer -= 1
        } else {
            nums1[insertIndex] = nums1[nums1Pointer]
            nums1Pointer -= 1
        }
        insertIndex -= 1
    }
    // That means we still have remaining values in list 2. It doesn't matter if nums1Pointer didn't reach 0, since if it didn't, that means nums2Pointer reached 0, and there is no more elements to add since nums1 already contains the remaining ones.
    if nums2Pointer >= 0 {
        while insertIndex >= 0 {
            nums1[insertIndex] = nums2[nums2Pointer]
            nums2Pointer -= 1
            insertIndex -= 1
        }
    }
}

// MARK: - Two Sum III - Data structure design (Easy)
/*
 Design a data structure that accepts a stream of integers and checks if it has a pair of integers that sum up to a particular value.

 Implement the TwoSum class:

 TwoSum() Initializes the TwoSum object, with an empty array initially.
 void add(int number) Adds number to the data structure.
 boolean find(int value) Returns true if there exists any pair of numbers whose sum is equal to value, otherwise, it returns false.
 */
class TwoSum {
    var nums: [Int]
    
    init() {
        nums = []
    }
    
    // Time O(N log N)
    // It's not as inneficient as it seems since each time a new number is added, the list will already be mostly sorted.
    func add(_ number: Int) {
        nums.append(number)
        nums.sort()
    }
    
    // Works by having a pointer at the start and one at the end. Adds up the current values and checks whether it's under or over the value. Move the specific pointer and then try again. This only works because the list is sorted, which is okay because it reduces the algorithm's complexity here.
    // Time O(N), Space O(1)
    func find(_ value: Int) -> Bool {
        var lowPointer = 0
        var highPointer = nums.count - 1
        while lowPointer < highPointer {
            let sum = nums[lowPointer] + nums[highPointer]
            if sum == value {
                return true
            } else if sum < value {
                // sum is too small, so we need to go higher from the start.
                lowPointer += 1
            } else {
                // sum is too large, so we need to go smaller from the end.
                highPointer -= 1
            }
        }
        return false
    }
}

// MARK: - Strobogrammatic Number (Easy)
/*
 Given a string num which represents an integer, return true if num is a strobogrammatic number.

 A strobogrammatic number is a number that looks the same when rotated 180 degrees (looked at upside down).
 */
// The only valid numbers upside down are: 0, 1, 6, 8, 9
// 0, 1 and 8 will still be the same number. 6 and 9 will be different numbers.
// A strobogrammatic number MUST be an even size EXCEPT when the center digit is 0, 1, or 8. That means that we can return false immediately if the center number is not one of those.
// Uses a pointer at both ends of the list, and compares each value with each other. If the comparison does not fit the case, it will return false, otherwise, continue after moving the pointers.
// Time O(N), Space O(1)
func isStrobogrammatic(_ num: String) -> Bool {
    // If it's an odd size, it's only valid if the center digit is 1, 0, or 8.
    if num.count % 2 == 1 {
        switch num[num.index(num.startIndex, offsetBy: num.count / 2)] {
        case "1", "8", "0": break
        default: return false
        }
    }
    var leftIndex = num.startIndex // Pointer from the left side going up.
    var rightIndex = num.index(num.startIndex, offsetBy: num.count - 1) // Pointer from the right side going down.
    while leftIndex < rightIndex {
        switch (num[leftIndex], num[rightIndex]) {
        case ("6", "9"), ("9", "6"), ("8", "8"), ("0", "0"), ("1", "1"):
            leftIndex = num.index(after: leftIndex)
            rightIndex = num.index(before: rightIndex)
        default: return false
        }
    }
    return true
}

// MARK: - Is Subsequence (Easy)
/*
 Given two strings s and t, return true if s is a subsequence of t, or false otherwise.

 A subsequence of a string is a new string that is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (i.e., "ace" is a subsequence of "abcde" while "aec" is not).
 */
// Use a pointer in s and a pointer in t. The pointer in s will ONLY move forward if the corresponding match is found in t. The pointer in t will traverse down only one time. If the pointer in s is not at the index after the last index, then it's a valid match. Only a valid match will mean that there are no more characters to check for in s.
func isSubsequence(_ s: String, _ t: String) -> Bool {
    if s.isEmpty { return true }
    if s.count > t.count { return false }
    
    var sIndex = s.startIndex // First pointer.
    for char in t { // Second "pointer".
        if s.indices.contains(sIndex) && s[sIndex] == char {
            sIndex = s.index(after: sIndex)
        }
    }
    // Only a successful match will make the index for s be after the end.
    return sIndex == s.endIndex
}

// MARK: -  Intersection of Two Linked Lists (Easy)
/*
 Given the heads of two singly linked-lists headA and headB, return the node at which the two lists intersect. If the two linked lists have no intersection at all, return null.
 
 Note that the linked lists must retain their original structure after the function returns.
 
 List A:         4 -> 1
                        \
                         8 -> 4 -> 5
                        /
 List B:    5 -> 6 -> 1
 */
// Uses a pointer for list A and a pointer for list B. Both pointers move forward by 1. When either reached the end, they will then start at the other list and keep going. At this point, both will have traversed the same number of times and eventually reached the same node, if any.
// Time O(A + B), Space(1)
func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
    var pointer1 = headA
    var pointer2 = headB
    while pointer1 !== pointer2 {
        // If any reach the end, then start at the other list.
        pointer1 = pointer1 == nil ? headB : pointer1?.next
        pointer2 = pointer2 == nil ? headA : pointer2?.next
    }
    return pointer1
}
