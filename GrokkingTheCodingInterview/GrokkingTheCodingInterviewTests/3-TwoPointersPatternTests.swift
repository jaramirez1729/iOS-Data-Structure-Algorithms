//
//  3-TwoPointersPatternTests.swift
//  GrokkingTheCodingInterviewTests
//
//  Created by J.A. Ramirez on 2/14/22.
//

import XCTest
@testable import GrokkingTheCodingInterview

// MARK: - Pair with Target Sum (Easy)
class PairWithTargetSumTests: XCTestCase {
    func test1() {
        let list = [1, 2, 3, 4, 6]
        let sum = 6
        let result = [1, 3]
        XCTAssertEqual(pairWithTargetSum(sum, in: list), result)
    }
    
    func test2() {
        let list = [2, 5, 9, 11]
        let sum = 11
        let result = [0, 2]
        XCTAssertEqual(pairWithTargetSum(sum, in: list), result)
    }
    
    func test3() {
        let list = [2, 5, 9, 11]
        let sum = 55
        let result = [-1, -1]
        XCTAssertEqual(pairWithTargetSum(sum, in: list), result)
    }
    
    func test4() {
        let list = [2]
        let sum = 2
        let result = [-1, -1]
        XCTAssertEqual(pairWithTargetSum(sum, in: list), result)
    }
    
    func test5() {
        let list = [Int]()
        let sum = 1
        let result = [-1, -1]
        XCTAssertEqual(pairWithTargetSum(sum, in: list), result)
    }
}

// MARK: - Remove Duplicates (Easy)
class RemoveDuplicatesTests: XCTestCase {
    func test1() {
        let list = [2, 3, 3, 3, 6, 9, 9]
        let result = 4
        XCTAssertEqual(removeDuplicates(in: list), result)
    }
    
    func test2() {
        let list = [2, 2, 2, 11]
        let result = 2
        XCTAssertEqual(removeDuplicates(in: list), result)
    }
    
    func test3() {
        let list = [11]
        let result = 1
        XCTAssertEqual(removeDuplicates(in: list), result)
    }
    
    func test4() {
        let list = [Int]()
        let result = 0
        XCTAssertEqual(removeDuplicates(in: list), result)
    }
    
    func testA() {
        let list = [3, 2, 3, 6, 3, 10, 9, 3]
        let key = 3
        XCTAssertEqual(removeDuplicates(in: list, of: key), 4)
    }
    
    func testB() {
        let list = [2, 11, 2, 2, 1]
        let key = 2
        XCTAssertEqual(removeDuplicates(in: list, of: key), 2)
    }
}

// MARK: - Squaring a Sorted Array (Easy)
class MakeSortedSquaresTests: XCTestCase {
    func test1() {
        let list = [-2, -1, 0, 2, 3]
        let result = [0, 1, 4, 4, 9]
        XCTAssertEqual(makeSortedSquares(from: list), result)
    }
    
    func test2() {
        let list = [-3, -1, 0, 1, 2]
        let result = [0, 1, 1, 4, 9]
        XCTAssertEqual(makeSortedSquares(from: list), result)
    }
    
    func test3() {
        let list = [Int]()
        let result = [Int]()
        XCTAssertEqual(makeSortedSquares(from: list), result)
    }
    
    func test4() {
        let list = [-5, 5]
        let result = [25, 25]
        XCTAssertEqual(makeSortedSquares(from: list), result)
    }
    
    func test5() {
        let list = [10]
        let result = [100]
        XCTAssertEqual(makeSortedSquares(from: list), result)
    }
}
