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
func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
    
    return 0
}
