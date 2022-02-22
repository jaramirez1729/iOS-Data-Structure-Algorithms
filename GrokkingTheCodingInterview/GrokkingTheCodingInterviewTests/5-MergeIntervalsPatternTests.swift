//
//  5-MergeIntervalsPatternTests.swift
//  GrokkingTheCodingInterviewTests
//
//  Created by J.A. Ramirez on 2/21/22.
//

import XCTest
@testable import GrokkingTheCodingInterview

// MARK: - Merge Intervals (Medium)
class MergeIntervalsTests: XCTestCase {
    func test1() {
        let input = [Interval(1, 4), Interval(2, 5), Interval(7, 9)]
        let result = mergeIntervals(input)
        XCTAssertEqual(result.description, "[[1, 5], [7, 9]]")
    }
    
    func test2() {
        let input = [Interval(6, 7), Interval(2, 4), Interval(5, 9)]
        let result = mergeIntervals(input)
        XCTAssertEqual(result.description, "[[2, 4], [5, 9]]")
    }
    
    func test3() {
        let input = [Interval(1, 4), Interval(2, 6), Interval(3, 5)]
        let result = mergeIntervals(input)
        XCTAssertEqual(result.description, "[[1, 6]]")
    }
    
    func test4() {
        let input = [Interval(1, 4), Interval(5, 6)]
        let result = mergeIntervals(input)
        XCTAssertEqual(result.description, "[[1, 4], [5, 6]]")
    }
    
    func test5() {
        let input = [Interval(1, 4)]
        let result = mergeIntervals(input)
        XCTAssertEqual(result.description, "[]")
    }
}

// MARK: - Merge Intervals (Medium)
class InstertIntervalTests: XCTestCase {
    func test1() {
        
    }
}
