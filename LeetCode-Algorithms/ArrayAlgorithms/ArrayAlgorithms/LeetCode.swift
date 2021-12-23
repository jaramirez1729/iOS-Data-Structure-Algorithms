//
//  LeetCode.swift
//  ArrayAlgorithms
//
//  Created by J.A. Ramirez on 11/18/21.
//

import Foundation

// MARK: - Remove Duplicates from Sorted Array
/*
 Given an integer array nums sorted in non-decreasing order, remove the duplicates in-place such that each unique element appears only once. The relative order of the elements should be kept the same.
 
 Since it is impossible to change the length of the array in some languages, you must instead have the result be placed in the first part of the array nums. More formally, if there are k elements after removing the duplicates, then the first k elements of nums should hold the final result. It does not matter what you leave beyond the first k elements.
 
 Return k after placing the final result in the first k slots of nums.
 
 Do not allocate extra space for another array. You must do this by modifying the input array in-place with O(1) extra memory.
 */
// Listen, Example: [0,0,1,1,1,2,2,3,3,4]
// Brute: Start at position 0, and store that number. Traverse the rest of the list and remove any numbers that are
// the same as the current number. Then repeat for the next number. Time O(n^2)
// Optimize (BUD): We can use 2 pointers. One to maintain a position after the last unique
// value, and the 2nd pointer to keep track of the comparison value.
func removeDuplicates(_ nums: inout [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }
    // We start at 1 to since the first value is already unique.
    var k = 1, j = 1
    while j < nums.endIndex {
        // If the traversed value does not equal to the previous one in the list, we just set the new unique value in the place of k.
        if nums[j] != nums[k - 1] {
            nums[k] = nums[j]
            k += 1
            j += 1
        } else {
            j += 1
        }
    }
    return k
}

// MARK: - Best Time to Buy and Sell Stock II
/*
 You are given an integer array prices where prices[i] is the price of a given stock on the ith day.
 
 On each day, you may decide to buy and/or sell the stock. You can only hold at most one share of the stock at any time. However, you can buy it then immediately sell it on the same day.
 
 Find and return the maximum profit you can achieve.
 */
// Listen: The question is worded confusingly, but it's essentially asking to find the greatest
// amount of differences between values. You don't need to compare each value with every other
// one since you can just determine the greatest difference between 2 values.
// Example: [7,1,5,3,6,4]
func maxProfit(_ prices: [Int]) -> Int {
    var profit = 0
    if prices.isEmpty { return profit }
    for index in 1..<prices.count {
        profit += max(0, prices[index] - prices[index - 1])
    }
    return profit
}

// MARK: - Rotate Array
/* 
 Given an array, rotate the array to the right by k steps, where k is non-negative.
 */
// Listen, Example: Input: [1,2,3,4,5,6,7], k = 3; Output: [5,6,7,1,2,3,4]
// Brute: Traverse the array from the end k number of times. For each loop,
// we will remove the last element and place it at the beginning.
// Optimize: 
func rotate(_ nums: inout [Int], _ k: Int) {
    // Shifting by the same number of elements does nothing.
    if nums.count == k || k == 0 { return }
    
    for _ in 1...k {
        if let last = nums.popLast() {
            nums.insert(last, at: 0)
        }
    }
}

// MARK: - Contains Duplicate
/*
 Given an integer array nums, return true if any value appears at least twice in the array, and return false if every element is distinct.
 */
func containsDuplicate(_ nums: [Int]) -> Bool {
    return Set(nums).count != nums.count
}

// MARK: - Single Number
/*
 Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.
 
 You must implement a solution with a linear runtime complexity and use only constant extra space.
 */
// Listen, Example: [1i, 0, 1]
// Brute: 
// Optimize (BUD): 
// Walkthrough: 
// Implement; Test
func singleNumber(_ nums: [Int]) -> Int {
    var dict = [Int: Int]()
    nums.forEach({ dict[$0, default: 0] += 1 })
    return dict.first { $1 == 1 }?.key ?? 0
}

//func singleNumber(_ nums: [Int]) -> Int {
//    // The bitwise XOR operator.
//    return nums.reduce(0) { $0 ^ $1 }
//}

// MARK: - Intersection of Two Arrays II
/*
 Given two integer arrays nums1 and nums2, return an array of their intersection. Each element in the result must appear as many times as it shows in both arrays and you may return the result in any order.
 */
// Example: Input: nums1 = [1,2,2,1], nums2 = [2,2]; Output: [2,2]
// Brute: Make 2 dictionaries. If they both have the same keys,
// then that means they both have those values. dict1[1: 2, 2: 2], dict2[2: 2]
func first_intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var dict1 = [Int: Int]()
    nums1.forEach { dict1[$0, default: 0] += 1 }    // O(n)
    
    var dict2 = [Int: Int]()
    nums2.forEach { dict2[$0, default: 0] += 1 }    // O(n)
    
    var intersection = [Int]()
    dict1.forEach { (key: Int, value: Int) in   // O(n)
        if let num = dict2[key] {
            let min = min(num, value)
            intersection.append(contentsOf: Array(repeating: key, count: min))
        }
    }
    
    return intersection
}

// More optimized.
func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var dict = [Int: Int]()
    var intersection = [Int]()
    let (smallerNums, largerNums) = min(nums1.count, nums2.count) == nums1.count ? (nums1, nums2) : (nums2, nums1)
    
    smallerNums.forEach { dict[$0, default: 0] += 1 }
    largerNums.forEach { 
        if let val = dict[$0], val > 0 {
            dict[$0] = val - 1
            intersection.append($0)
        }
    }
    return intersection
}

// MARK: - Plus One
/*
 You are given a large integer represented as an integer array digits, where each digits[i] is the ith digit of the integer. The digits are ordered from most significant to least significant in left-to-right order. The large integer does not contain any leading 0's.
 
 Increment the large integer by one and return the resulting array of digits.
 */
// Traverse the list backwards. Add 1 to the current position and determine if there is a carry-over.
// As traversal goes down the list, add the carry-over. If the position is at the start of the array,
// insert 1 at the begining.
func plusOne(_ digits: [Int]) -> [Int] {
    // Use 1 as the starting value so we can add 1 as we start the array loop.
    var carryOver = 1
    var mDigits = digits
    for i in (0..<digits.endIndex).reversed() {
        let result = digits[i] + carryOver
        mDigits[i] = result % 10    // Ensures only 0 - 9 values can be placed in position.
        carryOver = result > 9 ? 1 : 0

        if i == 0 && carryOver == 1 {
            mDigits.insert(1, at: 0)
        }
    }
    return mDigits
}

// MARK: - Move Zeroes
/*
 Given an integer array nums, move all 0's to the end of it while maintaining the relative order of the non-zero elements.
 
 Note that you must do this in-place without making a copy of the array.
 */
func moveZeroes(_ nums: inout [Int]) {
    guard nums.count > 1 else { return }
    // Return immediately if all the values are the same.
    guard Set(nums).count != 1 else { return }
    
    var i = nums.endIndex - 1
    while i >= 0 {
        if nums[i] == 0 {
            nums.remove(at: i)
            nums.append(0)
        }
        i -= 1
    }
}

// MARK: - Two Sum
/*
 Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
 
 You may assume that each input would have exactly one solution, and you may not use the same element twice.
 
 You can return the answer in any order.
 */
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var diffIndexes = [Int: Int]()
    
    for i in 0..<nums.endIndex {
        let difference = target - nums[i]
        if let index = diffIndexes[nums[i]] {
            return [index, i]
        } else {
            diffIndexes[difference] = i
        }
    }
    return []
}

// MARK: - Valid Sudoku
/*
 Determine if a 9 x 9 Sudoku board is valid. Only the filled cells need to be validated according to the following rules:
 
 Each row must contain the digits 1-9 without repetition.
 Each column must contain the digits 1-9 without repetition.
 Each of the nine 3 x 3 sub-boxes of the grid must contain the digits 1-9 without repetition.
 Note:
 
 A Sudoku board (partially filled) could be valid but is not necessarily solvable.
 Only the filled cells need to be validated according to the mentioned rules.
 */
// O(n^2 + n)
func isValidSudoku(_ board: [[Character]]) -> Bool {
    var collection = [Character: Character]()

    // Validate the rows. O(n^2)
    var isValidRows = true
    rowLoop: for row in 0..<board.endIndex {
        for column in 0..<board.endIndex {
            let char = board[row][column]
            if let element = collection[char], element == char {
                isValidRows = false
                break rowLoop
            }  else if char != "." {
                collection[char] = char
            }
        }
        collection.removeAll()
    }
        
    // Validate the columns. O(n^2)
    var isValidColumns = true
    columnLoop: for column in 0..<board.endIndex {
        for row in 0..<board.endIndex {
            let char = board[row][column]
            if let element = collection[char], element == char {
                isValidColumns = false
                break columnLoop
            }  else if char != "." {
                collection[char] = char
            }
        }
        collection.removeAll()
    }
    
    // Validate the 3x3 sub-boxes. O(n)
    var isValidSubBox = true
    offsetLoop: for rowOffset in stride(from: 0, to: 9, by: 3) {
        for columnOffset in stride(from: 0, to: 9, by: 3) {
            for row in 0..<3 {
                for column in 0..<3 {
                    let char = board[row + rowOffset][column + columnOffset]
                    if let element = collection[char], element == char {
                        isValidSubBox = false
                        break offsetLoop
                    } else if char != "." {
                        collection[char] = char
                    }
                }
            }
            collection.removeAll()
        }
    }
    
    return isValidRows && isValidColumns && isValidSubBox
}

// MARK: - Rotate Image
/*
 You are given an n x n 2D matrix representing an image, rotate the image by 90 degrees (clockwise).

 You have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.
 */
// A rotation can be achieved using transposition and then reversing.
func rotate(_ matrix: inout [[Int]]) {
    var temp = 0
    // Transpose first by flipping it through the diagonal.
    for row in 0..<matrix.endIndex {
        for column in row..<matrix.endIndex {
            temp = matrix[row][column]
            matrix[row][column] = matrix[column][row]
            matrix[column][row] = temp
        }
    }
    
    // Flip the transposed result for the final result.
    for column in 0..<matrix.count / 2 {
        for row in 0..<matrix.endIndex {
            temp = matrix[row][(matrix.endIndex - 1) - column]
            matrix[row][(matrix.endIndex - 1) - column] = matrix[row][column]
            matrix[row][column] = temp
        }
    }
}
