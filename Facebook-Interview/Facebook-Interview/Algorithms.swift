//
//  Algorithms.swift
//  Facebook-Interview
//
//  Created by J.A. Ramirez on 1/17/22.
//

// MARK: - Longest Substring Without Repeating Characters
/*
 Given a string s, find the length of the longest substring without repeating characters.
 
 Input: s = "abcabcbb"
 Output: 3
 Explanation: The answer is "abc", with the length of 3.
 
 Input: s = "bbbbb"
 Output: 1
 Explanation: The answer is "b", with the length of 1.
 
 Input: s = "pwwkew"
 Output: 3
 Explanation: The answer is "wke", with the length of 3.
 Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.
 */
// The longest substring will have unique characters.
// When we find a long substring, we only replace it if the new substring is greater than the one we found.
// We know if a new substring is unique by simply checking the substring doesn't already contain that character.
// Brute: We can use 2 pointers: the first pointer will point to the start of the potential substring. The 2nd pointer will go down the list and check if the next character is valid. If it is, we will append that character to the current substring we are building. If we find a repeating character, check if the substring we have so far is greater than the previous one. if it is, then store the new substring. This is very inneficient as it will check all substrings without repeating characters.
// 
// Optimize (BUD): Since we know the longest one found so far, why not just check the next m characters that is equal to the longest one we found so far? This will prevent doing unnecessary loops after finding the first longest substring.
// 
// s = "abcabcbb"
func lengthOfLongestSubstring(_ s: String) -> Int {
    guard !s.isEmpty else { return 0 }
    guard s.count != 1 else { return 1 }
    
    var substring = ""
    var p1 = 0
    var p2 = 1
    let chars = Array(s).map { String($0) }
    
    var tempSubstring = chars[p1]
    while p2 < chars.endIndex {
        // In case the previous mapping made a string with duplicates, move the window to the right and re-calculate.
        if Set(tempSubstring).count != tempSubstring.count {
            p1 += 1
            p2 += 1
            tempSubstring = chars[p1...(p1 + tempSubstring.count - 1)].joined()
            continue
        }
        
        if !tempSubstring.contains(chars[p2]) {
            tempSubstring += chars[p2] 
        } else {
            p1 += 1
            // Create a string immediately from the next characters that match the size of the longest one found so far.
            // This will save time from recreating a string that is the same size of the longest one found so far.
            tempSubstring = chars[p1...(p1 + tempSubstring.count - 1)].joined()
        }
        if tempSubstring.count > substring.count {
            substring = tempSubstring
        }
        p2 += 1
    }
    
    return substring.count
}

// LeetCode Optimal Solution: The optimal solution is to use the sliding window technique, in which a "window" is moved to the right by a single character each time there is a duplicate. This prevents having to check substrings that were already seen when trying to find the earlier longest substring.

// MARK: - Roman to Integer
/*
 Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.

 Symbol       Value
 I             1
 V             5
 X             10
 L             50
 C             100
 D             500
 M             1000
 
 For example, 2 is written as II in Roman numeral, just two one's added together. 12 is written as XII, which is simply X + II. The number 27 is written as XXVII, which is XX + V + II.

 Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII. Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:

 I can be placed before V (5) and X (10) to make 4 and 9. 
 X can be placed before L (50) and C (100) to make 40 and 90. 
 C can be placed before D (500) and M (1000) to make 400 and 900.
 Given a roman numeral, convert it to an integer.
 
 Input: s = "III"
 Output: 3
 Explanation: III = 3.
 Example 2:

 Input: s = "LVIII"
 Output: 58
 Explanation: L = 50, V= 5, III = 3.
 Example 3:

 Input: s = "MCMXCIV"
 Output: 1994
 Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.
 */
// Brute: We can hold a hash map to create a mapping between the roman numerals to their values. We loop through the input, and calculate the value based on the given character. We have to also check for special cases such as IV, IX, XL, XC, CD, and CM. If we find I, keep checking how many are to the right and count.
// 
// LeetCode Solution: The algorithm can be optimzed. We can loop from the end and determine if the next previous symbol is smaller or larger, and then we can add or subtract depending on it.
let romanMap = ["M": 1000, "D": 500, "C": 100, "L": 50, "X": 10, "V": 5, "I": 1]
func romanToInt(_ s: String) -> Int {
    let chars = Array(s).map { String($0) }
    var lastValue = romanMap[chars.last ?? ""] ?? 0
    var total = lastValue
    
    for i in stride(from: chars.count - 2, to: -1, by: -1) {
        if let currentValue = romanMap[chars[i]] {
            if currentValue < lastValue {
                total -= currentValue
            } else {
                total += currentValue
            }
            lastValue = currentValue
        }
    }
    return total
}

// MARK: - 3Sum
/*
 Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.
 */
// [-1, 0, 1, 2, -1, -4] => [-4, -1, -1, 0, 1, 2]
// 
// We will use a 2-pointer approach. We will fix 1 value as the pivotIndex. The low will be +1 more than the pivot and the high will decrease from the end. We will check if the value of high + low + pivot = 0, and if it is, store the values. Continue until low is greater than high.
// O(n log n + nm), O(n)
func threeSum(_ nums: [Int]) -> [[Int]] {
    guard nums.count > 2 else { return [] }
    var sums = [[Int]]()
    let sortedNums = nums.sorted()  // O(n log n)
    var low = 1
    var high = nums.count - 1
    
    for pivotIndex in 0..<sortedNums.count - 2 {    // O(n)
        // Only proceed if the index is the start, and while the next number isn't the same as the last number.
        if pivotIndex == 0 || sortedNums[pivotIndex - 1] != sortedNums[pivotIndex] {
            low = pivotIndex + 1
            high = nums.count - 1
            
            while low < high { // O(m)
                let sum = sortedNums[high] + sortedNums[low] + sortedNums[pivotIndex]
                if sum < 0 {
                    low += 1
                } else if sum > 0 {
                    high -= 1
                } else {
                    sums.append([sortedNums[high], sortedNums[low], sortedNums[pivotIndex]])
                    high -= 1
                    low += 1
                    // Avoid duplicate answers by moving the smaller pointer ahead.
                    while low < high && sortedNums[low] == sortedNums[low - 1] { low += 1 }
                }
            }
        }
    }
    return sums
}

// MARK: - 
