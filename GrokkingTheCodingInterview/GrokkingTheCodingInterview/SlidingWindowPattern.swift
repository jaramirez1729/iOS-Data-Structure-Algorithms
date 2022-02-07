//
//  SlidingWindowPattern.swift
//  GrokkingTheCodingInterview
//
//  Created by J.A. Ramirez on 2/5/22.
//

import Foundation
/*
 Imagine a window that moves down a collection. The window can be used to improve efficiency by knowing the item removed and the next item added, and thus being able to use the values in the window more efficiently.
 */

// MARK: - Maximum Sum Subarray of Size K (Easy)
/*
 Given an array of positive numbers and a positive number k, find the maximum sum of any contiguous subarray of size k.
 */

// Uses a sliding window of fixed size k. The window will have a total, and when it's time to move the window ahead, the last value is removed and the next value is added. This calculates the sum without having to do duplicate work.
// O(N), O(1)
func findMaxSumSubArray(in list: [Int], size k: Int) -> Int {
    var maxSum = 0
    var windowSum = 0
    var windowStartIndex = 0 // The last window's value to remove after sliding the window forward.
    
    for windowEndIndex in 0..<list.endIndex {
        windowSum += list[windowEndIndex] // Add the next element to the window running sum.
        
        // We only slide the window after we reached the window size.
        if windowEndIndex >= k - 1 {
            maxSum = max(maxSum, windowSum) // Store the max of the current total or new window sum.
            windowSum -= list[windowStartIndex] // Remove the element going out of the window.
            windowStartIndex += 1 // Slide the window ahead.
        }
    }
    
    return maxSum
}

// MARK: - Smallest Subarray with a Greater Sum (Easy)
/*
 Given an array of positive numbers and a positive number ‘S,’ find the length of the smallest contiguous subarray whose sum is greater than or equal to ‘S’. Return 0 if no such subarray exists.
 */

// Uses a sliding window but the size is not static. We need to create a window until we reach the sum s, and then keep shrinking the window from the start to try to achieve the least size subarray. If the sum of the shrunk window is under the target, then we need to expand it.
// O(N), O(1)
func findMinSumSubArray(in list: [Int], target s: Int) -> Int {
    var windowSum = 0
    var minLength = Int.max
    var windowStartIndex = 0
    
    for windowEndIndex in 0..<list.endIndex {
        windowSum += list[windowEndIndex] // Add the next element.
        
        // Keep shrinking the window until it's no longer over the target.
        while windowSum >= s {
            minLength = min(minLength, windowEndIndex - windowStartIndex + 1)
            windowSum -= list[windowStartIndex] // Remove the value kicked out of the window as it shrinks.
            windowStartIndex += 1 // Move the window start forward, thus shrinking it.
        }
    }
    
    return (minLength == Int.max) ? 0 : minLength
}

// MARK: - Longest Substring with K Distinct Characters (Medium)
/*
 Given a string, find the length of the longest substring in it with no more than K distinct characters.
 */
func FindLongestSubstring(in str: String, withDistinct k: Int) -> Int {
    var chars = str.map { String($0) }
    var charFrequency = [String: String]()
    var windowStartIndex = 0
    var maxLenght = 0
    
    for windowEndIndex in 0..<chars.endIndex {
        
    }
    
    return maxLenght
}

struct MyJson: Codable {
    var a: Int
}

let a = MyJson(a: <#T##Int#>)
