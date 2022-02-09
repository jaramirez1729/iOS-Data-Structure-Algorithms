//
//  GrokkingTheCodingInterviewTests.swift
//  GrokkingTheCodingInterviewTests
//
//  Created by J.A. Ramirez on 2/5/22.
//

import XCTest
@testable import GrokkingTheCodingInterview

// MARK: - Maximum Sum Subarray of Size K (Easy)
class FindMaxSumSubArrayTests: XCTestCase {
    func test1() {
        let list = [2, 1, 5, 1, 3, 2]
        let k = 3
        XCTAssertEqual(findMaxSumSubArray(in: list, size: k), 9)
    }
    
    func test2() {
        let list = [2, 3, 4, 1, 5]
        let k = 2
        XCTAssertEqual(findMaxSumSubArray(in: list, size: k), 7)
    }
}

// MARK: - Smallest Subarray with a Greater Sum (Easy) 
class FindMinSumSubArrayTests: XCTestCase {
    func test1() {
        let list = [2, 1, 5, 2, 3, 2] 
        let s = 7
        XCTAssertEqual(findMinSumSubArray(in: list, target: s), 2)
    }
    
    func test2() {
        let list = [2, 1, 5, 2, 8]
        let s = 7
        XCTAssertEqual(findMinSumSubArray(in: list, target: s), 1)
    }
    
    func test3() {
        let list = [3, 4, 1, 1, 6]
        let s = 8
        XCTAssertEqual(findMinSumSubArray(in: list, target: s), 3)
    }
}

// MARK: - Longest Substring with K Distinct Characters (Medium)
class FindLongestSubstringWithDistinctTests: XCTestCase {
    func test1() {
        let str = "araaci"
        let k = 2
        XCTAssertEqual(FindLongestSubstring(in: str, withDistinct: k), 4)
    }
    
    func test2() {
        let str = "araaci"
        let k = 1
        XCTAssertEqual(FindLongestSubstring(in: str, withDistinct: k), 2)
    }
    
    func test3() {
        let str = "cbbebi"
        let k = 3
        XCTAssertEqual(FindLongestSubstring(in: str, withDistinct: k), 5)
    }
}

// MARK: - Fruits into Baskets (Medium)
class FruitsIntoBasketsTests: XCTestCase {
    func test1() {
        let fruits = ["A", "B", "C", "A", "C"]
        XCTAssertEqual(fruitsIntoBaskets(fruits), 3)
    }
    
    func test2() {
        let fruits = ["A", "B", "C", "B", "B", "C"]
        XCTAssertEqual(fruitsIntoBaskets(fruits), 5)
    }
}

// MARK: - Longest Substring with Distinct Characters (Hard)
class FindLongestDistinctSubstringTests: XCTestCase {
    func test1() {
        let input = "aabccbb"
        XCTAssertEqual(FindLongestDistinctSubstring(in: input), 3)
    }
    
    func test2() {
        let input = "abbbb"
        XCTAssertEqual(FindLongestDistinctSubstring(in: input), 2)
    }
    
    func test3() {
        let input = "abccde"
        XCTAssertEqual(FindLongestDistinctSubstring(in: input), 3)
    }
    
    func test4() {
        let input = "abcdcfeghijk"
        XCTAssertEqual(FindLongestDistinctSubstring(in: input), 9)
    }
}

// MARK: - Longest Substring with Same Letters after Replacement (Hard)
class FindLongestReplacementSubstringTests: XCTestCase {
    func test1() {
        let input = "aabccbb"
        let k = 2
        XCTAssertEqual(findLongestReplacementSubstring(in: input, replacements: k), 5)
    }
    
    func test2() {
        let input = "abbcb"
        let k = 1
        XCTAssertEqual(findLongestReplacementSubstring(in: input, replacements: k), 4)
    }
    
    func test3() {
        let input = "abccde"
        let k = 1
        XCTAssertEqual(findLongestReplacementSubstring(in: input, replacements: k), 3)
    }
}

// MARK: - Longest Subarray with Ones after Replacement (Hard)
class FindLongestReplacementSubarrayTests: XCTestCase {
    func test1() {
        let nums = [0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1]
        let k = 2
        XCTAssertEqual(findLongestReplacementSubarray(in: nums, replacements: k), 6)
    }
    
    func test2() {
        let nums = [0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1]
        let k = 3
        XCTAssertEqual(findLongestReplacementSubarray(in: nums, replacements: k), 9)
    }
}
