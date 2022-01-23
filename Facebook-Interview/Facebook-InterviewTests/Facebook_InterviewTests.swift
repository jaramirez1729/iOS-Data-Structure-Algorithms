//
//  Facebook_InterviewTests.swift
//  Facebook-InterviewTests
//
//  Created by J.A. Ramirez on 1/17/22.
//

import XCTest
@testable import Facebook_Interview

// MARK: - Longest Substring Without Repeating Characters
class LeetCodeLengthOfLongestSubstringTests: XCTestCase {
    func test1() {
        let s = "abcabcbb"
        let result = lengthOfLongestSubstring(s)
        XCTAssertEqual(result, 3)
    }
    
    func test2() {
        let s = "bbbbb"
        let result = lengthOfLongestSubstring(s)
        XCTAssertEqual(result, 1)
    }
    
    func test3() {
        let s = "pwwkew"
        let result = lengthOfLongestSubstring(s)
        XCTAssertEqual(result, 3)
    }
    
    func test4() {
        let s = " "
        let result = lengthOfLongestSubstring(s)
        XCTAssertEqual(result, 1)
    }
    
    func test5() {
        let s = "aa"
        let result = lengthOfLongestSubstring(s)
        XCTAssertEqual(result, 1)
    }
}

// MARK: - Roman to Integer
class LeetCodeRomanToInt: XCTestCase {
    func test1() {
        let s = "MCMXCIV"
        let total = romanToInt(s)
        XCTAssertEqual(total, 1994)
    }
    
    func test2() {
        let s = "LVIII"
        let total = romanToInt(s)
        XCTAssertEqual(total, 58)
    }
    
    func test3() {
        let s = "IV"
        let total = romanToInt(s)
        XCTAssertEqual(total, 4)
    }
    
    func test4() {
        let s = "V"
        let total = romanToInt(s)
        XCTAssertEqual(total, 5)
    }
    
    func test5() {
        let s = "III"
        let total = romanToInt(s)
        XCTAssertEqual(total, 3)
    }
    
    func test6() {
        let s = "MMMCMV"
        let total = romanToInt(s)
        XCTAssertEqual(total, 3905)
    }
}

// MARK: - 3Sum
class LeetCodeThreeSumTests: XCTestCase {
    func test1() {
        let nums = [-1,0,1,2,-1,-4]
        let result = threeSum(nums)
        XCTAssertEqual(result.count, 2)
    }
    
    func test2() {
        let nums = [-1,0]
        let result = threeSum(nums)
        XCTAssertEqual(result.count, 0)
    }
    
    func test3() {
        let nums = [0]
        let result = threeSum(nums)
        XCTAssertEqual(result.count, 0)
    }
    
    func test4() {
        let nums = [Int]()
        let result = threeSum(nums)
        XCTAssertEqual(result.count, 0)
    }
    
    func test5() {
        let nums = [0, 0, 0, 0]
        let result = threeSum(nums)
        XCTAssertEqual(result.count, 1)
    }
}
