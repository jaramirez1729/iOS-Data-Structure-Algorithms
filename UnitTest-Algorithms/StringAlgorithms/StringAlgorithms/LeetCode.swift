//
//  LeetCode.swift
//  StringAlgorithms
//
//  Created by J.A. Ramirez on 11/20/21.
//

import Foundation

// MARK: - Reverse String
/*
 Write a function that reverses a string. The input string is given as an array of characters s.

 You must do this by modifying the input array in-place with O(1) extra memory.
 */
func reverseString(_ s: inout [Character]) {
    for i in 0..<s.endIndex / 2 {
        s.swapAt(i, (s.endIndex - 1) - i)
    }
}

// MARK: - Reverse Integer
/*
 Given a signed 32-bit integer x, return x with its digits reversed. If reversing x causes the value to go outside the signed 32-bit integer range [-231, 231 - 1], then return 0.
 */
func reverse(_ x: Int) -> Int {
    let sign = x < 0 ? -1 : 1
    func reverseString(_ s: inout [Character]) {
        for i in 0..<s.endIndex / 2 {
            s.swapAt(i, (s.endIndex - 1) - i)
        }
    }
    
    var digits: [Character] = Array(String(abs(x)))
    reverseString(&digits)
    let reversedDigits = digits.reduce(into: "") { $0 += String($1) }
    if let num = Int(reversedDigits), num <= Int32.max {
        return num * sign
    }
    return 0
}

// MARK: - First Unique Character in a String
/*
 Given a string s, find the first non-repeating character in it and return its index. If it does not exist, return -1.
 */
func firstUniqChar(_ s: String) -> Int {
    var charDict = [Character: Int]()
    s.enumerated().forEach { charDict[$1, default: 0] += 1 }
    for (index, char) in s.enumerated() {
        if charDict[char] == 1 {
            return index
        }
    }
    return -1
}

// MARK: - Valid Anagram
/*
 Given two strings s and t, return true if t is an anagram of s, and false otherwise.
 */
func isAnagram(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }
    
    var anagramDict = [Character: Int]()
    t.enumerated().forEach { anagramDict[$1, default: 0] += 1 } 
    s.enumerated().forEach {
        if let count = anagramDict[$1] {
            anagramDict[$1] = (count - 1 != 0) ? (count - 1) : nil
        }
    }
    
    return anagramDict.isEmpty
}

// MARK: Valid Palindrome
/*
 A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters include letters and numbers.

 Given a string s, return true if it is a palindrome, or false otherwise.
 */
func isPalindrome(_ s: String) -> Bool {
    let cleanS = s.components(separatedBy: CharacterSet.alphanumerics.inverted).joined().lowercased()
    if cleanS.isEmpty { return true }
    
    let letters = Array(cleanS)
    var i = 0, j = letters.endIndex - 1
    
    while i != j && i < j {
        if letters[i] != letters[j] {
            return false
        }
        i += 1
        j -= 1
    }
    return true
}

// MARK: - String to Integer (atoi)
/*
 Implement the myAtoi(string s) function, which converts a string to a 32-bit signed integer (similar to C/C++'s atoi function).

 The algorithm for myAtoi(string s) is as follows:

 Read in and ignore any leading whitespace.
 
 Check if the next character (if not already at the end of the string) is '-' or '+'. Read this character in if it is either. This determines if the final result is negative or positive respectively. Assume the result is positive if neither is present.
 
 Read in next the characters until the next non-digit character or the end of the input is reached. The rest of the string is ignored.
 
 Convert these digits into an integer (i.e. "123" -> 123, "0032" -> 32). If no digits were read, then the integer is 0. Change the sign as necessary (from step 2).
 
 If the integer is out of the 32-bit signed integer range [-231, 231 - 1], then clamp the integer so that it remains in the range. Specifically, integers less than -231 should be clamped to -231, and integers greater than 231 - 1 should be clamped to 231 - 1.
 Return the integer as the final result.
 
 Note:

 Only the space character ' ' is considered a whitespace character.
 Do not ignore any characters other than the leading whitespace or the rest of the string after the digits.
 */
func myAtoi(_ s: String) -> Int {
    // 1
    var noWhitespaceS = s.trimmingCharacters(in: .whitespaces)
    // 2
    var sign = 1
    if let symbol = noWhitespaceS.first, symbol == "-" || symbol == "+" {
        sign = symbol == "-" ? -1 : 1
        noWhitespaceS.removeFirst()
    }
    // 3
    var nums = ""
    for (_, char) in noWhitespaceS.enumerated() {
        if let num = Int(String(char)) {
            nums += "\(num)"
        } else {
            break
        }
    }
    // 4
    let minimum = Int(pow(-2.0, 31.0))
    let maximum = Int(pow(2.0, 31.0)) - 1
    if let validNumber = Int(nums) {
        let number = validNumber * sign
        if number < minimum {
            return minimum
        } else if number > maximum {
            return maximum
        } else {
            return number
        }
    }
    if nums.count > Array(String(minimum)).count {
        return sign == -1 ? minimum : maximum
    }
    return 0
}

// MARK: - Implement strStr()
/*
 Implement strStr().

 Return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.

 Clarification:

 What should we return when needle is an empty string? This is a great question to ask during an interview.

 For the purpose of this problem, we will return 0 when needle is an empty string. This is consistent to C's strstr() and Java's indexOf().
 */
//func strStr(_ haystack: String, _ needle: String) -> Int {
//    if needle.isEmpty { return 0 }
//    let haystackList = Array(haystack)
//    let needleList = Array(needle)
//    if needleList.count > haystackList.count { return -1 }
//    var index = -1
//    var j = 0
//    
//    haystackLoop: for (i, char) in haystackList.enumerated() {
//        if char == Array(needle)[j] {
//            var t = i
//            while t < haystackList.endIndex 
//                    && j < needleList.endIndex 
//                    && haystackList[t] == needleList[j] {
//                t += 1
//                j += 1
//                if j >= needleList.endIndex {
//                    index = i
//                    break haystackLoop
//                }
//            }
//            j = 0
//        }
//    }
//    return index
//}

func strStr(_ haystack: String, _ needle: String) -> Int {
    if needle.isEmpty { return 0 }
    if let range = haystack.range(of: needle) {
        return range.lowerBound.utf16Offset(in: needle)
    }
    return -1
}

