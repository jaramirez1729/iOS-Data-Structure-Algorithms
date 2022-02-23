//
//  6-CyclicSortPatternTests.swift
//  GrokkingTheCodingInterviewTests
//
//  Created by J.A. Ramirez on 2/22/22.
//

import XCTest
@testable import GrokkingTheCodingInterview

// MARK: - Cyclic Sort (Easy)
class CyclicSortTests: XCTestCase {
    func test1() {
        var input = [3, 1, 5, 4, 2]
        cyclicSort(&input)
        XCTAssertEqual(input, [1, 2, 3, 4, 5])
    }
    
    func test2() {
        var input = [2, 6, 4, 3, 1, 5]
        cyclicSort(&input)
        XCTAssertEqual(input, [1, 2, 3, 4, 5, 6])
    }
    
    func test3() {
        var input = [1, 5, 6, 4, 3, 2]
        cyclicSort(&input)
        XCTAssertEqual(input, [1, 2, 3, 4, 5, 6])
    }
}

// MARK: - Find the Missing Number (Easy)
class FindMissingNumberTests: XCTestCase {
    func test1() {
        let input = [4, 0 , 3, 1]
        XCTAssertEqual(findMissingNumber(in: input), 2)
    }
    
    func test2() {
        let input = [8, 3, 5, 2, 4, 6, 0, 1]
        XCTAssertEqual(findMissingNumber(in: input), 7)
    }
    
    func test3() {
        let input = [3, 4, 6, 7, 1, 2, 0]
        XCTAssertEqual(findMissingNumber(in: input), 5)
    }
    
    func test4() {
        let input = [1, 8, 3, 2, 7, 0, 6, 5]
        XCTAssertEqual(findMissingNumber(in: input), 4)
    }
}
