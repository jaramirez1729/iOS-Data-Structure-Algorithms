//
//  DesignPatternsTests.swift
//  DesignPatternsTests
//
//  Created by J.A. Ramirez on 2/26/22.
//

import XCTest
@testable import DesignPatterns

// MARK: - Contains Duplicates II (Easy)
class ContainsNearbyDuplicateTests: XCTestCase {
    func test1() {
        let nums = [1, 2, 3, 1]
        let k = 3
        XCTAssertTrue(containsNearbyDuplicate(nums, k))
    }
    
    func test2() {
        let nums = [1, 0, 1, 1]
        let k = 1
        XCTAssertTrue(containsNearbyDuplicate(nums, k))
    }
    
    func test3() {
        let nums = [1, 2, 3, 1, 2, 3]
        let k = 2
        XCTAssertFalse(containsNearbyDuplicate(nums, k))
    }
    
    func test4() {
        let nums = [1]
        let k = 5
        XCTAssertFalse(containsNearbyDuplicate(nums, k))
    }
}

// MARK: - Maximum Average Subarray I (Easy)
class FindMaxAverageTests: XCTestCase {
    func test1() {
        let nums = [1, 12, -5, -6, 50, 3]
        let k = 4
        XCTAssertEqual(findMaxAverage(nums, k), 12.75)
    }
    
    func test2() {
        let nums = [5]
        let k = 1
        XCTAssertEqual(findMaxAverage(nums, k), 5.0)
    }
}

// MARK: - Diet Plan Performance (Easy)
class DietPlanPerformanceTests: XCTestCase {
    func test1() {
        let calories = [1, 2, 3, 4, 5]
        let k = 1
        let lower = 3
        let upper = 3
        XCTAssertEqual(dietPlanPerformance(calories, k, lower, upper), 0)
    }
    
    func test2() {
        let calories = [3, 2]
        let k = 2
        let lower = 0
        let upper = 1
        XCTAssertEqual(dietPlanPerformance(calories, k, lower, upper), 1)
    }
    
    func test3() {
        let calories = [6, 5, 0, 0]
        let k = 2
        let lower = 1
        let upper = 5
        XCTAssertEqual(dietPlanPerformance(calories, k, lower, upper), 0)
    }
    
    func test4() {
        let calories = [6, 13, 8, 7, 10, 1, 12, 11]
        let k = 6
        let lower = 5
        let upper = 37
        XCTAssertEqual(dietPlanPerformance(calories, k, lower, upper), 3)
    }
}

// MARK: - Longest Nice Substring (Easy)
class LongestNiceSubstringTests: XCTestCase {
    func test1() {
        let s = "YazaAayx"
        XCTAssertEqual(longestNiceSubstring(s), "aAa")
    }
    
    func test2() {
        let s = "Bb"
        XCTAssertEqual(longestNiceSubstring(s), "Bb")
    }
    
    func test3() {
        let s = "c"
        XCTAssertEqual(longestNiceSubstring(s), "")
    }
    
    func test4() {
        let s = "aAaYazy"
        XCTAssertEqual(longestNiceSubstring(s), "aAa")
    }
}

// MARK: - Substrings of Size Three with Distinct Characters (Easy)
class CountGoodSubstringsTests: XCTestCase {
    func test1() {
        let s = "xyzzaz"
        XCTAssertEqual(countGoodSubstrings(s), 1)
    }
    
    func test2() {
        let s = "aababcabc"
        XCTAssertEqual(countGoodSubstrings(s), 4)
    }
    
    func test3() {
        let s = "aa"
        XCTAssertEqual(countGoodSubstrings(s), 0)
    }
    
    func test4() {
        let s = "ccc"
        XCTAssertEqual(countGoodSubstrings(s), 0)
    }
}

// MARK: - Minimum Difference Between Highest and Lowest of K Scores (Easy)
class countGoodSubstringsTests: XCTestCase {
    func test1() {
        let nums = [9, 4, 1, 7]
        let k = 2
        XCTAssertEqual(minimumDifference(nums, k), 2)
    }
    
    func test2() {
        let nums = [90]
        let k = 1
        XCTAssertEqual(minimumDifference(nums, k), 0)
    }
    
    func test3() {
        let nums = [90, 100]
        let k = 2
        XCTAssertEqual(minimumDifference(nums, k), 10)
    }
    
    func test4() {
        let nums = [87063, 61094, 44530, 21297, 95857, 93551, 9918]
        let k = 6
        XCTAssertEqual(minimumDifference(nums, k), 74560)
    }
}
