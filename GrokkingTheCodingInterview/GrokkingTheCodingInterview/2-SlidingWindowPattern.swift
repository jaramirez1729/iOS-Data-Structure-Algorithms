//
//  SlidingWindowPattern.swift
//  GrokkingTheCodingInterview
//
//  Created by J.A. Ramirez on 2/5/22.
//

import Foundation
/*
 Imagine a window that moves down a collection. The window can be used to improve efficiency by knowing the item removed and the next item added, and thus being able to use the values in the window more efficiently. The window is managed by a starting and ending index that determines when the window should grow or shrink or move forward.
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
    var windowStartIndex = 0 // The first window's value to remove after sliding the window forward.
    
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
// Time O(N), Space O(N)
func FindLongestSubstring(in str: String, withDistinct k: Int) -> Int {
    var windowStartIndex = 0
    var maxLength = 0
    var charFrequency = [String: Int]()
    let chars = str.map { String($0) }

    for windowEndIndex in 0..<chars.endIndex {
        let rightChar = chars[windowEndIndex]
        charFrequency[rightChar, default: 0] += 1 // Add a counter for the next character.
        
        // Shrink the sliding window until we have k distinct characters.
        while charFrequency.count > k {
            let leftChar = chars[windowStartIndex] // Get the first character in the window.
            charFrequency[leftChar]? -= 1 // Remove a counter for that character.
            if charFrequency[leftChar] == 0 {
                charFrequency.removeValue(forKey: leftChar)
            }
            windowStartIndex += 1 // Shrink the window from the left.
        }
        // After shrinking, update the maximum length so far.
        maxLength = max(maxLength, windowEndIndex - windowStartIndex + 1)
    }
    return maxLength
}

// MARK: - Fruits into Baskets (Medium)
/*
 Given an array of characters where each character represents a fruit tree, you are given two baskets, and your goal is to put maximum number of fruits in each basket. The only restriction is that each basket can have only one type of fruit.

 You can start with any tree, but you can’t skip a tree once you have started. You will pick one fruit from each tree until you cannot, i.e., you will stop when you have to pick from a third fruit type.

 Write a function to return the maximum number of fruits in both baskets.
 */
// Sounds confusing, but it's essentially asking for the longest substring with 2 distinct characters.
// This is the same algorithm as the parent question, just worded differently. 
// Time O(N), Space O(1)
func fruitsIntoBaskets(_ fruits: [String]) -> Int {
    var windowStartIndex = 0
    var maxLength = 0
    var charFrequency = [String: Int]()
    let chars = fruits.map { String($0) }

    for windowEndIndex in 0..<chars.endIndex {
        let rightChar = chars[windowEndIndex]
        charFrequency[rightChar, default: 0] += 1 // Add a counter for the next character.
        
        // Shrink the sliding window until we have 2 distinct characters.
        while charFrequency.count > 2 { // THE ONLY DIFFERENCE
            let leftChar = chars[windowStartIndex] // Get the first character in the window.
            charFrequency[leftChar]? -= 1 // Remove a counter for that character.
            if charFrequency[leftChar] == 0 {
                charFrequency.removeValue(forKey: leftChar)
            }
            windowStartIndex += 1 // Shrink the window from the left.
        }
        // After shrinking, update the maximum length so far.
        maxLength = max(maxLength, windowEndIndex - windowStartIndex + 1)
    }
    return maxLength
}

// MARK: - Longest Substring with Distinct Characters (Hard)
/*
 Given a string, find the length of the longest substring, which has all distinct characters.
 */
// Uses a dynamic sliding window. The indexes of the character is stored in a dictionary. If a duplicate is found, it will shrink the window to the next index after the duplicate character to start a new unique string.
// Time O(N), Space O(K)
func FindLongestDistinctSubstring(in str: String) -> Int {
    var windowStartIndex = 0
    var maxLength = 0
    var charIndexes = [String: Int]()
    let chars = str.map { String($0) }
    
    for windowEndIndex in 0..<chars.endIndex {
        let rightChar = chars[windowEndIndex]
        // If the dictionary already contains the character, shrink the window so that we have only one occurrence.
        if let index = charIndexes[rightChar] {
            // Since a duplicate was found, we know the current substring is invalid, so we will start the window at the next character from the stored index of the duplicate.
            windowStartIndex = max(windowStartIndex, index + 1)
        }
        charIndexes[rightChar] = windowEndIndex // Mark the index position of the current character.
        maxLength = max(maxLength, windowEndIndex - windowStartIndex + 1)
    }
    
    return maxLength
}

// MARK: - Longest Substring with Same Letters after Replacement (Hard)
/*
 Given a string with lowercase letters only, if you are allowed to replace no more than ‘k’ letters with any letter, find the length of the longest substring having the same letters after replacement.
 */
// Uses a dynamic sliding window. Keep track of the number of times characters appear. We will also record the character that repeats the most as we traverse the string. We only shrink the window if there are more tha k letters in the window because we cannot replace more than k characters.
// Time O(N), Space O(1) assumming  26 character set, which means at most it would be O(26) ~= O(1).
func findLongestReplacementSubstring(in str: String, replacements k: Int) -> Int {
    var windowStartIndex = 0
    var maxLength = 0
    var maxRepeatLetterCount = 0
    var frequencyDict = [Character: Int]()
    
    for windowEndIndex in 0..<str.count {
        let rightChar = str[str.index(str.startIndex, offsetBy: windowEndIndex)]
        frequencyDict[rightChar, default: 0] += 1
        // Record the character with the highest occurrences of repeats.
        maxRepeatLetterCount = max(maxRepeatLetterCount, frequencyDict[rightChar]!)
        
        // current window size is from windowStart to windowEnd, overall we have a letter which is repeating 'maxRepeatLetterCount' times, this means we can have a window which has one letter repeating 'maxRepeatLetterCount' times and the remaining letters we should replace. If the remaining letters are more than 'k', it is the time to shrink the window as we are not allowed to replace more than 'k' letters.
        if ((windowEndIndex - windowStartIndex + 1) - maxRepeatLetterCount) > k {
            let leftChar = str[str.index(str.startIndex, offsetBy: windowStartIndex)]
            frequencyDict[leftChar]! -= 1
            windowStartIndex += 1
        }
        maxLength = max(maxLength, windowEndIndex - windowStartIndex + 1)
    }
    return maxLength
}
// MARK: - Longest Subarray with Ones after Replacement (Hard)
/*
 Given an array containing 0s and 1s, if you are allowed to replace no more than ‘k’ 0s with 1s, find the length of the longest contiguous subarray having all 1s.
 */
// Uses a dynamic sliding window like the previous problem. Keep track of the number of times 1 appears. We only shrink the window if there are more tha k letters in the window because we cannot replace more than k 0s.
// Time O(N), Space O(1)
func findLongestReplacementSubarray(in nums: [Int], replacements k: Int) -> Int {
    var windowStartIndex = 0
    var maxLength = 0
    var maxOnesCount = 0
    
    for windowEndIndex in 0..<nums.endIndex {
        let rightNum = nums[windowEndIndex]
        maxOnesCount += (rightNum == 1) ? 1 : 0
        
        // current window size is from windowStart to windowEnd, overall we have a maximum of 1s repeating a maximum of 'maxOnesCount' times, this means that we can have a window with 'maxOnesCount' 1s and the remaining are 0s which should replace with 1s. Now, if the remaining 0s are more than 'k', it is the time to shrink the window as we are not allowed to replace more than 'k' Os.
        if ((windowEndIndex - windowStartIndex + 1) - maxOnesCount) > k {
            let leftNum = nums[windowStartIndex]
            maxOnesCount -= (leftNum == 1) ? 1 : 0
            windowStartIndex += 1
        }
        maxLength = max(maxLength, windowEndIndex - windowStartIndex + 1)
    }
    
    return maxLength
}

// MARK: - Problem Challenge #1: Permutation in a String (Hard)
/*
 Given a string and a pattern, find out if the string contains any permutation of the pattern.

 Permutation is defined as the re-arranging of the characters of the string. For example, “abc” has the following six permutations:
 abc
 acb
 bac
 bca
 cab
 cba
 If a string has ‘n’ distinct characters, it will have n! permutations.
 */
// Uses 2 dictionaries to store the number of times characters appear in the pattern and in the window and compares them each time. The book solution is slightly more efficient in that it does not keep a count for the window characters. Instead, it removes characters found from the pattern dictionary and keeps a counter for characters that have been matched yet.
// Time O(N + M), Space O(N + M)
func findPattern(in str: String, pattern: String) -> Bool {
    var windowStartIndex = 0
    let chars = str.map { String($0) }
    // Keep a count of how many times each character appears in the pattern.
    var patternFrequency = [String: Int]()
    pattern.map { String($0) }.forEach { patternFrequency[$0, default: 0] += 1 }
    // Keep a count of the characters in the current window.
    var windowFrequency = [String: Int]()
    
    for windowEndIndex in 0..<chars.endIndex {
        let endChar = chars[windowEndIndex]
        windowFrequency[endChar, default: 0] += 1
        
        // If the window is the same size as the pattern, then check if the dictionaries are the same.
        if windowEndIndex - windowStartIndex + 1 == pattern.count {
            // If they are the same, that means it's a valid permutation.
            if patternFrequency == windowFrequency {
                return true
            } else {
                // Shrink the window and remove a count for the letter going out of the window.
                let startChar = chars[windowStartIndex]
                if let count = windowFrequency[startChar] {
                    windowFrequency[startChar] = (count - 1 == 0) ? nil : count - 1
                }
                windowStartIndex += 1
            }
        }
    }
    return false
}

// MARK: - Problem Challenge #2: String Anagrams (Hard)
/*
 Given a string and a pattern, find all anagrams of the pattern in the given string.

 Every anagram is a permutation of a string. As we know, when we are not allowed to repeat characters while finding permutations of a string, we get N! permutations (or anagrams) of a string having N characters. For example, here are the six anagrams of the string “abc”:
 abc
 acb
 bac
 bca
 cab
 cba
 Write a function to return a list of starting indices of the anagrams of the pattern in the given string.
 */
// This is the same as the previous question, except we are keeping a count of the starting indexes and then shrinking the window as we go.
// Time O(N + M), Space O(N + M)
func findAnagrams(in str: String, pattern: String) -> [Int] {
    var windowStartIndex = 0
    let chars = str.map { String($0) }
    // Keep a count of how many times each character appears in the pattern.
    var patternFrequency = [String: Int]()
    pattern.map { String($0) }.forEach { patternFrequency[$0, default: 0] += 1 }
    // Keep a count of the characters in the current window.
    var windowFrequency = [String: Int]()
    var indices = [Int]()
    
    for windowEndIndex in 0..<chars.endIndex {
        let endChar = chars[windowEndIndex]
        windowFrequency[endChar, default: 0] += 1
        
        // If the window is the same size as the pattern, check if we found an anagram and then shrink the window.
        if windowEndIndex - windowStartIndex + 1 == pattern.count {
            // If they are the same, that means it's a valid anagram.
            if patternFrequency == windowFrequency {
                indices.append(windowStartIndex)
            }
            // Shrink the window and remove a count for the letter going out of the window.
            let startChar = chars[windowStartIndex]
            if let count = windowFrequency[startChar] {
                windowFrequency[startChar] = (count - 1 == 0) ? nil : count - 1
            }
            windowStartIndex += 1
        }
    }
    return indices
}

// MARK: - Problem Challenge #3: Smallest Window containing Substring (Hard)
/*
 Given a string and a pattern, find the smallest substring in the given string which has all the characters of the given pattern.
 */
// Whenever the number of matched characters has been reached, it shrinks the window. It also keeps track of the smallest substring that contains all characters.
// Time O(N + M), Space O(N + M)
func findSmallestSubstring(in str: String, pattern: String) -> String {
    var windowStartIndex = 0
    var matched = 0
    // Controls the start and end of the substring. The window is only used for traversal, not to contain the substring.
    var substringStart = 0
    var minLength = str.count + 1
    let chars = str.map { String($0) }
    var charFrequency = [String: Int]()
    pattern.map { String($0) }.forEach { charFrequency[$0, default: 0] += 1 }
    
    for windowEndIndex in 0..<chars.endIndex {
        let rightChar = chars[windowEndIndex]
        if let count = charFrequency[rightChar] {
            charFrequency[rightChar] = count - 1
            // Count every matching of a character. If it is a duplicate, it will just go negative which is fine since we will increase it as we shrink the window and move matched characters out.
            if count - 1 >= 0 { matched += 1 }
        }
        
        // Shrink the window if we can, finish as soon as we remove a matched character.
        while matched == pattern.count {
            if minLength > (windowEndIndex - windowStartIndex + 1) {
                minLength = windowEndIndex - windowStartIndex + 1
                substringStart = windowStartIndex
            }
            
            let leftChar = chars[windowStartIndex]
            windowStartIndex += 1
            if let count = charFrequency[leftChar] {
                // Note that we could have redundant matching characters, therefore we'll decrement the matched count only when a useful occurrence of a matched character is going out of the window. This also increments the count if it was negative, so it keeps shrinking it with duplicates.
                if count == 0 { matched -= 1 }
                charFrequency[leftChar] = count + 1
            }
        }
    }
    if minLength > str.count { return "" }
    
    return chars[substringStart..<(substringStart + minLength)].joined()
}

// MARK: - Problem Challenge #4: Words Concatenation (Hard)
/*
 Given a string and a list of words, find all the starting indices of substrings in the given string that are a concatenation of all the given words exactly once without any overlapping of words. It is given that all words are of the same length.
 */
/* 
 let str = "catfoxcat"
 let words = ["cat", "fox"]
 wordFreq = ["cat": 1, "fox": 1]
 indices = [0, ]
 
 for i in 0..<4:
    0: wordsSeen = ["cat": 1, "fox": 1]
        for j in 0..<2:
            0: nextWordIndex = 0; word = "cat"
            1: nextWordIndex = 3; word = "fox"; append i.
    1: wordsSeen = []
        for j in 0..<2:
            0: nextWordIndex = 1; 
 */
// Time O(N * M * Len), Space O(M + N)
func findSubstringIndices(in str: String, with words: [String]) -> [Int] {
    guard !str.isEmpty && !words.isEmpty else { return [] }

    var wordFreq = [String: Int]()
    words.forEach { wordFreq[$0, default: 0] += 1 }
    let chars = str.map {String($0)}
    var resultIndices = [Int]()
    let wordsCount = words.count
    let wordLenght = words[0].count
    // If we were to partition str into wordLenght sections, then the i represents the index for the start of the next sequence of wordLenght substrings to check. Each word loop is accounted for with j.
    // For "catfoxcatfox", if i = 0, it loops through [cat|fox|cat|fox]
    // If i = 1, it loops through c[atf|oxc|atf]ox
    // If i = 2, it loops through ca[tfo|xca|tfo]x
    // If i = 3, it loops through cat[fox|cat|fox]
    // Finally i = 4, it loops through catf[oxc|atf]ox
    // Notice the sliding window moves in wordLength width.
    let upperBound = (str.count - wordsCount * wordLenght) + 1
    guard upperBound >= 0 else { return [] }
    for i in 0..<upperBound {
        var wordsSeen = [String: Int]()
        for j in 0..<wordsCount { // Loop the list of words.
            let nextWordIndex = i + j * wordLenght // Every wordLenght substring offset by i.
            let word = chars[nextWordIndex..<(nextWordIndex + wordLenght)].joined()
            print(word)
            if wordFreq[word] == nil { break } // If we find a word not in the list, then go to next word.
            wordsSeen[word, default: 0] += 1 // Add the word to the ones seen.
            // No need to process further if the current word has a higher frequency than required. Essentially means that a duplicate was found of a word we already accounted for completely.
            if let seenCount = wordsSeen[word], let freqCount = wordFreq[word], seenCount > freqCount {
                break
            }
            // If we found all the words, then store the index. The (j + 1) means we're at the last word.
            if j + 1 == wordsCount {
                resultIndices.append(i)
            }
        } 
    }
    return resultIndices
}
