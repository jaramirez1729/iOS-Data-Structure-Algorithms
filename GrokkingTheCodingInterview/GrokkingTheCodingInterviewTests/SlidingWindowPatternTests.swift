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
