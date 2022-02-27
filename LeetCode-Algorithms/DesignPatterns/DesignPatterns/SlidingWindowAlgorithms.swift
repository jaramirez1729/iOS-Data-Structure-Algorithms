//
//  SlidingWindowPatterns.swift
//  DesignPatterns
//
//  Created by J.A. Ramirez on 2/26/22.
//

import Foundation
import UIKit

/*
 These questions come from LeetCode that are filtered by the sliding window topic.
 */

// MARK: - Contains Duplicates II (Easy)
/*
 Given an integer array nums and an integer k, return true if there are two distinct indices i and j in the array such that nums[i] == nums[j] and abs(i - j) <= k.
 */
// Listen: We have to find 2 indices that have the same number and only if the size between the indices is <= k. It's basically asking to return true if there are any duplicates in a window of size k. We don't actually need to keep track of i and j because we use a sliding window, the indices used will always be different.
// Use a sliding window. We will store every number encountered into a dictionary. When we grow the window, check if that number is already in the list. If it is, then return true. If it's not in the list, then we will add it. Then, we need to check if the current window size is greater than k. If it is, we need to remove the value out of the list that is going out of the window. Then, we will increase the starting window index.
// Time O(N), Space O(N)
// <30 min
func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
    var windowEndIndex = 0
    var windowStartIndex = 0
    var duplicates = [Int: Int]() // Num: Index
    
    while windowEndIndex < nums.count {
        let num = nums[windowEndIndex]
        if duplicates[num] != nil { // If the key already exists, then we have a duplicate.
            return true
        } else {
            duplicates[num, default: 0] += 1
        }
        
        // Shrink the window if it's greater than k, and remove the value going out the window.
        if abs(windowEndIndex - windowStartIndex + 1) > k {
            let prevNum = nums[windowStartIndex]
            if let existingCount = duplicates[prevNum] {
                (existingCount - 1 == 0) ? (duplicates[prevNum] = nil) : (duplicates[prevNum]! -= 1)
            }
            windowStartIndex += 1
        }
        
        // Grow the window for the next value.
        windowEndIndex += 1
    }
    
    return false
}

// MARK: - Maximum Average Subarray I (Easy)
/*
 You are given an integer array nums consisting of n elements, and an integer k.

 Find a contiguous subarray whose length is equal to k that has the maximum average value and return this value. Any answer with a calculation error less than 10-5 will be accepted.
 */
// [1, 2, 3, 4], k = 3
// End = 4, Start = 2
// Total = 2 + 3 + 4
// Average = 3
// Time O(N), Space O(1)
// <15 min
func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
    var windowEndIndex = 0
    var windowStartIndex = 0
    var total = 0.0
    var average = Double(Int.min)
    
    while windowEndIndex < nums.count {
        let num = nums[windowEndIndex] // The next number when we increase the window.
        total += Double(num) // Running total.
        
        // If we have reached the size of the window, we need to calculate the current average and store it if it's greater.
        if windowEndIndex - windowStartIndex + 1 == k {
            average = max(average, total / Double(k))
            // Shrink the window to check the next k sized window.
            let prevNum = nums[windowStartIndex]
            total -= Double(prevNum)
            windowStartIndex += 1
        }
        windowEndIndex += 1 // Grow the window for the next element.
    }
    return average
}

// MARK: - Diet Plan Performance (Easy)
/*
 A dieter consumes calories[i] calories on the i-th day. 

 Given an integer k, for every consecutive sequence of k days (calories[i], calories[i+1], ..., calories[i+k-1] for all 0 <= i <= n-k), they look at T, the total calories consumed during that sequence of k days (calories[i] + calories[i+1] + ... + calories[i+k-1]):

 If T < lower, they performed poorly on their diet and lose 1 point; 
 If T > upper, they performed well on their diet and gain 1 point;
 Otherwise, they performed normally and there is no change in points.
 Initially, the dieter has zero points. Return the total number of points the dieter has after dieting for calories.length days.

 Note that the total points can be negative.
 */
// We can use a sliding window that is the size of k and move it by k times forward to calculate the next consecutive days.
// [1, 2, 3, 4, 5, 6]; k = 2
// Time O(N), Space (1)
// <15 min
func dietPlanPerformance(_ calories: [Int], _ k: Int, _ lower: Int, _ upper: Int) -> Int {
    var windowStart = 0
    var windowEnd = 0
    var total = 0
    var points = 0
    
    while windowEnd < calories.count {
        let currentCalories = calories[windowEnd]
        total += currentCalories
        
        // If the current window is of size k, then we have already calculated k days. Determine what to do with the points.
        if windowEnd - windowStart + 1 == k {
            if total < lower { 
                points -= 1
            } else if total > upper {
                points += 1
            }
            // Shrink the window and remove the calories that are going out the window.
            windowStart += 1
            total -= calories[windowStart - 1]
        }
        windowEnd += 1
    }
    return points
}

// MARK: - Longest Nice Substring (Easy)
/*
 A string s is nice if, for every letter of the alphabet that s contains, it appears both in uppercase and lowercase. For example, "abABB" is nice because 'A' and 'a' appear, and 'B' and 'b' appear. However, "abA" is not because 'b' appears, but 'B' does not.

 Given a string s, return the longest substring of s that is nice. If there are multiple, return the substring of the earliest occurrence. If there are none, return an empty string.
 */
// Time O(N), Space O(1)
func longestNiceSubstring(_ s: String) -> String {
    var windowStart = 0
    var windowEnd = 0
    var substring = ""
    var currentGreatest = 0
    var validStart = 0 // The starting index of the current greatest nice substring.
    var validEnd = 0 // The ending index of the current greatest nice substring.

    // The window will grow until it reaches the end of the string.
    // Then, it will move the start ahead by 1 and start again growing a new window until the end, etc.
    // There is no point starting a new window if the remaining characters are smaller than the last greatest because there is no possible way to find another greatest nice string if there aren't enough remaining characters.
    while windowStart < (s.count - currentGreatest + 1) {
        let endChar = s[s.index(s.startIndex, offsetBy: windowEnd)]
        substring += String(endChar)

        if isNiceString(substring) && substring.count > currentGreatest {
            validStart = windowStart
            validEnd = windowEnd
            currentGreatest = substring.count
        }
        // Grow the window for the next character.
        windowEnd += 1

        // If the window end has reached the end of the string, then shrink the window start.
        if windowEnd == s.count {
            windowStart += 1
            // If the remaining characters cannot make a string greater than the current greatest, exit.
            if s.count - windowStart <= currentGreatest { break }

            // Starts a new window search.
            windowEnd = windowStart
            substring = ""
        }
    }

    // If the size is less than 2, then it's not valid.
    if (validEnd - validStart + 1) < 2 { return "" }

    let startIndex = s.index(s.startIndex, offsetBy: validStart)
    let endIndex = s.index(s.startIndex, offsetBy: validEnd)
    return String(s[startIndex...endIndex])
}

// The set size of all letters lowercased is twice as large as the set size of all letters.
// aAbB: aabb = ab = 2 == 4 = aAbB - valid
// aAcc: aacc = ac = 2 !== 3 = aAc - not valid
private func isNiceString(_ str: String) -> Bool {
    return Double(Set(str.lowercased()).count) == (Double(Set(str).count) / 2.0)
}

// MARK: - Substrings of Size Three with Distinct Characters (Easy)
/*
 A string is good if there are no repeated characters. Given a string s​​​​​, return the number of good substrings of length three in s​​​​​​.

 Note that if there are multiple occurrences of the same substring, every occurrence should be counted.
 */
// Uses a sliding window. Each time the size has been reached, check it, and then remove the character going out of the window.
// Time O(N), Space O(1)
// <15 min
func countGoodSubstrings(_ s: String) -> Int {
    guard s.count >= 3 else { return 0 }
    
    var windowStart = 0
    var windowEnd = 0
    var goodStrings = 0
    var substring = ""
    
    while windowEnd < s.count {
        substring += String(s[s.index(s.startIndex, offsetBy: windowEnd)])
        
        if substring.count == 3 {
            if substring.count == Set(substring).count {
                goodStrings += 1
            } 
            // Shrink the window.
            windowStart += 1
            substring.removeFirst()
        }
        // Grow the window.
        windowEnd += 1
    }
    
    return goodStrings
}

// MARK: - Minimum Difference Between Highest and Lowest of K Scores (Easy)
/*
 You are given a 0-indexed integer array nums, where nums[i] represents the score of the ith student. You are also given an integer k. 
 
 Pick the scores of any k students from the array so that the difference between the highest and the lowest of the k scores is minimized.

 Return the minimum possible difference.
 */
// Input: [9,4,1,7]; Answer: 2
// Sorting the list will make it easier to compare differences. After the sort, the k contiguous array will have scores as close to each other as possible. We can use a sliding window and to check only after the it's equal to a size of k, then just get the difference between the smallest and largest values in the window.
// Time O(N Log N + N), Space O(N)
// <35 min due to not properly understanding what difference is supposed to be calculated.
func minimumDifference(_ nums: [Int], _ k: Int) -> Int {
    var windowStart = 0
    var windowEnd = 0
    var minDiff = Int.max
    let sortedNums = nums.sorted() // Runs in (N log N)
    
    while windowEnd < sortedNums.count {
        // We only check the window if it's the size k.
        if (windowEnd - windowStart + 1) == k {
            // Get the minimum difference from the highest and lowest in the window.
            minDiff = min(minDiff, sortedNums[windowEnd] - sortedNums[windowStart])
            // Shrink the window.
            windowStart += 1
        }
        // Grow the window.
        windowEnd += 1
    }
    return minDiff
}
