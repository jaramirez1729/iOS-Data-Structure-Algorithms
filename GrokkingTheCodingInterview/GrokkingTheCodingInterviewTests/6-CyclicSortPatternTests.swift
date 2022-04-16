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

// MARK: - Find all Missing Numbers (Easy)
class FindAllMissingNumberTests: XCTestCase {
    func test1() {
        let input = [2, 3, 1, 8, 2, 3, 5, 1]
        let result = findAllMissingNumber(in: input)
        XCTAssertEqual(result, [4, 6, 7])
    }
    
    func test2() {
        let input = [2, 4, 1, 2]
        let result = findAllMissingNumber(in: input)
        XCTAssertEqual(result, [3])
    }
}

// MARK: - Find the Duplicate Number (Easy)
class FindDuplicateNumberTests: XCTestCase {
    func test1() {
        let input = [1, 4, 4, 3, 2]
        let result = findDuplicateNumber(in: input)
        XCTAssertEqual(result, 4)
    }
    
    func test2() {
        let input = [2, 1, 3, 3, 5, 4]
        let result = findDuplicateNumber(in: input)
        XCTAssertEqual(result, 3)
    }
    
    func test3() {
        let input = [2, 4, 1, 4, 4]
        let result = findDuplicateNumber(in: input)
        XCTAssertEqual(result, 4)
    }
    
    func test1a() {
        let input = [1, 4, 4, 3, 2]
        let result = findDuplicateNumberCycle(in: input)
        XCTAssertEqual(result, 4)
    }
    
    func test2a() {
        let input = [2, 1, 3, 3, 5, 4]
        let result = findDuplicateNumberCycle(in: input)
        XCTAssertEqual(result, 3)
    }
    
    func test3a() {
        let input = [2, 4, 1, 4, 4]
        let result = findDuplicateNumberCycle(in: input)
        XCTAssertEqual(result, 4)
    }
    
    func test4a() {
        let input = [1, 4, 3, 2, 6, 5, 7, 11, 10, 8, 9, 7]
        let result = findDuplicateNumberCycle(in: input)
        XCTAssertEqual(result, 7)
    }
}

// MARK: - Find All Duplicate Numbers (Easy)
class findAllDuplicateNumbersTests: XCTestCase {
    func test1() {
        let input = [3, 4, 4, 5, 5]
        let output = [4, 5]
        XCTAssertEqual(findAllDuplicateNumbers(in: input), output)
    }
    
    func test2() {
        let input = [5, 4, 7, 2, 3, 5, 3]
        let output = [3, 5]
        XCTAssertEqual(findAllDuplicateNumbers(in: input), output)
    }
}
