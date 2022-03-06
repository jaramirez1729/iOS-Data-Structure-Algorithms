//
//  TwoPointersAlgorithms.swift
//  DesignPatterns
//
//  Created by J.A. Ramirez on 2/27/22.
//

import Foundation

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
// Time O(N), Space O(1)
// ~30 min
func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
    guard !nums.isEmpty else { return 0 }
    var duplicateIndex = 0 // The first pointer.
    for i in 0..<nums.endIndex { // The second pointer.
        // By checking it's not the value, the first pointer will remain at the value we want to remove. So when we encouter a value that is not the one we are removing, we will replace that first pointer value with the current value, and move the pointer ahead.
        if nums[i] != val {
            nums[duplicateIndex] = nums[i]
            duplicateIndex += 1
        }
    }
    return duplicateIndex
}

// MARK: - Implement strStr() (Easy)
/*
 Implement strStr().

 Return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.
 
 What should we return when needle is an empty string? This is a great question to ask during an interview.

 For the purpose of this problem, we will return 0 when needle is an empty string. This is consistent to C's strstr() and Java's indexOf().
 */
// Uses 2 pointers and the window pattern. The 2 pointers form a window that is the same size as the needle. We will check the substring from pointer 1 to pointer 2. if it's not a match, we will move the pointers ahead by 1.
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
        // Advance both pointers ahead by 1.
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
// Uses 2 pointers in nums1, and another pointer to traverse nums2. It compares the values in each position from the end, and inserts the greatest value at the next available spot in nums1. Depending on which one was inserted, that pointer will go down.
// Time O(N), Space O(1)
// ~30 min
func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    if m == 0 { 
        nums1 = nums2
        return
    }
    // We'll insert going from the end to the start.
    var insertIndex = nums1.endIndex - 1
    var i = m - 1 // First pointer for nums1 (use m since it has trailing zeros).
    var j = nums2.endIndex - 1 // Second pointer for nums2.
    while i >= 0 && j >= 0 {
        if nums1[i] <= nums2[j] {
            nums1[insertIndex] = nums2[j]
            j -= 1
        } else {
            nums1[insertIndex] = nums1[i]
            i -= 1
        }
        insertIndex -= 1
    }
    // That means we still have remaining values in list 2. It doesn't matter if i didn't reach 0, since if it didn't, that means j reached 0, and there is no more elements to add since nums1 already contains the remaining ones.
    if j >= 0 {
        while insertIndex >= 0 {
            nums1[insertIndex] = nums2[j]
            j -= 1
            insertIndex -= 1
        }
    }
}
